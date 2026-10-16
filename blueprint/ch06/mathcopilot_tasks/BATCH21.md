# BATCH21 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3.3-BathReduction
```json
{
  "source_id": "MD-6.3.3-BathReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.3",
  "printed_page": "237",
  "pdf_page": "258",
  "statement_latex": "Introducing this formula in (6.23), we obtain a reduced system\n\\[\\dot Q=P;\\tag{6.27}\\quad\\dot P=-U'(Q)-k^{-1}\\sum_{i=1}^k(Q-q_i);\\tag{6.28}\\]\n\\[=-U'(Q)+f(t)-\\int_0^t\\psi(t-s)P(s)ds.\\tag{6.29}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.bathReduction",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]保留全部原Hamilton ODE与初值、正质量、真实卷积，按导出正k⁻¹合力；不将约化等式作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-16",
      "action": "local_original_page_transcription",
      "reason": "PDF258/259视觉核对原记忆核为psi，不是eta；仅原文符号转录更正，Lean定义未变。",
      "evidence": "source_transcription_fixes.json; PDF258/259",
      "website": "待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bathReduction :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter06Review.V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+MolecularDynamics.Chapter06Review.bathForce μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, MolecularDynamics.Chapter06Review.memoryKernel μ (t-s)*P s
```

### MD-6.3.3-BathReductionPrinted
```json
{
  "source_id": "MD-6.3.3-BathReductionPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.3",
  "printed_page": "237",
  "pdf_page": "258",
  "statement_latex": "\\[\\dot P=-U'(Q)+f(t)-\\int_0^t\\psi(t-s)P(s)ds.\\tag{6.29}\\]\n\\[f(t)=-k^{-1}\\sum_{i=1}^k[\\cos(\\Omega_i t)q_i(0)+\\Omega_i^{-1}\\sin(\\Omega_i t)p_i(0)/\\mu_i-\\cos(\\Omega_i t)Q(0)].\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原负f与+f约化式符号冲突；保留完整字面卷积方程。"
    }
  ],
  "lean_decl": "MD.Ch06.bathReductionPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-16",
      "action": "local_original_page_transcription",
      "reason": "PDF258/259视觉核对原记忆核为psi，不是eta；仅原文符号转录更正，Lean定义未变。",
      "evidence": "source_transcription_fixes.json; PDF258/259",
      "website": "待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bathReductionPrinted :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter06Review.V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+MolecularDynamics.Chapter06Review.bathForcePrinted μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, MolecularDynamics.Chapter06Review.memoryKernel μ (t-s)*P s
```

### MD-6.3.3-MemoryKernelDeltaMeaning
```json
{
  "source_id": "MD-6.3.3-MemoryKernelDeltaMeaning",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "238",
  "pdf_page": "259",
  "statement_latex": "If sufficient high frequency components are present, then the mass of the memory kernel is typically found to be localized around 0; in such a situation of rapid decay it is found that one may replace the function $\\psi$ by a Dirac delta function scaled by a positive coefficient $\\gamma$; we say that the system is Markovian or memory-less in this situation and we replace the delay-differential equation (6.29) by the SDEs\n\\[dQ=Pdt;\\tag{6.30}\\quad dP=-U'(Q)dt+\\sigma dW-\\gamma Pdt.\\tag{6.31}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原“sufficient high frequency/typically”没有给频率序列、归一化、热浴初值法则及白噪声弱收敛资格，不能声明任意热浴自动满足δ极限。"
    }
  ],
  "lean_decl": "MD.Ch06.memoryKernelDeltaMeaning",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确ηk→γδ0的实际分布意义，仅定义该近似资格；不计极限或Langevin推导已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-16",
      "action": "local_original_page_transcription",
      "reason": "PDF258/259视觉核对原记忆核为psi，不是eta；仅原文符号转录更正，Lean定义未变。",
      "evidence": "source_transcription_fixes.json; PDF258/259",
      "website": "待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def memoryKernelDeltaMeaning (masses : (k : ℕ) → (Fin k → ℝ)) (γ : ℝ) : Prop :=
  0 < γ ∧ ∀ f : ℝ → ℝ, ContDiff ℝ ∞ f → HasCompactSupport f →
    Tendsto (fun k ↦ ∫ t, MolecularDynamics.Chapter06Review.memoryKernel (masses k) t*f t)
      atTop (𝓝 (γ*f 0))
```

