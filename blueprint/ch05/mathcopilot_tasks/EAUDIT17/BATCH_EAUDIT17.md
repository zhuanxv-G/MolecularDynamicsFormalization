# EAUDIT17：第5章§5.5网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.5-Correlation",
  "kind": "definition",
  "label": null,
  "section": "5.5",
  "printed_page": "203",
  "pdf_page": "224",
  "statement_latex": "Let $a$ and $b$ be mappings from the phase space to the same Euclidean space, and define the temporal correlation of $a$ and $b$ (on the surface of energy $E$) by\n\\[C_{ab}(\\tau)\\stackrel{\\rm def}{=}k\\operatorname{Av}_{H=E}(a(\\mathcal F_t(z))\\cdot b(z))\n=kZ_E^{-1}\\int_{\\Sigma_E}a(\\mathcal F_t(z))\\cdot b(z)\\delta[H-E]d\\omega,\\]\nwhere $k$ is a normalization constant that is often incorporated to ensure that $C_{ab}(0)=1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实向量内积与µ积分；原左τ右t记号保留、Lean用单个lag参数；k只在零lag非零时能归一。δ积分解释为真实微正则测度配对。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.correlation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:12:25.337909",
      "before_sha256": "843180caf62584a602f05b76853dd503b07db2ff0e1277b08bba8daa28a5eba2",
      "after_sha256": "b0e7d84d451ac23a515ea50386e17290e1043474dad0c07b550624b3e8758f8a",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def correlation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.correlation
```lean
def correlation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
```

