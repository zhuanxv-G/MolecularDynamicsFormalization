import MolecularDynamics.Chapter04.Statements
import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv
import Mathlib.Analysis.Calculus.Deriv.Slope
import Mathlib.Analysis.SpecialFunctions.Trigonometric.ArctanDeriv
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Tactic

open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04
variable {n Nc : ℕ}
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {R : Type*} [Ring R] [Algebra ℝ R]

/-- source_id: MD-4-LinearField · (4.1) · §4 · 印刷p.139 / PDFp.161
[EXTRA] 复线性扩张用于随后的标量测试；原实矩阵实例嵌入ℂ。 -/
def linearField {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (z : Fin n → ℂ) := A *ᵥ z

/-- source_id: MD-4-EulerFactor · definition · §4 · 印刷p.139 / PDFp.161 -/
def eulerFactor (h : ℝ) (rho : ℂ) : ℂ := 1 + (h : ℂ) * rho

/-- source_id: MD-4-ScalarEulerStable · unnumbered_claim · §4 · 印刷p.139 / PDFp.161
[EXTRA] scalarStable明确定义为因子各次幂一致有界；非零初值下等价于迭代有界，零初值例外。 -/
theorem scalarEulerStable :
  ∀ h rho, MolecularDynamics.Chapter04Review.scalarStable (MolecularDynamics.Chapter04Review.eulerFactor h rho) ↔ ‖MolecularDynamics.Chapter04Review.eulerFactor h rho‖ ≤ 1 := by
  intro h rho
  constructor
  · rintro ⟨C, hC⟩
    by_contra hn
    have ht := (tendsto_pow_atTop_atTop_of_one_lt (lt_of_not_ge hn)).eventually (eventually_gt_atTop C)
    obtain ⟨k,hk⟩ := ht.exists
    have hb := hC k
    rw [norm_pow] at hb
    exact (not_lt_of_ge hb) hk
  · intro ha
    refine ⟨1, ?_⟩
    intro k
    rw [norm_pow]
    exact pow_le_one₀ (norm_nonneg _) ha

/-- source_id: MD-4-EulerRegion · definition · §4 · 印刷p.139 / PDFp.161 -/
def eulerStabilityRegion : Set ℂ := {z | ‖1+z‖ ≤ 1}

/-- source_id: MD-4-OscillatorMatrix · definition · §4 · 印刷p.139 / PDFp.161
[EXTRA] 一个自由度，I=1；按标量频率实例解释。 -/
def oscillatorMatrix (Ω : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![0,1; -Ω^2,0]

/-- source_id: MD-4-EulerImaginaryGrowth · unnumbered_claim · §4 · 印刷p.140 / PDFp.162
[EXTRA] h≠0、Ω≠0、复标量非零初值；只证明此线性振荡例，不声称所有非线性Hamiltonian平衡点都有纯虚谱。 -/
theorem eulerImaginaryGrowth :
  ∀ h Ω : ℝ, h ≠ 0 → Ω ≠ 0 → ∀ z : ℂ, z ≠ 0 →
    Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))^k*z‖) atTop atTop := by
  intro h Ω hh hΩ z hz
  have hs : ‖MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω)‖^2=1+(h*Ω)^2 := by
    simp_all [MolecularDynamics.Chapter04Review.eulerFactor, Complex.sq_norm, Complex.normSq_apply]
    ring
  have hp : 0 < (h*Ω)^2 := sq_pos_of_ne_zero (mul_ne_zero hh hΩ)
  have hg : 1 < ‖MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω)‖ := by
    nlinarith [norm_nonneg (MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))]
  have ht := (tendsto_pow_atTop_atTop_of_one_lt hg).atTop_mul_const (norm_pos_iff.mpr hz)
  simpa [norm_mul, norm_pow] using ht

/-- source_id: MD-4-SymplecticEulerMatrix · definition · §4 · 印刷p.140 / PDFp.162 -/
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]

