# EAUDIT77：第2章§2.2.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.2.1-FirstVariation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.1",
  "printed_page": "61",
  "pdf_page": "83",
  "statement_latex": "Using a Taylor series expansion of the Lagrangian, we have\n\\[\\mathcal A_L(\\Gamma^\\epsilon)-\\mathcal A_L(\\Gamma)=\\int_\\alpha^\\beta[L(\\boldsymbol q(t)+\\epsilon\\boldsymbol\\eta(t),\\dot{\\boldsymbol q}(t)+\\epsilon\\dot{\\boldsymbol\\eta}(t))-L(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))]\\,dt,\\]\n\\[=\\int_\\alpha^\\beta\\left[\\epsilon\\left(\\frac{\\partial L}{\\partial\\boldsymbol q}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\boldsymbol\\eta(t)+\\frac{\\partial L}{\\partial\\dot{\\boldsymbol q}}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\dot{\\boldsymbol\\eta}(t)\\right)+O(\\epsilon^2)\\right]\\,dt.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.firstVariation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "α<β；L、q、η C²以保证实际导数和紧时间窗余项资格。",
    "[EXTRA] 保留原三个结论，并补同一个真实点态Taylor余项的紧时间窗统一C|ε|²控制；没有把余项界当作前提，未新增证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:01:33.943167",
      "before_sha256": "1d893cbf5a4ad13fc5b83f280931a932e94161bc1889ccd2b6996516522d0633",
      "after_sha256": "d5897a5783289903cfb7cb9ddb19ed69688764836d874d4f032ca0d653c1f202",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem firstVariation :
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    (∀ ε : ℝ, action L a b (variation q η ε)-action L a b q =
      ∫ t in a..b, L (q t+ε • η t) (deriv q t+ε • deriv η t)-L (q t) (deriv q t)) ∧
    HasDerivAt (fun ε => action L a b (variation q η ε))
      (∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
        (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) 0 ∧
    Asymptotics.IsBigO (𝓝 0)
      (fun ε : ℝ => action L a b (variation q η ε)-action L a b q-
        ε*(∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
          (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)))
      (fun ε : ℝ => ε^2)
    ∧ (∃ C > 0, ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∀ t ∈ Icc a b,
      |L (q t + ε • η t) (deriv q t + ε • deriv η t) - L (q t) (deriv q t) -
        ε * ((fderiv ℝ (fun x ↦ L x (deriv q t)) (q t)) (η t) +
          (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t))| ≤ C * |ε|^2) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.action
```lean
def action {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : ℝ :=
  ∫ t in a..b, L (q t) (deriv q t)
```
### 实际依赖 MolecularDynamics.Chapter02Review.variation
```lean
def variation {n : ℕ} (q η : ℝ → Q n) (ε : ℝ) (t : ℝ) : Q n := q t + ε • η t
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.1-StationaryAction",
  "kind": "definition",
  "label": null,
  "section": "2.2.1",
  "printed_page": "61–62",
  "pdf_page": "83–84",
  "statement_latex": "Hamilton’s principle states that the natural motion of the system described by the Lagrangian $L$ is a stationary point of the classical action which implies that the $O(\\epsilon)$ term above should vanish for any smooth variation $\\boldsymbol\\eta(t)$ with $\\boldsymbol\\eta(\\alpha)=\\boldsymbol\\eta(\\beta)=\\boldsymbol0$, i.e.,\n\\[I=\\int_\\alpha^\\beta\\left[\\frac{\\partial L}{\\partial\\boldsymbol q}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\boldsymbol\\eta(t)+\\frac{\\partial L}{\\partial\\dot{\\boldsymbol q}}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\dot{\\boldsymbol\\eta}(t)\\right]dt=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.stationarySmoothAction",
  "reusable_proofs": [],
  "extra_assumptions": [
    "驻值以真实一阶变分导数为零定义；展开式相等由FirstVariation条目承担。",
    "[EXTRA] 保留驻值定义，同一source_id补完整积分I=0等价式及自然Euler–Lagrange运动推出驻值的Hamilton原理；C²及a<b是充分资格。新结论只登记sorry陈述，证明留到网站PASS后。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:01:33.943167",
      "before_sha256": "1e4ba9555d7a8f77591b34c2ba62b0d213a227e3fbb9a784bb8c608a48dbafec",
      "after_sha256": "a5cc7e3c5f8361509305816e34f927e2e67a9ce188fbd828d5a270f14ec490be",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def stationarySmoothAction {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : Prop :=
  ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
    HasDerivAt (fun ε => action L a b (variation q η ε)) 0 0

theorem stationarySmoothAction_iff_first_variation {n : ℕ}
    (L : Q n → Q n → ℝ) (q : ℝ → Q n) (a b : ℝ)
    (_hab : a < b) (_hL : ContDiff ℝ 2 (Function.uncurry L)) (_hq : ContDiff ℝ 2 q) :
    stationarySmoothAction L a b q ↔
      ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
      (∫ t in a..b, (fderiv ℝ (fun x ↦ L x (deriv q t)) (q t)) (η t) +
        (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) = 0 := by
  sorry

theorem stationarySmoothAction_hamilton {n : ℕ}
    (L : Q n → Q n → ℝ) (q : ℝ → Q n) (a b : ℝ)
    (_hab : a < b) (_hL : ContDiff ℝ 2 (Function.uncurry L)) (_hq : ContDiff ℝ 2 q)
    (_hnatural : ∀ t ∈ Ioo a b,
      HasDerivAt (fun s ↦ fderiv ℝ (L (q s)) (deriv q s))
        (fderiv ℝ (fun x ↦ L x (deriv q t)) (q t)) t) :
    stationarySmoothAction L a b q := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.action
```lean
def action {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : ℝ :=
  ∫ t in a..b, L (q t) (deriv q t)
```
### 实际依赖 MD.Ch02.stationarySmoothAction
```lean
def stationarySmoothAction {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : Prop :=
  ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
    HasDerivAt (fun ε => action L a b (variation q η ε)) 0 0
```
### 实际依赖 MolecularDynamics.Chapter02Review.variation
```lean
def variation {n : ℕ} (q η : ℝ → Q n) (ε : ℝ) (t : ℝ) : Q n := q t + ε • η t
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.1-EulerLagrange",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.1",
  "printed_page": "62",
  "pdf_page": "84",
  "statement_latex": "Since the variation $\\boldsymbol\\eta$ is meant to be arbitrary, it requires\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\frac{\\partial L}{\\partial\\dot{\\boldsymbol q}}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))=\\frac{\\partial L}{\\partial\\boldsymbol q}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t)),\\]\nwhich is precisely the Lagrangian formulation of the equations of motion.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF82／印刷60，§2.2.1：$L(\\boldsymbol q,\\boldsymbol v)=\\boldsymbol v^T M\\boldsymbol v/2-U(\\boldsymbol q)$；$M$ 为质量矩阵，$U$ 在此取 $C^2$。原条选定的运动方程使用这个拉格朗日函数及其位置、速度偏导数。",
    "PDF82／印刷60：$\\boldsymbol q(t)$ 是构型空间曲线的参数化，$t\\in[\\alpha,\\beta]$，$\\boldsymbol q(\\alpha)=\\boldsymbol Q$、$\\boldsymbol q(\\beta)=\\boldsymbol Q^{\\prime}$；$\\dot{\\boldsymbol q}$ 是时间导数。该页先说 twice continuously differentiable，随后又说各分量 $C^\\infty$ 及 smooth，保留这两处原文，不将其静默统一。",
    "PDF83／印刷61，式(2.3)：$\\boldsymbol q^\\epsilon(t)=\\boldsymbol q(t)+\\epsilon\\boldsymbol\\eta(t)$；$\\boldsymbol\\eta$ 为 $C^\\infty$ 曲线，$\\boldsymbol\\eta(\\alpha)=\\boldsymbol\\eta(\\beta)=0$。arbitrary 指满足这些资格的任意变分方向。",
    "PDF82–84／印刷60–62：$\\mathcal A_L(\\Gamma)=\\int_\\alpha^\\beta L(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\,dt$。本句承接 Hamilton 原理要求一阶变分为零，以及 PDF84 上方分部积分后的 $\\int_\\alpha^\\beta [\\partial L/\\partial\\boldsymbol q-(d/dt)(\\partial L/\\partial\\dot{\\boldsymbol q})]\\boldsymbol\\eta(t)\\,dt=0$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonPrinciple",
  "reusable_proofs": [],
  "extra_assumptions": [
    "α<β，L和q C²；变分按原文C∞且零端点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:01:33.943167",
      "before_sha256": "c9399a4ea1d5cfbf83bb2bbf01b364ca7eae8df70acf173edb4b2b50366b9350",
      "after_sha256": "0c3d81dcca743f386c64a74e9c24270f165bcf67e481723c7ba8b6952369f6c1",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH06_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonPrinciple :
  ∀ n (L : Q n → Q n → ℝ) (q : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q →
    (stationarySmoothAction L a b q ↔ ∀ t ∈ Ioo a b,
      HasDerivAt (fun s => fderiv ℝ (L (q s)) (deriv q s))
        (fderiv ℝ (fun x => L x (deriv q t)) (q t)) t) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.action
```lean
def action {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : ℝ :=
  ∫ t in a..b, L (q t) (deriv q t)
```
### 实际依赖 MD.Ch02.stationarySmoothAction
```lean
def stationarySmoothAction {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : Prop :=
  ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
    HasDerivAt (fun ε => action L a b (variation q η ε)) 0 0
```
### 实际依赖 MolecularDynamics.Chapter02Review.variation
```lean
def variation {n : ℕ} (q η : ℝ → Q n) (ε : ℝ) (t : ℝ) : Q n := q t + ε • η t
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.1-VariationalDerivativePrinted",
  "kind": "definition",
  "label": null,
  "section": "2.2.1",
  "printed_page": "62",
  "pdf_page": "84",
  "statement_latex": "Define the variational derivative of a functional $\\mathcal F$, $\\delta\\mathcal F/\\delta\\boldsymbol q$ so that\n\\[\\mathcal F(\\boldsymbol q+\\epsilon\\boldsymbol\\eta)=\\epsilon\\frac{\\delta\\mathcal F}{\\delta\\boldsymbol q}\\boldsymbol\\eta+O(\\epsilon^2),\\]\nfor all suitable (say, $C^\\infty$) functions $\\boldsymbol\\eta$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF84／印刷62：$\\mathcal F$ 是以曲线 $\\boldsymbol q$ 为自变量的泛函；$\\delta\\mathcal F/\\delta\\boldsymbol q$ 在展示式中作用于变分方向 $\\boldsymbol\\eta$。紧接的正文将经典作用量 $\\mathcal A_L(\\Gamma)$ 视作 $\\mathcal F$。",
    "PDF84／印刷62：$\\epsilon$ 为变分参数，$O(\\epsilon^2)$ 为 $\\epsilon\\to0$ 时的二阶余项；此式要求对所有 suitable (say, $C^\\infty$) functions $\\boldsymbol\\eta$ 成立。PDF83 的作用量变分还要求零端点，但本条泛函定义的这句话未单独列出端点条件。",
    "PDF84／印刷62 原式确为 $\\mathcal F(\\boldsymbol q+\\epsilon\\boldsymbol\\eta)=\\epsilon(\\delta\\mathcal F/\\delta\\boldsymbol q)\\boldsymbol\\eta+O(\\epsilon^2)$，没有减去或加回 $\\mathcal F(\\boldsymbol q)$。保留印刷公式及既有 ERRATUM?，不将其替换为通常导数定义。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "左式漏F(q)，原页实际如此。字面定义对于非零常值F无解，不能静默替成HasFDerivAt。"
    }
  ],
  "lean_decl": "MD.Ch02.printedVariationalDerivative",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:01:33.943167",
      "before_sha256": "9792cf4df0c26a5dde45062f4817e2d8cba5fba445fdc7937d1e925336e58233",
      "after_sha256": "1fd75955ce3b05d0096b654619bc9fdb1a52199405651d4065e0e9503709073c",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH06_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def printedVariationalDerivative {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (q : E) (A : E →L[ℝ] ℝ) : Prop :=
  ∀ η : E, Asymptotics.IsBigO (𝓝 0)
    (fun ε : ℝ => F (q + ε • η) - ε * A η) (fun ε : ℝ => ε^2)
```
### 实际依赖 MD.Ch02.printedVariationalDerivative
```lean
def printedVariationalDerivative {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (q : E) (A : E →L[ℝ] ℝ) : Prop :=
  ∀ η : E, Asymptotics.IsBigO (𝓝 0)
    (fun ε : ℝ => F (q + ε • η) - ε * A η) (fun ε : ℝ => ε^2)
```
