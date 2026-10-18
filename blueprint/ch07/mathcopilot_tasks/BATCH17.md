# BATCH17 第7章原文与陈述审校

## MD-7.9.3-ZeroFrictionVerlet
```json
{
  "source_id": "MD-7.9.3-ZeroFrictionVerlet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.3",
  "printed_page": "306",
  "pdf_page": "327",
  "statement_latex": "An exact Ornstein-Uhlenbeck solve can be added where it is required in the scheme in order to effectively integrate Langevin dynamics: then setting $\\gamma=0$ reduces the integrator to a standard Verlet scheme, integrating deterministic Newtonian dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "OU为恒等映射及BAOAB合并成BAB的函数恒等式；其他字母排列得到ABA或BAB，不一概声称同一种Verlet。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.zeroFrictionOU",
  "lean_declarations": [
    "MD.Ch07.zeroFrictionOU",
    "MD.Ch07.zeroFrictionBAOAB"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem zeroFrictionOU (m : V n) (θ h : ℝ) (R : V n) (x : Phase n) : ouStep m 0 θ h R x = x := by
  ext i <;> simp [ouStep,ouMomentum]
theorem zeroFrictionBAOAB (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) :
    baoab m U 0 θ h R = kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) := by
  sorry
```

## MD-7.11.1-TemperatureObservables
```json
{
  "source_id": "MD-7.11.1-TemperatureObservables",
  "kind": "unnumbered_claim",
  "label": "(7.41)–(7.42)",
  "section": "7.11.1",
  "printed_page": "310",
  "pdf_page": "331",
  "statement_latex": "Indeed, calculating the temperature of the system from an average of kinetic energy by\n\\[N_dk_BT=\\langle p^TM^{-1}p\\rangle,\\tag{7.41}\\]\ngives a similar problem. Using Proposition 6.1 we may formulate many alternative functions whose averages are proportional to the system temperature. In the following experiments we shall use the configurational temperature\n\\[N_dk_BT=\\langle q\\cdot\\nabla U(q)\\rangle.\\tag{7.42}\\]\nWere one able to solve the dynamics exactly, the kinetic and configurational temperatures would of course be equal.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "无约束n个独立坐标时Nd=n，θ=1/β；约束减少自由度时不能直接用此n公式。",
    "构型温度需真实归一位置Gibbs、可积和边界通量条件；数值分布下两种温度不必一致，不声称该等式对离散链自动成立。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.kineticTemperatureObservable",
  "lean_declarations": [
    "MD.Ch07.kineticTemperatureObservable",
    "MD.Ch07.configurationTemperatureObservable",
    "MD.Ch07.kineticTemperature",
    "MD.Ch07.configurationTemperature"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def kineticTemperatureObservable (m : V n) (x : Phase n) : ℝ := ∑ i, x.2 i^2/m i
def configurationTemperatureObservable (U : V n → ℝ) (q : V n) : ℝ := ∑ i, q i*gradient U q i
theorem kineticTemperature (m : V n) (U : V n → ℝ) (β : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hprob : IsProbabilityMeasure (positionGibbs U β)) :
    (∫ x, kineticTemperatureObservable m x ∂productGibbs m U β) = (n : ℝ)/β := by
  sorry
theorem configurationTemperature (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ 1 U)
    (hw : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hZ : 0 < ∫ q, Real.exp (-β*U q))
    (hint : ∀ i, Integrable (fun q ↦ q i*gradient U q i*Real.exp (-β*U q)) volume)
    (hb : ∀ q i, Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, configurationTemperatureObservable U q ∂positionGibbs U β) = (n : ℝ)/β := by
  sorry
```

