# EAUDIT08：第5章§5.3.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.3.2-WeakStationary",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "189–190",
  "pdf_page": "210–211",
  "statement_latex": "We are inclined to view the steady states (equilibrium solutions) of the Liouville equation as solutions of\n\\[\\mathcal L_f^\\dagger\\rho=0.\\]\nHowever, this requires a little care. In general, we would like to be able to apply $\\mathcal L_f^\\dagger$ to nonsmooth distributions such as Dirac delta functions for which the application of the Liouville operator does not make obvious sense (as we have not mentioned how to differentiate delta functions). Instead we will define the stationary solution in terms of integrals against test functions.\nthis suggests that the condition for the invariant probability density function $\\rho_\\infty$ should be\n\\[\\int_{\\mathcal D}\\phi\\mathcal L_f^\\dagger\\rho_\\infty\\,d\\omega=0,\\]\nfor all suitable functions $\\phi\\in C_0^\\infty(\\mathbb R^m)$. We say that $\\rho_\\infty$ satisfies\n\\[\\mathcal L^\\dagger\\rho_\\infty=0,\\]\nin the weak or variational sense.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal D\\subset\\mathbb R^m$ 为可容许相空间，$d\\omega=dz_1\\cdots dz_m$ 为 Lebesgue 体积元；$\\rho_\\infty$ 是待讨论的平稳概率分布或其密度。",
    "PDF p.211 在 “this suggests” 前的原文背景是 $\\partial\\rho/\\partial t=\\mathcal L_f^\\dagger\\rho$；本条摘录跨越 p.189–190 的不同段落。",
    "$C_0^\\infty(\\mathbb R^m)$ 是光滑紧支撑测试函数空间；对奇异测度，展示积分应按分布对偶理解。对受限测度的零延拓求分布导数时，边界贡献不能删除。",
    "原书末式为 $\\mathcal L^\\dagger\\rho_\\infty=0$，省略 f 下标；这里按原页保留，并不更换其所指算子。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.weakStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。",
    "[EXTRA] Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:58:05.599147",
      "before_sha256": "a1a447db25bf0f1d3c1e791ec30174f2c76eb079f2cd79181911d3c9ab8fadcb",
      "after_sha256": "e634d3d84adbb35e29b73fa3f086835de860f5eddf4883211c288f077314e5af",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.testSpace
```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}
```
### 实际依赖 MD.Ch05.weakStationary
```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.2-EnsembleAverage",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190",
  "pdf_page": "211",
  "statement_latex": "Let $\\phi$ be a $C^\\infty$ function of the phase variables with compact support and define the time $t$ average by\n\\[\\bar\\phi(t)=\\frac{\\int_{\\mathcal D}\\phi(\\mathbf q,\\mathbf p)\\rho(\\mathbf q,\\mathbf p,t)\\,d\\omega}{\\int_{\\mathcal D}\\rho(\\mathbf q,\\mathbf p,t)\\,d\\omega}.\\tag{5.6}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathbf q,\\mathbf p$ 为相空间的位置和动量坐标；$\\phi\\in C_0^\\infty(\\mathbb R^m)$；$\\rho(\\mathbf q,\\mathbf p,t)$ 是时刻 t 的概率密度，$\\mathcal D$ 为其相空间域。",
    "原文 “time t average” 在式 (5.6) 中是瞬时系综平均；分母为该时刻的总质量，在概率密度语境中为 1。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.ensembleAverageOn",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:58:05.599147",
      "before_sha256": "fcba520226e6c7bb56490bf6c53ae9f542d78edc3e287101ae0995640650dc00",
      "after_sha256": "497dece218ae2ddc8a8ce94d263cfa182c6734a754c05262de0a869a373aa247",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def ensembleAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (t : ℝ) :=
  densityAverageOn D (ρ t) φ
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.densityAverageOn
```lean
def densityAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ) : ℝ :=
  (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)