/-- source_id: MD-4-SymplecticEulerCharacteristic · unnumbered_claim · §4 · 印刷p.140 / PDFp.162
[EXTRA] 以真实复特征多项式等式表达二次根方程；全部复根公式另列，不能将特征多项式等式当实际求根已证。 -/
theorem symplecticEulerCharacteristic :
  ∀ Ω h : ℝ, ∀ rho : ℂ, (rho • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
    (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal).det=rho^2-(2-h^2*Ω^2 : ℝ)*rho+1 := by
  intro Ω h rho
  simp [MolecularDynamics.Chapter04Review.symplecticEulerMatrix, Matrix.det_fin_two]
  push_cast
  ring

/-- source_id: MD-4-PRKThreshold · unnumbered_claim · §4 · 印刷p.140 / PDFp.162
[NEEDS_HUMAN] 原文[74]的方法类限制需要审，未访问引用文献。 -/
theorem prkThreshold :
  ∀ s (A B : Matrix (Fin s) (Fin s) ℝ) (b c : Fin s → ℝ)
    (G : ℝ → ℝ → Matrix (Fin 2) (Fin 2) ℝ), 0 < s →
    (∑ i,b i)=1 → (∑ i,c i)=1 →
    (∀ i j, b i*B i j+c j*A j i=b i*c j) →
    (∀ i j, i ≤ j → A i j=0) → (∀ i j, i < j → B i j=0) →
    (∀ Ω h z, ∃ q p, MolecularDynamics.Chapter04Review.prkOscillatorRelation A B b c Ω h z (G Ω h *ᵥ z) q p) →
    (∀ Ω h, MolecularDynamics.Chapter04Review.matrixStable (G Ω h) → |h*Ω| ≤ 2) := by
  sorry

/-- source_id: MD-4-VerletStability · unnumbered_claim · §4 · 印刷p.141 / PDFp.163
[EXTRA] [EXTRA]真正幂有界版本0<|hΩ|<2；原文≤2字面版另列待审。
[ERRATUM?] Verlet的hΩ=2矩阵也有Jordan增长，不能以谱模1推出所有轨道有界。 -/
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

/-- source_id: MD-4-SymplecticEulerBoundaryPrinted · unnumbered_claim · §4 · 印刷p.140 / PDFp.162
[ERRATUM?] 原≤2声明的端点反例；不证明FAIL。 -/
theorem symplecticEulerBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h) := by
  sorry

/-- source_id: MD-4-VerletBoundaryPrinted · unnumbered_claim · §4 · 印刷p.141 / PDFp.163
[ERRATUM?] 原≤2端点不保证幂有界，单列原文不静默替换。 -/
theorem verletBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h) := by
  sorry

