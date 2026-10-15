import MolecularDynamics.Chapter04.Statements
import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv
import Mathlib.Analysis.Matrix.Spectrum
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
[EXTRA] h≠0、Ω≠0、复标量非零初值；只证明此线性振荡例，不声称所有非线性Hamiltonian平衡点都有纯虚谱。 
[EXTRA] 保留已证趋无穷，并补精确指数率r>1和实际实振子Euler轨道的加权范数等式；矩阵完整复谱已由MD-4-OscillatorSpectrum单列承担，原ω=Ω。非零步长/频率为[EXTRA]资格，新结论暂sorry。 -/
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

theorem eulerImaginaryGrowth_rate (h Ω : ℝ) (_hh : h ≠ 0) (_hΩ : Ω ≠ 0) :
    let r := Real.sqrt (1+(h*Ω)^2)
    1 < r ∧ (∀ (z : ℂ) (k : ℕ),
      ‖(MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))^k*z‖=r^k*‖z‖) ∧
    (∀ (v : Fin 2 → ℝ) (k : ℕ),
      let w := (1+h • MolecularDynamics.Chapter04Review.oscillatorMatrix Ω)^k *ᵥ v
      Real.sqrt (Ω^2*(w 0)^2+(w 1)^2)=
        r^k*Real.sqrt (Ω^2*(v 0)^2+(v 1)^2)) := by
  sorry

/-- source_id: MD-4-SymplecticEulerMatrix · definition · §4 · 印刷p.140 / PDFp.162 -/
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]

/-- source_id: MD-4-SymplecticEulerCharacteristic · unnumbered_claim · §4 · 印刷p.140 / PDFp.162
[EXTRA] 以真实复特征多项式等式表达二次根方程；全部复根公式另列，不能将特征多项式等式当实际求根已证。 
[EXTRA] 本条仅为特征多项式辅助计算；原完整两个复根（含零/负判别式及重根）已由MD-4-SymplecticEulerRoots明确承担，跨条目范围写明，保留原文。 -/
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
[ERRATUM?] Verlet的hΩ=2矩阵也有Jordan增长，不能以谱模1推出所有轨道有界。 
[EXTRA] 本条明确是严格稳定内区间的修订版本，另补h=0分支；原印含端点结论保留MD-4-VerletBoundaryPrinted待导师，不宣称与原句等价。 -/
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

theorem verletStability_zero (Ω : ℝ) :
    MolecularDynamics.Chapter04Review.matrixStable
      (MolecularDynamics.Chapter04Review.verletMatrix Ω 0) := by
  sorry

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
[ERRATUM?] ≤2端点有单位圆谱但通常Jordan线性增长；幂有界不能包含端点。 
[EXTRA] 明确为修订稳定内区间结论；补超阈值实谱恰为一内一外非零实根、真实指数增长轨道及正步长稳定集合上确界2/Ω。原端点错误单列保留，未新增证明。 -/
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

theorem symplecticEulerStability_complete (Ω : ℝ) (_hΩ : 0 < Ω) :
    (sSup {h : ℝ | 0 < h ∧ MolecularDynamics.Chapter04Review.matrixStable
      (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)}=2/Ω) ∧
    (∀ h : ℝ, 2 < h*Ω →
      ∃ a b : ℝ, 0 < |a| ∧ |a| < 1 ∧ 1 < |b| ∧
        (∀ ζ : ℂ, (∃ v : Fin 2 → ℂ, v ≠ 0 ∧
          (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal *ᵥ v=ζ • v) ↔
          ζ=(a : ℂ) ∨ ζ=(b : ℂ)) ∧
        ∃ v : Fin 2 → ℝ, v ≠ 0 ∧ ∀ k : ℕ,
          (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)^k *ᵥ v=b^k • v) := by
  sorry

/-- source_id: MD-4.1-PrintedImplicitRelation · definition · §4.1 · 印刷p.142 / PDFp.164
[ERRATUM?] p142名为Implicit Midpoint却写Trapezoidal Rule更新式；p144采用真正机械中点式。 -/
def printedImplicitRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)

/-- source_id: MD-4.1-ActualMidpointRelation · definition · §4.1 · 印刷p.142 / PDFp.164
[EXTRA] [EXTRA]名称通常对应的真正中点关系Z=z+h f((z+Z)/2)供审校上下文；不是原页的印刷公式。 -/
def actualMidpointRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+h • f ((1/2 : ℝ) • (z+znew))

/-- source_id: MD-4.1-ImplicitFactor · definition · §4.1 · 印刷p.142 / PDFp.164 
[EXTRA] 保留因子并补线性场iΩz的印刷隐式更新等价式；分母实部1不需额外非零假设，新定理暂sorry。 -/
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))

theorem implicitFactor_update (Ω h : ℝ) (z out : ℂ) :
    (out=z+(h : ℂ)*(Complex.I*Ω*z+Complex.I*Ω*out)/2) ↔
      out=implicitFactor Ω h*z := by
  sorry

/-- source_id: MD-4.1-ImplicitModulus · unnumbered_claim · §4.1 · 印刷p.142 / PDFp.164
[EXTRA] 只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。 
[EXTRA] 增加任意步长的标量迭代范数保持，准确对应当前线性振子模态；不扩大到任意线性系统。原模长证明保留。 -/
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

theorem implicitModulus_iterates (Ω h : ℝ) (z : ℂ) (k : ℕ) :
    ‖(MolecularDynamics.Chapter04Review.implicitFactor Ω h)^k*z‖=‖z‖ := by
  sorry

/-- source_id: MD-4.1-PrintedModifiedFrequency · definition · §4.1 · 印刷p.143 / PDFp.165
[EXTRA] h≠0；采用Mathlib Complex.log主支，对原未指定log支单独记录；后条连续实相位为2 atan(hΩ/2)/h。
[NEEDS_HUMAN] 原书未指定复log分支；与连续实相位的桥接须审校。 -/
def printedModifiedFrequency (Ω h : ℝ) : ℂ :=
  (Complex.I*(h : ℂ))⁻¹ * Complex.log (MolecularDynamics.Chapter04Review.implicitFactor Ω h)

/-- source_id: MD-4.1-ModifiedFrequencyLimit · unnumbered_claim · §4.1 · 印刷p.143 / PDFp.165
[EXTRA] [EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。 
[EXTRA] 补x=hΩ的频率比零点极限1与正无穷极限0及实际频率桥接，保留旧h→0证明；新结论不作证明。 -/
theorem modifiedFrequencyLimit :
  ∀ Ω : ℝ, Tendsto (MolecularDynamics.Chapter04Review.modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω) := by
  intro Ω
  have hd : HasDerivAt (fun h : ℝ => 2*Real.arctan (h*Ω/2)) Ω 0 := by
    convert (((hasDerivAt_id (0 : ℝ)).mul_const Ω).div_const 2).arctan.const_mul 2 using 1 <;> norm_num <;> ring
  convert hd.tendsto_slope_zero using 1
  funext t
  simp [MolecularDynamics.Chapter04Review.modifiedFrequency,smul_eq_mul,div_eq_mul_inv]
  ring

def midpointFrequencyRatio (x : ℝ) : ℝ := 2*Real.arctan (x/2)/x

theorem modifiedFrequencyRatio_limits :
    Tendsto midpointFrequencyRatio (nhdsWithin 0 ({0}ᶜ)) (𝓝 1) ∧
    Tendsto midpointFrequencyRatio atTop (𝓝 0) ∧
    (∀ Ω h : ℝ, h*Ω ≠ 0 →
      MolecularDynamics.Chapter04Review.modifiedFrequency Ω h/Ω=midpointFrequencyRatio (h*Ω)) := by
  sorry

/-- source_id: MD-4.1-MechanicalMidpoint · definition · §4.1 · 印刷p.144 / PDFp.166 -/
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (h : ℝ) (z mid out : MolecularDynamics.Chapter04Review.Z n) : Prop :=
  mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ mid.2=z.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1 ∧
  out.1=mid.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ out.2=mid.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1

/-- source_id: MD-4.1-MidpointElimination · unnumbered_claim · §4.1 · 印刷p.144 / PDFp.166 
[EXTRA] 保留消元公式及其已有证明，补实际相空间场的隐式Euler半步→显式Euler半步关系等价，不静默缩掉组合结论。 -/
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

theorem midpointEulerHalfSteps (n : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ)
    (z mid out : MolecularDynamics.Chapter04Review.Z n) :
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out ↔
      (let f := fun w : MolecularDynamics.Chapter04Review.Z n ↦
        (MolecularDynamics.Chapter04Review.invMass m w.2,
          -MolecularDynamics.Chapter04Review.grad U w.1)
       mid=z+(h/2) • f mid ∧ out=mid+(h/2) • f mid) := by
  sorry

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

/-- source_id: MD-4.2.1-SlowMatrix · definition · §4.2.1 · 印刷p.146 / PDFp.168 
[EXTRA] 本条明确只承担S_h；同一展示中的F_h由MD-4.2.1-FastMatrix承担，原合引文字保留。 -/
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]

/-- source_id: MD-4.2.1-FastMatrix · definition · §4.2.1 · 印刷p.146 / PDFp.168
[EXTRA] Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。 
[EXTRA] F_h使用原Ω≫1模型的非零频率域，防止除零总化；S_h由SlowMatrix承担，原展示不删。 -/
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]

/-- source_id: MD-4.2.1-ImpulseMatrix · definition · §4.2.1 · 印刷p.146 / PDFp.168 -/
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)

/-- source_id: MD-4.2.1-ImpulseDet · unnumbered_claim · §4.2.1 · 印刷p.146 / PDFp.168
[EXTRA] Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。 
[EXTRA] 保留三项行列式证明；补复特征多项式的完整首一二次分解及两根乘积1，重根以两个因子计重，非任取两个单根。 -/
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

