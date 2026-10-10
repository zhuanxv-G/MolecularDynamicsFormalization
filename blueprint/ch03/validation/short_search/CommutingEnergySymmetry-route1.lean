import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03Short34
set_option maxHeartbeats 400000
theorem commutingEnergySymmetry :
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 K D → IsOpen D → actualFlow (textbookHamiltonianVectorField H) D Φ η →
    (∀ z ∈ D, textbookPoissonBracket H K z=0) →
      (∀ z ∈ D, textbookPoissonBracket K H z=0) ∧ ∀ z ∈ D, ∀ t ∈ Ioo (-η) η, K (Φ t z)=K z := by
  intro n H K D Φ η hK hD hflow hzero
  have hskew : ∀ z ∈ D, textbookPoissonBracket K H z = 0 := by
    intro z hz
    rw [textbookPoissonBracket_skew, hzero z hz, neg_zero]
  refine ⟨hskew, ?_⟩
  intro z hz t ht
  have hη := hflow.1
  have htraj := hflow.2 z hz
  have hd : ∀ s ∈ Ioo (-η) η, HasDerivAt (fun u => K (Φ u z)) 0 s := by
    intro s hs
    have hks : DifferentiableAt ℝ K (Φ s z) :=
      (hK.differentiableOn (by norm_num)).differentiableAt (hD.mem_nhds (htraj.2 s hs).1)
    simpa only [textbookLieDerivative_hamiltonian_eq_poisson,
      hskew _ (htraj.2 s hs).1] using
      hasDerivAt_textbookLieDerivative (textbookHamiltonianVectorField H) K
        (fun u => Φ u z) s hks (htraj.2 s hs).2
  have heq := isOpen_Ioo.is_const_of_deriv_eq_zero (convex_Ioo (-η) η).isPreconnected
    (fun s hs => (hd s hs).differentiableAt.differentiableWithinAt)
    (fun s hs => (hd s hs).deriv) ht (show (0:ℝ) ∈ Ioo (-η) η by constructor <;> linarith)
  simpa only [htraj.1] using heq
end MD.Ch03Short34
