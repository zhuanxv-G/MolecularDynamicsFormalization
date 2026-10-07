import MolecularDynamics.Chapter01.LinearFlow

/-! Printed27/PDF50: actual modes and finite real spectral expansion.
Basis.repr supplies coefficients when a real eigenbasis is given.
Complex eigenvalues and real-solution recovery are separate statements. -/

namespace MolecularDynamics
section Banach
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

omit [CompleteSpace E] in
 theorem hasDerivAt_realEigenmode (A : E →L[ℝ] E) (ν : ℝ) (η : E)
    (hη : A η = ν • η) (t₀ t : ℝ) :
    HasDerivAt (fun u => Real.exp (ν * (u - t₀)) • η)
      (A (Real.exp (ν * (t - t₀)) • η)) t := by
  have hscale : HasDerivAt (fun u : ℝ => ν * (u - t₀)) ν t := by
    simpa using ((hasDerivAt_id t).sub_const t₀).const_mul ν
  have h := ((Real.hasDerivAt_exp (ν * (t - t₀))).comp t hscale).smul_const η
  rw [map_smul, hη, smul_smul]
  exact h

theorem linearExponentialFlow_realEigenmode (A : E →L[ℝ] E) (ν : ℝ) (η : E)
    (hη : A η = ν • η) (t : ℝ) :
    linearExponentialFlow A t η = Real.exp (ν * t) • η := by
  have heq := linearExponentialFlow_unique A η 0
    (fun u => Real.exp (ν * (u - 0)) • η)
    (fun u => hasDerivAt_realEigenmode A ν η hη 0 u) (by simp)
  simpa using (congrFun heq t).symm

theorem linearExponentialFlow_realSpectral_sum {ι : Type*}
    (s : Finset ι) (A : E →L[ℝ] E) (ν c : ι → ℝ) (η : ι → E)
    (hη : ∀ i ∈ s, A (η i) = ν i • η i) (z : E)
    (hinit : z = ∑ i ∈ s, c i • η i) (t : ℝ) :
    linearExponentialFlow A t z = ∑ i ∈ s, (c i * Real.exp (ν i * t)) • η i := by
  rw [hinit]
  change (NormedSpace.exp (t • A)) (∑ i ∈ s, c i • η i) = _
  rw [map_sum]
  apply Finset.sum_congr rfl
  intro i hi
  rw [map_smul]
  change c i • linearExponentialFlow A t (η i) = _
  rw [linearExponentialFlow_realEigenmode A (ν i) (η i) (hη i hi), smul_smul]


theorem linearExponentialFlow_realEigenbasis {ι : Type*} [Fintype ι]
    (A : E →L[ℝ] E) (b : Module.Basis ι ℝ E) (ν : ι → ℝ)
    (hb : ∀ i, A (b i) = ν i • b i) (z : E) (t : ℝ) :
    linearExponentialFlow A t z = ∑ i, (b.repr z i * Real.exp (ν i * t)) • b i := by
  exact linearExponentialFlow_realSpectral_sum Finset.univ A ν (b.repr z) b
    (fun i _ => hb i) z (b.sum_repr z).symm t
end Banach
end MolecularDynamics