theorem impulseDet_eigenvalueProduct (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ, a*b=1 ∧ ∀ ζ : ℂ,
      (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=
          (ζ-a)*(ζ-b) := by
  sorry

/-- source_id: MD-4.2.1-ImpulseTrace · unnumbered_claim · §4.2.1 · 印刷p.146 / PDFp.168
[EXTRA] Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。 
[EXTRA] 保留trace计算，并用同一个完整二次分解绑定按代数重数的两个根及根和，不重复任取同一简单根。 -/
theorem impulseTrace :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace=2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) := by
  intro Ω h hΩ
  simp [MolecularDynamics.Chapter04Review.impulseMatrix, MolecularDynamics.Chapter04Review.slowMatrix,
    MolecularDynamics.Chapter04Review.fastMatrix, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two]
  rw [mul_comm h Ω]
  ring

theorem impulseTrace_eigenvalueSum (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ,
      a+b=(2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) : ℝ) ∧
      (∀ ζ : ℂ, (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=(ζ-a)*(ζ-b)) := by
  sorry

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
[EXTRA] Ω>0；存在左邻域，每个h有真实复谱模>1。 
[EXTRA] 补共振左邻域完整两实根分解、圆外根及实际指数轨道；δ≤π/Ω明确正步长。旧圆外复根结论保留。 -/
theorem resonanceInstability :
  ∀ Ω : ℝ, 0 < Ω → ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.impulseMatrix Ω h) := by
  sorry

theorem resonanceInstability_realSpectrum (Ω : ℝ) (_hΩ : 0 < Ω) :
    ∃ δ > 0, δ ≤ Real.pi/Ω ∧ ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω),
      ∃ a b : ℝ, 1 < max |a| |b| ∧
        (∀ ζ : ℂ, (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
          (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=
            (ζ-(a:ℂ))*(ζ-(b:ℂ))) ∧
        (∃ v : Fin 2 → ℝ, v ≠ 0 ∧
          ((1 < |a| ∧ ∀ k : ℕ, (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)^k *ᵥ v=a^k • v) ∨
           (1 < |b| ∧ ∀ k : ℕ, (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)^k *ᵥ v=b^k • v))) := by
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
[EXTRA] 原泛称增长补q0≠0；q0=0时纯动量轨道模不增长。 
[EXTRA] 本条明确为发散推论；线性率由MD-4.2.1-ResonanceLinearRate、交替幂公式由MD-4.2.1-ResonancePower承担，原norm振荡疑误在LinearRate待导师，不删句。 -/
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

/-- source_id: MD-4.3-HolonomicRelation · (4.3) · §4.3 · 印刷p.150 / PDFp.172 -/
def holonomicRelation {n l : ℕ} (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) : Prop :=
  ∀ t, g (q t) t=0

/-- source_id: MD-4.3-TimeConstraintDerivative · unnumbered_claim · §4.3 · 印刷p.150 / PDFp.172
[EXTRA] g的实际uncurry可微、真实曲线导数q′=v、在当前时刻邻域g(q(s),s)=0；不把导数等于0作假设。 -/
theorem timeConstraintDerivative :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) t v,
    DifferentiableAt ℝ (Function.uncurry g) (q t,t) → HasDerivAt q v t →
    (∀ᶠ s in 𝓝 t, g (q s) s=0) → (fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)=0 := by
  intro n l g q t v hg hq hz
  have hp : HasDerivAt (fun s : ℝ => (q s,s)) (v,1) t := hq.prodMk (hasDerivAt_id t)
  have hd : HasDerivAt (fun s => g (q s) s)
      ((fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)) t :=
    hg.hasFDerivAt.comp_hasDerivAt (f := fun s : ℝ => (q s,s)) t hp
  have hzero : HasDerivAt (fun s => g (q s) s) (0 : Fin l → ℝ) t :=
    (hasDerivAt_const t (0 : Fin l → ℝ)).congr_of_eventuallyEq hz
  exact hd.unique hzero

/-- source_id: MD-4.3-ConstrainedSolution · (4.4)–(4.9) · §4.3 · 印刷p.152 / PDFp.174 
[EXTRA] 教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。 -/
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hU : Differentiable ℝ U) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, Differentiable ℝ (g j))
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) t ∧
    HasDerivAt p (-MolecularDynamics.Chapter04Review.grad U (q t)-
      (textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g

def constrainedSolution_generalForce {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g

/-- source_id: MD-4.3-ConstraintSet · definition · §4.3 · 印刷p.152 / PDFp.174
[EXTRA] 定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。 
[EXTRA] 零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。 -/
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}

theorem constraintSet_regularLevel (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ⊤ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ⊤ φ A ∧ ContDiffOn ℝ ⊤ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
  sorry

/-- source_id: MD-4.3-CotangentSet · definition · §4.3 · 印刷p.152 / PDFp.174
[EXTRA] 正质量及独立梯度为几何解释资格。 -/
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Z n) :=
  {z | z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0}

/-- source_id: MD-4.3-ConstraintJacobian · definition · §4.3 · 印刷p.152 / PDFp.174 
[EXTRA] 在同一source_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。 -/
noncomputable def constraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i

def combineConstraints {n l : ℕ}
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) :
    MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l :=
  fun q j ↦ g j q

/-- source_id: MD-4.3-JacobianActualDerivative · unnumbered_claim · §4.3 · 印刷p.152 / PDFp.174
[EXTRA] [EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。 
[EXTRA] 保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。 -/
theorem jacobianActualDerivative {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hγ : ∀ j, DifferentiableAt ℝ (γ j) q) :
    textbookConstraintJacobian γ q =
      LinearMap.toMatrix' (fderiv ℝ (fun y j => γ j y) q).toLinearMap := by
  apply MolecularDynamics.textbookConstraintJacobian_eq_actualDerivative <;> assumption

theorem jacobianActualDerivative_curve (n l : ℕ)
    (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (p v : MolecularDynamics.Chapter04Review.Q n) (t : ℝ)
    (_hg : ∀ j, DifferentiableAt ℝ (g j) (q t)) (_hq : HasDerivAt q v t)
    (_hv : v=MolecularDynamics.Chapter04Review.invMass m p)
    (_hc : ∀ᶠ s in 𝓝 t, ∀ j, g j (q s)=0) :
    textbookConstraintJacobian g (q t) *ᵥ v=0 ∧
    textbookConstraintJacobian g (q t) *ᵥ MolecularDynamics.Chapter04Review.invMass m p=0 := by
  sorry

/-- source_id: MD-4.3-ConstraintDegrees · unnumbered_claim · §4.3 · 印刷p.151 / PDFp.173
[EXTRA] [EXTRA]真实约束导数满射、当前点可微；独立正则约束下切空间是ker Dg，维数关系不作假设。 -/
theorem constraintDegrees :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l) (q : MolecularDynamics.Chapter04Review.Q n), DifferentiableAt ℝ g q →
    Function.Surjective (fderiv ℝ g q) →
    Module.finrank ℝ (LinearMap.ker (fderiv ℝ g q).toLinearMap)+l=n := by
  intro n l g q hg hs
  have hh := LinearMap.finrank_range_add_finrank_ker (fderiv ℝ g q).toLinearMap
  rw [LinearMap.range_eq_top.mpr hs] at hh
  simpa [add_comm] using hh

/-- source_id: MD-4.3-FlexiblePendulumHamiltonian · definition · §4.3 · 印刷p.150 / PDFp.172 -/
def flexiblePendulumHamiltonian (m ε r₀ : ℝ) (U : Position 3 → ℝ)
    (z : Position 3 × Position 3) : ℝ :=
  ‖z.2‖^2/(2*m)+U z.1+ε⁻¹*(‖z.1‖-r₀)^2/2

/-- source_id: MD-4.3-RestraintPotential · definition · §4.3 · 印刷p.150 / PDFp.172 -/
def restraintPotential (ε r₀ : ℝ) (q : Position 3) : ℝ :=
  ε⁻¹*(‖q‖-r₀)^2/2

/-- source_id: MD-4.3-RestraintForcePrinted · unnumbered_claim · §4.3 · 印刷p.150 / PDFp.172
[EXTRA] [EXTRA]将prime暂按配置梯度解释；该记号解释待审。
[ERRATUM?] Fε=−∇φε=φ′ε的prime含义/负号待裁定；原文不静默更正。 -/
theorem restraintForcePrinted :
    ∀ ε r₀ : ℝ, ∀ q : Position 3,
      -gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q =
       gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q := by
  sorry

/-- source_id: MD-4.3-ConstrainedPendulum · definition · §4.3 · 印刷p.151 / PDFp.173
[EXTRA] 原所写v′方程按单位质量，λ吸收法向grad(‖q‖²)=2q的因子；真实欧氏曲线和导数。 
[EXTRA] 增加开时间域，保证within导数确为经典运动导数，排除单点域任意导数的伪运动。 -/
def constrainedPendulum (U : Position 3 → ℝ) (r₀ : ℝ)
    (q v : ℝ → Position 3) (lam : ℝ → ℝ) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (v t) I t ∧
    HasDerivWithinAt v (-gradient U (q t)-(lam t) • q t) I t ∧
    ‖q t‖^2-r₀^2=0

/-- source_id: MD-4.3-ConstraintCurvature · definition · §4.3 · 印刷p.153 / PDFp.175 -/
noncomputable def constraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)

/-- source_id: MD-4.3-ReactionMultiplier · definition · §4.3 · 印刷p.153 / PDFp.175 -/
noncomputable def reactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)

/-- source_id: MD-4.3-ReactionBalance · unnumbered_claim · §4.3 · 印刷p.153 / PDFp.175
[EXTRA] 真实Gram det≠0；F=−grad U是Hamiltonian实例，一般位置力定理提供更强桥接。 -/
theorem reactionBalance {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) (hdet : (textbookConstraintGram m γ q).det ≠ 0) :
    textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (F q - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookConstrainedReactionMultiplier m γ F q p)) +
        textbookConstraintCurvature m γ q p = 0 := by
  apply MolecularDynamics.textbookConstrainedReaction_balance <;> assumption

/-- source_id: MD-4.3-GramPositive · unnumbered_claim · §4.3 · 印刷p.153 / PDFp.175
[EXTRA] [EXTRA]原假设的可检验充分条件：质量正且真实约束梯度线性独立；正定作为结论。 
[EXTRA] 仅为正质量/梯度独立推出正定的充分条件辅助；原句可解且唯一的完整乘子结论由MD-4.3-GramInvertible补全，原文不删。 -/
theorem gramPositive {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).PosDef := by
  apply MolecularDynamics.textbookConstraintGram_posDef <;> assumption

/-- source_id: MD-4.3-GramInvertible · unnumbered_claim · §4.3 · 印刷p.153 / PDFp.175
[EXTRA] [EXTRA]质量正及梯度独立推出真实Gram det≠0；不是将该结论作为前提。 
[EXTRA] 保留原可逆性充分条件证明，补det≠0下反力乘子唯一可解及明确逆Gram公式；F和φ是给定线性方程数据，不把所求λ作假设。 -/
theorem gramInvertible {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).det ≠ 0 := by
  apply MolecularDynamics.textbookConstraintGram_det_ne_zero <;> assumption

theorem gramInvertible_multiplier (n l : ℕ) (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q F : MolecularDynamics.Chapter04Review.Q n) (φ : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (textbookConstraintGram m g q).det ≠ 0) :
    (∃! lam : MolecularDynamics.Chapter04Review.Q l,
      textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ lam)+φ=0) ∧
    (∀ lam : MolecularDynamics.Chapter04Review.Q l,
      (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ lam)+φ=0) ↔
      lam=(textbookConstraintGram m g q)⁻¹ *ᵥ
        (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m F+φ)) := by
  sorry

/-- source_id: MD-4.3-CotangentInvariant · unnumbered_claim · §4.3 · 印刷p.153 / PDFp.175
[EXTRA] 给定闭区间实际ODE解、C²约束、正质量及沿解梯度独立；“for all time”仅在实际解定义区间，不声称任意长时域解存在。 -/
theorem cotangentInvariant {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (F : (Fin Nc → ℝ) → Fin Nc → ℝ) (q p : ℝ → Fin Nc → ℝ) (τ : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hind : ∀ t ∈ Icc 0 τ, LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (q t)))
    (hq : ∀ t ∈ Icc 0 τ, HasDerivWithinAt q (textbookInverseMassMatrix m *ᵥ p t) (Icc 0 τ) t)
    (hp : ∀ t ∈ Icc 0 τ, HasDerivWithinAt p
      (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ F (q t) (p t)) (Icc 0 τ) t)
    (hpos₀ : ∀ j, γ j (q 0) = 0)
    (hhidden₀ : ∀ j, (fderiv ℝ (γ j) (q 0)) (textbookInverseMassMatrix m *ᵥ p 0) = 0) :
    ∀ t ∈ Icc 0 τ, ∀ j, γ j (q t) = 0 ∧
      (fderiv ℝ (γ j) (q t)) (textbookInverseMassMatrix m *ᵥ p t) = 0 := by
  apply MolecularDynamics.textbookConstrainedODE_cotangent_invariant_of_mass_and_independence <;> assumption

/-- source_id: MD-4.3-ReducedFieldRegularity · unnumbered_claim · §4.3 · 印刷p.153 / PDFp.175
[EXTRA] [EXTRA]C³约束/C¹位置力、质量正、真实梯度独立给局部C¹场；是隐含正则性的独立补充，不冒充构造流存在。 -/
theorem reducedFieldRegularity
    {Nc Mc : ℕ} (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (z : (Fin Nc → ℝ) × (Fin Nc → ℝ))
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) z.1)) :
    ContDiffAt ℝ 1 (textbookConstrainedPhaseVectorField m γ U) z := by
  apply MolecularDynamics.contDiffAt_textbookConstrainedPhaseVectorField_of_mass_and_independence <;> assumption

/-- source_id: MD-4.3.1-RestrictedForm · definition · §4.3.1 · 印刷p.153 / PDFp.175 -/
def restrictedForm {n : ℕ} (chart : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (z u v : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ chart z) u) ((fderiv ℝ chart z) v)

/-- source_id: MD-4.3.1-VariationalFormula · unnumbered_claim · §4.3.1 · 印刷p.154 / PDFp.176
[EXTRA] 实际Fréchet变分场：U/g C²、乘子ρ(z)可微；切向dg=0由tangentPhase/拉回消去条另保留，不把它漏掉或作无条件全空间结论。 -/
theorem variational :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (rho : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (z v : MolecularDynamics.Chapter04Review.Z n), ContDiff ℝ 2 U → (∀ j, ContDiff ℝ 2 (g j)) →
    DifferentiableAt ℝ rho z →
    (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.Z n =>
      (MolecularDynamics.Chapter04Review.invMass m x.2,-MolecularDynamics.Chapter04Review.grad U x.1-(textbookConstraintJacobian g x.1)ᵀ *ᵥ rho x)) z) v =
      (MolecularDynamics.Chapter04Review.invMass m v.2,-(fderiv ℝ (MolecularDynamics.Chapter04Review.grad U) z.1) v.1-
        ∑ j, (((fderiv ℝ rho z) v) j • MolecularDynamics.Chapter04Review.grad (g j) z.1+
          rho z j • (fderiv ℝ (MolecularDynamics.Chapter04Review.grad (g j)) z.1) v.1)) := by
  sorry

/-- source_id: MD-4.3.1-HessianPullbackCancel · unnumbered_claim · §4.3.1 · 印刷p.155 / PDFp.177
[EXTRA] 完整实际C²势/约束、可微乘子和切向位置图；前文各消去项在已证正式库有限和展开中保留。 -/
theorem hessianPullbackCancel {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (ρ : Fin Mc → E → ℝ) (q : E → Fin Nc → ℝ) (x u v : E)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hq : DifferentiableAt ℝ q x) (hρ : ∀ j, DifferentiableAt ℝ (ρ j) x)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) :
    ∑ i : Fin Nc,
      ((fderiv ℝ q x) u i * (fderiv ℝ
        (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) v i -
        (fderiv ℝ (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) u i * (fderiv ℝ q x) v i) = 0 := by
  apply MolecularDynamics.textbookConstrainedAcceleration_pullback_zero <;> assumption

/-- source_id: MD-4.3.1-ConstrainedFlowPullback · unnumbered_claim · §4.3.1 · 印刷p.156 / PDFp.178
[EXTRA] 给定joint C²的真实流/时间区间、C³约束及C²势、正质量/独立梯度；完整条件见桥接签名，不假设辛性结论。 -/
theorem constrainedFlowPullback {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (Φ : ℝ × E → (Fin Nc → ℝ) × (Fin Nc → ℝ)) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : ∀ t ∈ Icc 0 τ, ∀ y,
      LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (Φ (t, y)).1))
    (hODE : ∀ t ∈ Icc 0 τ, ∀ y, HasDerivAt (fun s => Φ (s, y))
      (textbookConstrainedPhaseVectorField m γ U (Φ (t, y))) t)
    (hpos₀ : ∀ y j, γ j (Φ (0, y)).1 = 0)
    (hhidden₀ : ∀ y j, (fderiv ℝ (γ j) (Φ (0, y)).1)
      (textbookInverseMassMatrix m *ᵥ (Φ (0, y)).2) = 0) (x u v : E) :
    ∀ t ∈ Icc 0 τ,
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) v) =
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) v) := by
  apply MolecularDynamics.textbookConstrainedFlow_pullback_constant_of_mass_and_independence <;> assumption

