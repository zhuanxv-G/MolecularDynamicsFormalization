# EAUDIT14：第1章§1.5.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-FirstIntegral",
  "kind": "definition",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "Another term for constants of motion is first integral. In general, if we have a dynamical system $\\dot{\\boldsymbol z}=f(\\boldsymbol z)$, a first integral is a smooth function $I(\\boldsymbol z)$ which is constant along solutions, for all values of the initial condition.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "IsFirstIntegralOn量化每条真实曲线及其存在区间，不附加全局存在。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.smoothFirstIntegral",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-109"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def smoothFirstIntegral {n : ℕ} (f : Position n → Position n) (Q : Set (Position n))
    (I : Position n → ℝ) : Prop := ContDiffOn ℝ ∞ I Q ∧ IsFirstIntegralOn f Q I
```
### 实际依赖 MolecularDynamics.IsFirstIntegralOn
```lean
def IsFirstIntegralOn (f : E → E) (Q : Set E) (J : E → ℝ) : Prop :=
  ∀ (a b : ℝ) (γ : ℝ → E),
    (∀ t ∈ Ioo a b, γ t ∈ Q) →
    (∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) →
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b, J (γ s) = J (γ t)
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.smoothFirstIntegral
```lean
def smoothFirstIntegral {n : ℕ} (f : Position n → Position n) (Q : Set (Position n))
    (I : Position n → ℝ) : Prop := ContDiffOn ℝ ∞ I Q ∧ IsFirstIntegralOn f Q I
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-FirstIntegralCriterion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "Since this should hold everywhere, the condition for $I$ to be a first integral is that $\\nabla I\\cdot f=0$.",
  "proof_latex": "Let $\\boldsymbol z(t)$ ($t\\in\\mathbb R$) be a solution, then\n\\[I(\\boldsymbol z(t))=I(\\boldsymbol z(0))\\Rightarrow0=\\frac{\\mathrm d}{\\mathrm dt}I(\\boldsymbol z(t))=\\nabla I(\\boldsymbol z(t))\\cdot\\dot{\\boldsymbol z}(t)=\\nabla I(\\boldsymbol z(t))\\cdot f(\\boldsymbol z(t)).\\]",
  "proof_note": "按渲染原页逐字转录原文论证。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.firstintegralcriterion",
  "extra_assumptions": [
    "开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral_gradient_criterion。"
  ],
  "old_ids": [
    "CH01-110"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem firstintegralcriterion :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (Q : Set E) (J : E → ℝ)
    (hQ : IsOpen Q) (hf : ∀ x ∈ Q, ContDiffAt ℝ 1 f x)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x),
    IsFirstIntegralOn f Q J ↔ ∀ x ∈ Q, fderiv ℝ J x (f x) = 0 := by
  exact @MolecularDynamics.isFirstIntegralOn_iff_differential
```
### 实际依赖 MolecularDynamics.IsFirstIntegralOn
```lean
def IsFirstIntegralOn (f : E → E) (Q : Set E) (J : E → ℝ) : Prop :=
  ∀ (a b : ℝ) (γ : ℝ → E),
    (∀ t ∈ Ioo a b, γ t ∈ Q) →
    (∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) →
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b, J (γ s) = J (γ t)
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-PlanarGraphReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "In principle, such an equation can be solved (locally at least) for $y$ as a function of $x$ due to the implicit function theorem. Hence one may write $y=\\psi(x)$. Reinsert this into the first differential equation to get a reduced equation in just one dependent variable:\n\\[\\frac{\\mathrm dx}{\\mathrm dt}=g(x,\\psi(x)).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "正文前句二维f=(g,h)且第一积分I(x,y)=I0；不把IsFirstIntegralOn当证明目标假设，它是本条原文已有第一积分。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.planargraphreduction",
  "extra_assumptions": [
    "对y偏导非零，真实strict导数，局部时间窗；原文省略隐函数非退化条件。"
  ],
  "old_ids": [
    "CH01-111",
    "CH01-112"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem planargraphreduction :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J)
    (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (L : (ℝ × ℝ) →L[ℝ] ℝ) (hJ : HasStrictFDerivAt J L (γ t₀))
    (hpartial : L (0, 1) ≠ 0),
    ∃ ψ : ℝ → ℝ, ψ (γ t₀).1 = (γ t₀).2 ∧ DifferentiableAt ℝ ψ (γ t₀).1 ∧
      (∀ᶠ v in 𝓝 (γ t₀), J v = J (γ t₀) ↔ ψ v.1 = v.2) ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).2 = ψ (γ t).1 ∧
        HasDerivAt (fun u => (γ u).1) ((f ((γ t).1, ψ (γ t).1)).1) t) := by
  exact @MolecularDynamics.planarFirstIntegral_localGraph_reduction
```
### 实际依赖 MolecularDynamics.IsFirstIntegralOn
```lean
def IsFirstIntegralOn (f : E → E) (Q : Set E) (J : E → ℝ) : Prop :=
  ∀ (a b : ℝ) (γ : ℝ → E),
    (∀ t ∈ Ioo a b, γ t ∈ Q) →
    (∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) →
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b, J (γ s) = J (γ t)
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-PlanarQuadrature",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "Such an ordinary differential equation is said to be separable, and theoretically can be solved, given an initial condition, for x as a function of t.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.planarquadrature",
  "extra_assumptions": [
    "正则第一积分图及非转向速度非零；真实C2、局部积分逆。"
  ],
  "old_ids": [
    "CH01-113"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem planarquadrature :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J) (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (hJ : ContDiffAt ℝ 1 J (γ t₀)) (hf : ContDiffAt ℝ 1 f (γ t₀))
    (hpartial : (fderiv ℝ J (γ t₀)) (0, 1) ≠ 0) (hspeed : (f (γ t₀)).1 ≠ 0),
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (f (γ t₀)).1 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1,
        g (separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (γ t).1 = t - t₀) := by
  exact @MolecularDynamics.planarFirstIntegral_nonturning_quadrature
```
### 实际依赖 MolecularDynamics.IsFirstIntegralOn
```lean
def IsFirstIntegralOn (f : E → E) (Q : Set E) (J : E → ℝ) : Prop :=
  ∀ (a b : ℝ) (γ : ℝ → E),
    (∀ t ∈ Ioo a b, γ t ∈ Q) →
    (∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) →
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b, J (γ s) = J (γ t)
```
### 实际依赖 MolecularDynamics.separableTimePrimitive
```lean
noncomputable def separableTimePrimitive (w : ℝ → ℝ) (x₀ x : ℝ) : ℝ :=
  ∫ u in x₀..x, 1 / w u
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-ScalarFirstIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "Example 1.6 The single degree of freedom model of Example 1.4 has the energy as a first integral. The system is therefore integrable.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.scalar_first_integral_and_quadrature",
  "extra_assumptions": [
    "U C2；开放时间段真实解、积分逆图使用速度非零点；转向点全局拼接不声称已有证明。"
  ],
  "old_ids": [
    "CH01-114"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem scalar_first_integral_and_quadrature :
  (∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U),
    IsFirstIntegralOn (scalarPotentialVectorField U) univ (scalarPotentialEnergy U)) ∧
  (∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hv₀ : (γ t₀).2 ≠ 0),
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (γ t₀).2 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1, g (separableTimePrimitive ψ (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive ψ (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive ψ (γ t₀).1 (γ t).1 = t - t₀)) := by
  exact ⟨@MolecularDynamics.scalarPotentialEnergy_isFirstIntegral, @MolecularDynamics.scalarPotential_nonturning_quadrature⟩
```
### 实际依赖 MolecularDynamics.IsFirstIntegralOn
```lean
def IsFirstIntegralOn (f : E → E) (Q : Set E) (J : E → ℝ) : Prop :=
  ∀ (a b : ℝ) (γ : ℝ → E),
    (∀ t ∈ Ioo a b, γ t ∈ Q) →
    (∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) →
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b, J (γ s) = J (γ t)
```
### 实际依赖 MolecularDynamics.scalarPotentialEnergy
```lean
def scalarPotentialEnergy (U : ℝ → ℝ) (p : ℝ × ℝ) : ℝ := p.2 ^ 2 / 2 + U p.1
```
### 实际依赖 MolecularDynamics.scalarPotentialVectorField
```lean
def scalarPotentialVectorField (U : ℝ → ℝ) (p : ℝ × ℝ) : ℝ × ℝ :=
  (p.2, -deriv U p.1)
```
### 实际依赖 MolecularDynamics.separableTimePrimitive
```lean
noncomputable def separableTimePrimitive (w : ℝ → ℝ) (x₀ x : ℝ) : ℝ :=
  ∫ u in x₀..x, 1 / w u
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-KeplerConservedEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "The two conserved quantities, energy and angular momentum, mean that the Kepler problem is an integrable system.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "本条保留整句全部结论；旋转对称理由另见KeplerAngularMomentum；完整重建公式另见KeplerFullSolution。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.kepler_energy_angular_integrability",
  "extra_assumptions": [
    "真实平面非碰撞机械解；积分重建的整个存在区间含0，角为连续实提升；不声称穿越碰撞的全局轨道。"
  ],
  "old_ids": [
    "CH01-116"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem kepler_energy_angular_integrability :
  (∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ s) =
      massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ t)) ∧
  (∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t)) ∧
  (∀ (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z),
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = (fun r θ : ℝ => (WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ] : Position 2)) (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = (((fun r θ : ℝ => (WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ] : Position 2)) (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀])) := by
  refine ⟨@MolecularDynamics.kepler_energy_const_on_Ioo 2, @MolecularDynamics.kepler_planarAngularMomentum_const_on_Ioo, ?_⟩
  sorry
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Force
```lean
abbrev Force (n : ℕ) := Position n → Position n
```
### 实际依赖 MolecularDynamics.Hamiltonian
```lean
abbrev Hamiltonian (n : ℕ) := PhaseSpace n → ℝ
```
### 实际依赖 MolecularDynamics.HasScalarQuadratureRepresentation
```lean
def HasScalarQuadratureRepresentation (r s : ℝ → ℝ)
    (W : (ℝ → ℝ) → ℝ → ℝ) (w₀ a b t₀ : ℝ) : Prop :=
  ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
    ψ (r t₀) = s t₀ ∧ ContDiffAt ℝ 1 ψ (r t₀) ∧ HasStrictDerivAt g w₀ 0 ∧
    (∀ᶠ t in 𝓝 t₀, r t = g (t - t₀) ∧ s t = ψ (g (t - t₀))) ∧
    (∀ᶠ x in 𝓝 (r t₀), g (separableTimePrimitive (W ψ) (r t₀) x) = x) ∧
    (∀ᶠ y in 𝓝 0, separableTimePrimitive (W ψ) (r t₀) (g y) = y) ∧
    (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
      separableTimePrimitive (W ψ) (r t₀) (r t) = t - t₀)
