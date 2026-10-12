"""Register new Ch01 returns after a section commit, without trusting proposed code.

No input binding was supplied. Preserve reported verdicts and corrections as
proposals; do not apply source/signature changes or manufacture website PASS.
"""
import json,hashlib,re,subprocess
from pathlib import Path
from datetime import datetime
from collections import Counter
from render_blueprint import render
from local_stage import stage
ROOT=Path(__file__).resolve().parents[1]
BASE=ROOT/'blueprint/ch01'
OUT=BASE/'mathcopilot_results/integration20261012'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p,v):
    p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
receipt=OUT/'RECEIPT.json'
files=sorted((BASE/'mathcopilot_results').glob('BATCH*_result.json'))
raw={p.relative_to(ROOT).as_posix():sha(p) for p in files}
if receipt.exists():
    saved=json.loads(receipt.read_text(encoding='utf-8'))
    assert saved['raw_files']==raw,'New or changed returns require another receipt.'
    print('Registered returns reused; no duplicate integration.');raise SystemExit()
assert subprocess.check_output(['git','branch','--show-current'],cwd=ROOT,text=True).strip()=='chapter05-blueprint'
# Current section must already be committed. Its full checks cover the same Lean.
assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()==subprocess.check_output(['git','rev-parse','@{upstream}'],cwd=ROOT,text=True).strip()
sources=json.loads((BASE/'ch01_source.json').read_text(encoding='utf-8-sig'))
indexed={s['source_id']:s for s in sources}
protected_lean={p.relative_to(ROOT).as_posix():sha(p) for p in (ROOT/'MolecularDynamics').rglob('*.lean')}
protected_lean['Blueprint/Ch01.lean']=sha(ROOT/'Blueprint/Ch01.lean')
source_hash=sha(BASE/'ch01_source.json')
web=json.loads((BASE/'website_audit.json').read_text(encoding='utf-8'))
webmap={w['source_id']:w for w in web}
audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))
entries=[]
fields=('statement_latex','proof_latex','proof_note','proof_discussion_latex','context_notation','statement_scope','printed_page','pdf_page')
for path in files:
    result=json.loads(path.read_text(encoding='utf-8-sig'));assert isinstance(result,list)
    for r in result:
        sid=r['source_id'];assert sid in indexed
        assert r['audit']['lean_decl']==indexed[sid]['lean_decl']
        assert r['audit']['verdict'] in {'PASS','FAIL','NEEDS_HUMAN'}
        assert sid not in {e['source_id'] for e in entries} and sid not in webmap
        corrected=r['json_review'].get('corrected_json') or {}
        assert not corrected or corrected['source_id']==sid
        changes={k:dict(current=indexed[sid].get(k),proposed=corrected[k]) for k in fields if k in corrected and corrected[k]!=indexed[sid].get(k)}
        rec=dict(path=path.relative_to(ROOT).as_posix(),sha256=sha(path),received_at=datetime.now().isoformat(),input_version_status='UNVERIFIED: no manifest hash or website job was supplied',current_source_sha256=source_hash,current_lean_sha256=protected_lean['Blueprint/Ch01.lean'])
        explanation='原返回判定'+r['audit']['verdict']+'已原样登记；来源和输入版本绑定尚未核验，网站待审，不冻结。'+r['audit']['explanation']
        if changes:explanation+=' 提议修改字段：'+', '.join(changes)+'；原始JSON与Lean保持冻结，修订提案见本次RECEIPT配套PROPOSALS.json，未经本地原页复核不自动替换。'
        webmap[sid]=dict(source_id=sid,json_review=r['json_review'],returned_audit=r['audit'],audit=dict(lean_decl=r['audit']['lean_decl'],verdict='NEEDS_HUMAN',explanation=explanation,counterexample=r['audit'].get('counterexample'),suggested_fix=r['audit'].get('suggested_fix')),receipt=rec)
        a=audit['items'][sid]
        a.update(website_audit='NEEDS_HUMAN',external_review=dict(reported_verdict=r['audit']['verdict'],binding='UNVERIFIED',receipt=rec,proposed_fields=list(changes)))
        entries.append(dict(source_id=sid,receipt=rec,reported_verdict=r['audit']['verdict'],proposed_source_changes=changes,proposal_applied=False,signature_changed=False))