/-- source_id: MD-4.3.2-PositionEulerPrinted · (4.14)–(4.16) · §4.3.2 · 印刷p.156 / PDFp.178
[ERRATUM?] 印刷Fn负号与后文F=−grad U/+hF用法的约定需裁定。 -/
def positionEulerPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2-h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g

/-- source_id: MD-4.3.2-PositionEulerForceConvention · definition · §4.3.2 · 印刷p.156 / PDFp.178
[EXTRA] [EXTRA]采用F=−grad U的统一力版本，动量+hF；字面−hFn原式仍保留在相邻条。 -/
def positionEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g

/-- source_id: MD-4.3.2-HiddenEulerError · unnumbered_claim · §4.3.2 · 印刷p.156 / PDFp.178
[EXTRA] C²约束与C²实际出点小步分支，out0=z，初位置合法；将approx0定量化为小正h的一致O(h)，不把隐藏误差作前提。 -/
theorem hiddenEulerError :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (out : ℝ → MolecularDynamics.Chapter04Review.Z n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 out → out 0=z →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, MolecularDynamics.Chapter04Review.positionEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (out h) (rho h)) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      ‖textbookConstraintJacobian g (out h).1 *ᵥ MolecularDynamics.Chapter04Review.invMass m (out h).2‖ ≤ C*h := by
  sorry

/-- source_id: MD-4.3.2-ProjectionResidual · (4.17) · §4.3.2 · 印刷p.156 / PDFp.178 -/
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))

/-- source_id: MD-4.3.2-ProjectionJacobian · definition · §4.3.2 · 印刷p.157 / PDFp.179 -/
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ

/-- source_id: MD-4.3.2-NewtonConstraint · (4.18)–(4.19) · §4.3.2 · 印刷p.157 / PDFp.179 -/
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base η)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η

/-- source_id: MD-4.3.2-FrozenNewtonConstraint · definition · §4.3.2 · 印刷p.157 / PDFp.179
[ERRATUM?] R(0)=g′(Qn)M⁻¹Gnᵀ，一般不是GnM⁻¹Gnᵀ；只有Qn=qn或冻结Jacobian到旧位置时相同。 -/
def frozenNewtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η

/-- source_id: MD-4.3.2-NewtonQuadratic · unnumbered_claim · §4.3.2 · 印刷p.157 / PDFp.179
[EXTRA] 局部C²约束、真实残差root=0及真实R(root) det≠0；结论给存在邻域/二次界，不假设Newton误差结论。 -/
theorem newtonQuadratic :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base root).det ≠ 0 → ∃ C > 0, ∃ δ > 0,
    ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ → ‖MolecularDynamics.Chapter04Review.newtonConstraint m g q base η-root‖ ≤ C*‖η-root‖^2 := by
  sorry

/-- source_id: MD-4.3.2-FrozenNewtonLinear · unnumbered_claim · §4.3.2 · 印刷p.157 / PDFp.179
[EXTRA] [EXTRA]真实冻结映射在root的导数范数<1量化small-step收缩资格；det R0≠0、真实root和C²约束，不无条件声称冻结必收敛。 -/
theorem frozenNewtonLinear :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0).det ≠ 0 →
    ‖fderiv ℝ (MolecularDynamics.Chapter04Review.frozenNewtonConstraint m g q base) root‖ < 1 →
    ∃ C ∈ Ioo (0 : ℝ) 1, ∃ δ > 0, ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ →
      ‖MolecularDynamics.Chapter04Review.frozenNewtonConstraint m g q base η-root‖ ≤ C*‖η-root‖ := by
  sorry

/-- source_id: MD-4.3.2-ProjectionScale · unnumbered_claim · §4.3.2 · 印刷p.158 / PDFp.180
[EXTRA] 给定真实C²选根分支η0=0、正则Gram及初始余切资格；非线性根存在是独立缺项，不把O(h²)结论作假设。 -/
theorem projectionScale :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (η : ℝ → MolecularDynamics.Chapter04Review.Q l), z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 η → η 0=0 →
    (textbookConstraintGram m g z.1).det ≠ 0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectionResidual m g z.1 (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2+h^2 • MolecularDynamics.Chapter04Review.invMass m (F z.1)) (η h)=0) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ‖η h‖ ≤ C*h^2 := by
  sorry

/-- source_id: MD-4.3.2-FrozenGramPrinted · unnumbered_claim · §4.3.2 · 印刷p.157 / PDFp.179
[ERRATUM?] R(0)仍是新预测点与旧点的交叉Gram，原等式一般不成立。 -/
theorem frozenGramPrinted :
    ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n),
      MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0 = textbookConstraintGram m g q := by
  sorry

/-- source_id: MD-4.3.3-ComponentPrinted · definition · §4.3.3 · 印刷p.158 / PDFp.180
[EXTRA] [EXTRA]Gsup1是未定义印刷G_j^1的显式参数，未假设它等于已定义梯度。
[ERRATUM?] 一般分量式分母G_j^1疑为G_n^j的索引误写；原文不静默改。 -/
def componentPrinted {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)

/-- source_id: MD-4.3.3-ComponentConstraintStep · definition · §4.3.3 · 印刷p.158 / PDFp.180
[EXTRA] [EXTRA]一般j采用已定义Gn^j=grad gj(qn)，取非零分母才是可用步骤；原一般式索引疑误由ComponentPrinted保留。 -/
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (j : Fin l) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)

/-- source_id: MD-4.3.3-ComponentSweep · definition · §4.3.3 · 印刷p.158 / PDFp.180
[EXTRA] [EXTRA]一次完整顺序sweep，使用上一条统一Gn索引；多轮为其真实函数迭代。 -/
def componentSweep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (List.finRange l).foldl (fun Qcur j => MolecularDynamics.Chapter04Review.componentConstraintStep m g q Qcur j) Qnow

/-- source_id: MD-4.3.4-ProjectedEulerPrinted · definition · §4.3.4 · 印刷p.159 / PDFp.181
[ERRATUM?] p159(4.21)力符号与p163及F=−∇U定义不一致。 -/
def projectedEulerPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • (-F z.1)-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g

/-- source_id: MD-4.3.4-ProjectedEulerRelation · definition · §4.3.4 · 印刷p.159 / PDFp.181
[EXTRA] [EXTRA]实际力F=−∇U采用+hF版本，与p163一致；不是(4.21)逐字公式。 -/
def projectedEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g

/-- source_id: MD-4.3.4-Lemma41 · Lemma 4.1 · §4.3.4 · 印刷p.159–160 / PDFp.181–182
[EXTRA] 真实局部参数图、q/p/μ可微，约束在x邻域成立；完整拉回2形式对任意u,v相等。
[ERRATUM?] p160证明两处内和印刷dq_j；实际Hessian链式公式应dq_i。原proof_latex保持字面，正式库用真实Hessian对称性证明结论。 -/
theorem lemma41 {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x)
    (hchart : ∀ᶠ y in 𝓝 x, γ (q y) = 0 ∧
      p y ⬝ᵥ textbookConstraintGradient γ (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.lemma_4_1 <;> assumption

/-- source_id: MD-4.3.4-MultiMomentumPullback · unnumbered_claim · §4.3.4 · 印刷p.160 / PDFp.182
[EXTRA] 有限约束族、真实C²约束与可微乘子/参数图；只给定光滑分支，不声称构造解存在。 -/
theorem multiMomentumPullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (μ : ι → E → ℝ)
    (q : E → Fin Nc → ℝ) (x : E) (hq : DifferentiableAt ℝ q x)
    (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hconstraint : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (p : E → Fin Nc → ℝ) (hp : DifferentiableAt ℝ p x) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookMultiConstrainedMomentum_preserves_pullback <;> assumption

/-- source_id: MD-4.3.4-ProjectedEulerPullback · unnumbered_claim · §4.3.4 · 印刷p.160 / PDFp.182
[EXTRA] 真实势力、C²势与约束、可微乘子/参数图，前后位置约束；力kick系数a任意实数覆盖符号两版；不是求解分支存在证明。 -/
theorem projectedEulerPullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam μ : ι → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j ∈ s, DifferentiableAt ℝ (lam j) x)
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hold : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q (textbookProjectedEulerPreMomentum s γ lam U h a q p) y) = 0)
    (u v : E) :
    textbookSymplecticForm Nc (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x u)
      (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
        (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookProjectedEulerChart_preserves_pullback <;> assumption

/-- source_id: MD-4.3.4-CotangentMultiplier · definition · §4.3.4 · 印刷p.159 / PDFp.181
[EXTRA] [EXTRA]将(4.23–24)在Gram非奇异资格下解出实际μ=(GM⁻¹Gᵀ)⁻¹GM⁻¹p；正文未另印此显式式。 -/
noncomputable def cotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))

/-- source_id: MD-4.3.4-CotangentProjection · definition · §4.3.4 · 印刷p.159 / PDFp.181
[EXTRA] [EXTRA]采用实际Gram逆乘子；非奇异Gram是方法资格，另条证明隐藏约束。 -/
noncomputable def cotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p

