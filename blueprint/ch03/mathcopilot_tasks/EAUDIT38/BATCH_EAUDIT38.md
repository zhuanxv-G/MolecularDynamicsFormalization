# EAUDIT38：第3章§3.7.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.7.2-CollisionTimeRelation",
  "kind": "definition",
  "label": "(3.19)",
  "section": "3.7.2",
  "printed_page": "135",
  "pdf_page": "157",
  "statement_latex": "It is then possible to calculate the collision times by solving equations\n\\[\\|Q_i(t)-Q_j(t)\\|=\\sigma_i+\\sigma_j,\\qquad i\\ne j.\\tag{3.19}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "对预先选定的不同粒子索引 i≠j，a(t)=Q_i(t)、b(t)=Q_j(t)、radius=σ_i+σ_j，其中 σ_i、σ_j 为球的核半径，‖·‖为物理空间欧氏范数。",
    "式(3.19)给出接触候选方程；collisionTimeRelation 取其中 t>0 的候选时刻，不编码最小性、根的存在性或横截性。下一碰撞需要从各不同粒子对的候选根中选择最早的合格正根；原页没有单独陈述横截假设。",
    "本批 collisionalVerletRelation 仅给定 tc 后的更新分支；collisionalVerletOrder 另以 g 规定首个正接触根，但没有对该数值根规定横截性。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.collisionTimeRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:32:51.271067",
      "before_sha256": "36d3b3a1aaa579685d6cf77302dc5590c65ebfa147d62407e9c3b27c9936de57",
      "after_sha256": "1c5f5408ad1c60302980bc87d06b0aa8b704b6a640623d65c7a86977113be365",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def collisionTimeRelation {d : ℕ} (a b : ℝ → Position d) (radius t : ℝ) : Prop := 0 < t ∧ ‖a t-b t‖=radius
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch03.collisionTimeRelation
```lean
def collisionTimeRelation {d : ℕ} (a b : ℝ → Position d) (radius t : ℝ) : Prop := 0 < t ∧ ‖a t-b t‖=radius
```

