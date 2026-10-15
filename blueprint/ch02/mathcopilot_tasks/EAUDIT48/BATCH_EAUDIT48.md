# EAUDIT48：第2章§2.5.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.5.4-MultiTaylor",
  "kind": "definition",
  "label": null,
  "section": "2.5.4",
  "printed_page": "92",
  "pdf_page": "114",
  "statement_latex": "we may approximate a single step by\n\\[\\boldsymbol z_{n+1}=\\boldsymbol z_n+h\\dot{\\boldsymbol z}_n+\\frac{h^2}{2}\\ddot{\\boldsymbol z}_n+\\cdots+\\frac{h^k}{k!}\\boldsymbol z_n^{(k)},\\]\nwhere it is possible to make use of higher order derivatives of the solution in formulating the method. Then using the differential equation, the time derivatives may be replaced by elementary differentials of the vector field.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文 z_n 为当前步的状态，h 为步长，k 为截断阶数；点号及 z_n^{(j)} 表示解在当前时刻的时间导数。将公式写成导数数据求和时，须解释 d(0)=z_n、d(j)=z^{(j)}(t_n)，j=1,…,k。原文说明可由微分方程把时间导数替换为向量场的 elementary differentials；此处没有给出误差阶定理。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_multiTaylor",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:32:38.314404",
      "before_sha256": "247780ef9a73237bb9338b5723d6a304f72cdde596d14e0006e139ec2b746792",
      "after_sha256": "59a91d2e52e0dac91043502822730f71ee78860164e8f070223bc86c344d7abf",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH31_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bp_multiTaylor {n : ℕ} (d : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  ∑ j ∈ Finset.range (k+1), (h^j / (Nat.factorial j : ℝ)) • d j
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch02.bp_multiTaylor
```lean
def bp_multiTaylor {n : ℕ} (d : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  ∑ j ∈ Finset.range (k+1), (h^j / (Nat.factorial j : ℝ)) • d j
```

## 原文JSON
```json
{
  "source_id": "MD-2.5.4-TIPotential",
  "kind": "definition",
  "label": null,
  "section": "2.5.4",
  "printed_page": "92–93",
  "pdf_page": "114–115",
  "statement_latex": "the Takahashi-Imada method [355] (also known as Rowlands’ method [316]) has the same form as the Verlet method\n\\[\\hat{\\boldsymbol P}=\\boldsymbol p-(h/2)\\nabla\\tilde U(\\boldsymbol q),\\quad\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\hat{\\boldsymbol P},\\quad\\boldsymbol P=\\hat{\\boldsymbol P}-(h/2)\\nabla\\tilde U(\\boldsymbol Q),\\]\nwhere the corresponding potential energy function is\n\\[\\tilde U(\\boldsymbol q)=U(\\boldsymbol q)-\\frac{h^2}{24}\\nabla U(\\boldsymbol q)^TM^{-1}\\nabla U(\\boldsymbol q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文所在机械系统的 Hamiltonian 为 H(q,p)=p^T M^{-1}p/2+U(q)（PDF114，印刷92页）；q、Q 为位置，p、P 为动量，hat(P) 为半步动量，h 为步长，M 为质量矩阵，tilde(U) 为所展示的改势。",
    "PDF115（印刷93页）的改势字面为 U−(h²/24)∇U^T M^{-1}∇U；紧接其后的力式写为 −[I+(h²/12)U''M^{-1}]∇U，两式存在符号冲突，保留原文，不在本条静默改号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.tiMethod",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:32:38.314404",
      "before_sha256": "f71e4daf65ad035d0aeb7207a14e3f8b7fc7775ab50d95398a3755a3fcad6278",
      "after_sha256": "1364161c355dd28b82e02b6a8f185a5bee068b4664bc382cb89ffa7df9dff15d",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH31_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def tiMethod {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : Z n → Z n :=
  verlet m (fun q => -grad (takahashiPotential m U h) q) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.takahashiPotential
```lean
def takahashiPotential {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (q : Q n) : ℝ :=
  U q - h^2/24 * ∑ i, (grad U q i)^2 / m i
```
### 实际依赖 MD.Ch02.tiMethod
```lean
def tiMethod {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : Z n → Z n :=
  verlet m (fun q => -grad (takahashiPotential m U h) q) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.verlet
```lean
def verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
```
