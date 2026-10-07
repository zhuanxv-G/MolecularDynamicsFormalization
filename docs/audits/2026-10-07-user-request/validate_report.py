from pathlib import Path
import re,json,hashlib
O=Path(__file__).resolve().parent; R=O.parents[2]
report=(O/'AUDIT.zh-CN.md').read_text(encoding='utf-8')
broken=[]
for target in re.findall(r'\]\(<([^>]+)>\)',report):
    path=re.sub(r':\d+$','',target)
    if not Path(path).exists():broken.append(target)
before=json.loads((O/'inputs-before.json').read_text(encoding='utf-8-sig'))
snap=list((O/'snapshot/MolecularDynamics').rglob('*.lean'))
basemap={r['path']:r['sha256'] for r in before}
mismatch=[]
for p in snap:
    rel=p.relative_to(O/'snapshot').as_posix()
    # The initial text snapshot normalized CRLF. Restore exact bytes only when
    # current original bytes still equal the captured build-input hash.
    src=R/rel
    raw=src.read_bytes()
    if hashlib.sha256(raw).hexdigest()==basemap.get(rel):p.write_bytes(raw)
    if hashlib.sha256(p.read_bytes()).hexdigest()!=basemap.get(rel):mismatch.append(rel)
hashes=[{'file':p.relative_to(O/'snapshot').as_posix(),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in snap]
(O/'snapshot-hashes.json').write_text(json.dumps(hashes,indent=2),encoding='utf-8')
raw=(O/'selected-axioms.log').read_text(encoding='utf-8-sig')
selected=re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]",raw)
summary={'broken_links':broken,'frozen_formal_files':len(snap),'snapshot_vs_build_input_mismatch':mismatch,'selected_results':len(selected),'has_all_14_sections':all(f'## {n}.' in report for n in range(1,15)),'table_row_blank_gaps':len(re.findall(r'(?m)^\|[^\n]+\|\n\n\|',report))}
(O/'report-validation.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(summary,ensure_ascii=False))
if broken or mismatch or len(selected)!=21:raise SystemExit(1)