```
### 实际依赖 MD.Ch05.ensembleAverageOn
```lean
def ensembleAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (t : ℝ) :=
  densityAverageOn D (ρ t) φ
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.2-HamiltonianEnergyIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190",
  "pdf_page": "211",
  "statement_latex": "In the case of a Hamiltonian system, we know that $\\mathcal L_f^\\dagger=-\\mathcal L_f$, and, moreover, $\\mathcal L_fH=0$, so that $H$ is a first integral.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$f=J\\nabla H$ 为自治 Hamiltonian 向量场，$\\mathcal L_f u=D u[f]$，$\\mathcal L_f^\\dagger u=-\\nabla\\cdot(u f)$；Hamiltonian 场散度为零给出 $\\mathcal L_f^\\dagger=-\\mathcal L_f$。",
    "本条范围包括伴随算子关系、$\\mathcal L_fH=0$ 和能量第一积分含义。第一积分指 H 沿实际 Hamiltonian 轨道恒定，不仅是一个对总化 fderiv 的形式等式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.hamiltonianEnergyIntegral",
  "reusable_proofs": [
    "MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson",
    "MolecularDynamics.textbookPoissonBracket_self"
  ],
  "extra_assumptions": [
    "[EXTRA] 补真实Hamiltonian场的−div(u f)=−L_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L_fH=0，不把散度零/能量守恒当假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:58:05.599147",
      "before_sha256": "f1321865fc311f1855b3d94e522682dd171c803ce6cd1e98bb12b117717c0e1a",
      "after_sha256": "d145f44a3641e13a73a6e7cf369e11466147a793aa55b0a8e3ca4c73ca46a02e",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonianEnergyIntegral {Nc : ℕ} (H : MolecularDynamics.SymplecticCoordinates Nc → ℝ) (z : MolecularDynamics.SymplecticCoordinates Nc) :
  MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) H z=0 := by
  rw [MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson]
  exact MolecularDynamics.textbookPoissonBracket_self H z

