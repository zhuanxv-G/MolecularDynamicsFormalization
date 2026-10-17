# BATCH22 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3.3-Figure64Frequencies
```json
{
  "source_id": "MD-6.3.3-Figure64Frequencies",
  "kind": "definition",
  "label": "Fig. 6.4",
  "section": "6.3.3",
  "printed_page": "238",
  "pdf_page": "259",
  "statement_latex": "Fig. 6.4 The memory kernel $\\psi$ is shown for three different sets of frequencies $\\Omega_i$. Blue: $k=400$, $\\Omega_i=0.01i$; red: $k=1,000$, $\\Omega_i\\sim U[0,1]$; green: $k=1,000$, $\\Omega_i=10\\widehat\\Omega_i$, where $\\widehat\\Omega_i\\sim U[0,1]$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.figure64Frequencies",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Fin下标val+1恢复原i=1,…,k；长度1区间限制Lebesgue测度是U[0,1]，记录原边际law，未擅加原未明说的独立性。green/10完整表示10×Uniform频率。图中核使用前条实际频率求和定义。"
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
def figure64Frequencies {A : Type*} [MeasurableSpace A] (P : Measure A)
    (blue : Fin 400 → ℝ) (red green : Fin 1000 → A → ℝ) : Prop :=
  (∀ i, blue i=(1/100 : ℝ)*(i.val+1)) ∧
  (∀ i, HasLaw (red i) (volume.restrict (Icc (0 : ℝ) 1)) P) ∧
  ∀ i, HasLaw (fun sample ↦ green i sample/10) (volume.restrict (Icc (0 : ℝ) 1)) P
```

### MD-6.3.3-Figure65Frequencies
```json
{
  "source_id": "MD-6.3.3-Figure65Frequencies",
  "kind": "definition",
  "label": "Fig. 6.5",
  "section": "6.3.3",
  "printed_page": "238",
  "pdf_page": "259",
  "statement_latex": "Fig. 6.5 The memory kernels $\\psi$ are shown for various choices of $\\Omega_i^{(k)}$. Left: $\\Omega_i^{(k)}=i/\\sqrt k$, $k=5^2,10^2,\\ldots,35^2$; center: $\\Omega_i=\\sqrt k\\widehat\\Omega_i$, $\\widehat\\Omega_i\\sim U[0,1]$, $k=10,20,\\ldots,100$; right: $\\Omega_i=k\\widehat\\Omega_i$, $\\widehat\\Omega_i\\sim U[0,1]$, $k=10,20,\\ldots,100$. In each case the red curve indicates the largest value of $k$ considered, whereas green indicates the smallest value.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "各图红色为最大k、绿色为最小k；实际η由FrequencyMemoryKernel构造。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.figure65Frequencies",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]两个原数列分别7/10项、完整全部频率及随机边际；Fin下标+1；不把绘图外观当严格极限定理。"
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
def figure65Frequencies {A : Type*} [MeasurableSpace A] (P : Measure A)
    (left : (k : ℕ) → Fin k → ℝ) (center right : (k : ℕ) → Fin k → A → ℝ) : Prop :=
  (∀ j ∈ Finset.range 7, ∀ i : Fin ((5*(j+1))^2),
    left ((5*(j+1))^2) i=(i.val+1 : ℝ)/Real.sqrt ((5*(j+1))^2 : ℕ)) ∧
  (∀ j ∈ Finset.range 10, ∀ i : Fin (10*(j+1)),
    HasLaw (fun sample ↦ center (10*(j+1)) i sample/Real.sqrt (10*(j+1) : ℕ))
      (volume.restrict (Icc (0 : ℝ) 1)) P) ∧
  ∀ j ∈ Finset.range 10, ∀ i : Fin (10*(j+1)),
    HasLaw (fun sample ↦ right (10*(j+1)) i sample/(10*(j+1) : ℕ))
      (volume.restrict (Icc (0 : ℝ) 1)) P
```