## 原文JSON
```json
{
  "source_id": "MD-5.5-CorrelationTimeAE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "204",
  "pdf_page": "225",
  "statement_latex": "If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $H=E$ energy surface:\n\\[C_{a,b}(t)=k\\lim_{\\tau\\to\\infty}\\frac1\\tau\\int_0^{\\tau} a(z(s+t))\\cdot b(z(s))ds.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原书字面为any trajectory；本条Lean是明确的几乎处处修订版，不可将AE当作逐字原文。对每个给定t有AE集合，未断言同一满测集同时适用所有t。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.correlationTime",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:12:25.337909",
      "before_sha256": "e5b0bda8269eee8e13e48a9f0874b4c20e855d97aeaf7ee9ebe5d2216bac0b27",
      "after_sha256": "74ac292cf095d33d99c99325620b7578fe0663fb941b2b69ab48ac138ce47517",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem correlationTime :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun s => Φ s z) g (MolecularDynamics.Chapter05Review.average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation μ Φ a b k t)) := by
  intro n d μ Φ a b k t h0 hg he hi
  filter_upwards [he (fun z => inner ℝ (a (Φ t z)) (b z)) hi] with z hz
  unfold MolecularDynamics.Chapter05Review.hasTimeAverage MolecularDynamics.Chapter05Review.timeAverage at hz
  have hh := hz.const_mul k
  have ht (s : ℝ) : Φ (s+t) z=Φ t (Φ s z) := by rw [add_comm,hg]
  simpa only [MolecularDynamics.Chapter05Review.average,MolecularDynamics.Chapter05Review.correlation,ht,mul_assoc] using hh
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
### 实际依赖 MolecularDynamics.Chapter05Review.correlation
```lean
def correlation {n d : ℕ} (μ : Measure (E n)) (Φ : ℝ → E n → E n)
    (a b : E n → E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
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
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.correlation
```lean
def correlation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
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
  "source_id": "MD-5.5-PositionTransition",
  "kind": "definition",
  "label": null,
  "section": "5.5",
  "printed_page": "204",
  "pdf_page": "225",
  "statement_latex": "Now let $A$ and $B$ be subsets of configuration space (i.e. subsets in the position space) of nonzero measure, and define $T_{AB}(\\tau)\\stackrel{\\rm def}{=}C_{1_B,1_A}(\\tau)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "π是实际位置投影，配置集合在相空间上的逆像；真实指标乘积平均，不把状态点概率误作首次到达时间。",
    "原T_AB=C_{1_B,1_A}继承C定义的k；当前Lean无k，仅对应k=1。随后概率公式暗示未归一化指标相关，应公开该解释，不能默认为逐字相同。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.positionTransition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 恢复相关定义中完整归一化常数k，原k=1未归一化概率计数作为明确实例；位置投影及两个indicator积分均保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:12:25.337909",
      "before_sha256": "481fe546111d291d2900febed8892dc56823d0fdaed3f90668bdaee58a094896",
      "after_sha256": "8a509ba2a289dae0102da9ffda473929823695b6d77f3dec9745120d21c16209",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def positionTransition {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (π : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (A B : Set (MolecularDynamics.Chapter05Review.E d)) (k t : ℝ) :=
  k*
  (∫ z,((B.indicator (fun _ => (1 : ℝ))) (π (Φ t z)))*
    ((A.indicator (fun _ => (1 : ℝ))) (π z)) ∂μ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.positionTransition
```lean
def positionTransition {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (π : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (A B : Set (MolecularDynamics.Chapter05Review.E d)) (k t : ℝ) :=
  k*
  (∫ z,((B.indicator (fun _ => (1 : ℝ))) (π (Φ t z)))*
    ((A.indicator (fun _ => (1 : ℝ))) (π z)) ∂μ)
```

## 原文JSON
```json
{
  "source_id": "MD-5.5-MeasureDuality",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "205",
  "pdf_page": "226",
  "statement_latex": "\\[\\int_{\\Sigma_E}\\phi(z)\\rho(z;t)d\\omega\n=\\int_{\\Sigma_E}\\phi(z)e^{t\\mathcal L^\\dagger}\\rho(z,0)d\\omega\n=\\int_{\\Sigma_E}[e^{t\\mathcal L}\\phi(z)]\\rho(z,0)d\\omega\n=\\int_{\\Sigma_E}\\phi(\\mathcal F_t(z))\\rho(z,0)d\\omega\n=\\int_{\\Sigma_E}\\phi(\\mathcal F_t(z))\\frac{\\rho(z,0)}{\\rho_E(z)}\\rho_E(z)d\\omega.\\tag{5.10}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.measureDuality",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。",
    "[EXTRA] 保留推前对偶已有证明，补参考概率ν上的非负RN密度r、初始withDensity、演化Measure.map与全部加权配对链；公开ρ/ρ_E的RN解释，不对奇异δ作函数相除。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:12:25.337909",
      "before_sha256": "da2d37934e10d51e12e127abc50ee4f03ae7d349da4fa93f326bf508c3d53e73",
      "after_sha256": "7686dc288fa58c0bb87ce8138afac385b9d96c59a141db44d5d5ecbaf9cdd09d",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem measureDuality :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (φ : MolecularDynamics.Chapter05Review.E n → ℝ) t,
  Measurable (Φ t) → Integrable φ (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) →
    MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) φ=MolecularDynamics.Chapter05Review.average μ (MolecularDynamics.Chapter05Review.pullback Φ φ t) := by
  intro n μ Φ φ t hm hi
  exact integral_map hm.aemeasurable hi.aestronglyMeasurable

theorem measureDuality_RN (n : ℕ)
    (ν : Measure (MolecularDynamics.Chapter05Review.E n)) (_hν : IsProbabilityMeasure ν)
    (r : MolecularDynamics.Chapter05Review.E n → ℝ) (_hr : Integrable r ν)
    (_hrpos : ∀ z,0 ≤ r z) (_hrmass : (∫ z,r z ∂ν)=1)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (t : ℝ) (_hΦ : Measurable (Φ t))
    (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (_hc : Continuous φ)
    (_hb : Bornology.IsBounded (range φ)) :
    let μ₀ := ν.withDensity (fun z ↦ ENNReal.ofReal (r z))
    MolecularDynamics.Chapter05Review.average (Measure.map (Φ t) μ₀) φ=
      MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t) ∧
    MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t)=
      ∫ z,φ (Φ t z)*r z ∂ν := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.measurePropagator
```lean
def measurePropagator {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.pullback
```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MD.Ch05.measurePropagator
```lean
def measurePropagator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) := Measure.map (Φ t) μ
```
### 实际依赖 MD.Ch05.pullback
```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```

## 原文JSON
```json
{
  "source_id": "MD-5.5-MixingMemoryLoss",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "205",
  "pdf_page": "226",
  "statement_latex": "We assume $\\psi(z)\\stackrel{\\rm def}{=}\\rho(z;0)/\\rho_E(z)$ is bounded on $\\Sigma_E$, and moreover $\\operatorname{Av}_{H=E}(\\psi)=\\int_{\\Sigma_E}\\frac{\\rho(z;0)}{\\rho_E(z)}\\rho_E(z)\\,d\\omega=1$ (i.e., the initial density is a probability density on the energy surface), and that the system is mixing. Then the integral (5.10) is well defined and we may view it as a two-point correlation function of $\\phi$ and $\\psi$. By the mixing property it must converge to $\\int_{\\Sigma_E}\\phi(z)\\rho_Ed\\omega$, thus the average value of $\\phi$ is ultimately independent of the initial conditions. We have\n\\[\\lim_{t\\to\\infty}\\int_{\\Sigma_E}\\phi(\\mathcal F_t(z))(\\psi(z)-1)\\rho_Ed\\omega=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "\\Sigma_E=\\{z:H(z)=E\\}; \\mathcal F_t 为动力学流。",
    "\\operatorname{Av}_{H=E}(g)=\\int_{\\Sigma_E}g(z)\\rho_E(z)\\,d\\omega；\\rho_E\\,d\\omega为参考微正则概率测度。",
    "C_{ab}(t)=k\\operatorname{Av}_{H=E}(a(\\mathcal F_t(z))\\cdot b(z))；a,b取值于同一Euclidean空间，k为归一化常数（PDF224–225）。",
    "\\psi(z)\\stackrel{\\rm def}{=}\\rho(z;0)/\\rho_E(z)；Lean中的β对应原书ψ；对奇异能量面参考测度，应理解为相对密度。",
    "(5.10): \\int_{\\Sigma_E}\\phi(z)\\rho(z;t)d\\omega=\\int_{\\Sigma_E}\\phi(\\mathcal F_t(z))\\rho(z;0)d\\omega=\\int_{\\Sigma_E}\\phi(\\mathcal F_t(z))\\psi(z)\\rho_E(z)d\\omega。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.mixingMemoryLoss",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。",
    "[EXTRA] 对应补足资格后的weakMixing取第二合取，保持既有证明及原结论；不增加新证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:12:25.337909",
      "before_sha256": "833989a1958c9fbfcff2d534b2e73052d5738fac4ee87b579d0210988128e9c1",
      "after_sha256": "479eaa61bc831271549dd3e69fffeb9d196b4a33f02c837e7a8fbdf4a10fbeae",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem mixingMemoryLoss : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (β φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  IsProbabilityMeasure μ → weakMixing μ Φ → Integrable β μ → Bornology.IsBounded (range β) → (∀ z,0 ≤ β z) →
  (∫ z,β z ∂μ)=1 → Continuous φ → Bornology.IsBounded (range φ) →
  (∀ t,MeasurePreserving (Φ t) μ μ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*(β z-1) ∂μ) atTop (𝓝 0) := by
  intro n μ Φ β φ hμ hm hβ hβbound hβpos hβmass hφ hb hΦ
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hi : Integrable φ μ := Integrable.mono' (integrable_const C)
    hφ.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (φ z) (mem_range_self z)))
  have he (t : ℝ) : (∫ z,φ (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ φ := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable φ (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact hi.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have hp (t : ℝ) : Integrable (fun z => φ (Φ t z)*β z) μ :=
    hβ.bdd_mul (hφ.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hB (φ (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : (∫ z,φ (Φ t z)*(β z-1) ∂μ)=
      (∫ z,φ (Φ t z)*β z ∂μ)-MolecularDynamics.Chapter05Review.average μ φ := by
    simp_rw [mul_sub,mul_one]
    have hip : Integrable (fun z => φ (Φ t z)) μ := by
      simpa only [Function.comp_def] using (hΦ t).integrable_comp_of_integrable hi
    rw [integral_sub (hp t) hip,he]
  simp_rw [heq]
  simpa only [sub_self] using (hm.2 β φ hβ hβpos hβmass hφ hb).sub (tendsto_const_nhds : Tendsto (fun _ : ℝ => MolecularDynamics.Chapter05Review.average μ φ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ)))
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
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.weakMixing
```lean
def weakMixing {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (IsProbabilityMeasure μ ∧ (∀ z,Φ 0 z=z) ∧
    (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) ∧ Measurable (Function.uncurry Φ)) ∧
  ∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
  Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))
```

## 原文JSON
```json
{
  "source_id": "MD-5.5-MixingCorrelation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "205",
  "pdf_page": "226",
  "statement_latex": "$\\lim_{t\\to\\infty}C_{ab}(t)=\\operatorname{Av}_{H=E}(a)\\operatorname{Av}_{H=E}(b)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "\\Sigma_E=\\{z:H(z)=E\\}; \\mathcal F_t 为动力学流。",
    "\\operatorname{Av}_{H=E}(g)=\\int_{\\Sigma_E}g(z)\\rho_E(z)\\,d\\omega；\\rho_E\\,d\\omega为参考微正则概率测度。",
    "C_{ab}(t)=k\\operatorname{Av}_{H=E}(a(\\mathcal F_t(z))\\cdot b(z))；a,b取值于同一Euclidean空间，k为归一化常数（PDF224–225）。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.mixingCorrelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]独立修正版右侧保留k，实际AC概率初值的弱mixing条件及有界连续a/b；原参考微正则分布的不变资格明确为MeasurePreserving，保障各时积分可积和常数项不变。未以目标相关极限作假设。",
    "[EXTRA] 修订版扩至任意有限维向量观测量并以Bochner均值及inner表达完整k相关极限；保留原标量证明为辅助，新向量结论暂sorry，原漏k版本单列待导师。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:12:25.337909",
      "before_sha256": "c63baa427b12c7a546b5381271a37c8cef0ee6cd39f771b8f506f4877d4eb99d",
      "after_sha256": "039d6a6bcf6ef7d14129adacf50d3d3d7ddce296980e886fe04b9b11155007bc",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem mixingCorrelation :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)) atTop (𝓝 (k*inner ℝ (∫ z,a z ∂μ) (∫ z,b z ∂μ))) := by
  sorry

