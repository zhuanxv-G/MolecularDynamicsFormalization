from common import *

def primary(ch,sid):
 code=groups(ch)[sid]['code']
 matches=list(re.finditer(r'(?m)^(?:@\[[^\]]+\]\s*)?(?:noncomputable )?(theorem|def|lemma|abbrev)\s+(\w+)',code))
 assert matches,sid
 m=matches[0];end=matches[1].start() if len(matches)>1 else len(code)
 c=code[m.start():end].strip();c=re.split(r'\n/--',c)[0].strip()
 return m.group(1),m.group(2),c

def correction(ch,sid):
 kind,name,code=primary(ch,sid);newname=name+'_corrected'
 if kind in ['theorem','lemma']:
  signature=re.split(r'\s*:=\s*by\b',code,maxsplit=1)[0]
  new=re.sub(r'\b'+name+r'\b',newname,signature,count=1)+' := by\n  sorry'
 else:new=re.sub(r'\b'+name+r'\b',newname,code,count=1)
 note='将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。'
 custom=False;cross=None
 def change(a,b):
  nonlocal new,custom
  assert a in new,(sid,a);new=new.replace(a,b);custom=True
 key=sid.split('-')[-1]
 if ch==2:
  if key=='Admissible':
   new='''def admissibleSmooth_corrected {n : ℕ} (a b : ℝ) (x y : Q n) (q : ℝ → Q n) : Prop :=
  a < b ∧ ContDiffOn ℝ ∞ q (Icc a b) ∧ q a = x ∧ q b = y''';custom=True
   note='默认C∞区间版，补a<b；只对闭区间限制要求光滑，不强制任意全线代表光滑。C²与C∞的原文冲突保留导师选项。'
  elif key=='VariationalDerivativePrinted':
   change('F (q + ε • η) - ε * A η','F (q + ε • η) - F q - ε * A η')
   note='补被漏去的F(q)常项，保留逐方向O(ε²)及连续线性泛函，不将其混称一般Fréchet可微的必要条件。'
  elif key=='DiscreteStationaryPrinted':
   change('k ≤ ν','k < ν');note='双端点固定的驻值只变动0<k<ν内部节点，保留原印≤ν供比较。'
  elif key=='DiscreteAction':
   new='''def bp_discreteAction_corrected {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (_hh : 0 < h) (ν : ℕ) : ℝ :=
  ∑ k ∈ Finset.range ν, h*((∑ i, m i*((q (k+1) i-q k i)/h)^2)/2-U (q k))''';custom=True
   note='按原展示式采用动能−U的机械离散作用量，并限制h>0；正文+U原印保留。Riemann收敛只作背景，未给极限定理。'
  elif key=='DefectPrinted':
   change('(γ h).1-\n      h^3/6','(γ h).1+\n      h^3/6');note='位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。'
  elif key=='IntegralErrorPrinted':
   change('(K*B/(2*L))','(K*B/L)');note='由给定点误差只推出KB/L，去掉不成立的因子1/2，不加倍K也不预设待证积分误差。'
  elif key=='VariationalPrinted':
   change('(fun y => Φ (s,y)) (Φ (s,ζ))','(fun y => Φ (s,y)) ζ')
   change('(fun y => Φ (t,y)) (Φ (t,ζ))','(fun y => Φ (t,y)) ζ')
   change('flowC1 f Φ τ →','flowC1 f Φ τ → ContDiff ℝ 2 Φ →\n    (∀ t ∈ Ioo 0 τ, (textbookCoordinateJacobian (fun y => Φ (t,y)) ζ).det ≠ 0) →')
   note='Jacobian在固定初值ζ求值；联合C²及变分矩阵非奇异作为显式充分资格，Df仍在真实轨道点求值。'
  elif key=='HamiltonVariationalPrinted':
   change('ContDiff ℝ 1 Φ','ContDiff ℝ 2 Φ')
   change('(fun y => Φ (s,y)) (Φ (s,ζ))','(fun y => Φ (s,y)) ζ')
   change('(fun y => Φ (t,y)) (Φ (t,ζ))','(fun y => Φ (t,y)) ζ')
   note='固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。'
  elif key=='EulerVolumePrinted':
   change('(linearEuler S h).det=1','|(linearEuler S h).det|=1');note='标准无向体积的判据为绝对行列式1；原det=1不作必要条件。'
  elif key=='GlobalGroupPrinted':
   new='''theorem globalGroupPrinted_corrected (n : ℕ)
    (e : SymplecticCoordinates n ≃ SymplecticCoordinates n)
    (he : IsTextbookSymplecticMap e) (hi : ContDiff ℝ 1 e.symm) :
    IsTextbookSymplecticMap e.symm := by
  sorry''';custom=True
   note='只对已给全局双射且逆C¹的辛微分同胚断言逆辛；逐点非奇异不推出任意保辛自映射全局满射。'
  elif key=='Adjoint':
   note='把负步映射明示为Equiv可逆映射后定义伴随；不把任意数值积分器无条件当作全局可逆。原书any表述和Euler反例保留。'
  elif key=='RKSymplectic':
   change(') ↔',') →');note='保留系数条件的充分方向，删除对可约Butcher表不成立的必要性；未建设不可约表理论。'
  elif key=='NewmarkReduction':
   change('newmarkRelation m F','newmarkMassCorrected m F');note='采用显式质量一致Newmark关系，再与Verlet对应；原漏质量公式及反例保留。'
  elif key=='TIForce':
   change('-grad U q - (h^2/12)','-grad U q + (h^2/12)');note='保留负号改势，负梯度力修正项应为加号；未改原书展示式。'
  elif key=='BeemanOrder':
   change('≤ C*(τ/ν)^3','≤ C*(τ/ν)^2');note='全相空间有限时间收敛修正为二阶；原three的其它阶概念待导师，二阶正向估计尚需证明。'
  elif key=='TIPotential':
   new='''def tiMethod_corrected {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ)
    (_hm : positiveMass m) (_hU : ContDiff ℝ 2 U) (h : ℝ) : Z n → Z n :=
  verlet m (fun q => -grad (takahashiPotential m U h) q) h''';custom=True
   note='选择原负号改势路线，物理包装明示正质量和C²势；力式修正的加号在TIForce_corrected中另列。'
 elif ch==3:
  if key=='EndImpactThirdOrderPrinted':
   change('qc ≠ 0 →','qc ≠ 0 → Tendsto (fun h => (initial h).1) (𝓝[>] 0) (𝓝 qc) →')
   change('≤ C*h^3','≤ C*h')
   note='原末端碰撞三阶能量断言有反例；对接近接触点的初值族只给一阶上界，新增趋近资格排除隐式方程的远端分支，不声称二阶或三阶。'
  elif key=='EnergySymplecticNoGo':
   # State the safe local consequence; the global time-reparametrisation needs extra hypotheses.
   new='''theorem energySymplecticNoGo_corrected (n : ℕ)
    (H : SymplecticCoordinates n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (z : SymplecticCoordinates n) (hH : DifferentiableAt ℝ H (G z))
    (hG : DifferentiableAt ℝ G z) (hE : H ∘ G = H) :
    fderiv ℝ H z = (fderiv ℝ H (G z)).comp (fderiv ℝ G z) := by
  simpa only [hE] using (fderiv_comp z hH hG)''';custom=True
   note='只给能量保持的局部微分链式约束；一般全域时间重参数结论仍须连通能量层、局部流域与一致时间窗资格，保留为未覆盖问题，未拿此局部式充当原全局结论。'
  elif key=='VerletModifiedHamiltonian':
   new=code.replace(name,newname,1)
   note='这份独立表达式只按机械二次动能解释，不能用于一般非二次T；机械匹配见verletModifiedMatching_corrected。一般T的h⁴公式尚待导师，不声称本通用函数对任意T正确。'
  elif key=='VerletModifiedMatching':
   new=code.split('\ntheorem verletModifiedMatching_general',1)[0].split(' := by',1)[0].replace(name,newname,1)+' := by\n  sorry';custom=True
   note='独立修正版仅保留正质量机械二次动能的有限匹配，不复制一般T的有疑h⁴结论。标量h⁴另有独立系数核对。'
  elif key in ['FiniteLieTaylor','FlowCoordinates','BCHHamiltonianMatching','LeadingShadowHamiltonian','TakahashiEffectiveOrder']:
   if 'ContDiff' in new:
    new=new.replace('ContDiff ℝ ⊤','ContDiff ℝ ∞').replace('ContDiffOn ℝ ⊤','ContDiffOn ℝ ∞');custom=True
   if key in ['BCHHamiltonianMatching','LeadingShadowHamiltonian']:
    note='默认保留状态复合Φ_h∘Ψ_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL_B)exp(hL_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。'
  elif key=='DifferentLogsCommute':
   change('(s t : ℝ),','(s t : ℝ), A*B=B*A →');note='仅在A、B交换这一明示充分条件下给不同步长log交换；不使用原书一般交换断言证明奇性。'
  elif key=='ProcessorEnergyPrinted':
   change('quadraticKinetic m z.2+h^2/12','mechanicalEnergy m U z+h^2/12');note='首界补回遗漏势能U(q)，把T改成H；其余统一余项资格和第二界不变。'
  elif key=='PartitionedAffinePrinted':
   change('partitionedRKRelation f Aq Ap bq bp h z w F →','Aq=Ap → bq=bp → partitionedRKRelation f Aq Ap bq bp h z w F →')
   note='默认两套PRK表相同退化为普通相空间RK，才允许任意混合可逆线性变换；保持分区的更一般版本独立保留。'
  elif key=='ConjugateOrderPrinted':
   change('0 < r → IsCompact B →','0 < r → IsCompact B →\n      (∃ L ≥ 0, ∀ x y, ‖χ x-χ y‖ ≤ L*‖x-y‖) →')
   note='补运输映射的全局Lipschitz充分资格；只给单向局部误差阶运输，不声称全部effective order、性能或稳定性。'
  elif key=='PairForceDecoupling':
   change('(∀ r, φ r=α r+β r) ∧ deriv α contact=0','(∀ r, φ r=α r+β r) ∧ DifferentiableAt ℝ α contact ∧ deriv α contact=0')
   note='明确α为kick势并补接触点可微，deriv α contact=0才作为经典零接触力；α/β文字冲突保留导师选项。'
  elif key in ['PrimitiveOrder','CollisionalVerletOrder','DecoupledOrder']:
   new=new.replace('finiteCollisionTrajectory m (fun x => -grad U x) g q p 0 τ events',
     'finiteCollisionTrajectory_corrected m (fun x => -grad U x) g q p τ events')
   new=new.replace('finiteCollisionTrajectory m (fun x => -grad U x-grad V x) g q p 0 τ events',
     'finiteCollisionTrajectory_corrected m (fun x => -grad U x-grad V x) g q p τ events')
   new=new.replace('ContDiff ℝ ⊤','ContDiff ℝ ∞');custom=True
   if key=='PrimitiveOrder':
    new='''def finiteCollisionTrajectory_corrected {n : ℕ} (m : Fin n → ℝ)
    (F : Q n → Q n) (g : Q n → ℝ) (q p : ℝ → Q n) (τ : ℝ) (events : Finset ℝ) : Prop :=
  finiteCollisionTrajectory m F g q p 0 τ events ∧
  admissibleCollisionState m g (q 0,p 0) ∧ 0 < g (q τ) ∧
  Tendsto p (𝓝[>] 0) (𝓝 (p 0)) ∧ Tendsto p (𝓝[<] τ) (𝓝 (p τ)) ∧
  (∀ t ∈ Ico 0 τ, Tendsto p (𝓝[>] t) (𝓝 (p t))) ∧
  (∀ t ∈ Ioo 0 τ, g (q t)=0 ↔ t ∈ events) ∧
  (∀ t ∈ events, grad g (q t) ≠ 0)

'''+new
   elif key=='DecoupledOrder':
    new=new.replace('(∀ z, 0 ≤ g z.1 → ∀ T > 0, ∃ ev,',
     '(∀ z, 0 ≤ g z.1 → (∀ t ≥ 0, Tendsto (fun s => (Gfree s z).2) (𝓝[>] t) (𝓝 ((Gfree t z).2)))) →\n    (∀ z, 0 ≤ g z.1 → ∀ T > 0, ∃ ev,')
   elif key=='CollisionalVerletOrder':
    new=new.replace('(∀ z, Rc z=',
     '(∀ z, admissibleCollisionState m g z →\n      ∑ i, grad g (collisionQuadraticPath m (fun x => -grad U x) z (tc z)) i *\n        invMass m (z.2+(tc z) • (-grad U z.1)) i < 0) →\n    (∀ z, Rc z=')
   note='限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。'
  elif key=='HardCorePotential':
   new='''def hardCorePotential_corrected {N d : ℕ} (σ : Fin N → ℝ)
    (_hσ : ∀ i, 0 ≤ σ i) (q : Fin N → Position d) : ENNReal :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ < σ i+σ j then ⊤ else 0''';custom=True
   note='允许接触等号，只有严格重叠才取∞；原印≤判∞独立保留。'
  elif key=='ScalarVerletShadow4':return '',name+'_corrected','h⁴系数已独立核对；见SHADOW4_ALGEBRA及匹配修正版。',True,None
 elif ch==4:
  if key=='PRKThreshold':
   new='''theorem prkThreshold_corrected (Ω h : ℝ) (_hΩ : 0 < Ω) (_hh : 0 < h)
    (_hst : h*Ω < 4) :
    MolecularDynamics.Chapter04Review.matrixStable
      ((MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω (h/2))^2) := by
  sorry''';custom=True
   note='删除一般多级PRK的普遍阈值2，只给反例所用两个半步辛Euler的实际稳定区0<hΩ<4；未对所有PRK给新的最优阈值。'
  elif key=='ComponentPrinted':
   new=code.replace(name,newname,1).replace('(Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) ','').replace('(Gsup1 j)','(MolecularDynamics.Chapter04Review.grad (g j) q)');custom=True
   note='把一般分量式分母中的G_j^1明确改为当前约束在旧点的梯度G_n^j，与分子所用方向一致；原Gsup1参数版完整保留。'
  elif key=='ProjectionScale':
   note='独立限定版本采用原印负号预测器，并要求初态满足位置及隐藏余切约束、Gram非奇异、C²根分支且η(0)=0；只有位置约束不保证O(h²)。翻译预测器符号修复与原书缺相容性问题分开。'
  elif key=='DLMPrinted':
   note='独立保留单位质量的印刷算法解释，质量取1才将Drift写成q+hp；Spin仍按印刷约定，仅解释该组合定义，不称其为一般质量或π×ω原动力学的一致子流。质量修订和轴流符号另列工作版本。'
  elif key=='ConstraintSet':
   target=groups(4)[sid]['code'].split('\ntheorem constraintSet_regularLevel',1)[1]
   new='theorem constraintSet_corrected'+target.split(' := by',1)[0]+' := by\n  sorry';custom=True
   note='修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。'
  elif key in ['SymplecticEulerBoundaryPrinted','VerletBoundaryPrinted']:
   change('h*Ω ≤ 2','h*Ω < 2');note='幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。'
  elif key=='ResonanceEigenPrinted':
   change('Real.sqrt (|(Real.pi/Ω)*(h-Real.pi/Ω)|/2)','Real.sqrt (|(Real.pi/Ω)*(h-Real.pi/Ω)|)');note='去掉平方根内错误因子1/2；本独立修正版仅一支特征根估计，完整双支谱分解列覆盖缺口。'
  elif key=='RotationDerivativePrinted':
   change('(d *ᵥ δ)','(Θ t *ᵥ δ)');note='右端末因子从Θ̇δ改为Θδ，恢复Θ̇δ=(Θ̇Θᵀ)(Θδ)。'
  elif key=='InertiaTracePrinted':
   change('(MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace •','((MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace/2) •');note='二阶矩与惯性张量关系的trace(T)系数修正为1/2；原式保留。'
  elif key=='DipolarRotationalPrinted':
   change('  ∑ i,','  (1/2 : ℝ) * ∑ i,');note='转动动能补系数1/2；R应按trace(T)/2·I−T解释并与InertiaTracePrinted_corrected共同核查。'
  elif key=='SecondAxisPrinted':
   change('(a : ℝ)','(_hI : 0 < I 1)');change('a/I 1','π 1/I 1');note='将未定义标量a绑定第二动量分量π₂，补正主惯量；原无下标π保留。'
  elif key=='ThirdAxisPrinted':
   change('(a : ℝ)','(_hI : 0 < I 2)');change('a/I 2','π 2/I 2');note='将未定义标量a绑定第三动量分量π₃，补正主惯量；原无下标π保留。'
  elif key=='FrozenGramPrinted':
   change('textbookConstraintGram m g q','textbookConstraintJacobian g base * textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ')
   note='真实残差Jacobian为新预测点/旧点的交叉矩阵，不无条件等于旧点Gram或对称矩阵。'
  elif key=='RestraintForcePrinted':
   new='''def restraintForcePrinted_corrected (ε r₀ : ℝ) (_hε : 0 < ε) (q : Position 3) : Position 3 :=
  -gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q''';custom=True
   note='独立定义物理恢复力为势能负梯度；不保留原书把标量势与向量力相等的类型混淆为可证定理。'
  elif key=='AxisFlowFormal':
   target=groups(4)['MD-4.4.1-ExactPlanarRotation']['code'];new=target.split(' := by',1)[0].replace('theorem exactPlanarRotation','theorem axisFlow_corrected')+' := by\n  sorry';custom=True
   note='采用负角旋转子流，独立给初值、轴分量恒定及π×ω的ODE，正角Printed算法保留。'
 elif ch==5:
  if key=='ConvergenceHeuristic':
   new='''theorem convergenceHeuristic_corrected (A : ℝ → ℝ)
    (_hA : ContDiff ℝ 1 A) (_hint : IntegrableOn (deriv A) (Ici (0 : ℝ))) :
    ∃ L : ℝ, Tendsto A atTop (𝓝 L) := by
  sorry''';custom=True
   note='导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。'
  elif key=='MicroMeasure':
   new='''def microMeasure_corrected {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ)
    (_hpos : 0 < (MolecularDynamics.Chapter05Review.microRaw H c) univ)
    (_hfinite : (MolecularDynamics.Chapter05Review.microRaw H c) univ < ⊤) :
    Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c''';custom=True
   note='归一化主接口显式要求原始质量正且有限；任意H,c的总化公式仍保留为原辅助，不声称退化能级也是概率分布。'
  elif key=='MixingCorrelationPrinted':
   target=groups(5)['MD-5.5-MixingCorrelation']['code'];new=target.split(' := by',1)[0].replace('theorem mixingCorrelation','theorem mixingCorrelationPrinted_corrected',1)+' := by\n  sorry';custom=True
   note='独立修正版恢复任意向量维数及k因子，给有界连续向量观测量的内积均值极限；无k实值原式独立保留。'
  elif key=='DomainL2':note='明确采用Lebesgue可测函数按几乎处处相等取商的Lp空间；原生函数集合不直接宣称为Hilbert空间。'
  elif key=='HarmonicQuadraturePrinted':
   change('in (0 : ℝ)..Real.sqrt (2*c),','in (0 : ℝ)..Real.sqrt (2*c)/Ω,');note='首积分上界补/Ω，后续积分及microPartition由HarmonicPartition配套声明；原印上界不改。'
  elif key=='ShellWeakPrinted':
   change('(MolecularDynamics.Chapter05Review.shellPartition H c ε)⁻¹*','')
   change('ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →','ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →\n  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧\n    ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) →')
   note='删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。'
  elif key=='MixingCorrelationPrinted':
   change('average μ a*MolecularDynamics.Chapter05Review.average μ b','average μ a*MolecularDynamics.Chapter05Review.average μ b') if False else None
   change('(𝓝 (MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b))','(𝓝 (k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b))')
   note='右端补回k；向量版完整结论保留于MixingCorrelation，原无k字面式不证明。'
  elif key=='ForwardComponentsPrinted':
   target=groups(5)['MD-5.6-ForwardNormDivergence']['code'];new=target.split(' := by',1)[0].replace('theorem forwardNormDivergence','theorem forwardComponentsPrinted_corrected')+' := by\n  sorry';custom=True
   note='两分量各自发散修正为非零初值的范数发散；原分量断言的旋转反例保留。'
  elif key=='CorrelationTimePrinted':
   change('∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,','∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,')
   change('MolecularDynamics.Chapter05Review.microErgodic H c Φ →','MolecularDynamics.Chapter05Review.regularEnergy H c →\n  MolecularDynamics.Chapter05Review.microErgodic H c Φ →')
   note='any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。'
  elif key=='AnisotropicAxisPrinted':
   change('(z 0).1 1=0 →','(∀ t, (z t).1 ≠ 0) → (z 0).1 1=0 →')
   note='只在整条经典轨道避开原点的光滑域内给轴不变性；原点的范数势不可微资格不能省去。'
  elif key=='InitialSegmentPrinted':
   new='''def initialSegmentPrinted_corrected (κ l ε c : ℝ) : Set (MolecularDynamics.Chapter05Review.Phase 2) :=
  anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)''';custom=True
   note='四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。'
  elif key=='PendulumRegionPrinted':
   new='''theorem pendulumRegionPrinted_corrected (k₁ k₂ l₁ l₂ c : ℝ) :
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ p : MolecularDynamics.Chapter05Review.E 2,
    ((p 0)^2+(p 1)^2)/2+pendulumPotential k₁ k₂ l₁ l₂ q=c} =
  {q : MolecularDynamics.Chapter05Review.E 2 | pendulumPotential k₁ k₂ l₁ l₂ q ≤ c} := by
  sorry''';custom=True
   note='能量面的位置投影修正为势能次水平集，删除不成立的一般圆盘并参数化。'
 # The independent existing qualified theorem can be used only when its old axiom audit is clean.
 audit=load(base(ch)/'local_audit.json')['items'][sid]
 if not custom and kind in ['theorem','lemma'] and not any('sorryAx' in a for a in audit.get('axioms',[])) and not re.search(r'\bsorry\b',code):
  new=re.sub(r'\b'+name+r'\b',newname,code,count=1)
 return new,newname,note,custom,cross

