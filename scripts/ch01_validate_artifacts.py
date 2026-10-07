from pathlib import Path
import csv,re,json,collections
root=Path(__file__).resolve().parents[1]
review=root/'docs/review'
rows=list(csv.DictReader((review/'CH01_CLAIMS.csv').open(encoding='utf-8-sig')))
full=json.loads((review/'check-full01/CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
assert full['machine_check_status']=='passed' and full['exit_code']==0
assert len(full['checks'])==10 and all(c['exit_code']==0 for c in full['checks'])
mapped=(root.parent/'tmp/ch01-review/chapter01-mapped-audit-final.log').read_text(encoding='utf-8-sig')
assert 'error:' not in mapped and 'warning:' not in mapped
pattern=r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]|'([^']+)' does not depend on any axioms"
records={}
for m in re.finditer(pattern,mapped,re.S):
    name=m[1] or m[3]
    deps=[v.strip() for v in (m[2] or '').split(',') if v.strip()]
    assert set(deps)<= {'propext','Classical.choice','Quot.sound'},(name,deps)
    records[name]=deps
expected=set(n for r in rows for n in r['Lean声明名'].split(';'))
assert expected==set(records),(expected-set(records),set(records)-expected)
assert len({r['id'] for r in rows})==len(rows)==207
assert all(r['状态'] in ['proved','statement_only','weakened','not_formalizable_now'] for r in rows)
assert all(r['备注'] for r in rows)
assert all('待补' not in r['文件:行号'] for r in rows)
for r in rows:
    assert int(r['PDF页'])==int(r['印刷页'])+23
    assert len(r['Lean声明名'].split(';'))==len(r['文件:行号'].split(';'))
    for name,location in zip(r['Lean声明名'].split(';'),r['文件:行号'].split(';')):
        rel,line=location.rsplit(':',1)
        source=(root/rel).read_text(encoding='utf-8-sig').splitlines()
        assert re.search(r'\b'+re.escape(name.split('.')[-1])+r'\b',source[int(line)-1]),(r['id'],name,location)
for filename,count in [('CH01_REVIEW.zh-CN.md',207),('CH01_REVIEW_SHORT.zh-CN.md',15)]:
    text=(review/filename).read_text(encoding='utf-8')
    assert len(re.findall(r'^### CH01-',text,re.M))==count
    assert len(re.findall(r'^```',text,re.M))==2*count
axioms=(review/'check-full01/axiom_dependencies.log').read_text(encoding='utf-8-sig')
declcount=int(re.search(r'Dependency audit passed for (\d+) imported project declarations',axioms)[1])
build=(review/'check-full01/lake_build.log').read_text(encoding='utf-8-sig')
jobs=int(re.search(r'Build completed successfully \((\d+) jobs\)',build)[1])
warnings=sum(len(re.findall(r'(?m)^.*warning:',(review/'check-full01'/name).read_text(encoding='utf-8-sig'))) for name in ['lake_build.log','scratch.log','axiom_dependencies.log'])
assert warnings==0
automation=Path('C:/Users/ustc/.codex/automations/lean/automation.toml').read_text(encoding='utf-8-sig')
assert 'status = "ACTIVE"' in automation and 'rrule = "FREQ=MINUTELY;INTERVAL=15"' in automation
counts=collections.Counter(r['状态'] for r in rows)
validation={
  'date_Asia_Shanghai':'2026-10-08',
  'source':'locally supplied textbook PDF',
  'scope':'printed 1-46 / PDF 24-69, stopping at Exercises on printed46',
  'coverage_rows':len(rows),'status_counts':dict(counts),
  'proved_notation_or_definitions':sum(r['状态']=='proved' and r['类型'] in ['notation','定义'] for r in rows),
  'proved_conclusions':sum(r['状态']=='proved' and r['类型'] in ['定理','未编号结论'] for r in rows),
  'full_check_report':'docs/review/check-full01/CHECK_REPORT.json',
  'full_check_status':'passed','full_checks':10,'jobs':jobs,'formal_inputs':len(full['inputs']),
  'all_project_declaration_dependency_audit':declcount,
  'mapped_declarations_audited':len(records),'mapped_audit_exit_code':0,
  'mapped_axioms':records,
  'new_project_axioms':0,'proof_shortcuts':0,'lean_warnings':warnings,
  'lean_version':full['lean_version'],'mathlib_revision':full['actual_mathlib_revision'],
  'new_source_single_module_checks':'ReviewDefinitions, Statements, ReviewProofs passed before full check',
  'review_full_entries':207,'review_short_entries':15,'pending_locations':0,
  'heartbeat':'lean ACTIVE, unchanged 15-minute frequency; prompt updated to chapter1 and stop after delivery',
  'responsible_semantic_review':'pending: materials delivered for human review',
  'unproved_statements_are_not_theorems':True,
  'chapter06':'paused, candidate parked, accepted baseline 4b886f4',
  'history_hashes_recomputed':False
}
(review/'CH01_VALIDATION.json').write_text(json.dumps(validation,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:validation[k] for k in ['coverage_rows','status_counts','full_check_status','jobs','all_project_declaration_dependency_audit','mapped_declarations_audited','lean_warnings']},ensure_ascii=False))