## MD-7.11.1-VelocityAutocorrelationDefinition
```json
{
  "source_id": "MD-7.11.1-VelocityAutocorrelationDefinition",
  "kind": "definition",
  "label": null,
  "section": "7.11.1",
  "printed_page": "310",
  "pdf_page": "331",
  "statement_latex": "The self-diffusion coefficient gives a metric quantifying the diffusion rate. It is often used as a way to compare the rate of phase space exploration between methods, and is typically calculated using the integral of the velocity auto-correlation function. However, in theory one can construct arbitrary methods to artificially scale the velocity auto-correlation function, hence giving inaccurate diffusion constants: the momentum sampled may not be the momentum we use to propagate the position with.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "原文未给常数因子的显式Green–Kubo式；此处按各向同性n维标准归一记录1/n，仅在P概率、速度平稳、中心化且自相关可积等资格下解释为物理扩散率。",
    "已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.velocityAutocorrelation",
  "lean_declarations": [
    "MD.Ch07.velocityAutocorrelation",
    "MD.Ch07.greenKuboDiffusion",
    "MD.Ch07.autocorrelation_rescale"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def velocityAutocorrelation (P : Measure Ω) (v : ℝ → Ω → V n) (t : ℝ) : ℝ :=
  ∫ sample, ∑ i, v 0 sample i*v t sample i ∂P
def greenKuboDiffusion (P : Measure Ω) (v : ℝ → Ω → V n) : ℝ :=
  (n : ℝ)⁻¹*∫ t in Set.Ioi (0 : ℝ), velocityAutocorrelation P v t
theorem autocorrelation_rescale (P : Measure Ω) (v : ℝ → Ω → V n) (c t : ℝ) :
    velocityAutocorrelation P (fun t sample i ↦ c*v t sample i) t = c^2*velocityAutocorrelation P v t := by
  simp only [velocityAutocorrelation]
  have heq : ∀ sample, (∑ i, (c*v 0 sample i)*(c*v t sample i)) = c^2*(∑ i, v 0 sample i*v t sample i) := by
    intro sample
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  simp_rw [heq]
  rw [integral_const_mul]
```

## MD-7.12-ConstrainedLangevin
```json
{
  "source_id": "MD-7.12-ConstrainedLangevin",
  "kind": "definition",
  "label": "(7.43)–(7.45)",
  "section": "7.12",
  "printed_page": "317",
  "pdf_page": "338",
  "statement_latex": "\\[dq=M^{-1}pdt,\\tag{7.43}\\]\n\\[dp=-\\nabla U(q)dt-\\gamma pdt+\\sqrt{2\\gamma k_BTM}dW-g'(q)^T\\lambda dt,\\tag{7.44}\\]\n\\[0=g(q).\\tag{7.45}\\]\nThe vector of $l$ constraints is given by $g:\\mathbb R^{N_c}\\to\\mathbb R^l$ and $\\lambda$ is an $l$-dimensional vector of Lagrange multipliers. $W$ is a vector of standard Wiener processes, with the usual friction parameter $\\gamma>0$. Permissible phase points lie in the co-tangent bundle defined by the constraint and hidden constraint\n\\[g(q)=0,\\qquad g'(q)M^{-1}p=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "实际多维Wiener坐标独立、正质量/温度/摩擦、C²约束、积分可积明示；常系数噪声用真实W增量。",
    "定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。"
  ],
  "issues": [],
  "statement_scope": "全部约束积分方程及隐约束资格；适应性作为解资格显式保留，存在唯一性未证明。",
  "lean_decl": "MD.Ch07.constraintJacobian",
  "lean_declarations": [
    "MD.Ch07.constraintJacobian",
    "MD.Ch07.constraintReaction",
    "MD.Ch07.hiddenConstraint",
    "MD.Ch07.cotangentConstraint",
    "MD.Ch07.constrainedLangevin"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constraintJacobian {l : ℕ} (g : V n → V l) (q : V n) (j : Fin l) (i : Fin n) : ℝ :=
  coordDerivative (fun x ↦ g x j) q i
def constraintReaction {l : ℕ} (g : V n → V l) (q : V n) (multiplier : V l) : V n :=
  fun i ↦ ∑ j, constraintJacobian g q j i*multiplier j
def hiddenConstraint {l : ℕ} (m : V n) (g : V n → V l) (x : Phase n) : Prop :=
  ∀ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i)) = 0
def cotangentConstraint {l : ℕ} (m : V n) (g : V n → V l) : Set (Phase n) :=
  {x | g x.1 = 0 ∧ hiddenConstraint m g x}
def constrainedLangevin {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l) (U : V n → ℝ)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (Λ : ℝ → Ω → V l)
    (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧
  x0 ∈ cotangentConstraint m g ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (Λ t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i-γ*(X s sample).2 i-
      constraintReaction g (X s sample).1 (Λ s sample) i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    X t sample ∈ cotangentConstraint m g ∧
    (∀ i, (X t sample).1 i = x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i/m i) ∧
    (∀ i, (X t sample).2 i = x0.2 i+
      (∫ s in (0 : ℝ)..t, -gradient U (X s sample).1 i-γ*(X s sample).2 i-
        constraintReaction g (X s sample).1 (Λ s sample) i)+
      Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i))
```

