# EAUDIT14：第5章§5.4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-HarmonicFlow",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198–199",
  "pdf_page": "219–220",
  "statement_latex": "As a very simple example, the harmonic oscillator is always ergodic on its energy surfaces (i.e. energy curves, in this case).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.harmonicFlow",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实解析振子流，用于完整遍历命题；Ω>0使用资格另条。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。"
  ],
  "statement_scope": "仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:37.070895",
      "before_sha256": "6c39216b29aca6e3b47a219733d4e5d6361a73120aa122eceebc549820b92b5b",
      "after_sha256": "fdca99dea8db9d84d40836a2fb27187ab24fe273829ebd13cfc97cc7a558a3f8",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def harmonicFlow (Ω t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω*t)+z 1/Ω*Real.sin (Ω*t),
    z 1*Real.cos (Ω*t)-Ω*z 0*Real.sin (Ω*t)]
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.harmonicFlow
```lean
def harmonicFlow (Ω t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω*t)+z 1/Ω*Real.sin (Ω*t),
    z 1*Real.cos (Ω*t)-Ω*z 0*Real.sin (Ω*t)]
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-TwoOscillatorEnergy",
  "kind": "definition",
  "label": "Example 5.4",
  "section": "5.4.1",
  "printed_page": "198–199",
  "pdf_page": "219–220",
  "statement_latex": "Example 5.4 (2D Harmonic System) Consider a two-dimensional harmonic system, i.e. the system with Hamiltonian\n\\[H=p_1^2/2+p_2^2/2+\\Omega_1^2q_1^2/2+\\Omega_2^2q_2^2/2,\\]\nwhere $\\Omega_1$ and $\\Omega_2$ are two nonzero parameters. Because the two systems involving $q_1,p_1$ and $q_2,p_2$ are not coupled in the equations of motion, this system has two invariants $H_1=p_1^2/2+\\Omega_1^2q_1^2/2$ and $H_2=p_2^2/2+\\Omega_2^2q_2^2/2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.twoOscillatorEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。"
  ],
  "statement_scope": "仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:37.070895",
      "before_sha256": "b98ebc78935c46a75a5c738acaf39dcaf7ec09f3b9b25e8972f2ed593415f64a",
      "after_sha256": "258e4c3a8744c62c99246e9dcf235ee912119a2d0c2b3090e6c50eb265a6bfe1",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def twoOscillatorEnergy (Ω : Fin 2 → ℝ) (i : Fin 2) (z : MolecularDynamics.Chapter05Review.E 4) :=
  (z (Fin.natAdd 2 i))^2/2+(Ω i)^2*(z (Fin.castAdd 2 i))^2/2
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.twoOscillatorEnergy
```lean
def twoOscillatorEnergy (Ω : Fin 2 → ℝ) (i : Fin 2) (z : MolecularDynamics.Chapter05Review.E 4) :=
  (z (Fin.natAdd 2 i))^2/2+(Ω i)^2*(z (Fin.castAdd 2 i))^2/2
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-TwoOscillatorFlow",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198–199",
  "pdf_page": "219–220",
  "statement_latex": "Because the two systems involving $q_1,p_1$ and $q_2,p_2$ are not coupled in the equations of motion, this system has two invariants $H_1=p_1^2/2+\\Omega_1^2q_1^2/2$ and $H_2=p_2^2/2+\\Omega_2^2q_2^2/2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本句承接Example 5.4；Ω₁、Ω₂为非零参数；H₁、H₂为对应两个无耦合子系统的分能量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.twoOscillatorFlow",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确相空间排列(q1,q2,p1,p2)和真实两个振子流；非零频率资格另条。",
    "[EXTRA] 保留解析流并补任意初值（包括零分能量退化层）的两个真实分能量不变量，不再只依赖正共同层的Tori结论。原非零频率资格显式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:37.070895",
      "before_sha256": "da881e325b703a642176c7b6710a014e6c7d60402162b6e84767b75ab1627436",
      "after_sha256": "ef63113f4bdf0b4d08e2086c72e232d51677fe4150bdbde0a6db4f59b6f1da35",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def twoOscillatorFlow (Ω : Fin 2 → ℝ) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E 4) : MolecularDynamics.Chapter05Review.E 4 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω 0*t)+z 2/(Ω 0)*Real.sin (Ω 0*t),
    z 1*Real.cos (Ω 1*t)+z 3/(Ω 1)*Real.sin (Ω 1*t),
    z 2*Real.cos (Ω 0*t)-Ω 0*z 0*Real.sin (Ω 0*t),
    z 3*Real.cos (Ω 1*t)-Ω 1*z 1*Real.sin (Ω 1*t)]

