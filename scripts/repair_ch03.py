"""Chapter 3 source-by-source website repair plan; no new proofs."""
from website_repair_batch import prepare,verify,commit_section
from integrate_website_returns import ROOT,read
from eaudit_review_tasks import declarations

def run(section):
    ds=declarations(3);edits={};human={};refresh=[]
    def sid(k):return 'MD-'+section+'-'+k
    def current(k):return ds[sid(k)]['block']
    def change(k,code,category,note,**kw):edits[sid(k)]=dict(code=code,category=category,note=note,**kw)
    if section=='3':
        refresh=[sid('ModifiedConstruction')];pages=[119]
    elif section=='3.1':
        refresh=[sid(k) for k in ['EnergyFailure','FormalHamiltonian','FormalHamiltonianField']]
        human[sid('ShadowEllipses')]='slightly rotated是否要求旋转角趋零须先确定，圆形退化时主轴不唯一；选项：仅形状小扰动／非圆分支补主轴趋零并单列圆。保持现状，不默补非圆前提。'
        pages=[120,121,122]
    elif section=='3.2':
        human[sid('FiniteLieTaylor')]='原文形式exp等号采用形式系数还是Taylor jet/全阶渐近，需数学范围裁定；选项：逐阶导数/形式系数等式／现有有限余项严格化并单独标新增结论。现状保持，不声称无限级数收敛。'
        human[sid('FlowCoordinates')]='原页实际流与形式exp的连接需选形式jet还是全阶渐近解释；选项：定义实际拉回的时间jet并逐系数等同／批准现有局部有限余项作为严格化。保持当前声明。'
        pages=[122,123,124]
    elif section=='3.3':
        change('FormalSplitting',current('FormalSplitting')+'''

def formalExactSplit {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential (A+B)

def hamiltonianSplittingObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun k ↦ ∑ i ∈ Finset.range (k+1),
    ((textbookLieDerivative (textbookHamiltonianVectorField A))^[i]
      ((textbookLieDerivative (textbookHamiltonianVectorField B))^[k-i] φ)) z /
      ((Nat.factorial i : ℝ)*(Nat.factorial (k-i) : ℝ)))

def hamiltonianExactObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j ↦
    ((textbookLieDerivative (textbookHamiltonianVectorField (fun x ↦ A x+B x)))^[j] φ) z /
      (Nat.factorial j : ℝ))''','B','同时保留精确形式exp(A+B)及分裂形式expA expB，并用真实Hamiltonian Lie导数的卷积系数实例连接A=L_H1、B=L_H2；仅形式系数，不宣称解析收敛。')
        for key,degree in [('DifferenceCommutator',2),('DifferenceCubic',3)]:
            old=current(key);primary=old.split(' := by')[0]
            formula=primary.split(' =',1)[1].strip()
            delta='(textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B))'
            code=f'''theorem {ds[sid(key)]['name'].split('.')[-1]} (A B : R) :
    PowerSeries.coeff 0 {delta} = 0 ∧
    PowerSeries.coeff 1 {delta} = 0 ∧
    PowerSeries.coeff 2 {delta} = (1/2 : ℝ) • (A*B-B*A)'''
            if degree==3:code+=f' ∧\n    PowerSeries.coeff 3 {delta} = '+formula
            code+=' := by\n  sorry\n\n'+old.replace('theorem '+ds[sid(key)]['name'].split('.')[-1]+' ',
              'theorem '+ds[sid(key)]['name'].split('.')[-1]+f'_coeff{degree} ',1)
            if degree==2:code+='''

theorem differenceCommutator_hamiltonian (n : ℕ)
    (A B φ : SymplecticCoordinates n → ℝ)
    (_hA : ContDiff ℝ ⊤ A) (_hB : ContDiff ℝ ⊤ B) (_hφ : ContDiff ℝ ⊤ φ)
    (z : SymplecticCoordinates n) :
    let S := hamiltonianSplittingObservable A B φ z-hamiltonianExactObservable A B φ z
    PowerSeries.coeff 0 S = 0 ∧ PowerSeries.coeff 1 S = 0 ∧
    PowerSeries.coeff 2 S = (1/2 : ℝ)*
      (textbookLieDerivative (textbookHamiltonianVectorField A)
        (textbookLieDerivative (textbookHamiltonianVectorField B) φ) z -
       textbookLieDerivative (textbookHamiltonianVectorField B)
        (textbookLieDerivative (textbookHamiltonianVectorField A) φ) z) := by
  sorry'''
            change(key,code,'B','显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。')
        for key in ['LeadingShadowHamiltonian','BCHHamiltonianMatching']:
            human[sid(key)]='算子乘积与状态复合方向及Poisson奇数项符号冲突；选项：保留expLA expLB并反转状态端点及h/h³符号／保留当前端点及正号、显式勘误原书算子次序。需导师选路线，当前不改。'
        pages=[125,126,127,128]
    elif section=='3.3.1':
        pages=[128]
    elif section=='3.3.2':
        change('VerletHamiltonianParts','''def verletHamiltonianParts {n : ℕ} (m : Fin n → ℝ)
    (_hm : positiveMass m) (U : Q n → ℝ) : Fin 3 → SymplecticCoordinates n → ℝ :=
  ![(fun z ↦ U (unpack z).1/2),
    (fun z ↦ quadraticKinetic m (unpack z).2), (fun z ↦ U (unpack z).1/2)]

theorem verletHamiltonianParts_sum {n : ℕ} (m : Fin n → ℝ)
    (hm : positiveMass m) (U : Q n → ℝ) (z : SymplecticCoordinates n) :
    (∑ i : Fin 3, verletHamiltonianParts m hm U i z) =
      quadraticKinetic m (unpack z).2+U (unpack z).1 := by
  sorry''','C','绑定真实正对角质量、T(p)=pᵀM⁻¹p/2及U(q)，补H1+H2+H3=H；移除任意相空间函数替代机械分解。')
        change('VerletModifiedHamiltonian',current('VerletModifiedHamiltonian'),'B',
          '本条仅保留展示式到h⁴的有限多项式；一般可分离T(p),U(q)的完整形式系数及O(h⁶)匹配由MD-3.3.2-VerletModifiedMatching补全，原展示式及余项原文不删。',
          scope='展示式中到h⁴的有限多项式辅助定义；BCH系数匹配及Hamiltonian O(h⁶)余项范围由MD-3.3.2-VerletModifiedMatching承担。')
        change('VerletModifiedMatching',current('VerletModifiedMatching')+'''

theorem verletModifiedMatching_general (n : ℕ) (T U : Q n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (η : ℝ) (_hT : ContDiff ℝ ⊤ T) (_hU : ContDiff ℝ ⊤ U)
    (_hD : IsOpen D) (_hB : IsCompact B) (_hBD : B ⊆ D)
    (_hΦ : actualFlow (textbookHamiltonianVectorField (fun z ↦ T (unpack z).2)) D Φ η)
    (_hΨ : actualFlow (textbookHamiltonianVectorField (fun z ↦ U (unpack z).1)) D Ψ η) :
    let Tp := fun z : SymplecticCoordinates n ↦ T (unpack z).2
    let Uq := fun z : SymplecticCoordinates n ↦ U (unpack z).1
    let G := fun h ↦ Ψ (h/2) ∘ Φ h ∘ Ψ (h/2)
    matchesHamiltonian (verletModifiedH Tp Uq) G B 6 ∧
    (∃ Hj : ℕ → SymplecticCoordinates n → ℝ,
      (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      (∀ z ∈ D, Hj 0 z = Tp z+Uq z) ∧
      (∀ z ∈ D, Hj 2 z =
        (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq) z-
          textbookPoissonBracket Uq (textbookPoissonBracket Uq Tp) z/2)/12) ∧
      (∀ z ∈ D, Hj 4 z =
        (-textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq))) z/6+
          textbookPoissonBracket Uq (textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq))) z/3-
          textbookPoissonBracket Uq (textbookPoissonBracket Uq (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq))) z/4+
          textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Uq (textbookPoissonBracket Uq Tp))) z)/120) ∧
      (∀ j z, Hj (2*j+1) z = 0) ∧
      ∀ k ≥ 6, matchesHamiltonian (fun h z ↦ ∑ j ∈ Finset.range k, h^j*Hj j z) G B k) := by
  sorry''','B','保留已列机械特例，新增一般分离T(p),U(q)、真实局部子流、h⁴系数及所有截断匹配；Hamiltonian余项从h⁶起（奇项零），对应端点O(h⁷)，不混同两个余项。新结论暂sorry，未裁定印刷系数是否正确。')
        change('ModifiedEven',current('ModifiedEven').replace('(A B : R), ∀ j : ℕ,',
          '(A B : R),\n    PowerSeries.coeff 1 (formalLog (formalStrang A B))=A+B ∧ ∀ j : ℕ,'),
          'B','补一阶log系数A+B并保留全部偶次零，表达至少二阶及Hamiltonian偶性/log奇性；不沿用不同步长log交换的错误推理。')
        human[sid('DifferentLogsCommute')]='不同步长Strang的对数一般不交换；选项：保留为原书错误断言档案／批准加A、B交换的受限修复。现状不进入已证结论，奇性改依赖反步恒等式的路线另审。'
        old=current('StrangCubic');signature=old.split(' := by')[0].replace('(A B : R),',
          '(A B : R),\n    PowerSeries.coeff 1 (formalLog (formalStrang A B))=A+B ∧\n    (∀ j : ℕ, PowerSeries.coeff (2*j) (formalLog (formalStrang A B))=0) ∧',1)
        change('StrangCubic',signature+' := by\n  sorry\n\n'+old.replace('theorem strangCubic :','theorem strangCubic_coeff3 :',1),
          'B','补一次系数和全部偶次零，连同原三次公式覆盖完整奇次展开；原已证三次系数保留辅助并重查，新合取暂sorry。')
        pages=[129,130]
    elif section=='3.3.3':
        code=current('YoshidaRaiseOrder').replace('→ localOrder G Φ B (2*s) →',
          '→ (∀ K : Set (Q n), IsCompact K → K ⊆ D → localOrder G Φ K (2*s)) →')
        code=code.replace(' Φ B (2*s+2) := by',
          ''' Φ B (2*s+2) ∧
    (∀ K : Set (Q n), IsCompact K → K ⊆ D →
      localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ K (2*s+2)) ∧
    (∀ h z, yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 (-h)
      (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 h z)=z) ∧
    ContDiff ℝ ⊤ (fun hz : ℝ × Q n ↦
      yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 hz.1 hz.2) := by''')
        change('YoshidaRaiseOrder',code,'A','将孤立B上的逐紧集阶改为D内每个紧集的一致阶资格，覆盖移动中间点；结论补新方法在每紧集升阶、光滑及对称，保留递归资格。')
        # Preserve the unrestricted combination as an explicitly named auxiliary.
        old=current('Yoshida4')
        change('Yoshida4',old.replace('(U : Q n → ℝ) (h : ℝ)',
          '(_hm : positiveMass m) (U : Q n → ℝ) (_hU : Differentiable ℝ U) (h : ℝ)'),
          'A','教材算法接口明确正质量与经典可微势；后续结构定理调用使用正式总化辅助组合，证明不新增。')
        change('Yoshida4Structure',current('Yoshida4Structure').replace('yoshida4 m U',
          'MolecularDynamics.Chapter03Review.yoshida4 m U'),'A','依赖小修：原无质量限制的结构定理继续对应正式总化辅助算法；教材受限接口另有正质量/可微资格，原已证结论保留。')
        pages=[131,132,133]
    elif section=='3.3.4':
        change('TakahashiShadow',current('TakahashiShadow')+'''

theorem takahashiShadow2_matching (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ)
    (_hm : positiveMass m) (_hU : ContDiff ℝ ⊤ U) (B : Set (SymplecticCoordinates n))
    (_hB : IsCompact B) :
    matchesHamiltonian (fun h z ↦ takahashiShadow2 m U h (unpack z))
      (takahashiImada m U) B 4 ∧
    (∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
      |verletModifiedH (fun x ↦ quadraticKinetic m (unpack x).2)
        (fun x ↦ takahashiPotential m U h (unpack x).1) h z-
        takahashiShadow2 m U h (unpack z)| ≤ C*h^4) := by
  sorry''','B','保留有限函数并补修正势代入原Verlet影子多项式后的O(h⁴)差界、真实TI步的Hamiltonian匹配（端点O(h⁵)）；正质量、C∞、紧集为显式充分资格，Poisson到梯度联系保留相邻PotentialDoubleBracket。')
        human[sid('ProcessorEnergyPrinted')]='原印第一行T遗漏U，h=0即不等于H；选项：批准另立Corrected将T改H，保留第二界／原印仅存档。当前原式保留，不尝试证明。'
        human[sid('TakahashiEffectiveOrder')]='原后处理P=id+h²a与现χ⁻¹∘G∘χ的方向及全局Homeomorph域不匹配；选项：轨迹邻域P∘G∘P⁻¹并绑定原a／令χ=P⁻¹且系数取负并明确局部域。与第2章TI符号疑误一并裁定，当前保持。'
        pages=[134,135]
    elif section=='3.4':
        change('TruncationSmooth',current('TruncationSmooth').replace('ContDiffOn ℝ 1','ContDiffOn ℝ ⊤'),
          'B','光滑假设与结论均提升C∞，覆盖原文光滑截断；原正式有限和定理可按阶数参数实例化，保留原证明小修。')
        change('Thm3.1','''theorem theorem31 (n r k : ℕ)
    (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (_hr : 0 < r) (_hrk : r ≤ k) (_hD : IsOpen D) (_hconvD : Convex ℝ D)
    (_hB : IsCompact B) (_hconvB : Convex ℝ B) (_hBD : B ⊆ D)
    (_hH : ContDiffOn ℝ ⊤ H D) (_hHj : ∀ j, ContDiffOn ℝ ⊤ (Hj j) D)
    (_hmatching : finiteMatching H Hj r k D B G) :
    ∀ T > 0, ∃ M > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z₀ ∈ B, ∀ ν : ℕ,
      (∀ i ≤ ν, oneStepIterate G h z₀ i ∈ B) →
      (ν:ℝ)*h*h^(k-r) ≤ T →
      ‖H (oneStepIterate G h z₀ ν)-H z₀‖ ≤ M*h^r := by
  sorry''','B','将构造与能量估计分开：Hj及实际有限匹配由FiniteMatchingConstruction/ArbitraryFiniteTruncation提供；本条不再要求从B每点出发的全部截断短轨迹留B，保留原数值轨道约束和正确长时间量词。')
        change('EnergyTelescoping',current('EnergyTelescoping')+'''

theorem energyTelescoping_complete (K : E → ℝ) (G : ℝ → E → E)
    (F : E → E) (h : ℝ) (z₀ : E) (n : ℕ)
    (_hconserve : ∀ i < n, K (F (oneStepIterate G h z₀ i))=K (oneStepIterate G h z₀ i)) :
    let z := oneStepIterate G h z₀
    let η := fun i ↦ z (i+1)-F (z i)
    K (z n)-K z₀ = ∑ i ∈ Finset.range n, (K (z (i+1))-K (z i)) ∧
    (∑ i ∈ Finset.range n, (K (z (i+1))-K (z i))) =
      ∑ i ∈ Finset.range n, (K (z (i+1))-K (F (z i))) ∧
    (∑ i ∈ Finset.range n, (K (z (i+1))-K (F (z i)))) =
      ∑ i ∈ Finset.range n, (K (F (z i)+η i)-K (F (z i))) := by
  sorry''','B','保留已证首行望远镜恒等式；补给定守恒截断步F、真实差η=数值步−F的完整三行等式，不以待证能量差为前提。')
        change('UniformTruncatedLipschitz',current('UniformTruncatedLipschitz')+'''

theorem uniformTruncatedLipschitz_chain (K : E → ℝ) (G : ℝ → E → E)
    (F : E → E) (h L A : ℝ) (k n : ℕ) (z₀ : E)
    (_hh : 0 ≤ h) (_hL : 0 ≤ L) (_hA : 0 ≤ A)
    (_hconserve : ∀ i < n, K (F (oneStepIterate G h z₀ i))=K (oneStepIterate G h z₀ i))
    (_hlip : ∀ i < n,
      |K (oneStepIterate G h z₀ (i+1))-K (F (oneStepIterate G h z₀ i))| ≤
        L*‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖)
    (_hdefect : ∀ i < n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖ ≤ A*h^(k+1)) :
    |K (oneStepIterate G h z₀ n)-K z₀| ≤
      L*∑ i ∈ Finset.range n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖ ∧
    (L*∑ i ∈ Finset.range n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖) ≤
      L*A*(n:ℝ)*h^(k+1) := by
  sorry''','B','保留统一截断Lipschitz定理，补原完整能量差≤LΣ‖η‖≤LAνh^(k+1)链；A为原文缺陷常数重命名，F为所给守恒截断一步。')
        old=current('PhysicalEnergyDrift');aux=old.split(' := by')[0].replace('theorem physicalEnergyDrift','theorem physicalEnergyDrift_complete',1)
        aux=aux.replace('(γ h z t)) (Icc 0 h) t) :',
          '''(γ h z t)) (Icc 0 h) t)
    (A : ℝ) (_hA : 0 ≤ A)
    (_hdefect : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ‖G h z-γ h z h‖ ≤ A*h^(k+1)) :''')
        aux=aux.replace('L * ∑ i ∈ Finset.range n, ‖G h (oneStepIterate G h z₀ i) -\n            γ h (oneStepIterate G h z₀ i) h‖','L*A*(n:ℝ)*h^(k+1)')
        change('PhysicalEnergyDrift',old+'\n\n'+aux+' := by\n  sorry','B','保留已证实际缺陷和界，新增实际截断流的统一一步匹配误差资格与完整2Ch^r+LAνh^(k+1)结论；不是以能量结论为假设。')
        change('StepCountPower',current('StepCountPower'),'B',
          '本条仅承担步数幂次代数辅助；原句的完整能量率由MD-3.4-PolynomialEnergyRate承担，原文不删并显式跨条映射。',
          scope='仅步数/步长幂次分解代数辅助；本条所引原句能量O(h^r)由MD-3.4-PolynomialEnergyRate承担。')
        human[sid('AnalyticDefect')]='原文many standard classes没有给出准确方法类及解析邻域资格；选项：指定解析一阶方法类并核定k·h窗口／保留仅有限阶构造并另列指数严格化。需数学判断，不以缺陷结论作前提。'
        human[sid('OptimalTruncation')]='原印指数1/(γh)与γ=1/(De)及现标量优化的γ/h不一致，标量界也不直接给真实缺陷；选项：导师确认指数勘误后与AnalyticDefect连接／原式保留存档。当前不自行确定勘误。'
        change('ScalarVerletShadow4',current('ScalarVerletShadow4')+'''

theorem scalarVerletShadow4_matching (U : ℝ → ℝ) (_hU : ContDiff ℝ ⊤ U)
    (B : Set (ℝ × ℝ)) (_hB : IsCompact B) :
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → (ℝ × ℝ) → ℝ → (ℝ × ℝ),
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, Γ h z 0=z ∧
        solution (fun x : ℝ × ℝ ↦
          (deriv (fun p ↦ scalarVerletShadow4 U h (x.1,p)) x.2,
           -deriv (fun q ↦ scalarVerletShadow4 U h (q,x.2)) x.1)) (Γ h z) 0 h ∧
        ‖(let P := z.2-(h/2)*deriv U z.1
           let Q := z.1+h*P
           (Q,P-(h/2)*deriv U Q))-Γ h z h‖ ≤ C*h^7 := by
  sorry''','B','有限h⁴多项式保留；补足光滑势/紧集上与真实velocity Verlet及该Hamiltonian实际局部流的O(h⁷)端点匹配，对应Hamiltonian O(h⁶)遗漏；新陈述未证明。')
        pages=[135,136,137,138,139,140]
    elif section=='3.5':
        change('LinearEulerIntegral',current('LinearEulerIntegral')+'''

theorem linearEulerIntegral_continuous (n : ℕ) (b : Q n →L[ℝ] ℝ)
    (f : Q n → Q n) (_hb : ∀ z, b (f z)=0)
    (γ : ℝ → Q n) (a d : ℝ) (_had : a ≤ d)
    (_hγ : ∀ t ∈ Icc a d, HasDerivWithinAt γ (f (γ t)) (Icc a d) t) :
    ∀ t ∈ Icc a d, b (γ t)=b (γ a) := by
  sorry''','B','保留已证Euler精确保存；补连续ODE解上真实线性第一积分恒定，覆盖本条原句连续与离散两结论。')
        pages=[144,145,146,147,148]
    elif section=='3.6':
        change('HamiltonianFlowStructures',current('HamiltonianFlowStructures').replace(
          '    (∀ t ∈ Icc 0 τ, ∀ S,',
          '    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, H (Φ (t,z))=H z) ∧\n    (∀ t ∈ Icc 0 τ, ∀ S,'),
          'B','补原文Hamiltonian能量沿流守恒，保留变分/辛/体积全部结论；localFlowC1实际资格无显式反步，撤销旧EXTRA对此的过度描述，时间反演由3.6.1处理。')
        change('VolumeNotSymplectic',current('VolumeNotSymplectic').replace(
          'ContDiff ℝ 1 G ∧ (∀ z,','ContDiff ℝ 1 G ∧ Function.Injective G ∧\n    (∀ S, MeasurableSet S → volume (G \'\' S)=volume S) ∧ (∀ z,'),
          'B','补真实可测集合体积保存及单射，保留det=1和非辛见证；其余原句明确跨条映射HamiltonianFlowStructures及ProjectionEnergy，不静默删原文。',
          scope='保体积但非辛的真实C¹单射映射存在性；所引段落中Hamiltonian辛流的体积保持由MD-3.6-HamiltonianFlowStructures、精确能量方法构造由MD-3.5-ProjectionEnergy承担。')
        edits[sid('VolumeNotSymplectic')]['code']+='''

theorem volumeNotSymplectic_symplectic_volume (n : ℕ)
    (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (_hG : IsTextbookSymplecticMap G) (_hinj : Function.Injective G) :
    ∀ S, MeasurableSet S → volume (G '' S)=volume S := by
  sorry'''
        edits[sid('VolumeNotSymplectic')]['scope']='辛C¹全局单射映射的真实体积保持及保体积非辛见证；精确能量方法构造由MD-3.5-ProjectionEnergy承担，Hamiltonian流实例由MD-3.6-HamiltonianFlowStructures承担。'
        pages=[149,150]
    elif section=='3.6.1':
        change('MechanicalReversal',current('MechanicalReversal').replace('(-invMass m z.2, grad U z.1)',
          '-(-invMass m z.2, grad U z.1)'),
          'C','按原页外部负号修复先前转录误读，两行均为−(−M⁻¹p,∇U)，原书此式无误；先前本条ERRATUM判断撤销，第三反演合取保留。')
        change('ReversedTrajectoryPrinted',current('ReversedTrajectoryPrinted').replace(
          '(reversedField R f (R.mulVec (γ (-t)))) t',
          '(-R.mulVec (f (γ (-t)))) t')+'''

theorem reversedTrajectoryPrinted_coordinateChange (n : ℕ)
    (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n)
    (_hR : R*R=1) (_hγ : ∀ t, HasDerivAt γ (f (γ t)) t) :
    ∀ t, HasDerivAt (fun s ↦ R.mulVec (γ s))
      (R.mulVec (f (R.mulVec (R.mulVec (γ t))))) t := by
  sorry

theorem reversedTrajectoryPrinted_timeChange (n : ℕ) (f : Q n → Q n) (γ : ℝ → Q n)
    (_hγ : ∀ t, HasDerivAt γ (f (γ t)) t) :
    ∀ t, HasDerivAt (fun s ↦ γ (-s)) (-f (γ (-t))) t := by
  sorry''','C','按PDF151真实链式法则写−R f(γ(−t))，另列纯坐标变化Rf(Rz̃)及纯时间反向−f；不以转置reversedField偷换原链式右端。')
        change('ReversedTrajectory',current('ReversedTrajectory').replace('linearInvolution R →',
          'linearInvolution R → (∀ i j, R (Pi.single j 1) i = R (Pi.single i 1) j) →'),
          'A','补R的坐标矩阵对称资格，与R²=id合起来使Rᵀ=R=R⁻¹，现有经典反演条件才与原字面转置定义等价；该限制显式EXTRA。')
        pages=[150,151]
    elif section=='3.6.2':
        change('SymmetricAffineReversible',current('SymmetricAffineReversible').replace(
          '(∀ g h z, G (fun x => -g x) h z=G g (-h) z)',
          '(∀ h z, G (fun x => -f x) h z=G f (-h) z)'),
          'A','明确本条是原印省略方法类资格后的受限修复；符号/时间尺度相容仅要求固定f，不对所有无关g全称。保留原书疑误说明。')
        change('RKAffine',current('RKAffine'),'B','仅承担普通RK阶段/更新的线性等变；PRK分区修复及对称方法反演另映射PartitionedAffine、SymmetricAffineReversible，原文整句保留。',
          scope='普通RK关系的线性坐标变换等变性子句；PRK保持分区的修复子句见MD-3.6.2-PartitionedAffine，时间反演推论见MD-3.6.2-SymmetricAffineReversible。')
        human[sid('PartitionedAffinePrinted')]='不同分区表格一般不对混合q,p的任意线性变换等变；选项：批准仅保持分区Lq,Lp／强制Aq=Ap且bq=bp退化普通RK。原印全称式保持，需导师裁定路线。'
        change('PartitionedAffine',current('PartitionedAffine'),'B','本条显式仅为保持分区的PRK阶段/更新等变修复；普通RK及有符号相容、对称资格的时间反演推论归RKAffine/SymmetricAffineReversible。保留混合变换错误的Printed导师条目。',
          scope='PRK保持分区的线性坐标变换下阶段/更新等变性的受限修复；普通RK见MD-3.6.2-RKAffine，时间反演见MD-3.6.2-SymmetricAffineReversible；任意混合分区的原印主张见待导师Printed条目。')
        pages=[151,152]
    elif section=='3.6.3':
        change('SymplecticSpectrum',current('SymplecticSpectrum')+'''

theorem symplecticSpectrum_linearHamiltonian (n : ℕ)
    (K : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ) (_hK : K.IsSymm) :
    let A := textbookJ n*K
    let Φ := fun t : ℝ ↦ NormedSpace.exp ℝ (t • A)
    (∀ z, Φ 0 *ᵥ z=z) ∧
    (∀ t z, HasDerivAt (fun s ↦ Φ s *ᵥ z) (A *ᵥ (Φ t *ᵥ z)) t) ∧
    (∀ ζ, complexEigenvalue A ζ → complexEigenvalue A (-ζ) ∧
      complexEigenvalue A (star ζ) ∧ complexEigenvalue A (-star ζ)) ∧
    (∀ t, (Φ t)ᵀ*textbookJ n*Φ t=textbookJ n) ∧
    (∀ t ζ, complexEigenvalue (Φ t) ζ →
      ζ ≠ 0 ∧ complexEigenvalue (Φ t) ζ⁻¹ ∧ complexEigenvalue (Φ t) (star ζ)) := by
  sorry''','B','保留一般辛矩阵谱结论；补对称K的实际线性Hamiltonian流exp(tJK)、ODE、辛矩阵及对应倒数/共轭谱实例。')
        old=current('ConjugateIterates')
        change('ConjugateIterates','''theorem conjugateIterates {α : Type*} (χ : α ≃ α) (A B : α → α)
    (_hA : A = χ.symm ∘ B ∘ χ) (n : ℕ) :
    A^[n] = χ.symm ∘ (B^[n]) ∘ χ := by
  sorry

'''+old.replace('theorem conjugateIterates ','theorem conjugateIterates_homeomorph ',1),
          'A','纯迭代恒等式推广到任意类型及真实Equiv，不附拓扑/范数；原Homeomorph已证版本保留辅助，用于拓扑轨道结论。')
        human[sid('ConjugateOrderPrinted')]='原文性能/稳定性/effective order并非同一局部误差阶，且Homeomorph不足误差阶运输；选项：明确仅误差阶并要求相关共同邻域双Lipschitz／分别定义稳定性与effective order再补全。当前原声明保持。'
        human[sid('ReversibleVolumeFailure')]='原整句还含可逆积分器可能能量漂移，需先确定漂移的时间窗/长期含义及实际方法类；选项：新增给定Hamiltonian的可逆一致方法能量漂移实例，并关联已有辛体积/BEA定理／导师批准缩为非保体积存在性并另立完整能量条目。当前真实可逆非体积见证保持，不把may改为全称。'
        pages=[153,154]
    elif section=='3.7':
        code=current('CollisionRegularity').replace('ContDiff ℝ ⊤ F → concatenatedCollisionSegments',
          '''ContDiff ℝ ⊤ F → ContDiff ℝ 1 g →
    (∀ j < ν, grad g (segments j (times (j+1))).1 ≠ 0 ∧
      (∑ i, grad g (segments j (times (j+1))).1 i *
        (segments j (times (j+1))).2 i/m i) < 0) →
    (∀ j ≤ ν, ∀ t ∈ Icc (times j) (times (j+1)), 0 ≤ g (segments j t).1) →
    concatenatedCollisionSegments''')
        code=code.replace('    ContinuousOn (fun t =>',
          '    (∀ j < ν, (segments j (times (j+1))).2 ≠ (segments (j+1) (times (j+1))).2) ∧\n    ContinuousOn (fun t =>',1)
        code=code.replace('ContDiffAt ℝ ⊤ (fun t => (gluedCollision times segments ν t).2) t',
          'ContDiffAt ℝ ⊤ (gluedCollision times segments ν) t')
        change('CollisionRegularity',code,'A','补光滑接触函数、非零法向、严格入射及各段合法非重叠资格；结论补完整(q,p)内段光滑及每次真实碰撞的非零动量跳跃，保留双侧有限极限。')
        pages=[154,155]
    elif section=='3.7.1':
        old=current('HardCorePotential')
        change('HardCorePotential','''def hardCorePotential {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤ else 0

def hardSphereHamiltonianPrinted {N d : ℕ} (m σ : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (U : (Fin N → Position d) → ℝ)
    (q p : Fin N → Position d) : WithTop ℝ :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤
  else ((∑ i, ‖p i‖^2/(2*m i))+U q : ℝ)

'''+old.replace('def hardCorePotential ','def hardCorePotential_contactAllowed ',1),
          'C','原印≤接触也取∞独立忠实定义，并补K+U+U_hs完整Hamiltonian；原接触允许的物理版本改名保留辅助。两种边界约定明确区分，不擅自勘误原书。')
        human[sid('PrimitiveOrder')]='原文同时含有限时间能量O(h)及长期无界，当前时间对齐全状态阶与之不同，参考轨迹端点/碰后值未绑定；选项：确定右连续物理轨迹后补能量界及适当无界实例／另列时间对齐收敛辅助。需先确定目标与碰撞语境，现状保持。'
        code=current('PrimitiveDefect').replace('ContDiff ℝ 3 U → qc ≠ 0 →',
          '''(Δ : ℝ), 0 < Δ → ContDiff ℝ 3 U → qc ≠ 0 → ‖qc‖=1 →
    Tendsto (fun h ↦ (initial h).1) (𝓝[>] 0) (𝓝 qc) →''')
        # The new Δ binder belongs to the outer universal quantifier.
        code=code.replace('(tc : ℝ → ℝ),\n    (Δ : ℝ),','(tc : ℝ → ℝ) (Δ : ℝ),')
        code=code.replace('(∀ h > 0, 0 < tc h','(∀ h ∈ Ioo 0 Δ, 0 < tc h')
        code=code.replace('(initial h).2=pbar ∧ (initial h).1=qc-tc h • pminus ∧',
          '(initial h).2=pbar ∧ (initial h).1=qc-tc h • pminus ∧\n      (∀ t ∈ Ioo 0 (tc h), 1 < ‖(initial h).1+t • pminus‖) ∧')
        code=code.replace('inner ℝ qc pbar/inner ℝ qc qc',
          'inner ℝ qc (pbar+(h/2) • (-gradient U (initial h).1))/inner ℝ qc qc')
        change('PrimitiveDefect',code,'C','仅小正h、单位接触点及初态趋近接触点的首次单碰撞物理分支；系数使用原书碰前P̄（含半kick），不再用初始p冒充；保留O(h²)余项。')
        human[sid('EndImpactThirdOrderPrinted')]='原书末端碰撞三阶有反例，不能由无碰撞Verlet三阶推出；选项：原式仅存档／导师指定改变碰撞调度或法向势不变等受限修订。现状不尝试证明。'
        old=current('FreeHardSphereHamiltonian')
        change('FreeHardSphereHamiltonian','''def freeHardSphereHamiltonian {N d : ℕ} (m σ : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (q p : Fin N → Position d) : WithTop ℝ :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤
  else ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ)

theorem freeHardSphereHamiltonian_ballistic {N d : ℕ} (m : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (q p : Fin N → Position d) :
    (∀ t : ℝ, HasDerivAt (fun s ↦ fun i ↦ q i+(s/m i) • p i)
      (fun i ↦ (m i)⁻¹ • p i) t) ∧
    (∀ t : ℝ, HasDerivAt (fun _ : ℝ ↦ p) 0 t) := by
  sorry

'''+old.replace('def freeHardSphereHamiltonian ','def freeHardSphereHamiltonian_contactAllowed ',1),
          'C','忠实保留原印≤无穷势并显式正质量，接触允许物理版本另名存档；补非接触直线运动q′=M⁻¹p,p′=0，接触弹性反射由ElasticReflection/ElasticEnergy原有条目承担。',
          scope='原印自由硬球Hamiltonian、非接触弹道ODE；所引动力学中接触弹性反射关系及能量保存由MD-3.7-ElasticReflection和MD-3.7-ElasticEnergy承担。原印≤边界与接触允许物理版本独立命名。')
        pages=[155,156]
    elif section=='3.7.2':
        change('CollisionalVerletRelation',current('CollisionalVerletRelation')+'''

def particleQuadraticPath {N d : ℕ} (m : Fin N → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (z : (Fin N → Position d) × (Fin N → Position d)) (t : ℝ) : Fin N → Position d :=
  fun i ↦ z.1 i+(t/m i) • z.2 i+(t^2/(2*m i)) • F z.1 i

def particleVerlet {N d : ℕ} (m : Fin N → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (h : ℝ) (z : (Fin N → Position d) × (Fin N → Position d)) :=
  let P := z.2+(h/2) • F z.1
  let Q := fun i ↦ z.1 i+(h/m i) • P i
  (Q,P+(h/2) • F Q)

def particleReflection {N d : ℕ} (m : Fin N → ℝ) (i j : Fin N)
    (z : (Fin N → Position d) × (Fin N → Position d)) :=
  let u : Fin N → Position d := fun a ↦ if a=i then z.1 i-z.1 j
    else if a=j then z.1 j-z.1 i else 0
  let α := -2*(∑ a, inner ℝ (u a) (z.2 a)/m a)/(∑ a, ‖u a‖^2/m a)
  (z.1,z.2+α • u)

def physicalCVARelation {N d : ℕ} (m σ : Fin N → ℝ)
    (U : (Fin N → Position d) → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (event : Option (ℝ × (Fin N × Fin N))) (hmax h : ℝ)
    (z w : (Fin N → Position d) × (Fin N → Position d)) : Prop :=
  (∀ i, 0 < m i ∧ 0 < σ i) ∧ Differentiable ℝ U ∧
  (∀ q ξ, fderiv ℝ U q ξ = -∑ i, inner ℝ (F q i) (ξ i)) ∧
  (∀ i j, i ≠ j → σ i+σ j ≤ ‖z.1 i-z.1 j‖) ∧ 0 < hmax ∧
  match event with
  | none =>
    (∀ t > 0, ∀ i j, i ≠ j → σ i+σ j <
      ‖particleQuadraticPath m F z t i-particleQuadraticPath m F z t j‖) ∧
    h=hmax ∧ w=particleVerlet m F h z
  | some (tc,(i,j)) =>
    0 < tc ∧ i ≠ j ∧
    ‖particleQuadraticPath m F z tc i-particleQuadraticPath m F z tc j‖=σ i+σ j ∧
    (∀ t ∈ Ioo 0 tc, ∀ a b, a ≠ b → σ a+σ b <
      ‖particleQuadraticPath m F z t a-particleQuadraticPath m F z t b‖) ∧
    (∀ a b, a ≠ b → (a,b) ≠ (i,j) → (a,b) ≠ (j,i) →
      σ a+σ b < ‖particleQuadraticPath m F z tc a-particleQuadraticPath m F z tc b‖) ∧
    h=min tc hmax ∧ w=if tc<hmax then particleReflection m i j (particleVerlet m F h z)
      else particleVerlet m F h z''','A','保留给定tc/Rc的更新辅助；补实际粒子二次路径、正质量/半径、F=−∇U的对偶资格、不同粒子对的最早真实接触、唯一单碰撞及该接触面的质量加权弹性反射。Option.none明确无正根；严格tc<hmax及等号else照原印保留，不静默修改算法。')
        human[sid('CollisionalVerletOrder')]='原二阶需先选同时间位置/相空间还是时间对齐误差，并修复参考轨迹端点及碰后值、实际首根/无根分支；选项：指定物理右连续轨迹和指标后重述受限二阶／将现时间对齐界另列辅助。当前错误资格不能视为已修定理，保持现状。'
        pages=[157,158]
    elif section=='3.7.3':
        human[sid('PairForceDecoupling')]='原文字说第二项β的接触导数为零，展示却写α′=0；选项：批准β为kick且β′(σi+σj)=0／按展示式调整分工并同步算法。需导师裁定，保持原句与定义。'
        human[sid('DecoupledOrder')]='原书是α二次Verlet检测加碰撞点β kick，当前精确子流Strang对象不同；选项：导师先裁定α/β后完整指定原CVA混合算法及物理单侧轨迹／保留当前方法为另名辅助。保持现状，不能以精确子流法代替原算法。'
        pages=[158]
    else:raise ValueError(section)
    run_batches(section,edits,human,pages,refresh)

