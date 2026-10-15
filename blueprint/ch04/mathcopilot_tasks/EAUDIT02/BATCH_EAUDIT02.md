# EAUDIT02：第4章§4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4-SymplecticEulerRoots",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "The eigenvalues of the matrix are easily found, they are\n\\[\\lambda_{1,2}=1-\\frac{h^2\\Omega^2}{2}\\pm\\frac12\\sqrt{h^4\\Omega^4-4h^2\\Omega^2}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF p.162：Q=q+hP，P=p-hΩ²q；故作用于(q,p)ᵀ的矩阵为[[1-h²Ω²,h],[-hΩ²,1]]。",
    "λ₁,₂ 是该矩阵的复特征值；平方根的两个符号共同给出根集合，重根按集合理解。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.symplecticEulerRoots",
  "reusable_proofs": [],
  "extra_assumptions": [
    "以任意复平方根d²=判别式表达±，避免未指定复sqrt分支；不是仅特征多项式断言。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:51:09.667335",
      "before_sha256": "5983aa7b0106839acdfe76289cce58c2dd3d60f3c8a7698cd399887f8af9537c",
      "after_sha256": "ca9780da2147bed0e113dc03f240d9fb7eae0663777558900347fb644fc617eb",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
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
```
### 实际依赖 MolecularDynamics.Chapter04Review.symplecticEulerMatrix
```lean
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
```
### 实际依赖 MD.Ch04.symplecticEulerMatrix
```lean
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
```

## 原文JSON
```json
{
  "source_id": "MD-4-SymplecticEulerUnitRoots",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "Then we observe that for $h^2\\Omega^2\\le4$, they are complex and their squared magnitude is\n\\[|\\lambda_{1,2}|^2=\\left(1-\\frac{h^2\\Omega^2}{2}\\right)^2+\\frac14(4h^2\\Omega^2-h^4\\Omega^4)=1,\\]\nthus both eigenvalues lie on the unit circle in the complex plane as long as $h\\Omega\\le2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "λ₁,₂ 指 PDF p.162 上方 Symplectic Euler 矩阵的特征值；平方条件 h²Ω²≤4 包括0和4两个重根端点。",
    "原文 they are complex 在端点根为实数±1；只有0<h²Ω²<4时为非实复共轭根。原文末句 hΩ≤2 按正频率、正步长背景理解；任意实参数需|hΩ|≤2。",
    "模平方公式为原页推导，不是独立完整证明；单位圆谱不等于幂有界。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.symplecticEulerUnitRoots",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:51:09.667335",
      "before_sha256": "f2cee3fa5c32f4de58e397e5accc8e89b02801cae69b83009c08284af5eb70ee",
      "after_sha256": "9d4a11c940f8d874e01ec46641ad916b3f3cefd2f7dfe5743d1d2100f8f7a261",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
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
```

## 原文JSON
```json
{
  "source_id": "MD-4-SymplecticEulerStability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "This is the so-called linear stability condition of the Symplectic Euler method: if $h\\Omega\\le2$ the integrator is stable. When $h\\Omega>2$, the eigenvalues of the discretization method are both real, with one strictly inside and one strictly outside the unit circle. This implies that the method will exhibit exponentially growing solutions. We say that the stability threshold of the Symplectic Euler method is $2/\\Omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "≤2端点有单位圆谱但通常Jordan线性增长；幂有界不能包含端点。"
    }
  ],
  "lean_decl": "MD.Ch04.symplecticEulerStability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正确的幂有界资格改为0<|hΩ|<2；原≤2字面版独立保留，未声称已审核修复。",
    "[EXTRA] 明确为修订稳定内区间结论；补超阈值实谱恰为一内一外非零实根、真实指数增长轨道及正步长稳定集合上确界2/Ω。原端点错误单列保留，未新增证明。"
  ],
  "statement_scope": "修订的严格内区间、超阈值两实根/指数轨道及阈值上确界；原印含端点句由MD-4-SymplecticEulerBoundaryPrinted保留。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:51:09.667335",
      "before_sha256": "28985695ae56de2dd0f7e38ad125d4ec3b646409a837e48c2ede5cc7cb3f288e",
      "after_sha256": "14840bd1b01872dfe78f07ba450440416f2f34b62f894f857dcb47765be2fd33",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
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
```
### 实际依赖 MolecularDynamics.Chapter04Review.eigenvalueOutside
```lean
def eigenvalueOutside (A : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ∃ rho : ℂ, 1 < ‖rho‖ ∧ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (A.map Complex.ofReal) *ᵥ v = rho • v
```
### 实际依赖 MolecularDynamics.Chapter04Review.matrixStable
```lean
def matrixStable (A : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ∃ C : ℝ, ∀ k : ℕ, ∀ v : Fin 2 → ℝ, ‖A^k *ᵥ v‖ ≤ C*‖v‖
```
### 实际依赖 MolecularDynamics.Chapter04Review.symplecticEulerMatrix
```lean
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
```
### 实际依赖 MolecularDynamics.Chapter04Review.verletMatrix
```lean
def verletMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2/2,h; -h*Ω^2*(1-h^2*Ω^2/4),1-h^2*Ω^2/2]
```
### 实际依赖 MolecularDynamics.Chapter04Review.eigenvalueOutside
```lean
def eigenvalueOutside (A : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ∃ rho : ℂ, 1 < ‖rho‖ ∧ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (A.map Complex.ofReal) *ᵥ v = rho • v
```
### 实际依赖 MolecularDynamics.Chapter04Review.matrixStable
```lean
def matrixStable (A : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ∃ C : ℝ, ∀ k : ℕ, ∀ v : Fin 2 → ℝ, ‖A^k *ᵥ v‖ ≤ C*‖v‖
```
### 实际依赖 MD.Ch04.symplecticEulerMatrix
```lean
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
```
### 实际依赖 MolecularDynamics.Chapter04Review.verletMatrix
```lean
def verletMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2/2,h; -h*Ω^2*(1-h^2*Ω^2/4),1-h^2*Ω^2/2]
```