```
### 实际依赖 MolecularDynamics.IsMechanicalSolutionOn
```lean
def IsMechanicalSolutionOn {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ t ∈ I, (γ t).1 ∈ Q) ∧
    IsIntegralCurveOn γ (fun _ z => mechanicalVectorField μ F z) I
```
### 实际依赖 MolecularDynamics.KineticEnergy
```lean
abbrev KineticEnergy (n : ℕ) := Momentum n → ℝ
```
### 实际依赖 MolecularDynamics.MassMatrix
```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
```
### 实际依赖 MolecularDynamics.Momentum
```lean
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PhaseSpace
```lean
abbrev PhaseSpace (n : ℕ) := Position n × Momentum n
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PotentialEnergy
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```
### 实际依赖 MolecularDynamics.ScalarPotentialLocalDescription
```lean
def ScalarPotentialLocalDescription (U : ℝ → ℝ) (γ : ℝ → ℝ × ℝ)
    (a b t₀ : ℝ) : Prop :=
  ((γ t₀).2 ≠ 0 ∧ HasScalarQuadratureRepresentation
    (fun t => (γ t).1) (fun t => (γ t).2) (fun ψ => ψ) (γ t₀).2 a b t₀) ∨
  ((γ t₀).2 = 0 ∧ deriv U (γ t₀).1 ≠ 0 ∧ HasScalarQuadratureRepresentation
    (fun t => (γ t).2) (fun t => (γ t).1) (fun ψ v => -deriv U (ψ v))
    (-deriv U (γ t₀).1) a b t₀) ∨
  ((γ t₀).2 = 0 ∧ deriv U (γ t₀).1 = 0 ∧ ∀ t ∈ Ioo a b, γ t = γ t₀)
```
### 实际依赖 MolecularDynamics.SeparableEnergy
```lean
structure SeparableEnergy (n : ℕ) where
  kinetic : KineticEnergy n
  potential : PotentialEnergy n
```
### 实际依赖 MolecularDynamics.Velocity
```lean
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.diagonalMassMatrix
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```
### 实际依赖 MolecularDynamics.keplerForce
```lean
noncomputable def keplerForce {n : ℕ} (q : Position n) : Position n :=
  (-(‖q‖ ^ 3)⁻¹) • q
```
### 实际依赖 MolecularDynamics.keplerPotential
```lean
noncomputable def keplerPotential {n : ℕ} (q : Position n) : ℝ := -‖q‖⁻¹
```
### 实际依赖 MolecularDynamics.massHamiltonian
```lean
noncomputable def massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : Hamiltonian n := (massSeparableEnergy m U).hamiltonian
```
### 实际依赖 MolecularDynamics.massSeparableEnergy
```lean
noncomputable def massSeparableEnergy {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : SeparableEnergy n := ⟨momentumKineticEnergy m, U⟩
```
### 实际依赖 MolecularDynamics.mechanicalVectorField
```lean
noncomputable def mechanicalVectorField {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) : PhaseSpace n :=
  (velocityOperator μ z.2, F z.1)
```
### 实际依赖 MolecularDynamics.momentumKineticEnergy
```lean
noncomputable def momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : ℝ := ∑ i, (p i)^2 / (2 * m i)
```
### 实际依赖 MolecularDynamics.planarAngularMomentum
```lean
def planarAngularMomentum (z : PhaseSpace 2) : ℝ :=
  z.1 0 * z.2 1 - z.1 1 * z.2 0
```
### 实际依赖 MolecularDynamics.separableTimePrimitive
```lean
noncomputable def separableTimePrimitive (w : ℝ → ℝ) (x₀ x : ℝ) : ℝ :=
  ∫ u in x₀..x, 1 / w u
```
### 实际依赖 MolecularDynamics.velocityOperator
```lean
noncomputable def velocityOperator {n : ℕ} (μ : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)⁻¹).toContinuousLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-KeplerAngularMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "however, due to the fact that the potential energy is rotationally invariant (dependent only on the distance of the moving particle from the origin), the angular momentum of the system is conserved.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$l_z=x\\dot y-y\\dot x$，p.29同页；非碰撞真轨迹。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.keplerangularmomentum",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-117"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem keplerangularmomentum :
  ∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t) := by
  exact @MolecularDynamics.kepler_planarAngularMomentum_const_on_Ioo
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Force
```lean
abbrev Force (n : ℕ) := Position n → Position n
```
### 实际依赖 MolecularDynamics.IsMechanicalSolutionOn
```lean
def IsMechanicalSolutionOn {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ t ∈ I, (γ t).1 ∈ Q) ∧
    IsIntegralCurveOn γ (fun _ z => mechanicalVectorField μ F z) I
