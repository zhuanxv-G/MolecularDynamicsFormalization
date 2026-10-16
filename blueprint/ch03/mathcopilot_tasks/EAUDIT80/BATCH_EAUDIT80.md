# EAUDIT80：第3章§3.6.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.6.2-FlowReversal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.2",
  "printed_page": "129",
  "pdf_page": "151",
  "statement_latex": "From this we see that if we start from a point $z_0$ and integrate forward in time (i.e apply $\\mathcal F_t$) then apply the involution $R$, we get the exact same result as if we start from $\\widetilde z(0)=Rz_0$ and integrate backward in time (i.e apply $\\mathcal F_{-t}$). In sum, since $z_0$ is an arbitrary point,\n\\[\\mathcal F_{-t}(Rz)=R\\mathcal F_t(z).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$z\\in\\mathbb R^n$；$R$ 同时表示线性 involution 矩阵及映射 $z\\mapsto Rz$，$R^2=I$。",
    "本页推导针对时间可逆向量场，使用 $f(Rz)=-Rf(z)$；$\\mathcal F_t(z_0)$ 为该 ODE 从 $z_0$ 出发的真实流。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.flowReversal",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正确R反转、C¹场和全实时间真实流；不把所需反转等式藏进流假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:58.165808",
      "before_sha256": "e6a57d71b5fc0fdea5bff5cfff2403773c730017f72ad558800eb015555a1c58",
      "after_sha256": "db241f11a1c89cf76cfb9814f1b1a55afbb5644aa4c844bb4a7542458a076fa7",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem flowReversal :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) →
    ∀ t z, Φ (-t) (R z)=R (Φ t z) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch03.linearInvolution
```lean
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
```