### MD-6.3.3-BathForceWeakLimitMeaning
```json
{
  "source_id": "MD-6.3.3-BathForceWeakLimitMeaning",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "237–238",
  "pdf_page": "258–259",
  "statement_latex": "For large $k$ and for many choices of the frequencies $\\Omega_i$ and the initial conditions $\\{q_i(0);p_i(0)\\}$, function $f(t)$ will take on the character of a Wiener process; in fact the convergence can be shown in the weak sense. We may even take the initial conditions to be randomly distributed [13,205].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原many choices没有给热浴初值法则/频率条件/拓扑；此处f像Wiener process、下页f(t)作为Wiener increment还存在力与积分过程的类型疑问。"
    }
  ],
  "lean_decl": "MD.Ch06.bathForceWeakLimitMeaning",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整连续路径空间的弱法则，而非只收敛均值/某单时边际；实际有限热浴力路径与Wiener路径逐点关联，只定义原希望的资格，不宣称任意族满足。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "将与Wiener过程比较的对象改为时间积分后的热浴力；仍只定义极限意义。",
      "corrected_decl": "MD.Ch06.bathForceWeakLimitMeaning_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bathForceWeakLimitMeaning {A : Type*} [MeasurableSpace A] (P : Measure A)
    (masses : (k : ℕ) → Fin k → ℝ) (q0 p0 : (k : ℕ) → A → (Fin k → ℝ))
    (Q0 : ℝ) (W : ℝ → A → ℝ)
    (forcePaths : (k : ℕ) → (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ))
    (wienerPaths : (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ)) : Prop :=
  IsPreBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ k, 0 < k → ∀ i, 0 < masses k i) ∧
  (∀ k T sample s, forcePaths k T sample s =
    MolecularDynamics.Chapter06Review.bathForcePrinted (masses k) (q0 k sample) (p0 k sample) Q0 s) ∧
  (∀ T sample s, wienerPaths T sample s=W s sample) ∧
  ∀ T : ℝ, 0 < T → ∀ f : C(Icc (0 : ℝ) T, ℝ) → ℝ,
    Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun k ↦ ∫ sample, f (forcePaths k T sample) ∂P) atTop
      (𝓝 (∫ sample, f (wienerPaths T sample) ∂P))

/-- 修正版，对应原文 MD-6.3.3-BathForceWeakLimitMeaning；改动：将与Wiener过程比较的对象改为时间积分后的热浴力；仍只定义极限意义。 -/
def bathForceWeakLimitMeaning_corrected {A : Type*} [MeasurableSpace A] (P : Measure A)
    (masses : (k : ℕ) → Fin k → ℝ) (q0 p0 : (k : ℕ) → A → (Fin k → ℝ))
    (Q0 : ℝ) (W : ℝ → A → ℝ)
    (forcePaths : (k : ℕ) → (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ))
    (wienerPaths : (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ)) : Prop :=
  IsPreBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ k, 0 < k → ∀ i, 0 < masses k i) ∧
  (∀ k T sample s, forcePaths k T sample s =
    ∫ u in (0 : ℝ)..(s : ℝ), MolecularDynamics.Chapter06Review.bathForce (masses k) (q0 k sample) (p0 k sample) Q0 u) ∧
  (∀ T sample s, wienerPaths T sample s=W s sample) ∧
  ∀ T : ℝ, 0 < T → ∀ f : C(Icc (0 : ℝ) T, ℝ) → ℝ,
    Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun k ↦ ∫ sample, f (forcePaths k T sample) ∂P) atTop
      (𝓝 (∫ sample, f (wienerPaths T sample) ∂P))
```

### MD-6.3.3-VariableFrictionForward
```json
{
  "source_id": "MD-6.3.3-VariableFrictionForward",
  "kind": "extra_claim",
  "label": null,
  "section": "6.3.3",
  "printed_page": "239",
  "pdf_page": "260",
  "statement_latex": "\\[dp=-\\nabla U(q)dt-\\Gamma(q)\\Gamma(q)^T pdt+\\sqrt{2k_BT}M^{1/2}\\Gamma(q)d\\widetilde W.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.variableFrictionForward",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整原矩形Γ、任意质量的实际漂移与噪声协方差导出形式前向表达，供验证canonical资格；没有偷换为常矩阵或单位质量。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def variableFrictionForward {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  (∑ i, (-(m i)⁻¹*x.2 i*fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z ↦ (textbookConfigurationPartial U i z.1+
      ((Γ z.1*(Γ z.1).transpose).mulVec z.2) i)*ρ z) x (0,Pi.single i 1))) +
  ∑ i, ∑ k, θ*Real.sqrt (m i)*Real.sqrt (m k)*(Γ x.1*(Γ x.1).transpose) i k *
    fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single k 1)) x (0,Pi.single i 1)
```

### MD-6.3.3-VariableFrictionCanonicalPrinted
```json
{
  "source_id": "MD-6.3.3-VariableFrictionCanonicalPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.3",
  "printed_page": "239",
  "pdf_page": "260",
  "statement_latex": "However, it should be noted that in many types of modelling, the physical nature of the interaction with the solvent bath is neglected and $\\gamma$ or $\\Gamma(q)$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "任意ΓΓᵀ与对角质量不交换时，印刷漂移ΓΓᵀp与噪声M½Γ不自动满足Gibbs涨落耗散平衡；原canonical目标不能推广为任意质量/任意矩阵全称定理。"
    }
  ],
  "lean_decl": "MD.Ch06.variableFrictionCanonicalPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]该条为原恢复canonical目标的必要形式stationarity检验；完整任意质量/Γ对象保留，不以必要检验计完整采样收敛已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "增加ΓΓᵀ与质量矩阵M交换条件；另一个可选修法是修改漂移以匹配噪声协方差。",
      "corrected_decl": "MD.Ch06.variableFrictionCanonicalPrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem variableFrictionCanonicalPrinted : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0
```

### MD-6.3.3-VariableFrictionCommutingStationary
```json
{
  "source_id": "MD-6.3.3-VariableFrictionCommutingStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.3",
  "printed_page": "239",
  "pdf_page": "260",
  "statement_latex": "$\\gamma$ or $\\Gamma(q)$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.variableFrictionCommutingStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确ΓΓᵀ与M交换，保留任意维度/矩形Γ及完整Gibbs权重stationarity；未直接假设stationarity或声称采样收敛。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem variableFrictionCommutingStationary : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  (∀ q, (Γ q*(Γ q).transpose)*Matrix.diagonal m=Matrix.diagonal m*(Γ q*(Γ q).transpose)) →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0
```

