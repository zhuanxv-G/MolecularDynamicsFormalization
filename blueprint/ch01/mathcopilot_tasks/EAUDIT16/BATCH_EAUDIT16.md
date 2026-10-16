# EAUDIT16：第1章§1.5.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-TorusDense",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "in the latter case the paths do not “close up” but instead we see the curve gradually fills in the surface of the torus.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文用ratio of frequencies描述高维填满环面，未区分准周期子环面与全维整数无共振；须导师明确。"
    }
  ],
  "lean_decl": "MD.Ch01.torusdense",
  "extra_assumptions": [
    "高维全整数关系无共振；仅成对频率比无理不足，此为原文quasi-periodic intended meaning的数学资格。"
  ],
  "old_ids": [
    "CH01-133"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem torusdense :
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-TorusDense，改动：另补原句“非周期即充满整个环面”的literal；修正版显式全整数无共振，原有带资格陈述不变。 -/
theorem torusdense_literal :
    ∀ (n : ℕ) (Ω : Fin n → ℝ) (θ : HarmonicTorus n),
      (¬ ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) →
      DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-TorusDense，改动：明确全整数无共振资格。 -/
theorem torusdense_corrected :
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry
```
### 实际依赖 MolecularDynamics.HarmonicTorus
```lean
abbrev HarmonicTorus (n : ℕ) := Fin n → Real.Angle
```
### 实际依赖 MolecularDynamics.harmonicTorusRotation
```lean
noncomputable def harmonicTorusRotation {n : ℕ} (Ω : Fin n → ℝ) (t : ℝ)
    (θ : HarmonicTorus n) : HarmonicTorus n := fun j => θ j - (Ω j * t : ℝ)
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-LocalActionAngleReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "More generally, one finds occasional examples of nonlinear systems which possess as many independent first integrals as degrees of freedom (satisfying a certain “involution” condition); such systems may be reduced via a coordinate transformation to action-angle variables, i.e. they exhibit tori motion.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "local canonical action-angle与全局torus motion不同；本条只保留局部规约，原文最后tori motion需额外紧共同能量层假设。"
    }
  ],
  "lean_decl": "MD.Ch01.local_action_angle_reduction",
  "extra_assumptions": [
    "全部积分C∞且Poisson括号两两零；正则共同能量层紧、连通；满秩=独立。"
  ],
  "old_ids": [
    "CH01-134"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem local_action_angle_reduction :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    IsCompact S → IsConnected S →
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-LocalActionAngleReduction，改动：原书无紧性资格的环面推断另记literal；默认紧、连通、非空、正则共同水平集，保留局部正则坐标与全局环面结论。 -/
theorem local_action_angle_reduction_literal :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-LocalActionAngleReduction，改动：紧连通非空正则共同水平集。 -/
theorem local_action_angle_reduction_corrected :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    IsCompact S → IsConnected S →
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry
```
### 实际依赖 MolecularDynamics.HarmonicTorus
```lean
abbrev HarmonicTorus (n : ℕ) := Fin n → Real.Angle
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
### 实际依赖 MolecularDynamics.Chapter01Review.canonicalBilinear
```lean
def canonicalBilinear {d : ℕ} (u v : PhaseSpace d) :=
  inner ℝ u.1 v.2 - inner ℝ u.2 v.1
```
### 实际依赖 MolecularDynamics.harmonicTorusRotation
```lean
noncomputable def harmonicTorusRotation {n : ℕ} (Ω : Fin n → ℝ) (t : ℝ)
    (θ : HarmonicTorus n) : HarmonicTorus n := fun j => θ j - (Ω j * t : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter01Review.localActionAngle
```lean
def localActionAngle {d : ℕ} (I : Fin d → PhaseSpace d → ℝ)
    (S : Set (PhaseSpace d)) : Prop :=
  ∀ z ∈ S, ∃ (U V : Set (PhaseSpace d)) (φ ψ : PhaseSpace d → PhaseSpace d)
    (Ω : Fin d → Position d → Position d),
    IsOpen U ∧ IsOpen V ∧ z ∈ U ∧ ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V ∧
    MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
    (∀ w ∈ U, ∀ u v, canonicalBilinear (fderiv ℝ φ w u) (fderiv ℝ φ w v) =
      canonicalBilinear u v) ∧
    ∀ w ∈ U, ∀ i, fderiv ℝ φ w (symplecticGradient (I i) w) = (0,Ω i (φ w).1)
```
### 实际依赖 MolecularDynamics.Chapter01Review.poissonBracket
```lean
def poissonBracket {d : ℕ} (H K : PhaseSpace d → ℝ) (z : PhaseSpace d) :=
  fderiv ℝ H z (symplecticGradient K z)
```
### 实际依赖 MolecularDynamics.Chapter01Review.symplecticGradient
```lean
def symplecticGradient {d : ℕ} (H : PhaseSpace d → ℝ) (z : PhaseSpace d) : PhaseSpace d :=
  (gradient (fun p => H (z.1,p)) z.2, -gradient (fun q => H (q,z.2)) z.1)
```