/-- source_id: MD-4-OscillatorSpectrum · unnumbered_claim · §4 · 印刷p.140 / PDFp.162 -/
theorem oscillatorSpectrum :
    ∀ Ω : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (MolecularDynamics.Chapter04Review.oscillatorMatrix Ω).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ζ=Complex.I*Ω ∨ ζ= -Complex.I*Ω := by
  intro Ω ζ
  let A : Matrix (Fin 2) (Fin 2) ℂ := (MolecularDynamics.Chapter04Review.oscillatorMatrix Ω).map Complex.ofReal
  have heig : (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=0 := by
    rw [← Matrix.exists_mulVec_eq_zero_iff]
    simp only [Matrix.sub_mulVec, Matrix.smul_mulVec, Matrix.one_mulVec, sub_eq_zero]
    constructor
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
  have hd : (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=ζ^2+(Ω : ℂ)^2 := by
    simp [A, MolecularDynamics.Chapter04Review.oscillatorMatrix, Matrix.det_fin_two]
    push_cast
    ring
  change (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ _
  rw [heig,hd]
  have hf : ζ^2+(Ω : ℂ)^2=(ζ-Complex.I*Ω)*(ζ+Complex.I*Ω) := by
    ring_nf
    rw [Complex.I_sq]
    ring
  rw [hf,mul_eq_zero,sub_eq_zero,add_eq_zero_iff_eq_neg]
  simp only [neg_mul]

/-- source_id: MD-4-SymplecticEulerRoots · unnumbered_claim · §4 · 印刷p.140 / PDFp.162
[EXTRA] 以任意复平方根d²=判别式表达±，避免未指定复sqrt分支；不是仅特征多项式断言。 -/
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

/-- source_id: MD-4-SymplecticEulerUnitRoots · unnumbered_claim · §4 · 印刷p.140 / PDFp.162 -/
theorem symplecticEulerUnitRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ, h^2*Ω^2 ≤ 4 →
      ζ^2-(2-h^2*Ω^2 : ℝ)*ζ+1=0 → ‖ζ‖=1 := by
  intro Ω h ζ ht he
  have hr := congrArg Complex.re he
  have hi := congrArg Complex.im he
  simp [pow_two, Complex.mul_re, Complex.mul_im] at hr hi
  have hz : (2*ζ.re-(2-h^2*Ω^2))*ζ.im=0 := by nlinarith [hi]
  have hn : ζ.re^2+ζ.im^2=1 := by
    rcases mul_eq_zero.mp hz with hz|hz
    · nlinarith [hr]
    · by_cases hpos : 0 ≤ ζ.re
      · have hab : 0 ≤ h^2*Ω^2*ζ.re := mul_nonneg (mul_nonneg (sq_nonneg h) (sq_nonneg Ω)) hpos
        have hs : (ζ.re-1)^2=0 := by nlinarith [hr,sq_nonneg (ζ.re-1)]
        have hzre := sq_eq_zero_iff.mp hs
        nlinarith
      · have hab : 0 ≤ (4-h^2*Ω^2)*(-ζ.re) := mul_nonneg (by linarith) (by linarith)
        have hs : (ζ.re+1)^2=0 := by nlinarith [hr,sq_nonneg (ζ.re+1)]
        have hzre := sq_eq_zero_iff.mp hs
        nlinarith
  have hnorm : ‖ζ‖^2=1 := by
    rw [Complex.sq_norm,Complex.normSq_apply]
    nlinarith [hn]
  nlinarith [norm_nonneg ζ]

/-- source_id: MD-4-SymplecticEulerStability · unnumbered_claim · §4 · 印刷p.140 / PDFp.162
[EXTRA] [EXTRA]正确的幂有界资格改为0<|hΩ|<2；原≤2字面版独立保留，未声称已审核修复。
[ERRATUM?] ≤2端点有单位圆谱但通常Jordan线性增长；幂有界不能包含端点。 -/
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

/-- source_id: MD-4.1-PrintedImplicitRelation · definition · §4.1 · 印刷p.142 / PDFp.164
[ERRATUM?] p142名为Implicit Midpoint却写Trapezoidal Rule更新式；p144采用真正机械中点式。 -/
def printedImplicitRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)

/-- source_id: MD-4.1-ActualMidpointRelation · definition · §4.1 · 印刷p.142 / PDFp.164
[EXTRA] [EXTRA]名称通常对应的真正中点关系Z=z+h f((z+Z)/2)供审校上下文；不是原页的印刷公式。 -/
def actualMidpointRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+h • f ((1/2 : ℝ) • (z+znew))

/-- source_id: MD-4.1-ImplicitFactor · definition · §4.1 · 印刷p.142 / PDFp.164 -/
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))

/-- source_id: MD-4.1-ImplicitModulus · unnumbered_claim · §4.1 · 印刷p.142 / PDFp.164
[EXTRA] 只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。 -/
theorem implicitModulus :
  ∀ Ω h : ℝ, ‖MolecularDynamics.Chapter04Review.implicitFactor Ω h‖=1 := by
  intro Ω h
  rw [MolecularDynamics.Chapter04Review.implicitFactor,norm_div]
  have he : (1+Complex.I*((h*Ω/2 : ℝ) : ℂ)) = star (1-Complex.I*((h*Ω/2 : ℝ) : ℂ)) := by simp
  rw [he,norm_star]
  apply div_self
  intro hn
  have hz := norm_eq_zero.mp hn
  have hr := congrArg Complex.re hz
  norm_num at hr

/-- source_id: MD-4.1-PrintedModifiedFrequency · definition · §4.1 · 印刷p.143 / PDFp.165
[EXTRA] h≠0；采用Mathlib Complex.log主支，对原未指定log支单独记录；后条连续实相位为2 atan(hΩ/2)/h。
[NEEDS_HUMAN] 原书未指定复log分支；与连续实相位的桥接须审校。 -/
def printedModifiedFrequency (Ω h : ℝ) : ℂ :=
  (Complex.I*(h : ℂ))⁻¹ * Complex.log (MolecularDynamics.Chapter04Review.implicitFactor Ω h)

