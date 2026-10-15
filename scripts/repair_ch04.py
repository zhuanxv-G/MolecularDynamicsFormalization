"""Explicit Ch04 website repairs; no new proofs and no erratum choices."""
from website_repair_batch import prepare,verify,commit_section
from integrate_website_returns import ROOT,read
from eaudit_review_tasks import declarations

def run(section):
    ds=declarations(4);edits={};human={};refresh=[]
    def sid(k):return 'MD-'+section+'-'+k
    def current(k):return ds[sid(k)]['block']
    def change(k,code,category,note,**kw):edits[sid(k)]=dict(code=code,category=category,note=note,**kw)
    if section=='4':
        change('EulerImaginaryGrowth',current('EulerImaginaryGrowth')+'''

theorem eulerImaginaryGrowth_rate (h Ω : ℝ) (_hh : h ≠ 0) (_hΩ : Ω ≠ 0) :
    let r := Real.sqrt (1+(h*Ω)^2)
    1 < r ∧ (∀ (z : ℂ) (k : ℕ),
      ‖(MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))^k*z‖=r^k*‖z‖) ∧
    (∀ (v : Fin 2 → ℝ) (k : ℕ),
      let w := (1+h • MolecularDynamics.Chapter04Review.oscillatorMatrix Ω)^k *ᵥ v
      Real.sqrt (Ω^2*(w 0)^2+(w 1)^2)=
        r^k*Real.sqrt (Ω^2*(v 0)^2+(v 1)^2)) := by
  sorry''','B','保留已证趋无穷，并补精确指数率r>1和实际实振子Euler轨道的加权范数等式；矩阵完整复谱已由MD-4-OscillatorSpectrum单列承担，原ω=Ω。非零步长/频率为[EXTRA]资格，新结论暂sorry。',scope='本条覆盖Euler的标量/实轨道指数增长；振子完整谱由MD-4-OscillatorSpectrum承担，未删原句。')
        change('SymplecticEulerCharacteristic',current('SymplecticEulerCharacteristic'),'B','本条仅为特征多项式辅助计算；原完整两个复根（含零/负判别式及重根）已由MD-4-SymplecticEulerRoots明确承担，跨条目范围写明，保留原文。',scope='仅特征多项式辅助等式；原展示特征值的完整等价结论由MD-4-SymplecticEulerRoots承担。')
        human[sid('PRKThreshold')]='两次半步显式辛PRK的稳定阈值可达4/Ω，反驳未按阶段成本归一化的全类最大2/Ω；选项：核对原参考[74]的方法类/成本归一化后重述／保留原印为疑误。需导师判断，现签名不改。'
        for k in ['SymplecticEulerBoundaryPrinted','VerletBoundaryPrinted']:
            human[sid(k)]='原印≤端点发生非平凡Jordan块并线性无界；选项：将幂有界域改为严格内区间／保留≤但结论仅谱模1。原印问题保持，等待导师裁定。'
        change('VerletStability',current('VerletStability')+'''

theorem verletStability_zero (Ω : ℝ) :
    MolecularDynamics.Chapter04Review.matrixStable
      (MolecularDynamics.Chapter04Review.verletMatrix Ω 0) := by
  sorry''','A','本条明确是严格稳定内区间的修订版本，另补h=0分支；原印含端点结论保留MD-4-VerletBoundaryPrinted待导师，不宣称与原句等价。',scope='显式修订的严格稳定内区间及零步长；原印≤端点由MD-4-VerletBoundaryPrinted保留为疑误。')
        change('SymplecticEulerStability',current('SymplecticEulerStability')+'''

theorem symplecticEulerStability_complete (Ω : ℝ) (_hΩ : 0 < Ω) :
    (sSup {h : ℝ | 0 < h ∧ MolecularDynamics.Chapter04Review.matrixStable
      (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)}=2/Ω) ∧
    (∀ h : ℝ, 2 < h*Ω →
      ∃ a b : ℝ, 0 < |a| ∧ |a| < 1 ∧ 1 < |b| ∧
        (∀ ζ : ℂ, (∃ v : Fin 2 → ℂ, v ≠ 0 ∧
          (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal *ᵥ v=ζ • v) ↔
          ζ=(a : ℂ) ∨ ζ=(b : ℂ)) ∧
        ∃ v : Fin 2 → ℝ, v ≠ 0 ∧ ∀ k : ℕ,
          (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)^k *ᵥ v=b^k • v) := by
  sorry''','B','明确为修订稳定内区间结论；补超阈值实谱恰为一内一外非零实根、真实指数增长轨道及正步长稳定集合上确界2/Ω。原端点错误单列保留，未新增证明。',scope='修订的严格内区间、超阈值两实根/指数轨道及阈值上确界；原印含端点句由MD-4-SymplecticEulerBoundaryPrinted保留。')
        pages=[161,162,163]
    elif section=='4.1':
        human[sid('ActualMidpointRelation')]='PDF164的印刷“中点”公式其实梯形法，当前定义是真中点（PDF166机械中点背景）；选项：标独立更正候选并补准确来源／按原印重绑为梯形关系。须导师选择，当前定义保持，不覆盖PrintedImplicitRelation。'
        human[sid('PrintedModifiedFrequency')]='复对数分支及h=0资格未指定；选项：采用连续于零的主相位且h≠0并桥接2atan(hΩ/2)/h／另给连续延拓值Ω。保持原式，不擅定分支。'
        change('ImplicitFactor',current('ImplicitFactor')+'''

theorem implicitFactor_update (Ω h : ℝ) (z out : ℂ) :
    (out=z+(h : ℂ)*(Complex.I*Ω*z+Complex.I*Ω*out)/2) ↔
      out=implicitFactor Ω h*z := by
  sorry''','B','保留因子并补线性场iΩz的印刷隐式更新等价式；分母实部1不需额外非零假设，新定理暂sorry。')
        change('ImplicitModulus',current('ImplicitModulus')+'''

theorem implicitModulus_iterates (Ω h : ℝ) (z : ℂ) (k : ℕ) :
    ‖(MolecularDynamics.Chapter04Review.implicitFactor Ω h)^k*z‖=‖z‖ := by
  sorry''','B','增加任意步长的标量迭代范数保持，准确对应当前线性振子模态；不扩大到任意线性系统。原模长证明保留。')
        change('ModifiedFrequencyLimit',current('ModifiedFrequencyLimit')+'''

def midpointFrequencyRatio (x : ℝ) : ℝ := 2*Real.arctan (x/2)/x

theorem modifiedFrequencyRatio_limits :
    Tendsto midpointFrequencyRatio (nhdsWithin 0 ({0}ᶜ)) (𝓝 1) ∧
    Tendsto midpointFrequencyRatio atTop (𝓝 0) ∧
    (∀ Ω h : ℝ, h*Ω ≠ 0 →
      MolecularDynamics.Chapter04Review.modifiedFrequency Ω h/Ω=midpointFrequencyRatio (h*Ω)) := by
  sorry''','B','补x=hΩ的频率比零点极限1与正无穷极限0及实际频率桥接，保留旧h→0证明；新结论不作证明。')
        change('MidpointElimination',current('MidpointElimination')+'''

theorem midpointEulerHalfSteps (n : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ)
    (z mid out : MolecularDynamics.Chapter04Review.Z n) :
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out ↔
      (let f := fun w : MolecularDynamics.Chapter04Review.Z n ↦
        (MolecularDynamics.Chapter04Review.invMass m w.2,
          -MolecularDynamics.Chapter04Review.grad U w.1)
       mid=z+(h/2) • f mid ∧ out=mid+(h/2) • f mid) := by
  sorry''','B','保留消元公式及其已有证明，补实际相空间场的隐式Euler半步→显式Euler半步关系等价，不静默缩掉组合结论。')
        pages=[164,165,166]
    elif section=='4.2.1':
        human[sid('RESPAStructure')]='现source只引用分裂设计背景，保结构定理实际还据算法和跨页辛性句；选项：批准扩来源至PDF167算法及171辛性句并明确可逆解释／保留原source为设计背景且另列定理。涉及来源路线选择，保持现状。'
        change('SlowMatrix',current('SlowMatrix'),'B','本条明确只承担S_h；同一展示中的F_h由MD-4.2.1-FastMatrix承担，原合引文字保留。',scope='仅S_h定义；合引中的F_h由MD-4.2.1-FastMatrix承担。')
        change('FastMatrix',current('FastMatrix').replace('(Ω h : ℝ)','(Ω h : ℝ) (_hΩ : Ω ≠ 0)',1),'A','F_h使用原Ω≫1模型的非零频率域，防止除零总化；S_h由SlowMatrix承担，原展示不删。',scope='仅非零频率模型中的F_h定义；S_h由MD-4.2.1-SlowMatrix承担。')
        change('ImpulseDet',current('ImpulseDet')+'''

theorem impulseDet_eigenvalueProduct (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ, a*b=1 ∧ ∀ ζ : ℂ,
      (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=
          (ζ-a)*(ζ-b) := by
  sorry''','B','保留三项行列式证明；补复特征多项式的完整首一二次分解及两根乘积1，重根以两个因子计重，非任取两个单根。')
        change('ImpulseTrace',current('ImpulseTrace')+'''

theorem impulseTrace_eigenvalueSum (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ,
      a+b=(2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) : ℝ) ∧
      (∀ ζ : ℂ, (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=(ζ-a)*(ζ-b)) := by
  sorry''','B','保留trace计算，并用同一个完整二次分解绑定按代数重数的两个根及根和，不重复任取同一简单根。')
        change('ResonanceInstability',current('ResonanceInstability')+'''

theorem resonanceInstability_realSpectrum (Ω : ℝ) (_hΩ : 0 < Ω) :
    ∃ δ > 0, δ ≤ Real.pi/Ω ∧ ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω),
      ∃ a b : ℝ, 1 < max |a| |b| ∧
        (∀ ζ : ℂ, (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
          (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=
            (ζ-(a:ℂ))*(ζ-(b:ℂ))) ∧
        (∃ v : Fin 2 → ℝ, v ≠ 0 ∧
          ((1 < |a| ∧ ∀ k : ℕ, (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)^k *ᵥ v=a^k • v) ∨
           (1 < |b| ∧ ∀ k : ℕ, (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)^k *ᵥ v=b^k • v))) := by
  sorry''','B','补共振左邻域完整两实根分解、圆外根及实际指数轨道；δ≤π/Ω明确正步长。旧圆外复根结论保留。')
        human[sid('ResonanceEigenPrinted')]='原印sqrt(|ε|/2)首项不符实际sqrt(|ε|)，误差非O(ε)；选项：批准另立数学修正版同时列两支及误差界／仅存原印疑误。现原式保持。'
        human[sid('ResonanceLinearRate')]='原词norm oscillate不成立，实际解有(-1)^k交替而范数单调线性增长；选项：批准把振荡解释为解的符号交替并并列精确轨道／仅保留原句疑误与正确线性率辅助。保持当前声明，待导师确认措辞勘误。'
        change('ResonanceGrowth',current('ResonanceGrowth'),'B','本条明确为发散推论；线性率由MD-4.2.1-ResonanceLinearRate、交替幂公式由MD-4.2.1-ResonancePower承担，原norm振荡疑误在LinearRate待导师，不删句。',scope='仅非零q初值轨道发散推论；完整线性率见MD-4.2.1-ResonanceLinearRate，带(-1)^k的精确幂见MD-4.2.1-ResonancePower，norm振荡措辞待导师。')
        pages=[167,168,169,170]
    elif section=='4.2.2':
        pages=[170,171]
    elif section=='4.3':
        old=current('ConstrainedSolution')
        auxiliary=old.replace('def constrainedSolution','def constrainedSolution_generalForce',1)
        change('ConstrainedSolution','''def constrainedSolution {n l : ℕ} (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hU : Differentiable ℝ U) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, Differentiable ℝ (g j))
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) t ∧
    HasDerivAt p (-MolecularDynamics.Chapter04Review.grad U (q t)-
      (textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g

'''+auxiliary,'A','教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。')
        change('ConstraintSet',current('ConstraintSet')+'''

theorem constraintSet_regularLevel (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ⊤ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ⊤ φ A ∧ ContDiffOn ℝ ⊤ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
  sorry''','B','零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。')
        change('ConstraintJacobian',current('ConstraintJacobian')+'''

def combineConstraints {n l : ℕ}
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) :
    MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l :=
  fun q j ↦ g j q''','B','在同一source_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。')
        change('JacobianActualDerivative',current('JacobianActualDerivative')+'''

theorem jacobianActualDerivative_curve (n l : ℕ)
    (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (p v : MolecularDynamics.Chapter04Review.Q n) (t : ℝ)
    (_hg : ∀ j, DifferentiableAt ℝ (g j) (q t)) (_hq : HasDerivAt q v t)
    (_hv : v=MolecularDynamics.Chapter04Review.invMass m p)
    (_hc : ∀ᶠ s in 𝓝 t, ∀ j, g j (q s)=0) :
    textbookConstraintJacobian g (q t) *ᵥ v=0 ∧
    textbookConstraintJacobian g (q t) *ᵥ MolecularDynamics.Chapter04Review.invMass m p=0 := by
  sorry''','B','保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。')
        human[sid('RestraintForcePrinted')]='原页末项是标量φε(q)，与向量−∇φε(q)类型冲突，旧转录还误加撇号；选项：保留忠实原文类型疑误／另立径向力修正版并限定ε>0,q≠0。原印数学路线待导师，现Lean保持，JSON按原页CORRECTED合并。'
        change('ConstrainedPendulum',current('ConstrainedPendulum').replace('(I : Set ℝ) : Prop','(I : Set ℝ) (_hI : IsOpen I) : Prop'),'A','增加开时间域，保证within导数确为经典运动导数，排除单点域任意导数的伪运动。')
        change('GramPositive',current('GramPositive'),'B','仅为正质量/梯度独立推出正定的充分条件辅助；原句可解且唯一的完整乘子结论由MD-4.3-GramInvertible补全，原文不删。',scope='仅约束Gram正定的EXTRA充分条件辅助；原句解乘子由MD-4.3-GramInvertible承担。')
        change('GramInvertible',current('GramInvertible')+'''

theorem gramInvertible_multiplier (n l : ℕ) (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q F : MolecularDynamics.Chapter04Review.Q n) (φ : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (textbookConstraintGram m g q).det ≠ 0) :
    (∃! λ : MolecularDynamics.Chapter04Review.Q l,
      textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ λ)+φ=0) ∧
    (∀ λ : MolecularDynamics.Chapter04Review.Q l,
      (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ λ)+φ=0) ↔
      λ=(textbookConstraintGram m g q)⁻¹ *ᵥ
        (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m F+φ)) := by
  sorry''','B','保留原可逆性充分条件证明，补det≠0下反力乘子唯一可解及明确逆Gram公式；F和φ是给定线性方程数据，不把所求λ作假设。')
        pages=[171,172,173,174,175]
    elif section=='4.3.1':
        change('RestrictedForm',current('RestrictedForm')+'''

theorem restrictedForm_nondegenerate (n l : ℕ) (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) (z : MolecularDynamics.Chapter04Review.Z n)
    (_hz : ∀ j, g j z.1=0)
    (_hp : textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0)
    (_hind : LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) z.1)) :
    let c := fun w : MolecularDynamics.Chapter04Review.Z n ↦
      ((fun j ↦ g j w.1), textbookConstraintJacobian g w.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m w.2)
    let T := (fderiv ℝ c z).ker
    ∀ u ∈ T, (∀ v ∈ T, MolecularDynamics.Chapter04Review.phaseForm u v=0) → u=0 := by
  sorry''','B','保留一般拉回定义，并补实际位置/隐藏约束余切流形切空间上限制标准二形式的非退化；正质量、C²、梯度独立为EXTRA正则资格。任意chart本身不声称辛。')
        old=current('VariationalFormula');sig=old.split(' := by')[0]
        code=sig.replace('theorem variational','theorem variational_constraints',1).replace('    DifferentiableAt ℝ rho z →',
          '''    DifferentiableAt ℝ rho z →
    ∀ (c : ℝ → MolecularDynamics.Chapter04Review.Z n) (t : ℝ),
    c t=z → HasDerivAt c v t →
    (∀ᶠ s in 𝓝 t, ∀ j, g j (c s).1=0) →''')
        code=code.replace('    (fderiv ℝ (fun x :','    (∀ j, (fderiv ℝ (g j) z.1) v.1=0) ∧\n    (fderiv ℝ (fun x :',1)
        change('VariationalFormula',old+'\n\n'+code+' := by\n  sorry','B','保留一般场导数公式，新增真实约束曲线的切向变分资格，将Gdq=0与两分量变分方程同一结论合取。新结论暂sorry。')
        change('HessianPullbackCancel',current('HessianPullbackCancel')+'''

theorem hessianPullbackCancel_time (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (ρ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (_hU : ContDiff ℝ 2 U) (_hg : ∀ j, ContDiff ℝ 2 (g j)) (_hρ : ContDiff ℝ 1 ρ)
    (γ u v : ℝ → MolecularDynamics.Chapter04Review.Z n) (t : ℝ)
    (_hγ : HasDerivAt γ
      (MolecularDynamics.Chapter04Review.invMass m (γ t).2,
       -MolecularDynamics.Chapter04Review.grad U (γ t).1-(textbookConstraintJacobian g (γ t).1)ᵀ *ᵥ ρ (γ t)) t)
    (_hu : HasDerivAt u ((fderiv ℝ (fun z : MolecularDynamics.Chapter04Review.Z n ↦
      (MolecularDynamics.Chapter04Review.invMass m z.2,
       -MolecularDynamics.Chapter04Review.grad U z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ ρ z)) (γ t)) (u t)) t)
    (_hv : HasDerivAt v ((fderiv ℝ (fun z : MolecularDynamics.Chapter04Review.Z n ↦
      (MolecularDynamics.Chapter04Review.invMass m z.2,
       -MolecularDynamics.Chapter04Review.grad U z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ ρ z)) (γ t)) (v t)) t)
    (_htu : ∀ j, (fderiv ℝ (g j) (γ t).1) (u t).1=0)
    (_htv : ∀ j, (fderiv ℝ (g j) (γ t).1) (v t).1=0) :
    HasDerivAt (fun s ↦ MolecularDynamics.Chapter04Review.phaseForm (u s) (v s)) 0 t := by
  sorry''','B','保留动量项消去已有证明，补实际时间流/线性变分及合法约束切向量上的完整二形式导数零；位置项由常对角逆质量对称抵消，未把二形式守恒作前提。')
        pages=[175,176,177,178]
    elif section=='4.3.2':
        human[sid('PositionEulerForceConvention')]='原印−hF与现力版本+hF涉及F的符号约定；选项：另名F_printed=−F_force并记显式派生关系／参数化U并批准按−∇U的机械修订。当前不默定原书F含义，保持定义。'
        change('ProjectionResidual',current('ProjectionResidual')+'''

def projectionEquation {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  projectionResidual m g q base η=0

theorem projectionResidual_elimination {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (Fprinted : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n)
    (λ : MolecularDynamics.Chapter04Review.Q l)
    (_hp : out.2=z.2-h • Fprinted z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ λ))
    (_hq : out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2) :
    (out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g) ↔
      projectionEquation m g z.1
        (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2-
          h^2 • MolecularDynamics.Chapter04Review.invMass m (Fprinted z.1)) (h^2 • λ) := by
  sorry''','B','补真实零残差方程及原印F符号下base、η=h²λ与旧状态的消元等价；不把残差函数冒充已解投影方程。')
        change('ProjectionJacobian',current('ProjectionJacobian')+'''

def projectionNewtonIncrement {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n)
    (η ηnext : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  let Δ := ηnext-η
  projectionJacobian m g q base η *ᵥ Δ=projectionResidual m g q base η''','B','保留交叉Jacobian定义，并补实际Newton线性方程RΔΛ=r及Δ=η_next−η；Q依赖base−M⁻¹Gᵀη已在R中展开。')
        old=current('NewtonConstraint')
        change('NewtonConstraint',old.replace('(η : MolecularDynamics.Chapter04Review.Q l) :','(η : MolecularDynamics.Chapter04Review.Q l)\n    (_hdet : (MolecularDynamics.Chapter04Review.projectionJacobian m g q base η).det ≠ 0) :',1)+'''

def newtonConstraintSequence {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (k : ℕ)
    (_hvalid : ∀ i < k,
      (MolecularDynamics.Chapter04Review.projectionJacobian m g q base
        ((MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[i] 0)).det ≠ 0) :
    MolecularDynamics.Chapter04Review.Q l :=
  (MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[k] 0''','A','真实Newton主接口加入当前交叉矩阵det≠0；补建议初值0的有限序列且逐步可逆资格显式，不把奇异逆总化当合法迭代。Mathlib逆矩阵按标准含义采信。')
        for k in ['FrozenNewtonConstraint','FrozenGramPrinted']:
            human[sid(k)]='Λ⁽⁰⁾=0给出的实际交叉Jacobian为G(base)DG(q)ᵀ，未必等旧点Gram或对称；选项：冻结真实交叉矩阵并取消一般对称性／明示近似冻结旧点Gram，或加G(base)=G(q)。涉及书中疑误/算法路线，保持现状。'
        refresh=[sid('NewtonQuadratic')]
        pages=[178,179,180]
    elif section=='4.3.3':
        for k in ['ComponentPrinted','ComponentConstraintStep']:
            code=current(k)
            qualification=''' (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m '''
            qualification+=('(Gsup1 j)' if k=='ComponentPrinted' else '(MolecularDynamics.Chapter04Review.grad (g j) q)')+') ≠ 0)'
            code=code.replace('(j : Fin l) :','(j : Fin l)'+qualification+' :',1)
            change(k,code,'A','补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。',scope='单个有效分量步骤；重复顺序循环由MD-4.3.3-ComponentSweep承担。印刷Gsup1与梯度解释分开保留。')
        old=current('ComponentSweep')
        change('ComponentSweep',old+'''

def componentPrintedDelta {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (Q : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) : ℝ :=
  g j Q/MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
    (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))

def componentPrintedTrajectory {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) : ℕ → MolecularDynamics.Chapter04Review.Q n
  | 0 => Q₀
  | k+1 =>
    let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
    if hl : 0 < l then
      let j : Fin l := ⟨k%l,Nat.mod_lt k hl⟩
      Q-componentPrintedDelta m g Q Gsup1 j •
        MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
    else Q

def componentPrintedIteration {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (rounds : ℕ) (_hm : ∀ i, 0 < m i) (_hl : 0 < l)
    (_hvalid : ∀ k < rounds*l,
      let j : Fin l := ⟨k%l,Nat.mod_lt k _hl⟩
      let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
      DifferentiableAt ℝ (g j) q ∧ DifferentiableAt ℝ (g j) Q ∧
        MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
          (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) :
    MolecularDynamics.Chapter04Review.Q n :=
  componentPrintedTrajectory m g q Q₀ Gsup1 (rounds*l)

def componentPrintedStop {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (round : ℕ) (tol : ℝ) (_hl : 0 < l) : Prop :=
  ∀ j : Fin l, |componentPrintedDelta m g
    (componentPrintedTrajectory m g q Q₀ Gsup1 (round*l+j.val)) Gsup1 j| < tol''','B','保留一次修订梯度扫描辅助；新增字面Gsup1分母的实际逐分量轨迹、多轮顺序循环与每步有效域，以及一轮全部增量停止检查。字面原式不暗换Gsup1，不添加收敛承诺。')
        pages=[180]
    elif section=='4.3.4':
        human[sid('ProjectedEulerRelation')]='本source引用辛性原句，当前仅任意力更新且与原印−hF有符号绑定差异；选项：按原印a=−h并补机械梯度/光滑局部分支的完整辛性／批准独立力版本修订并重绑关系来源。与PositionEulerForceConvention一并确定路线，现状保持。'
        old=current('ProjectedEulerPullback');sig=old.split(' := by')[0]
        sig=sig.replace('theorem projectedEulerPullback','theorem projectedEulerPullback_intermediate',1)
        start=sig.index('    textbookSymplecticForm Nc')
        def form(q,p):return f'textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart {q} {p}) x u) (fderiv ℝ (textbookCotangentChart {q} {p}) x v)'
        result=('    let Pbar := textbookProjectedEulerPreMomentum s γ lam U h a q p\n'
          '    let Q := textbookProjectedEulerPosition m h q Pbar\n'
          f'    ({form("Q","Pbar")} = {form("q","Pbar")}) ∧\n'
          f'    ({form("q","Pbar")} = {form("q","p")}) ∧\n')
        change('ProjectedEulerPullback',old+'\n\n'+sig[:start]+result+sig[start:]+' := by\n  sorry','B','原总拉回等式已有证明保留；同条补Q/Pbar与q/Pbar、q/Pbar与q/p的两条实际微分二形式中间等式，逐句覆盖原证明链。')
        old=current('CotangentMultiplier')
        change('CotangentMultiplier',old.replace('(q p : Fin Nc → ℝ) :','(q p : Fin Nc → ℝ)\n    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) :',1)+'''

theorem cotangentMultiplier_hidden {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : MolecularDynamics.Chapter04Review.Q n)
    (_hdet : (textbookConstraintGram m g q).det ≠ 0) :
    let μ := textbookCotangentMultiplier m g q p
    (textbookConstraintGram m g q) *ᵥ μ=
      textbookConstraintJacobian g q *ᵥ (textbookInverseMassMatrix m *ᵥ p) ∧
    textbookConstraintJacobian g q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (p-(textbookConstraintJacobian g q)ᵀ *ᵥ μ))=0 := by
  sorry''','A','Gram构造限定det≠0，并补Aμ=GDp及真实投影隐藏约束；这是(4.23–24)推导的受限构造，不用值函数替代方程。')
        old=current('CotangentProjection')
        auxiliary=old.replace('def cotangentProjection','def cotangentProjection_gram',1).replace('(q p : Fin Nc → ℝ) :','(q p : Fin Nc → ℝ)\n    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) :',1)
        change('CotangentProjection','''def cotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p P : Fin Nc → ℝ) (μ : Fin Mc → ℝ) : Prop :=
  P=p-(textbookConstraintJacobian γ q)ᵀ *ᵥ μ

'''+auxiliary,'A','主声明忠实为任意μ的印刷投影等式；Gram专项实现独立命名且加可逆资格，隐藏约束由CotangentMultiplier补全，不暗中求解任意原式乘子。')
        change('CotangentRegularity',current('CotangentRegularity'),'B','本条显式仅为专项投影C¹正则性辅助；所引完整限制二形式等式已由MD-4.3.4-CotangentPullback承担并含真实邻域位置约束，不重复冒充同一结论。',scope='Gram专项投影C¹正则性辅助；原句位置约束下完整二形式等式由MD-4.3.4-CotangentPullback承担。')
        old=current('GramProjectedEuler')
        literal=old.replace('(h a : ℝ)','(h : ℝ)',1).replace(' U h a q p',' U h (-h) q p')
        change('GramProjectedEuler',literal+'\n\n'+old.replace('theorem gramProjectedEuler','theorem gramProjectedEuler_general',1),'C','教材包装全部固定a=−h，对应原印−hF的特殊参数；任意a几何推广作为独立辅助保留，原已证apply仅参数实例化。未把a=h物理修订暗作原印；不声称隐式分支存在或全局微分同胚。')
        pages=[181,182]
    elif section=='4.3.5':
        for k in ['SHAKEPositionMass','SHAKEElimination','SHAKEPositionOrder']:
            human[sid(k)]='原印(4.25)反力漏M⁻¹，与一般质量下的两步消元不一致；选项：批准另立质量一致修正式并显式绑定／原印仅单位质量或兼容反力空间的受限版。当前辅助质量修正对象及原文保持，不擅选勘误路线。'
        for k in ['StaggeredConstraint','SHAKERATTLEEquivalence']:
            human[sid(k)]='原印RATTLE乘子缩放与(4.33)不符，且初始化由(4.29)导出的反力号与原印相反；选项：原μ下采用λ/2+μ/h并修初始化正号／另定缩放μ且限定同一局部求解分支。需导师裁定，现状保持。'
        old=current('RATTLESymplectic')
        change('RATTLESymplectic','''theorem rattleSymplectic (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 2 U) (_hg : ∀ j, ContDiff ℝ 2 (g j))
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D) (h : ℝ)
    (G : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (half : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rho μ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) z.1))
    (_hG : ContDiffOn ℝ 1 G D) (_hp : ContDiffOn ℝ 1 half D)
    (_hr : ContDiffOn ℝ 1 rho D) (_hμ : ContDiffOn ℝ 1 μ D)
    (_hstep : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (G z) (half z) (rho z) (μ z)) :
    ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      ∀ u v, MolecularDynamics.Chapter04Review.tangentPhase m g z u →
      MolecularDynamics.Chapter04Review.tangentPhase m g z v →
        MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=
          MolecularDynamics.Chapter04Review.phaseForm u v := by
  sorry''','A','改为正质量、C²势/约束、余切域满秩的开放邻域C¹求解分支上真实拉回辛性；不假设全局隐式单值法，不声称分支存在。')
        change('ConstrainedOrders',current('ConstrainedOrders')+'''

theorem constrainedOrders_global (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 4 U) (_hg : ∀ j, ContDiff ℝ 4 (g j))
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      (textbookConstraintGram m g z.1).det ≠ 0)
    (E R : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (pE pR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (η : ℝ) (_hη : 0 < η)
    (_hE : ContDiffOn ℝ 3 (Function.uncurry E) (Ioo (-η) η ×ˢ D))
    (_hR : ContDiffOn ℝ 3 (Function.uncurry R) (Ioo (-η) η ×ˢ D))
    (_hrhoE : ContDiffOn ℝ 2 (Function.uncurry rhoE) (Ioo (-η) η ×ˢ D))
    (_hμE : ContDiffOn ℝ 2 (Function.uncurry μE) (Ioo (-η) η ×ˢ D))
    (_hrhoR : ContDiffOn ℝ 2 (Function.uncurry rhoR) (Ioo (-η) η ×ˢ D))
    (_hμR : ContDiffOn ℝ 2 (Function.uncurry μR) (Ioo (-η) η ×ˢ D))
    (_hzero : ∀ z ∈ D, E 0 z=z ∧ R 0 z=z ∧ μE 0 z=0 ∧ μR 0 z=0)
    (_hsteps : ∀ h ∈ Ioo (-η) η, ∀ z ∈ D,
      z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (R h z) (pR h z) (rhoR h z) (μR h z))
    (T : ℝ) (_hT : 0 < T) (Φ : ℝ → MolecularDynamics.Chapter04Review.Z n)
    (_hΦ : ∀ t ∈ Icc 0 T, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t)
    (_hc : ∀ t ∈ Icc 0 T, Φ t ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hcompact : ∃ B, IsCompact B ∧ B ⊆ D ∧ ∀ t ∈ Icc 0 T, Φ t ∈ B) :
    ∃ C > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      let h := T/(N:ℝ)
      ∀ k ≤ N, ‖(E h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h ∧
        ‖(R h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h^2 := by
  sorry

theorem constrainedOrders_firstOrderSharp :
    ∃ c > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      c/(N:ℝ) ≤ ‖(MolecularDynamics.Chapter04Review.symplecticEulerMatrix 1 (1/(N:ℝ)))^N *ᵥ
        (![1,0] : Fin 2 → ℝ)-![Real.cos 1,-Real.sin 1]‖ := by
  sorry''','B','保留局部一致性辅助，补真实光滑正则求解分支及紧时间精确轨道上的全局Euler一阶/RATTLE二阶，并给无约束振子一阶下界表达only first order。SHAKE位置阶专归SHAKEPositionOrder，其质量勘误路线待导师；原文不删。',scope='投影Euler全局一阶（含非二阶实例）及RATTLE全局二阶；SHAKE位置全局二阶由MD-4.3.5-SHAKEPositionOrder承担，其原印质量约定待导师。')
        pages=[183,184]
    elif section=='4.3.5.1':
        old=current('AdjointEuler')
        order=ds['MD-4.3.5-ConstrainedOrders']['block'].split(' := by')[0]
        order=order.replace('theorem constrainedOrders','theorem adjointEulerLocalOrder',1)
        import re
        order=re.sub(r'\bR\b','A',order).replace('rattleRelation','adjointEulerRelation').replace('‖A h-Φ h‖ ≤ C*h^3','‖A h-Φ h‖ ≤ C*h^2')
        change('AdjointEuler',old+'''

theorem adjointEuler_inverseRelation (n l : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (_hh : h ≠ 0)
    (z out : MolecularDynamics.Chapter04Review.Z n)
    (_hz : z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hout : out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g) :
    (∃ half rho μ, adjointEulerRelation m F g h z out half rho μ) ↔
      ∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (-h) out z pbar rho μ := by
  sorry

'''+order+' := by\n  sorry','B','保留原三式；补非零h、两端余切域上的真实逆步关系等价（对应所选局部逆分支），及正质量/光滑分支上实际ODE的O(h²)局部误差。未把逆映射或误差结论作为资格。')
        old=current('ConstrainedComposition')
        code=old.replace('Q l),','Q l) (η : ℝ), 0 < η →',1)
        code=code.replace('(∀ i, 0 < m i) →','(∀ i, 0 < m i) →\n    (∀ q ∈ MolecularDynamics.Chapter04Review.constraintSet g, LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) q)) →',1)
        code=code.replace('Differentiable ℝ','ContDiff ℝ 1')
        code=code.replace('(∀ h,','(∀ h ∈ Ioo (-η) η,').replace('(∀ h z,','(∀ h ∈ Ioo (-η) η, ∀ z,').replace('    ∀ h,','    ∀ h ∈ Ioo (-η) η,')
        code+='''

theorem constrainedComposition_circleExample :
    let m : Fin 2 → ℝ := fun _ ↦ 1
    let g : Fin 1 → (Fin 2 → ℝ) → ℝ := fun _ q ↦ (q 0)^2+(q 1)^2-1
    let F : (Fin 2 → ℝ) → Fin 2 → ℝ := fun _ ↦ 0
    let z : MolecularDynamics.Chapter04Review.Z 2 := (![1,0],![0,1])
    let e : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 15/4,1/4],![-1/4,Real.sqrt 15/4])
    let a : MolecularDynamics.Chapter04Review.Z 2 :=
      (![7/8,Real.sqrt 15/8],![-Real.sqrt 15/8,7/8])
    let r : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 3/2,1/2],![-1/2,Real.sqrt 3/2])
    ∃ pE pA pR pS ρE μE ρA μA ρR μR ρS ρSnew pSout,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (1/4) z e pE ρE μE ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m F g (1/4) e a pA ρA μA ∧
      MolecularDynamics.Chapter04Review.rattleRelation m F g (1/2) z r pR ρR μR ∧
      MolecularDynamics.Chapter04Review.shakeRelation m F g (1/2) z (r.1,pSout) pS ρS ρSnew ∧
      a.1 ≠ r.1 := by
  sorry

theorem constrainedComposition_noConstraints (n : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) :
    ((∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out pbar rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m (z.2+h • F z.1),z.2+h • F z.1)) ∧
    ((∃ half rho μ, MolecularDynamics.Chapter04Review.adjointEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out half rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2,
        z.2+h • F (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2))) := by
  sorry'''
        change('ConstrainedComposition',code,'B','分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的具体单值近分支实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。',scope='小h光滑分支上的组合辛性、无约束退化及非等价实例；二阶精度子句由MD-4.3.5.1-ConstrainedCompositionOrder承担，原文保留。',source_updates={'extra_assumptions':['U/g为C³，正质量及独立约束；小步长窗口内C¹空间分支资格显式。']})
        old=current('ConstrainedCompositionOrder')
        code=old.replace('Q l),','Q l) (η : ℝ), 0 < η →',1).replace('(∀ h z,','(∀ h ∈ Ioo (-η) η, ∀ z,')
        change('ConstrainedCompositionOrder',code,'B','本条限定二阶局部精度，辛性在ConstrainedComposition同域对应的空间光滑分支中单列；将关系限制实际小h窗口，避免强迫全步长隐式分支存在。',scope='组合方法O(h³)局部误差（二阶精度）子句；辛性、退化及非等价实例由MD-4.3.5.1-ConstrainedComposition承担；不冒充全局二阶收敛。')
        old=current('GeodesicRelation')
        change('GeodesicRelation',old.replace('(I : Set ℝ) : Prop','(I : Set ℝ) (_hI : IsOpen I) (_hm : ∀ i, 0 < m i)\n    (_hg : ∀ j, ContDiff ℝ 2 (g j)) : Prop',1)+'''

def massMetric {n : ℕ} (m : Fin n → ℝ) (u v : Fin n → ℝ) : ℝ :=
  ∑ i, m i*u i*v i

theorem geodesicRelation_massMetric (n l : ℕ) (m : Fin n → ℝ) (_hm : ∀ i, 0 < m i)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) (I : Set ℝ) (_hI : IsOpen I)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n) (_hq : ContDiff ℝ 2 q)
    (_hc : ∀ t ∈ I, ∀ j, g j (q t)=0)
    (_hreg : ∀ t ∈ I, LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) (q t))) :
    (∀ t ∈ I, ∀ ξ : MolecularDynamics.Chapter04Review.Q n,
      textbookConstraintJacobian g (q t) *ᵥ ξ=0 →
        massMetric m (deriv (deriv q) t) ξ=0) ↔
    ∃ p rho, (∀ t ∈ I, p t=fun i ↦ m i*deriv q t i) ∧
      MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ ↦ 0) g q p rho I := by
  sorry''','B','补正质量诱导度量∑m_i u_i v_i，并在开放时间、C²约束/轨迹及满秩域上，将质量正交加速度的嵌入测地线方程与真实零势约束ODE及p=Mqdot等价；不声称全局流存在。')
        pages=[185,186]
    elif section=='4.3.6':
        pages=[186,187]
    else:raise ValueError(section)
    run_batches(section,edits,human,pages,refresh)

