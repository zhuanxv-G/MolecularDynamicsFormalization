# EAUDIT18：第1章§1.6网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.6-HCPStacking",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "36",
  "pdf_page": "59",
  "statement_latex": "Also shown in Fig. 1.18 is the hcp lattice, which, on the other hand, alternates two distinct planar lattices.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hcpStacking",
  "extra_assumptions": [
    "图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。"
  ],
  "old_ids": [
    "CH01-165"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def hcpStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 2
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.hcpStacking
```lean
def hcpStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 2
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```
### 实际依赖 MolecularDynamics.Chapter01Review.triangularLayer
```lean
def triangularLayer (u v : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k+l/2+u,l*Real.sqrt 3/2+v]}
```
