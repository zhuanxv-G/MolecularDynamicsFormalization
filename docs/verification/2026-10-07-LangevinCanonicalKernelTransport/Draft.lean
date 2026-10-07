import MolecularDynamics.Chapter06.LangevinCanonicalMomentumClosedEnergy

/-! Actual closed Langevin kernel elements annihilate momentum adjoint tests,
the literal momentum OU tests and the original Hamiltonian transport tests.
This supplies the weak transport stage of conserved-quantity constancy;
full kernel constancy and Poisson solvability are not asserted. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace LinearPMap
namespace MolecularDynamics
noncomputable section

private theorem kernelTransport_H_eq {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) :
    textbookLangevinPeriodicHamiltonianTransportExpression U G =
      textbookLangevinPeriodicDifferentialOperator U 0 0 G := by
  funext x
  rw [textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp 1 0 0
    (by norm_num) (by simp) G hG]
  simp [textbookLangevinPeriodicHamiltonianTransportExpression]

/-- The true original Hamiltonian test image lies in the same actual canonical Hilbert space. -/
theorem textbookLangevinCanonicalMeasure_hamiltonianTest_memLp_two {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    MemLp (textbookLangevinPeriodicHamiltonianTransportExpression U G) 2
      (textbookLangevinCanonicalMeasure U β hβ) := by
  rw [kernelTransport_H_eq U hU hp G hG]
  exact textbookLangevinCanonicalMeasure_differential_memLp_two U hU hp β 0 0 hβ G hG hsG

private theorem kernelTransport_O_memLp {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    MemLp (textbookLangevinPeriodicMomentumOUExpression β γ G) 2
      (textbookLangevinCanonicalMeasure U β hβ) := by
  have hm := (textbookLangevinCanonicalMeasure_formalAdjoint_memLp_two U hU hp β γ hβ G hG hsG).add
    (textbookLangevinCanonicalMeasure_hamiltonianTest_memLp_two U hU hp β hβ G hG hsG)
  have he : textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ G +
      textbookLangevinPeriodicHamiltonianTransportExpression U G =
      textbookLangevinPeriodicMomentumOUExpression β γ G := by
    funext x
    simp only [Pi.add_apply, textbookLangevinCanonicalWeightedFormalAdjointExpression]
    ring
  rw [he] at hm
  exact hm

private theorem kernelTransport_inner_integral {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : MemLp G 2 (textbookLangevinCanonicalMeasure U β hβ)) :
    ⟪f, hG.toLp G⟫_ℝ = ∫ x, f x * G x ∂textbookLangevinCanonicalMeasure U β hβ := by
  rw [L2.inner_def]
  apply integral_congr_ae
  filter_upwards [hG.coeFn_toLp] with x hx
  rw [hx, Real.inner_apply]

/-- The literal original OU expression is a finite sum of genuine momentum
transpose tests of actual momentum derivatives, with the canonical gamma/beta factor. -/
theorem textbookLangevinCanonicalMomentumOUExpression_coordinate_transpose {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β γ : ℝ) (hβ : 0 < β)
    (G : textbookLangevinPeriodicPhase N → ℝ) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicMomentumOUExpression β γ G x =
      -(γ * β⁻¹) * ∑ i : Fin N,
        textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i)
          (textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1)) x := by
  simp only [textbookLangevinPeriodicMomentumOUExpression, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  simp only [textbookLangevinCanonicalCoordinateAdjointTestExpression,
    textbookLangevinCanonicalCoordinateDirection, textbookLangevinCanonicalCoordinateLogSlope]
  field_simp [ne_of_gt hβ]
  ring

/-- Every actual closed Langevin kernel element annihilates each true canonical
momentum transpose test, from the proved entire-domain momentum energy. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_momentum_testing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (i : Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i) G x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  have hfcl := (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).mem_graph f
  rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ] at hfcl
  have hg := textbookLangevinCanonicalClosedGraphMomentumDerivative_coordinate_graph U hU hp β γ σ hβ hγ hσ
    ⟨((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)),
      textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f), hfcl⟩ i
  change ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)),
    textbookLangevinCanonicalHilbertClosedOperatorMomentumDerivative U hU hp β γ σ hβ hγ hσ f i) ∈
    (textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).graph at hg
  rw [textbookLangevinCanonicalHilbertClosedOperator_kernel_momentum_zero U hU hp β γ σ hβ hγ hσ f hf,
    PiLp.zero_apply, textbookLangevinCanonicalCoordinateClosedOperator_graph U hU hp β hβ (Sum.inr i)] at hg
  have he := textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_pairing U hU hp β hβ (Sum.inr i)
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) 0 hg G hG hsG
  rw [inner_zero_left, kernelTransport_inner_integral] at he
  exact he.symm

