# BATCH05 第7章原文与陈述审校

## MD-7.3.1-WordConvention
```json
{
  "source_id": "MD-7.3.1-WordConvention",
  "kind": "definition",
  "label": null,
  "section": "7.3.1",
  "printed_page": "270",
  "pdf_page": "291",
  "statement_latex": "As a result we use the convention that if a letter appears $k$ times in a method's string, then each individual update piece uses a timestep $h/k$. For example, the scheme denoted $[OABAOBAO]$ has an update\n\\[\\mathcal U_h^{[OABAOBAO]}=\\mathcal U_{h/4}^O\\circ\\mathcal U_{h/3}^A\\circ\\mathcal U_{h/2}^B\\circ\\mathcal U_{h/4}^O\\circ\\mathcal U_{h/3}^A\\circ\\mathcal U_{h/2}^B\\circ\\mathcal U_{h/3}^A\\circ\\mathcal U_{h/4}^O,\\]\nwhere the random numbers used in each O update are independent. This scheme will require a total of $4N_c$ normal random numbers and two force evaluations per step (the force must be recomputed at the first B step following an A step); the number of force evaluations required is not directly related to the length of the string.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "原文图式照录3个h/4的O；修正版改3个h/3和3N_c随机数。力求值次数为实现说明，未形式化成本模型。",
    "每个O的向量噪声需联合独立标准正态；字母计数结论独立证明。"
  ],
  "issues": [
    "已目视核对PDF291／印刷270：字串OABAOBAO有3个O，所印复合也仅3个O，却各用h/4并称4N_c个正态数；不符前句每字母总时长h的约定。"
  ],
  "statement_scope": "完整复合图式、O计数及时间分配修正；力求值说明列于上下文，不声称已证明计算成本。",
  "lean_decl": "MD.Ch07.oabaobaoPrinted",
  "lean_declarations": [
    "MD.Ch07.oabaobaoPrinted",
    "MD.Ch07.oabaobaoPrinted_corrected",
    "MD.Ch07.oabaobaoCount"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def oabaobaoPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 3 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/4) (R 2) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/4) (R 1) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/4) (R 0)

def oabaobaoPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 3 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/3) (R 2) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/3) (R 1) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/3) (R 0)

theorem oabaobaoCount : (["O","A","B","A","O","B","A","O"] : List String).count "O" = 3 := by decide
```