/-- source_id: MD-4.3.4-CotangentHidden · unnumbered_claim · §4.3.4 · 印刷p.159 / PDFp.181
[EXTRA] [EXTRA]对实际逆Gram构造证明结论，正质量与约束梯度线性独立；不把隐藏约束作假设。 -/
theorem cotangentHidden {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    textbookConstraintJacobian γ q *ᵥ
      (textbookInverseMassMatrix m *ᵥ textbookCotangentProjection m γ q p) = 0 := by
  apply MolecularDynamics.textbookCotangentProjection_hiddenConstraint_of_mass_and_independence <;> assumption

/-- source_id: MD-4.3.4-CotangentRegularity · unnumbered_claim · §4.3.4 · 印刷p.160 / PDFp.182
[EXTRA] [EXTRA]实际逆Gram投影的一阶正则性资格：C²约束、C¹参数图、Gram非奇异；非另印定理。 -/
theorem cotangentRegularity {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => textbookCotangentProjection m γ (q y) (p y)) x := by
  apply MolecularDynamics.contDiffAt_textbookCotangentProjection <;> assumption

/-- source_id: MD-4.3.4-CotangentPullback · unnumbered_claim · §4.3.4 · 印刷p.160 / PDFp.182
[EXTRA] 实际逆Gram投影、C²约束、C¹参数图、Gram非奇异及邻域位置约束；可微乘子由正式库导出，不作新假设。 -/
theorem cotangentPullback {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x u)
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookCotangentProjection_preserves_pullback <;> assumption

/-- source_id: MD-4.3.4-GramProjectedEuler · unnumbered_claim · §4.3.4 · 印刷p.160 / PDFp.182
[EXTRA] [EXTRA]将(4.20–24)实际Gram末投影同时证明隐藏约束与完整拉回形式不变；给定C¹位置投影分支，非解的存在理论。 -/
theorem gramProjectedEuler {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback <;> assumption

/-- source_id: MD-4.3.5-SHAKEPositionPrinted · definition · §4.3.5 · 印刷p.161 / PDFp.183
[ERRATUM?] (4.25)约束反力未带M⁻¹；一般非标量对角质量不能任意吸收入λ。 -/
def shakePositionPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b)-h^2 • ((textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g

/-- source_id: MD-4.3.5-SHAKEPositionMass · definition · §4.3.5 · 印刷p.161 / PDFp.183
[EXTRA] [EXTRA]质量一致位置式h²M⁻¹(F−Gᵀλ)，非原印刷(4.25)。 -/
def shakePositionRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b-(textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g

/-- source_id: MD-4.3.5-SHAKEPhase · definition · §4.3.5 · 印刷p.161 / PDFp.183 -/
def shakeRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho rhonew : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • (F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ rhonew)

/-- source_id: MD-4.3.5-RATTLE · definition · §4.3.5 · 印刷p.161 / PDFp.183 -/
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g

/-- source_id: MD-4.3.5-ConstrainedOrders · unnumbered_claim · §4.3.5 · 印刷p.161–162 / PDFp.183–184
[EXTRA] 正质量、C⁴数据、独立约束与真实光滑隐式解分支及紧区间；明确局部截断误差Euler O(h²)、RATTLE O(h³)。 -/
theorem constrainedOrders :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E R : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3 := by
  sorry

/-- source_id: MD-4.3.5-RATTLESymplectic · unnumbered_claim · §4.3.5 · 印刷p.162 / PDFp.184
[EXTRA] 实际C¹分支、C²势与约束；完整真实拉回两形式，非把辛性作假设。 -/
theorem rattleSymplectic :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (G : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 U → Differentiable ℝ G →
    Differentiable ℝ half → Differentiable ℝ rho → Differentiable ℝ μ →
    (∀ z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g, MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (G z) (half z) (rho z) (μ z)) →
    MolecularDynamics.Chapter04Review.restrictedSymplectic m g G := by
  sorry

/-- source_id: MD-4.3.5-StaggeredConstraint · definition · §4.3.5 · 印刷p.162 / PDFp.184
[ERRATUM?] p162的平均乘子需与p161(4.33)无h/2缩放一致；未将未经核定平均关系计为证明。 -/
def staggeredConstraintRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • MolecularDynamics.Chapter04Review.invMass m newHalf ∧ qnew ∈ MolecularDynamics.Chapter04Review.constraintSet g

/-- source_id: MD-4.3.5-SHAKERATTLEEquivalence · unnumbered_claim · §4.3.5 · 印刷p.162 / PDFp.184
[EXTRA] 真实两套关系、相容初始半动量、正质量和同一局部唯一投影分支；不假设位置序列相同。
[EXTRA] [EXTRA]位置约束上梯度线性独立，保证显式逆Gram投影有定义；旧命题此资格缺失，不静默忽略。
[ERRATUM?] 展示初始p−1/2从(4.29)消元的反力符号需核；原句保持。 -/
theorem shakeRattlePositions :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      LinearIndependent ℝ (fun j => textbookConstraintGradient (g j) q)) →
    (∀ q base : MolecularDynamics.Chapter04Review.Q n, ∀ eta nu : MolecularDynamics.Chapter04Review.Q l, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      MolecularDynamics.Chapter04Review.projectionResidual m g q base eta=0 → MolecularDynamics.Chapter04Review.projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhoS rhoR muR : ℕ → MolecularDynamics.Chapter04Review.Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, MolecularDynamics.Chapter04Review.rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1)) := by
  sorry

/-- source_id: MD-4.3.5-SHAKEElimination · unnumbered_claim · §4.3.5 · 印刷p.161 / PDFp.183
[EXTRA] [EXTRA]实际相空间SHAKE消元给质量一致M⁻¹(F−Gᵀλ)；原(4.25)缺M⁻¹的字面版单列待审；只转录正文结论，不进入习题。 -/
theorem shakeElimination :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (q p half : ℕ → MolecularDynamics.Chapter04Review.Q n) (rho : ℕ → MolecularDynamics.Chapter04Review.Q l),
    (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, MolecularDynamics.Chapter04Review.shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1)) := by
  intro n l m F g h q p half rho hs k
  have h0 := hs k
  have h1 := hs (k+1)
  rcases h0 with ⟨hh0,hq0,hg0,hp0⟩
  rcases h1 with ⟨hh1,hq1,hg1,hp1⟩
  constructor
  · ext i
    have e0 := congrFun hq0 i
    have e1 := congrFun hq1 i
    have e2 := congrFun hp0 i
    have e3 := congrFun hh1 i
    simp [MolecularDynamics.Chapter04Review.invMass,Pi.smul_apply,smul_eq_mul] at e0 e1 e2 e3 ⊢
    linear_combination e1-e0+h*(m i)⁻¹*(e3+e2)
  · simpa [Nat.add_assoc] using hg1

/-- source_id: MD-4.3.5-SHAKEPositionOrder · unnumbered_claim · §4.3.5 · 印刷p.161 / PDFp.183
[EXTRA] [EXTRA]正质量、C⁴势/约束/实际轨道、沿解非奇异Gram、相容两步初值；精确给真实有限区间位置误差O(h²)及分支存在，不把误差界作假设。 -/
theorem shakePositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    MolecularDynamics.Chapter04Review.constrainedSolution m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhon : ℕ → MolecularDynamics.Chapter04Review.Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → MolecularDynamics.Chapter04Review.shakePositionRelation m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2 := by
  sorry

/-- source_id: MD-4.3.5.1-AdjointEuler · definition · §4.3.5.1 · 印刷p.163 / PDFp.185 -/
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g

/-- source_id: MD-4.3.5.1-ConstrainedComposition · unnumbered_claim · §4.3.5.1 · 印刷p.163 / PDFp.185
[EXTRA] 给定真实C¹半步分支、C²势与约束，前后位置约束；本条完整拉回形式结论，二阶精度另条。 -/
theorem constrainedComposition :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoA μA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 3 (g j)) → ContDiff ℝ 3 U → (∀ i, 0 < m i) →
    (∀ h, Differentiable ℝ (E h) ∧ Differentiable ℝ (A h) ∧
      Differentiable ℝ (pE h) ∧ Differentiable ℝ (pA h) ∧ Differentiable ℝ (rhoE h) ∧
      Differentiable ℝ (μE h) ∧ Differentiable ℝ (rhoA h) ∧ Differentiable ℝ (μA h)) →
    (∀ h z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (μA h z)) →
    ∀ h, MolecularDynamics.Chapter04Review.restrictedSymplectic m g (A (h/2) ∘ E (h/2)) := by
  sorry

/-- source_id: MD-4.3.5.1-ConstrainedCompositionOrder · unnumbered_claim · §4.3.5.1 · 印刷p.163 / PDFp.185
[EXTRA] 真实光滑隐式分支、正质量、C⁴势/约束和一致时间区间；实际局部O(h³)精度。 -/
theorem constrainedCompositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE muE rhoA muA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 3 (Function.uncurry E) → ContDiff ℝ 3 (Function.uncurry A) →
    (∀ z, E 0 z=z ∧ A 0 z=z ∧ muE 0 z=0) →
    (∀ h z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (muE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (muA h z)) →
    ∀ z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g, (textbookConstraintGram m g z.1).det ≠ 0 →
    ∀ Φ : ℝ → MolecularDynamics.Chapter04Review.Z n, ContDiff ℝ 3 Φ → Φ 0=z →
      (∃ d > 0, ∀ t ∈ Ioo (-d) d, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t) →
      ∃ C > 0, ∃ d > 0, ∀ h ∈ Ioo 0 d, ‖A (h/2) (E (h/2) z)-Φ h‖ ≤ C*h^3 := by
  sorry

/-- source_id: MD-4.3.5.1-MomentumProjector · definition · §4.3.5.1 · 印刷p.163 / PDFp.185 -/
def momentumProjector {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q : MolecularDynamics.Chapter04Review.Q n) :=
  (1 : Matrix (Fin n) (Fin n) ℝ)-(textbookConstraintJacobian g q)ᵀ *
    (textbookConstraintGram m g q)⁻¹ * textbookConstraintJacobian g q * textbookInverseMassMatrix m

/-- source_id: MD-4.3.5.1-ConstrainedPotentialFlow · unnumbered_claim · §4.3.5.1 · 印刷p.163 / PDFp.185
[EXTRA] [EXTRA]签名采用真实Gram行列式非零、可微约束及初始余切约束；正质量和独立约束是通常物理资格的充分条件。只证势能子流的固定位置与投影动量ODE。 -/
theorem constrainedPotentialFlow :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (z : MolecularDynamics.Chapter04Review.Z n),
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    (∀ j, Differentiable ℝ (g j)) → ∀ t : ℝ,
    let P := fun s : ℝ => z.2-s • (MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1)
    (z.1,P t) ∈ MolecularDynamics.Chapter04Review.cotangentSet m g ∧ HasDerivAt P (-MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1) t := by
  intro n l m U g z hz hdet hg t
  rcases hz with ⟨hq,hp⟩
  let u := MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1
  have hi : ∀ v : Fin n → ℝ, MolecularDynamics.Chapter04Review.invMass m v=textbookInverseMassMatrix m *ᵥ v := by
    intro v
    ext i
    simp [MolecularDynamics.Chapter04Review.invMass,textbookInverseMassMatrix,Matrix.mulVec_diagonal]
  have hproj : ∀ v : Fin n → ℝ, MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ v=textbookCotangentProjection m g z.1 v := by
    intro v
    simp only [MolecularDynamics.Chapter04Review.momentumProjector,Matrix.sub_mulVec,Matrix.one_mulVec,
      textbookCotangentProjection,textbookCotangentMultiplier,Matrix.mulVec_mulVec,Matrix.mul_assoc]
  have hu : textbookConstraintJacobian g z.1 *ᵥ (textbookInverseMassMatrix m *ᵥ u)=0 := by
    dsimp [u]
    rw [hproj]
    exact textbookCotangentProjection_hiddenConstraint m g z.1 _ hdet
  rw [hi] at hp
  constructor
  · change z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
      textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m (z.2-t • u)=0
    refine ⟨hq,?_⟩
    rw [hi,Matrix.mulVec_sub,Matrix.mulVec_smul,Matrix.mulVec_sub,Matrix.mulVec_smul,hp,hu]
    simp
  · simpa [u,Matrix.neg_mulVec] using (((hasDerivAt_id t).smul_const u).const_sub z.2)

/-- source_id: MD-4.3.5.1-GeodesicRelation · definition · §4.3.5.1 · 印刷p.164 / PDFp.186 -/
def geodesicRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) : Prop :=
  MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ => 0) g q p rho I

