# 第1章导师快速审阅（15条）

详表与全部差异见 CH01_REVIEW.zh-CN.md；这里挑出基础守恒、Theorem 1.1及最重要的覆盖边界。

| 状态 | 条数 |
| --- | ---: |
| proved | 158 |
| statement_only | 35 |
| weakened | 13 |
| not_formalizable_now | 1 |
| 合计 | 207 |

proved中有106条notation/定义、52条数学结论；完整章节交付包含未证明的忠实陈述。

需要人工判断的问题：

1. 印刷32的Hartman–Grobman是否应将smooth invertible map改为局部homeomorphism？本交付保留字面未证明Prop。
2. 印刷37的“极小点Hessian正定”是否应改为半正定并另加非退化条件？x^4的严格极小已提示该问题。
3. 印刷44的W应在初值xi处取流导数，而非z(t,xi)处吗？字面与修正版均给出，现有证明仅常系数。
4. 印刷34任意均匀势的正则晶格极小、印刷39定角速度、印刷40正能量必逃逸，哪些需要补假设或降为经验说明？
5. 定性势模型模板、有限27副本PBC及高维无共振/紧正则层假设是否忠实体现本章希望交付的范围？拓扑传递与遍历性还需指定不变测度。


### CH01-054 · 定义 · 印刷p.18 / PDF41

原文（忠实转述）：Total energy is kinetic energy plus U, (1.4).

```lean
noncomputable def nBodyTotalEnergy {n : ℕ} (masses : CoordinateMasses n)
    (potential : PotentialEnergy n) (position : Position n) (velocity : Velocity n) : ℝ :=
  nBodyKineticEnergy masses velocity + potential position
```

差异及额外假设：展开坐标形式等价粒子形式。

状态：**proved**。位置：`MolecularDynamics/Chapter01/NBody.lean:53`。

### CH01-056 · 未编号结论 · 印刷p.19 / PDF42

原文（忠实转述）：Total energy is constant along a solution.

```lean
theorem mechanical_energy_const_on_Ioo {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b : ℝ) (γ : ℝ → PhaseSpace n)
    (hm : ∀ i, 0 < m i)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    massHamiltonian m U (γ s) = massHamiltonian m U (γ t)
```

差异及额外假设：开放连通时间区间；非全局存在假设。

状态：**proved**。位置：`MolecularDynamics/Chapter01/EnergyConservation.lean:47`。

### CH01-073 · 未编号结论 · 印刷p.23 / PDF46

原文（忠实转述）：Newton's equations can be written as the Euler-Lagrange equations.

```lean
theorem mechanicalSolution_eulerLagrange {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (Q : Set (Position n))
    (I : Set ℝ) (γ : ℝ → PhaseSpace n) (hm : ∀ i, 0 < m i)
    (hI : IsOpen I) (hγ : IsMechanicalSolutionOn m (fun q => -gradient U q) Q I γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q) :
    IsEulerLagrangeTrajectoryOn m U Q I (fun t => (γ t).1)
```

差异及额外假设：固定质量，势可微。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Lagrangian.lean:83`。

### CH01-083 · 未编号结论 · 印刷p.24 / PDF47

原文（忠实转述）：The mechanical Hamiltonian is the Legendre supremum of L in velocity.

```lean
theorem massHamiltonian_eq_legendre_sup {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n)
    (hm : ∀ i, 0 < m i) :
    BddAbove (range (fun v : Velocity n => inner ℝ p v - massLagrangian m U q v)) ∧
    sSup (range (fun v : Velocity n => inner ℝ p v - massLagrangian m U q v)) =
      massHamiltonian m U (q, p)

def generalizedLegendreSup_statement : Prop :=
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n), (M q).PosDef →
    sSup (range (fun v => inner ℝ p v - quadraticL M U q v)) = quadraticH M U q p
```

差异及额外假设：固定正对角质量；正定性强于原文字面仅可逆，原文缺条件。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/LegendreTransform.lean:88;MolecularDynamics/Chapter01/Statements.lean:85`。

### CH01-095 · 未编号结论 · 印刷p.26 / PDF49

原文（忠实转述）：Smooth solutions confined to a compact nonsingular set extend globally.

