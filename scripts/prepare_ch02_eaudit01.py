"""Repair three bound chapter-start FAILs; do not run the completed Ch02 generator."""
import copy,sys
from datetime import datetime
import fitz
from integrate_website_returns import ROOT,sha,read,dump,display
from render_blueprint import entry_hash
from eaudit_review_tasks import declarations,build
BASE=ROOT/'blueprint/ch02';SIDS=['MD-2-HamiltonianODE','MD-2-Hamiltonian','MD-2-OneStep']
CODES={
SIDS[0]:'''def hamiltonianODE {n : ℕ} (m : Fin n → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin n → ℝ) → ℝ) (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  IsOpen I ∧
  (∀ z, H z = (∑ i, z (Sum.inr i)^2/(2*m i)) + U (fun i ↦ z (Sum.inl i))) ∧
  (∀ t ∈ I, DifferentiableAt ℝ H (γ t) ∧
    DifferentiableAt ℝ U (fun i ↦ γ t (Sum.inl i))) ∧
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t ∧
    (∀ i, HasDerivAt (fun s ↦ γ s (Sum.inl i)) ((m i)⁻¹*γ t (Sum.inr i)) t) ∧
    ∀ i, HasDerivAt (fun s ↦ γ s (Sum.inr i))
      (-fderiv ℝ U (fun j ↦ γ t (Sum.inl j)) (Pi.single i 1)) t''',
SIDS[1]:'''def mechanicalHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (_hm : ∀ i, 0 < m i) (U : PotentialEnergy n) : PhaseSpace n → ℝ :=
  massHamiltonian m U''',
SIDS[2]:'''def numericalTrajectory {n : ℕ} (m : Fin n → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin n → ℝ) → ℝ) (H : SymplecticCoordinates n → ℝ)
    (D : Set (SymplecticCoordinates n)) (G F : ℝ → D → D)
    (γ : ℝ → D → SymplecticCoordinates n) (Z : D → ℝ → ℕ → D) : Prop :=
  IsOpen D ∧ (∀ z ∈ D, DifferentiableAt ℝ U (fun i ↦ z (Sum.inl i))) ∧
  ∀ ζ : D, γ 0 ζ=ζ.1 ∧
    hamiltonianODE m hm U H (fun t ↦ γ t ζ) Set.univ ∧
    (∀ t, (F t ζ).1=γ t ζ) ∧
    ∀ h ν, Z ζ h ν=(G h)^[ν] ζ

def numericalIterate {E : Type*} (G : ℝ → E → E) (h : ℝ) (ζ : E) (ν : ℕ) : E :=
  (G h)^[ν] ζ

def oneStepTargetDifference {n : ℕ} {D : Set (SymplecticCoordinates n)}
    (G F : ℝ → D → D) (h : ℝ) (ζ : D) : ℝ :=
  ‖(G h ζ).1-(F h ζ).1‖'''}
EXTRA={
SIDS[0]:'[EXTRA] EAUDIT01显式固定正对角质量、U/H沿轨道可微、H与真实机械式的全坐标关系；完整q̇=M⁻¹p、ṗ=−∇U及ż=J∇H均保留。I为开时间域，采用环境HasDerivAt；只定义经典轨道关系，不宣称存在或唯一。',
SIDS[1]:'[EXTRA] EAUDIT01显式∀i,0<mᵢ排除奇异M及零除延拓；保持真实PhaseSpace的(q,p)机械Hamiltonian，固定对角质量来自第1章。',
SIDS[2]:'[EXTRA] EAUDIT01在开放正规相空间D排除势能不可微/奇异点；F的已给全时解族与初值/完整机械ODE相联，G作用于同一D，Z关联全部实际n次迭代。oneStepTargetDifference明确目标F_h与G_h的差；原段未规定定量近似质量，未加入虚构误差阶或收敛结论。全时流是此接口的给定模型资格，不是解存在定理。'}

def render_pages():
 pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'));folder=BASE/'validation/EAUDIT01/source_pages';folder.mkdir(parents=True,exist_ok=True)
 rows=[]
 for p in (75,76):
  with fitz.open(pdf) as book:
   path=folder/f'p{p}.png';book[p-1].get_pixmap(matrix=fitz.Matrix(1.2,1.2)).save(path)
  rows.append(dict(pdf_page=p,printed_page=p-22,png=path.relative_to(ROOT).as_posix(),png_sha256=sha(path)))
 dump(BASE/'validation/EAUDIT01/RENDERED_PAGES.json',dict(source_pdf_sha256=sha(pdf),pages=rows,verification='rendered; visual check required before prepare'))

