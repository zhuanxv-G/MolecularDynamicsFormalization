# BATCH18 第7章原文与陈述审校

## MD-7.12-MEVMEAlgorithm
```json
{
  "source_id": "MD-7.12-MEVMEAlgorithm",
  "kind": "definition",
  "label": null,
  "section": "7.12",
  "printed_page": "318–319",
  "pdf_page": "339–340",
  "statement_latex": "Midpoint Euler - Verlet - Midpoint Euler (see [232])\n\\[p_{n+1/4}=p_n-\\tfrac{h\\gamma}4(p_n+p_{n+1/4})+\\sqrt{h\\gamma k_BTM}R_n-g'(q_n)^T\\lambda_{n+1/4},\\quad g'(q_n)M^{-1}p_{n+1/4}=0.\\]\n\\[p_{n+1/2}=p_{n+1/4}-\\tfrac h2\\nabla U(q_n)-g'(q_n)^T\\lambda_{n+1/2},\\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\]\n\\[p_{n+3/4}=p_{n+1/2}-\\tfrac h2\\nabla U(q_{n+1})-g'(q_{n+1})^T\\lambda_{n+3/4},\\quad g'(q_{n+1})M^{-1}p_{n+3/4}=0,\\quad g(q_{n+1})=0.\\]\n\\[p_{n+1}=p_{n+3/4}-\\tfrac{h\\gamma}4(p_{n+3/4}+p_{n+1})+\\sqrt{h\\gamma k_BTM}R_{n+1/2}-g'(q_{n+1})^T\\lambda_{n+1},\\quad g'(q_{n+1})M^{-1}p_{n+1}=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "完整记录全部中间动量、乘子和位置/隐约束；隐式关系不声称求解器存在唯一。R,S为独立标准Gaussian向量的资格由使用时另加vectorNormalSequence。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.midpointConstrainedORelation",
  "lean_declarations": [
    "MD.Ch07.midpointConstrainedORelation",
    "MD.Ch07.constrainedVerletRelation",
    "MD.Ch07.mevmeRelation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def midpointConstrainedORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R out : V n) (multiplier : V l) : Prop :=
  (∀ i, out i = p i-h*γ/4*(p i+out i)+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i) ∧
  hiddenConstraint m g (q,out)
def constrainedVerletRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (h : ℝ)
    (x out : Phase n) (ph : V n) (multiplier μ : V l) : Prop :=
  (∀ i, ph i = x.2 i-h/2*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
  (∀ i, out.1 i = x.1 i+h/m i*ph i) ∧
  (∀ i, out.2 i = ph i-h/2*gradient U out.1 i-constraintReaction g out.1 μ i) ∧
  out ∈ cotangentConstraint m g
def mevmeRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (γ θ h : ℝ)
    (R S : V n) (x out : Phase n) : Prop :=
  ∃ pa ph pb : V n, ∃ multipliera multiplierb multiplierc multiplierd : V l,
    midpointConstrainedORelation m g γ θ h x.1 x.2 R pa multipliera ∧
    constrainedVerletRelation m g U h (x.1,pa) (out.1,pb) ph multiplierb multiplierc ∧
    midpointConstrainedORelation m g γ θ h out.1 pb S out.2 multiplierd
```

