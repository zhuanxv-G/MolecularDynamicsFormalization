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