/-- source_id: MD-4.1-ModifiedFrequencyLimit · unnumbered_claim · §4.1 · 印刷p.143 / PDFp.165
[EXTRA] [EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。 -/
theorem modifiedFrequencyLimit :
  ∀ Ω : ℝ, Tendsto (MolecularDynamics.Chapter04Review.modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω) := by
  intro Ω
  have hd : HasDerivAt (fun h : ℝ => 2*Real.arctan (h*Ω/2)) Ω 0 := by
    convert (((hasDerivAt_id (0 : ℝ)).mul_const Ω).div_const 2).arctan.const_mul 2 using 1 <;> norm_num <;> ring
  convert hd.tendsto_slope_zero using 1
  funext t
  simp [MolecularDynamics.Chapter04Review.modifiedFrequency,smul_eq_mul,div_eq_mul_inv]
  ring

/-- source_id: MD-4.1-MechanicalMidpoint · definition · §4.1 · 印刷p.144 / PDFp.166 -/
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (h : ℝ) (z mid out : MolecularDynamics.Chapter04Review.Z n) : Prop :=
  mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ mid.2=z.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1 ∧
  out.1=mid.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ out.2=mid.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1

/-- source_id: MD-4.1-MidpointElimination · unnumbered_claim · §4.1 · 印刷p.144 / PDFp.166 -/
theorem midpointElimination :
  ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) h (z mid out : MolecularDynamics.Chapter04Review.Z n),
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out →
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m z.2-(h^2/4) • MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad U mid.1) := by
  intro n m U h z mid out hm
  rcases hm with ⟨hq,hp,houtq,houtp⟩
  calc
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 := hq
    _ = _ := by
      rw [hp]
      funext i
      simp [MolecularDynamics.Chapter04Review.invMass]
      ring

/-- source_id: MD-4.2.1-SplitHamiltonian · definition · §4.2.1 · 印刷p.145 / PDFp.167 -/
def splitHamiltonian {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.dot z.2 (MolecularDynamics.Chapter04Review.invMass m z.2)/2+US z.1+UF z.1

/-- source_id: MD-4.2.1-FastVerlet · definition · §4.2.1 · 印刷p.145 / PDFp.167 -/
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n :=
  Chapter02Review.verlet m (fun q => -MolecularDynamics.Chapter04Review.grad UF q) h

/-- source_id: MD-4.2.1-RESPA · (4.2) · §4.2.1 · 印刷p.145 / PDFp.167
[EXTRA] r为正自然数，实际r次函数迭代；不把形式算子等式当实际ODE流。 -/
def respa {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (r : ℕ) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : MolecularDynamics.Chapter04Review.Z n :=
  MolecularDynamics.Chapter04Review.kick US (h/2) ((MolecularDynamics.Chapter04Review.fastVerlet m UF (h/r))^[r] (MolecularDynamics.Chapter04Review.kick US (h/2) z))

/-- source_id: MD-4.2.1-RESPAStructure · unnumbered_claim · §4.2.1 · 印刷p.145 / PDFp.167
[EXTRA] [EXTRA]本段Reversible名称及p149明确辛性合并成实际保结构声明：正质量、US/UF C²、r>0。 -/
theorem respaStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → 0 < r →
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m US UF r h) ∧ ∀ z, MolecularDynamics.Chapter04Review.respa m US UF r (-h) (MolecularDynamics.Chapter04Review.respa m US UF r h z)=z := by
  sorry

/-- source_id: MD-4.2.1-SlowMatrix · definition · §4.2.1 · 印刷p.146 / PDFp.168 -/
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]

/-- source_id: MD-4.2.1-FastMatrix · definition · §4.2.1 · 印刷p.146 / PDFp.168
[EXTRA] Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。 -/
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]

/-- source_id: MD-4.2.1-ImpulseMatrix · definition · §4.2.1 · 印刷p.146 / PDFp.168 -/
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)

