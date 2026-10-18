# BATCH09 第7章原文与陈述审校

## MD-7.6-DivergenceFreeInvariant
```json
{
  "source_id": "MD-7.6-DivergenceFreeInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.6",
  "printed_page": "282",
  "pdf_page": "303",
  "statement_latex": "Given any divergence free vector field $f$, we have\n\\[-\\nabla\\cdot(f\\rho)=-f\\cdot\\nabla\\rho,\\]\nthus $\\mathcal L_f^\\dagger\\rho=-\\mathcal L_f\\rho$.\nIf $\\mathcal L_f$ preserves a first integral $I$, then $\\mathcal L_f$ preserves any distribution which is a function of $I$. It follows that any energy-preserving, divergence free vector field will always preserve the Gibbs distribution.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "微分对象C¹，第一积分和散度为实际导数；密度非负及归一化需g另行满足，此微分恒等式不把任意g都称概率密度。",
    "不变生成元到全局流不变测度仍需完整流/输运桥，见HamiltonianGibbs。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.lieField",
  "lean_declarations": [
    "MD.Ch07.lieField",
    "MD.Ch07.divergenceField",
    "MD.Ch07.forwardField",
    "MD.Ch07.divergenceFreeInvariant",
    "MD.Ch07.firstIntegral_density"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def lieField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  (fderiv ℝ ρ x) (f x)
def divergenceField (f : V n → V n) (x : V n) : ℝ :=
  ∑ i, coordDerivative (fun y ↦ f y i) x i
def forwardField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  -∑ i, coordDerivative (fun y ↦ f y i*ρ y) x i
theorem divergenceFreeInvariant (f : V n → V n) (ρ : V n → ℝ)
    (hf : ContDiff ℝ 1 f) (hρ : ContDiff ℝ 1 ρ)
    (hdiv : ∀ x, divergenceField f x = 0) : ∀ x, forwardField f ρ x = -lieField f ρ x := by
  sorry
theorem firstIntegral_density (f : V n → V n) (I : V n → ℝ) (g : ℝ → ℝ)
    (hI : Differentiable ℝ I) (hg : Differentiable ℝ g)
    (hfirst : ∀ x, lieField f I x = 0) : ∀ x, lieField f (g ∘ I) x = 0 := by
  intro x
  rw [lieField, fderiv_comp x (hg (I x)) (hI x)]
  simp only [ContinuousLinearMap.comp_apply]
  change (fderiv ℝ g (I x)) (lieField f I x) = 0
  rw [hfirst x, map_zero]
```

## MD-7.6-GeMarsdenRestriction
```json
{
  "source_id": "MD-7.6-GeMarsdenRestriction",
  "kind": "definition",
  "label": null,
  "section": "7.6",
  "printed_page": "282",
  "pdf_page": "303",
  "statement_latex": "All symplectic methods preserve the volume, but for a system with no first integrals except the energy, it is known from a theorem of Ge and Marsden [400] that a symplectic method cannot preserve the system energy exactly (unless the symplectic method is itself a time-reparameterization of the exact solution).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "原文引用的Ge–Marsden定理未列非可积性、局部性及精确流的全部技术条件；仅定义其非可积性和结论形式，未把geMarsdenConclusion宣称为真。",
    "辛映射体积保持和Ge–Marsden结论均列入本条覆盖缺口，不能把该定义当成定理已证。"
  ],
  "issues": [],
  "statement_scope": "原文数学主张已登记；Lean给出结论形式和第一积分资格，尚缺可核定的完整定理前提与定理陈述。",
  "lean_decl": "MD.Ch07.onlyEnergyIntegrals",
  "lean_declarations": [
    "MD.Ch07.onlyEnergyIntegrals",
    "MD.Ch07.timeReparametrizes",
    "MD.Ch07.geMarsdenConclusion"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def onlyEnergyIntegrals (H : V n → ℝ) (f : V n → V n) : Prop :=
  ∀ I : V n → ℝ, ContDiff ℝ ⊤ I → (∀ x, lieField f I x = 0) →
    ∃ g : ℝ → ℝ, I = g ∘ H
def timeReparametrizes {E : Type*} (G flow : ℝ → E → E) : Prop :=
  ∃ τ : ℝ → E → ℝ, ∀ h x, G h x = flow (τ h x) x
def geMarsdenConclusion {k : ℕ}
    (H : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (G flow : ℝ → MolecularDynamics.SymplecticCoordinates k → MolecularDynamics.SymplecticCoordinates k) : Prop :=
  MolecularDynamics.Chapter02Review.symplecticIntegrator G →
  (∀ h x, H (G h x) = H x) → timeReparametrizes G flow
```