## MD-7.12-ConstrainedCanonicalErgodicity
```json
{
  "source_id": "MD-7.12-ConstrainedCanonicalErgodicity",
  "kind": "definition",
  "label": null,
  "section": "7.12",
  "printed_page": "317",
  "pdf_page": "338",
  "statement_latex": "In the infinite time limit, we have that solution trajectories of constrained Langevin (7.43)–(7.45) sample $\\widetilde\\rho_\\beta$ ergodically, such that\n\\[\\lim_{T\\to\\infty}\\frac1T\\int_0^T\\phi(q(t),p(t))dt=\\int_{\\mathcal D}\\phi(q,p)\\widetilde\\rho_\\beta d\\omega,\\]\nwhere $\\widetilde\\rho_\\beta$ is the normalized constrained canonical distribution\n\\[\\widetilde\\rho_\\beta=Z^{-1}\\exp(-\\beta H(q,p))\\delta[g(q)]\\delta[g'(q)M^{-1}p],\\]\nfor normalizing constant $Z$ and where $\\delta[z]:=\\prod_i\\delta[z_i]$ for a vector $z$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "δ不是普通Lebesgue密度；用有支撑测度ν和正则化δ的弱积分极限规定其含义，不能用任意面测度替代而省略Jacobian因子。",
    "实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。"
  ],
  "issues": [],
  "statement_scope": "全部分布及遍历平均目标的测度定义；约束参考测度存在与具体过程的遍历定理仍缺。",
  "lean_decl": "MD.Ch07.constrainedCanonical",
  "lean_declarations": [
    "MD.Ch07.constrainedCanonical",
    "MD.Ch07.constrainedReference",
    "MD.Ch07.constrainedErgodicAverages"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constrainedCanonical (ν : Measure (Phase n)) (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  ν.withDensity (fun x ↦ ENNReal.ofReal (gibbsWeight m U β x/(∫ y, gibbsWeight m U β y ∂ν)))
def constrainedReference {l : ℕ} (ν : Measure (Phase n)) (m : V n) (g : V n → V l) : Prop :=
  ν (cotangentConstraint m g)ᶜ = 0 ∧
  ∀ φ : Phase n → ℝ, Continuous φ → HasCompactSupport φ →
    Filter.Tendsto (fun ε : ℝ ↦ ∫ x, φ x*(Real.pi*ε)^(-(l : ℝ))*
      Real.exp (-((∑ j, (g x.1 j)^2)+
        (∑ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i))^2))/ε))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 (∫ x, φ x ∂ν))
def constrainedErgodicAverages (P : Measure Ω) (X : ℝ → Ω → Phase n) (μ : Measure (Phase n)) : Prop :=
  IsProbabilityMeasure P ∧ IsProbabilityMeasure μ ∧
  ∀ φ : Phase n → ℝ, Integrable φ μ →
    ∀ᵐ sample ∂P, Filter.Tendsto (fun T : ℝ ↦ T⁻¹*∫ t in (0 : ℝ)..T, φ (X t sample)) Filter.atTop (𝓝 (∫ x, φ x ∂μ))
```

## MD-7.12-ConstrainedHOSplitting
```json
{
  "source_id": "MD-7.12-ConstrainedHOSplitting",
  "kind": "definition",
  "label": null,
  "section": "7.12",
  "printed_page": "318",
  "pdf_page": "339",
  "statement_latex": "We could instead consider splitting the dynamics up and performing the integration using a splitting method. One uses\n\\[H_c:\\quad dq=M^{-1}pdt,\\quad dp=-\\nabla U(q)dt-g'(q)^T\\lambda dt,\\quad g(q)=0,\\]\n\\[O_c:\\quad dq=0,\\quad dp=-\\gamma pdt+\\sqrt{2\\gamma k_BTM}dW-g'(q)^T\\lambda dt,\\quad g(q)=0.\\]\nWe solve these two pieces symmetrically, where the constrained Hamiltonian part is solved over a step $h$, in between two solves of the Ornstein-Uhlenbeck SDE with stepsize $h/2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "Hc、Oc分别使用各自乘子，不能将相同multiplier在求和中重复扣除；Oc噪声为前条真实Wiener常扩散项，向量场仅记录漂移。",
    "每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.constrainedHField",
  "lean_declarations": [
    "MD.Ch07.constrainedHField",
    "MD.Ch07.constrainedOField",
    "MD.Ch07.constrainedHOComposition"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constrainedHField {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def constrainedOField {l : ℕ} (g : V n → V l) (γ : ℝ) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -γ*x.2 i-constraintReaction g x.1 multiplier i)
def constrainedHOComposition {E : Type*} (H O : ℝ → E → E) (h : ℝ) : E → E := O (h/2) ∘ H h ∘ O (h/2)
```
