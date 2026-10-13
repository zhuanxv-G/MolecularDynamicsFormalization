"""Repair the first four bound Chapter 3 FAILs without rewriting historical tasks."""
import copy,re,json
from datetime import datetime
import fitz
from integrate_website_returns import ROOT,sha,read,dump,display
from render_blueprint import entry_hash
from eaudit_review_tasks import declarations,build
BASE=ROOT/'blueprint/ch03';SIDS=['MD-3-ModifiedConstruction','MD-3.1-EnergyFailure','MD-3.1-FormalHamiltonian','MD-3.1-FormalHamiltonianField']
CODES={
SIDS[0]:'''theorem modifiedConstruction :
  MolecularDynamics.Chapter02Review.hamiltonianSymplectic_statement ∧
  MolecularDynamics.Chapter03Review.modifiedConstruction_statement := by
  sorry''',
SIDS[1]:'''theorem oscillatorEnergyFailure : ∀ Ω h : ℝ, 0 < Ω → h ≠ 0 →
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)-oscillatorEnergy Ω z =
    (h^2*Ω^2/2)*(Ω^2*(z.1+h*z.2)^2-z.2^2)) ∧
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)=oscillatorEnergy Ω z ↔
    Ω*(z.1+h*z.2)=z.2 ∨ Ω*(z.1+h*z.2)=-z.2) ∧
  (∃ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z) ≠ oscillatorEnergy Ω z) := by
  sorry''',
SIDS[2]:'''def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)''',
SIDS[3]:'''def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (_hH : ContDiff ℝ ∞ H) (_hHj : ∀ j, ContDiff ℝ ∞ (Hj j))
    (z : SymplecticCoordinates n) (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)'''}
EXTRA={
SIDS[0]:'[EXTRA] EAUDIT01补原首句Hamiltonian流辛性为独立完整结论，与原近恒等辛映射修正Hamiltonian有限匹配合取；两个真实项目命题全部量词展开供审校，未把流辛性作构造前提。',
SIDS[1]:'[EXTRA] EAUDIT01对每个Ω>0和h≠0保存完整ΔH恒等、能量不变的两条例外直线和一般不守恒见证；精确代数为原typical的形式化展开，不回填成教材原句。',
SIDS[2]:'[EXTRA] EAUDIT01显式1≤r，排除r=0遗漏Hr0的错义；仍是真实逐系数形式级数，不声称无限收敛或实际流嵌入。',
SIDS[3]:'[EXTRA] EAUDIT01显式1≤r及H和全部Hj全域C∞，保证真实Fréchet梯度；原平滑逐阶形式展开资格，不预置匹配结论。'}