## MD-7.6-JSplitting
```json
{
  "source_id": "MD-7.6-JSplitting",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.6",
  "printed_page": "282–283",
  "pdf_page": "303–304",
  "statement_latex": "Let $J$ be the skew-symmetric canonical symplectic structure matrix. The idea is to consider a splitting of $J$ into a finite number $K$ of skew-symmetric matrices $J_i$, $i=1,\\ldots,K$. This induces a splitting of the Hamiltonian vector field into $K$ vector fields $f_i=J_i\\nabla H$. Each of these vector fields preserves $H$ and, because they are themselves Hamiltonian, their flows are also volume-preserving. Assuming each such vector field is exactly integrable, the system dynamics may be approximated by composing the flow maps for each vector field.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "Ji取常系数反对称矩阵，H为C²；一般退化Ji并非标准坐标辛矩阵，但能量/散度两个实际导数结论仍有意义。",
    "体积保持需要已存在的完整光滑流；本条不新建流存在及Liouville理论。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.jField",
  "lean_declarations": [
    "MD.Ch07.jField",
    "MD.Ch07.jSplitting_energy",
    "MD.Ch07.composition_preservesEnergy"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def jField (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ) (x : V n) : V n :=
  fun i ↦ ∑ j, J i j * gradient H x j
theorem jSplitting_energy (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ)
    (hJ : ∀ i j, J i j = -J j i) (hH : ContDiff ℝ 2 H) :
    ∀ x, lieField (jField J H) H x = 0 ∧ divergenceField (jField J H) x = 0 := by
  sorry
theorem composition_preservesEnergy {E : Type*} (F G : E → E) (H : E → ℝ)
    (hF : ∀ x, H (F x) = H x) (hG : ∀ x, H (G x) = H x) :
    ∀ x, H ((F ∘ G) x) = H x := by
  intro x
  rw [Function.comp_apply, hF, hG]
```

## MD-7.6-CoordinateJSplitting
```json
{
  "source_id": "MD-7.6-CoordinateJSplitting",
  "kind": "definition",
  "label": null,
  "section": "7.6",
  "printed_page": "283",
  "pdf_page": "304",
  "statement_latex": "As an example of such a $J$-splitting, we may take $K=N_c$ with each $J_i$ to be defined by the components of the canonical symplectic structure matrix having to do with the $i$th position and momentum pair, thus the equations of motion for the $i$th vector field become\n\\[\\dot q_i=p_i/m_i,\\qquad \\dot p_i=-\\frac{\\partial U}{\\partial q_i}(\\bar q_1,\\ldots,\\bar q_{i-1},q_i,\\bar q_{i+1},\\ldots,\\bar q_{N_c}),\\]\nwhere components with a bar over them are fixed during the calculation. Any such 1-dof Hamiltonian system is formally integrable (albeit in quadratures).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.coordinateJField",
  "lean_declarations": [
    "MD.Ch07.coordinateJField",
    "MD.Ch07.frozenPotential"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def coordinateJField (m : V n) (U : V n → ℝ) (i : Fin n) (x : Phase n) : Phase n :=
  (fun j ↦ if j = i then x.2 i/m i else 0,
   fun j ↦ if j = i then -gradient U x.1 i else 0)
def frozenPotential (U : V n → ℝ) (q : V n) (i : Fin n) (r : ℝ) : ℝ :=
  U (Function.update q i r)
```