/-- The actual closed kernel annihilates the full original momentum OU test expression,
using proved integrability and the genuine momentum transpose identity. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_OU_testing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicMomentumOUExpression β γ G x ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  let T (i : Fin N) := textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i)
    (textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1))
  have hD (i : Fin N) : ContDiff ℝ ∞
      (textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) ∘ textbookLangevinPeriodicProjection) :=
    textbookLangevinPeriodicDirectionalDerivative_lift_contDiff G hG _
  have hsD (i : Fin N) : HasCompactSupport (textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1)) :=
    textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport G hsG _
  have hT (i : Fin N) : MemLp (T i) 2 (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ (Sum.inr i)
      _ (hD i) (hsD i)
  have hI (i : Fin N) : Integrable (fun x ↦
      (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * T i x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (Lp.memLp (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))).integrable_mul (hT i)
  have h0 (i : Fin N) : (∫ x,
      (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * T i x
        ∂textbookLangevinCanonicalMeasure U β hβ) = 0 :=
    textbookLangevinCanonicalHilbertClosedOperator_kernel_momentum_testing U hU hp β γ σ hβ hγ hσ f hf i
      _ (hD i) (hsD i)
  calc
    _ = ∫ x, -(γ * β⁻¹) * ∑ i : Fin N,
        (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * T i x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
      apply integral_congr_ae
      filter_upwards [] with x
      rw [textbookLangevinCanonicalMomentumOUExpression_coordinate_transpose U β γ hβ G x]
      change (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
        (-(γ * β⁻¹) * ∑ i : Fin N, T i x) =
        -(γ * β⁻¹) * ∑ i : Fin N,
          (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * T i x
      rw [← Finset.mul_sum]
      ring
    _ = -(γ * β⁻¹) * ∑ i : Fin N, ∫ x,
        (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * T i x
          ∂textbookLangevinCanonicalMeasure U β hβ := by
      rw [integral_const_mul, integral_finsetSum Finset.univ (fun i _ ↦ hI i)]
    _ = 0 := by simp_rw [h0]; simp

/-- Every actual closed Langevin kernel element is a weak conserved quantity of
the original Hamiltonian transport, derived from genuine closed transpose testing
and the proved vanishing OU pairing. No momentum independence or kernel constancy is assumed. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_hamiltonian_testing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicHamiltonianTransportExpression U G x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  let H := textbookLangevinPeriodicHamiltonianTransportExpression U G
  let O := textbookLangevinPeriodicMomentumOUExpression β γ G
  have hH : Integrable (fun x ↦ (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * H x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (Lp.memLp (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))).integrable_mul
      (textbookLangevinCanonicalMeasure_hamiltonianTest_memLp_two U hU hp β hβ G hG hsG)
  have hO : Integrable (fun x ↦ (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * O x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (Lp.memLp (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))).integrable_mul
      (kernelTransport_O_memLp U hU hp β γ hβ G hG hsG)
  have hHN : Integrable (fun x ↦ -((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * H x))
      (textbookLangevinCanonicalMeasure U β hβ) := hH.neg
  have hfg := (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).mem_graph f
  rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ] at hfg
  have he := textbookLangevinCanonicalHilbertTestGraph_closure_pairing U hU hp β γ σ hβ hσ
    f (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f) hfg G hG hsG
  rw [hf, inner_zero_left, kernelTransport_inner_integral] at he
  have hsplit : (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ G x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
      -(∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * H x
        ∂textbookLangevinCanonicalMeasure U β hβ) +
      ∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * O x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
    calc
      _ = ∫ x, -((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * H x) +
          (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * O x
          ∂textbookLangevinCanonicalMeasure U β hβ := by
        apply integral_congr_ae
        filter_upwards [] with x
        simp only [textbookLangevinCanonicalWeightedFormalAdjointExpression, H, O]
        ring
      _ = _ := by rw [integral_add hHN hO, integral_neg]
  have hO0 := textbookLangevinCanonicalHilbertClosedOperator_kernel_OU_testing U hU hp β γ σ hβ hγ hσ f hf G hG hsG
  change (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * H x
    ∂textbookLangevinCanonicalMeasure U β hβ) = 0
  change (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * O x
    ∂textbookLangevinCanonicalMeasure U β hβ) = 0 at hO0
  linarith [he, hsplit, hO0]

end
end MolecularDynamics
