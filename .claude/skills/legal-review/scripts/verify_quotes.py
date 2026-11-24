"""Check every quote in the legal docs against its source, word for word.

    python3 -I verify_quotes.py docs/legal.md docs/tax-years/2026.md [--cache DIR]

A quote is a block of `> ` lines; its source is the first link after it,
shared by the quotes of a group, before the next heading.
Statutes (wetten.overheid.nl links) are read from the official XML of the
version in the link (or 1 January of the current year), other pages with
curl, PDFs with pdftotext. Each fragment between `[…]` must appear in the
source; whitespace, quotes and dashes are ignored. Table rows written as
"label: value · label: value" do not match a page's table and are reported
for a manual check. Run with `python3 -I`.
"""
import datetime
import hashlib
import html
import os
import re
import subprocess
import sys
import xml.etree.ElementTree as ET

HERE = os.path.dirname(os.path.abspath(__file__))


def norm(s):
    s = html.unescape(s)
    for a, b in [(' ', ' '), ('’', "'"), ('‘', "'"), ('“', '"'),
                 ('”', '"'), ('«', '"'), ('»', '"'), ('–', '-'), ('—', '-'),
                 ('‑', '-'), ('​', ''), ('\xad', '')]:
        s = s.replace(a, b)
    return re.sub(r'\s+', '', s).lower()


def main():
    args = sys.argv[1:]
    cache = '/tmp/florin-legal-sources'
    if '--cache' in args:
        i = args.index('--cache')
        cache = args[i + 1]
        del args[i:i + 2]
    os.makedirs(cache, exist_ok=True)
    texts = {}

    def statute(url):
        m = re.search(r'(BWBR\d+)(?:/(\d{4}-\d{2}-\d{2}))?', url)
        bwb = m.group(1)
        date = m.group(2) or f'{datetime.date.today().year}-01-01'
        key = (bwb, date)
        if key not in texts:
            out = subprocess.run(
                [sys.executable, '-I', os.path.join(HERE, 'statute.py'), bwb,
                 date, '--cache', cache],
                capture_output=True, text=True, check=True).stdout.strip()
            texts[key] = norm(' '.join(ET.parse(out).getroot().itertext()))
        return texts[key]

    def page(url):
        if url in texts:
            return texts[url]
        path = os.path.join(cache, hashlib.md5(url.encode()).hexdigest()[:12])
        if not os.path.exists(path):
            subprocess.run(['curl', '-sS', '--http1.1', '-L', '-A',
                            'Mozilla/5.0', '-o', path, url], check=True)
        data = open(path, 'rb').read()
        if data[:4] == b'%PDF':
            t = subprocess.run(['pdftotext', '-layout', path, '-'],
                               capture_output=True, text=True).stdout
        else:
            t = data.decode('utf-8', 'replace')
            t = re.sub(r'<(script|style)[^>]*>.*?</\1>', ' ', t, flags=re.S)
            t = re.sub(r'<[^>]+>', ' ', t)
        texts[url] = norm(t)
        return texts[url]

    checked = problems = 0
    for doc in args:
        lines = open(doc, encoding='utf-8').read().split('\n')
        i = 0
        while i < len(lines):
            if not lines[i].startswith('> '):
                i += 1
                continue
            start, quote = i, []
            while i < len(lines) and lines[i].startswith('>'):
                quote.append(lines[i][1:].strip())
                i += 1
            # Quotes from one source share the link that follows the group.
            url = None
            for j in range(i, len(lines)):
                if lines[j].startswith('#'):
                    break
                m = re.search(r'\]\((https?://[^)]+)\)', lines[j])
                if m and not lines[j].startswith('>'):
                    url = m.group(1)
                    break
            if url is None:
                problems += 1
                print(f'{doc}:{start + 1}: no source link after the quote')
                continue
            src = statute(url) if 'wetten.overheid.nl' in url else page(url)
            missing = []
            for frag in re.split(r'\[…\]|\[\.\.\.\]|…', ' '.join(quote)):
                for part in re.split(r'\s[|·]\s', frag):
                    if len(norm(part)) > 3:
                        checked += 1
                        if norm(part) not in src:
                            missing.append(part.strip()[:140])
            if missing:
                problems += 1
                print(f'{doc}:{start + 1}: {url}')
                for m in missing:
                    print(f'    not found: {m}')
    print(f'{checked} fragments checked, {problems} quotes to look at')


if __name__ == '__main__':
    main()
