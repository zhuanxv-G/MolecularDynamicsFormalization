"""Explicit chapter-1 signature repairs; frozen formal sources are never written."""
import sys,re,hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT/'scripts'))
from integrate_website_returns import read,dump,sha
from eaudit_review_tasks import declarations,declaration_names
BASE=ROOT/'blueprint/ch01';OUT=BASE/'validation/CLOSEOUT19'

def apply():
    p=ROOT/'Blueprint/Ch01.lean';text=p.read_text(encoding='utf-8-sig');ds=declarations(1)
    edits={};notes={};cats={}
    def edit(suffix,code,note,cat='A'):
        sid=next(s for s in ds if s.endswith('-'+suffix));edits[sid]=code.strip();notes[sid]=note;cats[sid]=cat
    edit('Schrodinger',ds['MD-1.1-Schrodinger']['block'].replace('ContDiff ℝ 2 (Function.uncurry Φ) ∧', '''(∀ q, ContDiff ℝ 1 (fun t => Φ t q)) ∧
  (∀ t q (i : Fin 39), ContDiff ℝ 2 (fun s => Φ t (q + s • coordinateDirection i))) ∧
  Continuous (fun tq : ℝ × Q13 => deriv (fun t => Φ t tq.2) tq.1) ∧
  (∀ i, Continuous (fun tq : ℝ × Q13 => secondPartial (Φ tq.1) tq.2 i)) ∧'''),
         '按EAUDIT02新返回，将联合全域C²改为连续时间一阶/逐空间坐标二阶经典导数；不要求二阶时间或混合偏导。')
    edit('Coulomb','''def coulombPotential (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric r : {x : ℝ // 0 < x}) : ℝ := C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)''',
         '正C、介电常数与距离落实到子类型；电荷仍可正负，未另造吸引排斥结论。')
    edit('Cutoff','''def smoothCutoff (φ : ℝ → ℝ) (r_cut : ℝ) : Prop :=
  0 < r_cut ∧ ContDiffOn ℝ 1 φ (Ioi 0) ∧ ∀ r, r_cut < r → φ r = 0''',
         'C¹只要求正距离域，保留严格r_cut<r截零及正截断半径。')
    edit('Yukawa','''def yukawaScreened (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric : {x : ℝ // 0 < x}) (κ : ℝ) (r : {x : ℝ // 0 < x}) : ℝ :=
  C.val * Qᵢ * Qⱼ / (dielectric.val * r.val) * Real.exp (-κ * r.val)''',
         '正C、介电常数、距离落实到子类型；不改原书指数−κr，κ称谓量纲仅登记疑点。')
    edit('DegreesFreedom','''/-- Linear algebra auxiliary; geometric validity is proved by constraintdimension. -/
def linearizedConstraintDimension {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)

def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) : ℕ := linearizedConstraintDimension C q.val''',
         '只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。','C')
    edit('ConstraintDimension','''theorem constraintdimension {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) :
    degreesOfFreedom C c q + r = n ∧
    ∃ (U : Set (Position n)) (V : Set (Position (degreesOfFreedom C c q) × Position r))
      (φ : Position n → Position (degreesOfFreedom C c q) × Position r)
      (ψ : Position (degreesOfFreedom C c q) × Position r → Position n),
      IsOpen U ∧ IsOpen V ∧ q.val ∈ U ∧
      ContDiffOn ℝ 1 φ U ∧ ContDiffOn ℝ 1 ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      (∀ x ∈ U, C x = c ↔ (φ x).2 = 0) := by
  sorry

/-- Unconstrained three-dimensional N-particle specialization, not a geometry assumption. -/
theorem constraintdimension_unconstrained (N : ℕ) :
    linearizedConstraintDimension (fun _ : Position (3*N) => (0 : Position 0)) 0 = 3*N := by
  simp [linearizedConstraintDimension, Position]''',
         '保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。','C')
    edit('ScalarMechanical','''def scalarMechanicalModel (U : ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  ∀ t, DifferentiableAt ℝ U (z t).1 ∧ HasDerivAt z ((z t).2, -deriv U (z t).1) t''',
         '沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。')
    # Keep the existing substantial scaling proof and append its numerical clause.
    old=ds['MD-1.2-LJTimeScaling']['block'];at=old.find('/- END FULL SECTION');old=old[:at].rstrip() if at>=0 else old
    edit('LJTimeScaling',old+'''

/-- Argon SI specialization: the printed approximation uses a 0.005 ps tolerance. -/
theorem ljtimescaling_argon :
    |(3.4 / 10^10 : ℝ) * Real.sqrt ((6.69 / 10^26) / (1.65 / 10^21)) -
      2.17 / 10^12| < 0.005 / 10^12 := by
  have hs := Real.sq_sqrt (show (0 : ℝ) ≤ (6.69 / 10^26) / (1.65 / 10^21) by norm_num)
  have hp := Real.sqrt_nonneg ((6.69 / 10^26 : ℝ) / (1.65 / 10^21))
  rw [abs_lt]
  constructor <;> nlinarith''',
         '补原书氩m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m的2.17ps近似，显式容差0.005ps；保留原双向缩放和时间单位证明。','B')
    edit('HamiltonEquations','''def hamiltonEquationsOn {n : ℕ} (H : PhaseSpace n → ℝ)
    (I : Set ℝ) (q p : ℝ → Position n) : Prop :=
  ∀ t ∈ I, DifferentiableAt ℝ (fun v => H (q t,v)) (p t) ∧
    DifferentiableAt ℝ (fun x => H (x,p t)) (q t) ∧
    HasDerivAt q (gradient (fun v => H (q t,v)) (p t)) t ∧
    HasDerivAt p (-gradient (fun x => H (x,p t)) (q t)) t

def hamiltonEquations {n : ℕ} (H : PhaseSpace n → ℝ) (q p : ℝ → Position n) : Prop :=
  hamiltonEquationsOn H univ q p''',
         '沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。')
    edit('CompactContinuation','''/-- General confinement helper retained separately from the Hamiltonian result. -/
theorem compact_continuation_aux {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (K : Set (PhaseSpace n)) (z₀ : PhaseSpace n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q) (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q) (hz : z₀ ∈ K)
    (hconfine : ∀ a b γ, 0 ∈ Ioo a b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ 0 = z₀ → ∀ t ∈ Ioo a b, γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q univ γ ∧ γ 0 = z₀ ∧ ∀ t, γ t ∈ K := by
  sorry

theorem compact_continuation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z₀ : PhaseSpace n) (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U)
    (hlower : ∃ b : ℝ, ∀ q, b ≤ U q)
    (hconfine : ∀ E : ℝ, Bornology.IsBounded {q : Position n | U q ≤ E}) :
    ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ γ ∧ γ 0 = z₀ ∧
      (∀ t, hamiltonian m U (γ t) = hamiltonian m U z₀) ∧
      Bornology.IsBounded (Set.range γ) ∧
      (∀ η : ℝ → PhaseSpace n,
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ η → η 0 = z₀ → η = γ) ∧
      (∀ a b η, 0 ∈ Ioo a b →
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ (Ioo a b) η → η 0 = z₀ →
        ∀ t ∈ Ioo a b, η t = γ t) := by
  sorry''',
         '主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。','B')
    edit('HarmonicPhaseFlow',ds['MD-1.5.1-HarmonicPhaseFlow']['block']+'''

theorem harmonicPhaseFlow_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    harmonicPhaseFlow Ω 0 z = z ∧
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ))
      (fun q => (-(Ω^2)) • q) univ univ (fun t => harmonicPhaseFlow Ω t z) := by
  constructor
  · simp [harmonicPhaseFlow]
  · exact harmonicFlow_isMechanicalSolution Ω hΩ z''',
         '保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。','B')
    edit('KeplerMomentum',ds['MD-1.5.2-KeplerMomentum']['block']+'''

theorem keplermomentum_not_first_integrals :
    ∀ i : Fin 2, ¬ IsFirstIntegralOn
      (mechanicalField (fun _ : Fin 2 => (1 : ℝ)) keplerForce)
      {z : PhaseSpace 2 | z.1 ≠ 0} (fun z : PhaseSpace 2 => z.2 i) := by
  sorry''',
         '保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。','B')
    edit('TorusPeriod',ds['MD-1.5.2-TorusPeriod']['block']+'''

/-- Finite-dimensional torus translation: a quasiperiodic representation allows resonances. -/
def torusQuasiperiodic {n : ℕ} (γ : ℝ → HarmonicTorus n) : Prop :=
  ∃ (Ω : Fin n → ℝ) (θ : HarmonicTorus n), γ = fun t => harmonicTorusRotation Ω t θ

theorem torusperiod_classification {n : ℕ} (Ω : Fin n → ℝ) (θ : HarmonicTorus n) :
    (∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) ∨
    (torusQuasiperiodic (fun t => harmonicTorusRotation Ω t θ) ∧
      ¬ ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) := by
  classical
  by_cases h : ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T
  · exact Or.inl h
  · exact Or.inr ⟨⟨Ω,θ,rfl⟩,h⟩''',
         '保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。','B')
    edit('LinearizedHamiltonian',ds['MD-1.5.3-LinearizedHamiltonian']['block']+'''

theorem linearizedHamiltonian_field {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hM : M.PosDef)
    (hU : ContDiff ℝ 2 U) (heq : gradient U qstar = 0) :
    ∀ δz : PhaseSpace n,
      fderiv ℝ (symplecticGradient (fun z : PhaseSpace n =>
        inner ℝ z.2 (matrixAction M⁻¹ z.2)/2 + U z.1)) (qstar,0) δz =
      symplecticGradient (fun z : PhaseSpace n => linearizedHamiltonian M U qstar z.1 z.2) δz := by
  sorry''',
         '保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。','B')
    edit('PeriodicBoundary','''def periodicPositionEquivalent (L : ℝ) (x y : ℝ) : Prop := ∃ k : ℤ, y = x + k*L

def periodicBoundary (L : {x : ℝ // 0 < x}) (x y : ℝ) : Prop :=
  y = if L.val < x then x-L.val else if x < 0 then x+L.val else x''',
         '原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。','C')
    edit('PeriodicTranslationMomentum',ds['MD-1.6-PeriodicTranslationMomentum']['block']+'''

/-- Both endpoint forces of each actual directed periodic bond, including the closing bond. -/
def periodicBondEnergy (φ : ℝ → ℝ) (L : ℝ) (x y : ℝ) (closing : Bool) : ℝ :=
  φ (y-x + if closing then L else 0)

theorem periodic_translation_third_law (φ : ℝ → ℝ) (L x y : ℝ) (closing : Bool)
    (hφ : DifferentiableAt ℝ φ (y-x + if closing then L else 0)) :
    -deriv (fun u => periodicBondEnergy φ L u y closing) x =
      -(-deriv (fun u => periodicBondEnergy φ L x u closing) y) := by
  have hx := hφ.hasDerivAt.scomp x
    (((hasDerivAt_const x y).sub (hasDerivAt_id x)).add_const (if closing then L else 0))
  have hy := hφ.hasDerivAt.scomp y
    (((hasDerivAt_id y).sub_const x).add_const (if closing then L else 0))
  simpa [periodicBondEnergy] using congrArg Neg.neg (by simpa using hx.deriv.trans (by rw [hy.deriv]; ring))''',
         '完整保留平移/方向导数/动量结论，补真实每条周期键两端负偏导相反的Newton第三定律（含闭合键），依赖包展开真实周期能量。','B')
    edit('MinimumImage',ds['MD-1.6-MinimumImage']['block']+'''

def minimumImageForce {N : ℕ} (L : ℝ) (q : Fin N → V3)
    (image : Fin N → Fin N → V3) (pairForce : Fin N → Fin N → V3 → V3 → V3)
    (force : Fin N → V3) : Prop :=
  0 < L ∧ (∀ i j, i ≠ j → minimumImage L (q i) (q j) (image i j)) ∧
    ∀ i, force i = ∑ j ∈ Finset.univ.erase i, pairForce i j (q i) (image i j)''',
         '最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。','B')
    old=ds['MD-1.6.1-ComplexNormalMode']['block']
    edit('ComplexNormalMode',old.replace('    (A.map (algebraMap ℝ ℂ)).mulVec η =', '    η ≠ 0 → (A.map (algebraMap ℝ ℂ)).mulVec η =',1).replace('    ∀ a b : ℂ, ∀ t : ℝ,','''    (fun i => star (η i)) ≠ 0 ∧
    (A.map (algebraMap ℝ ℂ)).mulVec (fun i => star (η i)) =
      (-Complex.I * Ω) • (fun i => star (η i)) ∧
    ∀ a b : ℂ, ∀ t : ℝ,''',1),
         '增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。','B')
    # Preserve the old long proof verbatim as an auxiliary; only add the actual conservation conclusion.
    old=ds['MD-1.7-CentralAngularMomentum']['block']
    aux=old.replace('theorem centralangularmomentum :','theorem centralangularmomentum_derivative :',1)
    sig=old.split(' := by',1)[0].replace('theorem centralangularmomentum :','theorem centralangularmomentum :',1).replace('(I : Set ℝ), IsOpen I →','(I : Set ℝ), IsOpen I → IsPreconnected I →',1)
    sig=sig.replace('    ∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t', '''    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, cross3 (q a i) (m i • v a i)) =
      ∑ i, cross3 (q b i) (m i • v b i)''')
    edit('CentralAngularMomentum',aux+'\n\n'+sig+''' := by
  intro N m q v F I hI hc hq hp ha hf
  obtain ⟨ht,hd⟩ := centralangularmomentum_derivative N m q v F I hI hq hp ha hf
  refine ⟨ht,hd,?_⟩
  intro a ha b hb
  exact IsPreconnected.is_const_of_fderivWithin_eq_zero hc
    (fun t ht => (hd t ht).continuousAt.continuousWithinAt)
    (fun t ht => (hd t ht).hasFDerivAt.hasFDerivWithinAt) ha hb''',
         '保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。','B')
    # Keep section boundary comments intact, even where the extractor included them.
    changed=[]
    for sid,code in edits.items():
        raw=ds[sid]['block'];boundary=re.search(r'\n/\- END FULL SECTION[\s\S]*$',raw)
        if boundary and boundary.group(0).strip() not in code:code+='\n'+boundary.group(0)
        assert text.count(raw)==1,sid
        text=text.replace(raw,code,1);changed.append(dict(source_id=sid,category=cats[sid],note=notes[sid],before=ds[sid]['signature_sha256']))
    p.write_text(text,encoding='utf-8')
    src=read(BASE/'ch01_source.json');web=read(BASE/'website_audit.json');ws={w['source_id']:w for w in web}
    for s in src:
        sid=s['source_id']
        if sid not in edits:continue
        s.setdefault('extra_assumptions',[]).append('[EXTRA] 19号：'+notes[sid])
        s.setdefault('repair_log',[]).append(dict(stage='CLOSEOUT19_SIGNATURE_REPAIR',category=cats[sid],before_signature_sha256=ds[sid]['signature_sha256'],reason=notes[sid],original_statement_unchanged=True))
        ws[sid].setdefault('repair',{}).update(status='prepared_unverified',eaudit='CLOSEOUT19',category=cats[sid],note=notes[sid])
    dump(BASE/'ch01_source.json',src);dump(BASE/'website_audit.json',web);dump(OUT/'SIGNATURE_REPAIRS.json',changed)
    print('Prepared',len(edits),'signature groups; NOT yet compiled')

if __name__=='__main__':apply()