```
### 实际依赖 MolecularDynamics.MassMatrix
```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
```
### 实际依赖 MolecularDynamics.Momentum
```lean
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PhaseSpace
```lean
abbrev PhaseSpace (n : ℕ) := Position n × Momentum n
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Velocity
```lean
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.diagonalMassMatrix
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```
### 实际依赖 MolecularDynamics.keplerForce
```lean
noncomputable def keplerForce {n : ℕ} (q : Position n) : Position n :=
  (-(‖q‖ ^ 3)⁻¹) • q
```
### 实际依赖 MolecularDynamics.mechanicalVectorField
```lean
noncomputable def mechanicalVectorField {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) : PhaseSpace n :=
  (velocityOperator μ z.2, F z.1)
```
### 实际依赖 MolecularDynamics.planarAngularMomentum
```lean
def planarAngularMomentum (z : PhaseSpace 2) : ℝ :=
  z.1 0 * z.2 1 - z.1 1 * z.2 0
```
### 实际依赖 MolecularDynamics.velocityOperator
```lean
noncomputable def velocityOperator {n : ℕ} (μ : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)⁻¹).toContinuousLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-KeplerMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "Note that a consequence of fixing one of the bodies in the Kepler problem is that the two components of the total momentum vector, i.e. $(m\\dot x,m\\dot y)$, are obviously no longer conserved;",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.keplermomentum",
  "extra_assumptions": [
    "q≠0；单位质量。",
    "[EXTRA] 19号：保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。"
  ],
  "old_ids": [
    "CH01-201"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem keplermomentum :
  ∀ q : Position 2, q ≠ 0 → keplerForce q ≠ 0 := by
  intro q hq
  simp [keplerForce, smul_eq_zero, hq, norm_ne_zero_iff.mpr hq]

theorem keplermomentum_not_first_integrals :
    ∀ i : Fin 2, ¬ IsFirstIntegralOn
      (mechanicalVectorField (fun _ : Fin 2 => (1 : ℝ)) keplerForce)
      {z : PhaseSpace 2 | z.1 ≠ 0} (fun z : PhaseSpace 2 => z.2 i) := by
  sorry
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Force
```lean
abbrev Force (n : ℕ) := Position n → Position n
```
### 实际依赖 MolecularDynamics.IsFirstIntegralOn
```lean
def IsFirstIntegralOn (f : E → E) (Q : Set E) (J : E → ℝ) : Prop :=
  ∀ (a b : ℝ) (γ : ℝ → E),
    (∀ t ∈ Ioo a b, γ t ∈ Q) →
    (∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) →
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b, J (γ s) = J (γ t)
```
### 实际依赖 MolecularDynamics.MassMatrix
```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
```
### 实际依赖 MolecularDynamics.Momentum
```lean
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PhaseSpace
```lean
abbrev PhaseSpace (n : ℕ) := Position n × Momentum n
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Velocity
```lean
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.diagonalMassMatrix
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```
### 实际依赖 MolecularDynamics.keplerForce
```lean
noncomputable def keplerForce {n : ℕ} (q : Position n) : Position n :=
  (-(‖q‖ ^ 3)⁻¹) • q
```
### 实际依赖 MolecularDynamics.mechanicalVectorField
```lean
noncomputable def mechanicalVectorField {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) : PhaseSpace n :=
  (velocityOperator μ z.2, F z.1)
```
### 实际依赖 MolecularDynamics.velocityOperator
```lean
noncomputable def velocityOperator {n : ℕ} (μ : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)⁻¹).toContinuousLinearMap
```
