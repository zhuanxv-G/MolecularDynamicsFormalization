"""Ch05 signature/source repairs, without new proofs or erratum decisions."""
from website_repair_batch import prepare,verify,commit_section
from integrate_website_returns import ROOT,read
from eaudit_review_tasks import declarations

def run(section):
    ds=declarations(5);edits={};human={};refresh=[]
    def sid(k):return 'MD-'+section+'-'+k
    def current(k):return ds[sid(k)]['block']
    def change(k,code,category,note,**kw):edits[sid(k)]=dict(code=code,category=category,note=note,**kw)
    def scope(k,note):change(k,current(k),'B','显式逐句范围及跨source_id映射；原文保留，repair_log追加。'+note,scope=note)
    if section=='5.1':
        change('FlowFieldTransport',current('FlowFieldTransport')+'''

theorem flowFieldTransport_observable (n : ℕ)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hΦ : ContDiff ℝ 2 (Function.uncurry Φ))
    (g : MolecularDynamics.Chapter05Review.E n → ℝ) (_hg : ContDiff ℝ 1 g) (t : ℝ)
    (z : MolecularDynamics.Chapter05Review.E n) :
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=
      (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z)) ∧
    (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z))=
      (fderiv ℝ g (Φ t z)) (f (Φ t z)) ∧
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=
      MolecularDynamics.Chapter05Review.lie f g (Φ t z) := by
  sorry''','B','补可观测量g、链式中间式及完整Lie拉回输运等式，保留原向量场输运引理。联合C²与g为C¹标为充分资格。')
        change('SolutionOperator','''def solutionOperator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (g : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.pullback Φ g t

theorem solutionOperator_initial {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (hf : MolecularDynamics.Chapter05Review.flow f Φ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) :
    solutionOperator f Φ hf 0 g=g := by
  sorry''','A','主定义加入实际自治流资格，补G₀g=g接口；e^(tL)作为该实际流拉回的记号，不构造无界算子级数。')
        pages=[201,202]
    elif section=='5.2.1':pages=[203,204,205]
    elif section=='5.2.2':
        change('MassDerivative',current('MassDerivative')+'''

theorem massDerivative_smooth (n : ℕ)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ)
    (A : Set (MolecularDynamics.Chapter05Review.E n))
    (_hA : MeasurableSet A) (_hc : IsCompact A)
    (_hρ : ContDiff ℝ ∞ (Function.uncurry ρ)) :
    ContDiff ℝ ∞ (MolecularDynamics.Chapter05Review.massFraction ρ A) := by
  sorry''','B','保留已证的一阶积分交换，补紧空间域和联合C∞密度下质量函数C∞结论；紧域给各阶局部支配的充分资格，非结论前提。')
        scope('Divergence','仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M_f w=−div(wf)由MD-5.2.2-Liouvillian承担。')
        scope('LiouvilleProduct','仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。')
        scope('DivergenceCoordinates','仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。')
        statement=ds['MD-5.2.2-LiouvilleEquation']['statement'].replace('theorem liouvilleEquation','theorem liouvilleProductCoordinates_evolution',1)
        statement=statement.replace('(MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z)',
          '(-(∑ i : Fin n,ρ t z*(fderiv ℝ (fun x ↦ f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+f z i*(fderiv ℝ (ρ t) z) (EuclideanSpace.basisFun (Fin n) ℝ i)))')
        change('LiouvilleProductCoordinates',current('LiouvilleProductCoordinates')+'\n\n'+statement+' := by\n  sorry','B','保留原坐标乘积法则证明，并以真实自治流、光滑密度和Measure.map输运条件补全部时间导数PDE；不把PDE作前提。')
        scope('FaceFlux','仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。')
        old=current('MeasurePropagator').replace('def measurePropagator','def measurePropagator_general',1)
        code='''def measurePropagator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) := Measure.map (Φ t) μ

'''+old+'\n\n'+ds['MD-5.2.2-LiouvilleEquation']['statement'].replace('theorem liouvilleEquation','theorem measurePropagator_density_evolution',1)+' := by\n  sorry'
        change('MeasurePropagator',code,'A','主接口限定实际自治流；保留一般Measure.map辅助定义，另列由实际初始密度推前得到的点态Liouville演化；ρ(0)是初值，形式指数作记号，不将PDE作为前提。')
        pages=[205,206,207]
    elif section=='5.2.3':pages=[207,208]
    elif section=='5.3.1':
        change('TestSpace',current('TestSpace').replace('ContDiff ℝ ⊤','ContDiff ℝ ∞'),'C','将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。')
        code=current('RegularDistributionLinearity').replace('ContDiff ℝ ⊤','ContDiff ℝ ∞')
        change('RegularDistributionLinearity',code,'C','将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。')
        pages=[209,210]
    elif section=='5.3.2':
        change('WeakStationary','''def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0''','C','Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。')
        human[sid('ConvergenceHeuristic')]='原句“condition is just that”是否必要且充分、现充分方向是否真由所列动力学背景保证，均需数学判断；一般导数趋零不能推出函数收敛。选项：补可检验谱/混合或可积导数条件后给严格版本／保留启发式与未覆盖方向。网站要求必要方向但未提供满足全前提的反例；保持原签名等待导师。'
        change('HamiltonianEnergyIntegral',current('HamiltonianEnergyIntegral')+'''

theorem hamiltonianEnergyIntegral_full (k : ℕ)
    (H u : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (_hH : ContDiff ℝ 2 H) (_hu : ContDiff ℝ 1 u)
    (z : MolecularDynamics.SymplecticCoordinates k)
    (γ : ℝ → MolecularDynamics.SymplecticCoordinates k) (a b : ℝ) (_hab : a ≤ b)
    (_hγ : ∀ t ∈ Icc a b,HasDerivWithinAt γ
      (MolecularDynamics.textbookHamiltonianVectorField H (γ t)) (Icc a b) t) :
    -(LinearMap.trace ℝ (MolecularDynamics.SymplecticCoordinates k)
      (fderiv ℝ (fun x ↦ u x • MolecularDynamics.textbookHamiltonianVectorField H x) z).toLinearMap)=
        -MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) u z ∧
    (∀ t ∈ Icc a b,H (γ t)=H (γ a)) := by
  sorry''','B','补真实Hamiltonian场的−div(u f)=−L_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L_fH=0，不把散度零/能量守恒当假设。')
        scope('ShellWeight','仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。')
        human[sid('ShellWeakPrinted')]='PDF212式(5.8)对已归一化ρ_ε再次乘Z_ε⁻¹，重复归一化；另有尾部条件与Liouville不变性范围问题。选项：确认删外层Z后的独立修正版（已有ShellWeakLimitCorrected）／按原印保留疑误。保持签名，不能以补证明处理错误极限。'
        scope('NormalEnergyTaylor','仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。')
        human[sid('PatchShellVolume')]='原印ΔV=∫ξdσ漏曲率Jacobian，一般仅渐近成立；例圆周外法线管体积还有二次项。选项：将精确式改为∫∫J ds dσ并把现O(e)目标独立标修正版／保留原印疑误。须导师判断来源路线，现签名保持。'
        human[sid('WholeShellVolumeLimit')]='当前是紧能量带控制下整面极限，原文范围含任意片与O(e)，相关PatchShellVolume原印精确等式又有Jacobian疑误；选项：导师确认将本条明确登记为该修正版的整面推论／另补完整片的修正陈述。保持当前签名，避免静默把一般原句降为整面特例。'
        human[sid('ShellPointValuePrinted')]='原印把依赖φ的标量配对写成分布ρ₀(q,p)点值且重复归一化；当前仅配对记号也不含极限。选项：保留原印疑误并独立绑定已修弱极限／确认完整分布配对规范。保持签名，等待导师来源解释。'
        change('HarmonicEnergy',current('HarmonicEnergy')+'''

theorem harmonicEnergy_ellipse (Ω c : ℝ) (_hΩ : Ω ≠ 0) (_hc : 0 < c)
    (z : MolecularDynamics.Chapter05Review.E 2) :
    harmonicEnergy Ω z=c ↔
      (z 0/(Real.sqrt (2*c)/|Ω|))^2+(z 1/Real.sqrt (2*c))^2=1 := by
  sorry''','B','补非零频率、正能量下能量面椭圆的完整等价式；质量为单位，原定义与坐标顺序保留。')
        human[sid('HarmonicQuadraturePrinted')]='原页第一积分上界√(2E)漏/Ω，之后两行才是√(2E)/Ω；Ω≠1时两积分不等。选项：导师确认更正第一上界并补完整积分链／保留原印疑误。保持字面签名，正确末两行由HarmonicPartition单列。'
        change('HarmonicPartition',current('HarmonicPartition')+'''

theorem harmonicPartition_quadrature (Ω c : ℝ) (_hΩ : 0 < Ω) (_hc : 0 < c) :
    MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=
      4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) ∧
    4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2))=2*Real.pi/Ω := by
  sorry''','B','保留真实曲面微正则质量终值，补其与正确参数积分的等式及该积分的终值；不更改原印首积分疑误。')
        scope('IdealGasPositionDomain','仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。')
        change('IdealGasPartition',current('IdealGasPartition')+'''

theorem idealGasPartition_factors (N : ℕ) (m c L : ℝ)
    (_hN : 0 < N) (_hm : 0 < m) (_hc : 0 < c) (_hL : 0 < L) :
    let S := Metric.sphere (0 : MolecularDynamics.Chapter05Review.E (3*N)) (Real.sqrt (2*m*c))
    let A := (MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1) S).toReal
    let Z := ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal
    Z=(L^3)^N*(∫ p in S,m/Real.sqrt (2*m*c)
      ∂(MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1))) ∧
    Z=(L^3)^N*(m/Real.sqrt (2*m*c))*A ∧
    Z=(L^3)^N*(Real.sqrt m/Real.sqrt (2*c))*
      ((3*N : ℝ)*Real.rpow Real.pi ((3*N : ℝ)/2)*Real.rpow (2*m*c) (((3*N : ℝ)-1)/2)/
      Real.Gamma ((3*N : ℝ)/2+1)) := by
  sorry''','B','补真实动量(3N−1)维球面S、r=√(2mc)、位置体积(L³)^N及面积/Gamma两项中间分解，保留原终值；不以参数积分作microRaw定义。')
        pages=[210,211,212,213,214,215]
    elif section=='5.3.3':
        change('LowerDimensionNull',current('LowerDimensionNull')+'''

theorem lowerDimensionNull_countable (n d : ℕ)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ)
    (g : ℕ → MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : ℕ → Set (MolecularDynamics.Chapter05Review.E d)) (_hd : d+1 < n)
    (_hH : ContDiff ℝ 1 H)
    (_hreg : ∀ z,MolecularDynamics.Chapter05Review.energySurface H c z →
      MolecularDynamics.Chapter05Review.grad H z ≠ 0)
    (_hblocks : ∀ k,ContDiff ℝ 1 (g k) ∧ IsCompact (K k) ∧
      g k '' K k ⊆ MolecularDynamics.Chapter05Review.energySurface H c) :
    (MolecularDynamics.Chapter05Review.microMeasure H c) (⋃ k,g k '' K k)=0 ∧
      volume (⋃ k,g k '' K k)=0 := by
  sorry

theorem lowerDimensionNull_level_dimension (n : ℕ) (_hn : 0 < n)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (_hH : ContDiff ℝ 1 H)
    (c : ℝ) (_hreg : ∀ z,H z=c → MolecularDynamics.Chapter05Review.grad H z ≠ 0) :
    ∀ z,H z=c → ∃ U : Set (MolecularDynamics.Chapter05Review.E n),
      IsOpen U ∧ z ∈ U ∧ ∃ V : Set (MolecularDynamics.Chapter05Review.E (n-1)),
      IsOpen V ∧ Nonempty (V ≃ₜ ↥(MolecularDynamics.Chapter05Review.energySurface H c ∩ U)) := by
  sorry''','B','保留紧面子引理，新增无需全能量面紧性的可数紧参数块零测推广，以及正则水平集局部同胚于开ℝ^(n−1)的维数结论（相空间n=2N_d）。环境Lebesgue零测也在本批同列。')
        change('MicroAverage',current('MicroAverage')+'''

theorem microAverage_surface_and_delta_limit (n : ℕ) (_hn : 0 < n)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (_hH : ContDiff ℝ 2 H)
    (c : ℝ) (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hband : ∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧
      ∀ z,|H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0)
    (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (_hφ : ContDiff ℝ ∞ φ)
    (_hc : HasCompactSupport φ) :
    microAverage H c φ=(MolecularDynamics.Chapter05Review.microPartition H c)⁻¹*
      (∫ z in MolecularDynamics.Chapter05Review.energySurface H c,
        φ z/‖MolecularDynamics.Chapter05Review.grad H z‖
        ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))) ∧
    Tendsto (fun ε : ℝ ↦
      (∫ z in {z | |H z-c| < ε},φ z)/
      (volume {z | |H z-c| < ε}).toReal) (𝓝[>] 0) (𝓝 (microAverage H c φ)) := by
  sorry''','B','补曲面限制逆梯度积分等式，并以真实对称薄壳积分比极限表达归一化δ配对；紧正则能量带控制尾部，不把δ当普通Lebesgue函数或同测度重命名。')
        pages=[215,216]
    elif section=='5.4':
        scope('TimeAverage','仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。')
        scope('ConservedAverage','仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。')
        scope('DoubleWellEnergy','仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。')
        change('DoubleWellBasin',current('DoubleWellBasin')+'''

theorem doubleWellBasin_average_witness (c : ℝ) (_hc : c ∈ Ioo (0 : ℝ) 1)
    (z : ℝ → MolecularDynamics.Chapter05Review.E 2) (_hz : Continuous z)
    (_hE : ∀ t,doubleWellEnergy (z t)=c) :
    let g := fun x : MolecularDynamics.Chapter05Review.E 2 ↦ if 0 < x 0 then (1 : ℝ) else 0
    MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g=1/2 ∧
    MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) ∧
    g (z 0) ≠ MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g := by
  sorry''','B','保留左右阱不变性，补可测有界右阱indicator的明确时间平均与对称真实微正则空间平均1/2不等见证；不预设最终平均不等。此处观测量明确为indicator（原句many quantities）。')
        pages=[216,217,218]
    elif section=='5.4.1':
        qualifications='''
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=
'''
        change('UniformMicroErgodic',current('UniformMicroErgodic').replace(' : Prop :=',qualifications,1),'A','明示C² Hamiltonian、常非退化反对称J生成的实际流、能量保持与正有限正则能量面背景；保留AE后∀可积光滑观测量的原量词顺序。')
        old=current('MicroErgodicStandard')
        main=current('UniformMicroErgodic').replace('def uniformMicroErgodic','def microErgodic',1).replace(' : Prop :=',qualifications,1)
        change('MicroErgodicStandard',main+'\n\n'+old.replace('def microErgodic','def microErgodic_L1_alternative',1),'C','主接口恢复原句共同AE后∀光滑可积观测量，实际Hamiltonian/概率背景显式；旧∀L¹后AE版本仅保留为标明的替代定义，等价连接在ErgodicTimeEquivalence补列。')
        change('FlowInvariant',current('FlowInvariant').replace('∀ t, Φ t', '∀ t,t ≠ 0 → Φ t'),'A','按原印精确限定t≠0；真实零时恒等流下等价全时间条件，不对任意Φ默加零时限制。')
        change('SetErgodic',current('SetErgodic').replace(' : Prop :=', '''
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hjoint : Measurable (Function.uncurry Φ)) : Prop :=''',1),'A','集合0/1定义限定概率测度、零时恒等、实际群律及联合可测流，排除任意测度/映射的伪遍历解释。')
        scope('InvariantIndicator','仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。')
        change('ErgodicTimeEquivalence',current('ErgodicTimeEquivalence')+'''

theorem ergodicTimeAverage_common_smooth (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n))
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hμ : IsProbabilityMeasure μ) (_hpres : ∀ t,MeasurePreserving (Φ t) μ μ)
    (_h0 : ∀ z,Φ 0 z=z) (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hΦ : Continuous (Function.uncurry Φ))
    (_hK : ∃ K : Set (MolecularDynamics.Chapter05Review.E n),IsCompact K ∧ μ Kᶜ=0) :
    (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
      ∀ᵐ z ∂μ,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
        ContDiff ℝ ∞ g → Integrable g μ →
          MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z) g
            (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

theorem ergodicTimeAverage_positive_invariant (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_herg : MolecularDynamics.Chapter05Review.setErgodic μ Φ)
    (A : Set (MolecularDynamics.Chapter05Review.E n)) (_hA : MeasurableSet A)
    (_hinv : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (_hpos : 0 < μ A) :
    μ A=1 ∧ (∀ z ∈ A,∀ t,Φ t z ∈ A) ∧
    (∀ z ∈ A,MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z)
      (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) 0) := by
  sorry''','B','保留标准L¹双向定理，补紧支持概率流上共同AE光滑定义的连接及正概率不变集分支/实际indicator平均，区分原定义与标准替代定义。')
        change('NonergodicSet',current('NonergodicSet')+'''

theorem nonergodicSet_average_witness (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (A : Set (MolecularDynamics.Chapter05Review.E n)) (_hA : MeasurableSet A)
    (_hinv : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (_hpos : 0 < μ A) (_hlt : μ A < 1) :
    (∀ z ∈ A,∀ t,Φ t z ∈ A) ∧
    (∀ z ∈ A,MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z)
      (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) 0) ∧
    MolecularDynamics.Chapter05Review.average μ (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) ≠ 0 := by
  sorry''','B','补中间概率不变集合内真实轨道保持、补集indicator无限平均零及空间平均非零的见证；可用于实际能量面概率流，不把不等式作假设。')
        scope('HarmonicFlow','仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。')
        scope('TwoOscillatorEnergy','仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。')
        scope('TwoOscillatorFlow','仅实际两振子解析流辅助定义；两分能量保持由MD-5.4.1-TwoOscillatorTori的正共同能量层结论承担，退化层范围在EnergyDecomposition与待导师原句中明列。')
        human[sid('TwoOscillatorTori')]='原句称整个正总能量面是正分能量二维环面之并，遗漏一个分能量为零的圆层；选项：导师确认补退化圆层/原点后重述／现条仅标正层特例并另列原印疑误。当前正层/稠密与非遍历签名保持。'
        scope('TwoOscillatorEnergyDecomposition','仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。')
        change('Mixing',current('Mixing').replace(' : Prop :=', ''' : Prop :=
  (IsProbabilityMeasure μ ∧ (∀ z,Φ 0 z=z) ∧
    (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) ∧ Measurable (Function.uncurry Φ)) ∧''',1),'A','混合定义在谓词内记录概率参考测度、零时恒等、群律、联合可测实际流；保留AC初始概率与有界连续测试配对。相关已有证明取第二合取后重查。')
        human[sid('KAMPersistence')]='现通用KAM命题不包含原双摆对象/参数和数值观察所需可核查非退化资格；选项：导师确认将通用KAM独立标背景并保留双摆经验描述／提供双摆可验证KAM资格后另立定理。不能把数值图像当作通用KAM实例，保持现状。'
        human[sid('AnisotropicAxisPrinted')]='原“径向力”解释与各向异性势不符，且全时间轨道可能穿过势不光滑原点；选项：远离原点的最大解域+唯一性下只证轴不变并把探索叙述列观察／导师确认其他修订。原签名保持。'
        human[sid('PendulumRegionPrinted')]='圆盘交替代真实距离等值导致一般区域等式错误；网站反例针对弹簧伸长/压缩与半径上界混淆。选项：改能量投影为{U≤c}并另述E=4数值观察／保留一般圆盘并原印疑误。需导师判断，签名不改。'
        human[sid('InitialSegmentPrinted')]='原书四维“line segment”实际初始动量sqrt(2(c−U(x,0)))通常非仿射；位置投影才为直线段。选项：确认相空间参数曲线勘误并给正根号光滑资格／保留原印线段疑误。保持现签名。'
        qualified=current('CircleInitialPoints').replace('(κ l ε c x θ : ℝ)', '''(κ l ε c x θ : ℝ)
    (_hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (_hx : x ∈ Icc (105/100 : ℝ) (115/100))''',1)
        change('CircleInitialPoints',qualified+'\n\n'+current('CircleInitialPoints').replace('def circleInitialPoints','def circleInitialPoints_total',1),'A','将实际初值域限定可行能量及原x区间；θ为后条均匀角分布的取样变量，定性样本图像不强化为全样本必然分离。零半径为允许退化；总延拓仅作独立辅助定义。')
        code=current('CircleInitialLaw').replace('(κ l ε c x : ℝ)', '''(κ l ε c x : ℝ)
    (hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (hx : x ∈ Icc (105/100 : ℝ) (115/100))''',1)
        code=code.replace('(circleInitialPoints κ l ε c x)','(fun θ ↦ circleInitialPoints κ l ε c x θ hfeas hx)')
        change('CircleInitialLaw',code,'A','均匀圆概率主接口限定可行能量和原x区间，使用归一化角测度推前；c=U为退化Dirac，不默认负能差的sqrt总化初值。')
        code=current('CircleInitialEnergy').replace('circleInitialPoints','circleInitialPoints_total')
        # Keep the old total extension theorem as an auxiliary; the qualified
        # public constructor above is the source-faithful input interface.
        change('CircleInitialEnergy',code,'A','原能量恒等式保留为正式库总延拓的辅助证明；本条适用前提仍是非负能差，实际取样主接口由CircleInitialPoints/Law限定区间及可行域。')
        pages=[218,219,220,221,222,223,224]
    elif section=='5.5':
        human[sid('CorrelationTimePrinted')]='原any trajectory超过通常遍历性的AE结论；例能量面内零测异常轨道不由AE排除。选项：导师确认原any改AE（已有CorrelationTimeAE）／另增明确全点动力学资格。保持原印签名，不能把目标等式作资格。'
        code=current('PositionTransition').replace('(t : ℝ) :=','(k t : ℝ) :=\n  k*',1)
        change('PositionTransition',code,'C','恢复相关定义中完整归一化常数k，原k=1未归一化概率计数作为明确实例；位置投影及两个indicator积分均保留。')
        change('MeasureDuality',current('MeasureDuality')+'''

theorem measureDuality_RN (n : ℕ)
    (ν : Measure (MolecularDynamics.Chapter05Review.E n)) (_hν : IsProbabilityMeasure ν)
    (r : MolecularDynamics.Chapter05Review.E n → ℝ) (_hr : Integrable r ν)
    (_hrpos : ∀ z,0 ≤ r z) (_hrmass : (∫ z,r z ∂ν)=1)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (t : ℝ) (_hΦ : Measurable (Φ t))
    (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (_hc : Continuous φ)
    (_hb : Bornology.IsBounded (range φ)) :
    let μ₀ := ν.withDensity (fun z ↦ ENNReal.ofReal (r z))
    MolecularDynamics.Chapter05Review.average (Measure.map (Φ t) μ₀) φ=
      MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t) ∧
    MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t)=
      ∫ z,φ (Φ t z)*r z ∂ν := by
  sorry''','B','保留推前对偶已有证明，补参考概率ν上的非负RN密度r、初始withDensity、演化Measure.map与全部加权配对链；公开ρ/ρ_E的RN解释，不对奇异δ作函数相除。')
        code=current('MixingMemoryLoss').replace('(hm β φ','(hm.2 β φ')
        change('MixingMemoryLoss',code,'A','对应补足资格后的weakMixing取第二合取，保持既有证明及原结论；不增加新证明。')
        human[sid('MixingCorrelationPrinted')]='原极限漏相关归一化k，取常数a=b=1,k=2，左极限2而右1。选项：导师确认补回k／明确k=1特例，另需向量观测量完整范围。保持原印签名，修订版MixingCorrelation独立保留。'
        scalar=current('MixingCorrelation').replace('theorem mixingCorrelation','theorem mixingCorrelation_scalar',1)
        vector=ds[sid('MixingCorrelation')]['statement'].replace('∀ n (μ','∀ n d (μ',1)
        vector=vector.replace('(a b : MolecularDynamics.Chapter05Review.E n → ℝ)','(a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d)',1)
        vector=vector.replace('k*(∫ z,a (Φ t z)*b z ∂μ)','k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)')
        vector=vector.replace('k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b','k*inner ℝ (∫ z,a z ∂μ) (∫ z,b z ∂μ)')
        change('MixingCorrelation',vector+' := by\n  sorry\n\n'+scalar,'B','修订版扩至任意有限维向量观测量并以Bochner均值及inner表达完整k相关极限；保留原标量证明为辅助，新向量结论暂sorry，原漏k版本单列待导师。')
        scalar=current('CenteredCorrelation').replace('theorem centeredCorrelation','theorem centeredCorrelation_scalar',1).replace('using mixingCorrelation ', 'using mixingCorrelation_scalar ')
        # The original proof invokes the scalar correlation theorem and the
        # mixing property; select the qualified predicate's second conjunct.
        scalar=scalar.replace('mixingCorrelation n','mixingCorrelation_scalar n').replace(' hΦ hm ', ' hΦ hm.2 ')
        vector=ds[sid('CenteredCorrelation')]['statement'].replace('∀ n (μ','∀ n d (μ',1)
        vector=vector.replace('(a b : MolecularDynamics.Chapter05Review.E n → ℝ)','(a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d)',1)
        vector=vector.replace('MolecularDynamics.Chapter05Review.average μ a=0 ∨ MolecularDynamics.Chapter05Review.average μ b=0','(∫ z,a z ∂μ)=0 ∨ (∫ z,b z ∂μ)=0')
        vector=vector.replace('k*(∫ z,a (Φ t z)*b z ∂μ)','k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)')
        change('CenteredCorrelation',vector+' := by\n  sorry\n\n'+scalar,'B','扩至向量观测量、任意一向量Bochner零均值及相关绝对值趋零，保留旧标量证明辅助；不添加单调衰减。')
        pages=[224,225,226]
    elif section=='5.6':
        scope('DiscreteAverage','仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。')
        change('DiscretePropagator',current('DiscretePropagator').replace('(G : X → X) (μ : Measure X)','(G : X → X) (_hG : Measurable G) (μ : Measure X)',1),'A','离散分布传播主接口显式限定可测G，避免不可测映射的Measure.map零总化被当概率推前。')
        change('ModifiedLiouvillian',current('ModifiedLiouvillian')+'''

def modifiedDensityEquation {n : ℕ}
    (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (h : ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  ∀ t z,HasDerivAt (fun s ↦ ρ s z)
    (MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) (ρ t) z) t

theorem modifiedLiouvillian_model_equivalence (n : ℕ)
    (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : Differentiable ℝ f) (_hfr : Differentiable ℝ fr)
    (h : ℝ) (r : ℕ) (hr : 1 ≤ r)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (_hρ : ∀ t,Differentiable ℝ (ρ t)) :
    modifiedDensityEquation f fr h r hr ρ ↔
      ∀ t z,HasDerivAt (fun s ↦ ρ s z)
        (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z+
          h^r*MolecularDynamics.Chapter05Review.liouvillian fr (ρ t) z) t := by
  sorry''','B','保留算子线性证明，并新增原文假设的修正模型PDE定义（r≥1），与展开右侧的等价式；仅定义模型及其算子展开，不声称任意空间可微ρ自动满足PDE。')
        human[sid('ForwardComponentsPrinted')]='原“两分量绝对值均趋无穷”假，h=1,z=(1,0)有无限多零分量；选项：导师确认替换成范数发散／保留原印疑误并单列谱与修正范数结论。保持原字面签名。'
        change('ForwardEnergyGrowth',current('ForwardEnergyGrowth')+'''

theorem forwardEnergyGrowth_spectrum (h : ℝ) (_hh : h ≠ 0) :
    let A : Matrix (Fin 2) (Fin 2) ℂ := !![1,(h : ℂ);-(h : ℂ),1]
    (∀ ζ : ℂ,(∃ v : Fin 2 → ℂ,v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔
      ζ=1+Complex.I*h ∨ ζ=1-Complex.I*h) ∧
    ‖(1 : ℂ)+Complex.I*h‖=Real.sqrt (1+h^2) ∧
    ‖(1 : ℂ)-Complex.I*h‖=Real.sqrt (1+h^2) ∧ 1 < Real.sqrt (1+h^2) := by
  sorry''','B','保留能量精确增长率并补原谱结论：两个复特征值恰为1±ih及模√(1+h²)>1，非零步长显式；不替换原两分量疑误。')
        scope('EulerInvariant','仅离散Euler唯一不变概率及非Dirac初始概率无弱概率极限（补列）；实际modified模型一步对应由MD-5.6-EulerLogCorrespondence，弱稳态唯一/非吸引由MD-5.6-ForwardWeakStationary承担。')
        change('EulerInvariant',current('EulerInvariant')+'''

theorem eulerInvariant_no_probability_limit (h : ℝ) (_hh : h ≠ 0)
    (μ : Measure (MolecularDynamics.Chapter05Review.E 2)) (_hμ : IsProbabilityMeasure μ)
    (_hne : μ ≠ MolecularDynamics.Chapter05Review.diracMeasure 2) :
    ¬∃ ν : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure ν ∧
      ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun k : ℕ ↦ ∫ z,φ ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) ∂μ)
          atTop (𝓝 (∫ z,φ z ∂ν)) := by
  sorry''','B','除离散唯一性再补非Dirac初始概率的离散推前无任何弱概率极限；连续modified模型/稳态/非吸引分别明确绑定EulerLogCorrespondence与ForwardWeakStationary。',scope=edits[sid('EulerInvariant')]['scope'])
        scope('BackwardEuler','仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。')
        change('BackwardEnergyDecay',current('BackwardEnergyDecay')+'''

theorem backwardEnergyDecay_spectrum (h : ℝ) (_hh : h ≠ 0) :
    let A : Matrix (Fin 2) (Fin 2) ℂ := !![1,(h : ℂ);-(h : ℂ),1]
    let B := ((1+h^2 : ℝ)⁻¹ : ℂ) • A
    (∀ ζ : ℂ,(∃ v : Fin 2 → ℂ,v ≠ 0 ∧ B *ᵥ v=ζ • v) ↔
      ζ=(1+Complex.I*h)/(1+h^2) ∨ ζ=(1-Complex.I*h)/(1+h^2)) ∧
    ‖((1 : ℂ)+Complex.I*h)/(1+h^2)‖=1/Real.sqrt (1+h^2) ∧
    ‖((1 : ℂ)-Complex.I*h)/(1+h^2)‖=1/Real.sqrt (1+h^2) ∧
    1/Real.sqrt (1+h^2) < 1 := by
  sorry''','B','保留能量衰减已有证明，补两个完整复特征值及模严格小于1；迭代趋零由BackwardEulerLimit，实际模型由EulerLogCorrespondence/BackwardWeakStationary承担。',scope='能量衰减与复谱/模；全部离散迭代趋零由MD-5.6-BackwardEulerLimit，连续模型对应和稳态由MD-5.6-EulerLogCorrespondence/BackwardWeakStationary承担。')
        scope('BackwardEulerLimit','仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。')
        scope('SymplecticEulerShadow','仅一步二次不变量辅助恒等式；全部k及合法稳定区椭圆/零退化由MD-5.6-SymplecticEulerEllipse，连续能量场稳态由MD-5.6-SymplecticWeakStationary承担。')
        change('SymplecticEulerEllipse',current('SymplecticEulerEllipse')+'''

theorem symplecticEulerEllipse_geometry (h : ℝ) (_hh : |h| < 2) :
    {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z=0}={0} ∧
    (∀ c : ℝ,0 < c → Nonempty
      (↥{z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z=c} ≃ₜ
        ↥(Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) := by
  sorry''','B','保留正定/全部k保持证明，并补正能级椭圆拓扑及零能级单点退化；二次不变量作为modified Hamiltonian的显式固定选择，实际场/流资格见SymplecticWeakStationary，不声称唯一修正能量。')
        scope('SymplecticEulerDensity','仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。')
        scope('PerturbationCorrection','仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。')
        scope('DenominatorBound','仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。')
        scope('SmoothDenominatorBound','仅C² H/连续w的横截分母下界一般化衍生引理；原光滑资格及完整公式由MD-5.6-Theorem51承担。')
        scope('ZeroPerturbation','仅η≡0校正量为零的后果；一般位移定义由MD-5.6-PerturbationDisplacement、完整平均误差由MD-5.6-Theorem51承担。')
        human[sid('ForwardNormDivergence')]='当前范数发散是正确独立修正版，但所引原句“两分量发散”有h=1无限零分量反例；选项：导师确认本条改为修正候选范围并保留原印Printed／继续只记疑误。保持已证范数签名，不冒称覆盖原两分量。'
        change('WeakStationary',current('WeakStationary').replace('MolecularDynamics.Chapter05Review.weakStationary f μ','weakStationary f μ'),'C','仅弱PDE技术谓词，实际使用Blueprint修正后的C∞测试空间；原唯一概率断言由MD-5.6-ForwardWeakStationary承担。',scope='从弱方程引用抽出的辅助技术定义；不是原书另立定义，唯一性结论由MD-5.6-ForwardWeakStationary承担。')
        scope('WeakAttractor','仅弱概率局部吸引的辅助技术定义；原负吸引性断言由MD-5.6-ForwardWeakStationary承担，不把定义本身当否定结论。')
        scope('EulerLogField','仅单位振子h>0时新增的精确对数场技术模型（h=0总延拓不用作物理解释）；实际一步/ODE对应由MD-5.6-EulerLogCorrespondence，唯一概率稳态由MD-5.6-ForwardWeakStationary承担。')
        scope('EulerLogFlow','仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。')
        pages=[227,228,229,230]
    else:raise ValueError(section)
    # C∞ in Lean/Mathlib 4.34 is scoped infinity, not the outer analytic top.
    # Every changed PASS entry is also explicitly requeued for website review.
    sources=read(ROOT/'blueprint/ch05/ch05_source.json')
    for source in sources:
        k=source['source_id']
        if source['section']!=section or k in human:continue
        code=edits[k]['code'] if k in edits else ds[k]['block']
        corrected=code.replace('ContDiff ℝ ⊤','ContDiff ℝ ∞').replace('ContDiffOn ℝ ⊤','ContDiffOn ℝ ∞')
        if section not in ['5.1','5.2.1','5.2.2','5.2.3','5.3.1']:
            corrected=corrected.replace('MolecularDynamics.Chapter05Review.testSpace','MD.Ch05.testSpace')
            corrected=corrected.replace('MolecularDynamics.Chapter05Review.weakStationary','MD.Ch05.weakStationary')
        if corrected!=code:
            if k in edits:
                edits[k]['code']=corrected;edits[k]['note']+=' 并恢复C∞而非Cω资格。'
            else:edits[k]=dict(code=corrected,category='C',note='恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。')
        if section not in ['5.1','5.2.1','5.2.2','5.2.3','5.3.1'] and 'weakStationary' in corrected:
            refresh.append(k)
    run_batches(section,edits,human,pages,refresh)

