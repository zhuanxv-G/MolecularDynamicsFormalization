# EAUDIT57：第5章§5.4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-CircleInitialLaw",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "202",
  "pdf_page": "223",
  "statement_latex": "choose the initial momenta from the uniform distribution on the circle $p_x^2+p_y^2=2(E_0-U(x,0))$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.circleInitialLaw",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。",
    "[EXTRA] 均匀圆概率主接口限定可行能量和原x区间，使用归一化角测度推前；c=U为退化Dirac，不默认负能差的sqrt总化初值。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:11:44.974098",
      "before_sha256": "292afd0627d47d88f3926fa3fe674ad2ebd33954ab5ebd0c6d2ed974e3b32687",
      "after_sha256": "1ecf9d4ae739c26820c064b6008b38c3bf44ad9d81edf1d954e677a07b9e317f",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT16/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def circleInitialLaw (κ l ε c x : ℝ)
    (hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (hx : x ∈ Icc (105/100 : ℝ) (115/100)) : Measure (MolecularDynamics.Chapter05Review.Phase 2) :=
  Measure.map (fun θ ↦ circleInitialPoints κ l ε c x θ hfeas hx)
    ((ENNReal.ofReal (2*Real.pi))⁻¹ • (volume.restrict (Ioc (0 : ℝ) (2*Real.pi))))
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicEnergy
```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.Phase
```lean
abbrev Phase (n : ℕ) := E n × E n
```
### 实际依赖 MolecularDynamics.Chapter05Review.Phase
```lean
abbrev Phase (n : ℕ) := E n × E n
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicAngular
```lean
def anisotropicAngular (x y : ℝ) :=
  let c := x/Real.sqrt (x^2+y^2)
  4*c^3-3*c
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicEnergy
```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicParameters
```lean
def anisotropicParameters (κ₀ l₀ ε c₃ : ℝ) : ℝ × ℝ :=
  (κ₀*(1-ε*c₃/2),l₀*(1+ε*c₃/2))
```
### 实际依赖 MD.Ch05.anisotropicPotential
```lean
def anisotropicPotential (κ l ε : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :=
  MolecularDynamics.Chapter01Review.anisotropicEnergy κ l ε (z 0) (z 1) 0 0
```
### 实际依赖 MD.Ch05.circleInitialLaw
```lean
def circleInitialLaw (κ l ε c x : ℝ)
    (hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (hx : x ∈ Icc (105/100 : ℝ) (115/100)) : Measure (MolecularDynamics.Chapter05Review.Phase 2) :=
  Measure.map (fun θ ↦ circleInitialPoints κ l ε c x θ hfeas hx)
    ((ENNReal.ofReal (2*Real.pi))⁻¹ • (volume.restrict (Ioc (0 : ℝ) (2*Real.pi))))
```
### 实际依赖 MD.Ch05.circleInitialPoints
```lean
def circleInitialPoints (κ l ε c x θ : ℝ)
    (_hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (_hx : x ∈ Icc (105/100 : ℝ) (115/100)) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-CircleInitialEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "202",
  "pdf_page": "223",
  "statement_latex": "In this way we again get initial conditions on the $H=E_0$ energy surface.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.circleInitialEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。",
    "[EXTRA] 原能量恒等式保留为正式库总延拓的辅助证明；本条适用前提仍是非负能差，实际取样主接口由CircleInitialPoints/Law限定区间及可行域。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:11:44.974098",
      "before_sha256": "eb6cda603046bb1c7f9ae602cfd0a6954e8026ebfe8a6d42776462a865db1957",
      "after_sha256": "8510eb5cc3ba09d3103caf1c9b2aca0432f23467af85cdca898b7761f65e36d7",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT16/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem circleInitialEnergy : ∀ κ l ε c x θ : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := circleInitialPoints_total κ l ε c x θ
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicEnergy
```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.Phase
```lean
abbrev Phase (n : ℕ) := E n × E n
```
### 实际依赖 MolecularDynamics.Chapter05Review.Phase
```lean
abbrev Phase (n : ℕ) := E n × E n
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicAngular
```lean
def anisotropicAngular (x y : ℝ) :=
  let c := x/Real.sqrt (x^2+y^2)
  4*c^3-3*c
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicEnergy
```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicParameters
```lean
def anisotropicParameters (κ₀ l₀ ε c₃ : ℝ) : ℝ × ℝ :=
  (κ₀*(1-ε*c₃/2),l₀*(1+ε*c₃/2))
```
### 实际依赖 MD.Ch05.anisotropicPotential
```lean
def anisotropicPotential (κ l ε : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :=
  MolecularDynamics.Chapter01Review.anisotropicEnergy κ l ε (z 0) (z 1) 0 0
```
### 实际依赖 MD.Ch05.circleInitialPoints_total
```lean
def circleInitialPoints_total (κ l ε c x θ : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])
```