/-- source_id: MD-4.3.6-MShakeIteration · definition · §4.3.6 · 印刷p.164 / PDFp.186 -/
def mShakeIteration {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (k : ℕ) := (MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[k] 0

/-- source_id: MD-4.3.6-SETTLE · definition · §4.3.6 · 印刷p.165 / PDFp.187
[EXTRA] [EXTRA]正文没有闭式算法细节，仅登记真实小系统residual=0关系；不发明SETTLE闭式或存在定理。 -/
def settleRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Prop := MolecularDynamics.Chapter04Review.projectionResidual m g q base η=0

/-- source_id: MD-4.3.6-LINCSInverse · definition · §4.3.6 · 印刷p.165 / PDFp.187
[EXTRA] [EXTRA]标准Neumann有限和Σ(j=0..k) C^j表达series inverse，正文没有印系数公式；收敛条件另条。 -/
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j

/-- source_id: MD-4.3.6-LINCSConvergence · unnumbered_claim · §4.3.6 · 印刷p.165 / PDFp.187
[EXTRA] [EXTRA]明确实际连续线性算子C.toLin'.toContinuousLinearMap的范数<1；不使用逐元素最大范数作为Neumann收敛资格。 -/
theorem lincsConvergence :
  ∀ l (C : Matrix (Fin l) (Fin l) ℝ),
  ‖C.toLin'.toContinuousLinearMap‖ < 1 → Tendsto (MolecularDynamics.Chapter04Review.lincsInverse C) atTop (𝓝 ((1-C)⁻¹)) := by
  sorry

/-- source_id: MD-4.4-WaterPairPotential · definition · §4.4 · 印刷p.167 / PDFp.189
[EXTRA] 有限电荷位点、所有距离>0与k1,k2,k3>0是物理定义域；不将经验模型当普遍物理定律。 -/
def waterPairPotential {a b : ℕ} (k1 k2 k3 rOO : ℝ) (qa : Fin a → ℝ)
    (qb : Fin b → ℝ) (r : Fin a → Fin b → ℝ) : ℝ :=
  (∑ i, ∑ j, k1*qa i*qb j/r i j)+k2/rOO^12-k3/rOO^6

/-- source_id: MD-4.4-TotalMass · definition · §4.4 · 印刷p.167 / PDFp.189 -/
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i

/-- source_id: MD-4.4-CenterMass · definition · §4.4 · 印刷p.167 / PDFp.189 -/
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  (MolecularDynamics.Chapter04Review.totalMass m)⁻¹ • ∑ i, m i • q i

/-- source_id: MD-4.4-RelativePositions · definition · §4.4 · 印刷p.167 / PDFp.189 -/
def relativePositions {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : Fin N → MolecularDynamics.Chapter04Review.V :=
  fun i => q i-MolecularDynamics.Chapter04Review.centerMass m q

/-- source_id: MD-4.4-RelativeWeightedZero · unnumbered_claim · §4.4 · 印刷p.167 / PDFp.189
[EXTRA] 总质量非零；原物理正质量给此资格，空体系排除。 -/
theorem relativeWeightedZero : ∀ N (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V),
    MolecularDynamics.Chapter04Review.totalMass m ≠ 0 → (∑ i, m i • MolecularDynamics.Chapter04Review.relativePositions m q i)=0 := by
  intro N m q hm
  simp only [MolecularDynamics.Chapter04Review.relativePositions,smul_sub,Finset.sum_sub_distrib,← Finset.sum_smul]
  rw [MolecularDynamics.Chapter04Review.centerMass,smul_smul]
  change (∑ i, m i • q i)-(MolecularDynamics.Chapter04Review.totalMass m * (MolecularDynamics.Chapter04Review.totalMass m)⁻¹) • (∑ i, m i • q i)=0
  rw [mul_inv_cancel₀ hm,one_smul,sub_self]

/-- source_id: MD-4.4-KineticSplit · unnumbered_claim · §4.4 · 印刷p.167 / PDFp.189 -/
theorem kineticSplit :
  ∀ N (m : Fin N → ℝ) (v : MolecularDynamics.Chapter04Review.V) (w : Fin N → MolecularDynamics.Chapter04Review.V),
  (∑ i, m i • w i)=0 →
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i))/2=MolecularDynamics.Chapter04Review.totalMass m*MolecularDynamics.Chapter04Review.dot v v/2+(∑ i,m i*MolecularDynamics.Chapter04Review.dot (w i) (w i))/2 := by
  intro N m v w hz
  have h0 := congrFun hz 0
  have h1 := congrFun hz 1
  have h2 := congrFun hz 2
  simp only [Finset.sum_apply,Pi.smul_apply,smul_eq_mul,Pi.zero_apply] at h0 h1 h2
  have he : ∀ i, MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i)=
      MolecularDynamics.Chapter04Review.dot v v+2*MolecularDynamics.Chapter04Review.dot v (w i)+MolecularDynamics.Chapter04Review.dot (w i) (w i) := by
    intro i
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three]
    ring
  have ht : ∀ a : Fin 3, (∑ i, m i*(v a*w i a))=v a*∑ i,m i*w i a := by
    intro a
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  have hc : ∑ i, m i*MolecularDynamics.Chapter04Review.dot v (w i)=0 := by
    simp only [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,mul_add,Finset.sum_add_distrib]
    rw [ht 0,ht 1,ht 2,h0,h1,h2]
    ring
  simp_rw [he,mul_add,Finset.sum_add_distrib]
  rw [← Finset.sum_mul]
  have hx : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=0 := by
    rw [show (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=2*∑ i,m i*MolecularDynamics.Chapter04Review.dot v (w i) by rw [Finset.mul_sum]; apply Finset.sum_congr rfl; intro i hi; ring,hc,mul_zero]
  rw [hx]
  simp [MolecularDynamics.Chapter04Review.totalMass]
  ring

/-- source_id: MD-4.4-SecondMoment · definition · §4.4 · 印刷p.168 / PDFp.190 -/
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := ∑ i, m i • MolecularDynamics.Chapter04Review.outer (δ i)

/-- source_id: MD-4.4-RotationKinetic · definition · §4.4 · 印刷p.168 / PDFp.190 -/
def rotationKinetic (R dΘ : MolecularDynamics.Chapter04Review.Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2

/-- source_id: MD-4.4-RotationTraceIdentity · unnumbered_claim · §4.4 · 印刷p.168 / PDFp.190 -/
theorem rotationTraceIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (dΘ : MolecularDynamics.Chapter04Review.Mat3),
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (dΘ *ᵥ δ i) (dΘ *ᵥ δ i))/2=
      MolecularDynamics.Chapter04Review.rotationKinetic (MolecularDynamics.Chapter04Review.secondMoment m δ) dΘ := by
  intro N m δ dΘ
  unfold MolecularDynamics.Chapter04Review.rotationKinetic MolecularDynamics.Chapter04Review.secondMoment
  rw [Matrix.mul_sum,Matrix.sum_mul,Matrix.trace_sum]
  rw [Finset.sum_div,Finset.sum_div]
  apply Finset.sum_congr rfl
  intro i hi
  simp [Matrix.trace,Matrix.mul_apply,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
  ring

/-- source_id: MD-4.4-RotationSkew · unnumbered_claim · §4.4 · 印刷p.168–169 / PDFp.190–191
[EXTRA] 真实HasDerivAt矩阵轨道与邻域正交约束；不假设导数乘积恒等式。 -/
theorem rotationSkew :
  ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) t d,
  HasDerivAt Θ d t → (∀ᶠ s in 𝓝 t, Θ s*(Θ s)ᵀ=1) → (d*(Θ t)ᵀ)ᵀ=-(d*(Θ t)ᵀ) := by
  intro Θ t d hd ho
  have hs : ∀ i j : Fin 3, ∑ k, (d i k*Θ t j k+Θ t i k*d j k)=0 := by
    intro i j
    have hf : HasDerivAt (fun s => ∑ k, Θ s i k*Θ s j k)
        (∑ k, (d i k*Θ t j k+Θ t i k*d j k)) t := by
      apply HasDerivAt.fun_sum
      intro k hk
      exact ((hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) k).mul (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd j) k))
    have he : (fun s => ∑ k, Θ s i k*Θ s j k) =ᶠ[𝓝 t] (fun _ => (1 : MolecularDynamics.Chapter04Review.Mat3) i j) := by
      filter_upwards [ho] with s h
      simpa [Matrix.mul_apply,Matrix.transpose_apply] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) h
    exact hf.unique ((hasDerivAt_const t ((1 : MolecularDynamics.Chapter04Review.Mat3) i j)).congr_of_eventuallyEq he)
  ext i j
  have h := hs i j
  simp only [Fin.sum_univ_three] at h
  simp [Matrix.mul_apply,Matrix.transpose_apply,Fin.sum_univ_three]
  nlinarith [h]

/-- source_id: MD-4.4-SkewMatrix · (4.38) · §4.4 · 印刷p.169 / PDFp.191 -/
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]

/-- source_id: MD-4.4-CrossProduct · definition · §4.4 · 印刷p.169 / PDFp.191 -/
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]

/-- source_id: MD-4.4-SkewRepresentation · unnumbered_claim · §4.4 · 印刷p.169 / PDFp.191 -/
theorem skewRepresentation : ∀ A : MolecularDynamics.Chapter04Review.Mat3, Aᵀ = -A → ∃! «ω» : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix «ω»=A := by
  intro A ha
  have hs : ∀ i j : Fin 3, A j i= -A i j := by
    intro i j
    simpa using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) ha
  refine ⟨![A 2 1,A 0 2,A 1 0],?_,?_⟩
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [MolecularDynamics.Chapter04Review.skewMatrix] <;> nlinarith [hs 0 0,hs 0 1,hs 0 2,hs 1 1,hs 1 2,hs 2 2]
  · intro w hw
    ext i
    fin_cases i
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 2 1) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 0 2) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 1 0) hw

/-- source_id: MD-4.4-CrossMatrix · unnumbered_claim · §4.4 · 印刷p.169 / PDFp.191
[EXTRA] [EXTRA]本条仅首等式的子引理；原式两个等式全部保存在CrossIdentityFull，不把子引理当全部结论。 -/
theorem crossMatrix :
  ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix u *ᵥ v=MolecularDynamics.Chapter04Review.cross3 u v := by
  intro u v
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring

/-- source_id: MD-4.4-RigidVelocity · unnumbered_claim · §4.4 · 印刷p.169 / PDFp.191
[EXTRA] 给定真实正交旋转轨道和定义角速度的skew关系；不是把速度公式当假设。 -/
theorem rigidVelocity : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (dΘ : MolecularDynamics.Chapter04Review.Mat3) (δ «ω» : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ dΘ t → Θ t*(Θ t)ᵀ=1 → dΘ*(Θ t)ᵀ=MolecularDynamics.Chapter04Review.skewMatrix «ω» →
    HasDerivAt (fun s => Θ s *ᵥ δ) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ)) t := by
  intro Θ dΘ δ «ω» t hd ho hs
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,dΘ i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  have hv : HasDerivAt (fun s => Θ s *ᵥ δ) (dΘ *ᵥ δ) t := hasDerivAt_pi.mpr he
  have hi : (Θ t)ᵀ*Θ t=1 := mul_eq_one_comm.mp ho
  have hcross : MolecularDynamics.Chapter04Review.skewMatrix «ω» *ᵥ (Θ t *ᵥ δ)=
      MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ) := by
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
  rw [← hcross,← hs,Matrix.mulVec_mulVec,Matrix.mul_assoc,hi,Matrix.mul_one]
  exact hv

/-- source_id: MD-4.4-InertiaTensor · definition · §4.4 · 印刷p.169 / PDFp.191 -/
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 :=
  ∑ i, m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))

/-- source_id: MD-4.4-CrossIdentityFull · unnumbered_claim · §4.4 · 印刷p.169 / PDFp.191 -/
theorem crossIdentityFull : ∀ u v : MolecularDynamics.Chapter04Review.V,
    MolecularDynamics.Chapter04Review.skewMatrix u *ᵥ v=MolecularDynamics.Chapter04Review.cross3 u v ∧
    MolecularDynamics.Chapter04Review.cross3 u v= -(MolecularDynamics.Chapter04Review.skewMatrix v *ᵥ u) := by
  intro u v
  constructor <;> ext i <;> fin_cases i <;>
    simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring

/-- source_id: MD-4.4-RotationalEnergy · definition · §4.4 · 印刷p.169 / PDFp.191 -/
def rotationalEnergy (T : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V) : ℝ := MolecularDynamics.Chapter04Review.dot «ω» (T *ᵥ «ω»)/2

/-- source_id: MD-4.4-InertiaSkewIdentity · unnumbered_claim · §4.4 · 印刷p.169 / PDFp.191 -/
theorem inertiaSkewIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.inertiaTensor m δ= -∑ i, m i • (MolecularDynamics.Chapter04Review.skewMatrix (δ i))^2 := by
  intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v= -(MolecularDynamics.Chapter04Review.skewMatrix v)^2 := by
    intro v
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,MolecularDynamics.Chapter04Review.skewMatrix,Matrix.mul_apply,Fin.sum_univ_three,pow_two] <;> ring
  simp [MolecularDynamics.Chapter04Review.inertiaTensor,he,Finset.sum_neg_distrib]