### MD-6.3.3-ScalarLangevin
```json
{
  "source_id": "MD-6.3.3-ScalarLangevin",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "238",
  "pdf_page": "259",
  "statement_latex": "\\[dQ=Pdt;\\tag{6.30}\\quad dP=-U'(Q)dt+\\sigma dW-\\gamma Pdt.\\tag{6.31}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.scalarLangevin",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实耦合随机Q(t,sample)及动量漂移、实际可积性、初值与严格Ito积分；无任意样本代替随机状态。",
    "[EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def scalarLangevin {Ω : Type*} [MeasurableSpace Ω] (law : Measure Ω)
    (W Q momentum : ℝ → Ω → ℝ) (U : ℝ → ℝ) (γ σ q0 p0 : ℝ) : Prop :=
  0 < γ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample (_i : Fin 1) ↦ W t sample) law ∧
  (∀ᵐ sample ∂law, ContinuousOn (fun t ↦ Q t sample) (Ici 0) ∧
    ContinuousOn (fun t ↦ momentum t sample) (Ici 0) ∧ momentum 0 sample=p0 ∧ ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ momentum s sample) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -deriv U (Q s sample)-γ*momentum s sample) volume 0 T ∧
    Q T sample=q0+∫ s in 0..T, momentum s sample) ∧
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral law W (fun _ _ ↦ σ) T
    (fun sample ↦ momentum T sample-p0-∫ s in 0..T, -deriv U (Q s sample)-γ*momentum s sample)
```

### MD-6.3.3-MassLangevin
```json
{
  "source_id": "MD-6.3.3-MassLangevin",
  "kind": "definition",
  "label": "(6.32)–(6.33)",
  "section": "6.3.3",
  "printed_page": "239",
  "pdf_page": "260",
  "statement_latex": "The equations of motion are, in vectorial form:\n\\[dq=M^{-1}pdt;\\tag{6.32}\\quad dp=-\\nabla U(q)dt-\\gamma pdt+\\sqrt{2\\gamma k_BT}M^{1/2}dW.\\tag{6.33}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "任意正对角质量m、γ>0、θ=kBT>0均在模型内明确；常噪声的实际路径积分方程完整保留，额外漂移可积资格在具体定理明确；不把单位质量正式桥当一般质量模型已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinMassSDE",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def langevinMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (X : ℝ → Ω → MolecularDynamics.Chapter06Review.Phase n) (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ θ : ℝ) (x0 : MolecularDynamics.Chapter06Review.Phase n) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧ (∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ fun i ↦ (m i)⁻¹*(X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ fun i ↦ -textbookConfigurationPartial U i (X s sample).1-
      γ*(X s sample).2 i) volume 0 T) ∧
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    (X t sample).1 = x0.1 + (∫ s in 0..t, fun i ↦ (m i)⁻¹ * (X s sample).2 i) ∧
    (X t sample).2 = x0.2 + (∫ s in 0..t, fun i ↦
      -textbookConfigurationPartial U i (X s sample).1 - γ*(X s sample).2 i) +
      fun i ↦ Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)
```

