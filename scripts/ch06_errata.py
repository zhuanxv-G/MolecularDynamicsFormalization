"""Explicit printed/corrected pairs, enabled in bounded source-edit batches."""
import json,re
from pathlib import Path

# key: (corrected record, mathematical counterexample/reason, explicit change)
SPECS={
'BathTaylor':('BoltzmannConstantSlope','取S(E)=E²、E=kB=1、β=2、s=1，原两端分别为e⁻¹和e⁻²。','精确Boltzmann因子增加整个能量区间的恒定熵斜率；一般热浴只保留带余项近似。'),
'CanonicalCDFPrinted':(None,'取ZA(s)=1+s、ZB(s)=1、E=1、α=1/2，两边分别为5/12和1/2。','能量累计概率的分子分母均保留ZA(s)权重；改为正确累计概率的定义。'),
'FiniteDomainPrinted':(None,'Q=(0,1)、U(q)=log q、β=1，权重1/q不可积；U在Q内光滑且Q体积有限。','将有限体积域内光滑改为紧域上连续，使用紧性保证权重可积。'),
'CanonicalAveragePrinted':('CanonicalAverage','若Zcan=2，则原Avβ(1)=1/2；概率平均必须为1。','去掉对已经归一化ρβ的第二次Zcan⁻¹；沿用未归一权重乘一次Zcan⁻¹的定义。'),
'PartitionInversePrinted':(None,'积分为2时，原式断言1/2=2。','Zcan定义为积分本身；归一密度的结论另见DensityNormalization，避免把定义重述作新定理。'),
'CoarseMarkovPrinted':('StateMarkovMeaning','令当前粗事件为全集，Brownian过去值与未来值仍相关；粗事件未保留完整当前状态。','以完整当前状态生成的σ代数写条件期望Markov性质。'),
'WeakItoAlias':('StrictItoIntegral','此项是既有Lean辅助定义的缺口，不是教材笔误：非可积函数的默认Bochner积分为0，可能使错误的均方极限成立。','严格定义要求每个有限和及极限变量均属于L²；正式库冻结，只在Blueprint使用严格版。'),
'Proposition62':('Proposition62','有序交叉和应系数+1；若仅遍历k<l，则为+2。原写−2且遍历k≠l。独立中心变量的交叉期望恰好为0，故最终结论不受影响。另p.230末句ν→0应为ν→∞。','保持已证二次变差结论；独立记录印刷平方展开与其正确代数式，并注明极限方向。'),
'DeterministicStrobePrinted':('DeterministicStrobeCorrected','若g≡1，区间[tₙ,tₙ₊₁]增量方差应为tₙ₊₁−tₙ，不能使用累计到tₙ₊₁的方差或把标准差当方差参数。','采用区间积分∫[tₙ,tₙ₊₁]g²及同一过程的独立增量资格。'),
'DiffusiveTaylorPrinted':(None,'φ(x)=|x|^(5/2)在0为C²；a=0,b=1时余项为dt^(5/4)，不是O(dt^(3/2))。','C²加强为C³，使三阶Taylor余项与扩散缩放匹配。'),
'TimeItoFormula':(None,'取φ(x,t)=t，原右端留下常数1而非微分dt；修正公式应为dφ=dt。','原文右端以形式微分占位量记录，时间偏导补dt；完整修正积分公式独立命名。'),
'OULawPrinted':('OULawCorrect','令1−e^(−2γt)=1/2，原噪声项方差多乘1/2。','把整个(1−e^(−2γt))/(2γ)放入根号；只断言同一OU过程的单时刻法则。'),
'BathForcePrinted':('BathForce','将(6.26)代回(6.23)，初值项为+k⁻¹Σ[(qᵢ(0)−Q(0))cos+…]；原f定义却有负号。','选择正的初值合力f，使(6.29)保留+f；等价选项是保留原f并将(6.29)改为−f。'),
'BathReductionPrinted':('BathReduction','同上一项：原定义f为负合力，却在约化方程中加f。','使用从原Hamilton方程实际代入所得的正合力卷积方程。'),
'MemoryKernelDeltaMeaning':(None,'不限制频率与权重时，可选全部频率固定，余弦记忆核不会自动成为Dirac分布。','仅给分布收敛的精确定义，并明确正质量资格；不声称任意热浴满足该极限。'),
'BathForceWeakLimitMeaning':(None,'光滑有限热浴力的极限应区分白噪声与其时间积分Wiener过程；无初始化法则和谱条件不能指定普适法则。','将与Wiener过程比较的对象改为时间积分后的热浴力；仍只定义极限意义。'),
'FPDiffusionPrinted':(None,'两次分部积分产生正号。取b=1，ρ与紧支φ使二阶导配对非零，负号将其错误取反。','仅将两次分部积分后的外负号改为正号，保留原C²和紧支资格。'),
'FPPolynomialAdjoint':('FPPolynomialAdjoint','函数值的多项式增长不控制全部导数；可取振荡频率快速增长的有界光滑函数。','显式约束所需导数的多项式增长和密度导数的指数衰减。'),
'VariableFrictionCanonicalPrinted':('VariableFrictionCommutingStationary','M与A=ΓΓᵀ不交换时，A M⁻¹和M⁻¹/² A M⁻¹/²不同；例如M=diag(1,4)、Γ=(1,1)ᵀ。','增加ΓΓᵀ与质量矩阵M交换条件；另一个可选修法是修改漂移以匹配噪声协方差。'),
'FiniteDistribution':('FiniteDistribution','一般概率向量可为(1,0)；nonzero不能作为全部分布的定义。','原nonzero单独保留为严格正权重版本；一般定义采用非负权重、总和1。'),
'CylinderForwardPrinted':('VectorForward','密度前向算子不应依赖独立的检验函数φ；即使ρ固定，改变φ会改变印刷右端。','扩散项中的φ″改为ρ″。'),
'BrownianNonpositive':('BrownianNonpositive','非零常数函数的梯度为0，二次型等于0；故仅为半负定。','采用≤0并区分闭算子实现与光滑核心；严格负定字面另见BrownianNegativeDefinitePrinted。'),
'Theorem61':('Theorem61','常数核反驳严格负定；随机轨道时间平均通常不具有原式的逐路径指数误差界；核心域上的对称性不自动等于闭实现的自伴性。此外p.244将ΔM定义为正质量权重，Brownian生成元扩散应为逆质量权重；m=2、U=0、f(x)=x²可区分二者。','明确闭Gibbs-L²实现、半负定、离散谱、谱隙和L²初始相对密度的演化分布平均；Brownian扩散使用逆质量权重，不混用p.244动量算子的ΔM；不声称已证原轨道时间平均。'),
'Theorem61TimeAveragePrinted':('BrownianEnsembleExponential','对非平凡平稳扩散，时间平均的随机波动通常为代数尺度；原句前半讨论演化分布平均，末句却引用(5.6)时间平均。','选择演化分布平均，限定L²初始相对密度；轨道遍历极限应另行陈述，不赋予指数逐路径率。'),
'BrownianNegativeDefinitePrinted':('BrownianNonpositive','取f≡1，非零而〈f,Lf〉=0。','将严格小于0改为小于等于0；零特征值与常数核保留。'),
'OUDensityPrinted':('OUDensityCorrect','高斯权重积分为sqrt(2πσ²(t))而非1；t=0为Dirac测度。','增加(2πσ²(t))⁻¹/²，并限γ>0、噪声非零、t>0的密度解释。'),
'Assumption1Printed':('Assumption1Correct','Brownian热核对角线上随t↓0发散，t=0转移核是Dirac测度。','联合连续性的时间域由[0,∞)改为(0,∞)。'),
'MinorizationPrinted':('MinorizationCorrectedImplication','取C=∅，小集下界对全部x∈C空真，但Assumption1要求y∈int(C)，因此不成立。即使C非空，小集下界也不自动给相对于指定参考测度的联合连续密度。','只保留在明确正时刻密度、可达性条件下到小集下界的充分方向。'),
'Theorem62':('Theorem62','原Assumption1在0时刻的密度问题需先修正；抽象generator与实际Markov演化的域、全状态密度和非爆炸资格不能省略。','明示实际Markov/Feller演化、正确正时刻密度、generator联系和先于过程选择的阈值；整条仍未证明。'),
'PeriodicPotentialBound':('PeriodicPotentialBound','周期势有界，不可能同时在其欧氏lift上随|q|→∞趋于∞；U=0也不满足Umin>1。','保留周期势有界结论；正下界通过加常数归一单独实现。'),
'PeriodicConfiningPrinted':('LangevinLyapunov','正维周期lift沿整数平移取相同势值，无法趋于∞。','围束对象改为环面×动量空间上的Hamiltonian幂；无穷远只涉及动量方向。'),
'LaplacianBoundPrinted':('LaplacianBoundCorrect','n=1、U=2、l=2、p=4时，实际Laplacian为52，印刷上界为40。','系数l(l+Nc−1)改为2l(l−1)+Nc·l。'),
'LyapunovYoungBounds':('LyapunovYoungBounds','U(q)≤Umax不能推出严格U(q)<Umax；原Laplacian错系数也不能由Young估计补救。','可选严格外上界；同时保存原有效标量界和正确系数所需界。'),
'Definition61':(None,'一维确定性dX=dt的漂移b₀=1已张成R，但点初始转移法则始终为Dirac，没有Lebesgue密度。单独把漂移放入生成族不能保证随机平滑。','用于密度结论时，从噪声字段开始，允许与漂移及噪声反复取括号；不把漂移本身直接加入初始生成族。'),
'Lemma61Printed':('Lemma61Nonempty','C=∅是开集，但概率为0。','增加目标开集非空；保留任意点初值、任意t>0的实际核正概率。'),
'Proposition64Printed':('Proposition64Relative','flat前向算子的像应满足相对于体积的零质量条件；原却用Gibbs加权零均值，同时把核写成Gibbs密度，混合两种坐标。','选择相对Gibbs密度坐标与真实加权伴随算子，核相应为常数；保留完整H¹解存在与唯一性目标。'),
'SmoothTestL2Printed':(None,'在正维无界动量空间上，f≡1光滑却不属于flat L²；一般光滑也不保证Gibbs L²。','明确要求检验函数属于所选L²空间；给出正确检验函数域定义，不冒称所有C∞函数可积。'),
}

