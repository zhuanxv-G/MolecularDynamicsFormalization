# EAUDIT12：第5章§5.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.4-TimeAverage",
  "kind": "definition",
  "label": null,
  "section": "5.4",
  "printed_page": "195",
  "pdf_page": "216",
  "statement_latex": "Given an autonomous system of differential equations $\\dot z=f(z)$ in $\\mathbb R^m$, and a trajectory $\\Gamma=\\{z(t)\\mid t\\in[0,\\infty)\\}$, let $g=g(z)$ be any smooth scalar valued function of $z$ (an observable) and define (assuming it exists) the infinite time average of $g$ along $\\Gamma$ by\n\\[\\bar g_\\Gamma=\\lim_{\\tau\\to\\infty}\\tau^{-1}\\int_0^\\tau g(z(t))dt.\\tag{5.9}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实0..T区间积分；T>0及极限存在意义另条，T=0总化值不赋予平均意义。",
    "原PDF式(5.9)使用 Γ 表示轨道、τ 表示截断时间、ḡ_Γ 表示依赖轨道的平均；Lean 用 z 和 T 表示相应对象。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.timeAverage",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。"
  ],
  "statement_scope": "仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:00:27.167822",
      "before_sha256": "6fc82c38dcd5991add90b39dae3ee0371cfb24a9692acb7a3078691af54ffe3d",
      "after_sha256": "7b8c750bd3f2c5621d88d3e051a4128ee82e394b2b76161b92f93aa5579cfe0b",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

## 原文JSON
```json
{
  "source_id": "MD-5.4-HasTimeAverage",
  "kind": "definition",
  "label": null,
  "section": "5.4",
  "printed_page": "195",
  "pdf_page": "216",
  "statement_latex": "define (assuming it exists) the infinite time average of $g$ along $\\Gamma$ by $\\bar g_\\Gamma=\\lim_{\\tau\\to\\infty}\\tau^{-1}\\int_0^\\tau g(z(t))dt$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实Tendsto atTop；定义未声称所有轨道或所有可观测量必有极限。",
    "原PDF式(5.9)使用 Γ 表示轨道、τ 表示截断时间、ḡ_Γ 表示依赖轨道的平均；Lean 用 z 和 T 表示相应对象。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.hasTimeAverage",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:00:27.167822",
      "before_sha256": "c8a31f2ee8ca2b2bcfd04bf695e1a8bac182ab3566b99d020c95c447524dd1f9",
      "after_sha256": "0c7e958c69cff78f4e6ea9a8a901776292f123b85d6d0a51064ccc4338229cee",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MD.Ch05.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

## 原文JSON
```json
{
  "source_id": "MD-5.4-ConservedAverage",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4",
  "printed_page": "196–197",
  "pdf_page": "217–218",
  "statement_latex": "Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $I=I(z)$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.conservedAverage",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.conservedAverage_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。"
  ],
  "statement_scope": "仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:00:27.167822",
      "before_sha256": "6fd3927d311cea313272eefb3829838f5dd7dc28d361691ae6e7e59485608b3f",
      "after_sha256": "19e5e0d419bf9055dd5b9080e01a07a31fc3ef17c1a02426ba64f46eb59436ba",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem conservedAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ)
    (h : ∀ t,g (z t)=a) (T : ℝ) (hT : T ≠ 0) : MolecularDynamics.Chapter05Review.timeAverage z g T=a := by
  apply MolecularDynamics.Chapter05Review.conservedAverage_proved <;> assumption
```
### 实际依赖 MolecularDynamics.Chapter05Review.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

## 原文JSON
```json
{
  "source_id": "MD-5.4-ConservedInfiniteAverage",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4",
  "printed_page": "196–197",
  "pdf_page": "217–218",
  "statement_latex": "Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $I=I(z)$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留第一积分及任意依赖它的量两个无限平均结论；不只保留有限时间积分。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.conservedInfiniteAverage",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:00:27.167822",
      "before_sha256": "9848fd92290ef4a1d82f52ea0ce6c57e51505fd4f2e53c5c34f28a913004d071",
      "after_sha256": "fdf737e3485af2284363a1b16aa9e58b68a9d246f1a3143bb69c6c0f685eedfb",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem conservedInfiniteAverage {X : Type*} (z : ℝ → X) (I : X → ℝ) (r : ℝ → ℝ)
    (hI : ∀ t,I (z t)=I (z 0)) :
  MolecularDynamics.Chapter05Review.hasTimeAverage z I (I (z 0)) ∧
    MolecularDynamics.Chapter05Review.hasTimeAverage z (r ∘ I) (r (I (z 0))) := by
  have hm (g : X → ℝ) (hg : ∀ t,g (z t)=g (z 0)) :
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) := by
    apply tendsto_congr' _ |>.2 tendsto_const_nhds
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
    exact MolecularDynamics.Chapter05Review.conservedAverage_proved z g (g (z 0)) hg T (ne_of_gt hT)
  exact ⟨hm I hI,hm (r ∘ I) (fun t => by simp only [Function.comp_apply,hI])⟩