/-- source_id: MD-4.2.1-ImpulseDet · unnumbered_claim · §4.2.1 · 印刷p.146 / PDFp.168
[EXTRA] Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。 -/
theorem impulseDet :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 ∧ (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 ∧ (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=1 := by
  intro Ω h hΩ
  simp only [MolecularDynamics.Chapter04Review.impulseMatrix, Matrix.det_mul]
  have hs : (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hs2 : (MolecularDynamics.Chapter04Review.slowMatrix (h/2)).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hf : (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.fastMatrix, Matrix.det_fin_two]
    field_simp
    nlinarith [Real.sin_sq_add_cos_sq (Ω*h)]
  exact ⟨hs,hf,by rw [hs2,hf]; norm_num⟩

/-- source_id: MD-4.2.1-ImpulseTrace · unnumbered_claim · §4.2.1 · 印刷p.146 / PDFp.168
[EXTRA] Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。 -/
theorem impulseTrace :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace=2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) := by
  intro Ω h hΩ
  simp [MolecularDynamics.Chapter04Review.impulseMatrix, MolecularDynamics.Chapter04Review.slowMatrix,
    MolecularDynamics.Chapter04Review.fastMatrix, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two]
  rw [mul_comm h Ω]
  ring

/-- source_id: MD-4.2.1-ResonancePower · unnumbered_claim · §4.2.1 · 印刷p.146 / PDFp.168
[EXTRA] Ω>0；所有自然数k，不止图中有限迭代。 -/
theorem resonancePower :
  ∀ Ω : ℝ, 0 < Ω → ∀ k : ℕ,
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k=(-1 : ℝ)^k • !![1,0; -(k : ℝ)*(Real.pi/Ω),1] := by
  intro Ω hΩ k
  have hne : Ω ≠ 0 := ne_of_gt hΩ
  have ha : Ω*(Real.pi/Ω)=Real.pi := by field_simp
  have hm : MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω)= -!![1,0; -(Real.pi/Ω),1] := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.impulseMatrix,MolecularDynamics.Chapter04Review.slowMatrix,MolecularDynamics.Chapter04Review.fastMatrix,Matrix.mul_apply,Fin.sum_univ_two,ha] <;> ring
  induction k with
  | zero =>
    ext i j
    fin_cases i <;> fin_cases j <;> norm_num
  | succ k hk =>
    rw [pow_succ,hk,hm,pow_succ]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,Nat.cast_add,Nat.cast_one] <;> ring

/-- source_id: MD-4.2.1-ResonanceTaylor · unnumbered_claim · §4.2.1 · 印刷p.147 / PDFp.169
[EXTRA] [EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。 -/
theorem resonanceTaylor :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2 := by
  sorry

/-- source_id: MD-4.2.1-ResonanceInstability · unnumbered_claim · §4.2.1 · 印刷p.147 / PDFp.169
[EXTRA] Ω>0；存在左邻域，每个h有真实复谱模>1。 -/
theorem resonanceInstability :
  ∀ Ω : ℝ, 0 < Ω → ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.impulseMatrix Ω h) := by
  sorry