def run_batches(section,edits,human,pages,refresh=()):
    sources=read(ROOT/'blueprint/ch04/ch04_source.json');web={w['source_id']:w for w in read(ROOT/'blueprint/ch04/website_audit.json')}
    handled=lambda k: web[k].get('repair',{}).get('status') in ('awaiting_reaudit','awaiting_mentor')
    edits={k:v for k,v in edits.items() if not handled(k)}
    human={k:v for k,v in human.items() if not handled(k)}
    source_only=[s['source_id'] for s in sources if s['section']==section and s['source_id'] not in edits and s['source_id'] not in human and
      (s['source_id'] in refresh or (web[s['source_id']]['json_review']['status']=='CORRECTED' and not web[s['source_id']].get('repair',{}).get('json_review_locally_verified')) or
       (web[s['source_id']]['returned_audit']['verdict']=='NEEDS_HUMAN' and web[s['source_id']].get('needs_category')!='原文数学判断'))]
    touched=set(edits)|set(human)|set(source_only);ids=[s['source_id'] for s in sources if s['source_id'] in touched]
    if not ids:return
    existing=[int(p.name[6:]) for p in (ROOT/'blueprint/ch04/validation').glob('EAUDIT[0-9][0-9]')]
    number=max(existing,default=0)+1;eaudits=[]
    for start in range(0,len(ids),8):
        chunk=set(ids[start:start+8]);e=f'EAUDIT{number:02}';number+=1
        prepare(4,e,section,{k:v for k,v in edits.items() if k in chunk},pages=pages,
          source_only=[k for k in source_only if k in chunk],human={k:v for k,v in human.items() if k in chunk})
        verify(4,e);eaudits.append(e)
    commit_section(4,section,eaudits)

if __name__=='__main__':
    import sys
    run(sys.argv[1])
