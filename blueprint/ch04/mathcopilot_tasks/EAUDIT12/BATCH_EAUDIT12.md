# EAUDIT12：第4章§4.3.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3.3-ComponentPrinted",
  "kind": "definition",
  "label": null,
  "section": "4.3.3",
  "printed_page": "158",
  "pdf_page": "180",
  "statement_latex": "In general, we perform a sequence of updates\n\\[\\Delta\\Lambda_j=[\\nabla g_j(Q)^TM^{-1}G_j^1]^{-1}g_j(Q),\\qquad Q:=Q-M^{-1}G_n^j\\Delta\\Lambda_j,\\]\nas $j$ cycles repeatedly from $1$ to $m$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF第180页（印刷第158页）§4.3.3：G_n^k=\\nabla g_k(q_n)，为G_n^T的第k列；q_n为固定旧位置，Q为在分量更新过程中不断改变的位置，Q_n为初始试探位置。",
    "约束分量编号为j=1,...,m；M为质量矩阵，M^{-1}作用于梯度向量。Lean中的n是位置坐标维数，l是约束数，m : Fin n → ℝ是各坐标质量，Fin l的0,...,l-1对应原文1,...,m。",
    "本页初始化为Λ=0、Q=Q_n；ΔΛ_j是第j个乘子分量的增量，Q:=Q-M^{-1}G_n^jΔΛ_j使用当前Q计算后立即覆盖Q。",
    "原文方括号的逆是标量逆；有意义的线性化步骤要求该分母非零，M可逆，并要求g_j在求梯度处可微。原句未把这些技术资格逐一写成假设。",
    "原书一般式分母确印为G_j^1，而同页已定义的是G_n^k、更新方向为G_n^j；保留印刷索引，不将其静默改为G_n^j。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "一般分量式分母G_j^1疑为G_n^j的索引误写；原文不静默改。"
    }
  ],
  "lean_decl": "MD.Ch04.componentPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Gsup1是未定义印刷G_j^1的显式参数，未假设它等于已定义梯度。",
    "[EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。"
  ],
  "statement_scope": "单个有效分量步骤；重复顺序循环由MD-4.3.3-ComponentSweep承担。印刷Gsup1与梯度解释分开保留。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:54:20.419406",
      "before_sha256": "4a3ab9761a017080e1ec7ba9ee787b52206133c9d7c5a93591a5814322dd510a",
      "after_sha256": "3f12733fb438efae3d6152154d6582fb5e3ea892a40c2ac3482b76af132ab3f3",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def componentPrinted {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.componentPrinted
```lean
def componentPrinted {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.3-ComponentConstraintStep",
  "kind": "definition",
  "label": null,
  "section": "4.3.3",
  "printed_page": "158",
  "pdf_page": "180",
  "statement_latex": "\\[\\Delta\\Lambda_1=[\\nabla g_1(Q)^TM^{-1}G_n^1]^{-1}g_1(Q).\\]\nWe then update $Q$ by\n\\[Q:=Q-M^{-1}G_n^1\\Delta\\Lambda_1.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF第180页（印刷第158页）§4.3.3：G_n^k=\\nabla g_k(q_n)，为G_n^T的第k列；q_n为固定旧位置，Q为在分量更新过程中不断改变的位置，Q_n为初始试探位置。",
    "约束分量编号为j=1,...,m；M为质量矩阵，M^{-1}作用于梯度向量。Lean中的n是位置坐标维数，l是约束数，m : Fin n → ℝ是各坐标质量，Fin l的0,...,l-1对应原文1,...,m。",
    "本页初始化为Λ=0、Q=Q_n；ΔΛ_j是第j个乘子分量的增量，Q:=Q-M^{-1}G_n^jΔΛ_j使用当前Q计算后立即覆盖Q。",
    "原文方括号的逆是标量逆；有意义的线性化步骤要求该分母非零，M可逆，并要求g_j在求梯度处可微。原句未把这些技术资格逐一写成假设。",
    "原书一般式分母确印为G_j^1，而同页已定义的是G_n^k、更新方向为G_n^j；保留印刷索引，不将其静默改为G_n^j。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.componentConstraintStep",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一般j采用已定义Gn^j=grad gj(qn)，取非零分母才是可用步骤；原一般式索引疑误由ComponentPrinted保留。",
    "[EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。"
  ],
  "statement_scope": "单个有效分量步骤；重复顺序循环由MD-4.3.3-ComponentSweep承担。印刷Gsup1与梯度解释分开保留。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:54:20.419508",
      "before_sha256": "3b5bd4364d1862d56d67fe807da4dbb346b1269ed57856a19829145eb736f216",
      "after_sha256": "079244dd9d01aeda6f35eec44864d2465fbdb1bffa64d4c0ab81535c7482d4f3",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.componentConstraintStep
```lean
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.3-ComponentSweep",
  "kind": "definition",
  "label": null,
  "section": "4.3.3",
  "printed_page": "158",
  "pdf_page": "180",
  "statement_latex": "and continue to update $\\Lambda_2$ in the same manner (using the second constraint). In general, we perform a sequence of updates\n\\[\\Delta\\Lambda_j=[\\nabla g_j(Q)^TM^{-1}G_j^1]^{-1}g_j(Q),\\qquad Q:=Q-M^{-1}G_n^j\\Delta\\Lambda_j,\\]\nas $j$ cycles repeatedly from $1$ to $m$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF第180页（印刷第158页）§4.3.3：G_n^k=\\nabla g_k(q_n)，为G_n^T的第k列；q_n为固定旧位置，Q为在分量更新过程中不断改变的位置，Q_n为初始试探位置。",
    "约束分量编号为j=1,...,m；M为质量矩阵，M^{-1}作用于梯度向量。Lean中的n是位置坐标维数，l是约束数，m : Fin n → ℝ是各坐标质量，Fin l的0,...,l-1对应原文1,...,m。",
    "本页初始化为Λ=0、Q=Q_n；ΔΛ_j是第j个乘子分量的增量，Q:=Q-M^{-1}G_n^jΔΛ_j使用当前Q计算后立即覆盖Q。",
    "原文方括号的逆是标量逆；有意义的线性化步骤要求该分母非零，M可逆，并要求g_j在求梯度处可微。原句未把这些技术资格逐一写成假设。",
    "原书一般式分母确印为G_j^1，而同页已定义的是G_n^k、更新方向为G_n^j；保留印刷索引，不将其静默改为G_n^j。",
    "原页实际给出的停止建议是$\\|\\Delta\\Lambda_j\\|\\leq\\mathrm{tol}$，$j=1,2,\\ldots,m$；“或残差”不是这句原文给出的条件。本条不声称收敛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.componentSweep",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一次完整顺序sweep，使用上一条统一Gn索引；多轮为其真实函数迭代。",
    "[EXTRA] 保留一次修订梯度扫描辅助；新增字面Gsup1分母的实际逐分量轨迹、多轮顺序循环与每步有效域，以及一轮全部增量停止检查。字面原式不暗换Gsup1，不添加收敛承诺。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:54:20.419570",
      "before_sha256": "e50c9c99546cdd8ca9e30fab7cec54838ab913c85ab125ee712afa541276385f",
      "after_sha256": "9b12f1b88bbd7034135cbd549115cb600f5ad1339d50e70c156ba2aa85011d02",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def componentSweep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (List.finRange l).foldl (fun Qcur j => MolecularDynamics.Chapter04Review.componentConstraintStep m g q Qcur j) Qnow

def componentPrintedDelta {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (Q : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) : ℝ :=
  g j Q/MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
    (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))

def componentPrintedTrajectory {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) : ℕ → MolecularDynamics.Chapter04Review.Q n
  | 0 => Q₀
  | k+1 =>
    let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
    if hl : 0 < l then
      let j : Fin l := ⟨k%l,Nat.mod_lt k hl⟩
      Q-componentPrintedDelta m g Q Gsup1 j •
        MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
    else Q

def componentPrintedIteration {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (rounds : ℕ) (_hm : ∀ i, 0 < m i) (_hl : 0 < l)
    (_hvalid : ∀ k < rounds*l,
      let j : Fin l := ⟨k%l,Nat.mod_lt k _hl⟩
      let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
      DifferentiableAt ℝ (g j) q ∧ DifferentiableAt ℝ (g j) Q ∧
        MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
          (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) :
    MolecularDynamics.Chapter04Review.Q n :=
  componentPrintedTrajectory m g q Q₀ Gsup1 (rounds*l)

def componentPrintedStop {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (round : ℕ) (tol : ℝ) (_hl : 0 < l) : Prop :=
  ∀ j : Fin l, |componentPrintedDelta m g
    (componentPrintedTrajectory m g q Q₀ Gsup1 (round*l+j.val)) Gsup1 j| < tol
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.componentConstraintStep
```lean
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q Qnow : Q n) (j : Fin l) : Q n :=
  Qnow-(g j Qnow / dot (grad (g j) Qnow) (invMass m (grad (g j) q))) •
    invMass m (grad (g j) q)
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.componentConstraintStep
```lean
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```
### 实际依赖 MD.Ch04.componentPrintedDelta
```lean
def componentPrintedDelta {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (Q : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) : ℝ :=
  g j Q/MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
    (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))
```
### 实际依赖 MD.Ch04.componentPrintedIteration
```lean
def componentPrintedIteration {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (rounds : ℕ) (_hm : ∀ i, 0 < m i) (_hl : 0 < l)
    (_hvalid : ∀ k < rounds*l,
      let j : Fin l := ⟨k%l,Nat.mod_lt k _hl⟩
      let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
      DifferentiableAt ℝ (g j) q ∧ DifferentiableAt ℝ (g j) Q ∧
        MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
          (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) :
    MolecularDynamics.Chapter04Review.Q n :=
  componentPrintedTrajectory m g q Q₀ Gsup1 (rounds*l)
```
### 实际依赖 MD.Ch04.componentPrintedStop
```lean
def componentPrintedStop {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (round : ℕ) (tol : ℝ) (_hl : 0 < l) : Prop :=
  ∀ j : Fin l, |componentPrintedDelta m g
    (componentPrintedTrajectory m g q Q₀ Gsup1 (round*l+j.val)) Gsup1 j| < tol
```
### 实际依赖 MD.Ch04.componentPrintedTrajectory
```lean
def componentPrintedTrajectory {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) : ℕ → MolecularDynamics.Chapter04Review.Q n
  | 0 => Q₀
  | k+1 =>
    let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
    if hl : 0 < l then
      let j : Fin l := ⟨k%l,Nat.mod_lt k hl⟩
      Q-componentPrintedDelta m g Q Gsup1 j •
        MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
    else Q
```
### 实际依赖 MD.Ch04.componentSweep
```lean
def componentSweep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (List.finRange l).foldl (fun Qcur j => MolecularDynamics.Chapter04Review.componentConstraintStep m g q Qcur j) Qnow
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
