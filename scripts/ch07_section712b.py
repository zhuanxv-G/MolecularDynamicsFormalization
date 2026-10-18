from ch07_data import add, EXCLUDED

add('MidpointStabilityPrinted','7.12',319,
r'''The Lagrange multiplier $\lambda_{n+1/4}$ (and likewise $\lambda_{n+1}$) can be obtained by solving the linear system
\[g'(q_n)M^{-1}[(1-h\gamma/4)p_n+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4}]=0,\]
which is easily computed once the $R_n$ vector is evaluated in the step, and gives us a stability criterion
\[\gamma h<4.\tag{7.46}\]''',
'''def multiplierLinearSystem {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R : V n) (λ : V l) : Prop :=
  hiddenConstraint m g (q,fun i ↦ (1-h*γ/4)*p i+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q λ i)
def midpointAmplification (a : ℝ) : ℝ := (1-a/4)/(1+a/4)
def midpointStabilityPrinted (a : ℝ) : Prop := |midpointAmplification a| ≤ 1 ↔ a < 4
theorem midpointStabilityPrinted_corrected (a : ℝ) (ha : 0 ≤ a) : |midpointAmplification a| ≤ 1 := by
  unfold midpointAmplification
  rw [abs_le]
  constructor <;> (apply (le_div_iff₀ (by positivity : 0 < 1+a/4)).2 <;> nlinarith)
theorem midpointStability_counterexample : |midpointAmplification 8| ≤ 1 ∧ ¬ (8 : ℝ) < 4 := by
  norm_num [midpointAmplification]''',label='(7.46)',
issues=['已目视核对PDF340／印刷319：所印γh<4是中点OU放大因子非负的条件，而非线性绝对稳定性的必要条件。隐式中点OU对γh≥0满足|r|≤1；γh=8给反例。完整耦合Verlet仍有其独立步长限制。'],
extra=['原文版以声称的稳定充要式单列目标且不证明；修正版仅针对中点OU衰减模态，不把它推广为完整MEVME无条件稳定。'],verdict='NEEDS_HUMAN')

add('ConstrainedABOSplitting','7.12.1','319–320',
r'''\[A_c:\quad dq=M^{-1}pdt,\quad dp=-g'(q)^T\lambda dt,\quad g(q)=0,\]
\[B_c:\quad dq=0,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,\]
\[O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.\]
Observe that the holonomic constraint (as well as the hidden constraint) is maintained in each part, changing the usual A piece into a geodesic drift along the manifold defined by $g(q)=0$.''',
'''def constrainedAField {l : ℕ} (m : V n) (g : V n → V l) (λ : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -constraintReaction g x.1 λ i)
def constrainedBField {l : ℕ} (U : V n → ℝ) (g : V n → V l) (λ : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 λ i)
def geodesicConstraintFlow {l : ℕ} (m : V n) (g : V n → V l) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧
  ∀ x ∈ cotangentConstraint m g, ∃ λ : ℝ → V l, ∀ t,
    F t x ∈ cotangentConstraint m g ∧ HasDerivAt (fun s ↦ F s x) (constrainedAField m g (λ t) (F t x)) t
def constrainedKickRelation {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (h : ℝ) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ λ : V l, (∀ i, out.2 i = x.2 i-h*gradient U x.1 i-constraintReaction g x.1 λ i) ∧
    out ∈ cotangentConstraint m g
def constrainedExactORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (R : V n) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ λ : V l, (∀ i, out.2 i = ouMomentum m γ θ h x.2 R i-constraintReaction g x.1 λ i) ∧
    out ∈ cotangentConstraint m g''',kind='definition',
extra=['Ac为已存在的完整光滑约束流，F0=id及流合成律完整；Bc/Oc为乘子线性求解关系。规则保持约束写在关系中，不把乘子求解存在性计为已证。','正质量、约束Jacobian满秩和γ≥0,θ>0,h≥0由求解器应用时另加；Oc噪声R必须独立标准Gaussian。'])

add('ConstrainedBAOABAlgorithm','7.12.1',320,
r'''c-$[BAOAB]$
\[p_{n+1/5}=p_n-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/3},\quad g'(q_n)M^{-1}p_{n+1/5}=0.\]
Solve the geodesic flow $A_c$ for $h/2$, and map $[q_n,p_{n+1/5}]\to[q_{n+1/2},p_{n+2/5}]$.
\[p_{n+3/5}=e^{-\gamma h}p_{n+2/5}+\sqrt{(1-e^{-2\gamma h})k_BTM}R_n-g'(q_{n+1/2})^T\lambda_{n+2/3},\quad g'(q_{n+1/2})M^{-1}p_{n+3/5}=0.\]
Solve the geodesic flow $A_c$ for $h/2$, and map $[q_{n+1/2},p_{n+3/5}]\to[q_{n+1},p_{n+4/5}]$.
\[p_{n+1}=p_{n+4/5}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.\]''',
'''def constrainedBAOABRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n) : Prop :=
  geodesicConstraintFlow m g F ∧ ∃ b o : Phase n,
    constrainedKickRelation m U g (h/2) x b ∧
    constrainedExactORelation m g γ θ h R (F (h/2) b) o ∧
    constrainedKickRelation m U g (h/2) (F (h/2) o) out
theorem constrainedBAOAB_constraint {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n)
    (hs : constrainedBAOABRelation m g U F γ θ h R x out) : out ∈ cotangentConstraint m g := by
  obtain ⟨_,b,o,_,_,hout⟩ := hs
  exact hout.2.choose_spec.2''',kind='definition',
extra=['完整五段关系、全部中间变量与隐约束；仅证明成功求解后的终点资格，不证明隐式解存在、唯一或概率不变性。网站包须同时摘录geodesicConstraintFlow、两求解关系和选择规格。'])

add('ApproximateGeodesicOrder','7.12.1',320,
r'''We do not necessarily need to solve the geodesic flow exactly in practice, though for the purposes of analysis we shall assume we do. If we are considering a second order scheme, then solving the $A_c$ piece to at least second order would be sufficient to preserve the overall order of the scheme, although a scheme may have potentially better accuracy and stability properties if a higher order solve is used.''',
'''def localMapErrorBound {E : Type*} [NormedAddCommGroup E] (F G : ℝ → E → E) (D : Set E) (r : ℕ) : Prop :=
  ∃ C ≥ 0, ∃ δ > 0, ∀ h ∈ Set.Ioo 0 δ, ∀ x ∈ D, ‖F h x-G h x‖ ≤ C*h^(r+1)
def geodesicReplacementSecondOrder {E : Type*} [NormedAddCommGroup E]
    (exact approx : ℝ → E → E) (D : Set E) : Prop := localMapErrorBound exact approx D 2''',kind='definition',
extra=['用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。'],
scope='局部二阶替换的目标资格；从该资格推出随机全局/不变分布阶数尚未陈述完整定理。',verdict='NEEDS_HUMAN')
EXCLUDED.append({'section':'7.12.1','printed_page':'320–322','reason':'233个刚性水分子、Fig.7.11–7.12、SETTLE/NAMD实现和平均能量经验误差/最大步长排序不作待证；Ac近似求解保阶的数学主张单独登记。'})
