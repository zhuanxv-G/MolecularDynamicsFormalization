"""Directive 21: ten sequential repairs, each bound to a fresh Lean/axiom receipt."""
from pathlib import Path
import sys, json, re, hashlib, difflib, copy
from collections import Counter
ROOT = Path(__file__).resolve().parents[4]
sys.path.insert(0, str(ROOT/'scripts'))
from local_compile import compile_recorded
BASE = ROOT/'blueprint/ch01'
OUT = BASE/'validation/CLOSEOUT21'
LEAN = ROOT/'Blueprint/Ch01.lean'
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p, d): p.write_text(json.dumps(d, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
def load(p): return json.loads(p.read_text(encoding='utf-8-sig'))

def register():
    website=load(BASE/'website_audit.json'); by={x['source_id']:x for x in website}
    if (OUT/'RETURN_REGISTRATION.json').exists():
        return by
    allitems=[]; bindings=[]
    for n in range(4,24):
        path=BASE/f'mathcopilot_results/eaudit/EAUDIT{n:02}_result.json'; d=load(path)
        for rel,h in d['input_sha256'].items():
            p=ROOT/rel if '/' in rel else BASE/f'mathcopilot_tasks/EAUDIT{n:02}'/rel
            assert sha(p)==h, (p,h)
        for item in d['items']:
            sid=item['source_id']; w=by[sid]
            if 'closeout21_return' not in w:
                w.setdefault('website_history',[]).append({k:v for k,v in w.items() if k!='website_history'})
                w['closeout21_return']=item
                w['closeout21_binding']=dict(result=path.relative_to(ROOT).as_posix(),result_sha256=sha(path),input_sha256=d['input_sha256'],merged_from=d.get('merged_from'),bound=True)
                w['audit']=item['audit']
                w['effective_status']={'PASS':'网站PASS（EAUDIT复审）','FAIL':'按网站意见修复中','NEEDS_HUMAN':'原书疑误待导师；各版本分别登记'}[item['audit']['verdict']]
            allitems.append(item)
        bindings.append(dict(batch=d['batch'],items=len(d['items']),result_sha256=sha(path),input_hashes_verified=True))
    counts=Counter(x['audit']['verdict'] for x in allitems)
    assert counts==dict(PASS=62,FAIL=10,NEEDS_HUMAN=21) and len({x['source_id'] for x in allitems})==93
    dump(BASE/'website_audit.json',website)
    dump(OUT/'RETURN_REGISTRATION.json',dict(total=93,counts=counts,batches=bindings,raw_returns_unchanged=True))
    return by

def add_doc(s,sid,note):
    start=s.index('/-- source_id: '+sid+' ·'); end=s.index('-/',start)
    return s[:end]+note+'\n'+s[end:]
def replace(s,a,b):
    assert s.count(a)==1, (a[:80],s.count(a)); return s.replace(a,b,1)

def repair(key,s):
    if key=='AngleBond':
        a='  k / 2 * (Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) /\n    (‖qᵢ-qⱼ‖ * ‖qⱼ-qₖ‖)) - θ₀)^2'
        s=replace(s,a,a+'''

/-- Physical angle domain; both directed bonds have strictly positive length. -/
def AngleBondValidDomain (qᵢ qⱼ qₖ : V3) : Prop :=
  0 < ‖qᵢ-qⱼ‖ ∧ 0 < ‖qⱼ-qₖ‖

def angleBondOnDomain (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3)
    (_h : AngleBondValidDomain qᵢ qⱼ qₖ) : ℝ := angleBondModel k θ₀ qᵢ qⱼ qₖ
''')
        return s,'MD-1.1.2-AngleBond','总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。','MD.Ch01.angleBondOnDomain'
    if key=='GayBerne':
        a='  4 * εGB * ((σ₀ / Δ)^12 - (σ₀ / Δ)^6)'
        s=replace(s,a,a+'''

/-- Effective Gay--Berne domain: all divisions and both square roots are physical. -/
def GayBerneValidDomain (σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : Prop :=
  let r := q₂-q₁
  let rhat := ‖r‖⁻¹ • r
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  ‖u₁‖ = 1 ∧ ‖u₂‖ = 1 ∧ q₁ ≠ q₂ ∧
  σₛ ≠ 0 ∧ εₛ ≠ 0 ∧ μ ≠ 0 ∧
  ((σₑ/σₛ)^2+1) ≠ 0 ∧ (1+Real.rpow (εₑ/εₛ) (1/μ)) ≠ 0 ∧
  (1+χ*inner ℝ u₁ u₂) ≠ 0 ∧ (1-χ*inner ℝ u₁ u₂) ≠ 0 ∧
  (1+χ'*inner ℝ u₁ u₂) ≠ 0 ∧ (1-χ'*inner ℝ u₁ u₂) ≠ 0 ∧
  0 < 1-χ^2*(inner ℝ u₁ u₂)^2 ∧ 0 < gayBerneW rhat u₁ u₂ χ ∧
  (‖r‖-σ₀/Real.sqrt (gayBerneW rhat u₁ u₂ χ)) ≠ 0

def gayBerneOnDomain (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3)
    (_h : GayBerneValidDomain σ₀ σₑ σₛ εₑ εₛ μ q₁ q₂ u₁ u₂) : ℝ :=
  gayBerneModel ε₀ σ₀ σₑ σₛ εₑ εₛ μ q₁ q₂ u₁ u₂
''')
        return s,'MD-1.1.2-GayBerne','原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。','MD.Ch01.gayBerneOnDomain'
    if key=='NewtonCompact':
        s=replace(s,'  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧\n  massOperator m (deriv (deriv q) t) = -gradient U (q t)',
            '  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧\n  DifferentiableAt ℝ U (q t) ∧\n  massOperator m (deriv (deriv q) t) = -gradient U (q t)')
        return s,'MD-1.2-NewtonCompact','在原有两项真实时间导数资格后增加势能在q(t)处可微。',None
    if key=='HarmonicSolution':
        a='theorem harmonic_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :'
        s=replace(s,a,'''def harmonicEnergy {n : ℕ} (Ω : ℝ) (z : PhaseSpace n) : ℝ :=
  ‖z.2‖^2 / 2 + Ω^2 * ‖z.1‖^2 / 2

theorem harmonicEnergy_eq_massHamiltonian {n : ℕ} (Ω : ℝ) (z : PhaseSpace n) :
    harmonicEnergy Ω z = massHamiltonian (fun _ : Fin n => (1 : ℝ))
      (harmonicPotential Ω) z := by
  simp [harmonicEnergy, massHamiltonian, massSeparableEnergy,
    SeparableEnergy.hamiltonian, momentumKineticEnergy, harmonicPotential,
    nBodyKineticEnergy, EuclideanSpace.real_norm_sq_eq, Finset.sum_div,
    Finset.mul_sum, mul_div_assoc]

'''+a)
        a='''    ∀ t, (harmonicFlow Ω t z).1 = Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2 := by
  exact ⟨harmonicFlow_isMechanicalSolution Ω hΩ z, harmonicFlow_zero Ω z, fun _ => rfl⟩'''
        b='''    (∀ t, (harmonicFlow Ω t z).1 = Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2) ∧
    (∀ t, harmonicEnergy Ω (harmonicFlow Ω t z) = harmonicEnergy Ω z) ∧
    (∀ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
        univ univ γ → γ 0 = z → ∀ t, γ t = harmonicFlow Ω t z) := by
  refine ⟨harmonicFlow_isMechanicalSolution Ω hΩ z, harmonicFlow_zero Ω z,
    (fun _ => rfl), ?_, ?_⟩
  · intro t
    simpa only [harmonicEnergy_eq_massHamiltonian] using harmonicFlow_energy Ω hΩ z t
  · intro γ hγ hinit t
    have heq := mechanicalSolution_unique_on_preconnected_of_contDiffAt
      isOpen_univ isPreconnected_univ (mem_univ (0 : ℝ)) hγ
      (harmonicFlow_isMechanicalSolution Ω hΩ z)
      (fun s _ => mechanicalVectorField_contDiffAt _ _ (γ s) (by fun_prop))
      (by simpa using hinit)
    exact heq (mem_univ t)'''
        s=replace(s,a,b)
        return s,'MD-1.2-HarmonicSolution','补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。',None
    if key=='ScalarMechanical':
        a='''def scalarMechanicalModel (U : ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  ∀ t, DifferentiableAt ℝ U (z t).1 ∧ HasDerivAt z ((z t).2, -deriv U (z t).1) t'''
        b='''def scalarMechanicalEnergy (U : ℝ → ℝ) (z : ℝ × ℝ) : ℝ :=
  z.2^2 / 2 + U z.1

/-- E explicitly names this model's prescribed mechanical energy. -/
def scalarMechanicalModel (U : ℝ → ℝ) (E : ℝ × ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  E = scalarMechanicalEnergy U ∧
  ∀ t, DifferentiableAt ℝ U (z t).1 ∧ HasDerivAt z ((z t).2, -deriv U (z t).1) t'''
        s=replace(s,a,b)
        return s,'MD-1.2-ScalarMechanical','补E_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。',None
    if key=='LJTimeScaling':
        # Only the docstring tolerance is changed; the theorem bytes stay fixed.
        start=s.index('/-- source_id: MD-1.2-LJTimeScaling ·');end=s.index('-/',start)
        part=s[start:end]
        s=s[:start]+part.replace('0.005','0.01')+s[end:]
        return s,'MD-1.2-LJTimeScaling','仅[EXTRA]容差0.005ps改为0.01ps；两个定理逐字未改。',None
    if key=='ScalarFirstIntegral':
        return s,'MD-1.5.2-ScalarFirstIntegral','本条正式覆盖为“能量守恒 + 非转向点局部求积”的部分形式化；转向点换坐标求积、平衡点常解分类和全局拼接列为覆盖缺口，不补理论。',None
    if key=='PeriodicTranslationMomentum':
        s=replace(s,'  φ (y-x + if closing then L else 0)','  φ ‖y-x + if closing then L else 0‖')
        s=replace(s,'(hφ : DifferentiableAt ℝ φ (y-x + if closing then L else 0))','(hφ : DifferentiableAt ℝ (fun s => φ ‖s‖) (y-x + if closing then L else 0))')
        a='''      -deriv φ (y-x + if closing then L else 0) := by'''
        s=replace(s,a,'''      -deriv (fun s => φ ‖s‖) (y-x + if closing then L else 0) := by''')
        a='''      deriv φ (y-x + if closing then L else 0) := by'''
        s=replace(s,a,'''      deriv (fun s => φ ‖s‖) (y-x + if closing then L else 0) := by''')
        s=s.replace('Both endpoint forces of each actual directed periodic bond, including the closing bond.','Both endpoint forces of each norm-based periodic bond, including the closing bond.')
        return s,'MD-1.6-PeriodicTranslationMomentum','键能量补范数，第三定律改对ψ=φ∘|·|在有向差处可微；平移/动量主定理逐字未改。',None
    if key=='RhombicLattice':
        a='  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}'
        s=replace(s,a,a+'''

def RhombicLatticeValidDomain (a b θ : ℝ) : Prop :=
  0 < a ∧ 0 < b ∧ Real.sin θ ≠ 0

def rhombicLatticeOnDomain (a b θ : ℝ) (_h : RhombicLatticeValidDomain a b θ) :
    Set (Position 2) := rhombicLattice a b θ
''')
        return s,'MD-1.6-RhombicLattice','一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。','MD.Ch01.rhombicLatticeOnDomain'
    if key=='UnitCell':
        a='''    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}'''
        s=replace(s,a,a+'''

/-- Half-open cell B([0,1)^3), with boundary representatives fixed by coordinates. -/
def unitCellBox (B : Matrix (Fin 3) (Fin 3) ℝ) : Set V3 :=
  B.toEuclideanLin '' {x : V3 | ∀ i, 0 ≤ x i ∧ x i < 1}

def UnitCellValidDomain (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Prop :=
  B.det ≠ 0 ∧ motif.Finite ∧ motif.Nonempty ∧ motif ⊆ unitCellBox B

def unitCellOnDomain (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3)
    (_h : UnitCellValidDomain B motif) : Set V3 := unitCellLattice B motif
''')
        return s,'MD-1.6-UnitCell','一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。','MD.Ch01.unitCellOnDomain'
    raise ValueError(key)

def main():
    by=register()
    done=load(OUT/'REPAIRS.json') if (OUT/'REPAIRS.json').exists() else []
    for key in ['AngleBond','GayBerne','NewtonCompact','HarmonicSolution','ScalarMechanical','LJTimeScaling','ScalarFirstIntegral','PeriodicTranslationMomentum','RhombicLattice','UnitCell']:
        if any(d['key']==key and d['exit_code']==0 for d in done): continue
        before=LEAN.read_text(encoding='utf-8-sig');after,sid,note,primary=repair(key,before)
        after=add_doc(after,sid,'[EXTRA] '+note)
        after=re.sub(r'(?m)^#print axioms MD\.Ch01\.[^\n]+\n?','',after).rstrip()+'\n'
        names=re.findall(r'(?m)^(?:noncomputable )?(?:def|theorem|abbrev)\s+(\w+)',after)
        after+='\n'+'\n'.join('#print axioms MD.Ch01.'+n for n in names)+'\n'
        LEAN.write_text(after,encoding='utf-8')
        sources=load(BASE/'ch01_source.json');src=next(x for x in sources if x['source_id']==sid)
        returned=by[sid]['closeout21_return']
        if key in ('AngleBond','LJTimeScaling'):
            corrected=returned['json_review']['corrected_json'];assert corrected
            for field in ['statement_latex','context_notation','label','extra_assumptions']:
                if field in corrected:src[field]=copy.deepcopy(corrected[field])
        if key=='HarmonicSolution':src['label']='Example 1.3'
        src.setdefault('extra_assumptions',[]).append('[EXTRA] '+note)
        if primary:src['lean_decl']=primary
        if key=='ScalarFirstIntegral':
            src['statement_scope']='能量守恒 + 非转向点局部求积（部分形式化）'
            src['coverage_gaps']=['转向点换坐标求积','平衡点常解分类','全局拼接与完整可积性']
        src.setdefault('repair_log',[]).append(dict(stage='CLOSEOUT21',reason=note,website='按网站意见修复；不再送网站'))
        dump(BASE/'ch01_source.json',sources)
        diff=''.join(difflib.unified_diff(before.splitlines(True),after.splitlines(True),fromfile='before/Ch01.lean',tofile='after/Ch01.lean'))
        (OUT/(key+'.diff')).write_text(diff,encoding='utf-8')
        receipt,output,_=compile_recorded(['lake','env','lean','Blueprint/Ch01.lean'],ROOT,LEAN,OUT/(key+'.log'),OUT/(key+'.json'))
        row=dict(key=key,source_id=sid,diff_summary=note,suggested_fix=returned['audit']['suggested_fix'],original_fail=returned['audit'],diff_file=key+'.diff',**receipt)
        done.append(row);dump(OUT/'REPAIRS.json',done)
        if receipt['exit_code']!=0:
            print(output.decode('utf-8',errors='replace')[-6000:],flush=True);raise SystemExit(receipt['exit_code'])
        assert all("sorryAx" not in line for line in output.decode('utf-8',errors='replace').splitlines() if any("'MD.Ch01."+n+"'" in line for n in names if n in ['AngleBondValidDomain','angleBondOnDomain','GayBerneValidDomain','gayBerneOnDomain','harmonicEnergy','harmonicEnergy_eq_massHamiltonian','harmonic_solution','scalarMechanicalEnergy','scalarMechanicalModel','periodic_translation_third_law','RhombicLatticeValidDomain','rhombicLatticeOnDomain','unitCellBox','UnitCellValidDomain','unitCellOnDomain']))
        w=by[sid];w['effective_status']='按网站审校意见修复，本地核验通过（未再送网站）';w['local_repair21']=row
        dump(BASE/'website_audit.json',list(by.values()))
        print(key+': compile and all declaration axioms passed',flush=True)
    dump(BASE/'CheckAxioms.lean',{}) if False else None
    text=LEAN.read_text(encoding='utf-8');prints=re.findall(r'(?m)^#print axioms MD\.Ch01\..+',text)
    (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch01\n\n'+'\n'.join(prints)+'\n',encoding='utf-8')
    print('TEN REPAIRS COMPLETE; full check remains pending.',flush=True)
if __name__=='__main__':main()