def run_batches(section,edits,human,pages,refresh=()):
    sources=read(ROOT/'blueprint/ch03/ch03_source.json');web={w['source_id']:w for w in read(ROOT/'blueprint/ch03/website_audit.json')}
    source_only=[s['source_id'] for s in sources if s['section']==section and s['source_id'] not in edits and s['source_id'] not in human and
      (s['source_id'] in refresh or (web[s['source_id']]['json_review']['status']=='CORRECTED' and not web[s['source_id']].get('repair',{}).get('json_review_locally_verified')))]
    touched=set(edits)|set(human)|set(source_only);ids=[s['source_id'] for s in sources if s['source_id'] in touched]
    if not ids:return
    existing=[int(p.name[6:]) for p in (ROOT/'blueprint/ch03/validation').glob('EAUDIT[0-9][0-9]')]
    number=max(existing,default=1)+1;eaudits=[]
    for start in range(0,len(ids),8):
        chunk=set(ids[start:start+8]);e=f'EAUDIT{number:02}';number+=1
        prepare(3,e,section,{k:v for k,v in edits.items() if k in chunk},pages=pages,
          source_only=[k for k in source_only if k in chunk],human={k:v for k,v in human.items() if k in chunk})
        verify(3,e);eaudits.append(e)
    commit_section(3,section,eaudits)

if __name__=='__main__':
    import sys
    run(sys.argv[1])