def primary(r):
    name=r['lean_decl'].rsplit('.',1)[1]
    pattern=r'(?m)^(?:noncomputable )?(?:def|theorem|lemma) '+re.escape(name)+r'\b'
    m=re.search(pattern,r['code']);assert m,name
    stop=re.search(r'\n(?:(?:noncomputable )?(?:def|theorem|lemma|abbrev)\b|/--)',r['code'][m.end():])
    return r['code'][m.start():m.end()+stop.start() if stop else len(r['code'])].strip()

def rename(code,name):
    return re.sub(r'\b(def|theorem|lemma)\s+\w+',lambda m:m[1]+' '+name,code,count=1)

def apply(records,enabled=None):
    from ch06_data import BASE
    enabled_path=BASE/'errata_enabled.json'
    if enabled is None:
        if not enabled_path.exists():return
        enabled=json.loads(enabled_path.read_text(encoding='utf-8'))['enabled']
    bykey={r['source_id'].split('-')[-1]:r for r in records}
    # Capture originals before appending any declaration to avoid cloning pairs.
    originals={k:primary(r) for k,r in bykey.items()}
    for key in enabled:
        if key not in bykey:continue
        r=bykey[key];target,example,change=SPECS[key];name=r['lean_decl'].rsplit('.',1)[1]
        if key=='Definition61':
            r['local_verdict']='NEEDS_HUMAN'
            r['issues'].append(dict(code='ERRATUM?',detail='印刷定义将漂移b0直接纳入张成族；用于转移密度的抛物型Hörmander条件需区分仅由噪声及其与漂移括号生成的族。'))
        corrected=name+'_corrected';dest=bykey.get(target,r) if target else r
        code=rename(originals[target],corrected) if target else custom(key,r,corrected)
        dest['code']+='\n\n/-- 修正版，对应原文 '+r['source_id']+'；改动：'+change+' -/\n'+code
        r['repair_log'].append(dict(date='2026-10-17',action='directive22_printed_corrected_pair',change=change,corrected_decl='MD.Ch06.'+corrected,website='未提交；待网站审计'))
        if key=='Proposition62':
            r['code']+='''\n\n/-- 【原书疑误】p.229错误交叉项展开；双变量形式，原文不证。 -/
def proposition62Printed (x y : ℝ) : ℝ := x^2+y^2-4*x*y

/-- 修正平方展开；有序交叉和的系数为+1。 -/
theorem proposition62Expansion_corrected (x y : ℝ) : (x+y)^2=x^2+y^2+2*x*y := by
  ring

theorem proposition62Printed_counterexample : ¬ ((1+1 : ℝ)^2=1^2+1^2-4*1*1) := by
  norm_num'''
        elif key=='FiniteDistribution':
            r['code']+='''\n\n/-- 【原书疑误】保留nonzero按正概率权重的字面版本。 -/
def finiteDistributionPrinted {k : ℕ} (ψ : Fin k → ℝ) : Prop :=
  (∀ i, 0 < ψ i) ∧ ∑ i, ψ i=1

/-- 边界概率向量(1,0)是概率分布，但不满足印刷nonzero权重资格。 -/
theorem finiteDistributionPrinted_counterexample :
    finiteDistribution (fun i : Fin 2 ↦ if i=0 then 1 else 0) ∧
      ¬ finiteDistributionPrinted (fun i : Fin 2 ↦ if i=0 then 1 else 0) := by
  constructor
  · constructor
    · intro i
      split_ifs <;> norm_num
    · norm_num [Fin.sum_univ_two]
  · intro h
    have hi := h.1 (1 : Fin 2)
    norm_num at hi'''
        elif key=='TimeItoFormula':
            r['code']+='''\n\n/-- 【原书疑误】(6.17)逐字右端形式表达，dX/dXX为形式微分占位；不宣称它是正确积分等式。 -/
def timeItoFormulaPrinted (φ : ℝ×ℝ → ℝ) (x t dX dXX : ℝ) : ℝ :=
  fderiv ℝ φ (x,t) (0,1)+fderiv ℝ φ (x,t) (1,0)*dX+
    fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (x,t) (1,0)*dXX/2'''
        elif key=='FPPolynomialAdjoint':
            printed=rename(originals[key],'fpPolynomialAdjointPrinted').replace('k ≤ 2 →','k = 0 →')
            r['code']+='\n\n/-- 【原书疑误】仅函数值增长条件的字面伴随断言；不证。 -/\n'+printed
        elif key=='Theorem61' and 'Theorem61TimeAveragePrinted' in bykey:
            head=originals[key].split('  ∀ {Ω : Type*}')[0]
            # Preserve all three printed clauses, including both disputed claims.
            # The closed operator is only the explicit realization vocabulary;
            # its choice and the ambiguous printed mass Laplacian remain flagged.
            tail='''  (∀ f : (Fin n → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube n)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω), textbookIsWienerVector B P →
    ∀ x : UnitAddTorus (Fin n), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
      ∀ f : textbookPeriodicSmoothSpace n, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
        |t⁻¹*(∫ s in (0 : ℝ)..t,
            textbookConfigurationTorusObservable f
              (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hp β hβ x B s sample)) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K*‖textbookPeriodicSmoothEmbedding U hU hp β f‖*Real.exp (-α*t) := by
  sorry'''
            r['code']+='\n\n/-- 【原书疑误】Theorem6.1三款并列，保留严格负定及(5.6)轨道时间平均；闭算子实现与质量Laplacian歧义另列，不证明此版。 -/\n'+rename(head+tail,'theorem61Printed')
            r['code']+='''\n\n/-- 【原书疑误】按p.244既定ΔM=Σmi∂ii逐字代入Theorem6.1的形式表达；不宣称它是Brownian过程生成元。 -/
def brownianMassGeneratorPrinted {n : ℕ} (m : Fin n → ℝ) (U f : (Fin n → ℝ) → ℝ)
    (β : ℝ) (x : Fin n → ℝ) : ℝ :=
  ∑ i, (-(m i)⁻¹*fderiv ℝ U x (Pi.single i 1)*fderiv ℝ f x (Pi.single i 1)+
    β⁻¹*m i*fderiv ℝ (fun y ↦ fderiv ℝ f y (Pi.single i 1)) x (Pi.single i 1))'''
            r['code']+='\n\n/-- 修正版，Brownian扩散使用逆质量权重；实际生成元的表达式定义。 -/\n'+rename(originals['BrownianGenerator'],'brownianMassGeneratorPrinted_corrected')
        elif key=='Theorem62':
            r['code']+='\n\n/-- 【原书疑误】采用印刷Assumption1的版本；技术量词仍显式保留，不证。 -/\n'+rename(originals[key],'theorem62Printed').replace('Chapter06Review.assumption1 ','Chapter06Review.assumption1Printed ')
        elif key=='Definition61':
            r['code']+='\n\n/-- 【原书疑误】保留原含漂移的张成条件，不能据此推出一般转移密度。 -/\n'+rename(originals[key],'definition61Printed')
        if key=='BathTaylor':
            r['code']+='''\n\ntheorem bathBoltzmannPrinted_counterexample : Real.exp ((0 : ℝ)^2-1^2) ≠ Real.exp (-2) := by
  intro h
  have hn := Real.exp_injective h
  norm_num at hn'''