```
### 实际依赖 MolecularDynamics.Chapter05Review.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MD.Ch05.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

## 原文JSON
```json
{
  "source_id": "MD-5.4-DoubleWellEnergy",
  "kind": "definition",
  "label": "Example 5.3",
  "section": "5.4",
  "printed_page": "196",
  "pdf_page": "217",
  "statement_latex": "Example 5.3 Consider the double well potential $\\phi(q)=(1-q^2)^2$. The energy $H(q,p)=p^2/2+\\phi(q)$ will tend to $+\\infty$ as $q\\to\\infty$ or $p\\to\\infty$, but is obviously bounded below (by zero).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实二维(q,p)标量能量；非负、紧下水平集与能量面分离性质另外保留。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.doubleWellEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。"
  ],
  "statement_scope": "仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:00:27.167822",
      "before_sha256": "0c4ab3d62e6282d23bcaaf660e9490cff9742226a4a40ffed37409723f2598ad",
      "after_sha256": "024826b63c66dd7ed2f0fcb3cece4fbf14ffdfce13837d1250091b3327019431",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def doubleWellEnergy (z : MolecularDynamics.Chapter05Review.E 2) : ℝ := (z 1)^2/2+(1-(z 0)^2)^2
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.doubleWellEnergy
```lean
def doubleWellEnergy (z : MolecularDynamics.Chapter05Review.E 2) : ℝ := (z 1)^2/2+(1-(z 0)^2)^2
```

## 原文JSON
```json
{
  "source_id": "MD-5.4-DoubleWellBasin",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4",
  "printed_page": "196",
  "pdf_page": "217",
  "statement_latex": "If an initial condition is taken from one of the two basins, say with energy $E_0$, then the trajectory through that point will remain forever in the one basin, thus the averages of many quantities, if computed using the trajectory values, would not be a good approximation of the overall average at constant energy $E_0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.doubleWellBasin",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。",
    "[EXTRA] 保留左右阱不变性，补全局C∞紧支撑观测量的明确见证：它在两个分离能量分支上分别为0/1，时间平均与真实对称微正则空间平均1/2不等；不把平均不等作前提，也不把不连续全局indicator冒充原光滑观测量。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:00:27.167822",
      "before_sha256": "7019cce51d3be57047537b750df34b56f800f156325072ded1a649fc0cdf350e",
      "after_sha256": "99fd1b841721c03b023a1fa3eeeab8844b4bd66f90408fa86654ece1696165cc",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem doubleWellBasin : ∀ (z : ℝ → MolecularDynamics.Chapter05Review.E 2) c,
  Continuous z → c ∈ Ioo (0 : ℝ) 1 → (∀ t,doubleWellEnergy (z t)=c) →
  ∀ t,((z 0) 0 > 0 ∧ (z t) 0 > 0) ∨ ((z 0) 0 < 0 ∧ (z t) 0 < 0) := by
  intro z c hz hc hE t
  let q (s : ℝ) := (z s) 0
  have hq : Continuous q := by dsimp [q]; fun_prop
  have hn (s : ℝ) : q s ≠ 0 := by
    intro heq
    have hh := hE s
    unfold doubleWellEnergy at hh
    change (z s) 0=0 at heq
    rw [heq] at hh
    nlinarith [sq_nonneg ((z s) 1),hc.2]
  by_cases h0 : 0 < q 0
  · left
    refine ⟨h0,?_⟩
    by_contra ht
    have hneg : q t < 0 := lt_of_le_of_ne (le_of_not_gt ht) (hn t)
    obtain ⟨s,hs⟩ := intermediate_value_univ t 0 hq (show (0 : ℝ) ∈ Icc (q t) (q 0) from ⟨hneg.le,h0.le⟩)
    exact hn s hs
  · right
    have hneg : q 0 < 0 := lt_of_le_of_ne (le_of_not_gt h0) (hn 0)
    refine ⟨hneg,?_⟩
    by_contra ht
    have hpos : 0 < q t := lt_of_le_of_ne (le_of_not_gt ht) (Ne.symm (hn t))
    obtain ⟨s,hs⟩ := intermediate_value_univ 0 t hq (show (0 : ℝ) ∈ Icc (q 0) (q t) from ⟨hneg.le,hpos.le⟩)
    exact hn s hs

theorem doubleWellBasin_average_witness (c : ℝ) (_hc : c ∈ Ioo (0 : ℝ) 1)
    (z : ℝ → MolecularDynamics.Chapter05Review.E 2) (_hz : Continuous z)
    (_hE : ∀ t,doubleWellEnergy (z t)=c) :
    ∃ g : MolecularDynamics.Chapter05Review.E 2 → ℝ,ContDiff ℝ ∞ g ∧ HasCompactSupport g ∧
      (∀ x,doubleWellEnergy x=c → g x=if 0 < x 0 then (1 : ℝ) else 0) ∧
      MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g=1/2 ∧
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) ∧
      g (z 0) ≠ MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.energySurface
```lean
def energySurface {n : ℕ} (H : E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter05Review.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.microAverage
```lean
def microAverage {n : ℕ} (H : E n → ℝ) (c : ℝ) (g : E n → ℝ) := average (microMeasure H c) g
```
### 实际依赖 MolecularDynamics.Chapter05Review.microMeasure
```lean
def microMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  ((microRaw H c) univ)⁻¹ • microRaw H c
```
### 实际依赖 MolecularDynamics.Chapter05Review.microRaw
```lean
def microRaw {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖grad H z‖⁻¹))
```
### 实际依赖 MolecularDynamics.Chapter05Review.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (hausdorffArea (n-1)).restrict (energySurface H c)
```
### 实际依赖 MolecularDynamics.Chapter05Review.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.doubleWellEnergy
```lean
def doubleWellEnergy (z : MolecularDynamics.Chapter05Review.E 2) : ℝ := (z 1)^2/2+(1-(z 0)^2)^2
```
### 实际依赖 MD.Ch05.energySurface
```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MD.Ch05.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.microAverage
```lean
def microAverage {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) := MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.microMeasure H c) g
```
### 实际依赖 MD.Ch05.microMeasure
```lean
def microMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c
```
### 实际依赖 MD.Ch05.microRaw
```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```
### 实际依赖 MD.Ch05.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