```lean
theorem exists_globalMechanicalSolution_of_local_compact_confinement {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {K : Set (PhaseSpace n)}
    {a t₀ b₀ : ℝ} {z₀ : PhaseSpace n} {γ₀ : ℝ → PhaseSpace n}
    (hat : a < t₀) (htb : t₀ < b₀) (hQ : IsOpen Q)
    (hF : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hγ₀ : IsMechanicalSolutionOn m F Q (Ioo a b₀) γ₀) (hinit₀ : γ₀ t₀ = z₀)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q)
    (hconfine : ∀ b γ, t₀ < b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ t₀ = z₀ → ∀ t ∈ Ioo a b, t₀ ≤ t → γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q (Ioi a) γ ∧ γ t₀ = z₀ ∧
      ∀ t, t₀ ≤ t → γ t ∈ K
```

差异及额外假设：紧集在开放力C1域内部，真实延拓链。

状态：**proved**。位置：`MolecularDynamics/Chapter01/GlobalContinuation.lean:55`。

### CH01-105 · 未编号结论 · 印刷p.27 / PDF50

原文（忠实转述）：The eigenvector column matrix X is invertible and coefficients satisfy xi=Xc.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem basisColumnMatrix_inverse_coefficients {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    (basisColumnMatrix b)⁻¹.mulVec (WithLp.ofLp z) = b.repr z
```

差异及额外假设：真实基，repr系数。

状态：**proved**。位置：`MolecularDynamics/Chapter01/BasisMatrix.lean:36`。

### CH01-109 · 定义 · 印刷p.28 / PDF51

原文（忠实转述）：A first integral is a smooth scalar function constant along every solution.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def IsFirstIntegralOn (f : E → E) (Q : Set E) (J : E → ℝ) : Prop :=
  ∀ (a b : ℝ) (γ : ℝ → E),
    (∀ t ∈ Ioo a b, γ t ∈ Q) →
    (∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) →
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b, J (γ s) = J (γ t)
```

差异及额外假设：开放位置域与解区间接口。

状态：**proved**。位置：`MolecularDynamics/Chapter01/FirstIntegrals.lean:15`。

### CH01-126 · 未编号结论 · 印刷p.30 / PDF53

原文（忠实转述）：The complete Kepler motion is reconstructed from radial quadrature and angular integration.

```lean
theorem exists_kepler_localIVP_radialReconstruction (t₀ : ℝ) (z₀ : PhaseSpace 2) (hz : z₀.1 ≠ 0) :
    ∃ (r₀ θ₀ v₀ ε : ℝ) (r v : ℝ → ℝ), 0 < r₀ ∧ 0 < ε ∧ r t₀ = r₀ ∧ v t₀ = v₀ ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-(r t ^ 2)⁻¹ + (planarAngularMomentum z₀) ^ 2 / r t ^ 3) t) ∧
      IsLocalMechanicalIVP (fun _ => (1 : ℝ)) keplerForce {q : Position 2 | q ≠ 0}
        t₀ z₀ ε (fun t => polarCartesianState (r t)
          (keplerReconstructedAngle (planarAngularMomentum z₀) t₀ θ₀ r t)
          (v t) (planarAngularMomentum z₀ / r t ^ 2))

def keplerFullReconstruction_statement : Prop :=
  ∀ (a b t₀ : ℝ) (r v : ℝ → ℝ) (ℓ θ₀ : ℝ), t₀ ∈ Ioo a b →
    (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t) →
    let θ := fun t => θ₀ + ∫ s in t₀..t, ℓ/(r s)^2
    ∃ q p : ℝ → Position 2,
      (∀ t ∈ Ioo a b, q t = WithLp.toLp 2 ![r t*Real.cos (θ t),r t*Real.sin (θ t)]) ∧
      (∀ t ∈ Ioo a b, HasDerivAt q (p t) t ∧
        HasDerivAt p (keplerForce (q t)) t)
```

差异及额外假设：已证局部重建，未证穿越全部转向点的全局拼接。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/KeplerReconstruction.lean:168;MolecularDynamics/Chapter01/Statements.lean:130`。

### CH01-133 · 未编号结论 · 印刷p.30 / PDF53

原文（忠实转述）：Incommensurate frequencies yield nonperiodic quasiperiodic motion filling a torus.

```lean
theorem harmonicTorusRotation_two_dense (Ω₀ Ω₁ : ℝ) (hΩ₀ : Ω₀ ≠ 0)
    (hirr : Irrational (Ω₁ / Ω₀)) (θ : HarmonicTorus 2) :
    DenseRange (fun t : ℝ => harmonicTorusRotation ![Ω₀, Ω₁] t θ)

def torusDense_statement : Prop :=
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ)
```

差异及额外假设：仅2维无理频率比稠密；高维须所有整数关系无共振，补原意陈述。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/TorusDensity.lean:62;MolecularDynamics/Chapter01/Statements.lean:139`。