def custom(key,r,name):
    if key=='CanonicalCDFPrinted':return '''def '''+name+''' (ZA ZB : ℝ → ℝ) (energy α : ℝ) : ℝ :=
  (∫ s in 0..α, ZA s*ZB (energy-s))/(∫ s in 0..energy, ZA s*ZB (energy-s))'''
    if key=='FiniteDomainPrinted':return '''theorem '''+name+''' {n : ℕ} (Q : Set (Fin n → ℝ))
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hQ : IsCompact Q) (hU : ContinuousOn U Q) :
    IntegrableOn (fun q ↦ Real.exp (-β*U q)) Q := by
  exact (Real.continuous_exp.comp_continuousOn (hU.const_mul (-β))).integrableOn_compact hQ'''
    if key=='PartitionInversePrinted':return '''def '''+name+''' {n : ℕ} (m : Fin n → ℝ)
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) : ℝ :=
  ∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)'''
    if key=='DiffusiveTaylorPrinted':return rename(primary(r),name).replace('ContDiff ℝ 2 φ','ContDiff ℝ 3 φ')
    if key=='TimeItoFormula':return rename(primary(r),name)
    if key=='MemoryKernelDeltaMeaning':return rename(primary(r),name).replace('0 < γ ∧','(∀ k, ∀ i, 0 < masses k i) ∧ 0 < γ ∧',1)
    if key=='BathForceWeakLimitMeaning':return rename(primary(r),name).replace('MolecularDynamics.Chapter06Review.bathForcePrinted (masses k) (q0 k sample) (p0 k sample) Q0 s)',
        '∫ u in (0 : ℝ)..(s : ℝ), MolecularDynamics.Chapter06Review.bathForce (masses k) (q0 k sample) (p0 k sample) Q0 u)')
    if key=='FPDiffusionPrinted':return rename(primary(r),name).replace('-(∫ x, φ x*deriv','(∫ x, φ x*deriv').replace('  sorry','''  intro b ρ φ hb hρ hφ hc
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have h1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have h2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  calc
    _ = (∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
      apply integral_congr_ae
      filter_upwards [] with x
      ring
    _ = _ := by
      rw [h1,h2,neg_neg]
      apply integral_congr_ae
      filter_upwards [] with x
      ring''')
    if key=='SmoothTestL2Printed':return '''def '''+name+''' {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) ∧
    MemLp f 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)'''
    if key=='Definition61':return '''def parabolicNoiseBracketLevels {m S : ℕ}
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) : ℕ → Set ((Fin m → ℝ) → (Fin m → ℝ))
  | 0 => Set.range (fun i : Fin S ↦ b i.succ)
  | k+1 => parabolicNoiseBracketLevels b k ∪
      {w | ∃ u ∈ parabolicNoiseBracketLevels b k, ∃ i : Fin (S+1),
        w=MolecularDynamics.Chapter06Review.lieBracket (b i) u}

def '''+name+''' {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧
    Submodule.span ℝ {v | ∃ k : ℕ, ∃ w ∈ parabolicNoiseBracketLevels b k, v=w x}=⊤'''
    raise ValueError(key)
