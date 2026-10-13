"""Append returned audits after the current section push; preserve local Lean/source."""
import json,hashlib,subprocess
from collections import Counter
from datetime import datetime
from pathlib import Path
from local_stage import stage
ROOT=Path(__file__).resolve().parents[1];BASE=ROOT/'blueprint/ch02'
OUT=BASE/'mathcopilot_results/integration20261013_reaudit'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p,v):
    p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
raw=sorted((BASE/'mathcopilot_results/reaudit').glob('BATCH*_result.json'))
raw_hashes={p.relative_to(ROOT).as_posix():sha(p) for p in raw}
receipt=OUT/'RECEIPT.json'
if receipt.exists():
    assert json.loads(receipt.read_text(encoding='utf-8'))['raw_files']==raw_hashes
    print('Existing reaudit receipt reused.');raise SystemExit()
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
assert head==subprocess.check_output(['git','rev-parse','@{upstream}'],cwd=ROOT,text=True).strip()
baseline=ROOT/'blueprint/ch06/BASELINE.json';b=json.loads(baseline.read_text(encoding='utf-8'))
for path,h in {**b['protected'],**b['unrelated']}.items():assert sha(ROOT/path)==h,path
sources=json.loads((BASE/'ch02_source.json').read_text(encoding='utf-8-sig'));indexed={r['source_id']:r for r in sources}
frozen=[BASE/'ch02_source.json',ROOT/'Blueprint/Ch02.lean',BASE/'local_audit.json',BASE/'DELIVERY_VALIDATION.json']
unchanged={p.relative_to(ROOT).as_posix():sha(p) for p in frozen}
entries=[];bindings=[]
fields=('statement_latex','proof_latex','proof_note','proof_discussion_latex','context_notation','statement_scope','printed_page','pdf_page')
for path in raw:
    data=json.loads(path.read_text(encoding='utf-8-sig'));assert data['chapter']=='ch02'
    batch=BASE/'mathcopilot_tasks'/f"{data['batch']}.md"
    actual={'BATCH.md':sha(batch),'Blueprint/Ch02.lean':sha(ROOT/'Blueprint/Ch02.lean'),'Ch02_deps.txt':None}
    expected=data['input_sha256']
    binding={key:dict(expected=value,actual=actual.get(key),matches=actual.get(key)==value) for key,value in expected.items()}
    assert binding['BATCH.md']['matches'] and binding['Blueprint/Ch02.lean']['matches'],path
    bindings.append(dict(raw_path=path.relative_to(ROOT).as_posix(),inputs=binding,status='PARTIAL: batch and Lean hashes verified; dependency export unavailable'))
    for r in data['items']:
        sid=r['source_id'];assert sid in indexed and sid not in {x['source_id'] for x in entries}
        assert r['audit']['verdict'] in {'PASS','FAIL','NEEDS_HUMAN'}
        proposed=r['json_review'].get('corrected_json') or {};assert not proposed or proposed['source_id']==sid
        changes={key:dict(current=indexed[sid].get(key),proposed=proposed[key]) for key in fields if key in proposed and proposed[key]!=indexed[sid].get(key)}
        entries.append(dict(source_id=sid,raw_path=path.relative_to(ROOT).as_posix(),raw_sha256=sha(path),
            reported_verdict=r['audit']['verdict'],returned_audit=r['audit'],returned_json_review=r['json_review'],
            lean_decl_matches=r['audit']['lean_decl']==indexed[sid]['lean_decl'],input_binding=binding,
            effective_website_status='待网站审计',proposed_source_changes=changes,proposal_applied=False,signature_changed=False))
assert len(raw)==5 and len(entries)==20
counts=dict(Counter(x['reported_verdict'] for x in entries))
dump(OUT/'PROPOSALS.json',entries)
dump(receipt,dict(received_at=datetime.now().isoformat(),raw_files=raw_hashes,source_ids=[x['source_id'] for x in entries],
    counts=counts,bindings=bindings,effective_website_status='待网站审计',proposals_unapplied=sum(bool(x['proposed_source_changes']) for x in entries),
    unchanged_local_inputs=unchanged,prior_section_commit=head,dependency_search='No Ch02_deps.txt found by rg in workspace including ignored paths or Downloads/md_sync; supplied digest alone is not an export.'))
index=BASE/'mathcopilot_results/INDEX.md'
with index.open('a',encoding='utf-8') as f:
    f.write('\n2026-10-13 reaudit BATCH01–05共20条已登记：原返回'+str(counts)+'。\n各BATCH与当前Ch02 Lean输入SHA均匹配；Ch02_deps.txt原附件未找到，依赖版本绑定仍未验。\n完整原判定/修订提案见integration20261013_reaudit；原文、Lean、本地审计及交付不变，网站列仍待网站审计。\n')
for path,h in unchanged.items():assert sha(ROOT/path)==h
for p in [*raw,OUT/'PROPOSALS.json',receipt,index]:b['protected'][p.relative_to(ROOT).as_posix()]=sha(p)
b.setdefault('licensed_return_registrations',[]).append(dict(chapter=2,receipt=receipt.relative_to(ROOT).as_posix(),
    source_and_lean_byte_identity='PASS',existing_delivery_reused=True,site_binding='PARTIAL: dependencies unavailable'))
dump(baseline,b)
for path,h in {**b['protected'],**b['unrelated']}.items():assert sha(ROOT/path)==h,path
state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines()
lines[3]='下一步：继续第6章§6.2；激活scripts/ch06_section621.py首8条，复用§6.1完整check/公理结果。'
lines.insert(8,'第2章reaudit BATCH01–05共20条已登记；BATCH及Lean SHA匹配，依赖附件未找到；修订未应用，网站仍待审。')
state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-13 第2章：新reaudit返回登记\n5件20条原返回/源修订提案已登记；BATCH与Lean SHA匹配，依赖未绑定；所有源JSON/Lean及既有交付逐字节复用。\n下一步：继续第6章§6.2，网站仍待审，不重复完整构建。\n')
stage(['scripts/register_ch02_reaudit_returns.py','blueprint/ch02/mathcopilot_results/reaudit',
    'blueprint/ch02/mathcopilot_results/integration20261013_reaudit','blueprint/ch02/mathcopilot_results/INDEX.md',
    'blueprint/ch06/BASELINE.json','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md'])
subprocess.run(['git','commit','-m','ch02 reaudit: register 20 partially bound reports without source changes'],cwd=ROOT,check=True)
subprocess.run(['git','push'],cwd=ROOT,check=True)
commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';s=table.read_text(encoding='utf-8');row=next(x for x in s.splitlines() if x.startswith('| 6 |'))
parts=row.split('|');parts[-3]=' '+commit[:12]+' ';table.write_text(s.replace(row,'|'.join(parts)),encoding='utf-8')
print('Registered/pushed',len(entries),'reports',counts,'; protected paths',len(b['protected']),'; current source/Lean unchanged.')