theorem twoOscillatorFlow_invariants (Ω : Fin 2 → ℝ) (_hΩ : ∀ i,Ω i ≠ 0)
    (z : MolecularDynamics.Chapter05Review.E 4) (t : ℝ) (i : Fin 2) :
    twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=twoOscillatorEnergy Ω i z := by
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
### 实际依赖 MD.Ch05.twoOscillatorEnergy
```lean
def twoOscillatorEnergy (Ω : Fin 2 → ℝ) (i : Fin 2) (z : MolecularDynamics.Chapter05Review.E 4) :=
  (z (Fin.natAdd 2 i))^2/2+(Ω i)^2*(z (Fin.castAdd 2 i))^2/2
```
### 实际依赖 MD.Ch05.twoOscillatorFlow
```lean
def twoOscillatorFlow (Ω : Fin 2 → ℝ) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E 4) : MolecularDynamics.Chapter05Review.E 4 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω 0*t)+z 2/(Ω 0)*Real.sin (Ω 0*t),
    z 1*Real.cos (Ω 1*t)+z 3/(Ω 1)*Real.sin (Ω 1*t),
    z 2*Real.cos (Ω 0*t)-Ω 0*z 0*Real.sin (Ω 0*t),
    z 3*Real.cos (Ω 1*t)-Ω 1*z 1*Real.sin (Ω 1*t)]
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-Mixing",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "199",
  "pdf_page": "220",
  "statement_latex": "An even stronger property than the ergodic property is the concept of a mixing system. For a mixing system, the finite time density $\\rho(z;t)$ converges, in the weak sense, to the invariant distribution $\\rho_\\infty(z)$, as $t\\to\\infty$. That is, we have, for all test functions $\\phi$ in some chosen space\n\\[\\lim_{t\\to\\infty}\\langle\\phi,\\rho(\\cdot;t)\\rangle=\\langle\\phi,\\rho_\\infty\\rangle.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.weakMixing",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际不变参考测度上的AC概率初值、有界连续测试函数；参考测度是μ，可取微正则测度；避免旧density r谓词暗中以Lebesgue可积替代微正则可积。",
    "[EXTRA] 混合定义在谓词内记录概率参考测度、零时恒等、群律、联合可测实际流；保留AC初始概率与有界连续测试配对。相关已有证明取第二合取后重查。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:37.070895",
      "before_sha256": "59e3cf2aaeef819acde67366c80351cdd160c9049256e1461abf68037a224c1f",
      "after_sha256": "db0eb975725b316611365b25d5a83156a55ba4626a531ef1502efeaf6541d9a2",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def weakMixing {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (IsProbabilityMeasure μ ∧ (∀ z,Φ 0 z=z) ∧
    (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) ∧ Measurable (Function.uncurry Φ)) ∧
  ∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
  Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))
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
  "source_id": "MD-5.4.1-TwoOscillatorEnergyDecomposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "199",
  "pdf_page": "220",
  "statement_latex": "On the other hand, the energy surface $H=E$ is the union of all such 2-tori with $E_1+E_2=E$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "相空间坐标顺序(q₁,q₂,p₁,p₂)，H_i=p_i²/2+Ω_i²q_i²/2，H=H₁+H₂；原语境 Ω₁,Ω₂≠0。",
    "原文 such 2-tori 指前文 E₁,E₂>0 的层；E_i=0 的退化层未被原句字面涵盖，保留该原书疑误。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.twoOscillatorEnergyDecomposition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]包括c_i=0的退化边界；原“all such 2-tori”字面忽略零分能量层，完整全能量面分解不能遗漏这些层。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。"
  ],
  "statement_scope": "仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:37.070895",
      "before_sha256": "4dd9174a2898578d9d9b5a6e6f2731fee76e4a8eb129408e7dabc33f3f0cd0c4",
      "after_sha256": "f11cf2bb64db234e2066399a6596c354d045dfdbca9d05eb9174138ded367248",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem twoOscillatorEnergyDecomposition : ∀ (Ω : Fin 2 → ℝ) (E : ℝ) (z : MolecularDynamics.Chapter05Review.E 4),
  ((∑ i,twoOscillatorEnergy Ω i z)=E) ↔
  ∃ c : Fin 2 → ℝ,(∀ i,0 ≤ c i) ∧ (∑ i,c i)=E ∧ (∀ i,twoOscillatorEnergy Ω i z=c i) := by
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
### 实际依赖 MD.Ch05.twoOscillatorEnergy
```lean
def twoOscillatorEnergy (Ω : Fin 2 → ℝ) (i : Fin 2) (z : MolecularDynamics.Chapter05Review.E 4) :=
  (z (Fin.natAdd 2 i))^2/2+(Ω i)^2*(z (Fin.castAdd 2 i))^2/2
```
