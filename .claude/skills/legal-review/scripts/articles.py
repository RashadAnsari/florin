"""Print articles of a statute XML, lid by lid.

    python3 -I articles.py FILE.xml 3.76 3.77
    python3 -I articles.py FILE.xml --refers 25a

With --refers, prints every article that mentions the given article, where
exceptions to it are often written. Run with `python3 -I`.
"""
import re
import sys
import xml.etree.ElementTree as ET


def text(e):
    return re.sub(r'\s+', ' ', ''.join(e.itertext())).strip()


def main():
    path, *nums = sys.argv[1:]
    refers = None
    if nums and nums[0] == '--refers':
        refers = nums[1]
    root = ET.parse(path).getroot()
    for a in root.iter('artikel'):
        nr = (a.findtext('kop/nr') or '').strip()
        if refers:
            t = text(a)
            if nr != refers and re.search(r'artikel %s\b' % re.escape(refers), t):
                i = t.find(refers)
                print(f'== Artikel {nr}: ...{t[max(0, i - 300):i + 400]}...\n')
            continue
        if nr in nums:
            print(f'== Artikel {nr}')
            for lid in a.findall('lid') or [a]:
                print('  ' + text(lid))


if __name__ == '__main__':
    main()
