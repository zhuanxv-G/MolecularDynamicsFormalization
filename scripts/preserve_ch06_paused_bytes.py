"""Seal the verified Ch6 checkpoint bytes; never advance the paused chapter."""
import json,hashlib,subprocess
from pathlib import Path
from local_stage import ROOT,stage,canonical
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
base=ROOT/'blueprint/ch06';report=base/'validation/section634-637-final'
local=json.loads((report/'LOCAL_CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
assert local['machine_check_status']=='passed'
for f in local['inputs']:assert sha(ROOT/f['relative_path'])==f['sha256'],f['relative_path']
for c in local['checks']:assert c['exit_code']==0 and sha(report/c['raw_log'])==c['raw_log_sha256']
sources=json.loads((base/'ch06_source.json').read_text(encoding='utf-8'));assert len(sources)==148
mapping=json.loads((base/'old_mapping.json').read_text(encoding='utf-8'));assert len(mapping['mapped'])==76
assert 'import ch06_section638\n' not in (ROOT/'scripts/ch06_data.py').read_text(encoding='utf-8')
attrs=ROOT/'.gitattributes';text=attrs.read_text(encoding='utf-8')
marker='# Preserve exact Chapter 6 source, audit, packet and compiler evidence bytes.'
if marker not in text:
    attrs.write_text(text+'\n'+marker+'\nblueprint/ch06/** -text whitespace=cr-at-eol,-trailing-space\nBlueprint/Ch06.lean -text whitespace=cr-at-eol\ndocs/review/CH06_BLUEPRINT.zh-CN.md -text whitespace=cr-at-eol,-trailing-space\n',encoding='utf-8')
paths=['.gitattributes','Blueprint/Ch06.lean','docs/review/CH06_BLUEPRINT.zh-CN.md',
       'scripts/ch06_short_candidates.py','scripts/local_checkpoint.py','scripts/local_short_search.py',
       'scripts/local_advance_ch06.py','scripts/local_section_check.py','scripts/local_stage.py','scripts/preserve_ch06_paused_bytes.py']
paths += [p.relative_to(ROOT).as_posix() for p in base.rglob('*') if p.is_file()
          and not ('-commit' in p.name and p.suffix=='.log') and not p.name.startswith('INACTIVE_DRAFT_PLAN_')]
receipt=base/'validation/PAUSED_CHECKPOINT_BYTES_20261016.json'
critical=['Blueprint/Ch06.lean','blueprint/ch06/ch06_source.json','blueprint/ch06/CheckAxioms.lean',
          'blueprint/ch06/old_mapping.json','blueprint/ch06/local_audit.json','docs/review/CH06_BLUEPRINT.zh-CN.md']
for batch in json.loads((base/'mathcopilot_tasks/MANIFEST.json').read_text(encoding='utf-8')):
    critical.append('blueprint/ch06/mathcopilot_tasks/'+batch['batch']+'.md')
    for item in batch['subtasks']:
        critical += [p.relative_to(ROOT).as_posix() for p in (ROOT/item['path']).iterdir() if p.is_file()]
critical += ['blueprint/ch06/mathcopilot_tasks/INDEX.md','blueprint/ch06/mathcopilot_tasks/MANIFEST.json']
hashes={p:sha(ROOT/p) for p in critical}
receipt.write_text(json.dumps(dict(status='paused_by_directive21',records=148,old_rows_mapped=76,
    section_report=report.relative_to(ROOT).as_posix(),local_report_sha256=sha(report/'LOCAL_CHECK_REPORT.json'),
    exact_git_bytes=hashes,next_section_activated=False,proofs_rerun=False),ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
paths.append(receipt.relative_to(ROOT).as_posix())
assert not subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).strip(),'Other task staging in progress; leave all files intact.'
stage(paths)
allowed={canonical(p) for p in paths}
staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
assert set(staged)<=allowed,'Concurrent staging; do not commit other task files.'
queries=''.join(':'+p+'\n' for p in critical).encode()
raw=subprocess.check_output(['git','cat-file','--batch'],cwd=ROOT,input=queries);pos=0
for relative in critical:
    end=raw.index(b'\n',pos);header=raw[pos:end].split();size=int(header[-1]);pos=end+1
    assert hashlib.sha256(raw[pos:pos+size]).hexdigest()==hashes[relative],relative
    pos+=size+1
print('Exact index bytes validated:',len(critical),flush=True)
subprocess.run(['git','commit','-m','ch06: preserve exact verified 148-entry checkpoint bytes and pause evidence'],cwd=ROOT,check=True)
subprocess.run(['git','push'],cwd=ROOT,check=True)
print('Paused checkpoint byte preservation committed and pushed.',flush=True)
