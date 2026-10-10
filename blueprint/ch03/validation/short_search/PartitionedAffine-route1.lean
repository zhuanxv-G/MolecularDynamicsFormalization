import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03Short36
set_option maxHeartbeats 400000
theorem partitionedAffine :
  ∀ (n s : ℕ) (Lq Lp : Q n ≃L[ℝ] Q n) (fq fp : Z n → Q n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) (h : ℝ) (z w : Z n) (Fq Fp : Fin s → Q n),
    (∀ i, Fq i=fq (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    (∀ i, Fp i=fp (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    w=(z.1+h • ∑ i, bq i • Fq i,z.2+h • ∑ i, bp i • Fp i) →
    (∀ i, Lq (Fq i)=Lq (fq (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (∀ i, Lp (Fp i)=Lp (fp (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (Lq w.1,Lp w.2)=(Lq z.1+h • ∑ i, bq i • Lq (Fq i),Lp z.2+h • ∑ i, bp i • Lp (Fp i)) := by
  intro n s Lq Lp fq fp Aq Ap bq bp h z w Fq Fp hq hp hw
  have tq : ∀ a : Fin s → ℝ,
      Lq.symm (Lq z.1+h • ∑ j, a j • Lq (Fq j)) = z.1+h • ∑ j, a j • Fq j := by
    intro a
    apply Lq.injective
    simp
  have tp : ∀ a : Fin s → ℝ,
      Lp.symm (Lp z.2+h • ∑ j, a j • Lp (Fp j)) = z.2+h • ∑ j, a j • Fp j := by
    intro a
    apply Lp.injective
    simp
  refine ⟨?_, ?_, ?_⟩
  · intro i
    rw [tq, tp]
    exact congrArg Lq (hq i)
  · intro i
    rw [tq, tp]
    exact congrArg Lp (hp i)
  · rw [hw]
    simp
end MD.Ch03Short36