## 原文JSON
```json
{
  "source_id": "MD-3.7.2-CollisionalVerletRelation",
  "kind": "definition",
  "label": null,
  "section": "3.7.2",
  "printed_page": "135",
  "pdf_page": "157",
  "statement_latex": "Collisional Verlet Algorithm (CVA) [Single Step]\n[computes $h$ (the timestep) and $(Q,P)$ given a starting point $(q,p)$]\nCalculate $\\tau_c$ the time of next collision from the Verlet paths (quadratics) of (3.18) using collision conditions (3.19).\nIf $\\tau_c<h_{\\max}$, then\n\\[h:=\\tau_c,\\qquad(Q,P):=R_c\\mathcal G_h^{\\mathrm{Verlet}}(q,p)\\]\nelse\n\\[h:=h_{\\max},\\qquad(Q,P):=\\mathcal G_h^{\\mathrm{Verlet}}(q,p).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际方法关系保持严格tc<hmax；tc=hmax时原算法不反射，随后顺序/资格疑点保留。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "tc=hmax边界时原伪代码不反射，之后的二阶陈述排除此边界，不能冒充一般结果。"
    }
  ],
  "lean_decl": "MD.Ch03.collisionalVerletRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "tc>0,hmax>0明示；tc必须是下一接触时刻，求根实现不是数学定理。",
    "[EXTRA] 保留给定tc/Rc的更新辅助；补实际粒子二次路径、正质量/半径、F=−∇U的对偶资格、不同粒子对的最早真实接触、唯一单碰撞及该接触面的质量加权弹性反射。Option.none明确无正根；严格tc<hmax及等号else照原印保留，不静默修改算法。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:32:51.271067",
      "before_sha256": "c056ea91c0fea84656aaf3a74684b747279cb90d7af814de0601ce26d8a2de6c",
      "after_sha256": "5e40a7efccc458a4e33b62a1189fc87e8865918ee2458509bfce5791e14acaa5",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def collisionalVerletRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (Rc : Z n → Z n)
    (tc hmax h : ℝ) (z w : Z n) : Prop :=
  0 < tc ∧ 0 < hmax ∧ h=min tc hmax ∧
    w=if tc<hmax then Rc (verlet m F h z) else verlet m F h z

def particleQuadraticPath {N d : ℕ} (m : Fin N → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (z : (Fin N → Position d) × (Fin N → Position d)) (t : ℝ) : Fin N → Position d :=
  fun i ↦ z.1 i+(t/m i) • z.2 i+(t^2/(2*m i)) • F z.1 i

def particleVerlet {N d : ℕ} (m : Fin N → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (h : ℝ) (z : (Fin N → Position d) × (Fin N → Position d)) :=
  let P := z.2+(h/2) • F z.1
  let Q := fun i ↦ z.1 i+(h/m i) • P i
  (Q,P+(h/2) • F Q)

def particleReflection {N d : ℕ} (m : Fin N → ℝ) (i j : Fin N)
    (z : (Fin N → Position d) × (Fin N → Position d)) :=
  let u : Fin N → Position d := fun a ↦ if a=i then z.1 i-z.1 j
    else if a=j then z.1 j-z.1 i else 0
  let α := -2*(∑ a, inner ℝ (u a) (z.2 a)/m a)/(∑ a, ‖u a‖^2/m a)
  (z.1,z.2+α • u)

def physicalCVARelation {N d : ℕ} (m σ : Fin N → ℝ)
    (U : (Fin N → Position d) → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (event : Option (ℝ × (Fin N × Fin N))) (hmax h : ℝ)
    (z w : (Fin N → Position d) × (Fin N → Position d)) : Prop :=
  (∀ i, 0 < m i ∧ 0 < σ i) ∧ Differentiable ℝ U ∧
  (∀ q ξ, fderiv ℝ U q ξ = -∑ i, inner ℝ (F q i) (ξ i)) ∧
  (∀ i j, i ≠ j → σ i+σ j ≤ ‖z.1 i-z.1 j‖) ∧ 0 < hmax ∧
  match event with
  | none =>
    (∀ t > 0, ∀ i j, i ≠ j → σ i+σ j <
      ‖particleQuadraticPath m F z t i-particleQuadraticPath m F z t j‖) ∧
    h=hmax ∧ w=particleVerlet m F h z
  | some (tc,(i,j)) =>
    0 < tc ∧ i ≠ j ∧
    ‖particleQuadraticPath m F z tc i-particleQuadraticPath m F z tc j‖=σ i+σ j ∧
    (∀ t ∈ Ioo 0 tc, ∀ a b, a ≠ b → σ a+σ b <
      ‖particleQuadraticPath m F z t a-particleQuadraticPath m F z t b‖) ∧
    (∀ a b, a ≠ b → (a,b) ≠ (i,j) → (a,b) ≠ (j,i) →
      σ a+σ b < ‖particleQuadraticPath m F z tc a-particleQuadraticPath m F z tc b‖) ∧
    h=min tc hmax ∧ w=if tc<hmax then particleReflection m i j (particleVerlet m F h z)
      else particleVerlet m F h z
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MD.Ch03.collisionalVerletRelation
```lean
def collisionalVerletRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (Rc : Z n → Z n)
    (tc hmax h : ℝ) (z w : Z n) : Prop :=
  0 < tc ∧ 0 < hmax ∧ h=min tc hmax ∧
    w=if tc<hmax then Rc (verlet m F h z) else verlet m F h z
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MD.Ch03.particleQuadraticPath
```lean
def particleQuadraticPath {N d : ℕ} (m : Fin N → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (z : (Fin N → Position d) × (Fin N → Position d)) (t : ℝ) : Fin N → Position d :=
  fun i ↦ z.1 i+(t/m i) • z.2 i+(t^2/(2*m i)) • F z.1 i
```
### 实际依赖 MD.Ch03.particleReflection
```lean
def particleReflection {N d : ℕ} (m : Fin N → ℝ) (i j : Fin N)
    (z : (Fin N → Position d) × (Fin N → Position d)) :=
  let u : Fin N → Position d := fun a ↦ if a=i then z.1 i-z.1 j
    else if a=j then z.1 j-z.1 i else 0
  let α := -2*(∑ a, inner ℝ (u a) (z.2 a)/m a)/(∑ a, ‖u a‖^2/m a)
  (z.1,z.2+α • u)
```
### 实际依赖 MD.Ch03.particleVerlet
```lean
def particleVerlet {N d : ℕ} (m : Fin N → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (h : ℝ) (z : (Fin N → Position d) × (Fin N → Position d)) :=
  let P := z.2+(h/2) • F z.1
  let Q := fun i ↦ z.1 i+(h/m i) • P i
  (Q,P+(h/2) • F Q)
```
### 实际依赖 MD.Ch03.physicalCVARelation
```lean
def physicalCVARelation {N d : ℕ} (m σ : Fin N → ℝ)
    (U : (Fin N → Position d) → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (event : Option (ℝ × (Fin N × Fin N))) (hmax h : ℝ)
    (z w : (Fin N → Position d) × (Fin N → Position d)) : Prop :=
  (∀ i, 0 < m i ∧ 0 < σ i) ∧ Differentiable ℝ U ∧
  (∀ q ξ, fderiv ℝ U q ξ = -∑ i, inner ℝ (F q i) (ξ i)) ∧
  (∀ i j, i ≠ j → σ i+σ j ≤ ‖z.1 i-z.1 j‖) ∧ 0 < hmax ∧
  match event with
  | none =>
    (∀ t > 0, ∀ i j, i ≠ j → σ i+σ j <
      ‖particleQuadraticPath m F z t i-particleQuadraticPath m F z t j‖) ∧
    h=hmax ∧ w=particleVerlet m F h z
  | some (tc,(i,j)) =>
    0 < tc ∧ i ≠ j ∧
    ‖particleQuadraticPath m F z tc i-particleQuadraticPath m F z tc j‖=σ i+σ j ∧
    (∀ t ∈ Ioo 0 tc, ∀ a b, a ≠ b → σ a+σ b <
      ‖particleQuadraticPath m F z t a-particleQuadraticPath m F z t b‖) ∧
    (∀ a b, a ≠ b → (a,b) ≠ (i,j) → (a,b) ≠ (j,i) →
      σ a+σ b < ‖particleQuadraticPath m F z tc a-particleQuadraticPath m F z tc b‖) ∧
    h=min tc hmax ∧ w=if tc<hmax then particleReflection m i j (particleVerlet m F h z)
      else particleVerlet m F h z
```
### 实际依赖 MolecularDynamics.Chapter02Review.verlet
```lean
def verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
```