## MD-7.12-MidpointStabilityPrinted
```json
{
  "source_id": "MD-7.12-MidpointStabilityPrinted",
  "kind": "unnumbered_claim",
  "label": "(7.46)",
  "section": "7.12",
  "printed_page": "319",
  "pdf_page": "340",
  "statement_latex": "The Lagrange multiplier $\\lambda_{n+1/4}$ (and likewise $\\lambda_{n+1}$) can be obtained by solving the linear system\n\\[g'(q_n)M^{-1}[(1-h\\gamma/4)p_n+\\sqrt{h\\gamma k_BTM}R_n-g'(q_n)^T\\lambda_{n+1/4}]=0,\\]\nwhich is easily computed once the $R_n$ vector is evaluated in the step, and gives us a stability criterion\n\\[\\gamma h<4.\\tag{7.46}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "原文版仅保留γh<4条件，不增添充要关系；补充结论仅针对中点OU衰减模态。a=8说明γh<4不是该单独模态稳定的必要条件，不反驳原书整套算法的充分条件。"
  ],
  "issues": [
    "已目视核对PDF340／印刷319：所印γh<4保留为原书给出的限制。它保证中点OU放大因子为正；OU线性绝对稳定性本身对γh≥0均成立。原文没有写充要关系，不能把本条当作已确认的原书错误。完整耦合Verlet仍有独立步长限制。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.multiplierLinearSystem",
  "lean_declarations": [
    "MD.Ch07.multiplierLinearSystem",
    "MD.Ch07.midpointAmplification",
    "MD.Ch07.midpointStabilityPrinted",
    "MD.Ch07.midpointStabilityPrinted_corrected",
    "MD.Ch07.midpointStability_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def multiplierLinearSystem {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R : V n) (multiplier : V l) : Prop :=
  hiddenConstraint m g (q,fun i ↦ (1-h*γ/4)*p i+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i)
def midpointAmplification (a : ℝ) : ℝ := (1-a/4)/(1+a/4)
def midpointStabilityPrinted (a : ℝ) : Prop := a < 4
theorem midpointStabilityPrinted_corrected (a : ℝ) (ha : 0 ≤ a) : |midpointAmplification a| ≤ 1 := by
  unfold midpointAmplification
  rw [abs_le]
  constructor
  · apply (le_div_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
  · apply (div_le_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
theorem midpointStability_counterexample : |midpointAmplification 8| ≤ 1 ∧ ¬ (8 : ℝ) < 4 := by
  norm_num [midpointAmplification]
```

## MD-7.12.1-ConstrainedABOSplitting
```json
{
  "source_id": "MD-7.12.1-ConstrainedABOSplitting",
  "kind": "definition",
  "label": null,
  "section": "7.12.1",
  "printed_page": "319–320",
  "pdf_page": "340–341",
  "statement_latex": "\\[A_c:\\quad dq=M^{-1}pdt,\\quad dp=-g'(q)^T\\lambda dt,\\quad g(q)=0,\\]\n\\[B_c:\\quad dq=0,\\quad dp=-\\nabla U(q)dt-g'(q)^T\\lambda dt,\\quad g(q)=0,\\]\n\\[O_c:\\quad dq=0,\\quad dp=-\\gamma pdt+\\sqrt{2\\gamma k_BTM}dW-g'(q)^T\\lambda dt,\\quad g(q)=0.\\]\nObserve that the holonomic constraint (as well as the hidden constraint) is maintained in each part, changing the usual A piece into a geodesic drift along the manifold defined by $g(q)=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "Ac为已存在的完整光滑约束流，F0=id及流合成律完整；Bc/Oc为乘子线性求解关系。规则保持约束写在关系中，不把乘子求解存在性计为已证。",
    "正质量、约束Jacobian满秩和γ≥0,θ>0,h≥0由求解器应用时另加；Oc噪声R必须独立标准Gaussian。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.constrainedAField",
  "lean_declarations": [
    "MD.Ch07.constrainedAField",
    "MD.Ch07.constrainedBField",
    "MD.Ch07.geodesicConstraintFlow",
    "MD.Ch07.constrainedKickRelation",
    "MD.Ch07.constrainedExactORelation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constrainedAField {l : ℕ} (m : V n) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -constraintReaction g x.1 multiplier i)
def constrainedBField {l : ℕ} (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def geodesicConstraintFlow {l : ℕ} (m : V n) (g : V n → V l) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧
  ∀ x ∈ cotangentConstraint m g, ∃ multiplier : ℝ → V l, ∀ t,
    F t x ∈ cotangentConstraint m g ∧ HasDerivAt (fun s ↦ F s x) (constrainedAField m g (multiplier t) (F t x)) t
def constrainedKickRelation {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (h : ℝ) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = x.2 i-h*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
def constrainedExactORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (R : V n) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = ouMomentum m γ θ h x.2 R i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
```