def prepare():
 receipt=BASE/'mathcopilot_results/EAUDIT01_PREPARATION.json'
 if receipt.exists():
  saved=read(receipt);assert saved['lean_sha256']==sha(ROOT/'Blueprint/Ch03.lean')
  assert saved['source_sha256']==sha(BASE/'ch03_source.json');print('Existing EAUDIT01 preparation reused.');return
 edits=BASE/'validation/EAUDIT01/EDITS.json';lean=ROOT/'Blueprint/Ch03.lean'
 if not edits.exists():
  old=declarations(3);text=lean.read_text(encoding='utf-8-sig')
  for sid in SIDS:
   assert text.count(old[sid]['block'])==1
   text=text.replace(old[sid]['block'],CODES[sid],1)
  lean.write_text(text,encoding='utf-8')
  dump(edits,dict(old_signature_sha256={sid:old[sid]['signature_sha256'] for sid in SIDS},lean_sha256=sha(lean)))
 sources=read(BASE/'ch03_source.json');unchanged=copy.deepcopy(sources);indexed={s['source_id']:s for s in sources}
 web=read(BASE/'website_audit.json');ws={w['source_id']:w for w in web}
 pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'));book=fitz.open(pdf);visual=BASE/'validation/EAUDIT01/source_pages';visual.mkdir(parents=True,exist_ok=True)
 page_rows=[]
 for p in (119,120,122):
  path=visual/f'p{p}.png';fresh=book[p-1].get_pixmap(matrix=fitz.Matrix(1.2,1.2))
  assert fresh.samples==fitz.Pixmap(BASE/f'source_pages/p{p}.png').samples
  fresh.save(path);page_rows.append(dict(pdf_page=p,printed_page=p-22,png=path.relative_to(ROOT).as_posix(),png_sha256=sha(path),verification='VIEW_IMAGE original PDF119/120/122 visually checked; original/cached pixels identical'))
 dump(BASE/'validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json',dict(source_pdf_sha256=sha(pdf),pages=page_rows))
 for sid in SIDS:
  s=indexed[sid];existing=next((r for r in s['repair_log'] if r.get('stage')=='EAUDIT01_LOCAL_PAGE_RECHECK'),None)
  if existing:assert existing['after_sha256']==entry_hash(s);continue
  before=entry_hash(s);changed=[];proposed=ws[sid]['json_review'].get('corrected_json') or {}
  for key in ('statement_latex','proof_latex','proof_note','proof_discussion_latex','context_notation','statement_scope'):
   if key in proposed and proposed[key]!=s.get(key):s[key]=proposed[key];changed.append(key)
  s['extra_assumptions'].append(EXTRA[sid]);s['source_page_verification']='VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json'
  if changed:s['review_status']='CORRECTED'
  if sid==SIDS[1]:s['reusable_proofs']=[]
  s['repair_log'].append(dict(stage='EAUDIT01_LOCAL_PAGE_RECHECK',timestamp=datetime.now().isoformat(),before_sha256=before,after_sha256=entry_hash(s),
    changed_fields=changed,raw_return=ws[sid]['raw_path'],raw_sha256=ws[sid]['raw_sha256'],reason='原页119/120/122视觉核对后合并A的标点/记号修订；按绑定FAIL补齐四条全部结论/阶数/真实导数资格，不采用未批准数学勘误。'))
 assert all(s==old for s,old in zip(sources,unchanged) if s['source_id'] not in SIDS)
 dump(BASE/'ch03_source.json',sources)
 # Keep regeneration faithful to the repaired primary signatures.
 overrides={sid:dict(code=CODES[sid],extra_assumptions=indexed[sid]['extra_assumptions'],
  statement_latex=indexed[sid]['statement_latex'],proof_discussion_latex=indexed[sid].get('proof_discussion_latex'),reusable_proofs=indexed[sid].get('reusable_proofs',[])) for sid in SIDS}
 dump(BASE/'website_signature_overrides.json',overrides)
 generator=ROOT/'scripts/ch03_data.py';text=generator.read_text(encoding='utf-8')
 if '# EAUDIT website signature overrides' not in text:
  text+='''\n# EAUDIT website signature overrides: preserve the current audited objects on regeneration.
import json as _website_json
_website_overrides=BASE/'website_signature_overrides.json'
if _website_overrides.exists():
    for _sid,_values in _website_json.loads(_website_overrides.read_text(encoding='utf-8')).items():
        _record=next(r for r in RECORDS if r['source_id']==_sid)
        _record.update(_values)
        _record['priors']=_values['reusable_proofs']
        if _sid=='MD-3.1-EnergyFailure':
            _record['local_explanation']='每个正Ω/非零步长的完整能量差、两条例外直线及一般不守恒见证；原单一参数见证不再冒充完整原断言。'
'''
  generator.write_text(text,encoding='utf-8')
 tasks=build(3,'EAUDIT01','3–3.1',SIDS)
 for w in web:
  if w['source_id'] in SIDS:
   w['repair']=dict(eaudit='EAUDIT01',status='awaiting_reaudit',signature_changed=True,json_review_locally_verified=True,
     task_index=tasks['task_index'],input_sha256=tasks['input_sha256'])
   w['effective_status']=display(w)
 dump(BASE/'website_audit.json',web)
 dump(receipt,dict(source_ids=SIDS,old_signature_sha256=read(edits)['old_signature_sha256'],
  lean_sha256=sha(lean),source_sha256=sha(BASE/'ch03_source.json'),raw_returns={ws[sid]['raw_path']:ws[sid]['raw_sha256'] for sid in SIDS},
  task_index=tasks['task_index'],compact_bytes=[x['total_bytes'] for x in tasks['subtasks']],website_reaudit='not submitted'))
 print('Ch03 EAUDIT01 prepared',tasks['source_ids'],[s['total_bytes'] for s in tasks['subtasks']])

if __name__=='__main__':prepare()
