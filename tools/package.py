"""Build an allowlisted install ZIP and verify every archived file."""
from pathlib import Path
import hashlib
import re
import zipfile

root = Path(__file__).resolve().parents[1]
toc = root / 'LibraryGuideForever.toc'
files = [toc.name, 'README.md', 'LICENSE', 'CHANGELOG.md', 'Libs/NOTICE.txt', 'Libs/Ace3-LICENSE.txt']
for line in toc.read_text(encoding='utf-8-sig').splitlines():
    if line.strip() and not line.startswith('#'):
        files.append(line.strip().replace('\\', '/'))
assert len(files) == len(set(files))
version = re.search(r'^## Version:\s*(\S+)', toc.read_text(encoding='utf-8-sig'), re.MULTILINE).group(1)
out = root / 'dist' / f'LibraryGuideForever-{version}.zip'
out.parent.mkdir(exist_ok=True)
with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED) as z:
    for name in files:
        path = root / name
        assert path.is_file(), name
        z.write(path, 'LibraryGuideForever/' + name)
with zipfile.ZipFile(out) as z:
    assert z.testzip() is None
    assert len(z.namelist()) == len(files)
    for name in files:
        assert z.read('LibraryGuideForever/' + name) == (root / name).read_bytes()
print(f'{out}\n{len(files)} verified files\nSHA256 {hashlib.sha256(out.read_bytes()).hexdigest()}')
