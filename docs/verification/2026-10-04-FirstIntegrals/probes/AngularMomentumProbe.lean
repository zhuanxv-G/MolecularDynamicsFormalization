import MolecularDynamics.Chapter01.HarmonicOscillator

open Set
namespace MolecularDynamics

def planarAngularMomentum (z : PhaseSpace 2) : ℝ :=
  z.1 0 * z.2 1 - z.1 1 * z.2 0

theorem planarAngularMomentum_hasDerivAt_zero (F : Force 2)
    (Q : Set (Position 2)) (I : Set ℝ) (γ : ℝ → PhaseSpace 2)
    (hI : IsOpen I)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) F Q I γ)
    (hTorque : ∀ q ∈ Q, q 0 * F q 1 - q 1 * F q 0 = 0)
    (t : ℝ) (ht : t ∈ I) :
    HasDerivAt (fun s => planarAngularMomentum (γ s)) 0 t := by
  obtain ⟨hq, hp⟩ := ((isMechanicalSolutionOn_iff_components _ _ _ _ _ hI).1 hγ).2 t ht
  rw [velocityOperator_unit] at hq
  have hqc : ∀ i : Fin 2, HasDerivAt (fun s => (γ s).1 i) ((γ t).2 i) t := by
    intro i
    exact (EuclideanSpace.proj (𝕜 := ℝ) i).hasFDerivAt.comp_hasDerivAt t hq
  have hpc : ∀ i : Fin 2, HasDerivAt (fun s => (γ s).2 i) (F (γ t).1 i) t := by
    intro i
    exact (EuclideanSpace.proj (𝕜 := ℝ) i).hasFDerivAt.comp_hasDerivAt t hp
  have hd := ((hqc 0).mul (hpc 1)).sub ((hqc 1).mul (hpc 0))
  have heq : (γ t).2 0 * (γ t).2 1 + (γ t).1 0 * F (γ t).1 1 -
      ((γ t).2 1 * (γ t).2 0 + (γ t).1 1 * F (γ t).1 0) = 0 := by
    nlinarith [hTorque (γ t).1 (hγ.1 t ht)]
  rw [heq] at hd
  exact hd

theorem planarAngularMomentum_const_on_Ioo (F : Force 2) (Q : Set (Position 2))
    (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) F Q (Ioo a b) γ)
    (hTorque : ∀ q ∈ Q, q 0 * F q 1 - q 1 * F q 0 = 0)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t) := by
  have hd : ∀ u ∈ Ioo a b, HasDerivAt (fun v => planarAngularMomentum (γ v)) 0 u :=
    fun u hu => planarAngularMomentum_hasDerivAt_zero F Q (Ioo a b) γ
      isOpen_Ioo hγ hTorque u hu
  exact isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo
    (fun u hu => (hd u hu).differentiableAt.differentiableWithinAt)
    (fun u hu => (hd u hu).deriv) hs ht

theorem centralForce_planarTorque_zero (c : Position 2 → ℝ) (q : Position 2) :
    q 0 * (c q • q) 1 - q 1 * (c q • q) 0 = 0 := by
  simp only [PiLp.smul_apply, smul_eq_mul]
  ring

theorem centralForce_planarAngularMomentum_const (c : Position 2 → ℝ)
    (Q : Set (Position 2)) (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) (fun q => c q • q) Q (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t) :=
  planarAngularMomentum_const_on_Ioo (fun q => c q • q) Q a b γ hγ
    (fun q _ => centralForce_planarTorque_zero c q) s t hs ht

#print axioms planarAngularMomentum_hasDerivAt_zero
#print axioms planarAngularMomentum_const_on_Ioo
#print axioms centralForce_planarAngularMomentum_const
end MolecularDynamics
