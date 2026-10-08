"""Fixed-source validation of delivery artifacts, mapped dependencies and freezes."""
from pathlib import Path
import csv,json,re,collections,sys,subprocess,hashlib
root=Path(__file__).resolve().parents[1];ch=int(sys.argv[1]);tag=f'CH{ch:02}'
review=root/'docs/review';folder=review/(sys.argv[2] if len(sys.argv)>2 else f'check-full{ch:02}')
report=json.loads((folder/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
assert report['machine_check_status']=='passed' and report['exit_code']==0
assert len(report['checks'])==10 and all(x['exit_code']==0 for x in report['checks'])
rows=list(csv.DictReader((review/f'{tag}_CLAIMS.csv').open(encoding='utf-8-sig')))
names=set(n for r in rows for n in r['Lean声明名'].split(';'))
log=(review/f'{tag}_AXIOMS.log').read_text(encoding='utf-8-sig')
records={m[1]:[] if m[2] is None else [s.strip() for s in m[2].split(',')]
 for m in re.finditer(r"'([^']+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)",log,re.S)}
assert names<=records.keys(),names-records.keys()
assert all(set(a)<={'propext','Classical.choice','Quot.sound'} for a in records.values())
assert not re.search(r'(?m)^.*(?:error:|warning:)',log)
for r in rows:
    assert r['状态'] in ['defined','proved','statement_only','weakened','not_formalizable_now']
    assert r['Lean声明名'] and r['备注']
    for name,loc in zip(r['Lean声明名'].split(';'),r['文件:行号'].split(';'),strict=True):
        p,l=loc.rsplit(':',1); lines=(root/p).read_text(encoding='utf-8-sig').splitlines()
        assert 1<=int(l)<=len(lines)
        assert name.split('.')[-1] in lines[int(l)-1],(r['id'],loc)
    if r['状态']=='defined':assert r['类型'] in ['notation','定义']
    if r['状态'] in ['statement_only','not_formalizable_now']:
        assert '_statement' in r['Lean声明名'] and '/Statements.lean:' in r['文件:行号'],r['id']
full=(review/f'{tag}_REVIEW.zh-CN.md').read_text(encoding='utf-8')
short=(review/f'{tag}_REVIEW_SHORT.zh-CN.md').read_text(encoding='utf-8')
assert len(re.findall(r'^### '+tag+'-',full,re.M))==len(rows)
assert 10<=len(re.findall(r'^### '+tag+'-',short,re.M))<=15
assert not re.search(r'```lean\n(?:(?!```)[\s\S])*:= by',full)
warnings=sum(len(re.findall(r'(?m)^.*warning:',(folder/name).read_text(encoding='utf-8-sig')))
 for name in ['lake_build.log','scratch.log','axiom_dependencies.log'])
assert warnings==0,warnings
frozen=['MolecularDynamics/Chapter01','MolecularDynamics/Chapter02','MolecularDynamics/Chapter03','docs/parked/chapter06-20261008']
frozen += [f'docs/review/CH{c:02}_{suffix}' for c in [1,2,3] for suffix in ['CLAIMS.csv','REVIEW.zh-CN.md','REVIEW_SHORT.zh-CN.md','VALIDATION.json']]
freeze=subprocess.check_output(['git','diff','8948420','--',*frozen],cwd=root)
assert not freeze,'Frozen chapters or parked checkpoint modified'
auto=Path('C:/Users/ustc/.codex/automations/lean/automation.toml')
baseline=json.loads((review/'CH456_BASELINE.json').read_text(encoding='utf-8'))
assert hashlib.sha256(auto.read_bytes()).hexdigest()==baseline['heartbeat_sha256'],'Heartbeat configuration changed'
assert 'status = "ACTIVE"' in auto.read_text(encoding='utf-8-sig') and 'FREQ=MINUTELY;INTERVAL=15' in auto.read_text(encoding='utf-8-sig')
if ch==6:
    original_paths=subprocess.check_output(['git','ls-tree','-r','--name-only','8948420','--','MolecularDynamics/Chapter06'],cwd=root,text=True).splitlines()
    assert len(original_paths)==182
    old=subprocess.check_output(['git','diff','8948420','--',*original_paths],cwd=root,text=True)
    assert not old,'Existing Chapter 6 source modified'
    for filename in ['ReviewDefinitions.lean','Statements.lean']:
        source=(root/'MolecularDynamics/Chapter06'/filename).read_text(encoding='utf-8')
        assert not re.search(r'(?m)^(?:theorem|lemma|axiom) |:= by',source),'New Chapter 6 proof introduced'
build=(folder/'lake_build.log').read_text(encoding='utf-8-sig');deps=(folder/'axiom_dependencies.log').read_text(encoding='utf-8-sig')
scan=json.loads((review/f'{tag}_PAGE_SCAN.json').read_text(encoding='utf-8'))
assert len({p['pdf_page'] for p in scan})==len(scan)
assert set(r['id'] for r in rows)==set(i for p in scan for i in p['claim_ids'])
v={'date_Asia_Shanghai':'2026-10-08','source':'user supplied original textbook PDF, fresh per-page extraction; selected formula images inspected',
 'coverage_rows':len(rows),'status_counts':dict(collections.Counter(r['状态'] for r in rows)),
 'proved_conclusions':sum(r['状态']=='proved' for r in rows),'proof_count_basis':'CSV rows; repeated mappings are not independent theorems',
 'full_check_report':str((folder/'CHECK_REPORT.json').relative_to(root)).replace('\\','/'),
 'full_check_status':'passed','full_checks':10,'jobs':int(re.search(r'Build completed successfully \((\d+) jobs\)',build)[1]),
 'mapped_declarations_audited':len(names),'mapped_axioms':records,'new_project_axioms':0,'sorry_admit':0,'lean_warnings':warnings,
 'all_project_declarations_audited':int(re.search(r'Dependency audit passed for (\d+)',deps)[1]),
 'chapters_1_3_and_parked_frozen':'no tracked differences from 8948420','heartbeat':'lean ACTIVE/15 minutes; entire configuration unchanged',
 'page_scan_count':len(scan),'responsible_semantic_review':'pending; statement definitions are not proofs',
 'lean_version':report['lean_version'],'mathlib_revision':report['actual_mathlib_revision']}
(review/f'{tag}_VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v[k] for k in ['coverage_rows','status_counts','jobs','mapped_declarations_audited','all_project_declarations_audited']},ensure_ascii=False))
