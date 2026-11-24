"""Download the official XML of a Dutch statute as in force on a date.

    python3 -I statute.py BWBR0011353 2027-01-01 [--cache DIR]

Prints the path of the XML and every version (expression) that starts in the
same calendar year, so later versions and retroactive corrections (`_1`) are
not missed. wetten.overheid.nl refuses scripted requests; this reads the
official repository instead. Run with `python3 -I`.
"""
import os
import subprocess
import sys
import xml.etree.ElementTree as ET

REPO = 'https://repository.officiele-overheidspublicaties.nl/bwb'


def fetch(url, path):
    subprocess.run(['curl', '-sS', '-f', '-o', path, url], check=True)


def main():
    args = sys.argv[1:]
    cache = '/tmp/florin-legal-sources'
    if '--cache' in args:
        i = args.index('--cache')
        cache = args[i + 1]
        del args[i:i + 2]
    bwb, date = args
    os.makedirs(cache, exist_ok=True)
    manifest = os.path.join(cache, f'manifest_{bwb}.xml')
    fetch(f'{REPO}/{bwb}/manifest.xml', manifest)
    versions = []
    for e in ET.parse(manifest).getroot().iter('expression'):
        label = e.get('label')
        start = e.findtext('metadata/datum_inwerkingtreding') or ''
        end = e.findtext('metadata/einddatum') or '9999-12-31'
        versions.append((start, label, end))
    in_force = [v for v in versions if v[0] <= date <= v[2]]
    if not in_force:
        sys.exit(f'No version of {bwb} in force on {date}')
    # The latest correction of the version in force wins: 2026-01-01_1 over _0.
    start, label, end = sorted(in_force, key=lambda v: (v[0], v[1]))[-1]
    path = os.path.join(cache, f'{bwb}_{label}.xml')
    fetch(f'{REPO}/{bwb}/{label}/xml/{bwb}_{label}.xml', path)
    print(path)
    print(f'in force {start} to {end}', file=sys.stderr)
    same_year = sorted(v for v in versions if v[0][:4] == date[:4])
    for s, l, e in same_year:
        print(f'version {l}: {s} to {e}', file=sys.stderr)


if __name__ == '__main__':
    main()