## MD-7.3.1-SixSchemes
```json
{
  "source_id": "MD-7.3.1-SixSchemes",
  "kind": "definition",
  "label": null,
  "section": "7.3.1",
  "printed_page": "271",
  "pdf_page": "292",
  "statement_latex": "For reference and to remove any ambiguity, we write out some of these algorithms below as single timestep maps.\n\\[\\begin{array}{ll}\n[ABAO]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\\quad p_{n+1/2}=p_n-h\\nabla U(q_{n+1/2}),\\\\\n&q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1/2},\\quad p_{n+1}=e^{-h\\gamma}p_{n+1/2}+\\zeta_2M^{1/2}R_n;\\\\\n[BABO]:&p_{n+1/2}=p_n-(h/2)\\nabla U(q_n),\\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\\\\n&\\hat p_{n+1/2}=p_{n+1/2}-(h/2)\\nabla U(q_{n+1}),\\quad p_{n+1}=e^{-h\\gamma}\\hat p_{n+1/2}+\\zeta_2M^{1/2}R_n;\\\\\n[ABOBA]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\\quad p_{n+1/2}=p_n-(h/2)\\nabla U(q_{n+1/2}),\\\\\n&\\hat p_{n+1/2}=e^{-h\\gamma}p_{n+1/2}+\\zeta_2M^{1/2}R_n,\\\\\n&p_{n+1}=\\hat p_{n+1/2}-(h/2)\\nabla U(q_{n+1/2}),\\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1};\\\\\n[BAOAB]:&p_{n+1/2}=p_n-(h/2)\\nabla U(q_n),\\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\\\\\n&\\hat p_{n+1/2}=e^{-h\\gamma}p_{n+1/2}+\\zeta_2M^{1/2}R_n,\\\\\n&q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\\hat p_{n+1/2},\\quad p_{n+1}=\\hat p_{n+1/2}-(h/2)\\nabla U(q_{n+1});\\\\\n[OABAO]:&p_{n+1/2}=e^{-h\\gamma/2}p_n+\\zeta_1M^{1/2}R_n,\\\\\n&q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\\quad\\hat p_{n+1/2}=p_{n+1/2}-h\\nabla U(q_{n+1/2}),\\\\\n&q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\\hat p_{n+1/2},\\quad p_{n+1}=e^{-h\\gamma/2}\\hat p_{n+1/2}+\\zeta_1M^{1/2}R_{n+1/2};\\\\\n[OBABO]:&p_{n+1/2}=e^{-h\\gamma/2}p_n+\\zeta_1M^{1/2}R_n,\\quad\\hat p_{n+1/2}=p_{n+1/2}-(h/2)\\nabla U(q_n),\\\\\n&q_{n+1}=q_n+hM^{-1}\\hat p_{n+1/2},\\quad\\hat p_{n+1}=\\hat p_{n+1/2}-(h/2)\\nabla U(q_{n+1}),\\\\\n&p_{n+1}=e^{-h\\gamma/2}\\hat p_{n+1}+\\zeta_1M^{1/2}R_{n+1/2},\n\\end{array}\\]\nwhere $\\zeta_j=[k_BT(1-e^{-j\\gamma h})]^{1/2}$, and $R_n,R_{n+1/2}$ are $N_d$ vectors of standard independent $\\mathcal N(0,1)$ random variables, resampled at each step.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "BABO已定义于ABOBABO；其余5个完整复合依次对应所列中间步。",
    "R与S为同一步两次O的独立标准正态向量；跨步也独立，用vectorNormalSequence提供资格。",
    "原文最后“single evaluation”使用跨步缓存；实现成本不列为待证数学命题。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.abao",
  "lean_declarations": [
    "MD.Ch07.abao",
    "MD.Ch07.aboba",
    "MD.Ch07.baoab",
    "MD.Ch07.oabao",
    "MD.Ch07.obabo"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def abao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2)
def aboba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U (h/2) ∘ ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m (h/2)
def baoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def oabao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ (h/2) R
def obabo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ ouStep m γ θ (h/2) R
```

## MD-7.3.1-ConjugateIteration
```json
{
  "source_id": "MD-7.3.1-ConjugateIteration",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.3.1",
  "printed_page": "272",
  "pdf_page": "293",
  "statement_latex": "When iterated $n+1$ times, we can see the scheme $[OABA]$ produces a mapping of the form\n\\[(\\mathcal U_h^{[OABA]})^{n+1}=\\mathcal U_{h/2}^A\\circ\\mathcal U_{h/2}^B\\circ(\\mathcal U_h^{[BAOAB]})^n\\circ\\mathcal U_{h/2}^B\\circ\\mathcal U_{h/2}^A\\circ\\mathcal U_h^O;\\]\ntherefore through a coordinate transformation the $[OABA]$ method can be morphed into the $[BAOAB]$ scheme.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "compositionIterate是任意确定性映射的真实复合恒等式；实际随机迭代应在扩展噪声序列空间中使用更新映射，不能把固定R重复使用当独立重抽样。",
    "对所印OABA与BAOAB的随机分布/路径共轭仍需噪声移位包装，列入覆盖缺口；未把一般S,T恒等式冒称整段已覆盖。"
  ],
  "issues": [],
  "statement_scope": "有限复合恒等式及OABA单步映射；独立随机序列上的共轭解释未形式化。",
  "lean_decl": "MD.Ch07.compositionIterate",
  "lean_declarations": [
    "MD.Ch07.compositionIterate",
    "MD.Ch07.oaba"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem compositionIterate {D : Type*} (S T : D → D) (k : ℕ) :
    (S ∘ T)^[k+1] = S ∘ (T ∘ S)^[k] ∘ T := by
  funext x
  induction k with
  | zero => rfl
  | succ k ih =>
    simp only [Function.iterate_succ_apply', Function.comp_apply] at *
    rw [ih]

def oaba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R
```