### MD-6.3.3-VariableFriction
```json
{
  "source_id": "MD-6.3.3-VariableFriction",
  "kind": "definition",
  "label": "(6.34)–(6.35)",
  "section": "6.3.3",
  "printed_page": "239",
  "pdf_page": "260",
  "statement_latex": "In particular, a different friction coefficient can be used for each particle and these coefficients can even depend on spatial location, thus we might work with the following system:\n\\[dq=M^{-1}pdt;\\tag{6.34}\\quad dp=-\\nabla U(q)dt-\\Gamma(q)\\Gamma(q)^T pdt+\\sqrt{2k_BT}M^{1/2}\\Gamma(q)d\\widetilde W;\\tag{6.35}\\]\nwhere we use the matrix $\\Gamma(q)\\in\\mathbb R^{N_c\\times S}$ and a vector of $S$ independent Wiener processes $\\widetilde W$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.variableFriction",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整任意矩形Γ(q)、任意质量和真实全部噪声坐标严格Ito积分；未缩成对角或单位质量，不宣称自动Gibbs不变。",
    "[EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def variableFriction {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ)))
    (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ)
    (x0 : (Fin n → ℝ) × (Fin n → ℝ)) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧ ContDiff ℝ ∞ Γ ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0 ∧
    ∀ T : ℝ, 0 ≤ T → IntervalIntegrable (fun s ↦ fun i ↦ (m i)⁻¹*(X s sample).2 i) volume 0 T ∧
      (X T sample).1=x0.1+∫ s in 0..T, fun i ↦ (m i)⁻¹*(X s sample).2 i) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ Real.sqrt (2*θ*m i)*Γ (X s sample).1 i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ -textbookConfigurationPartial U i (X s sample).1-
          ((Γ (X s sample).1*(Γ (X s sample).1).transpose).mulVec (X s sample).2) i) volume 0 T ∧
        (X T sample).2 i-x0.2 i-(∫ s in 0..T, -textbookConfigurationPartial U i (X s sample).1-
          ((Γ (X s sample).1*(Γ (X s sample).1).transpose).mulVec (X s sample).2) i)=∑ j, integrals j sample)
```

### MD-6.3.3-ParticleDiagonalFriction
```json
{
  "source_id": "MD-6.3.3-ParticleDiagonalFriction",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "239",
  "pdf_page": "260",
  "statement_latex": "In the case of Langevin dynamics with different, variable friction coefficients for each particle, we have $S=N_c$ and\n\\[\\Gamma=\\operatorname{diag}(\\gamma_1(q),\\gamma_1(q),\\gamma_1(q),\\gamma_2(q),\\gamma_2(q),\\gamma_2(q),\\ldots,\\gamma_N(q),\\gamma_N(q),\\gamma_N(q)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "每个粒子三个真实坐标重复系数；原Γ记号沿用，无静默平方根替换。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.particleDiagonalFriction",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def particleDiagonalFriction {N : ℕ} (γ : Fin N → (Fin (N*3) → ℝ) → ℝ)
    (q : Fin (N*3) → ℝ) : Matrix (Fin (N*3)) (Fin (N*3)) ℝ :=
  Matrix.diagonal (fun i ↦ γ ⟨i.val/3, by omega⟩ q)
```

### MD-6.3.3-FrequencyMemoryKernel
```json
{
  "source_id": "MD-6.3.3-FrequencyMemoryKernel",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "237",
  "pdf_page": "258",
  "statement_latex": "\\[\\psi(t)=k^{-1}\\sum_{i=1}^k\\cos(\\Omega_i(t)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.frequencyMemoryKernel",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]以实际给定频率直接表达原核，方便记录图6.4/6.5全部数值族；k>0用于物理解释，有限函数定义不计δ极限已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-16",
      "action": "local_original_page_transcription",
      "reason": "PDF258/259视觉核对原记忆核为psi，不是eta；仅原文符号转录更正，Lean定义未变。",
      "evidence": "source_transcription_fixes.json; PDF258/259",
      "website": "待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def frequencyMemoryKernel {k : ℕ} (Ω : Fin k → ℝ) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹*∑ i, Real.cos (Ω i*t)
```