theorem hamiltonianEnergyIntegral_full (k : ℕ)
    (H u : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (_hH : ContDiff ℝ 2 H) (_hu : ContDiff ℝ 1 u)
    (z : MolecularDynamics.SymplecticCoordinates k)
    (γ : ℝ → MolecularDynamics.SymplecticCoordinates k) (a b : ℝ) (_hab : a ≤ b)
    (_hγ : ∀ t ∈ Icc a b,HasDerivWithinAt γ
      (MolecularDynamics.textbookHamiltonianVectorField H (γ t)) (Icc a b) t) :
    -(LinearMap.trace ℝ (MolecularDynamics.SymplecticCoordinates k)
      (fderiv ℝ (fun x ↦ u x • MolecularDynamics.textbookHamiltonianVectorField H x) z).toLinearMap)=
        -MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) u z ∧
    (∀ t ∈ Icc a b,H (γ t)=H (γ a)) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```
### 实际依赖 MolecularDynamics.textbookLieDerivative
```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookLieDerivative
```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.2-ShellWeight",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190",
  "pdf_page": "211",
  "statement_latex": "In particular, consider the density $\\rho_\\varepsilon(\\mathbf q,\\mathbf p)=Z_\\varepsilon^{-1}e^{-(H(\\mathbf q,\\mathbf p)-E)^2/(2\\varepsilon)}$, where $\\varepsilon$ is an arbitrary small positive constant and $E$ is an accessible energy level.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原句定义的是完整归一化密度 $\\rho_\\varepsilon$。未归一化指数权可另记为 $w_\\varepsilon(z)=e^{-(H(z)-E)^2/(2\\varepsilon)}$，两者相差 $Z_\\varepsilon^{-1}$。",
    "$\\varepsilon>0$，E 为可达能级；H 为此前 Hamiltonian 系统的能量，$z=(\\mathbf q,\\mathbf p)$。下文 p.190–191 假设 H 充分增长以使权可积并选取归一化因子。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.shellWeight",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。"
  ],
  "statement_scope": "仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:58:05.599147",
      "before_sha256": "075ceeded3d91cb68332a9059a8b4ac425bda6bf6934bd021cbc15b0bd29c5d1",
      "after_sha256": "8bc7f8ce5eaa85a91be72280066337c1ebd9273c196bb9e38d81b9868adc2c28",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def shellWeight {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := Real.exp (-(H z-c)^2/(2*ε))
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.shellWeight
```lean
def shellWeight {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := Real.exp (-(H z-c)^2/(2*ε))
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.2-ShellPartition",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190–191",
  "pdf_page": "211–212",
  "statement_latex": "We assume that $H$ tends to infinity sufficiently rapidly as $\\|\\mathbf z\\|\\to\\infty$ so that the exponential decays sufficiently rapidly (and thus the total integral exists) and take $Z_\\varepsilon$ to be a normalization factor that insures that we have, for each $\\varepsilon$, a well defined probability density function.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathbf z=(\\mathbf q,\\mathbf p)$，$\\varepsilon>0$；上一段的指数权为 $w_\\varepsilon=e^{-(H-E)^2/(2\\varepsilon)}$，归一化要求确定 $Z_\\varepsilon=\\int_{\\mathbb R^m}w_\\varepsilon\\,d\\omega$。",
    "此全相空间表达沿用原文 H 充分增长以保证总积分存在的语境。可积性及 $0<Z_\\varepsilon<\\infty$ 是实际概率使用资格；总化积分定义不自动提供资格证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.shellPartition",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:58:05.599147",
      "before_sha256": "22e657a2c453f27d5f059bb49aaa4825b09fabb4d88f98d30533c65305d72493",
      "after_sha256": "db8a69333c977bd041fb9e98a50d44ebeea7043f61b5d76b22ba05944033925e",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def shellPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) := ∫ z,MolecularDynamics.Chapter05Review.shellWeight H c ε z
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.shellWeight
```lean
def shellWeight {n : ℕ} (H : E n → ℝ) (c ε : ℝ) (z : E n) := Real.exp (-(H z-c)^2/(2*ε))
```
### 实际依赖 MD.Ch05.shellPartition
```lean
def shellPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) := ∫ z,MolecularDynamics.Chapter05Review.shellWeight H c ε z
```
### 实际依赖 MD.Ch05.shellWeight
```lean
def shellWeight {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := Real.exp (-(H z-c)^2/(2*ε))
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.2-ShellDensity",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190–191",
  "pdf_page": "211–212",
  "statement_latex": "$\\rho_\\varepsilon(\\mathbf q,\\mathbf p)=Z_\\varepsilon^{-1}e^{-(H(\\mathbf q,\\mathbf p)-E)^2/(2\\varepsilon)}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\varepsilon>0$，E 为可达能级，$\\mathbf z=(\\mathbf q,\\mathbf p)$；归一化因子由实际全相空间指数权的积分确定。原文在后续句子登记 H 的充分增长/可积资格。",
    "ρ_ε 已除一次 $Z_\\varepsilon$；原有对后文 (5.8) 若再除一次须单列字面疑误的提示予以保留。本条只审计 PDF p.211 的密度定义，不处理 (5.8) 的其他 source_id。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.shellDensity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:58:05.599147",
      "before_sha256": "fe4def89a217921af24d01f5c4eeded8faed076ff2c76288c7474b1900261095",
      "after_sha256": "c2ffdeceaf7665ea44219ecaa8ca90899d9c24e3ced9dd9a1411d0dd0d5273c3",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def shellDensity {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.shellWeight H c ε z/MolecularDynamics.Chapter05Review.shellPartition H c ε
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.shellPartition
```lean
def shellPartition {n : ℕ} (H : E n → ℝ) (c ε : ℝ) := ∫ z,shellWeight H c ε z
```
### 实际依赖 MolecularDynamics.Chapter05Review.shellWeight
```lean
def shellWeight {n : ℕ} (H : E n → ℝ) (c ε : ℝ) (z : E n) := Real.exp (-(H z-c)^2/(2*ε))
```
### 实际依赖 MD.Ch05.shellDensity
```lean
def shellDensity {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.shellWeight H c ε z/MolecularDynamics.Chapter05Review.shellPartition H c ε
```
### 实际依赖 MD.Ch05.shellPartition
```lean
def shellPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) := ∫ z,MolecularDynamics.Chapter05Review.shellWeight H c ε z
```
### 实际依赖 MD.Ch05.shellWeight
```lean
def shellWeight {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := Real.exp (-(H z-c)^2/(2*ε))
```