## MD-7.3.2-SPVPrinted
```json
{
  "source_id": "MD-7.3.2-SPVPrinted",
  "kind": "definition",
  "label": null,
  "section": "7.3.2",
  "printed_page": "272",
  "pdf_page": "293",
  "statement_latex": "Stochastic Position Verlet (SPV)\n\\[q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\\qquad\np_{n+1}=e^{-h\\gamma}p_n-\\eta\\nabla U(q_n)+\\zeta M^{1/2}R_n,\\qquad\nq_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1}\\]\nwhere $\\eta=(1-e^{-h\\gamma})/\\gamma$, $\\zeta=[k_BT(1-e^{-2\\gamma h})]^{1/2}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "γ>0使用原印η商；γ=0的连续延拓η=h另需定义，不用实数除零总化声称正确。"
  ],
  "issues": [
    "已目视核对原页PDF293／印刷272：SPV展示式动量用∇U(q_n)，而前文说对两部分作对称积分，漂移半步后冻结位置应为q_{n+1/2}；两者分别保留，待导师判断。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.spvPrinted",
  "lean_declarations": [
    "MD.Ch07.spvPrinted",
    "MD.Ch07.spvPrinted_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def spvPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U x.1 i
  driftStep m (h/2) (qhalf,pnew)

def spvPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U qhalf i
  driftStep m (h/2) (qhalf,pnew)
```

## MD-7.3.2-SPVLargeFriction
```json
{
  "source_id": "MD-7.3.2-SPVLargeFriction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.3.2",
  "printed_page": "272–273",
  "pdf_page": "293–294",
  "statement_latex": "It is important to note that in the limit of infinite friction, we have $\\eta\\to0$ independent of the timestep $h$. This suggests that this splitting strategy is unsuitable for large choices of the parameter $\\gamma$ as the sampling will become inconsistent: the force will be dominated by the stochastic term, leaving the dynamics to evolve as a random walk.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "只表达明确的η极限；采样不一致的定性判断缺统一模型、时标与测试函数量化，不作为已证结论。"
  ],
  "issues": [],
  "statement_scope": "固定正h的η→0；随后的数值方法失效说明登记为适用范围讨论。",
  "lean_decl": "MD.Ch07.spvEtaLimit",
  "lean_declarations": [
    "MD.Ch07.spvEtaLimit"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem spvEtaLimit (h : ℝ) (hh : 0 < h) :
    Tendsto (fun γ : ℝ ↦ (1-Real.exp (-h*γ))/γ) atTop (𝓝 0) := by
  sorry
```

## MD-7.3.2-BBK
```json
{
  "source_id": "MD-7.3.2-BBK",
  "kind": "definition",
  "label": null,
  "section": "7.3.2",
  "printed_page": "273",
  "pdf_page": "294",
  "statement_latex": "Brünger-Brooks-Karplus (BBK)\n\\[p_{n+1/2}=(1-h\\gamma/2)p_n-(h/2)\\nabla U(q_n)+\\tfrac12\\sqrt{2k_BTh\\gamma}M^{1/2}R_n,\\]\n\\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\qquad\np_{n+1}=[p_{n+1/2}-(h/2)\\nabla U(q_{n+1})+\\tfrac12\\sqrt{2k_BTh\\gamma}M^{1/2}R'_n]/(1+h\\gamma/2).\\]\nOften $R'$ is chosen such that $R'_n=R_{n+1}$, so the random vector would be reused at the start of the following timestep, however there are many variants of this scheme that incorporate the redraw of random numbers differently. In other variants of BBK we take $R'_n=R_n$, reusing the random number within the step.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "h>0、γ≥0、θ>0、m_i>0时分母非零及噪声方差有效；不同R′耦合方案分别处理，不把独立与重用噪声混为一谈。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbk",
  "lean_declarations": [
    "MD.Ch07.bbk",
    "MD.Ch07.bbkSameNoise"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bbk (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) (x : Phase n) : Phase n :=
  let ph := fun i ↦ (1-h*γ/2)*x.2 i - (h/2)*gradient U x.1 i +
    (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*R i
  let q := (driftStep m h (x.1,ph)).1
  (q, fun i ↦ (ph i-(h/2)*gradient U q i + (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*S i)/(1+h*γ/2))

def bbkSameNoise (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) := bbk m U γ θ h R R
```