## MD-7.12.1-ConstrainedBAOABAlgorithm
```json
{
  "source_id": "MD-7.12.1-ConstrainedBAOABAlgorithm",
  "kind": "definition",
  "label": null,
  "section": "7.12.1",
  "printed_page": "320",
  "pdf_page": "341",
  "statement_latex": "c-$[BAOAB]$\n\\[p_{n+1/5}=p_n-\\tfrac h2\\nabla U(q_n)-g'(q_n)^T\\lambda_{n+1/3},\\quad g'(q_n)M^{-1}p_{n+1/5}=0.\\]\nSolve the geodesic flow $A_c$ for $h/2$, and map $[q_n,p_{n+1/5}]\\to[q_{n+1/2},p_{n+2/5}]$.\n\\[p_{n+3/5}=e^{-\\gamma h}p_{n+2/5}+\\sqrt{(1-e^{-2\\gamma h})k_BTM}R_n-g'(q_{n+1/2})^T\\lambda_{n+2/3},\\quad g'(q_{n+1/2})M^{-1}p_{n+3/5}=0.\\]\nSolve the geodesic flow $A_c$ for $h/2$, and map $[q_{n+1/2},p_{n+3/5}]\\to[q_{n+1},p_{n+4/5}]$.\n\\[p_{n+1}=p_{n+4/5}-\\tfrac h2\\nabla U(q_{n+1})-g'(q_{n+1})^T\\lambda_{n+1},\\quad g'(q_{n+1})M^{-1}p_{n+1}=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "完整五段关系、全部中间变量与隐约束；仅证明成功求解后的终点资格，不证明隐式解存在、唯一或概率不变性。网站包须同时摘录geodesicConstraintFlow、两求解关系和选择规格。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.constrainedBAOABRelation",
  "lean_declarations": [
    "MD.Ch07.constrainedBAOABRelation",
    "MD.Ch07.constrainedBAOAB_constraint"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constrainedBAOABRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n) : Prop :=
  geodesicConstraintFlow m g F ∧ ∃ b o : Phase n,
    constrainedKickRelation m U g (h/2) x b ∧
    constrainedExactORelation m g γ θ h R (F (h/2) b) o ∧
    constrainedKickRelation m U g (h/2) (F (h/2) o) out
theorem constrainedBAOAB_constraint {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n)
    (hs : constrainedBAOABRelation m g U F γ θ h R x out) : out ∈ cotangentConstraint m g := by
  obtain ⟨_,b,o,_,_,hout⟩ := hs
  exact hout.2.choose_spec.2
```

## MD-7.12.1-ApproximateGeodesicOrder
```json
{
  "source_id": "MD-7.12.1-ApproximateGeodesicOrder",
  "kind": "definition",
  "label": null,
  "section": "7.12.1",
  "printed_page": "320",
  "pdf_page": "341",
  "statement_latex": "We do not necessarily need to solve the geodesic flow exactly in practice, though for the purposes of analysis we shall assume we do. If we are considering a second order scheme, then solving the $A_c$ piece to at least second order would be sufficient to preserve the overall order of the scheme, although a scheme may have potentially better accuracy and stability properties if a higher order solve is used.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。"
  ],
  "issues": [],
  "statement_scope": "局部二阶替换的目标资格；从该资格推出随机全局/不变分布阶数尚未陈述完整定理。",
  "lean_decl": "MD.Ch07.localMapErrorBound",
  "lean_declarations": [
    "MD.Ch07.localMapErrorBound",
    "MD.Ch07.geodesicReplacementSecondOrder"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def localMapErrorBound {E : Type*} [NormedAddCommGroup E] (F G : ℝ → E → E) (D : Set E) (r : ℕ) : Prop :=
  ∃ C ≥ 0, ∃ δ > 0, ∀ h ∈ Set.Ioo 0 δ, ∀ x ∈ D, ‖F h x-G h x‖ ≤ C*h^(r+1)
def geodesicReplacementSecondOrder {E : Type*} [NormedAddCommGroup E]
    (exact approx : ℝ → E → E) (D : Set E) : Prop := localMapErrorBound exact approx D 2
```
