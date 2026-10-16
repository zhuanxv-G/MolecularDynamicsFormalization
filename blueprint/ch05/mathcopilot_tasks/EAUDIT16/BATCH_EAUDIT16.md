# EAUDIT16：第5章§5.4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-CurveImageDimension",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "202",
  "pdf_page": "223",
  "statement_latex": "The segment of initial conditions, a one-dimensional object, when transformed by the smooth map defined by solving initial value problems, should result, again, in a one-dimensional object, i.e. a curve. Yet it appears also to provide a dense covering of a two-dimensional region in the position projection.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.curveImageDimension",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原“one-dimensional”以实际正则参数曲线及全平滑自治流实现；由群律推出可逆场导数而非假设最终像曲线正则。位置投影未必浸入，且有限时刻的曲线本身不是一般二维开集；视觉稠密覆盖仅作为数值观察保留。",
    "[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:11:44.974098",
      "before_sha256": "f8d7b37835044307945ee600ff2d7df02b41e9f94000f0aa8912a1b8965c14a2",
      "after_sha256": "08d16d25867b87917ec53588f71b2d3c36fc01b3dc2b36963e6fc9102a2360b2",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT16/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem curveImageDimension : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (γ : ℝ → MolecularDynamics.Chapter05Review.E n),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ ∞ (Function.uncurry Φ) → ContDiff ℝ ∞ γ →
  (∀ s,deriv γ s ≠ 0) → ∀ t,
  ContDiff ℝ ∞ (fun s => Φ t (γ s)) ∧ (∀ s,deriv (fun r => Φ t (γ r)) s ≠ 0) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-PendulumPotential",
  "kind": "definition",
  "label": "Example 5.5",
  "section": "5.4.1",
  "printed_page": "200",
  "pdf_page": "221",
  "statement_latex": "Example 5.5 (Double Pendulum) To explore some of the issues related to ergodicity, let us return to the double pendulum considered in Chap. 3.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条为第5章引用的第3章双弹簧对象的本地定义；不改变第3章文件。",
    "q=(x,y)，两固定端为(0,0)、(0,−2)，r₁=√(x²+y²)，r₂=√(x²+(y+2)²)，k_i 为弹簧系数、l_i 为自然长度，物理情形均为正。",
    "U(q)=k₁(r₁−l₁)²/2+k₂(r₂−l₂)²/2；公式回指教材 PDF148/印刷126。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.pendulumPotential",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]引用的真实双弹簧势按§3.5印刷126/PDF148已存在原页核对：U=k₁(r₁−l₁)²/2+k₂(r₂−l₂)²/2，r₁=√(x²+y²)、r₂=√(x²+(y+2)²)；不是把数值轨迹图当势的定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:11:44.974098",
      "before_sha256": "a427f739a4b25b2f783774040898c3f3ebdba886b4120c763add9f3479130dd4",
      "after_sha256": "9c8f22efdb5d02db0053ad760f63b164b1d5e74c0f642285b78ac950811acb6b",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT16/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def pendulumPotential (k₁ k₂ l₁ l₂ : ℝ) (q : MolecularDynamics.Chapter05Review.E 2) :=
  k₁/2*(Real.sqrt ((q 0)^2+(q 1)^2)-l₁)^2+
    k₂/2*(Real.sqrt ((q 0)^2+(q 1+2)^2)-l₂)^2
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.pendulumPotential
```lean
def pendulumPotential (k₁ k₂ l₁ l₂ : ℝ) (q : MolecularDynamics.Chapter05Review.E 2) :=
  k₁/2*(Real.sqrt ((q 0)^2+(q 1)^2)-l₁)^2+
    k₂/2*(Real.sqrt ((q 0)^2+(q 1+2)^2)-l₂)^2
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-CircleInitialPoints",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "202",
  "pdf_page": "223",
  "statement_latex": "Now consider an alternative initial set. Begin, as before, with a line segment on the $x$-axis, but now choose the initial momenta from the uniform distribution on the circle $p_x^2+p_y^2=2(E_0-U(x,0))$. In this way we again get initial conditions on the $H=E_0$ energy surface, but this time the points are not close to one another in phase space, since the momenta of successive points may differ greatly.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际动量圆的角参数化；根号非负时对应书中圆，半径0允许退化点，均匀角概率推送另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.circleInitialPoints",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 将实际初值域限定可行能量及原x区间；θ为后条均匀角分布的取样变量，定性样本图像不强化为全样本必然分离。零半径为允许退化；总延拓仅作独立辅助定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:11:44.974098",
      "before_sha256": "adab45a28d2a7f9629cde36aec7b04323422a3dcf04bb6d16785c2cd632f2cdc",
      "after_sha256": "e4d3129a3897690e414faa695fdbd947b4472829f7b0e42cfbb6d3c5b7021d6e",
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
def circleInitialPoints (κ l ε c x θ : ℝ)
    (_hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (_hx : x ∈ Icc (105/100 : ℝ) (115/100)) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])

def circleInitialPoints_total (κ l ε c x θ : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])
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
### 实际依赖 MD.Ch05.circleInitialPoints
```lean
def circleInitialPoints (κ l ε c x θ : ℝ)
    (_hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (_hx : x ∈ Icc (105/100 : ℝ) (115/100)) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])
```
### 实际依赖 MD.Ch05.circleInitialPoints_total
```lean
def circleInitialPoints_total (κ l ε c x θ : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])
```

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
