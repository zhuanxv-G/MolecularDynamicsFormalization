# BATCH12：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：51, 52；上下文读取该节相邻页。
2. `blueprint/ch01/ch01_source.json`（仅审本批source_id）及 `Blueprint/Ch01.lean`（包含全部辅助定义）。
3. 依赖定义文件（核实真实定义，不能依据名称）：

```text
MolecularDynamics/BasicDefinitions.lean
MolecularDynamics/Chapter01/BasisMatrix.lean
MolecularDynamics/Chapter01/ComplexSpectralFlow.lean
MolecularDynamics/Chapter01/Continuation.lean
MolecularDynamics/Chapter01/EnergyConservation.lean
MolecularDynamics/Chapter01/EnergyGlobalExistence.lean
MolecularDynamics/Chapter01/Equilibrium.lean
MolecularDynamics/Chapter01/EquilibriumLinearization.lean
MolecularDynamics/Chapter01/EuclideanStability.lean
MolecularDynamics/Chapter01/FirstIntegralGraph.lean
MolecularDynamics/Chapter01/FirstIntegralQuadrature.lean
MolecularDynamics/Chapter01/FirstIntegrals.lean
MolecularDynamics/Chapter01/FutureFlow.lean
MolecularDynamics/Chapter01/GeneralizedCoordinates.lean
MolecularDynamics/Chapter01/GlobalContinuation.lean
MolecularDynamics/Chapter01/GlobalFlow.lean
MolecularDynamics/Chapter01/Hamiltonian.lean
MolecularDynamics/Chapter01/HamiltonianHessian.lean
MolecularDynamics/Chapter01/HarmonicActionAngle.lean
MolecularDynamics/Chapter01/HarmonicOscillator.lean
MolecularDynamics/Chapter01/HarmonicTorus.lean
MolecularDynamics/Chapter01/Kepler.lean
MolecularDynamics/Chapter01/KeplerCartesianBridge.lean
MolecularDynamics/Chapter01/KeplerPolarDynamics.lean
MolecularDynamics/Chapter01/KeplerQuadrature.lean
MolecularDynamics/Chapter01/KeplerReconstruction.lean
MolecularDynamics/Chapter01/Lagrangian.lean
MolecularDynamics/Chapter01/LatticePairPotential.lean
MolecularDynamics/Chapter01/LatticeVibrations.lean
MolecularDynamics/Chapter01/LegendreTransform.lean
MolecularDynamics/Chapter01/LinearFlow.lean
MolecularDynamics/Chapter01/LinearizedHamiltonian.lean
MolecularDynamics/Chapter01/LocalExistence.lean
MolecularDynamics/Chapter01/LocalTrajectories.lean
MolecularDynamics/Chapter01/MatrixFlow.lean
MolecularDynamics/Chapter01/MechanicalConfinement.lean
MolecularDynamics/Chapter01/MechanicalContinuation.lean
MolecularDynamics/Chapter01/MomentumBounds.lean
MolecularDynamics/Chapter01/MomentumConservation.lean
MolecularDynamics/Chapter01/NBody.lean
MolecularDynamics/Chapter01/NormalModes.lean
MolecularDynamics/Chapter01/ODEEndpoint.lean
MolecularDynamics/Chapter01/ParticleCoordinates.lean
MolecularDynamics/Chapter01/PhaseMetric.lean
MolecularDynamics/Chapter01/PlanarAngularMomentum.lean
MolecularDynamics/Chapter01/PolarCoordinateMap.lean
MolecularDynamics/Chapter01/PolarCoordinates.lean
MolecularDynamics/Chapter01/PotentialBarriers.lean
MolecularDynamics/Chapter01/PotentialRegularity.lean
MolecularDynamics/Chapter01/RealRecoveryFlow.lean
MolecularDynamics/Chapter01/RealSpectralFlow.lean
MolecularDynamics/Chapter01/ReviewDefinitions.lean
MolecularDynamics/Chapter01/ReviewProofs.lean
MolecularDynamics/Chapter01/ScalarIntegrability.lean
MolecularDynamics/Chapter01/ScalarLocalIVP.lean
MolecularDynamics/Chapter01/ScalarTurning.lean
MolecularDynamics/Chapter01/SeparableQuadrature.lean
MolecularDynamics/Chapter01/Stability.lean
MolecularDynamics/Chapter01/Statements.lean
MolecularDynamics/Chapter01/TimeReversal.lean
MolecularDynamics/Chapter01/TorusDensity.lean
MolecularDynamics/Chapter01/TorusPeriod.lean
MolecularDynamics/Chapter01/VariationalEquation.lean
MolecularDynamics/Notation.lean
```