assert len(entries)==136
dump(OUT/'PROPOSALS.json',entries)
dump(BASE/'website_audit.json',list(webmap.values()))
dump(BASE/'local_audit.json',audit)
progress=BASE/'PROGRESS.md';text=progress.read_text(encoding='utf-8')
lines=text.splitlines()
for i,line in enumerate(lines):
    if line.startswith('| MD-'):
        cells=line.split('|');sid=cells[1].strip()
        if sid in {e['source_id'] for e in entries}:
            # Existing table: source_id / JSON / Blueprint / local / website / proof.
            assert len(cells)==8
            cells[5]=' NEEDS_HUMAN（返回版本绑定未核验） ';lines[i]='|'.join(cells)
counts=dict(Counter(e['reported_verdict'] for e in entries))
proposal_count=sum(bool(e['proposed_source_changes']) for e in entries)
lines=[x.replace('网站返回5；','网站返回141（版本绑定待验）；') for x in lines]
lines += ['','## 2026-10-12 返回件登记','',f'BATCH02–23共136条，原返回PASS {counts["PASS"]} / NEEDS_HUMAN {counts["NEEDS_HUMAN"]} / FAIL {counts["FAIL"]}。缺输入哈希/任务标识，全部待版本绑定复核；不提升网站PASS、不冻结。', '原文JSON与Lean逐字节不变；修订提案未自动应用，见mathcopilot_results/integration20261012/PROPOSALS.json。本地编译与公理证据复用，不恢复第1章长证明。']
progress.write_text('\n'.join(lines)+'\n',encoding='utf-8')
doc=ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md'
doc.write_text(render(BASE/'ch01_source.json',ROOT/'Blueprint/Ch01.lean',BASE/'local_audit.json'),encoding='utf-8')
assert sha(BASE/'ch01_source.json')==source_hash
for relative,digest in protected_lean.items():assert sha(ROOT/relative)==digest
baseline=ROOT/'blueprint/ch05/BASELINE.json';b=json.loads(baseline.read_text(encoding='utf-8'))
delta=[]
for relative,digest in b['protected'].items():
    current=sha(ROOT/relative)
    if current!=digest:
        assert relative.startswith(('blueprint/ch01/','docs/review/CH01_'))
        delta.append(dict(path=relative,before_sha256=digest,after_sha256=current));b['protected'][relative]=current
for p in (BASE/'mathcopilot_results').rglob('*'):
    if p.is_file():b['protected'][p.relative_to(ROOT).as_posix()]=sha(p)
dump(receipt,dict(raw_files=raw,source_ids=[e['source_id'] for e in entries],counts=counts,proposals_unapplied=sum(bool(e['proposed_source_changes']) for e in entries),input_binding='UNVERIFIED',source_and_lean_byte_identity='PASS',changed_files=delta,prior_section_commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()))
for p in OUT.rglob('*'):
    if p.is_file():b['protected'][p.relative_to(ROOT).as_posix()]=sha(p)
b.setdefault('licensed_ch01_return_exceptions',[]).append(dict(receipt=receipt.relative_to(ROOT).as_posix(),reason='用户允许当前节提交后整合新返回件；仅登记未绑定原返回及修订提案；原文JSON/Lean不变',changed_files=delta))
dump(baseline,b)
state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines()
lines.insert(8,'第1章2026-10-12 BATCH02–23新返回136条已登记；44 PASS/66 NEEDS/26 FAIL为原返回，缺版本绑定不提升网站PASS；原文JSON及Lean不改，提案留待原页复核。回第5章§5.2.1。')
state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write(f'\n## 2026-10-12 第1章新返回件例外\nBATCH02–23的136条原返回、哈希及{proposal_count}项修订提案已登记；原文JSON/Lean不变，现有本地证据复用，网站版本绑定未验。\n下一步：回第5章§5.2.1；不提升网站PASS、不冻结、不恢复第1章长证明。\n')
stage(['scripts/register_ch01_batch_returns.py','blueprint/ch01/mathcopilot_results','blueprint/ch01/website_audit.json','blueprint/ch01/local_audit.json','blueprint/ch01/PROGRESS.md','docs/review/CH01_BLUEPRINT.zh-CN.md','blueprint/ch05/BASELINE.json','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md'],allow_ch01_return=True)
subprocess.run(['git','commit','-m','ch01 returns: register 136 unbound reports and preserve correction proposals'],cwd=ROOT,check=True)
subprocess.run(['git','push'],cwd=ROOT,check=True)
print(f'Registered and pushed 136 returns; {proposal_count} source proposals remain unapplied; frozen source/Lean verified.')