def prepare():
 receipt=BASE/'mathcopilot_results/EAUDIT01_PREPARATION.json'
 if receipt.exists():
  saved=read(receipt);assert saved['lean_sha256']==sha(ROOT/'Blueprint/Ch02.lean') and saved['source_sha256']==sha(BASE/'ch02_source.json');print('Ch02 EAUDIT01 preparation reused.');return
 assert (BASE/'validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json').exists(),'View freshly rendered original pages before source corrections.'
 edits=BASE/'validation/EAUDIT01/EDITS.json';lean=ROOT/'Blueprint/Ch02.lean'
 if not edits.exists():
  ds=declarations(2);text=lean.read_text(encoding='utf-8-sig')
  for sid in SIDS:
   assert text.count(ds[sid]['block'])==1
   text=text.replace(ds[sid]['block'],CODES[sid],1)
   marker='source_id: '+sid
   start=text.index(marker);stop=text.index('-/',start)
   text=text[:stop]+'\n'+EXTRA[sid]+' '+text[stop:]
  lean.write_text(text,encoding='utf-8');dump(edits,dict(old_signature_sha256={sid:ds[sid]['signature_sha256'] for sid in SIDS},lean_sha256=sha(lean)))
 sources=read(BASE/'ch02_source.json');before_all=copy.deepcopy(sources);web=read(BASE/'website_audit.json');ws={w['source_id']:w for w in web}
 for s in sources:
  sid=s['source_id']
  if sid not in SIDS:continue
  assert ws[sid]['binding']['bound'] and ws[sid]['audit_round']=='reaudit' and ws[sid]['returned_audit']['verdict']=='FAIL'
  existing=next((r for r in s['repair_log'] if isinstance(r,dict) and r.get('stage')=='EAUDIT01_LOCAL_PAGE_RECHECK'),None)
  if existing:assert existing['after_sha256']==entry_hash(s);continue
  before=entry_hash(s);proposal=ws[sid]['json_review'].get('corrected_json') or {};changed=[]
  for k in ('statement_latex','proof_latex','proof_note','proof_discussion_latex','context_notation','statement_scope'):
   if k in proposal and proposal[k]!=s.get(k):s[k]=proposal[k];changed.append(k)
  s['extra_assumptions'].append(EXTRA[sid]);s['source_page_verification']='VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json'
  if changed:s['review_status']='CORRECTED'
  raw=ws[sid]['json_review_raw_path']
  s['repair_log'].append(dict(stage='EAUDIT01_LOCAL_PAGE_RECHECK',timestamp=datetime.now().isoformat(),before_sha256=before,after_sha256=entry_hash(s),changed_fields=changed,
    raw_return=raw,raw_sha256=sha(ROOT/raw),reason='重新视觉核对PDF75–76后合并第一轮A排印修订；C以已绑定reaudit为准，补齐经典梯度、可逆质量及完整流/单步域关联；不采用未批准数学更正。'))
 assert all(s==old for s,old in zip(sources,before_all) if s['source_id'] not in SIDS)
 dump(BASE/'ch02_source.json',sources)
 dump(BASE/'website_signature_overrides.json',{sid:dict(code=CODES[sid],extra_assumptions=next(s['extra_assumptions'] for s in sources if s['source_id']==sid)) for sid in SIDS})
 tasks=build(2,'EAUDIT01','2',SIDS)
 for w in web:
  if w['source_id'] in SIDS:
   w['repair']=dict(eaudit='EAUDIT01',status='awaiting_reaudit',signature_changed=True,json_review_locally_verified=True,task_index=tasks['task_index'],input_sha256=tasks['input_sha256']);w['effective_status']=display(w)
 dump(BASE/'website_audit.json',web)
 raw_paths={ws[sid][key] for sid in SIDS for key in ('raw_path','json_review_raw_path')}
 dump(receipt,dict(source_ids=SIDS,old_signature_sha256=read(edits)['old_signature_sha256'],lean_sha256=sha(lean),source_sha256=sha(BASE/'ch02_source.json'),
  raw_returns={p:sha(ROOT/p) for p in raw_paths},task_index=tasks['task_index'],compact_bytes=[x['total_bytes'] for x in tasks['subtasks']],website_reaudit='not submitted'))
 audit=read(BASE/'local_audit.json');ds=declarations(2)
 for sid in SIDS:
  audit['items'][sid].update(verdict='PASS',explanation=EXTRA[sid],checked=False,compiled=False,signature_sha256=ds[sid]['signature_sha256'],block_sha256=ds[sid]['block_sha256'],direct_placeholder=False,proof_status='definition',final_status='incomplete',missing=None,documented_priors=[])
 dump(BASE/'local_audit.json',audit)
 print('Ch02 EAUDIT01 prepared',tasks['source_ids'],[s['total_bytes'] for s in tasks['subtasks']])

if __name__=='__main__':
 if '--render-only' in sys.argv:render_pages()
 else:prepare()