Lean4.34.0 / Mathlib v4.34.0。完整输入哈希见MANIFEST.json；本地审计不能替代你的网站独立审计。

## 第一部分：模板A 原文审校

逐条打开PDF原页，逐字核对statement_latex、proof_latex、页码及上下文；不把CSV转述当原文。不得静默纠正原书。若问题仅为原书疑误，保留原文并标记ISSUE。不得伪造证明；proof_latex=null表示无独立完整证明。status仅APPROVED / CORRECTED / NEEDS_HUMAN；issue_codes、issues及evidence给出页码和具体原文依据。corrected_json为完整修正版条目，无需修订则null。

## 第二部分：模板C 只读语义审计

基于A审校后的原文，逐条核对真实Lean定义展开、对象/域/量词/前提/全部结论；判断[EXTRA]是否合理，不能接受True、P→P、结论作前提或偷换对象。证明是否sorry与签名语义判定分开；只读，不修文件不写证明。verdict仅PASS / FAIL / NEEDS_HUMAN；反例有则明确给出，建议修复须指出缺失或强化；原文错误不得静默改成真命题。

## 本批输入

### MD-1.5.2-FirstIntegral

```json
{
  "source_id": "MD-1.5.2-FirstIntegral",
  "kind": "definition",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "Another term for constants of motion is first integral. In general, if we have a dynamical system $\\dot{\\boldsymbol z}=f(\\boldsymbol z)$, a first integral is a smooth function $I(\\boldsymbol z)$ which is constant along solutions, for all values of the initial condition.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "IsFirstIntegralOn量化每条真实曲线及其存在区间，不附加全局存在。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.smoothFirstIntegral",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-109"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def smoothFirstIntegral {n : ℕ} (f : Position n → Position n) (Q : Set (Position n))
    (I : Position n → ℝ) : Prop := ContDiffOn ℝ ∞ I Q ∧ IsFirstIntegralOn f Q I
```

### MD-1.5.2-FirstIntegralCriterion

```json
{
  "source_id": "MD-1.5.2-FirstIntegralCriterion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "Since this should hold everywhere, the condition for $I$ to be a first integral is that $\\nabla I\\cdot f=0$.",
  "proof_latex": "Let $\\boldsymbol z(t)$ ($t\\in\\mathbb R$) be a solution, then\n\\[I(\\boldsymbol z(t))=I(\\boldsymbol z(0))\\Rightarrow0=\\frac{\\mathrm d}{\\mathrm dt}I(\\boldsymbol z(t))=\\nabla I(\\boldsymbol z(t))\\cdot\\dot{\\boldsymbol z}(t)=\\nabla I(\\boldsymbol z(t))\\cdot f(\\boldsymbol z(t)).\\]",
  "proof_note": "按渲染原页逐字转录原文论证。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.firstintegralcriterion",
  "extra_assumptions": [
    "开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral_gradient_criterion。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-110"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem firstintegralcriterion :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (Q : Set E) (J : E → ℝ)
    (hQ : IsOpen Q) (hf : ∀ x ∈ Q, ContDiffAt ℝ 1 f x)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x),
    IsFirstIntegralOn f Q J ↔ ∀ x ∈ Q, fderiv ℝ J x (f x) = 0
```

### MD-1.5.2-PlanarGraphReduction

```json
{
  "source_id": "MD-1.5.2-PlanarGraphReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "In principle, such an equation can be solved (locally at least) for $y$ as a function of $x$ due to the implicit function theorem. Hence one may write $y=\\psi(x)$. Reinsert this into the first differential equation to get a reduced equation in just one dependent variable:\n\\[\\frac{\\mathrm dx}{\\mathrm dt}=g(x,\\psi(x)).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "正文前句二维f=(g,h)且第一积分I(x,y)=I0；不把IsFirstIntegralOn当证明目标假设，它是本条原文已有第一积分。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.planargraphreduction",
  "extra_assumptions": [
    "对y偏导非零，真实strict导数，局部时间窗；原文省略隐函数非退化条件。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-111",
    "CH01-112"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem planargraphreduction :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J)
    (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (L : (ℝ × ℝ) →L[ℝ] ℝ) (hJ : HasStrictFDerivAt J L (γ t₀))
    (hpartial : L (0, 1) ≠ 0),
    ∃ ψ : ℝ → ℝ, ψ (γ t₀).1 = (γ t₀).2 ∧ DifferentiableAt ℝ ψ (γ t₀).1 ∧
      (∀ᶠ v in 𝓝 (γ t₀), J v = J (γ t₀) ↔ ψ v.1 = v.2) ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).2 = ψ (γ t).1 ∧
        HasDerivAt (fun u => (γ u).1) ((f ((γ t).1, ψ (γ t).1)).1) t)
```

