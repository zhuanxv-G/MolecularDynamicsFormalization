import MolecularDynamics.Chapter01.MatrixFlow
import MolecularDynamics.Chapter01.ComplexSpectralFlow
import Mathlib.Analysis.Complex.RealDeriv

namespace MolecularDynamics
section Banach
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

theorem linearExponentialFlow_intertwine (A B C : E →L[ℝ] E)
    (hAB : ∀ x, B (A x) = C (B x)) (z : E) (t : ℝ) :
    B (linearExponentialFlow A t z) = linearExponentialFlow C t (B z) := by
  have hder : ∀ u : ℝ, HasDerivAt (fun v => B (linearExponentialFlow A v z))
      (C (B (linearExponentialFlow A u z))) u := by
    intro u
    have h := B.hasFDerivAt.comp_hasDerivAt u (hasDerivAt_linearExponentialFlow A z u)
    rw [hAB] at h
    exact h
  have heq := linearExponentialFlow_unique C (B z) 0 _ hder (by simp)
  simpa using congrFun heq t

theorem linearExponentialFlow_fixed_clm (A B : E →L[ℝ] E)
    (hAB : ∀ x, B (A x) = A (B x)) (z : E) (hz : B z = z) (t : ℝ) :
    B (linearExponentialFlow A t z) = linearExponentialFlow A t z := by
  rw [linearExponentialFlow_intertwine A B A hAB, hz]
end Banach

noncomputable def complexPositionConjugation (m : ℕ) :
    EuclideanSpace ℂ (Fin m) →L[ℝ] EuclideanSpace ℂ (Fin m) :=
  LinearMap.toContinuousLinearMap {
    toFun := fun q => WithLp.toLp 2 (fun i => star (q i))
    map_add' := by
      intro q p
      ext i
      simp [PiLp.add_apply]
    map_smul' := by
      intro r q
      ext i
      simp [PiLp.smul_apply]
  }

theorem complexPositionConjugation_coordinate (m : ℕ)
    (q : EuclideanSpace ℂ (Fin m)) (i : Fin m) :
    complexPositionConjugation m q i = star (q i) := rfl

theorem realMatrix_conjugation_commute {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (q : EuclideanSpace ℂ (Fin m)) :
    complexPositionConjugation m
      (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal) q) =
    Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal)
      (complexPositionConjugation m q) := by
  ext i
  change star (∑ j, (A i j : ℂ) * q j) = ∑ j, (A i j : ℂ) * star (q j)
  simp

theorem realMatrix_complexFlow_isReal {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : EuclideanSpace ℂ (Fin m)) (hz : ∀ i, (z i).im = 0) (t : ℝ) (i : Fin m) :
    (linearExponentialFlow
      ((Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal)).restrictScalars ℝ)
      t z i).im = 0 := by
  have hz' : complexPositionConjugation m z = z := by
    ext j
    apply Complex.ext
    · rfl
    · simp [complexPositionConjugation_coordinate, hz j]
  have hfixed := linearExponentialFlow_fixed_clm
    ((Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal)).restrictScalars ℝ)
    (complexPositionConjugation m) (realMatrix_conjugation_commute A) z hz' t
  have him := congrArg (fun q : EuclideanSpace ℂ (Fin m) => (q i).im) hfixed
  rw [complexPositionConjugation_coordinate] at him
  simp only [Complex.star_def, Complex.conj_im] at him
  linarith


theorem realMatrix_complexSpectral_sum_isReal {m : ℕ}
    (A : Matrix (Fin m) (Fin m) ℝ)
    (b : Module.Basis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (ν : Fin m → ℂ)
    (hb : ∀ j, Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal)
      (b j) = ν j • b j)
    (z : EuclideanSpace ℂ (Fin m)) (hz : ∀ j, (z j).im = 0) (t : ℝ) (i : Fin m) :
    ((∑ j, (b.repr z j * Complex.exp (ν j * (t : ℂ))) • b j) i).im = 0 := by
  rw [← complexExponentialFlow_eigenbasis
    (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal)) b ν hb z t]
  exact realMatrix_complexFlow_isReal A z hz t i

#print axioms realMatrix_complexSpectral_sum_isReal
#print axioms linearExponentialFlow_intertwine
#print axioms linearExponentialFlow_fixed_clm
#print axioms realMatrix_conjugation_commute
#print axioms realMatrix_complexFlow_isReal
end MolecularDynamics
