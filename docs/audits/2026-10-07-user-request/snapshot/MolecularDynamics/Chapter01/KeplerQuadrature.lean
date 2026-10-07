import MolecularDynamics.Chapter01.SeparableQuadrature

open Set Filter
open scoped Topology
namespace MolecularDynamics

noncomputable def keplerRadialSpeedSquare (l E x : ℝ) : ℝ :=
  2 * (E + 1 / x - l ^ 2 / (2 * x ^ 2))

noncomputable def keplerRadialBranchSpeed (σ l E x : ℝ) : ℝ :=
  σ * Real.sqrt (keplerRadialSpeedSquare l E x)

theorem keplerRadial_energy_speedSquare (l E x v : ℝ)
    (hE : keplerRadialEnergy l x v = E) :
    v ^ 2 = keplerRadialSpeedSquare l E x := by
  rw [keplerRadialEnergy_formula] at hE
  unfold keplerRadialSpeedSquare
  linarith

theorem keplerRadialBranchSpeed_eq_velocity (σ l E x v : ℝ)
    (hσ : σ ^ 2 = 1) (hbranch : 0 < σ * v) (hE : keplerRadialEnergy l x v = E) :
    keplerRadialBranchSpeed σ l E x = v := by
  have hs : (σ * v) ^ 2 = keplerRadialSpeedSquare l E x := by
    rw [mul_pow, hσ, one_mul]
    exact keplerRadial_energy_speedSquare l E x v hE
  unfold keplerRadialBranchSpeed
  rw [← hs, Real.sqrt_sq_eq_abs, abs_of_pos hbranch]
  calc
    _ = σ ^ 2 * v := by ring
    _ = v := by rw [hσ]; ring

theorem keplerRadialSpeedSquare_continuousAt (l E x : ℝ) (hx : x ≠ 0) :
    ContinuousAt (keplerRadialSpeedSquare l E) x := by
  exact ((continuousAt_const.add (continuousAt_const.div continuousAt_id hx)).sub
    (continuousAt_const.div (continuousAt_const.mul (continuousAt_id.pow 2))
      (mul_ne_zero (by norm_num) (pow_ne_zero 2 hx)))).const_mul 2

