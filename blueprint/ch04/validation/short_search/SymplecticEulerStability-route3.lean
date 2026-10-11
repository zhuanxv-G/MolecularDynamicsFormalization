import MolecularDynamics.Chapter04.Statements
import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter04Review
open scoped BigOperators Topology Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04EulerStable
set_option maxHeartbeats 400000
theorem verletStability :
  ∀ Ω h : ℝ, 0 < |h*Ω| → |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h) := by
  intro Ω h hn ht
  have hΩ : Ω ≠ 0 := by intro hz; simp [hz] at hn
  have ht2 : h^2*Ω^2 < 4 := by
    obtain ⟨ha,hb⟩ := abs_lt.mp ht
    nlinarith
  let b : ℝ := Ω^2*(1-h^2*Ω^2/4)
  have hb : 0 < b := mul_pos (sq_pos_of_ne_zero hΩ) (by nlinarith)
  let A := MolecularDynamics.Chapter04Review.verletMatrix Ω h
  let K : (Fin 2 → ℝ) → ℝ := fun v => v 1^2+b*v 0^2
  have hstep : ∀ v : Fin 2 → ℝ, K (A *ᵥ v)=K v := by
    intro v
    simp [K,A,b,MolecularDynamics.Chapter04Review.verletMatrix,Matrix.mulVec,dotProduct, vecHead, vecTail,Fin.sum_univ_two]
    ring
  have hi : ∀ k : ℕ, ∀ v : Fin 2 → ℝ, K (A^k *ᵥ v)=K v := by
    intro k v
    induction k with
    | zero => simp
    | succ k ih => rw [pow_succ',← Matrix.mulVec_mulVec,hstep,ih]
  let d : ℝ := min 1 b
  have hd : 0 < d := lt_min (by norm_num) hb
  have hd1 : d ≤ 1 := min_le_left _ _
  have hdb : d ≤ b := min_le_right _ _
  have hcoord : ∀ (v : Fin 2 → ℝ) (i : Fin 2), (v i)^2 ≤ ‖v‖^2 := by
    intro v i
    rw [← sq_abs]
    exact (sq_le_sq₀ (abs_nonneg _) (norm_nonneg _)).mpr (by simpa using norm_le_pi_norm v i)
  have hu : ∀ v : Fin 2 → ℝ, K v ≤ (1+b)*‖v‖^2 := by
    intro v
    have hm := mul_le_mul_of_nonneg_left (hcoord v 0) hb.le
    dsimp [K]
    nlinarith [hcoord v 1]
  have hl : ∀ (v : Fin 2 → ℝ) (i : Fin 2), d*(v i)^2 ≤ K v := by
    intro v i
    fin_cases i
    · dsimp [K]
      nlinarith [mul_nonneg (sub_nonneg.mpr hdb) (sq_nonneg (v 0)),sq_nonneg (v 1)]
    · dsimp [K]
      nlinarith [mul_nonneg (sub_nonneg.mpr hd1) (sq_nonneg (v 1)),mul_nonneg hb.le (sq_nonneg (v 0))]
  let C : ℝ := Real.sqrt ((1+b)/d)
  have hC : 0 ≤ C := Real.sqrt_nonneg _
  have hCs : C^2*d=1+b := by
    dsimp [C]
    rw [Real.sq_sqrt (by positivity)]
    field_simp [ne_of_gt hd]
  refine ⟨C, ?_⟩
  intro k v
  apply (pi_norm_le_iff_of_nonneg (mul_nonneg hC (norm_nonneg v))).mpr
  intro i
  have hm : d*((A^k *ᵥ v) i)^2 ≤ d*(C*‖v‖)^2 := calc
    d*((A^k *ᵥ v) i)^2 ≤ K (A^k *ᵥ v) := hl _ i
    _ = K v := hi k v
    _ ≤ (1+b)*‖v‖^2 := hu v
    _ = d*(C*‖v‖)^2 := by rw [← hCs]; ring
  have hsq := le_of_mul_le_mul_left hm hd
  simpa using abs_le_of_sq_le_sq hsq (mul_nonneg hC (norm_nonneg v))
theorem symplecticEulerRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ∃ d : ℂ, d^2=(h^4*Ω^4-4*h^2*Ω^2 : ℝ) ∧
        (ζ=1-(h^2*Ω^2 : ℝ)/2+d/2 ∨ ζ=1-(h^2*Ω^2 : ℝ)/2-d/2) := by
  intro Ω h ζ
  let A : Matrix (Fin 2) (Fin 2) ℂ := (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal
  have heig : (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=0 := by
    rw [← Matrix.exists_mulVec_eq_zero_iff]
    simp only [Matrix.sub_mulVec, Matrix.smul_mulVec, Matrix.one_mulVec, sub_eq_zero]
    constructor
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
  have hchar : (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=ζ^2-(2-h^2*Ω^2 : ℝ)*ζ+1 := by
    simp [A, MolecularDynamics.Chapter04Review.symplecticEulerMatrix, Matrix.det_fin_two]
    push_cast
    ring
  change (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ _
  rw [heig,hchar]
  constructor
  · intro he
    refine ⟨2*ζ-(2-h^2*Ω^2 : ℝ), ?_, Or.inl ?_⟩
    · push_cast at he ⊢
      linear_combination 4*he
    · push_cast
      ring
  · rintro ⟨d,hroot,(rfl|rfl)⟩ <;> push_cast at hroot ⊢ <;>
      linear_combination (1/4 : ℂ)*hroot
theorem symplecticEulerStability :
  ∀ Ω h : ℝ, (0 < |h*Ω| ∧ |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)) ∧
    (2 < |h*Ω| → MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)) := by
  intro Ω h
  constructor
  · rintro ⟨hn,ht⟩
    obtain ⟨C,hC⟩ := verletStability Ω h hn ht
    let s : ℝ := h*Ω^2/2
    let P : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -s,1]
    let S : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; s,1]
    let A := MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h
    let B := MolecularDynamics.Chapter04Review.verletMatrix Ω h
    have hSP : S*P=1 := by
      ext i j; fin_cases i <;> fin_cases j <;>
        simp [S,P,Matrix.mul_apply,Fin.sum_univ_two]
    have hPA : P*A=B*P := by
      ext i j; fin_cases i <;> fin_cases j <;>
        simp [P,A,B,s,MolecularDynamics.Chapter04Review.symplecticEulerMatrix,
          MolecularDynamics.Chapter04Review.verletMatrix,Matrix.mul_apply,Fin.sum_univ_two] <;> ring
    have hp : ∀ k : ℕ, P*A^k=B^k*P := by
      intro k
      induction k with
      | zero => simp
      | succ k ih => rw [pow_succ',pow_succ',← mul_assoc,hPA,mul_assoc,ih,← mul_assoc]
    have hs : ∀ a : ℝ, ∀ v : Fin 2 → ℝ,
        ‖(!![1,0; a,1] : Matrix (Fin 2) (Fin 2) ℝ) *ᵥ v‖ ≤ (1+|a|)*‖v‖ := by
      intro a v
      have h0 : |v 0| ≤ ‖v‖ := by simpa using norm_le_pi_norm v 0
      have h1 : |v 1| ≤ ‖v‖ := by simpa using norm_le_pi_norm v 1
      apply (pi_norm_le_iff_of_nonneg (by positivity)).mpr
      intro i
      fin_cases i
      · simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,vecHead,vecTail]
        nlinarith [mul_nonneg (abs_nonneg a) (norm_nonneg v)]
      · simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,vecHead,vecTail]
        change |a*v 0+v 1| ≤ (1+|a|)*‖v‖
        calc
          _ ≤ |a| * |v 0|+|v 1| := by simpa [abs_mul] using abs_add_le (a*v 0) (v 1)
          _ ≤ |a| * ‖v‖+‖v‖ := add_le_add (mul_le_mul_of_nonneg_left h0 (abs_nonneg a)) h1
          _ = _ := by ring
    refine ⟨(1+|s|)^2*|C|, ?_⟩
    intro k v
    have he : A^k *ᵥ v=S *ᵥ (B^k *ᵥ (P *ᵥ v)) := by
      have inner : B^k *ᵥ (P *ᵥ v)=(P*A^k) *ᵥ v := by rw [Matrix.mulVec_mulVec,hp k]
      rw [inner,Matrix.mulVec_mulVec,← mul_assoc,hSP,one_mul]
    rw [he]
    calc
      _ ≤ (1+|s|)*‖B^k *ᵥ (P *ᵥ v)‖ := hs s _
      _ ≤ (1+|s|)*(|C| * ‖P *ᵥ v‖) := by
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        exact (hC k (P *ᵥ v)).trans (mul_le_mul_of_nonneg_right (le_abs_self C) (norm_nonneg _))
      _ ≤ (1+|s|)*(|C| * ((1+|s|)*‖v‖)) := by
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        apply mul_le_mul_of_nonneg_left _ (abs_nonneg C)
        simpa [P,abs_neg] using hs (-s) v
      _ = _ := by ring
  · intro ht
    have ht2 : 4 < h^2*Ω^2 := by
      have hs := sq_lt_sq₀ (by norm_num : (0:ℝ) ≤ 2) (abs_nonneg (h*Ω))
      have hh : (2:ℝ)^2 < |h*Ω|^2 := hs.mpr ht
      norm_num [sq_abs,mul_pow] at hh ⊢
      exact hh
    let D : ℝ := h^4*Ω^4-4*h^2*Ω^2
    have hD : 0 < D := by dsimp [D]; nlinarith
    let d : ℝ := Real.sqrt D
    have hd : d^2=D := Real.sq_sqrt hD.le
    let ρ : ℝ := 1-h^2*Ω^2/2-d/2
    have hr : ρ < -1 := by dsimp [ρ,d]; nlinarith [Real.sqrt_nonneg D]
    have hv := (symplecticEulerRoots Ω h (ρ : ℂ)).mpr
      ⟨(d : ℂ),by exact_mod_cast hd,Or.inr (by dsimp [ρ]; push_cast; ring)⟩
    refine ⟨(ρ : ℂ), ?_, hv⟩
    rw [Complex.norm_real,Real.norm_eq_abs,abs_of_neg (by linarith)]
    linarith
end MD.Ch04EulerStable