def run_batches(section,edits,human,pages,refresh=()):
    sources=read(ROOT/'blueprint/ch05/ch05_source.json');web={w['source_id']:w for w in read(ROOT/'blueprint/ch05/website_audit.json')}
    handled=lambda k: web[k].get('repair',{}).get('status') in ('awaiting_reaudit','awaiting_mentor')
    edits={k:v for k,v in edits.items() if not handled(k)};human={k:v for k,v in human.items() if not handled(k)}
    source_only=[s['source_id'] for s in sources if s['section']==section and s['source_id'] not in edits and s['source_id'] not in human and
      (s['source_id'] in refresh or (web[s['source_id']]['json_review']['status']=='CORRECTED' and not web[s['source_id']].get('repair',{}).get('json_review_locally_verified')) or
       (web[s['source_id']]['returned_audit']['verdict']=='NEEDS_HUMAN' and web[s['source_id']].get('needs_category')!='原文数学判断'))]
    touched=set(edits)|set(human)|set(source_only);ids=[s['source_id'] for s in sources if s['source_id'] in touched]
    if not ids:return
    existing=[int(p.name[6:]) for p in (ROOT/'blueprint/ch05/validation').glob('EAUDIT[0-9][0-9]')]
    number=max(existing,default=0)+1;eaudits=[]
    for start in range(0,len(ids),8):
        chunk=set(ids[start:start+8]);e=f'EAUDIT{number:02}';number+=1
        prepare(5,e,section,{k:v for k,v in edits.items() if k in chunk},pages=pages,
          source_only=[k for k in source_only if k in chunk],human={k:v for k,v in human.items() if k in chunk})
        verify(5,e);eaudits.append(e)
    commit_section(5,section,eaudits)

if __name__=='__main__':
    import sys
    run(sys.argv[1])
