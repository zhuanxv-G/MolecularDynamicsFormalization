"""Separate preserved textbook statements from explicitly named corrections."""
import sys,re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT/'scripts'))
from integrate_website_returns import read,dump
from eaudit_review_tasks import declarations
BASE=ROOT/'blueprint/ch01';OUT=BASE/'validation/CLOSEOUT19'

def apply():
 p=ROOT/'Blueprint/Ch01.lean';text=p.read_text(encoding='utf-8-sig');ds=declarations(1)
 rows=[]
 def add(suffix,code,change,reason,example,options,default,missing=''):
  nonlocal text
  sid=next(s for s in ds if s.endswith('-'+suffix));old=ds[sid]['block'];name=ds[sid]['name'].split('.')[-1]
  text=text.replace(old,old+'\n\n/-- 修正版，对应原文 '+sid+'，改动：'+change+' -/\n'+code.strip(),1)
  # Keep the source_id at the start for existing repository parsers.
  text=re.sub(r'(/-- source_id: '+re.escape(sid)+r'[^\n]*)',r'\1 【原书疑误】',text,count=1)
  rows.append(dict(source_id=sid,original_name=ds[sid]['name'],original_signature_sha256=ds[sid]['signature_sha256'],change=change,problem=reason,mathematical_counterexample=example,mentor_options=options,default_option=default,missing=missing,corrected_names=re.findall(r'(?m)^(?:noncomputable )?(?:theorem|def)\s+(\w+_corrected(?:_[ab])?)\b',code),counterexample_names=re.findall(r'(?m)^theorem\s+(\w+_counterexample)\b',code)))
 # Existing proven exact limit stays intact; the empirical prose is preserved in JSON/doc.
 add('LJRepulsion','''theorem lj_repulsion_corrected (ε σ : ℝ) (hε : 0 < ε) (hσ : 0 < σ) (E : ℝ) :
    ∃ δ > 0, ∀ r ∈ Ioo 0 δ, E < lennardJonesPotential ε σ r := by
  have h := (lj_repulsion ε σ hε hσ).eventually (eventually_gt_atTop E)
  obtain ⟨δ,hδ,hh⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp h
  exact ⟨δ,hδ,fun r hr => hh hr⟩''',
 '保留已证单侧极限；把可严格陈述的内容写成任意有限能级对应正距离屏障，不声称数值模拟rarely的概率。',
 '有限能量的精确轨道和长时间数值模拟的经验频率是不同命题；缺算法、步长、时间窗和概率模型。',
 '数值积分器若跨越势垒，势在0附近发散不能单独保证离散轨迹无碰撞；rarely无概率空间无法判定。',
 ['定性登记','指定数学模型'],'定性登记')
 # Negative-gradient sign repair; the original literal theorem is untouched.
 raw=ds['MD-1.2-RadialLJForceLiteral']['block'].replace('theorem radial_lj_force_literal','theorem radial_lj_force_literal_corrected',1)
 raw=raw.replace('(deriv (lennardJonesPotential ε σ)', '(-deriv (lennardJonesPotential ε σ)',1).replace('(-24 * ε / σ)','(24 * ε / σ)',1)
 proof='''  have hphi (r : ℝ) (hr : r ≠ 0) :
      deriv (Chapter01Review.lennardJonesPotential ε σ) r =
        (24*ε/r)*((σ/r)^6-2*(σ/r)^12) := by
    have hx := (hasDerivAt_const r σ).div (hasDerivAt_id r) hr
    have hd := ((hx.pow 12).sub (hx.pow 6)).const_mul (4*ε)
    convert hd.deriv using 1
    · rfl
    · simp only [Pi.div_apply, Pi.pow_apply, id_eq, Nat.cast_ofNat]
      norm_num only [Nat.reduceSub]
      field_simp [hr] <;> ring
  constructor
  · simpa [ljForce,pairDistance,lennardJonesPotential,Chapter01Review.lennardJonesPotential] using hnewton
  · rw [hnewton]
    unfold ljForce
    rw [Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro j hj
    have hij : i ≠ j := (Finset.mem_erase.mp hj).1.symm
    have hr : ‖q i-q j‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr (hnc j hij))
    change (-deriv (Chapter01Review.lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) = _
    rw [hphi _ hr,smul_smul]
    congr 1
    field_simp [hr,hσ.ne'] <;> ring'''
 add('RadialLJForceLiteral',raw.rsplit('  sorry',1)[0]+proof,
 '第一式补负梯度负号，第二式外系数由−24ε/σ改为+24ε/σ；其余对象和量词不变。',
 'Newton力为−∇U；印刷式把径向势梯度当成力，两个等号均反号。',
 'N=2、m=ε=σ=1，q₀=0、q₁=e₁。φ′(1)=−24，真实F₀=−24e₁，原书右端却为+24e₁。',
 ['按负梯度符号勘误','仅保留原文疑误'],'按负梯度符号勘误')
 add('ConvexLegendre','''theorem legendreTransform_literal {n : ℕ} (g : Position n → ℝ)
    (hg : ConvexOn ℝ univ g) :
    ∀ η : Position n, ∃ r : ℝ, IsLUB (Set.range (fun θ => inner ℝ η θ - g θ)) r := by
  sorry

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：允许上确界为+∞。 -/
def legendreTransform_corrected {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：实值版显式要求有上界。 -/
theorem legendreTransform_corrected_b {n : ℕ} (g : Position n → ℝ) (η : Position n)
    (hb : BddAbove (Set.range (fun θ => inner ℝ η θ - g θ))) :
    IsLUB (Set.range (fun θ => inner ℝ η θ - g θ))
      (sSup (Set.range (fun θ => inner ℝ η θ - g θ))) := by
  exact isLUB_csSup (Set.range_nonempty _) hb''',
 '新增原书“任意凸函数的变换处处实值”的literal陈述；默认EReal扩展实数，并给有界时实值备选。',
 '凸性不能保证共轭函数每一点有限；实数sSup在无上界时的总化值不能充当真实上确界。',
 '一维g(x)=0、η=1时supₓ x=+∞，不存在实数上确界。',
 ['EReal推广','实值加有界性'],'EReal推广')
 add('TorusDense','''theorem torusdense_literal :
    ∀ (n : ℕ) (Ω : Fin n → ℝ) (θ : HarmonicTorus n),
      (¬ ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) →
      DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-TorusDense，改动：明确全整数无共振资格。 -/
theorem torusdense_corrected :
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry''',
 '另补原句“非周期即充满整个环面”的literal；修正版显式全整数无共振，原有带资格陈述不变。',
 '高维准周期运动可能只在真子环面稠密；无正周期不等于全维无共振。',
 '三维频率(1,√2,1+√2)无公共正周期，却满足θ₃−θ₁−θ₂常数，轨道局限于二维子环面。',
 ['全维加无共振','子环面版本'],'全维加无共振','缺一般d维Kronecker稠密定理；不建设大型理论。')
 old=ds['MD-1.5.2-LocalActionAngleReduction']['block']
 literal=old.replace('local_action_angle_reduction','local_action_angle_reduction_literal',1).replace('    IsCompact S → IsConnected S →\n','')
 corrected=old.replace('local_action_angle_reduction','local_action_angle_reduction_corrected',1)
 add('LocalActionAngleReduction',literal+'\n\n/-- 修正版，对应原文 MD-1.5.2-LocalActionAngleReduction，改动：紧连通非空正则共同水平集。 -/\n'+corrected,
 '原书无紧性资格的环面推断另记literal；默认紧、连通、非空、正则共同水平集，保留局部正则坐标与全局环面结论。',
 '独立对合第一积分只给局部正则结构；非紧共同水平集未必为环面。IsConnected含非空。',
 '自由粒子H=p，水平集{p=c}≅ℝ，不紧，不同胚于圆S¹。',
 ['批准明确资格','保留字面疑误待定'],'批准明确资格','缺一般Liouville–Arnold与局部辛坐标理论；不建设大型理论。')
 old=ds['MD-1.5.3-HartmanGrobmanLiteral']['block']
 add('HartmanGrobmanLiteral',old.replace('hartmangrobmanliteral','hartmangrobmanliteral_corrected',1).replace('ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V','ContinuousOn φ U ∧ ContinuousOn ψ V'),
 'C∞可逆坐标替换改为连续互逆局部同胚；保留零点、邻域与留域期间共轭公式。',
 'C¹双曲系统的一般Hartman–Grobman结论为拓扑共轭，不保证C∞线性化。',
 '一维f(x)=x+x|x|为C¹但非C²的双曲向量场。若有C∞微分同胚线性化，其推前公式将使f光滑，矛盾；即使f光滑，共振仍可阻碍光滑线性化。',
 ['同胚勘误','光滑加条件'],'同胚勘误','缺一般Hartman–Grobman局部拓扑共轭；不建设大型理论。')
 old=ds['MD-1.5.3-HyperbolicStabilityTransfer']['block']
 add('HyperbolicStabilityTransfer',old.replace('hyperbolicstabilitytransfer','hyperbolicstabilitytransfer_corrected',1),
 '显式独立登记以拓扑共轭为依据的稳定性转移，不调用光滑literal。',
 '结论本身是标准推论，但原证明链不能依赖原书过强的光滑共轭。',
 '拓扑同胚在平衡点邻域的连续性及逆连续性已足以传递ε/δ稳定性；不需要C∞共轭。',
 ['采用拓扑共轭推论','等待导师核对'],'采用拓扑共轭推论','缺一般拓扑共轭及留域稳定性转移桥接；不依赖literal。')
 add('RegularLatticeMinimizerLiteral','''theorem regularlatticeminimizerliteral_corrected (N : ℕ) (φ : ℝ → ℝ)
    (L : ℝ) (hL : 0 < L) (hφ : StrictConvexOn ℝ (Ioi 0) φ) :
    let d := L / (N+1)
    ∀ gaps : Fin (N+1) → ℝ, (∀ i, 0 < gaps i) → (∑ i, gaps i) = L →
      (N+1 : ℝ) * φ d ≤ ∑ i, φ (gaps i) ∧
      ((∑ i, φ (gaps i)) = (N+1 : ℝ) * φ d ↔ ∀ i, gaps i = d) := by
  sorry

theorem regularlatticeminimizerliteral_counterexample :
    (∀ x y : Fin 2 → ℝ,
      boxPeriodicNearestNeighborPotentialEnergy (fun _ => 0) 1 x ≤
      boxPeriodicNearestNeighborPotentialEnergy (fun _ => 0) 1 y) ∧
    ¬ ∃ a : ℝ, regularLattice a (1/2) (fun _ : Fin 2 => 0) := by
  constructor
  · intro x y; simp [boxPeriodicNearestNeighborPotentialEnergy]
  · rintro ⟨a,ha⟩
    have h0 := ha.2 (0 : Fin 2)
    have h1 := ha.2 (1 : Fin 2)
    norm_num at h0 h1
    linarith''',
 '改为一维周期有序粒子的正间距和L固定、严格凸最近邻势；Jensen给等间距最小且仅等间距等号。',
 '任意uniform pair potential不保证晶格最小；还缺排序、盒域和势的凸性等资格。',
 'φ≡0时所有配置都是最小，包括不等间距；原字面量化还接受重合配置。修正版严格凸正间距排除这些反例。',
 ['批准严格凸正间距版本','保留字面疑误'],'批准严格凸正间距版本','缺固定正间距Jensen等号到周期排序配置的组合桥接。')
 old=ds['MD-1.6.1-MinimumGradientZero']['block']
 add('MinimumGradientZero',old.replace('minimumgradientzero','minimumgradientzero_corrected',1),
 '显式标为无约束内点极小的必要条件，保留已证桥接；不扩展到约束边界。',
 '约束边界极小一般不能推出全梯度为零；原上下文若含边界须区分可行方向。',
 'U(x)=x在闭半轴[0,∞)的0为约束最小，但U′(0)=1。现有Lean用IsLocalMin，已限制为内点意义。',
 ['无约束内点版本','另立约束可行方向版本'],'无约束内点版本')
 old=ds['MD-1.6.1-MinimumHessianLiteral']['block']
 code=old.replace('minimumhessianliteral','minimumhessianliteral_corrected',1).replace('v ≠ 0 → 0 < inner','v ≠ 0 → 0 ≤ inner',1)
 code+='''

theorem minimumhessianliteral_counterexample :
    IsLocalMin (fun x : ℝ => x^4) 0 ∧ deriv (deriv (fun x : ℝ => x^4)) 0 = 0 := by
  constructor
  · change ∀ᶠ x in 𝓝 (0 : ℝ), (0 : ℝ)^4 ≤ x^4
    exact Filter.Eventually.of_forall (fun x => by positivity)
  · have hd : deriv (fun x : ℝ => x^4) = fun x => 4*x^3 := by
      funext x
      convert ((hasDerivAt_id x).pow 4).deriv using 1 <;> simp
    rw [hd]
    simpa using (((hasDerivAt_id (0 : ℝ)).pow 3).const_mul 4).deriv
'''
 add('MinimumHessianLiteral',code,'正定改为半正定；仍保留Hessian对称性及所有非零方向。',
 '局部极小只能推出Hessian半正定，严格极小也不能保证非退化。',
 'U(x)=x⁴在0严格极小，但U″(0)=0；Lean反例核验局部极小与零二阶导。',
 ['半正定勘误','增加Hessian非退化后保留正定'],'半正定勘误','缺一般C²二阶必要条件及Hessian对称/双线性形式桥接；原文不证。')
 add('ConstantRotationLiteral','''theorem constantrotationliteral_corrected_a (R ℓ : ℝ) (θ : ℝ → ℝ)
    (hR : 0 < R) (h : ∀ t, R^2 * deriv θ t = ℓ) :
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  refine ⟨ℓ/R^2,fun t => ?_⟩
  apply (eq_div_iff (pow_ne_zero 2 hR.ne')).mpr
  simpa [mul_comm] using h t

/-- 修正版，对应原文 MD-1.7-ConstantRotationLiteral，改动：角速度随半径变化。 -/
theorem constantrotationliteral_corrected_b (r θ : ℝ → ℝ) (ℓ : ℝ)
    (h : ∀ t, 0 < r t ∧ (r t)^2 * deriv θ t = ℓ) :
    ∀ t, deriv θ t = ℓ/(r t)^2 := by
  intro t
  apply (eq_div_iff (pow_ne_zero 2 (h t).1.ne')).mpr
  simpa [mul_comm] using (h t).2''',
 'a增加恒定正半径才推恒角速；默认b保留角动量守恒并明确θ′=ℓ/r²。',
 '守恒的是角动量，转动惯量或半径可变时角速度可变。',
 'r(t)=√(1+t²)、θ(t)=arctan t、ℓ=1，r²θ′=1而θ′(0)=1、θ′(1)=1/2。',
 ['恒定半径下恒角速','角动量守恒与变角速'],'角动量守恒与变角速')
 old=ds['MD-1.7-TrimerEscapeLiteral']['block']
 add('TrimerEscapeLiteral',old.replace('trimerescapeliteral','trimerescapeliteral_corrected',1).replace('    ∀ i : Fin 3, Tendsto (fun t => ‖q t i‖) atTop atTop',
 '    ∃ i j : Fin 3, i ≠ j ∧ Tendsto (fun t => dist (q t i) (q t j)) atTop atTop'),
 '把every body逐粒子逃逸改为至少一对粒子分离的候选陈述；全部动力学、正能量、零质心/角动量资格保留。',
 '总能量正并不直接推出每个粒子相对固定原点趋于无穷；系统分离与逐粒子逃逸不同。',
 '对称共线运动q₁=−q₂、q₃=0中，第三粒子因对称力抵消可始终静止；向外大初速产生正能量。候选系统分离命题仍需独立散射论核查。',
 ['逐粒子原句登记错误','另立系统分离命题待审'],'另立系统分离命题待审','缺全局三体散射/分离理论；候选修正也尚未经导师确认。')
 add('TransitivityErgodicityLiteral','''theorem transitivityergodicityliteral_corrected {n : ℕ}
    (f : Position n → Position n) (F : ℝ → Position n → Position n)
    (μ : Measure (Position n)) [IsFiniteMeasure μ]
    (hflow : isFlowOf f F) (hcont : Continuous (Function.uncurry F))
    (hfull : ∀ U : Set (Position n), IsOpen U → U.Nonempty → μ U ≠ 0)
    (he : flowErgodic F μ) : topologicalTransitivity F univ := by
  sorry''',
 '改为有限、满支撑不变测度下的遍历性⇒拓扑传递单向结论。',
 '拓扑传递依赖拓扑，遍历性依赖选定不变测度；一般不能直接等价。',
 '原签名允许零测度：任意流对零测度均遍历，恒等流在ℝ上不拓扑传递。非零概率反例可取恒等流和单点Dirac测度。',
 ['仅保留疑误','另立满支撑测度下的单向结果'],'另立满支撑测度下的单向结果','缺由连续时间遍历性到满支撑正向拓扑传递的测度理论桥接。')
 add('FlowJacobianLiteral','''def variationalMatrixLiteral_corrected {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) ξ''',
 'DF_t取值点从F_t(ξ)改为初值ξ。',
 '对初值求导的Jacobian应在初值取值；把演化后位置再次代入是复合了不同取值点。',
 '全局sin向量场的流，ξ=π/2、t=log2时DF_t(ξ)=4/5，DF_t(F_tξ)=10/17。',
 ['批准另立','保留字面疑误'],'批准另立')
 old=ds['MD-1.7.2-VariationalEquationLiteral']['block']
 # This declaration occurs after the corrected definition in source order.
 code=old.replace('variationalequationliteral','variationalequationliteral_corrected',1).replace('variationalMatrixLiteral F','variationalMatrixLiteral_corrected F')
 add('VariationalEquationLiteral',code,'采用W(t)=DF_t(ξ)，保留C¹向量场及真实流资格。',
 '原W的取值点多复合一次F_t，时间微分产生额外链式项，不满足标准变分方程。',
 '同一全局sin流、ξ=π/2、t=log2：原W=10/17，W′=−198/289，但f′(F_tξ)W=−102/289。',
 ['批准另立','保留字面疑误'],'批准另立','缺一般非线性流对初值的可微依赖及参数/时间微分交换；常系数定理范围不足。')
 old=ds['MD-1.7.2-NearbyTrajectoryLiteral']['block']
 code=old.replace('nearby_trajectory_literal','nearby_trajectory_literal_corrected',1).replace('variationalMatrixLiteral F','variationalMatrixLiteral_corrected F')
 code=code.rsplit('  sorry',1)[0]+'''  intro n F hF t ξ
  exact ((hF t).differentiable (by norm_num) ξ).hasFDerivAt.isLittleO'''
 add('NearbyTrajectoryLiteral',code,'线性化在初值ξ处取DF_t，固定t的余项为o(扰动)。',
 '错误取值点的导数通常与真实DF_t(ξ)不同，差额线性项不是小o。',
 '同一sin流在指定点的两个导数4/5和10/17不相等；其差乘初值扰动保留一阶项。',
 ['批准另立','保留字面疑误'],'批准另立')
 p.write_text(text,encoding='utf-8');dump(OUT/'ERRATA_RECORDS.json',rows)
 print('Prepared',len(rows),'dual-version groups; NOT yet compiled')

if __name__=='__main__':apply()