theorem keplerRadialEnergy_const_on_Ioo (l a b : ℝ) (r v : ℝ → ℝ)
    (h : ∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    keplerRadialEnergy l (r s) (v s) = keplerRadialEnergy l (r t) (v t) := by
  have hd : ∀ u ∈ Ioo a b, HasDerivAt (fun u => keplerRadialEnergy l (r u) (v u)) 0 u :=
    fun u hu => keplerRadialEnergy_hasDerivAt_zero l r v u (ne_of_gt (h u hu).1)
      (h u hu).2.1 (h u hu).2.2
  exact isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo
    (fun u hu => (hd u hu).differentiableAt.differentiableWithinAt)
    (fun u hu => (hd u hu).deriv) hs ht

theorem keplerRadial_signedQuadrature_inverse_on_branch
    (σ l E A B a b t₀ : ℝ) (r v : ℝ → ℝ)
    (hσ : σ ^ 2 = 1)
    (hQ : ∀ x ∈ Ioo A B, 0 < x ∧ 0 < keplerRadialSpeedSquare l E x)
    (h : ∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t)
    (hrange : ∀ t ∈ Ioo a b, r t ∈ Ioo A B)
    (hbranch : ∀ t ∈ Ioo a b, 0 < σ * v t)
    (ht₀ : t₀ ∈ Ioo a b) (hE : keplerRadialEnergy l (r t₀) (v t₀) = E) :
    ∃ g : ℝ → ℝ,
      (∀ᶠ x in 𝓝 (r t₀), g (separableTimePrimitive (keplerRadialBranchSpeed σ l E) (r t₀) x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive (keplerRadialBranchSpeed σ l E) (r t₀) (g y) = y) ∧
      HasStrictDerivAt g (v t₀) 0 ∧
      (∀ᶠ t in 𝓝 t₀, g (t - t₀) = r t) ∧
      (∀ t ∈ Ioo a b,
        separableTimePrimitive (keplerRadialBranchSpeed σ l E) (r t₀) (r t) = t - t₀) := by
  have hσ0 : σ ≠ 0 := by
    intro hz
    rw [hz] at hσ
    norm_num at hσ
  have hw : ContinuousOn (keplerRadialBranchSpeed σ l E) (Ioo A B) := by
    intro x hx
    exact ((keplerRadialSpeedSquare_continuousAt l E x (ne_of_gt (hQ x hx).1)).sqrt.const_mul σ).continuousWithinAt
  have hn : ∀ x ∈ Ioo A B, keplerRadialBranchSpeed σ l E x ≠ 0 :=
    fun x hx => mul_ne_zero hσ0 (Real.sqrt_ne_zero'.mpr (hQ x hx).2)
  have hvelocity : ∀ t ∈ Ioo a b, keplerRadialBranchSpeed σ l E (r t) = v t := by
    intro t ht
    apply keplerRadialBranchSpeed_eq_velocity σ l E _ _ hσ (hbranch t ht)
    rw [← keplerRadialEnergy_const_on_Ioo l a b r v h t₀ t ht₀ ht]
    exact hE
  have hODE : ∀ t ∈ Ioo a b, r t ∈ Ioo A B ∧
      HasDerivAt r (keplerRadialBranchSpeed σ l E (r t)) t := by
    intro t ht
    rw [hvelocity t ht]
    exact ⟨hrange t ht, (h t ht).2.1⟩
  obtain ⟨g, hl, hr, hg, hsol⟩ := separableTimePrimitive_inverse_along_solution
    (keplerRadialBranchSpeed σ l E) A B (r t₀) a b t₀ hw hn (hrange t₀ ht₀) r hODE ht₀ rfl
  rw [hvelocity t₀ ht₀] at hg
  exact ⟨g, hl, hr, hg, hsol, fun t ht => separableTimePrimitive_along_solution
    (keplerRadialBranchSpeed σ l E) A B (r t₀) a b t₀ hw hn (hrange t₀ ht₀) r hODE ht₀ rfl t ht⟩

theorem exists_keplerRadial_nonturning_window
    (σ l E a b t₀ : ℝ) (r v : ℝ → ℝ)
    (hbranch₀ : 0 < σ * v t₀)
    (h : ∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t)
    (ht₀ : t₀ ∈ Ioo a b) (hE : keplerRadialEnergy l (r t₀) (v t₀) = E) :
    ∃ δ ε : ℝ, 0 < δ ∧ 0 < ε ∧
      (∀ x ∈ Ioo (r t₀ - δ) (r t₀ + δ), 0 < x ∧ 0 < keplerRadialSpeedSquare l E x) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        r t ∈ Ioo (r t₀ - δ) (r t₀ + δ) ∧ 0 < σ * v t) := by
  have hv₀ : v t₀ ≠ 0 := by
    intro hz
    rw [hz, mul_zero] at hbranch₀
    linarith
  have hS₀ : 0 < keplerRadialSpeedSquare l E (r t₀) := by
    rw [← keplerRadial_energy_speedSquare l E _ _ hE]
    exact sq_pos_of_ne_zero hv₀
  have hS := keplerRadialSpeedSquare_continuousAt l E (r t₀) (ne_of_gt (h t₀ ht₀).1)
  have hdom : {x : ℝ | 0 < x ∧ 0 < keplerRadialSpeedSquare l E x} ∈ 𝓝 (r t₀) :=
    Filter.inter_mem (isOpen_Ioi.mem_nhds (h t₀ ht₀).1)
      (hS.preimage_mem_nhds (isOpen_Ioi.mem_nhds hS₀))
  obtain ⟨δ, hδ, hδsub⟩ := Metric.mem_nhds_iff.mp hdom
  have hQ : ∀ x ∈ Ioo (r t₀ - δ) (r t₀ + δ),
      0 < x ∧ 0 < keplerRadialSpeedSquare l E x := by
    intro x hx
    apply hδsub
    rwa [Real.ball_eq_Ioo]
  have hr₀ : r t₀ ∈ Ioo (r t₀ - δ) (r t₀ + δ) := by constructor <;> linarith
  have htime : {t : ℝ | t ∈ Ioo a b ∧ r t ∈ Ioo (r t₀ - δ) (r t₀ + δ) ∧
      0 < σ * v t} ∈ 𝓝 t₀ :=
    Filter.inter_mem (isOpen_Ioo.mem_nhds ht₀) (Filter.inter_mem
      ((h t₀ ht₀).2.1.continuousAt.preimage_mem_nhds (isOpen_Ioo.mem_nhds hr₀))
      ((continuousAt_const.mul (h t₀ ht₀).2.2.continuousAt).preimage_mem_nhds
        (isOpen_Ioi.mem_nhds hbranch₀)))
  obtain ⟨ε, hε, hεsub⟩ := Metric.mem_nhds_iff.mp htime
  refine ⟨δ, ε, hδ, hε, hQ, ?_⟩
  intro t ht
  apply hεsub
  rwa [Real.ball_eq_Ioo]

theorem keplerRadial_nonturning_signedQuadrature
    (σ l E a b t₀ : ℝ) (r v : ℝ → ℝ)
    (hσ : σ ^ 2 = 1) (hbranch₀ : 0 < σ * v t₀)
    (h : ∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t)
    (ht₀ : t₀ ∈ Ioo a b) (hE : keplerRadialEnergy l (r t₀) (v t₀) = E) :
    ∃ (δ ε : ℝ) (g : ℝ → ℝ), 0 < δ ∧ 0 < ε ∧
      HasStrictDerivAt g (v t₀) 0 ∧ (∀ᶠ t in 𝓝 t₀, g (t - t₀) = r t) ∧
      (∀ᶠ x in 𝓝 (r t₀), g (separableTimePrimitive (keplerRadialBranchSpeed σ l E) (r t₀) x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive (keplerRadialBranchSpeed σ l E) (r t₀) (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        r t ∈ Ioo (r t₀ - δ) (r t₀ + δ) ∧
        separableTimePrimitive (keplerRadialBranchSpeed σ l E) (r t₀) (r t) = t - t₀) := by
  obtain ⟨δ, ε, hδ, hε, hQ, htime⟩ :=
    exists_keplerRadial_nonturning_window σ l E a b t₀ r v hbranch₀ h ht₀ hE
  have ht₀' : t₀ ∈ Ioo (t₀ - ε) (t₀ + ε) := by constructor <;> linarith
  obtain ⟨g, hl, hr, hg, hsol, hquad⟩ := keplerRadial_signedQuadrature_inverse_on_branch
    σ l E (r t₀ - δ) (r t₀ + δ) (t₀ - ε) (t₀ + ε) t₀ r v hσ hQ
    (fun t ht => h t (htime t ht).1) (fun t ht => (htime t ht).2.1)
    (fun t ht => (htime t ht).2.2) ht₀' hE
  exact ⟨δ, ε, g, hδ, hε, hg, hsol, hl, hr,
    fun t ht => ⟨(htime t ht).1, (htime t ht).2.1, hquad t ht⟩⟩

theorem keplerRadial_nonturning_quadrature
    (l a b t₀ : ℝ) (r v : ℝ → ℝ)
    (h : ∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t)
    (ht₀ : t₀ ∈ Ioo a b) (hv₀ : v t₀ ≠ 0) :
    ∃ (σ δ ε : ℝ) (g : ℝ → ℝ), σ ^ 2 = 1 ∧ 0 < δ ∧ 0 < ε ∧
      HasStrictDerivAt g (v t₀) 0 ∧ (∀ᶠ t in 𝓝 t₀, g (t - t₀) = r t) ∧
      (∀ᶠ x in 𝓝 (r t₀), g (separableTimePrimitive
        (keplerRadialBranchSpeed σ l (keplerRadialEnergy l (r t₀) (v t₀))) (r t₀) x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive
        (keplerRadialBranchSpeed σ l (keplerRadialEnergy l (r t₀) (v t₀))) (r t₀) (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        r t ∈ Ioo (r t₀ - δ) (r t₀ + δ) ∧
        separableTimePrimitive
          (keplerRadialBranchSpeed σ l (keplerRadialEnergy l (r t₀) (v t₀))) (r t₀) (r t) = t - t₀) := by
  have hsign : ∃ σ : ℝ, σ ^ 2 = 1 ∧ 0 < σ * v t₀ := by
    rcases lt_or_gt_of_ne hv₀ with hn | hp
    · refine ⟨-1, by norm_num, ?_⟩
      simpa using neg_pos.mpr hn
    · refine ⟨1, by norm_num, ?_⟩
      simpa using hp
  obtain ⟨σ, hσ, hbranch⟩ := hsign
  obtain ⟨δ, ε, g, hδ, hε, hg, hsol, hl, hr, hquad⟩ :=
    keplerRadial_nonturning_signedQuadrature σ l (keplerRadialEnergy l (r t₀) (v t₀))
      a b t₀ r v hσ hbranch h ht₀ rfl
  exact ⟨σ, δ, ε, g, hσ, hδ, hε, hg, hsol, hl, hr, hquad⟩

end MolecularDynamics
