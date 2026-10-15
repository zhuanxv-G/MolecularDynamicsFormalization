"""Explicit website signature repairs for 2.3, keeping mathematical choices open."""
from website_repair_batch import prepare,verify,commit_section
from eaudit_review_tasks import declarations
from integrate_website_returns import ROOT,read

def run(section):
    ds=declarations(2);edits={};human={}
    def change(key,code,category,note):
        edits['MD-'+section+'-'+key]=dict(code=code,category=category,note=note)
    def current(key):return ds['MD-'+section+'-'+key]['block']
    if section=='2.3.1':
        change('Divergence',current('Divergence')+'''

def divergenceFree {n : ℕ} (f : Q n → Q n) : Prop :=
  Differentiable ℝ f ∧ ∀ z, bp_divergence f z = 0''','B','保留散度辅助定义，并补经典可微向量场的散度恒零谓词；覆盖原句零条件。')
        old=current('FlowDet');signature=old.split(' := by')[0]
        signature=signature.replace('(hinit : (fun z => Φ (0, z)) = id) :','(hinit : (fun z => Φ (0, z)) = id) (_hτ : 0 < τ) :').replace('    ∀ t ∈ Icc 0 τ, ∀ z,','    (∀ t ∈ Icc 0 τ, ∀ z,')
        signature+=''' ) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (Q n), MeasurableSet S →
      volume ((fun z ↦ Φ (t,z)) '' S) = volume S)'''
        change('FlowDet',signature+''' := by
  constructor
  · apply MolecularDynamics.textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2 <;> assumption
  · exact MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2 f hf hdiv Φ hΦ τ hODE hinit''','B','补全可测集合真实Lebesgue体积结论，保留det=1；显式τ>0对应原[EXTRA]。已有证明仅用两条已证正式结论作合取小修补，无新证明路线。')
        change('LJOscillator','''def ljOscillatorEquation (σ ε : ℝ) (_hσ : 0 < σ) (_hε : 0 < ε)
    (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  (∀ t ∈ I, 0 < (γ t).1) ∧
  ∀ t ∈ I, HasDerivAt γ
    ((γ t).2,-deriv (fun q : ℝ ↦ 4*ε*((σ/q)^12-(σ/q)^6)) (γ t).1) t

def oscillatorEquation (φ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ ((γ t).2,-deriv φ (γ t).1) t''','C','本条绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、正参数及正位置；原一般势关系另保留为辅助oscillatorEquation。')
        change('LJBoundedPeriodic',current('LJBoundedPeriodic').replace('ljOscillatorEquation (fun','oscillatorEquation (fun'),'C','依赖小修：一般ODE关系改引辅助oscillatorEquation；原显式LJ势、正参数、正位置及全部周期结论逐字保留。')
        human['MD-2.3.1-VariationalPrinted']='原印变分矩阵在移动点取空间Jacobian，链式法则多项；选项：批准固定初值ζ版本／保留移动点并重写全部右侧；当前字面式及ERRATUM保持，不自行勘误。'
        eaudit='EAUDIT07';pages=[94,95,96]
    elif section=='2.3.2':
        # Absolute determinant is the substantive missing conclusion. Keep the
        # old proof for one bounded repair attempt; use the stronger existing
        # witness result only if its signature is available during compilation.
        old=current('EulerVolumeCounterexample')
        signature=old.split(' := by')[0].replace('(linearEuler S h).det ≠ 1','|(linearEuler S h).det| ≠ 1')
        change('EulerVolumeCounterexample',signature+' := by\n  sorry','B','强化见证为每个h≠0时|det(I+hS)|≠1，覆盖实际体积不守恒；原桥接只给det≠1，不能证明强化后的结论，保留sorry并记录原证明不适配，不写新证明。')
        human['MD-2.3.2-EulerVolumePrinted']='原印体积保存等价det=1遗漏绝对值；选项：批准|det|=1勘误／明确正行列式的小步长限制；保持原印，负行列式反例交导师。'
        eaudit='EAUDIT08';pages=[96,97,98]
    elif section=='2.3.3':
        change('SymplecticMap',current('SymplecticMap').replace('ContDiff ℝ 1 Φ','Differentiable ℝ Φ'),'A','采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。')
        change('OneForm',current('OneForm')+'''

def oneFormOfCoefficients {n : ℕ} (a : Q n → Q n) (z : Q n) : Q n →L[ℝ] ℝ :=
  ∑ i : Fin n, (a z i) • ContinuousLinearMap.proj i

theorem oneFormOfCoefficients_apply {n : ℕ} (a : Q n → Q n) (z ξ : Q n) :
    oneFormOfCoefficients a z ξ = ∑ i : Fin n, a z i * ξ i := by
  sorry''','B','保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。')
        change('FormSumWedges',current('FormSumWedges')+'''

def symplecticComponentMatrix {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinateMatrix Nc :=
  fun a b ↦ if a = Sum.inl i ∧ b = Sum.inr i then 1
    else if a = Sum.inr i ∧ b = Sum.inl i then -1 else 0

theorem formSumWedges_components (Nc : ℕ) :
    (∀ (i : Fin Nc) (u v : SymplecticCoordinates Nc),
      textbookWedgeOneForms (textbookDq i) (textbookDp i) u v =
        ∑ a, u a * ((symplecticComponentMatrix i) *ᵥ v) a) ∧
    (∑ i : Fin Nc, symplecticComponentMatrix i) = textbookJ Nc := by
  sorry''','B','保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。')
        old=current('SymplecticIffForm');code=old.split(' := by')[0].replace('IsTextbookSymplecticMap Φ','bp_IsSymplecticMap Φ').replace('ContDiff ℝ 1 Φ','Differentiable ℝ Φ')+' := by\n  sorry'
        change('SymplecticIffForm',code,'A','教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。')
        old=current('HamiltonDet');signature=old.split(' := by')[0].replace('    (∀ t ∈ Icc 0 τ, ∀ z,','    (∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z ↦ Φ (t,z))) ∧\n    (∀ t ∈ Icc 0 τ, ∀ z,',1)
        body=old.split(' := by',1)[1].strip();nested='\n'.join('  '+line for line in body.splitlines())
        change('HamiltonDet',signature+' := by\n  constructor\n  · exact MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 H hH Φ hΦ τ hODE hinit\n  · '+body.splitlines()[0]+'\n'+'\n'.join('  '+line for line in body.splitlines()[1:]),'B','补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。')
        eaudit='EAUDIT09';pages=[98,99,100]
    elif section=='2.3.4':
        change('MatrixCancellation',current('MatrixCancellation')+'''

theorem matrixCancellation_time {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (I : Set ℝ) (t : ℝ)
    (_hS : (S t).IsSymm)
    (_hW : HasDerivWithinAt W (textbookJ Nc * S t * W t) I t) :
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s)
      ((textbookJ Nc * S t * W t)ᵀ * textbookJ Nc * W t +
        (W t)ᵀ * textbookJ Nc * (textbookJ Nc * S t * W t)) I t ∧
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s) 0 I t := by
  sorry''','B','保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。')
        human['MD-2.3.4-HamiltonVariationalPrinted']='原印W在移动点取Jacobian；选项：批准固定ζ并用联合C²流的正式定理／保留移动点且补完整链式右侧；原印保持，不自行裁定。'
        eaudit='EAUDIT10';pages=[101]
    elif section=='2.3.5':
        human['MD-2.3.5-GlobalGroupPrinted']='非退化局部Jacobian不足推出全球双射；选项：批准另立全球辛微分同胚群／将原文全球可逆及群主张整体登记疑误；现有字面式保持。'
        eaudit='EAUDIT11';pages=[101]
    elif section=='2.3.6':
        change('SymplecticIntegrator','''def bp_symplecticIntegrator {n : ℕ}
    (H : SymplecticCoordinates n → ℝ) (F : Flow ℝ (SymplecticCoordinates n))
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ContDiff ℝ 2 H ∧
  (∀ t z, HasDerivAt (fun s ↦ F s z) (textbookHamiltonianVectorField H (F t z)) t) ∧
  ∃ δ > 0, (∀ h ∈ Ioo 0 δ, bp_IsSymplecticMap (G h)) ∧
    ∃ r : ℝ, 0 < r ∧ ∀ z, ∃ K ≥ 0, ∃ d > 0, d ≤ δ ∧
      ∀ h ∈ Ioo 0 d, ‖G h z - F h z‖ ≤ K * h^(r+1)''','B','补实际Hamiltonian流、正阶局部一致性及可用正步长域；保辛性质与数值近似资格合取，C²为充分[EXTRA]，未把无关辛映射冒充积分方法。')
        eaudit='EAUDIT12';pages=[102,103]
    elif section=='2.3.7':
        change('AdjointSymplecticEuler','''noncomputable def bp_adjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h

theorem bp_adjointSymplecticEuler_coordinates {Nc : ℕ}
    (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U)
    (h : ℝ) (z : SymplecticCoordinates Nc) :
    (∀ i, (bp_adjointSymplecticEuler m hm U hU h z) (Sum.inl i) =
      z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i)) ∧
    (∀ i, (bp_adjointSymplecticEuler m hm U hU h z) (Sum.inr i) =
      z (Sum.inr i) - h * fderiv ℝ U
        (fun j ↦ z (Sum.inl j) + h*(m j)⁻¹*z (Sum.inr j)) (Pi.single i 1)) := by
  sorry''','A','本条显式正质量及U经典可微，并补原文(Q,P)两条坐标公式；原总化正式辅助Equiv保持，新增坐标陈述暂sorry。Mathlib Flow按用户标准含义直接采信，FlowSelfAdjoint只补材料复审。')
        eaudit='EAUDIT13';pages=[103,104]
    else:raise ValueError(section)
    sources=read(ROOT/'blueprint/ch02/ch02_source.json');web={w['source_id']:w for w in read(ROOT/'blueprint/ch02/website_audit.json')}
    source_only=[s['source_id'] for s in sources if s['section']==section and s['source_id'] not in edits and s['source_id'] not in human and (web[s['source_id']]['json_review']['status']=='CORRECTED' or web[s['source_id']]['audit']['verdict']=='NEEDS_HUMAN')]
    prepare(2,eaudit,section,edits,pages=pages,source_only=source_only,human=human)
    verify(2,eaudit);commit_section(2,section,[eaudit])

if __name__=='__main__':
    import sys
    run(sys.argv[1])