/-- source_id: MD-4.2.1-ResonanceEigenPrinted · unnumbered_claim · §4.2.1 · 印刷p.147 / PDFp.169
[ERRATUM?] 根展开首项疑少sqrt(2)因子；待网站/导师裁定。 -/
theorem resonanceEigenPrinted :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), ∃ rho : ℝ,
    (rho • (1 : Matrix (Fin 2) (Fin 2) ℝ)-MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=0 ∧
    |rho+1-Real.sqrt (|(Real.pi/Ω)*(h-Real.pi/Ω)|/2)| ≤ C*|h-Real.pi/Ω| := by
  sorry

/-- source_id: MD-4.2.2-MollifiedAverage · definition · §4.2.2 · 印刷p.149 / PDFp.171
[EXTRA] [EXTRA]原未指定快积分器，以真实fastVerlet离散位置作为θi的具体实例；K+1项有限加权和，不假定权重任意都有效滤波。 -/
def mollifiedAverage {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (K : ℕ) (w : ℕ → ℝ) (δ : ℝ) (q : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (1/(K+1 : ℝ)) • ∑ i ∈ Finset.range (K+1), w i • ((MolecularDynamics.Chapter04Review.fastVerlet m UF δ)^[i] (q,0)).1

/-- source_id: MD-4.2.2-MollifiedPotential · definition · §4.2.2 · 印刷p.149 / PDFp.171 -/
def mollifiedPotential {n : ℕ} (US : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) := US ∘ A

/-- source_id: MD-4.2.1-ResonanceLinearRate · unnumbered_claim · §4.2.1 · 印刷p.147 / PDFp.169
[EXTRA] [EXTRA]选实际Pi最大范数给出精确正线性率；q0≠0，否则此增长结论不成立。 -/
theorem resonanceLinearRate : ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
    atTop (𝓝 (|(Real.pi/Ω)*z 0|)) := by
  intro Ω hΩ z hz
  let c : ℝ := (Real.pi/Ω)*z 0
  let w : ℕ → Fin 2 → ℝ := fun k => ![z 0/(k : ℝ),z 1/(k : ℝ)-c]
  have ht : Tendsto w atTop (𝓝 (![0,-c] : Fin 2 → ℝ)) := by
    apply tendsto_pi_nhds.mpr
    intro i
    fin_cases i
    · simpa [w] using tendsto_const_div_atTop_nhds_zero_nat (z 0 : ℝ)
    · simpa [w] using (tendsto_const_div_atTop_nhds_zero_nat (z 1 : ℝ)).sub_const c
  have hn : ‖(![0,-c] : Fin 2 → ℝ)‖=|c| := by
    apply le_antisymm
    · apply (pi_norm_le_iff_of_nonneg (abs_nonneg c)).mpr
      intro i
      fin_cases i <;> simp
    · simpa using (norm_le_pi_norm (![0,-c] : Fin 2 → ℝ) 1)
  have he : (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
      =ᶠ[atTop] fun k => ‖w k‖ := by
    filter_upwards [eventually_gt_atTop (0 : ℕ)] with k hk
    have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
    have hp := resonancePower Ω hΩ k
    have hv : (!![1,0; -(k : ℝ)*(Real.pi/Ω),1] : Matrix (Fin 2) (Fin 2) ℝ) *ᵥ z
        = (k : ℝ) • w k := by
      ext i
      fin_cases i <;> simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,w,c] <;> field_simp [hk0] <;> ring
    rw [hp,Matrix.smul_mulVec,hv,norm_smul,norm_smul]
    simp [Real.norm_eq_abs,abs_pow,abs_of_nonneg ((Nat.cast_nonneg k : (0 : ℝ) ≤ (k : ℝ))),hk0]
  simpa only [hn,c] using (ht.norm.congr' he.symm)


/-- source_id: MD-4.2.1-ResonanceGrowth · unnumbered_claim · §4.2.1 · 印刷p.147 / PDFp.169
[EXTRA] 原泛称增长补q0≠0；q0=0时纯动量轨道模不增长。 -/
theorem resonanceGrowth :
  ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖) atTop atTop := by
  intro Ω hΩ z hz
  have hc : 0 < |(Real.pi/Ω)*z 0| := abs_pos.mpr (mul_ne_zero (div_ne_zero Real.pi_ne_zero (ne_of_gt hΩ)) hz)
  have hr := resonanceLinearRate Ω hΩ z hz
  have ht := hr.pos_mul_atTop hc (tendsto_natCast_atTop_atTop (R := ℝ))
  apply ht.congr'
  filter_upwards [eventually_gt_atTop (0 : ℕ)] with k hk
  have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  exact div_mul_cancel₀ _ hk0


/-- source_id: MD-4.2.2-MollifiedStructure · unnumbered_claim · §4.2.2 · 印刷p.149 / PDFp.171
[EXTRA] 正质量、US/UF/A C²、r>0；实际Fréchet链式法则及RESPA的Jacobian辛性，不假定保结构结论。 -/
theorem mollifiedStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → ContDiff ℝ 2 A → 0 < r →
    (∀ q v, (fderiv ℝ (MolecularDynamics.Chapter04Review.mollifiedPotential US A) q) v=(fderiv ℝ US (A q)) ((fderiv ℝ A q) v)) ∧
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m (MolecularDynamics.Chapter04Review.mollifiedPotential US A) UF r h) := by
  sorry

end MD.Ch04
