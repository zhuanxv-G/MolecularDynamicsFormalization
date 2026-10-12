"""Preserve all Ch02 returns and source proposals without applying unbound claims."""
import json,hashlib,subprocess
from pathlib import Path
from collections import Counter
from datetime import datetime
from local_stage import stage
ROOT=Path(__file__).resolve().parents[1]
BASE=ROOT/'blueprint/ch02'
OUT=BASE/'mathcopilot_results/integration20261012'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p,v):
    p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
files=sorted((BASE/'mathcopilot_results').glob('BATCH*_result.json'))
raw={p.relative_to(ROOT).as_posix():sha(p) for p in files}
if (OUT/'RECEIPT.json').exists():
    assert json.loads((OUT/'RECEIPT.json').read_text(encoding='utf-8'))['raw_files']==raw
    print('Existing Ch02 receipt reused.');raise SystemExit()
assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True)==subprocess.check_output(['git','rev-parse','@{upstream}'],cwd=ROOT,text=True)
sources=json.loads((BASE/'ch02_source.json').read_text(encoding='utf-8-sig'))
indexed={r['source_id']:r for r in sources}
before={p.relative_to(ROOT).as_posix():sha(p) for p in (ROOT/'MolecularDynamics').rglob('*.lean')}
before.update({p.relative_to(ROOT).as_posix():sha(p) for p in [BASE/'ch02_source.json',ROOT/'Blueprint/Ch02.lean',BASE/'local_audit.json',BASE/'DELIVERY_VALIDATION.json']})
fields=('statement_latex','proof_latex','proof_note','proof_discussion_latex','context_notation','statement_scope','printed_page','pdf_page')
entries=[]
for path in files:
    for r in json.loads(path.read_text(encoding='utf-8-sig')):
        sid=r['source_id'];assert sid in indexed and sid not in {e['source_id'] for e in entries}
        assert r['audit']['lean_decl']==indexed[sid]['lean_decl']
        assert r['audit']['verdict'] in {'PASS','FAIL','NEEDS_HUMAN'}
        corrected=r['json_review'].get('corrected_json') or {}
        assert not corrected or corrected['source_id']==sid
        changes={k:dict(current=indexed[sid].get(k),proposed=corrected[k]) for k in fields if k in corrected and corrected[k]!=indexed[sid].get(k)}
        entries.append(dict(source_id=sid,raw_path=path.relative_to(ROOT).as_posix(),raw_sha256=sha(path),reported_verdict=r['audit']['verdict'],effective_website_status='待网站审计',binding='UNVERIFIED: input manifest SHA256 and website job were not supplied',returned_audit=r['audit'],proposed_source_changes=changes,proposal_applied=False,signature_changed=False))
assert len(files)==32 and len(entries)==len(sources)==160
counts=dict(Counter(e['reported_verdict'] for e in entries))
dump(OUT/'PROPOSALS.json',entries)
dump(OUT/'RECEIPT.json',dict(received_at=datetime.now().isoformat(),raw_files=raw,source_ids=[e['source_id'] for e in entries],counts=counts,input_binding='UNVERIFIED',effective_website_status='待网站审计',proposals_unapplied=sum(bool(e['proposed_source_changes']) for e in entries),unchanged_local_inputs=before,prior_section_commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()))
(BASE/'mathcopilot_results/INDEX.md').write_text('# 第2章返回件登记\n\nBATCH01–32共160条已保留原件和SHA256；原返回PASS 15、NEEDS_HUMAN 130、FAIL 15。\n缺输入MANIFEST哈希及网站任务绑定，全部仍待网站审计；不能把原返回PASS作为核验完成。\n\n每条原判定、源字段修订提案及未应用标志见 integration20261012/PROPOSALS.json；总收据见同目录RECEIPT.json。\n原文JSON、Blueprint及本地审计/交付证据不变，既有编译和公理结果继续复用。后续有版本绑定或原页修订裁定时再整合，不自动改签名。\n',encoding='utf-8')
for relative,digest in before.items():assert sha(ROOT/relative)==digest
baseline=ROOT/'blueprint/ch05/BASELINE.json';b=json.loads(baseline.read_text(encoding='utf-8'))
for p in (BASE/'mathcopilot_results').rglob('*'):
    if p.is_file():b['protected'][p.relative_to(ROOT).as_posix()]=sha(p)
b.setdefault('licensed_return_registrations',[]).append(dict(chapter=2,receipt=(OUT/'RECEIPT.json').relative_to(ROOT).as_posix(),source_and_lean_byte_identity='PASS',existing_delivery_reused=True))
dump(baseline,b)
state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines()
lines.insert(8,'第2章BATCH01–32的160条新返回已登记（15 PASS/130 NEEDS/15 FAIL）；版本绑定未验，修订未应用，原文/Lean及已通过本地交付不变。继续第5章。')
state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-12 第2章新返回件登记\n32件160条原返回和SHA256/修订提案已登记；源JSON、Blueprint及既有本地验收证据逐字节复用，网站版本绑定未验。\n下一步：继续第5章；无网站PASS提升，无签名修改。\n')
stage(['scripts/register_ch02_batch_returns.py','blueprint/ch02/mathcopilot_results','blueprint/ch05/BASELINE.json','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md'])
subprocess.run(['git','commit','-m','ch02 returns: preserve 160 unbound reports and source proposals'],cwd=ROOT,check=True)
subprocess.run(['git','push'],cwd=ROOT,check=True)
print('Ch02 returns registered and pushed; existing local delivery unchanged.')
