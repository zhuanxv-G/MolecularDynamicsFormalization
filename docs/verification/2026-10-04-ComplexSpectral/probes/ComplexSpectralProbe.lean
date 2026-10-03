import MolecularDynamics.Chapter01.LinearFlow
import Mathlib.Analysis.Complex.RealDeriv

namespace MolecularDynamics
section ComplexBanach
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]

noncomputable def complexExponentialFlow (A : E →L[ℂ] E) (t : ℝ) (z : E) : E :=
  linearExponentialFlow (A.restrictScalars ℝ) t z

omit [CompleteSpace E] in
 theorem hasDerivAt_complexEigenmode (A : E →L[ℂ] E) (ν : ℂ) (η : E)
    (hη : A η = ν • η) (t₀ t : ℝ) :
    HasDerivAt (fun u : ℝ => Complex.exp (ν * ((u - t₀ : ℝ) : ℂ)) • η)
      (A (Complex.exp (ν * ((t - t₀ : ℝ) : ℂ)) • η)) t := by
  have hscale : HasDerivAt (fun u : ℂ => ν * u) ν (t - t₀ : ℝ) := by
    simpa using (hasDerivAt_id ((t - t₀ : ℝ) : ℂ)).const_mul ν
  have he := ((Complex.hasDerivAt_exp (ν * ((t - t₀ : ℝ) : ℂ))).comp
    ((t - t₀ : ℝ) : ℂ) hscale).comp_ofReal
  have h := (he.scomp t ((hasDerivAt_id t).sub_const t₀)).smul_const η
  rw [one_smul] at h
  rw [map_smul, hη, smul_smul]
  exact h

theorem complexExponentialFlow_eigenmode (A : E →L[ℂ] E) (ν : ℂ) (η : E)
    (hη : A η = ν • η) (t : ℝ) :
    complexExponentialFlow A t η = Complex.exp (ν * (t : ℂ)) • η := by
  have heq := linearExponentialFlow_unique (A.restrictScalars ℝ) η 0
    (fun u : ℝ => Complex.exp (ν * ((u - 0 : ℝ) : ℂ)) • η)
    (fun u => hasDerivAt_complexEigenmode A ν η hη 0 u) (by simp)
  simpa [complexExponentialFlow] using (congrFun heq t).symm

theorem complexExponentialFlow_spectral_sum {ι : Type*}
    (s : Finset ι) (A : E →L[ℂ] E) (ν c : ι → ℂ) (η : ι → E)
    (hη : ∀ i ∈ s, A (η i) = ν i • η i) (z : E)
    (hinit : z = ∑ i ∈ s, c i • η i) (t : ℝ) :
    complexExponentialFlow A t z = ∑ i ∈ s, (c i * Complex.exp (ν i * (t : ℂ))) • η i := by
  have hcoeff : ∀ i ∈ s, A (c i • η i) = ν i • (c i • η i) := by
    intro i hi
    rw [map_smul, hη i hi, smul_smul, smul_smul, mul_comm]
  have hder : ∀ u : ℝ, HasDerivAt
      (fun v : ℝ => ∑ i ∈ s, Complex.exp (ν i * (v : ℂ)) • (c i • η i))
      (A (∑ i ∈ s, Complex.exp (ν i * (u : ℂ)) • (c i • η i))) u := by
    intro u
    have h := HasDerivAt.fun_sum (u := s) (fun i hi =>
      hasDerivAt_complexEigenmode A (ν i) (c i • η i) (hcoeff i hi) 0 u)
    simp only [sub_zero] at h
    rw [← map_sum] at h
    exact h
  have heq := linearExponentialFlow_unique (A.restrictScalars ℝ) z 0 _ hder
    (by simpa using hinit.symm)
  simpa [complexExponentialFlow, smul_smul, mul_comm] using (congrFun heq t).symm

theorem complexExponentialFlow_eigenbasis {ι : Type*} [Fintype ι]
    (A : E →L[ℂ] E) (b : Module.Basis ι ℂ E) (ν : ι → ℂ)
    (hb : ∀ i, A (b i) = ν i • b i) (z : E) (t : ℝ) :
    complexExponentialFlow A t z =
      ∑ i, (b.repr z i * Complex.exp (ν i * (t : ℂ))) • b i := by
  exact complexExponentialFlow_spectral_sum Finset.univ A ν (b.repr z) b
    (fun i _ => hb i) z (b.sum_repr z).symm t


theorem hasDerivAt_complexExponentialFlow (A : E →L[ℂ] E) (z : E) (t : ℝ) :
    HasDerivAt (fun u => complexExponentialFlow A u z)
      (A (complexExponentialFlow A t z)) t :=
  hasDerivAt_linearExponentialFlow (A.restrictScalars ℝ) z t

noncomputable def complexContinuousFlow (A : E →L[ℂ] E) : Flow ℝ E :=
  linearContinuousFlow (A.restrictScalars ℝ)

omit [CompleteSpace E] in theorem complexEigenbasis_coefficients_unique {ι : Type*} [Fintype ι]
    (b : Module.Basis ι ℂ E) (z : E) :
    ∃! c : ι → ℂ, z = ∑ i, c i • b i := by
  refine ⟨fun i => b.repr z i, (b.sum_repr z).symm, ?_⟩
  intro c hc
  funext i
  have h := congrArg (fun x => b.repr x i) hc
  simpa only [b.repr_sum_self] using h.symm
end ComplexBanach
#print axioms hasDerivAt_complexExponentialFlow
#print axioms complexContinuousFlow
#print axioms complexEigenbasis_coefficients_unique
#print axioms hasDerivAt_complexEigenmode
#print axioms complexExponentialFlow_eigenmode
#print axioms complexExponentialFlow_spectral_sum
#print axioms complexExponentialFlow_eigenbasis
end MolecularDynamics