## 原文JSON
```json
{
  "source_id": "MD-3.6.2-FlowReversalIdentity",
  "kind": "unnumbered_claim",
  "label": "(3.14)",
  "section": "3.6.2",
  "printed_page": "129",
  "pdf_page": "151",
  "statement_latex": "For the flow map, $\\mathcal F_{-t}=\\mathcal F_t^{-1}$ so we can recast the identity as\n\\[R\\circ\\mathcal F_t\\circ R\\circ\\mathcal F_t=\\mathrm{Id},\\tag{3.14}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$z\\in\\mathbb R^n$；$R$ 同时表示线性 involution 矩阵及映射 $z\\mapsto Rz$，$R^2=I$。",
    "本页推导针对时间可逆向量场，使用 $f(Rz)=-Rf(z)$；$\\mathcal F_t(z_0)$ 为该 ODE 从 $z_0$ 出发的真实流。",
    "$\\mathcal F_{-t}=\\mathcal F_t^{-1}$；$\\mathrm{Id}$ 为相空间上的恒等映射。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.flowReversalIdentity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正确R反转、C¹场、实际全时间流、群性质；不供应结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:58.165808",
      "before_sha256": "626e39d022e8a0002d70c9b481f4e86a2fdee5efb8e7ebd93c5e860b7e2ee1eb",
      "after_sha256": "a87f39125c60a7a4383367208ae6b81e388dd59619bff490760c6af8e09ce774",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem flowReversalIdentity :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) → ∀ t z, R (Φ t (R (Φ t z)))=z := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch03.linearInvolution
```lean
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
```

## 原文JSON
```json
{
  "source_id": "MD-3.6.2-SymmetricMethod",
  "kind": "definition",
  "label": null,
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "Recall from the previous chapter that a numerical method $\\mathcal G_h$ was said to be symmetric if it satisfied\n\\[\\mathcal G_{-h}=\\mathcal G_h^{-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal G_h$ 为一步数值映射；$\\mathcal G_h^{-1}$ 是其实际逆映射，$h$ 为步长。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.symmetricMethod",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:58.165808",
      "before_sha256": "1fddec8f0fadda9291793ccd418cbe31a713bc306f3a4d0fb77a6008094b2585",
      "after_sha256": "2098219e84de0500a794abaa992f23b85527e413175653ddf1c1a0e9d308c330",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def symmetricMethod {E : Type*} (G : ℝ → Equiv.Perm E) : Prop := ∀ h, G (-h)=(G h).symm
```
### 实际依赖 MD.Ch03.symmetricMethod
```lean
def symmetricMethod {E : Type*} (G : ℝ → Equiv.Perm E) : Prop := ∀ h, G (-h)=(G h).symm
```

## 原文JSON
```json
{
  "source_id": "MD-3.6.2-AffineInvariant",
  "kind": "definition",
  "label": "Definition 3.1",
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "Definition 3.1 (Affine Invariance) Let\n\\[\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=f(\\boldsymbol z)\\tag{3.16}\\]\nbe a given ordinary differential equation. The transformation $\\widetilde{\\boldsymbol z}=A\\boldsymbol z$, where $A$ is a non-singular square matrix, results in the modified differential equation\n\\[\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=Af(A^{-1}\\widetilde{\\boldsymbol z}).\\tag{3.17}\\]\nLet $z_0,z_1,\\ldots$ be a sequence of points obtained by application of the numerical method $\\mathcal G_h$ to (3.16). If the same method, when applied to (3.17) produces the set of points $Az_0,Az_1,\\ldots$, then we say that the numerical method is invariant with respect to the transformation $\\widetilde{\\boldsymbol z}=Az$. An affine invariant method is one which is invariant under any such transformation.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$A$ 为非奇异方阵；$\\widetilde{\\boldsymbol z}=A\\boldsymbol z$，变换后的向量场为 $Af(A^{-1}\\widetilde{\\boldsymbol z})$。",
    "$z_0,z_1,\\ldots$ 为同一步长方法产生的序列，变换方程从 $Az_0$ 出发产生 $Az_0,Az_1,\\ldots$；本书这一定义仅量化线性变换，未包含平移。",
    "(3.17)左端原印为 $\\mathrm d\\boldsymbol z/\\mathrm dt$，没有波浪号；保留原印，并单独标记疑误。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "(3.17)左端印刷z而不是z̃；保留原文，语义按前后说明的变换坐标。"
    }
  ],
  "lean_decl": "MD.Ch03.affineInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:58.166807",
      "before_sha256": "212ad08358d6b9196f61d5e21f4b052ec021a3261fefe8fe06b5e51a24de80f1",
      "after_sha256": "a3375e7dc3a0d60ac3e75a120cf71ba693d5675dc3cf2f3329f346699bcdac89",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def affineInvariant {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch03.affineInvariant
```lean
def affineInvariant {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)
```
### 实际依赖 MolecularDynamics.Chapter03Review.transportedField
```lean
def transportedField {n : ℕ} (A : Q n ≃L[ℝ] Q n) (f : Q n → Q n) (z : Q n) : Q n := A (f (A.symm z))
```

## 原文JSON
```json
{
  "source_id": "MD-3.6.2-SymmetricAffineReversible",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "If a differential equation is time-reversible with respect to the involution $R$, and we apply a method which is affine invariant and symmetric, then the method will be time-reversible (3.15).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "一般方法需要G_{−f}(h)=G_f(−h)，否则原文蕴含式条件不全。"
    }
  ],
  "lean_decl": "MD.Ch03.symmetricAffineReversible",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]G_{−f}(h)=G_f(−h)显式给步长符号相容性；原文没列这项，任意抽象方法仅线性等变与对称未必足够。",
    "[EXTRA] 明确本条是原印省略方法类资格后的受限修复；符号/时间尺度相容仅要求固定f，不对所有无关g全称。保留原书疑误说明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:58.166807",
      "before_sha256": "6f84c9e1d5e1c2f352231bc74e8be59564d0acd8b3b2f0421636b67eb822cba3",
      "after_sha256": "1463a36d278a94bc40627890daa24308b53adaafc34f4b60fde7df80974f98cc",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symmetricAffineReversible :
  ∀ (n : ℕ) (R : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (G : (Q n → Q n) → ℝ → Q n → Q n),
    (∀ z, R (R z)=z) → (∀ z, f (R z)=-R (f z)) → affineInvariant G →
    (∀ h z, G (fun x => -f x) h z=G f (-h) z) →
    (∀ h z, G f (-h) (G f h z)=z) → reversibleMethod R (G f) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch03.affineInvariant
```lean
def affineInvariant {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)
```
### 实际依赖 MD.Ch03.reversibleMethod
```lean
def reversibleMethod {E : Type*} (R : E → E) (G : ℝ → E → E) : Prop := ∀ h z, R (G h (R (G h z)))=z
```
### 实际依赖 MolecularDynamics.Chapter03Review.transportedField
```lean
def transportedField {n : ℕ} (A : Q n ≃L[ℝ] Q n) (f : Q n → Q n) (z : Q n) : Q n := A (f (A.symm z))
```

## 原文JSON
```json
{
  "source_id": "MD-3.6.2-RKAffine",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Runge–Kutta 与 Partitioned Runge–Kutta 均为原句量化的方法类别；“if they are also symmetric”所指的是上述 $\\mathcal G_{-h}=\\mathcal G_h^{-1}$，时间反转指(3.15)。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.rkAffine",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.rkAffine_proved"
  ],
  "extra_assumptions": [
    "[EXTRA] 仅承担普通RK阶段/更新的线性等变；PRK分区修复及对称方法反演另映射PartitionedAffine、SymmetricAffineReversible，原文整句保留。"
  ],
  "statement_scope": "普通RK关系的线性坐标变换等变性子句；PRK保持分区的修复子句见MD-3.6.2-PartitionedAffine，时间反演推论见MD-3.6.2-SymmetricAffineReversible。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:58.166807",
      "before_sha256": "eaccb881d99a8f0698407bd8c6cc28efe9e9409ac6965a4f66e050e44783bd53",
      "after_sha256": "ef844c01eb080c1e1355f959186812f5eb5ba2c8f17a9a779fe496be105f1c34",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem rkAffine :
  ∀ (n s : ℕ) (L : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
    rungeKuttaRelation f A b h z w F →
      rungeKuttaRelation (transportedField L f) A b h (L z) (L w) (fun i => L (F i)) := by
  exact MolecularDynamics.Chapter03Review.rkAffine_proved
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.rungeKuttaRelation
```lean
def rungeKuttaRelation {n s : ℕ} (f : Q n → Q n) (A : Matrix (Fin s) (Fin s) ℝ)
    (b : Fin s → ℝ) (h : ℝ) (z w : Q n) (F : Fin s → Q n) : Prop :=
  (∀ i, F i = f (z + h • ∑ j, A i j • F j)) ∧ w = z + h • ∑ i, b i • F i
```
### 实际依赖 MolecularDynamics.Chapter03Review.transportedField
```lean
def transportedField {n : ℕ} (A : Q n ≃L[ℝ] Q n) (f : Q n → Q n) (z : Q n) : Q n := A (f (A.symm z))
```

## 原文JSON
```json
{
  "source_id": "MD-3.6.2-PartitionedAffine",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "这是原文PRK的严格条件化分块版本；字面全称单独保留，未替代它。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.partitionedAffine",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正确限定为保持q,p分区的连续线性等价Lq,Lp；不同分区表格不要求混合线性等变。",
    "[EXTRA] 本条显式仅为保持分区的PRK阶段/更新等变修复；普通RK及有符号相容、对称资格的时间反演推论归RKAffine/SymmetricAffineReversible。保留混合变换错误的Printed导师条目。"
  ],
  "statement_scope": "PRK保持分区的线性坐标变换下阶段/更新等变性的受限修复；普通RK见MD-3.6.2-RKAffine，时间反演见MD-3.6.2-SymmetricAffineReversible；任意混合分区的原印主张见待导师Printed条目。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:58.166807",
      "before_sha256": "7d14e070fa140bc86eb88746f6cca83be1c88f1ae9dcaccdd9b3e3140da1200e",
      "after_sha256": "8ce1fc6f949051dc8f237b56952865271e24c0e71efd6d2f21a17981926725e9",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
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
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