### CH01-134 · 未编号结论 · 印刷p.30 / PDF53

原文（忠实转述）：Independent first integrals in involution permit a local action-angle reduction.

```lean
def liouvilleArnold_statement : Prop :=
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    IsCompact S → IsConnected S →
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩)
```

差异及额外假设：已给局部辛action-angle及全环面运动的忠实Prop；补充紧、连通、满秩正则层等标准条件。固定Mathlib缺完整Liouville-Arnold、辛流形与action-angle坐标证明基础，本阶段不搭建。

状态：**not_formalizable_now**。位置：`MolecularDynamics/Chapter01/Statements.lean:158`。

### CH01-140 · 未编号结论 · 印刷p.32 / PDF55

原文（忠实转述）：Hartman-Grobman: nonlinear and linear systems near a hyperbolic equilibrium are conjugate by a smooth invertible local map.

```lean
def hartmanGrobmanLiteral_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x)
```

差异及额外假设：忠实保留smooth，通常定理仅homeomorphism；疑似原文过强，不能证明假命题；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:179`。

### CH01-145 · 定理 · 印刷p.32 / PDF55

原文（忠实转述）：Theorem 1.1: a strong local minimum of smooth U gives stable z*=(q*,0).

```lean
theorem strictPotentialMin_futureStableEuclidean_of_smooth {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ ∞ U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStableEuclidean m (fun q => -gradient U q) Q
      (q₀, (0 : Momentum n))
```

差异及额外假设：正固定质量，U在q*附近光滑，欧氏稳定及未来解存在。

状态：**proved**。位置：`MolecularDynamics/Chapter01/EuclideanStability.lean:72`。

### CH01-169 · 未编号结论 · 印刷p.37 / PDF60

原文（忠实转述）：At a minimum U'' is a positive definite symmetric matrix.

```lean
def minimumHessianLiteral_statement : Prop :=
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v)
```

差异及额外假设：字面正定通常应为半正定；x^4反例，不能静默增加非退化假设；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:219`。

### CH01-192 · 未编号结论 · 印刷p.44 / PDF67

原文（忠实转述）：Differentiating the flow Jacobian gives Wdot=f'(z(t,xi)) W, (1.10).

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem linearExponentialFlow_isConstantVariationalSolution
    (A : E →L[ℝ] E) (w₀ : E) :
    IsConstantVariationalSolution A (fun t => linearExponentialFlow A t w₀) w₀

def variationalEquationLiteral_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral F ξ t)) t

def variationalEquation_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → ContDiff ℝ 1 (Function.uncurry F) → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => fderiv ℝ (F s) ξ)
      ((fderiv ℝ f (F t ξ)).comp (fderiv ℝ (F t) ξ)) t
```

差异及额外假设：已有常系数完整证明；补齐打印W取值点字面Prop及在初值xi取导数的修正版Prop；一般非线性均未证明，不能用常系数冒充。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/VariationalEquation.lean:29;MolecularDynamics/Chapter01/Statements.lean:285;MolecularDynamics/Chapter01/Statements.lean:280`。

### CH01-196 · 定义 · 印刷p.45 / PDF68

原文（忠实转述）：lambda_i=limsup_{t->infinity} (1/t) log sigma_i(W(t)).

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def lyapunovExponent (σ : ℝ → ℝ) : EReal :=
  Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop
```

差异及额外假设：扩展实值limsup，W可逆避免log0；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:162`。