theorem mixingCorrelation_scalar :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b)) := by
  intro n μ Φ a b k hμ hΦ hm ha hb hba hbb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hbb.exists_pos_norm_le
  obtain ⟨R,hR,hA⟩ := hba.exists_pos_norm_le
  have ib : Integrable b μ := Integrable.mono' (integrable_const C)
    hb.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (b z) (mem_range_self z)))
  have ia : Integrable a μ := Integrable.mono' (integrable_const R)
    ha.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hA (a z) (mem_range_self z)))
  have ibound : |∫ z,b z ∂μ| ≤ C := by
    simpa only [Real.norm_eq_abs,probReal_univ,mul_one] using
      norm_integral_le_of_norm_le_const (ae_of_all μ (fun z => hB (b z) (mem_range_self z)))
  let D := C+1
  let M := (∫ z,b z ∂μ)+D
  have hM : 0 < M := by dsimp [M,D];linarith [neg_le_of_abs_le ibound]
  let r (z) := (b z+D)/M
  have ir : Integrable r μ := (ib.add (integrable_const D)).div_const M
  have rpos (z) : 0 ≤ r z := by
    have hx : |b z| ≤ C := by simpa only [Real.norm_eq_abs] using hB (b z) (mem_range_self z)
    dsimp [r,D]
    apply div_nonneg _ hM.le
    linarith [neg_le_of_abs_le hx]
  have rmass : (∫ z,r z ∂μ)=1 := by
    dsimp [r]
    rw [integral_div,integral_add ib (integrable_const D)]
    simp [integral_const,M,ne_of_gt hM]
  have ht := hm r a ir rpos rmass ha hba
  have iap (t : ℝ) : Integrable (fun z => a (Φ t z)) μ :=
    (hΦ t).integrable_comp_of_integrable ia
  have ie (t : ℝ) : (∫ z,a (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ a := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable a (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact ia.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have ipr (t : ℝ) : Integrable (fun z => a (Φ t z)*r z) μ :=
    ir.bdd_mul (ha.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hA (a (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : M*(∫ z,a (Φ t z)*r z ∂μ)-D*MolecularDynamics.Chapter05Review.average μ a=
      (∫ z,a (Φ t z)*b z ∂μ) := by
    rw [←ie t,←integral_const_mul,←integral_const_mul,
      ←integral_sub ((ipr t).const_mul M) ((iap t).const_mul D)]
    apply integral_congr_ae
    filter_upwards [] with z
    dsimp [r]
    field_simp [ne_of_gt hM] <;> ring
  have hh := (ht.const_mul M).sub (tendsto_const_nhds : Tendsto
    (fun _ : ℝ => D*MolecularDynamics.Chapter05Review.average μ a) atTop
    (𝓝 (D*MolecularDynamics.Chapter05Review.average μ a)))
  simp_rw [heq] at hh
  convert hh.const_mul k using 1
  unfold MolecularDynamics.Chapter05Review.average
  dsimp [M]
  ring
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
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