/-- source_id: MD-4.4-InertiaTracePrinted · unnumbered_claim · §4.4 · 印刷p.169 / PDFp.191
[ERRATUM?] (4.40)末式应trace(T)/2 I−T；原式逐字保留。 -/
theorem inertiaTracePrinted :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=(MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ := by
  sorry

/-- source_id: MD-4.4-InertiaTraceCorrected · unnumbered_claim · §4.4 · 印刷p.169 / PDFp.191
[EXTRA] [EXTRA]纠正(4.40)末式系数为trace(T)/2；不覆盖原印刷条目。 -/
theorem inertiaTraceCorrected :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=((MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace/2) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ := by
  intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      (MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v).trace=2*MolecularDynamics.Chapter04Review.dot v v := by
    intro v
    simp [Matrix.trace,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
    ring
  rw [MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.trace_sum]
  simp_rw [Matrix.trace_smul,he,smul_eq_mul]
  have ht : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot (δ i) (δ i)))/2=
      ∑ i, m i*MolecularDynamics.Chapter04Review.dot (δ i) (δ i) := by
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  rw [ht,MolecularDynamics.Chapter04Review.secondMoment]
  ext i j
  simp only [Matrix.sum_apply,Matrix.smul_apply,Matrix.sub_apply,smul_eq_mul]
  rw [Finset.sum_mul,← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro k hk
  ring

/-- source_id: MD-4.4-DipolarHamiltonian · Example 4.1 · §4.4 · 印刷p.169–170 / PDFp.191–192
[EXTRA] 所有质量/主惯性矩>0，单位偶极方向为物理约束；N有限。 -/
def dipolarHamiltonian {N : ℕ} (mass : Fin N → ℝ) (inertia : MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.V) → ℝ)
    (q p μ π : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  (∑ i, ∑ j, (π i j)^2/(2*inertia j))+(∑ i, MolecularDynamics.Chapter04Review.dot (p i) (p i)/(2*mass i))+U q μ

/-- source_id: MD-4.4-DipolarPairPotential · definition · §4.4 · 印刷p.170 / PDFp.192
[EXTRA] r=Euclidean距离>0；本条实际pair函数，不声称经验模型准确性。 -/
def dipolarPairPotential (lj : ℝ → ℝ) (r : ℝ) (q μ ν : MolecularDynamics.Chapter04Review.V) : ℝ :=
  lj r+MolecularDynamics.Chapter04Review.dot μ (((r^3)⁻¹ • (1 : MolecularDynamics.Chapter04Review.Mat3)-(3/r^5) • MolecularDynamics.Chapter04Review.outer q) *ᵥ ν)

/-- source_id: MD-4.4-DipolarRotationalPrinted · definition · §4.4 · 印刷p.170 / PDFp.192
[ERRATUM?] p170 Ex4.1 trace动能印刷少1/2；R与T关系亦引用疑误式。 -/
def dipolarRotationalPrinted {N : ℕ} (R : MolecularDynamics.Chapter04Review.Mat3) (dΘ : Fin N → MolecularDynamics.Chapter04Review.Mat3) : ℝ :=
  ∑ i, (dΘ i*R*(dΘ i)ᵀ).trace

/-- source_id: MD-4.4-RigidHamiltonian · definition · §4.4 · 印刷p.170 / PDFp.192
[EXTRA] M>0、R非奇异是物理资格；正交约束单列在真实ODE关系中；inverse定义不计存在理论。 -/
def rigidHamiltonian (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q p : MolecularDynamics.Chapter04Review.V) (Θ mom : MolecularDynamics.Chapter04Review.Mat3) : ℝ :=
  MolecularDynamics.Chapter04Review.dot p p/(2*M)+(mom*R⁻¹*momᵀ).trace/2+U q Θ

/-- source_id: MD-4.4-SecondMomentDiagonal · unnumbered_claim · §4.4 · 印刷p.168 / PDFp.190 -/
theorem secondMomentDiagonal : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
    ∃ O : MolecularDynamics.Chapter04Review.Mat3, Oᵀ*O=1 ∧ ∀ i j, i ≠ j →
      (Oᵀ*MolecularDynamics.Chapter04Review.secondMoment m δ*O) i j=0 := by
  intro N m δ
  let R := MolecularDynamics.Chapter04Review.secondMoment m δ
  have hs : R.IsHermitian := by
    change Rᴴ=R
    ext i j
    simp [R,MolecularDynamics.Chapter04Review.secondMoment,MolecularDynamics.Chapter04Review.outer,Matrix.conjTranspose_apply,Matrix.sum_apply,Matrix.smul_apply,mul_comm]
  let O := hs.eigenvectorUnitary
  refine ⟨(O : MolecularDynamics.Chapter04Review.Mat3),?_,?_⟩
  · simpa [Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using Unitary.coe_star_mul_self O
  · have he : (O : MolecularDynamics.Chapter04Review.Mat3)ᵀ*R*(O : MolecularDynamics.Chapter04Review.Mat3)=Matrix.diagonal hs.eigenvalues := by
      simpa [O,Unitary.conjStarAlgAut_star_apply,Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using hs.conjStarAlgAut_star_eigenvectorUnitary
    intro i j hij
    simpa [Matrix.diagonal,hij] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) he

/-- source_id: MD-4.4-RotationBodyEnergy · unnumbered_claim · §4.4 · 印刷p.169 / PDFp.191
[EXTRA] 真实SO3旋转；不把动能等式/叉积协变当假设。 -/
theorem rotationBodyEnergy : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 →
  (∑ i, m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
    MolecularDynamics.Chapter04Review.rotationalEnergy (MolecularDynamics.Chapter04Review.inertiaTensor m δ) (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  let x := Θᵀ *ᵥ «ω»
  have ht : ∀ (A : MolecularDynamics.Chapter04Review.Mat3) (v w : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot (A *ᵥ v) w=MolecularDynamics.Chapter04Review.dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hx : Θ *ᵥ x=«ω» := by
    dsimp [x]
    rw [Matrix.mulVec_mulVec,mul_eq_one_comm.mp ho,Matrix.one_mulVec]
  have hn : MolecularDynamics.Chapter04Review.dot «ω» «ω»=MolecularDynamics.Chapter04Review.dot x x := by
    conv_lhs => rw [← hx]
    rw [ht,hi]
  have hc : ∀ v w : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 w v) (MolecularDynamics.Chapter04Review.cross3 w v)=MolecularDynamics.Chapter04Review.dot v v*MolecularDynamics.Chapter04Review.dot w w-(MolecularDynamics.Chapter04Review.dot v w)^2 := by
    intro v w
    simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three]
    ring
  have he : ∀ v y : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot y ((MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ y)=MolecularDynamics.Chapter04Review.dot v v*MolecularDynamics.Chapter04Review.dot y y-(MolecularDynamics.Chapter04Review.dot v y)^2 := by
    intro v y
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hf : ∀ v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v))=
      MolecularDynamics.Chapter04Review.dot x ((MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ x) := by
    intro v
    rw [hc,he]
    have hv : MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) (Θ *ᵥ v)=MolecularDynamics.Chapter04Review.dot v v := by rw [ht,hi]
    have hw : MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) «ω»=MolecularDynamics.Chapter04Review.dot v x := ht Θ v «ω»
    rw [hv,hn,hw]
  have hsum : ∀ (K : ℕ) (a : Fin K → MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot x (∑ i,a i)=∑ i,MolecularDynamics.Chapter04Review.dot x (a i) := by
    intro K a
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Finset.sum_apply,Finset.mul_sum,Finset.sum_add_distrib]
  have hsmul : ∀ (c : ℝ) (v : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot x (c • v)=c*MolecularDynamics.Chapter04Review.dot x v := by
    intro c v
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  rw [MolecularDynamics.Chapter04Review.rotationalEnergy,MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.sum_mulVec]
  change (∑ i,m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
      MolecularDynamics.Chapter04Review.dot x (∑ i,(m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))) *ᵥ x)/2
  simp_rw [Matrix.smul_mulVec]
  rw [hsum]
  simp_rw [hsmul,hf]

/-- source_id: MD-4.4-DipolarConstraint · definition · §4.4 · 印刷p.170 / PDFp.192 -/
def dipolarConstraint {N : ℕ} (μ : Fin N → MolecularDynamics.Chapter04Review.V) : Prop :=
  ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1

/-- source_id: MD-4.4-DipolarPotentialSum · definition · §4.4 · 印刷p.170 / PDFp.192
[EXTRA] 对无重叠位置，真实Euclidean距离sqrtΣ(qi−qj)²及有限无序pair和；经验势定义，不计模拟正确性。 -/
def dipolarPotentialSum {N : ℕ} (lj : ℝ → ℝ) (q μ : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  ∑ i, ∑ j, if i < j then
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot (q i-q j) (q i-q j))) (q i-q j) (μ i) (μ j) else 0

/-- source_id: MD-4.4-RotationTrajectory · unnumbered_claim · §4.4 · 印刷p.168 / PDFp.190 -/
theorem rotationTrajectory : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → HasDerivAt (fun s => Θ s *ᵥ δ) (d *ᵥ δ) t := by
  intro Θ d δ t hd
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,d i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  exact hasDerivAt_pi.mpr he

/-- source_id: MD-4.4-RotationDerivativePrinted · unnumbered_claim · §4.4 · 印刷p.168 / PDFp.190
[ERRATUM?] p168展示最后应以配置δ_i而非速度dotδ_i代换；已渲染视觉复核。 -/
theorem rotationDerivativePrinted : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → Θ t*(Θ t)ᵀ=1 →
    d *ᵥ δ=(d*(Θ t)ᵀ) *ᵥ (d *ᵥ δ) := by
  sorry

/-- source_id: MD-4.4-RigidMatrixRelation · definition · §4.4 · 印刷p.171 / PDFp.193 -/
def rigidMatrixRelation (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.V) (Θ mom Λ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (M⁻¹ • p t) I t ∧ HasDerivWithinAt Θ (mom t*R⁻¹) I t ∧
    HasDerivWithinAt p (-MolecularDynamics.Chapter04Review.grad (fun x => U x (Θ t)) (q t)) I t ∧
    HasDerivWithinAt mom (-MolecularDynamics.Chapter04Review.matrixGrad (U (q t)) (Θ t)-Θ t*Λ t) I t ∧ (Θ t)ᵀ*Θ t=1

/-- source_id: MD-4.4.1-AngularMomentum · definition · §4.4.1 · 印刷p.171 / PDFp.193 -/
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  ∑ i, m i • MolecularDynamics.Chapter04Review.cross3 (δ i) (v i)

/-- source_id: MD-4.4.1-BodyMomentum · definition · §4.4.1 · 印刷p.171 / PDFp.193 -/
def bodyMomentum (Θ : MolecularDynamics.Chapter04Review.Mat3) (l : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := Θᵀ *ᵥ l

/-- source_id: MD-4.4.1-AngularInertia · unnumbered_claim · §4.4.1 · 印刷p.171 / PDFp.193
[EXTRA] 真实SO(3)矩阵和cross3，嵌套为δ×(ω×δ)；原无括号三重积含糊，明确上下文对象。 -/
theorem angularInertia :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 → MolecularDynamics.Chapter04Review.bodyMomentum Θ
    (MolecularDynamics.Chapter04Review.angularMomentum m (fun i => Θ *ᵥ δ i) (fun i => MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i))) =
      MolecularDynamics.Chapter04Review.inertiaTensor m δ *ᵥ (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  have ht : ∀ (A : MolecularDynamics.Chapter04Review.Mat3) (v w : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot (A *ᵥ v) w=MolecularDynamics.Chapter04Review.dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hn : ∀ v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) (Θ *ᵥ v)=MolecularDynamics.Chapter04Review.dot v v := by
    intro v
    rw [ht,hi]
  have hc : ∀ u w : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.cross3 u (MolecularDynamics.Chapter04Review.cross3 w u)=MolecularDynamics.Chapter04Review.dot u u • w-MolecularDynamics.Chapter04Review.dot u w • u := by
    intro u w
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul] <;> ring
  have he : ∀ v y : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.outer v *ᵥ y=MolecularDynamics.Chapter04Review.dot v y • v := by
    intro v y
    ext i
    simp [MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  have hterm : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ MolecularDynamics.Chapter04Review.cross3 (Θ *ᵥ v) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v))=
      (MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ (Θᵀ *ᵥ «ω») := by
    intro v
    rw [hc,Matrix.mulVec_sub,Matrix.mulVec_smul,Matrix.mulVec_smul,hn,ht,hi,
      Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,he]
  simp only [MolecularDynamics.Chapter04Review.bodyMomentum,MolecularDynamics.Chapter04Review.angularMomentum,
    MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.mulVec_sum,Matrix.mulVec_smul,Matrix.sum_mulVec,Matrix.smul_mulVec]
  apply Finset.sum_congr rfl
  intro i hii
  rw [hterm]

/-- source_id: MD-4.4.1-EulerRigidField · (4.41) · §4.4.1 · 印刷p.172 / PDFp.194 -/
def eulerRigidField (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := MolecularDynamics.Chapter04Review.cross3 π (T⁻¹ *ᵥ π)

/-- source_id: MD-4.4.1-FreeRigidSolution · definition · §4.4.1 · 印刷p.172 / PDFp.194 -/
def freeRigidSolution (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) I t

/-- source_id: MD-4.4.1-RigidInvariants · unnumbered_claim · §4.4.1 · 印刷p.172 / PDFp.194
[EXTRA] 对称正定T、实际连续闭区间轨道，证明原能量H̃=πᵀT⁻¹π/2和角动量平方同时守恒；不假设任一守恒。 -/
theorem rigidInvariants :
  ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) a b,
  T.PosDef → a ≤ b → ContinuousOn π (Icc a b) → MolecularDynamics.Chapter04Review.freeRigidSolution T π (Icc a b) →
    ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) ∧
      MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a) := by
  intro T π a b hT hab hπ hsol
  have hsym : (T⁻¹)ᵀ=T⁻¹ := by
    simpa [Matrix.conjTranspose_eq_transpose_of_trivial] using hT.isHermitian.inv.eq
  have hcomm : ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot u v=MolecularDynamics.Chapter04Review.dot v u := by
    intro u v
    simp [MolecularDynamics.Chapter04Review.dot,mul_comm]
  have htrans : ∀ (B : MolecularDynamics.Chapter04Review.Mat3) (u v : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot u (B *ᵥ v)=MolecularDynamics.Chapter04Review.dot (Bᵀ *ᵥ u) v := by
    intro B u v
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hc : ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 u v) v=0 ∧ MolecularDynamics.Chapter04Review.dot u (MolecularDynamics.Chapter04Review.cross3 u v)=0 := by
    intro u v
    constructor <;> simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three] <;> ring
  have hd : ∀ (B : MolecularDynamics.Chapter04Review.Mat3) t, t ∈ Icc a b →
      HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (B *ᵥ π s))
      (MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (B *ᵥ π t)+MolecularDynamics.Chapter04Review.dot (π t) (B *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t))) (Icc a b) t := by
    intro B t ht
    have hp := hsol t ht
    have hx : ∀ i, HasDerivWithinAt (fun s => (B *ᵥ π s) i) ((B *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) i) (Icc a b) t := by
      intro i
      change HasDerivWithinAt (fun s => ∑ j, B i j*π s j) (∑ j,B i j*MolecularDynamics.Chapter04Review.eulerRigidField T (π t) j) (Icc a b) t
      apply HasDerivWithinAt.fun_sum
      intro j hj
      exact (hasDerivWithinAt_pi.mp hp j).const_mul (B i j)
    have h := HasDerivWithinAt.fun_sum (u := Finset.univ) (fun i _ => (hasDerivWithinAt_pi.mp hp i).mul (hx i))
    simpa [MolecularDynamics.Chapter04Review.dot,Finset.sum_add_distrib] using h
  have he : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (T⁻¹ *ᵥ π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (T⁻¹ *ᵥ π t)+MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t))=0 := by
      rw [htrans T⁻¹ (π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)),hsym,hcomm (T⁻¹ *ᵥ π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t))]
      simp [MolecularDynamics.Chapter04Review.eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).1]
    simpa [hz] using hd T⁻¹ t ht
  have hn : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (π t)+MolecularDynamics.Chapter04Review.dot (π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t))=0 := by
      rw [hcomm (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (π t)]
      simp [MolecularDynamics.Chapter04Review.eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).2]
    simpa [Matrix.one_mulVec,hz] using hd 1 t ht
  have ce : ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (he t ht).continuousWithinAt)
    intro t ht
    exact (he t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  have cn : ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (hn t ht).continuousWithinAt)
    intro t ht
    exact (hn t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  intro t ht
  exact ⟨ce t ht,cn t ht⟩

/-- source_id: MD-4.4.1-RigidPoissonMatrix · definition · §4.4.1 · 印刷p.172 / PDFp.194 -/
def rigidPoissonMatrix (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := MolecularDynamics.Chapter04Review.skewMatrix π

/-- source_id: MD-4.4.1-PoissonDegeneracy · unnumbered_claim · §4.4.1 · 印刷p.172 / PDFp.194 -/
theorem poissonDegeneracy : ∀ π : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ π=0 := by
  intro π
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring

/-- source_id: MD-4.4.1-AxisRotation · definition · §4.4.1 · 印刷p.173–174 / PDFp.195–196 -/
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]

/-- source_id: MD-4.4.1-SecondAxisPrinted · definition · §4.4.1 · 印刷p.173 / PDFp.195
[EXTRA] 为未定义标量引入a供审校，不声称它等于π₂。
[ERRATUM?] p173第二子系统分量少下标2，原文尚需导师裁定。 -/
def secondAxisPrinted (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (a : ℝ) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,a/I 1,0]

/-- source_id: MD-4.4.1-ThirdAxisPrinted · definition · §4.4.1 · 印刷p.173 / PDFp.195
[EXTRA] [EXTRA]a只为缺下标的印刷标量供审校。
[ERRATUM?] p173第三子系统分量少下标3，单列保留原式。 -/
def thirdAxisPrinted (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (a : ℝ) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,0,a/I 2]

/-- source_id: MD-4.4.1-PrincipalAxisField · definition · §4.4.1 · 印刷p.173 / PDFp.195
[EXTRA] [EXTRA]将第二和第三子场的分量分别明确为π₂/π₃；原印刷两处缺下标另列待审，不覆盖原式。 -/
def principalAxisField (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π (Pi.single i (π i/I i))

/-- source_id: MD-4.4.2-PrintedSpinAxis · definition · §4.4.2 · 印刷p.174 / PDFp.196
[ERRATUM?] p174正角列动量Rπ的导数符号与(4.41)π×ω相反；保留原算法，不证明其精确子流。 -/
def printedSpinAxis (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (h : ℝ) (s : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  let R := MolecularDynamics.Chapter04Review.axisRotation i (h*s.1 i/I i)
  (R *ᵥ s.1,s.2*Rᵀ)

/-- source_id: MD-4.4.2-PrintedSpinStep · definition · §4.4.2 · 印刷p.174 / PDFp.196 -/
def printedSpinStep (I : MolecularDynamics.Chapter04Review.V) (h : ℝ) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 → MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  printedSpinAxis I 0 (h/2) ∘ printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 2 h ∘
    printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 0 (h/2)

/-- source_id: MD-4.4.1-AxisFlowFormal · unnumbered_claim · §4.4.1 · 印刷p.173 / PDFp.195
[EXTRA] [EXTRA]旧声明使用与p174一致的正式库spinAxis；作为待审正角精确子流候选，不把它当已证原结论。
[ERRATUM?] 正角主动Rπ导数=ω×π，不是π×ω；精确流需负角列动量。 -/
theorem axisFlow :
  ∀ (I π : MolecularDynamics.Chapter04Review.V) i, 0 < I i → ∀ t : ℝ,
  HasDerivAt (fun s : ℝ => (MolecularDynamics.Chapter04Review.spinAxis I i s (π,1)).1)
    (MolecularDynamics.Chapter04Review.cross3 ((MolecularDynamics.Chapter04Review.spinAxis I i t (π,1)).1) (Pi.single i (((MolecularDynamics.Chapter04Review.spinAxis I i t (π,1)).1 i)/I i))) t := by
  sorry

/-- source_id: MD-4.4.1-SpinPoissonFormal · unnumbered_claim · §4.4.1 · 印刷p.173 / PDFp.195
[EXTRA] [EXTRA]此条仅正式库三维非canonical动量映射D J Dᵀ=J(Gπ)；Θ字面算法的完整几何结构另列。 -/
theorem spinPoisson :
  ∀ I : MolecularDynamics.Chapter04Review.V, (∀ i, 0 < I i) → ∀ h : ℝ,
  poissonMap (fun π => (MolecularDynamics.Chapter04Review.spinStep I h (π,1)).1) := by
  sorry

/-- source_id: MD-4.4.1-RigidPoissonSkew · unnumbered_claim · §4.4.1 · 印刷p.172 / PDFp.194 -/
theorem rigidPoissonSkew : ∀ π : MolecularDynamics.Chapter04Review.V, (MolecularDynamics.Chapter04Review.rigidPoissonMatrix π)ᵀ= -MolecularDynamics.Chapter04Review.rigidPoissonMatrix π := by
  intro π
  ext i j
  fin_cases i <;> fin_cases j <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix]

/-- source_id: MD-4.4.1-RigidHamiltonianField · unnumbered_claim · §4.4.1 · 印刷p.172 / PDFp.194
[EXTRA] 正定T确保对称可逆；真实Fréchet配置梯度，不把∇H=T⁻¹π作假设。 -/
theorem rigidHamiltonianField : ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V), T.PosDef →
  MolecularDynamics.Chapter04Review.eulerRigidField T π=MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ
    MolecularDynamics.Chapter04Review.grad (fun x => MolecularDynamics.Chapter04Review.dot x (T⁻¹ *ᵥ x)/2) π := by
  intro T π hT
  let B := T⁻¹
  have hsym : Bᵀ=B := by
    simpa [B,Matrix.conjTranspose_eq_transpose_of_trivial] using hT.isHermitian.inv.eq
  have hs : ∀ i j : Fin 3, B i j=B j i := by
    intro i j
    simpa using congrArg (fun A : MolecularDynamics.Chapter04Review.Mat3 => A j i) hsym
  let row : Fin 3 → (MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ) := fun i => ∑ j, B i j • (ContinuousLinearMap.proj j : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ)
  let L : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ := (2 : ℝ)⁻¹ • ∑ i, (π i • row i+(B *ᵥ π) i • (ContinuousLinearMap.proj i : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ))
  have hb : ∀ i, HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => (B *ᵥ x) i) (row i) π := by
    intro i
    change HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => ∑ j,B i j*x j) (∑ j,B i j • (ContinuousLinearMap.proj j : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ)) π
    apply HasFDerivAt.fun_sum
    intro j hj
    exact (hasFDerivAt_apply j π).const_mul (B i j)
  have hh : HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => ∑ i,x i*(B *ᵥ x) i)
      (∑ i, (π i • row i+(B *ᵥ π) i • (ContinuousLinearMap.proj i : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ))) π := by
    apply HasFDerivAt.fun_sum
    intro i hii
    exact (hasFDerivAt_apply i π).mul (hb i)
  have hd : HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) L π := by
    convert hh.const_mul ((2 : ℝ)⁻¹) using 1
    funext x
    simp only [MolecularDynamics.Chapter04Review.dot,div_eq_mul_inv]
    ring
  have hg : MolecularDynamics.Chapter04Review.grad (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) π=B *ᵥ π := by
    ext i
    change (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) π) (Pi.single i 1)=(B *ᵥ π) i
    rw [hd.fderiv]
    fin_cases i <;> simp [L,row,ContinuousLinearMap.sum_apply,ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.proj_apply,Fin.sum_univ_three,Pi.single_apply,Matrix.mulVec,dotProduct,hs 1 0,hs 2 0,hs 2 1] <;> ring
  change MolecularDynamics.Chapter04Review.cross3 π (B *ᵥ π)=MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ MolecularDynamics.Chapter04Review.grad (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) π
  rw [hg]
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring

/-- source_id: MD-4.4.2-RigidForce · definition · §4.4.2 · 印刷p.173 / PDFp.195 -/
def rigidForce (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.grad (fun x => U x Θ) q

/-- source_id: MD-4.4.2-MatrixRot · definition · §4.4.2 · 印刷p.174 / PDFp.196 -/
def matrixRot (A : MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]

/-- source_id: MD-4.4.2-RigidTorque · definition · §4.4.2 · 印刷p.173 / PDFp.195 -/
def rigidTorque (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.matrixRot (Θᵀ*MolecularDynamics.Chapter04Review.matrixGrad (U q) Θ)

/-- source_id: MD-4.4.2-DLMPrinted · definition · §4.4.2 · 印刷p.174 / PDFp.196
[EXTRA] [EXTRA]本条仅N=1实例；任意N体耦合势与完整算法另由DLMPrintedSystem忠实保存。
[ERRATUM?] 字面drift缺1/M；正角spin动量符号疑点保留。 -/
def dlmPrinted (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift 1 h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)

/-- source_id: MD-4.4.2-DLMMassOnly · definition · §4.4.2 · 印刷p.174 / PDFp.196
[EXTRA] [EXTRA]只将drift质量修为q+h p/M；仍保留原spin，不能据此称完整正确几何积分器。 -/
def dlmMassOnly (M : ℝ) (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift M h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)

/-- source_id: MD-4.4.2-DriftSpinCommute · unnumbered_claim · §4.4.2 · 印刷p.174 / PDFp.196 -/
theorem driftSpinCommute : ∀ M h (I : MolecularDynamics.Chapter04Review.V) (z : MolecularDynamics.Chapter04Review.RBState),
  MolecularDynamics.Chapter04Review.rigidDrift M h (z.1,printedSpinStep I h z.2)=
    ((MolecularDynamics.Chapter04Review.rigidDrift M h z).1,printedSpinStep I h (MolecularDynamics.Chapter04Review.rigidDrift M h z).2) := by
  intro M h I z
  rfl

/-- source_id: MD-4.4.2-DLMStructureFormal · unnumbered_claim · §4.4.2 · 印刷p.173–174 / PDFp.195–196
[EXTRA] [EXTRA]旧正式库单体质量一致对象单独保留；原任意N体耦合势的算法几何声明另列。 -/
theorem dlmStructure :
  ∀ M (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  0 < M → (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h) ∧ ∀ z : MolecularDynamics.Chapter04Review.RBState,
      z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 →
      MolecularDynamics.Chapter04Review.dlmMassConsistent M I U (-h) (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z)=z ∧
      (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2ᵀ*(MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2=1 := by
  sorry

/-- source_id: MD-4.4.2-DLMPrintedStructure · unnumbered_claim · §4.4.2 · 印刷p.173–174 / PDFp.195–196
[EXTRA] 明确SO3初态与实际切向量在rbSymplectic定义内；单位质量为原字面drift。 -/
theorem dlmPrintedStructure : ∀ (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (dlmPrinted I U h) := by
    sorry

/-- source_id: MD-4.4.2-RigidSystemState · definition · §4.4.2 · 印刷p.173 / PDFp.195
[EXTRA] [EXTRA]完整N体状态的透明类型别名：每体(q,p,π,Θ)；下列势U可耦合全部刚体，不限于单体或独立势。 -/
@[reducible] def rigidSystemState (N : ℕ) := Fin N → MolecularDynamics.Chapter04Review.RBState

/-- source_id: MD-4.4.2-RigidSystemForce · definition · §4.4.2 · 印刷p.173 / PDFp.195 -/
def rigidSystemForce {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.grad (fun x => U (Function.update (fun j => (z j).1.1) k x) (fun j => (z j).2.2)) (z k).1.1

/-- source_id: MD-4.4.2-RigidSystemTorque · definition · §4.4.2 · 印刷p.173 / PDFp.195 -/
def rigidSystemTorque {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.matrixRot ((z k).2.2ᵀ * MolecularDynamics.Chapter04Review.matrixGrad
    (fun A => U (fun j => (z j).1.1) (Function.update (fun j => (z j).2.2) k A)) (z k).2.2)

/-- source_id: MD-4.4.2-RigidSystemKick · definition · §4.4.2 · 印刷p.174 / PDFp.196 -/
def rigidSystemKick {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1,(z k).1.2+h • rigidSystemForce U z k),
    ((z k).2.1+h • rigidSystemTorque U z k,(z k).2.2))

/-- source_id: MD-4.4.2-RigidSystemDriftPrinted · definition · §4.4.2 · 印刷p.174 / PDFp.196
[ERRATUM?] 原字面缺1/Mk；完整N体版本保留原式，不静默补质量。 -/
def rigidSystemDriftPrinted {N : ℕ} (h : ℝ) (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1+h • (z k).1.2,(z k).1.2),(z k).2)

/-- source_id: MD-4.4.2-RigidSystemSpinPrinted · definition · §4.4.2 · 印刷p.174 / PDFp.196
[ERRATUM?] 正角Rπ与π×ω的子流符号疑点保留，不冒充已证精确刚体子流。 -/
def rigidSystemSpinPrinted {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => ((z k).1,printedSpinStep (I k) h (z k).2)

/-- source_id: MD-4.4.2-DLMPrintedSystem · definition · §4.4.2 · 印刷p.174 / PDFp.196
[ERRATUM?] 完整原表的缺质量drift与正角spin疑点保持；编译定义不代表正确辛性。 -/
def dlmPrintedSystem {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)

/-- source_id: MD-4.4.2-SystemDriftSpinCommute · unnumbered_claim · §4.4.2 · 印刷p.174 / PDFp.196 -/
theorem systemDriftSpinCommute : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V) h (z : rigidSystemState N),
    rigidSystemDriftPrinted h (rigidSystemSpinPrinted I h z)=
      rigidSystemSpinPrinted I h (rigidSystemDriftPrinted h z) := by
  intro N I h z
  rfl

/-- source_id: MD-4.4.2-RigidSystemSymplectic · definition · §4.4.2 · 印刷p.173–174 / PDFp.195–196
[EXTRA] [EXTRA]完整N体SO(3)配置、实际切向量和各体rbForm之和；明确包含输出配置约束及真实Fréchet拉回，不假设辛性或以抽象形式替代。 -/
def rigidSystemSymplectic {N : ℕ} (G : rigidSystemState N → rigidSystemState N) : Prop :=
  ∀ (z : rigidSystemState N), (∀ k, (z k).2.2ᵀ*(z k).2.2=1 ∧ (z k).2.2.det=1) →
    (∀ k, (G z k).2.2ᵀ*(G z k).2.2=1 ∧ (G z k).2.2.det=1) ∧
    ∀ (u v : rigidSystemState N), (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (u k)) → (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (v k)) →
      (∑ k, MolecularDynamics.Chapter04Review.rbForm (G z k) (((fderiv ℝ G z) u) k) (((fderiv ℝ G z) v) k))=
        ∑ k, MolecularDynamics.Chapter04Review.rbForm (z k) (u k) (v k)

/-- source_id: MD-4.4.2-DLMPrintedSystemStructure · unnumbered_claim · §4.4.2 · 印刷p.173–174 / PDFp.195–196
[EXTRA] C³耦合势和正主惯性矩为明确技术资格；实际全部SO3输入/输出约束及N体两形式在定义内。 -/
theorem dlmPrintedSystemStructure : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ),
  (∀ k i, 0 < I k i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rigidSystemSymplectic (dlmPrintedSystem I U h) := by
  sorry

/-- source_id: MD-4.4.1-ExactPlanarRotation · unnumbered_claim · §4.4.1 · 印刷p.173 / PDFp.195
[EXTRA] [EXTRA]第二/第三子场按完整π₂/π₃解释，与PrincipalAxisField一致；显式负角主动旋转给出(4.41)的π×ω符号，不将原表正角错误候选当作该精确子流。 -/
theorem exactPlanarRotation : ∀ (I π : MolecularDynamics.Chapter04Review.V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => MolecularDynamics.Chapter04Review.axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ (MolecularDynamics.Chapter04Review.cross3 (γ t) (Pi.single i (γ t i/I i))) t := by
  sorry

end MD.Ch04

/- BEGIN WEBSITE REPAIR AXIOMS -/
#print axioms MD.Ch04.linearField
#print axioms MD.Ch04.eulerFactor
#print axioms MD.Ch04.scalarEulerStable
#print axioms MD.Ch04.eulerStabilityRegion
#print axioms MD.Ch04.oscillatorMatrix
#print axioms MD.Ch04.eulerImaginaryGrowth
#print axioms MD.Ch04.eulerImaginaryGrowth_rate
#print axioms MD.Ch04.symplecticEulerMatrix
#print axioms MD.Ch04.symplecticEulerCharacteristic
#print axioms MD.Ch04.prkThreshold
#print axioms MD.Ch04.verletStability
#print axioms MD.Ch04.verletStability_zero
#print axioms MD.Ch04.symplecticEulerBoundaryPrinted
#print axioms MD.Ch04.verletBoundaryPrinted
#print axioms MD.Ch04.oscillatorSpectrum
#print axioms MD.Ch04.symplecticEulerRoots
#print axioms MD.Ch04.symplecticEulerUnitRoots
#print axioms MD.Ch04.symplecticEulerStability
#print axioms MD.Ch04.symplecticEulerStability_complete
#print axioms MD.Ch04.printedImplicitRelation
#print axioms MD.Ch04.actualMidpointRelation
#print axioms MD.Ch04.implicitFactor
#print axioms MD.Ch04.implicitFactor_update
#print axioms MD.Ch04.implicitModulus
#print axioms MD.Ch04.implicitModulus_iterates
#print axioms MD.Ch04.printedModifiedFrequency
#print axioms MD.Ch04.modifiedFrequencyLimit
#print axioms MD.Ch04.midpointFrequencyRatio
#print axioms MD.Ch04.modifiedFrequencyRatio_limits
#print axioms MD.Ch04.mechanicalMidpointRelation
#print axioms MD.Ch04.midpointElimination
#print axioms MD.Ch04.midpointEulerHalfSteps
#print axioms MD.Ch04.splitHamiltonian
#print axioms MD.Ch04.fastVerlet
#print axioms MD.Ch04.respa
#print axioms MD.Ch04.respaStructure
#print axioms MD.Ch04.slowMatrix
#print axioms MD.Ch04.fastMatrix
#print axioms MD.Ch04.impulseMatrix
#print axioms MD.Ch04.impulseDet
#print axioms MD.Ch04.impulseDet_eigenvalueProduct
#print axioms MD.Ch04.impulseTrace
#print axioms MD.Ch04.impulseTrace_eigenvalueSum
#print axioms MD.Ch04.resonancePower
#print axioms MD.Ch04.resonanceTaylor
#print axioms MD.Ch04.resonanceInstability
#print axioms MD.Ch04.resonanceInstability_realSpectrum
#print axioms MD.Ch04.resonanceEigenPrinted
#print axioms MD.Ch04.mollifiedAverage
#print axioms MD.Ch04.mollifiedPotential
#print axioms MD.Ch04.resonanceLinearRate
#print axioms MD.Ch04.resonanceGrowth
#print axioms MD.Ch04.mollifiedStructure
#print axioms MD.Ch04.holonomicRelation
#print axioms MD.Ch04.timeConstraintDerivative
#print axioms MD.Ch04.constrainedSolution
#print axioms MD.Ch04.constrainedSolution_generalForce
#print axioms MD.Ch04.constraintSet
#print axioms MD.Ch04.constraintSet_regularLevel
#print axioms MD.Ch04.cotangentSet
#print axioms MD.Ch04.constraintJacobian
#print axioms MD.Ch04.combineConstraints
#print axioms MD.Ch04.jacobianActualDerivative
#print axioms MD.Ch04.jacobianActualDerivative_curve
#print axioms MD.Ch04.constraintDegrees
#print axioms MD.Ch04.flexiblePendulumHamiltonian
#print axioms MD.Ch04.restraintPotential
#print axioms MD.Ch04.restraintForcePrinted
#print axioms MD.Ch04.constrainedPendulum
#print axioms MD.Ch04.constraintCurvature
#print axioms MD.Ch04.reactionMultiplier
#print axioms MD.Ch04.reactionBalance
#print axioms MD.Ch04.gramPositive
#print axioms MD.Ch04.gramInvertible
#print axioms MD.Ch04.gramInvertible_multiplier
#print axioms MD.Ch04.cotangentInvariant
#print axioms MD.Ch04.reducedFieldRegularity
#print axioms MD.Ch04.restrictedForm
#print axioms MD.Ch04.variational
#print axioms MD.Ch04.hessianPullbackCancel
#print axioms MD.Ch04.constrainedFlowPullback
#print axioms MD.Ch04.positionEulerPrinted
#print axioms MD.Ch04.positionEulerRelation
#print axioms MD.Ch04.hiddenEulerError
#print axioms MD.Ch04.projectionResidual
#print axioms MD.Ch04.projectionJacobian
#print axioms MD.Ch04.newtonConstraint
#print axioms MD.Ch04.frozenNewtonConstraint
#print axioms MD.Ch04.newtonQuadratic
#print axioms MD.Ch04.frozenNewtonLinear
#print axioms MD.Ch04.projectionScale
#print axioms MD.Ch04.frozenGramPrinted
#print axioms MD.Ch04.componentPrinted
#print axioms MD.Ch04.componentConstraintStep
#print axioms MD.Ch04.componentSweep
#print axioms MD.Ch04.projectedEulerPrinted
#print axioms MD.Ch04.projectedEulerRelation
#print axioms MD.Ch04.lemma41
#print axioms MD.Ch04.multiMomentumPullback
#print axioms MD.Ch04.projectedEulerPullback
#print axioms MD.Ch04.cotangentMultiplier
#print axioms MD.Ch04.cotangentProjection
#print axioms MD.Ch04.cotangentHidden
#print axioms MD.Ch04.cotangentRegularity
#print axioms MD.Ch04.cotangentPullback
#print axioms MD.Ch04.gramProjectedEuler
#print axioms MD.Ch04.shakePositionPrinted
#print axioms MD.Ch04.shakePositionRelation
#print axioms MD.Ch04.shakeRelation
#print axioms MD.Ch04.rattleRelation
#print axioms MD.Ch04.constrainedOrders
#print axioms MD.Ch04.rattleSymplectic
#print axioms MD.Ch04.staggeredConstraintRelation
#print axioms MD.Ch04.shakeRattlePositions
#print axioms MD.Ch04.shakeElimination
#print axioms MD.Ch04.shakePositionOrder
#print axioms MD.Ch04.adjointEulerRelation
#print axioms MD.Ch04.constrainedComposition
#print axioms MD.Ch04.constrainedCompositionOrder
#print axioms MD.Ch04.momentumProjector
#print axioms MD.Ch04.constrainedPotentialFlow
#print axioms MD.Ch04.geodesicRelation
#print axioms MD.Ch04.mShakeIteration
#print axioms MD.Ch04.settleRelation
#print axioms MD.Ch04.lincsInverse
#print axioms MD.Ch04.lincsConvergence
#print axioms MD.Ch04.waterPairPotential
#print axioms MD.Ch04.totalMass
#print axioms MD.Ch04.centerMass
#print axioms MD.Ch04.relativePositions
#print axioms MD.Ch04.relativeWeightedZero
#print axioms MD.Ch04.kineticSplit
#print axioms MD.Ch04.secondMoment
#print axioms MD.Ch04.rotationKinetic
#print axioms MD.Ch04.rotationTraceIdentity
#print axioms MD.Ch04.rotationSkew
#print axioms MD.Ch04.skewMatrix
#print axioms MD.Ch04.cross3
#print axioms MD.Ch04.skewRepresentation
#print axioms MD.Ch04.crossMatrix
#print axioms MD.Ch04.rigidVelocity
#print axioms MD.Ch04.inertiaTensor
#print axioms MD.Ch04.crossIdentityFull
#print axioms MD.Ch04.rotationalEnergy
#print axioms MD.Ch04.inertiaSkewIdentity
#print axioms MD.Ch04.inertiaTracePrinted
#print axioms MD.Ch04.inertiaTraceCorrected
#print axioms MD.Ch04.dipolarHamiltonian
#print axioms MD.Ch04.dipolarPairPotential
#print axioms MD.Ch04.dipolarRotationalPrinted
#print axioms MD.Ch04.rigidHamiltonian
#print axioms MD.Ch04.secondMomentDiagonal
#print axioms MD.Ch04.rotationBodyEnergy
#print axioms MD.Ch04.dipolarConstraint
#print axioms MD.Ch04.dipolarPotentialSum
#print axioms MD.Ch04.rotationTrajectory
#print axioms MD.Ch04.rotationDerivativePrinted
#print axioms MD.Ch04.rigidMatrixRelation
#print axioms MD.Ch04.angularMomentum
#print axioms MD.Ch04.bodyMomentum
#print axioms MD.Ch04.angularInertia
#print axioms MD.Ch04.eulerRigidField
#print axioms MD.Ch04.freeRigidSolution
#print axioms MD.Ch04.rigidInvariants
#print axioms MD.Ch04.rigidPoissonMatrix
#print axioms MD.Ch04.poissonDegeneracy
#print axioms MD.Ch04.axisRotation
#print axioms MD.Ch04.secondAxisPrinted
#print axioms MD.Ch04.thirdAxisPrinted
#print axioms MD.Ch04.principalAxisField
#print axioms MD.Ch04.printedSpinAxis
#print axioms MD.Ch04.printedSpinStep
#print axioms MD.Ch04.axisFlow
#print axioms MD.Ch04.spinPoisson
#print axioms MD.Ch04.rigidPoissonSkew
#print axioms MD.Ch04.rigidHamiltonianField
#print axioms MD.Ch04.rigidForce
#print axioms MD.Ch04.matrixRot
#print axioms MD.Ch04.rigidTorque
#print axioms MD.Ch04.dlmPrinted
#print axioms MD.Ch04.dlmMassOnly
#print axioms MD.Ch04.driftSpinCommute
#print axioms MD.Ch04.dlmStructure
#print axioms MD.Ch04.dlmPrintedStructure
#print axioms MD.Ch04.rigidSystemForce
#print axioms MD.Ch04.rigidSystemTorque
#print axioms MD.Ch04.rigidSystemKick
#print axioms MD.Ch04.rigidSystemDriftPrinted
#print axioms MD.Ch04.rigidSystemSpinPrinted
#print axioms MD.Ch04.dlmPrintedSystem
#print axioms MD.Ch04.systemDriftSpinCommute
#print axioms MD.Ch04.rigidSystemSymplectic
#print axioms MD.Ch04.dlmPrintedSystemStructure
#print axioms MD.Ch04.exactPlanarRotation
/- END WEBSITE REPAIR AXIOMS -/