### MD-1.5.2-PlanarQuadrature

```json
{
  "source_id": "MD-1.5.2-PlanarQuadrature",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "Such an ordinary differential equation is said to be separable, and theoretically can be solved, given an initial condition, for x as a function of t.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.planarquadrature",
  "extra_assumptions": [
    "正则第一积分图及非转向速度非零；真实C2、局部积分逆。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-113"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem planarquadrature :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J) (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (hJ : ContDiffAt ℝ 1 J (γ t₀)) (hf : ContDiffAt ℝ 1 f (γ t₀))
    (hpartial : (fderiv ℝ J (γ t₀)) (0, 1) ≠ 0) (hspeed : (f (γ t₀)).1 ≠ 0),
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (f (γ t₀)).1 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1,
        g (separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (γ t).1 = t - t₀)
```

### MD-1.5.2-ScalarFirstIntegral

```json
{
  "source_id": "MD-1.5.2-ScalarFirstIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "28",
  "pdf_page": "51",
  "statement_latex": "Example 1.6 The single degree of freedom model of Example 1.4 has the energy as a first integral. The system is therefore integrable.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.scalar_first_integral_and_quadrature",
  "extra_assumptions": [
    "U C2；开放时间段真实解、积分逆图使用速度非零点；转向点全局拼接不声称已有证明。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-114"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem scalar_first_integral_and_quadrature :
  (∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U),
    IsFirstIntegralOn (scalarPotentialVectorField U) univ (scalarPotentialEnergy U)) ∧
  (∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hv₀ : (γ t₀).2 ≠ 0),
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (γ t₀).2 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1, g (separableTimePrimitive ψ (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive ψ (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive ψ (γ t₀).1 (γ t).1 = t - t₀))
```

### MD-1.5.2-KeplerEnergy

```json
{
  "source_id": "MD-1.5.2-KeplerEnergy",
  "kind": "definition",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "Example 1.7 The Kepler problem describes the motion of a body in the plane moving under gravitational force exerted by a second, fixed body (located at the origin); it has the energy $E(x,y,\\dot x,\\dot y)=\\dot x^2/2+\\dot y^2/2-1/\\sqrt{x^2+y^2}$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "x²+y²>0非碰撞域；单位质量和引力系数。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.planarKeplerEnergy",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-115"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def planarKeplerEnergy (x y v w : ℝ) : ℝ :=
  v^2/2 + w^2/2 - 1/Real.sqrt (x^2+y^2)
```

### MD-1.5.2-KeplerConservedEnergy

```json
{
  "source_id": "MD-1.5.2-KeplerConservedEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "The two conserved quantities, energy and angular momentum, mean that the Kepler problem is an integrable system.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "本条保留整句全部结论；旋转对称理由另见KeplerAngularMomentum；完整重建公式另见KeplerFullSolution。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.kepler_energy_angular_integrability",
  "extra_assumptions": [
    "真实平面非碰撞机械解；积分重建的整个存在区间含0，角为连续实提升；不声称穿越碰撞的全局轨道。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-116"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem kepler_energy_angular_integrability :
  (∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ s) =
      massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ t)) ∧
  (∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t)) ∧
  (∀ (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z),
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = (fun r θ : ℝ => (WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ] : Position 2)) (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = (((fun r θ : ℝ => (WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ] : Position 2)) (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀]))
```

### MD-1.5.2-KeplerAngularMomentum

```json
{
  "source_id": "MD-1.5.2-KeplerAngularMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "however, due to the fact that the potential energy is rotationally invariant (dependent only on the distance of the moving particle from the origin), the angular momentum of the system is conserved.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$l_z=x\\dot y-y\\dot x$，p.29同页；非碰撞真轨迹。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.keplerangularmomentum",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-117"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem keplerangularmomentum :
  ∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t)
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
