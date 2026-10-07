# 第1章人工审阅材料

正文：印刷1–46 / PDF24–69；Exercises从印刷46中途开始，全部排除。清单是唯一进度来源。
`proved`含已实现的定义和完整证明的结论，不能把两者都称为定理证明数量；`statement_only`与`not_formalizable_now`仅有Prop陈述，编译通过不等于命题成立。
旧成果复用固定版本正式库；新增结果的机器验证见 `CH01_VALIDATION.json`。负责人原文语义审阅尚未进行，本文件就是待审材料。
类型别名和定义需要展示定义体；定理只展示陈述，不展示证明。代码块需在工程导入、命名空间及各节的隐式参数环境中阅读，不能逐块独立编译。
新增配置相关质量采用正定性；旧成果多为固定正对角质量。物理奇异公式限制到备注中的正距离等域。

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

全部待证或有差异的条目：

- CH01-016（§1.1.1，p.8，statement_only）：The Morse potential has its minimum at r_e and well depth D.
- CH01-022（§1.1.1，p.11，statement_only）：The Lennard-Jones potential tends to positive infinity as r tends to zero.
- CH01-025（§1.1.2，p.12，statement_only）：Coulomb forces attract opposite charges and repel charges of the same sign.
- CH01-031（§1.1.2，p.14，weakened）：Stillinger-Weber models contain two-body and three-body terms favoring tetrahedral structures.
- CH01-032（§1.1.2，p.14，weakened）：Embedded Atom potentials include local electron-cloud density contributed by neighbors.
- CH01-033（§1.1.2，p.14，weakened）：Bond Order potentials depend on the local bonding structure.
- CH01-034（§1.1.2，p.15，weakened）：United-atom models group atoms into pseudoatoms and sum their effective interactions.
- CH01-052（§1.2，p.18，statement_only）：Without constraints N_d=N_c=3N; r independent constraints give N_d=N_c-r.
- CH01-058（§1.2，p.19，statement_only）：Pair forces obey F_ij=-F_ji and the sum of internal forces vanishes.
- CH01-067（§1.2，p.20，statement_only）：Global scalar solutions require concatenating local descriptions; degenerate turning points need separate treatment.
- CH01-069（§1.2，p.21，statement_only）：The force for a radial pair potential follows by the chain rule.
- CH01-071（§1.3，p.22，statement_only）：The principle of least action is a variational characterization of the equations.
- CH01-080（§1.4，p.24，weakened）：For a mechanical quadratic L the maximizing velocity is M(q)^(-1)p.
- CH01-081（§1.4，p.24，weakened）：p=partial L/partial qdot=M(q) qdot.
- CH01-083（§1.4，p.24，weakened）：The mechanical Hamiltonian is the Legendre supremum of L in velocity.
- CH01-086（§1.4，p.25，statement_only）：The Hamiltonian and Lagrangian formulations are interchangeable for regular mechanical models.
- CH01-088（§1.4，p.25，statement_only）：An N-particle phase point in three dimensions has 6N real coordinates.
- CH01-094（§1.5，p.26，weakened）：Uniformly bounded potential levels together with energy conservation confine solutions to a compact set.
- CH01-097（§1.5，p.26，statement_only）：U(x,y)=x^2 does not bound y at constant energy.
- CH01-124（§1.5.2，p.30，weakened）：The Kepler radius can be expressed via scalar quadratures and their inverses.
- CH01-126（§1.5.2，p.30，weakened）：The complete Kepler motion is reconstructed from radial quadrature and angular integration.
- CH01-133（§1.5.2，p.30，weakened）：Incommensurate frequencies yield nonperiodic quasiperiodic motion filling a torus.
- CH01-134（§1.5.2，p.30，not_formalizable_now）：Independent first integrals in involution permit a local action-angle reduction.
- CH01-140（§1.5.3，p.32，statement_only）：Hartman-Grobman: nonlinear and linear systems near a hyperbolic equilibrium are conjugate by a smooth invertible local map.
- CH01-142（§1.5.3，p.32，statement_only）：Stability of a hyperbolic nonlinear equilibrium is determined by stability of its linearization.
- CH01-147（§1.5.3，p.33，statement_only）：A positive definite Hessian makes the quadratic Hamiltonian a strong local minimum.
- CH01-148（§1.5.3，p.33，statement_only）：Positive distinct Hessian eigenvalues imply a strong local minimum of U.
- CH01-150（§1.6，p.33，statement_only）：The unordered pair count is N(N-1)/2.
- CH01-155（§1.6，p.34，weakened）：Periodic boundary conditions preserve translations and thus momentum for internal pair forces.
- CH01-157（§1.6，p.34，statement_only）：For a uniform pair potential with periodic boundaries energy minimizers are regular lattices.
- CH01-169（§1.6.1，p.37，statement_only）：At a minimum U'' is a positive definite symmetric matrix.
- CH01-171（§1.6.1，p.37，statement_only）：For positive definite M and Hessian, the eigenvalues of A are purely imaginary pairs plus/minus i Omega.
- CH01-172（§1.6.1，p.37，statement_only）：An imaginary eigenpair gives conjugate exponential normal-mode solutions.
- CH01-175（§1.7，p.38，statement_only）：For central forces partial_i U_ij=-partial_j U_ij.
- CH01-177（§1.7，p.39，statement_only）：Central pair torques cancel and total angular momentum is conserved.
- CH01-178（§1.7，p.39，statement_only）：The center of mass moves linearly under zero net force.
- CH01-179（§1.7，p.39，statement_only）：Conservation of angular momentum is said to imply rotation at a constant rate in time.
- CH01-186（§1.7.1，p.42，statement_only）：Topological transitivity is essentially equivalent to ergodicity.
- CH01-192（§1.7.2，p.44，weakened）：Differentiating the flow Jacobian gives Wdot=f'(z(t,xi)) W, (1.10).
- CH01-193（§1.7.2，p.45，statement_only）：Nearby trajectories differ to first order by W(t)(xi_hat-xi).
- CH01-195（§1.7.2，p.45，statement_only）：An invertible linear map sends a unit sphere to an ellipsoid whose semi-axes are its singular values.
- CH01-197（§1.7.2，p.45，statement_only）：A positive Lyapunov exponent implies exponential amplification of infinitesimal perturbations.
- CH01-198（§1.1.1，p.11，statement_only）：Finite conserved energy and a repulsive Lennard-Jones singularity prevent particle collisions.
- CH01-199（§1.2，p.21，statement_only）：The normalized coordinates Q_i=q_i/sigma have qdot_i=sigma Qdot_i and qddot_i=sigma Qddot_i.
- CH01-200（§1.2，p.22，statement_only）：With tau=alpha t and alpha^2=epsilon/(m sigma^2), normalized LJ dynamics have unit mass and parameter-independent potential.
- CH01-201（§1.5.2，p.29，statement_only）：In the fixed-center Kepler problem linear momentum is generally not conserved.
- CH01-203（§1.7，p.38，statement_only）：For the unit LJ trimer an equilateral triangle minimizes U=3 phi_LJ(r), at r=2^(1/6).
- CH01-206（§1.7，p.40，statement_only）：The minimum in the collinear configuration is a saddle: U increases along x and decreases along y.
- CH01-207（§1.7，p.40，statement_only）：When E>0 the trimer bodies eventually escape to infinity.

## §1.1

### CH01-001 · notation · 印刷p.5 / PDF28

原文（忠实转述）：The wave function is complex valued in the particle position coordinates and time.

```lean
abbrev waveFunction := ℝ → Q13 → ℂ
```

差异及额外假设：量子背景；不声称存在解；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:16`。

### CH01-002 · notation · 印刷p.5 / PDF28

原文（忠实转述）：i is the square root of minus one.

```lean
def imaginaryUnit : ℂ := Complex.I
```

差异及额外假设：复数单位；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:17`。

### CH01-003 · notation · 印刷p.5 / PDF28

原文（忠实转述）：hbar is Planck's constant.

```lean
abbrev planckConstant := {h : ℝ // 0 < h}
```

差异及额外假设：正参数，不登记实验数值；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:18`。

### CH01-004 · notation · 印刷p.5 / PDF28

原文（忠实转述）：mu_j is the mass of particle j.

```lean
abbrev quantumMass := Fin 13 → {m : ℝ // 0 < m}
```

差异及额外假设：正质量；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:19`。

### CH01-005 · 定义 · 印刷p.5 / PDF28

原文（忠实转述）：U_P is the primitive particle potential energy.

```lean
abbrev primitivePotential := Q13 → ℝ
```

差异及额外假设：实值位置函数；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:20`。

### CH01-006 · 定义 · 印刷p.5 / PDF28

原文（忠实转述）：The Schrodinger equation (1.1) is i hbar d_t Phi = -hbar^2 sum_j Laplacian_j(Phi)/(2 mu_j) + U_P Phi.

```lean
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q
```

差异及额外假设：保留原式13粒子；只定义满足方程关系；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:25`。

### CH01-007 · 定义 · 印刷p.6 / PDF29

原文（忠实转述）：The Born-Oppenheimer potential U depends on nuclear positions only.

```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```

差异及额外假设：给定实值函数；不证明量子到经典的近似有效性。

状态：**proved**。位置：`MolecularDynamics/Notation.lean:21`。

### CH01-008 · 未编号结论 · 印刷p.6 / PDF29

原文（忠实转述）：For each nuclear coordinate, m_i d^2 q_i/dt^2 = -partial U/partial q_i, equation (1.2).

```lean
theorem solution_nBodyEquationAt_of_differentiable {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (U : PotentialEnergy n) (Q : Set (Position n))
    (I : Set ℝ) (γ : ℝ → PhaseSpace n) (hμ : ∀ i, 0 < μ i)
    (hI : IsOpen I) (hγ : IsMechanicalSolutionOn μ F Q I γ)
    (_hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hFU : ∀ q ∈ Q, F q = -gradient U q) (t : ℝ) (ht : t ∈ I) :
    NBodyEquationAt μ F U (γ t).1 (deriv (deriv (fun s => (γ s).1)) t)
```

差异及额外假设：正质量、实际二阶导数、势可微、存在区间。

状态：**proved**。位置：`MolecularDynamics/Chapter01/LocalTrajectories.lean:167`。

### CH01-009 · 定义 · 印刷p.6 / PDF29

原文（忠实转述）：Initial positions and velocities at a specified time supplement Newton's equations.

```lean
def initialData {n : ℕ} (q : ℝ → Position n) (t₀ : ℝ)
    (q₀ v₀ : Position n) : Prop := q t₀ = q₀ ∧ HasDerivAt q v₀ t₀
```

差异及额外假设：初值关系；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:31`。

### CH01-010 · 定义 · 印刷p.7 / PDF30

原文（忠实转述）：Hard spheres are impenetrable and interact by perfectly elastic collisions.

```lean
def hardSphereCollision (R₁ R₂ m₁ m₂ : ℝ) (q₁ q₂ v₁ v₂ w₁ w₂ : V3) : Prop :=
  0 < R₁ ∧ 0 < R₂ ∧ 0 < m₁ ∧ 0 < m₂ ∧ dist q₁ q₂ = R₁+R₂ ∧
  m₁ • v₁ + m₂ • v₂ = m₁ • w₁ + m₂ • w₂ ∧
  m₁ * ‖v₁‖^2 / 2 + m₂ * ‖v₂‖^2 / 2 = m₁ * ‖w₁‖^2 / 2 + m₂ * ‖w₂‖^2 / 2
```

差异及额外假设：瞬时碰撞模型；不证明事件驱动解存在；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:33`。

## §1.1.1

### CH01-011 · notation · 印刷p.8 / PDF31

原文（忠实转述）：q_i is the position vector of atom i in R^3.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
abbrev ParticleVectors (N d : ℕ) := Fin N → EuclideanSpace ℝ (Fin d)
```

差异及额外假设：d=3实例；通用d接口。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ParticleCoordinates.lean:22`。

### CH01-012 · 定义 · 印刷p.8 / PDF31

原文（忠实转述）：The potential is a sum of two-body contributions U_ij(q_i,q_j).

```lean
abbrev twoBodyTerms := V3 → V3 → ℝ
```

差异及额外假设：有限索引；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:37`。

### CH01-013 · 定义 · 印刷p.8 / PDF31

原文（忠实转述）：Three-body contributions are U_ijk(q_i,q_j,q_k).

```lean
abbrev threeBodyTerms := V3 → V3 → V3 → ℝ
```

差异及额外假设：有限索引；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:38`。

### CH01-014 · 定义 · 印刷p.8 / PDF31

原文（忠实转述）：Four-body contributions are U_ijkl(q_i,q_j,q_k,q_l).

```lean
abbrev fourBodyTerms := V3 → V3 → V3 → V3 → ℝ
```

差异及额外假设：有限索引；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:39`。

### CH01-015 · 定义 · 印刷p.8 / PDF31

原文（忠实转述）：The Morse potential is D(1-exp(-a(r-r_e)))^2.

```lean
def morsePotential (D a rₑ r : ℝ) := D * (1 - Real.exp (-a * (r-rₑ)))^2
```

差异及额外假设：D,a,r_e正；r>0物理域；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:40`。

### CH01-016 · 未编号结论 · 印刷p.8 / PDF31

原文（忠实转述）：The Morse potential has its minimum at r_e and well depth D.

```lean
def morseMinimum_statement : Prop :=
  ∀ D a rₑ : ℝ, 0 < D → 0 < a → 0 < rₑ →
    (∀ r > 0, 0 ≤ morsePotential D a rₑ r) ∧
    morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D)
```

差异及额外假设：D,a正；深度是无穷远极限减最小值；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:18`。

### CH01-017 · 定义 · 印刷p.9 / PDF32

原文（忠实转述）：The harmonic length-bond potential is k_ij/2 (r_ij-r_ij^0)^2.

```lean
def lengthBond (k r₀ r : ℝ) := k / 2 * (r-r₀)^2
```

差异及额外假设：正弹性系数；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:41`。

### CH01-018 · notation · 印刷p.9 / PDF32

原文（忠实转述）：r_ij = norm(q_i-q_j).

```lean
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
```

差异及额外假设：三维欧氏范数；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:42`。

### CH01-019 · 定义 · 印刷p.10 / PDF33

原文（忠实转述）：London dispersion is modeled by -K/r^6 with K>0.

```lean
def dispersionPotential (K r : ℝ) := -K / r^6
```

差异及额外假设：r>0；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:43`。

### CH01-020 · 定义 · 印刷p.10 / PDF33

原文（忠实转述）：The Buckingham potential is A exp(-Br)-C/r^6, with A,B,C>0.

```lean
def buckinghamPotential (A B C r : ℝ) := A * Real.exp (-B*r) - C/r^6
```

差异及额外假设：r>0；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:44`。

### CH01-021 · 定义 · 印刷p.10 / PDF33

原文（忠实转述）：The Lennard-Jones potential is 4 epsilon ((sigma/r)^12-(sigma/r)^6).

```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```

差异及额外假设：epsilon,sigma,r正；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:45`。

### CH01-022 · 未编号结论 · 印刷p.11 / PDF34

原文（忠实转述）：The Lennard-Jones potential tends to positive infinity as r tends to zero.

```lean
def lennardJonesSingularity_statement : Prop :=
  ∀ ε σ : ℝ, 0 < ε → 0 < σ →
    Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop
```

差异及额外假设：右极限，正epsilon及sigma；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:22`。

### CH01-023 · 定义 · 印刷p.11 / PDF34

原文（忠实转述）：For different atom types epsilon_ij and sigma_ij determine the pair LJ contribution.

```lean
def heterogeneousLJ {N : ℕ} (ε σ : Fin N → Fin N → ℝ)
    (q : Fin N → V3) (i j : Fin N) :=
  lennardJonesPotential (ε i j) (σ i j) (pairDistance (q i) (q j))
```

差异及额外假设：逐对参数；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:46`。

### CH01-198 · 未编号结论 · 印刷p.11 / PDF34

原文（忠实转述）：Finite conserved energy and a repulsive Lennard-Jones singularity prevent particle collisions.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def ljCollisionAvoidance_statement : Prop :=
  ∀ (N : ℕ) (ε σ E : ℝ), 0 < ε → 0 < σ → ∃ δ > 0,
    ∀ q : Fin N → V3, (∀ i j, i ≠ j → q i ≠ q j) →
      uniformLJEnergy ε σ q ≤ E → ∀ i j, i ≠ j → δ ≤ pairDistance (q i) (q j)
```

差异及额外假设：有限粒子，每对势有统一下界；只陈述能量子水平集上正距离界；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:305`。

## §1.1.2

### CH01-024 · 定义 · 印刷p.12 / PDF35

原文（忠实转述）：The Coulomb potential is C Q_i Q_j/(dielectric r_ij).

```lean
def coulombPotential (C Qᵢ Qⱼ dielectric r : ℝ) := C*Qᵢ*Qⱼ/(dielectric*r)
```

差异及额外假设：正dielectric、C，非碰撞；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:49`。

### CH01-025 · 未编号结论 · 印刷p.12 / PDF35

原文（忠实转述）：Coulomb forces attract opposite charges and repel charges of the same sign.

```lean
def coulombForceSign_statement : Prop :=
  ∀ C Qᵢ Qⱼ dielectric r : ℝ, 0 < C → 0 < dielectric → 0 < r →
    -deriv (coulombPotential C Qᵢ Qⱼ dielectric) r = C*Qᵢ*Qⱼ/(dielectric*r^2) ∧
    (0 < -deriv (coulombPotential C Qᵢ Qⱼ dielectric) r ↔ 0 < Qᵢ*Qⱼ) ∧
    (-deriv (coulombPotential C Qᵢ Qⱼ dielectric) r < 0 ↔ Qᵢ*Qⱼ < 0)
```

差异及额外假设：径向负导数的符号；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:25`。

### CH01-026 · 定义 · 印刷p.12 / PDF35

原文（忠实转述）：A cutoff potential vanishes for r>r_cut and should remain at least continuously differentiable.

```lean
def smoothCutoff (φ : ℝ → ℝ) (r_cut : ℝ) : Prop :=
  ContDiff ℝ 1 φ ∧ ∀ r, r_cut < r → φ r = 0
```

差异及额外假设：性质定义；不证明任意截断连续；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:50`。

### CH01-027 · 定义 · 印刷p.12 / PDF35

原文（忠实转述）：The screened Yukawa potential is C Q_i Q_j exp(-r_ij/lambda)/(dielectric r_ij).

```lean
def yukawaPotential (C Qᵢ Qⱼ dielectric debye r : ℝ) :=
  coulombPotential C Qᵢ Qⱼ dielectric r * Real.exp (-r/debye)
```

差异及额外假设：正Debye长度；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:52`。

### CH01-028 · 定义 · 印刷p.13 / PDF36

原文（忠实转述）：An angle bond has energy k_ijk/2 (theta_ijk-theta_ijk^0)^2.

```lean
def angleBond (k θ₀ θ : ℝ) := k/2*(θ-θ₀)^2
```

差异及额外假设：正系数；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:54`。

### CH01-029 · 定义 · 印刷p.13 / PDF36

原文（忠实转述）：theta_ijk = arccos((q_i-q_j) dot (q_j-q_k)/(r_ij r_jk)).

```lean
def bondAngle (qᵢ qⱼ qₖ : V3) :=
  Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) / (pairDistance qᵢ qⱼ * pairDistance qⱼ qₖ))
```

差异及额外假设：忠实保留印刷向量方向；非零键长；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:55`。

### CH01-030 · 定义 · 印刷p.13 / PDF36

原文（忠实转述）：A dihedral potential is k(1+cos(n theta-d)).

```lean
def dihedralPotential (k n θ d : ℝ) := k*(1+Real.cos (n*θ-d))
```

差异及额外假设：角参数；位置到二面角原文未给公式；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:57`。

### CH01-031 · 定义 · 印刷p.14 / PDF37

原文（忠实转述）：Stillinger-Weber models contain two-body and three-body terms favoring tetrahedral structures.

```lean
def stillingerWeberTerms {N : ℕ} (U : (Fin N → V3) → ℝ)
    (U₂ : Fin N → Fin N → twoBodyTerms)
    (U₃ : Fin N → Fin N → Fin N → threeBodyTerms) : Prop :=
  ∀ q, U q = (∑ i, ∑ j ∈ Finset.Ioi i, U₂ i j (q i) (q j)) +
    ∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, U₃ i j k (q i) (q j) (q k)
```

差异及额外假设：仅形式化二体/三体分解；原文偏好四面体结构的定性模型性质无具体公式或条件，未证明。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:58`。

### CH01-032 · 定义 · 印刷p.14 / PDF37

原文（忠实转述）：Embedded Atom potentials include local electron-cloud density contributed by neighbors.

```lean
def embeddedAtomPotential {N : ℕ} (φ ρ : ℝ → ℝ) (F : Fin N → ℝ → ℝ)
    (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.Ioi i, φ (pairDistance (q i) (q j))) +
    ∑ i, F i (∑ j ∈ Finset.univ.erase i, ρ (pairDistance (q i) (q j)))
```

差异及额外假设：用任意嵌入函数和邻居密度参数化标准模型形式；原文无公式，具体物理模型与逼真性未经证明。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:63`。

### CH01-033 · 定义 · 印刷p.14 / PDF37

原文（忠实转述）：Bond Order potentials depend on the local bonding structure.

```lean
def bondOrderPotential {N : ℕ} (rep att : ℝ → ℝ)
    (b : (Fin N → V3) → Fin N → Fin N → ℝ) (q : Fin N → V3) :=
  ∑ i, ∑ j ∈ Finset.Ioi i,
    (rep (pairDistance (q i) (q j)) - b q i j * att (pairDistance (q i) (q j)))
```

差异及额外假设：用依赖局部配置的bond-order系数实现模型模板；原文无指定函数，不声称结构稳定性证明。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:67`。

### CH01-034 · 定义 · 印刷p.15 / PDF38

原文（忠实转述）：United-atom models group atoms into pseudoatoms and sum their effective interactions.

```lean
def unitedAtomModel {N G : ℕ} (group : Fin N → Fin G) : Prop := Function.Surjective group
```

差异及额外假设：已实现原子到pseudoatom的满射分组；有效势的物理近似/平均效应没有数学定义，未证明。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:71`。

### CH01-035 · notation · 印刷p.16 / PDF39

原文（忠实转述）：Gay-Berne uses separation q_12=q_2-q_1 and unit orientation vectors u_1,u_2.

```lean
def gayBerneGeometry (q₁ q₂ u₁ u₂ : V3) : Prop :=
  q₁ ≠ q₂ ∧ ‖u₁‖ = 1 ∧ ‖u₂‖ = 1
```

差异及额外假设：非零分离；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:72`。

### CH01-036 · 定义 · 印刷p.16 / PDF39

原文（忠实转述）：The Gay-Berne potential is 4 epsilon_GB[(sigma_0/rho)^12-(sigma_0/rho)^6].

```lean
def gayBernePotential (ε₀ σ₀ χ χ' : ℝ) (q₁ q₂ u₁ u₂ : V3) :=
  let r := q₂-q₁
  let ρ := gayBerneRho σ₀ χ r u₁ u₂
  4 * gayBerneWell ε₀ χ χ' (‖r‖⁻¹ • r) u₁ u₂ * ((σ₀/ρ)^12-(σ₀/ρ)^6)
```

差异及额外假设：保留模型定义，排除原文数值参数演示；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:84`。

### CH01-037 · 定义 · 印刷p.16 / PDF39

原文（忠实转述）：epsilon_GB = epsilon_1(u_1,u_2) epsilon_2(r_hat,u_1,u_2)^2.

```lean
def gayBerneWell (ε₀ χ χ' : ℝ) (r u₁ u₂ : V3) :=
  gayBerneEpsilonOne ε₀ χ u₁ u₂ * (gayBerneEpsilonTwo r u₁ u₂ χ')^2
```

差异及额外假设：原式指数2；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:80`。

### CH01-038 · 定义 · 印刷p.16 / PDF39

原文（忠实转述）：rho = norm(r)-sigma_0/sqrt(W(r_hat,u_1,u_2,chi)).

```lean
def gayBerneRho (σ₀ χ : ℝ) (r u₁ u₂ : V3) :=
  ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
```

差异及额外假设：物理参数域W正；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:82`。

### CH01-039 · 定义 · 印刷p.17 / PDF40

原文（忠实转述）：epsilon_1 = epsilon_0 [1-chi^2 (u_1 dot u_2)^2]^(-1/2).

```lean
def gayBerneEpsilonOne (ε₀ χ : ℝ) (u₁ u₂ : V3) :=
  ε₀ / Real.sqrt (1-χ^2*(inner ℝ u₁ u₂)^2)
```

差异及额外假设：根号内正；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:77`。

### CH01-040 · 定义 · 印刷p.17 / PDF40

原文（忠实转述）：epsilon_2 = W(r_hat,u_1,u_2,chi_prime).

```lean
def gayBerneEpsilonTwo (r u₁ u₂ : V3) (χ' : ℝ) := gayBerneW r u₁ u₂ χ'
```

差异及额外假设：代入定义；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:79`。

### CH01-041 · 定义 · 印刷p.17 / PDF40

原文（忠实转述）：W = 1-chi/2[(r_hat dot (u_1+u_2))^2/(1+chi u_1 dot u_2)+(r_hat dot (u_1-u_2))^2/(1-chi u_1 dot u_2)].

```lean
def gayBerneW (r u₁ u₂ : V3) (χ : ℝ) :=
  1 - χ/2 * ((inner ℝ r (u₁+u₂))^2/(1+χ*inner ℝ u₁ u₂) +
    (inner ℝ r (u₁-u₂))^2/(1-χ*inner ℝ u₁ u₂))
```

差异及额外假设：分母非零；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:74`。

### CH01-042 · 定义 · 印刷p.17 / PDF40

原文（忠实转述）：chi=[(sigma_e/sigma_s)^2-1]/[(sigma_e/sigma_s)^2+1].

```lean
def gayBerneChi (σₑ σₛ : ℝ) := ((σₑ/σₛ)^2-1)/((σₑ/σₛ)^2+1)
```

差异及额外假设：正形状参数；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:88`。

### CH01-043 · 定义 · 印刷p.17 / PDF40

原文（忠实转述）：chi_prime=[1-(epsilon_e/epsilon_s)^(1/mu)]/[1+(epsilon_e/epsilon_s)^(1/mu)].

```lean
def gayBerneChiPrime (εₑ εₛ μ : ℝ) :=
  (1-Real.rpow (εₑ/εₛ) (1/μ))/(1+Real.rpow (εₑ/εₛ) (1/μ))
```

差异及额外假设：正能量参数，mu非零；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:89`。

## §1.2

### CH01-044 · notation · 印刷p.18 / PDF41

原文（忠实转述）：q is the vector of all positions.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

差异及额外假设：有限维欧氏空间。

状态：**proved**。位置：`MolecularDynamics/Notation.lean:13`。

### CH01-045 · notation · 印刷p.18 / PDF41

原文（忠实转述）：qdot is the velocity vector.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

差异及额外假设：实际轨迹导数见LocalTrajectories。

状态：**proved**。位置：`MolecularDynamics/Notation.lean:14`。

### CH01-046 · notation · 印刷p.18 / PDF41

原文（忠实转述）：M is a diagonal mass matrix.

```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```

差异及额外假设：固定对角质量。

状态：**proved**。位置：`MolecularDynamics/Chapter01/NBody.lean:22`。

### CH01-047 · 定义 · 印刷p.18 / PDF41

原文（忠实转述）：F(q) = -gradient U(q).

```lean
def forceGradient_statement {n : ℕ} (U : PotentialEnergy n) (F : Force n) : Prop :=
  ∀ q, F q = -gradient U q
```

差异及额外假设：Force只给类型；忠实关系需补Prop陈述。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:37`。

### CH01-048 · 定义 · 印刷p.18 / PDF41

原文（忠实转述）：The compact Newton equation is M qddot = F(q), (1.3).

```lean
def NBodyEquationAt {n : ℕ} (masses : CoordinateMasses n) (force : Force n)
    (potential : PotentialEnergy n) (position acceleration : Position n) : Prop :=
  (diagonalMassMatrix masses).mulVec acceleration = force position ∧
    force position = -gradient potential position
```

差异及额外假设：质量作用按坐标，实际二阶导数。

状态：**proved**。位置：`MolecularDynamics/Chapter01/NBody.lean:31`。

### CH01-049 · notation · 印刷p.18 / PDF41

原文（忠实转述）：N_c=3N is the number of position coordinates in three dimensions.

```lean
def particleCoordinateEquiv (N d : ℕ) : Fin N × Fin d ≃ Fin (N * d) :=
  finProdFinEquiv
```

差异及额外假设：Fin N × Fin 3与Fin (N*3)等价。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ParticleCoordinates.lean:25`。

### CH01-050 · notation · 印刷p.18 / PDF41

原文（忠实转述）：M=diag(m_1,m_1,m_1,...,m_N,m_N,m_N).

```lean
def coordinateMassesOfParticles {N d : ℕ} (m : ParticleMasses N) :
    CoordinateMasses (N * d) :=
  fun k => m ((particleCoordinateEquiv N d).symm k).1
```

差异及额外假设：每粒子质量重复d次，d=3。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ParticleCoordinates.lean:28`。

### CH01-051 · 定义 · 印刷p.18 / PDF41

原文（忠实转述）：Degrees of freedom count the local directions in which configuration can vary.

```lean
def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)
```

差异及额外假设：用局部正则约束导数核的维数；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:91`。

### CH01-052 · 未编号结论 · 印刷p.18 / PDF41

原文（忠实转述）：Without constraints N_d=N_c=3N; r independent constraints give N_d=N_c-r.

```lean
def constraintDimension_statement : Prop :=
  ∀ (n r : ℕ) (C : Position n → Position r) (q : Position n),
    DifferentiableAt ℝ C q → Function.Surjective (fderiv ℝ C q) →
    degreesOfFreedom C q + r = n
```

差异及额外假设：满秩导数，r≤N_c；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:30`。

### CH01-053 · 定义 · 印刷p.18 / PDF41

原文（忠实转述）：Kinetic energy is sum_j m_j norm(qdot_j)^2/2.

```lean
noncomputable def particleKineticEnergy {N d : ℕ}
    (m : ParticleMasses N) (v : ParticleVectors N d) : ℝ :=
  ∑ i, m i * ‖v i‖ ^ 2 / 2
```

差异及额外假设：有限粒子任意d。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ParticleCoordinates.lean:40`。

### CH01-054 · 定义 · 印刷p.18 / PDF41

原文（忠实转述）：Total energy is kinetic energy plus U, (1.4).

```lean
noncomputable def nBodyTotalEnergy {n : ℕ} (masses : CoordinateMasses n)
    (potential : PotentialEnergy n) (position : Position n) (velocity : Velocity n) : ℝ :=
  nBodyKineticEnergy masses velocity + potential position
```

差异及额外假设：展开坐标形式等价粒子形式。

状态：**proved**。位置：`MolecularDynamics/Chapter01/NBody.lean:53`。

### CH01-055 · 未编号结论 · 印刷p.19 / PDF42

原文（忠实转述）：The derivative of total energy along Newtonian solutions vanishes.

```lean
theorem mechanical_energy_hasDerivAt_zero {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n)
    (hm : ∀ i, 0 < m i) (hI : IsOpen I)
    (hγ : IsMechanicalSolutionOn m F Q I γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (t : ℝ) (ht : t ∈ I) :
    HasDerivAt (fun s => massHamiltonian m U (γ s)) 0 t
```

差异及额外假设：真实导数与势梯度关系。

状态：**proved**。位置：`MolecularDynamics/Chapter01/EnergyConservation.lean:11`。

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

### CH01-057 · notation · 印刷p.19 / PDF42

原文（忠实转述）：E denotes the fixed energy value; the energy function is distinguished from this parameter.

```lean
abbrev fixedEnergy := ℝ
```

差异及额外假设：能量层参数；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:93`。

### CH01-058 · 未编号结论 · 印刷p.19 / PDF42

原文（忠实转述）：Pair forces obey F_ij=-F_ji and the sum of internal forces vanishes.

```lean
def pairForceCancellation_statement : Prop :=
  ∀ (N : ℕ) (F : Fin N → Fin N → V3),
    (∀ i, F i i = 0) → (∀ i j, F i j = -F j i) → ∑ i, ∑ j, F i j = 0
```

差异及额外假设：只陈述反对称内部力；外力不计；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:34`。

### CH01-059 · 定义 · 印刷p.19 / PDF42

原文（忠实转述）：Momentum satisfies dp_i/dt = F_i and p_i=m_i qdot_i.

```lean
theorem momentum_eq_mass_deriv_position {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n)
    (hμ : ∀ i, 0 < μ i) (hI : IsOpen I) (hγ : IsMechanicalSolutionOn μ F Q I γ)
    (t : ℝ) (ht : t ∈ I) :
    (γ t).2 = massOperator μ (deriv (fun s => (γ s).1) t)
```

差异及额外假设：固定正质量。

状态：**proved**。位置：`MolecularDynamics/Chapter01/LocalTrajectories.lean:131`。

### CH01-060 · 定义 · 印刷p.19 / PDF42

原文（忠实转述）：The total momentum vector is sum_i p_i.

```lean
def totalMomentumCoordinate {N d : ℕ} (p : Momentum (N * d)) (a : Fin d) : ℝ :=
  ∑ i : Fin N, p (particleCoordinateEquiv N d (i, a))
```

差异及额外假设：按方向求和，逐坐标向量等价。

状态：**proved**。位置：`MolecularDynamics/Chapter01/MomentumConservation.lean:10`。

### CH01-061 · 未编号结论 · 印刷p.19 / PDF42

原文（忠实转述）：Each component of total momentum is conserved when the net force vanishes.

```lean
theorem totalMomentumCoordinate_const_on_Ioo {N d : ℕ}
    (m : CoordinateMasses (N * d)) (F : Force (N * d))
    (Q : Set (Position (N * d))) (a b : ℝ)
    (γ : ℝ → PhaseSpace (N * d))
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hFsum : ∀ q ∈ Q, ∀ c : Fin d,
      ∑ i : Fin N, F q (particleCoordinateEquiv N d (i, c)) = 0)
    (c : Fin d) (s t : ℝ)
    (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    totalMomentumCoordinate (γ s).2 c = totalMomentumCoordinate (γ t).2 c
```

差异及额外假设：净力零是物理结构假设。

状态：**proved**。位置：`MolecularDynamics/Chapter01/MomentumConservation.lean:44`。

### CH01-062 · 定义 · 印刷p.19 / PDF42

原文（忠实转述）：A unit-mass harmonic oscillator satisfies xdot=v, vdot=-Omega^2 x.

```lean
noncomputable def harmonicPotential {n : ℕ} (Ω : ℝ) : PotentialEnergy n :=
  nBodyKineticEnergy (fun _ => Ω ^ 2)
```

差异及额外假设：Omega参数；实际解另行映射。

状态：**proved**。位置：`MolecularDynamics/Chapter01/HarmonicOscillator.lean:97`。

### CH01-063 · 未编号结论 · 印刷p.20 / PDF43

原文（忠实转述）：The harmonic solution is x(t)=xi cos(Omega t)+eta sin(Omega t)/Omega.

```lean
theorem harmonicFlow_isMechanicalSolution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0)
    (z : PhaseSpace n) :
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ))
      (fun q => (-(Ω ^ 2)) • q) univ univ (fun t => harmonicFlow Ω t z)
```

差异及额外假设：Omega非零；位置与动量同时给出。

状态：**proved**。位置：`MolecularDynamics/Chapter01/HarmonicOscillator.lean:31`。

### CH01-064 · 定义 · 印刷p.20 / PDF43

原文（忠实转述）：For one degree of freedom E(x,v)=v^2/2+U(x).

```lean
def scalarPotentialEnergy (U : ℝ → ℝ) (p : ℝ × ℝ) : ℝ := p.2 ^ 2 / 2 + U p.1
```

差异及额外假设：原式单位质量。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ScalarIntegrability.lean:10`。

### CH01-065 · 未编号结论 · 印刷p.20 / PDF43

原文（忠实转述）：At a nonturning point v0!=0 the energy level solves smoothly for v=V(x;xi,eta).

```lean
theorem scalarPotential_localDescription (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) : ScalarPotentialLocalDescription U γ a b t₀
```

差异及额外假设：U光滑；局部表示，真实隐函数条件。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ScalarLocalIVP.lean:28`。

### CH01-066 · 未编号结论 · 印刷p.20 / PDF43

原文（忠实转述）：The reduced separable equation can be integrated and locally inverted to describe the solution.

```lean
theorem scalarPotential_exists_localIVP_integrable (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (z₀ : ℝ × ℝ) (t₀ : ℝ) :
    ∃ (ε : ℝ) (γ : ℝ → ℝ × ℝ), 0 < ε ∧ γ t₀ = z₀ ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), HasDerivAt γ (scalarPotentialVectorField U (γ t)) t) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), scalarPotentialEnergy U (γ t) = scalarPotentialEnergy U z₀) ∧
      ScalarPotentialLocalDescription U γ (t₀ - ε) (t₀ + ε) t₀
```

差异及额外假设：非转向初值，局部时间窗。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ScalarLocalIVP.lean:47`。

### CH01-067 · 未编号结论 · 印刷p.20 / PDF43

原文（忠实转述）：Global scalar solutions require concatenating local descriptions; degenerate turning points need separate treatment.

```lean
def scalarGlobalPatching_statement : Prop :=
  ∀ (U : ℝ → ℝ) (a b : ℝ) (z : ℝ → ℝ × ℝ),
    ContDiff ℝ ∞ U → (∀ t ∈ Ioo a b,
      HasDerivAt z (scalarPotentialVectorField U (z t)) t) →
    ∃ (J : ℝ → Set ℝ) (X V : ℝ → ℝ → ℝ),
      (∀ s ∈ Ioo a b, IsOpen (J s) ∧ s ∈ J s ∧ J s ⊆ Ioo a b) ∧
      (∀ s ∈ Ioo a b, ∀ t ∈ J s, z t = (X s t,V s t)) ∧
      (∀ s ∈ Ioo a b, ∀ r ∈ Ioo a b, ∀ t ∈ J s ∩ J r,
        X s t = X r t ∧ V s t = V r t) ∧
      ∀ s ∈ Ioo a b, ∀ t ∈ J s,
        HasDerivAt (X s) (V s t) t ∧ HasDerivAt (V s) (-deriv U (X s t)) t
```

差异及额外假设：不把已有局部证明当全局拼接；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:39`。

### CH01-068 · 定义 · 印刷p.21 / PDF44

原文（忠实转述）：A uniform pairwise LJ model sums phi_LJ(r_ij) over unordered pairs.

```lean
def uniformLJEnergy {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) :=
  ∑ i, ∑ j ∈ Finset.Ioi i, lennardJonesPotential ε σ (pairDistance (q i) (q j))
```

差异及额外假设：模型定义保留；argon数值单位及数值例子排除；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:94`。

### CH01-069 · 未编号结论 · 印刷p.21 / PDF44

原文（忠实转述）：The force for a radial pair potential follows by the chain rule.

```lean
def radialPairForce_statement : Prop :=
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x : V3 => φ ‖x-r‖) q = (deriv φ ‖q-r‖ / ‖q-r‖) • (q-r)
```

差异及额外假设：印刷首个等式符号待审，数学陈述用负梯度；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:50`。

### CH01-199 · 未编号结论 · 印刷p.21 / PDF44

原文（忠实转述）：The normalized coordinates Q_i=q_i/sigma have qdot_i=sigma Qdot_i and qddot_i=sigma Qddot_i.

```lean
def ljCoordinateScaling_statement : Prop :=
  ∀ (Q : ℝ → V3) (σ t : ℝ) (v a : V3),
    HasDerivAt Q v t → HasDerivAt (deriv Q) a t →
    HasDerivAt (fun s => σ • Q s) (σ • v) t ∧
      HasDerivAt (fun s => σ • deriv Q s) (σ • a) t
```

差异及额外假设：只保留正文链式法则推导，排除argon数值参数；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:309`。

### CH01-200 · 未编号结论 · 印刷p.22 / PDF45

原文（忠实转述）：With tau=alpha t and alpha^2=epsilon/(m sigma^2), normalized LJ dynamics have unit mass and parameter-independent potential.

```lean
def ljTimeScaling_statement : Prop :=
  ∀ (N : ℕ) (m ε σ α : ℝ) (Q : ℝ → Fin N → V3),
    0 < m → 0 < ε → 0 < σ → 0 < α → α^2=ε/(m*σ^2) →
    (∀ i, ContDiff ℝ 2 (fun t => Q t i)) →
    (∀ t i j, i ≠ j → Q t i ≠ Q t j) →
    ((∀ t i, m • deriv (deriv (fun s => σ • Q (α*s) i)) t =
      ljForce ε σ (fun j => σ • Q (α*t) j) i) ↔
    ∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i)
```

差异及额外假设：正epsilon,m,sigma；不登记数值时间单位；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:318`。

## §1.3

### CH01-070 · 定义 · 印刷p.22 / PDF45

原文（忠实转述）：The Lagrangian is L(q,v)=v^T M v/2-U(q).

```lean
noncomputable def massLagrangian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) : ℝ :=
  nBodyKineticEnergy m v - U q
```

差异及额外假设：固定正对角质量。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Lagrangian.lean:22`。

### CH01-071 · 定义 · 印刷p.22 / PDF45

原文（忠实转述）：The principle of least action is a variational characterization of the equations.

```lean
def leastAction_statement : Prop :=
  ∀ (n : ℕ) (L : Position n → Velocity n → ℝ) (q : ℝ → Position n) (a b : ℝ),
    a < b → ContDiff ℝ 2 q → ContDiff ℝ 2 (Function.uncurry L) →
    ((∀ η : ℝ → Position n, ContDiff ℝ 2 η → η a = 0 → η b = 0 →
      HasDerivAt (fun ε : ℝ => action L a b (fun t => q t + ε • η t)) 0 0) ↔
    ∀ t ∈ Ioo a b,
      HasDerivAt (fun s => gradient (L (q s)) (deriv q s))
        (gradient (fun x => L x (deriv q t)) (q t)) t)
```

差异及额外假设：本章原文明确将推导推迟至第2章；仅忠实驻值陈述；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:56`。

### CH01-072 · 定义 · 印刷p.23 / PDF46

原文（忠实转述）：Euler-Lagrange equations are d/dt(partial L/partial qdot)=partial L/partial q.

```lean
def IsEulerLagrangeTrajectoryOn {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) : Prop :=
  (∀ t ∈ I, q t ∈ Q) ∧ ∀ t ∈ I,
    HasDerivAt q (deriv q t) t ∧
    HasDerivAt (fun s => gradient (fun v => massLagrangian m U (q s) v) (deriv q s))
      (gradient (fun x => massLagrangian m U x (deriv q t)) (q t)) t
```

差异及额外假设：按梯度/实际导数陈述。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Lagrangian.lean:75`。

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

### CH01-074 · notation · 印刷p.23 / PDF46

原文（忠实转述）：Generalized coordinates Q parameterize q=Phi(Q), possibly with fewer coordinates.

```lean
abbrev generalizedCoordinates (n d : ℕ) := Position d → Position n
```

差异及额外假设：参数化需正则；不假设全球可逆；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:96`。

### CH01-075 · 未编号结论 · 印刷p.23 / PDF46

原文（忠实转述）：Under q=Phi(Q), qdot=Phi'(Q) Qdot.

```lean
theorem hasDerivAt_coordinateChange {n k : ℕ}
    (Φ : Position k → Position n) (J : Matrix (Fin n) (Fin k) ℝ)
    (q : ℝ → Position k) (V : Velocity k) (t : ℝ)
    (hΦ : HasFDerivAt Φ J.toEuclideanLin.toContinuousLinearMap (q t))
    (hq : HasDerivAt q V t) :
    HasDerivAt (fun s => Φ (q s)) (J.toEuclideanLin V) t
```

差异及额外假设：实际可微Phi与Q。

状态：**proved**。位置：`MolecularDynamics/Chapter01/GeneralizedCoordinates.lean:40`。

### CH01-076 · 定义 · 印刷p.23 / PDF46

原文（忠实转述）：The generalized mass matrix is Phi'(Q)^T M Phi'(Q).

```lean
noncomputable def generalizedMassMatrix {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) : MassMatrix k :=
  J.transpose * diagonalMassMatrix m * J
```

差异及额外假设：矩阵维数Nd×Nd。

状态：**proved**。位置：`MolecularDynamics/Chapter01/GeneralizedCoordinates.lean:18`。

### CH01-077 · 未编号结论 · 印刷p.23 / PDF46

原文（忠实转述）：The transformed Lagrangian is Qdot^T Phi'^T M Phi' Qdot/2-U(Phi(Q)).

```lean
theorem massLagrangian_coordinateChange {n k : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Φ : Position k → Position n)
    (J : Matrix (Fin n) (Fin k) ℝ) (Q : Position k) (V : Velocity k) :
    massLagrangian m U (Φ Q) (J.toEuclideanLin V) =
      inner ℝ V ((generalizedMassMatrix m J).toEuclideanLin V) / 2 - U (Φ Q)
```

差异及额外假设：给定Jacobian线性作用的代数等式。

状态：**proved**。位置：`MolecularDynamics/Chapter01/GeneralizedCoordinates.lean:22`。

### CH01-078 · 未编号结论 · 印刷p.23 / PDF46

原文（忠实转述）：A full-rank regular transformation gives an invertible generalized mass matrix.

```lean
theorem generalizedMassMatrix_isUnit {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) (hm : ∀ i, 0 < m i)
    (hJ : Function.Injective J.mulVec) : IsUnit (generalizedMassMatrix m J)
```

差异及额外假设：正质量、Jacobian单射。

状态：**proved**。位置：`MolecularDynamics/Chapter01/GeneralizedCoordinates.lean:54`。

## §1.4

### CH01-079 · 定义 · 印刷p.24 / PDF47

原文（忠实转述）：The convex Legendre transform is gtilde(eta)=sup_theta(eta^T theta-g(theta)).

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def legendreTransform {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)
```

差异及额外假设：允许扩展实值避免未界实数sup；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:97`。

### CH01-080 · 未编号结论 · 印刷p.24 / PDF47

原文（忠实转述）：For a mechanical quadratic L the maximizing velocity is M(q)^(-1)p.

```lean
theorem legendre_objective_eq_massHamiltonian_iff {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) (v : Velocity n)
    (hm : ∀ i, 0 < m i) :
    inner ℝ p v - massLagrangian m U q v = massHamiltonian m U (q, p) ↔
      v = velocityOperator m p

def legendreMaximizer_statement : Prop :=
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p v : Position n), (M q).PosDef →
    (inner ℝ p v - quadraticL M U q v = quadraticH M U q p ↔
      v = (M q)⁻¹.toEuclideanLin p)
```

差异及额外假设：已证固定正对角质量；一般位置相关SPD质量待忠实陈述。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/LegendreTransform.lean:71;MolecularDynamics/Chapter01/Statements.lean:71`。

### CH01-081 · 定义 · 印刷p.24 / PDF47

原文（忠实转述）：p=partial L/partial qdot=M(q) qdot.

```lean
theorem hasGradientAt_massLagrangian_velocity {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) :
    HasGradientAt (fun w => massLagrangian m U q w) (massOperator m v) v

def generalizedMomentum_statement : Prop :=
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : Position n), (M q).PosDef →
    gradient (quadraticL M U q) v = (M q).toEuclideanLin v
```

差异及额外假设：固定质量；一般质量逐点版本补陈述。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/Lagrangian.lean:61;MolecularDynamics/Chapter01/Statements.lean:76`。

### CH01-082 · 定义 · 印刷p.24 / PDF47

原文（忠实转述）：H(q,p)=p^T M(q)^(-1)p/2+U(q).

```lean
def quadraticH {n : ℕ} (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) :=
  inner ℝ p ((M q)⁻¹.toEuclideanLin p)/2+U q
```

差异及额外假设：固定正对角质量；一般质量版本补陈述。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:68`。

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

### CH01-084 · 定义 · 印刷p.24 / PDF47

原文（忠实转述）：Hamilton's equations are qdot=partial H/partial p and pdot=-partial H/partial q.

```lean
def symplecticGradient {d : ℕ} (H : PhaseSpace d → ℝ) (z : PhaseSpace d) : PhaseSpace d :=
  (gradient (fun p => H (z.1,p)) z.2, -gradient (fun q => H (q,z.2)) z.1)
```

差异及额外假设：梯度接口，未声称一般L全部等价。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:143`。

### CH01-085 · 未编号结论 · 印刷p.24 / PDF47

原文（忠实转述）：For constant mass Hamilton's equations reduce to qdot=M^-1 p and pdot=-gradient U.

```lean
theorem hamiltonianVectorField_eq {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (U : PotentialEnergy n) (z : PhaseSpace n) :
    hamiltonianVectorField m U z = (velocityOperator m z.2, -gradient U z.1)
```

差异及额外假设：势可微，固定正对角质量。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Hamiltonian.lean:185`。

### CH01-086 · 未编号结论 · 印刷p.25 / PDF48

原文（忠实转述）：The Hamiltonian and Lagrangian formulations are interchangeable for regular mechanical models.

```lean
def generalLegendreEquivalence_statement : Prop :=
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : ℝ → Position n) (I : Set ℝ),
    IsOpen I → ContDiff ℝ 2 M → ContDiff ℝ 2 U →
    (∀ x, (M x).PosDef) → (∀ t ∈ I, HasDerivAt q (v t) t) →
    ((∀ t ∈ I, HasDerivAt (fun s => gradient (quadraticL M U (q s)) (v s))
      (gradient (fun x => quadraticL M U x (v t)) (q t)) t) ↔
    ∀ t ∈ I, let p := fun s => (M (q s)).toEuclideanLin (v s)
      HasDerivAt q (gradient (quadraticH M U (q t)) (p t)) t ∧
      HasDerivAt p (-gradient (fun x => quadraticH M U x (p t)) (q t)) t)
```

差异及额外假设：一般位置相关质量与正则域，不扩展证明；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:89`。

### CH01-087 · 定义 · 印刷p.25 / PDF48

原文（忠实转述）：Phase space consists of positions and momenta for which energy is finite.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def finiteEnergyPhaseSpace {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}
```

差异及额外假设：已有类型为全欧氏积；奇异势的有限能量域补陈述。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:99`。

### CH01-088 · notation · 印刷p.25 / PDF48

原文（忠实转述）：An N-particle phase point in three dimensions has 6N real coordinates.

```lean
def phaseDimension_statement : Prop := ∀ N : ℕ, Module.finrank ℝ (PhaseSpace (3*N)) = 6*N
```

差异及额外假设：位置与动量各3N；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:101`。

## §1.5

### CH01-089 · 未编号结论 · 印刷p.25 / PDF48

原文（忠实转述）：Smooth molecular Hamiltonian systems have locally unique solutions.

```lean
theorem exists_localMechanicalIVP_open {n : ℕ}
    (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (hQ : IsOpen Q)
    (t₀ : ℝ) (z₀ : PhaseSpace n) (hz₀ : z₀.1 ∈ Q)
    (hfield : ContDiffAt ℝ 1 (mechanicalVectorField m F) z₀) :
    ∃ ε : ℝ, ∃ γ : ℝ → PhaseSpace n,
      IsLocalMechanicalIVP m F Q t₀ z₀ ε γ
```

差异及额外假设：力C1，开放非奇异位置域，正质量。

状态：**proved**。位置：`MolecularDynamics/Chapter01/LocalExistence.lean:74`。

### CH01-090 · 定义 · 印刷p.25 / PDF48

原文（忠实转述）：Sigma_E0={(q,p):H(q,p)=E0}.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def energySurface {n : ℕ} (H : PhaseSpace n → ℝ) (E : ℝ) := {z | H z = E}
```

差异及额外假设：实值H的指定能量层；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:99`。

### CH01-091 · 未编号结论 · 印刷p.25 / PDF48

原文（忠实转述）：If U>=Umin, then kinetic energy at energy E0 is at most E0-Umin.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def kineticEnergyBound_statement : Prop :=
  ∀ (n : ℕ) (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q p : Position n) (E Umin : ℝ),
    Umin ≤ U q → massHamiltonian m U (q,p) = E →
    momentumKineticEnergy m p ≤ E-Umin

theorem kineticEnergyBound_proved : kineticEnergyBound_statement
```

差异及额外假设：直接能量代数；完整证明见ReviewProofs。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:102;MolecularDynamics/Chapter01/ReviewProofs.lean:46`。

### CH01-092 · 未编号结论 · 印刷p.25 / PDF48

原文（忠实转述）：Positive definite M^-1 implies momenta are bounded at fixed energy.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem momentum_norm_le_of_energy {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (z : PhaseSpace n) (M c E : ℝ)
    (hm : ∀ i, 0 < m i) (hMpos : 0 < M) (hM : ∀ i, m i ≤ M)
    (hU : c ≤ U z.1) (hE : massHamiltonian m U z ≤ E) :
    ‖z.2‖ ≤ Real.sqrt (2 * M * (E - c))
```

差异及额外假设：固定正对角质量、势下界。

状态：**proved**。位置：`MolecularDynamics/Chapter01/MomentumBounds.lean:48`。

### CH01-093 · 未编号结论 · 印刷p.25 / PDF48

原文（忠实转述）：At energy E0 one has Umin<=U(q)<=E0.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def positionEnergyBound_statement : Prop :=
  ∀ (n : ℕ) (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q p : Position n) (E Umin : ℝ),
    (∀ i, 0 < m i) → Umin ≤ U q → massHamiltonian m U (q,p) = E →
    Umin ≤ U q ∧ U q ≤ E

theorem positionEnergyBound_proved : positionEnergyBound_statement
```

差异及额外假设：动能非负，势下界；完整证明见ReviewProofs。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:107;MolecularDynamics/Chapter01/ReviewProofs.lean:51`。

### CH01-094 · 未编号结论 · 印刷p.26 / PDF49

原文（忠实转述）：Uniformly bounded potential levels together with energy conservation confine solutions to a compact set.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem isCompact_phaseEnergySublevel {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (K : Set (Position n)) (E : ℝ)
    (hm : ∀ i, 0 < m i) (hK : IsCompact K) (hU : ContinuousOn U K) :
    IsCompact {z : PhaseSpace n | z.1 ∈ K ∧ massHamiltonian m U z ≤ E}

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def uniformLevelsCompact_statement : Prop :=
  ∀ (n : ℕ) (m : CoordinateMasses n) (U : PotentialEnergy n) (E Umin : ℝ),
    (∀ i, 0 < m i) → Continuous U → (∀ q, Umin ≤ U q) →
    (∃ R : ℝ, ∀ α ∈ Icc Umin E, ∀ q, U q = α → ‖q‖ ≤ R) →
    IsCompact (energySurface (massHamiltonian m U) E)
```

差异及额外假设：已有紧子水平集条件；补原文一致有界层与闭域陈述。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/MomentumBounds.lean:73;MolecularDynamics/Chapter01/Statements.lean:112`。

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

### CH01-096 · 定义 · 印刷p.26 / PDF49

原文（忠实转述）：A confining potential prevents unbounded position motion at fixed energy.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def confiningPotential {n : ℕ} (U : PotentialEnergy n) : Prop :=
  ∀ E : ℝ, Bornology.IsBounded {q | U q ≤ E}
```

差异及额外假设：有界子水平集，奇异域需另约束；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:100`。

### CH01-097 · 未编号结论 · 印刷p.26 / PDF49

原文（忠实转述）：U(x,y)=x^2 does not bound y at constant energy.

```lean
def nonconfiningExample_statement : Prop :=
  ¬ Bornology.IsBounded {q : Position 2 | (q 0)^2 = 1}
```

差异及额外假设：正文用于解释假设的数学反例；非数值例子；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:117`。

## §1.5.1

### CH01-098 · 定义 · 印刷p.26 / PDF49

原文（忠实转述）：The flow F_t(xi)=z(t) solves zdot=f(z), z(0)=xi, (1.5).

```lean
def IsGlobalMechanicalFlowOn {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (S : Set (PhaseSpace n))
    (ψ : ℝ → PhaseSpace n → PhaseSpace n) : Prop :=
  (∀ z ∈ S, IsMechanicalSolutionOn m F Q univ (fun t => ψ t z) ∧ ψ 0 z = z) ∧
  ∀ t, MapsTo (ψ t) S S
```

差异及额外假设：机械系统接口；通用ODE原式补陈述。

状态：**proved**。位置：`MolecularDynamics/Chapter01/GlobalFlow.lean:41`。

### CH01-099 · 未编号结论 · 印刷p.26 / PDF49

原文（忠实转述）：F_(-t) F_t = identity.

```lean
theorem globalMechanicalFlow_inverse {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n}
    (hψ : IsGlobalMechanicalFlowOn m F Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    {z : PhaseSpace n} (hz : z ∈ S) (t : ℝ) : ψ (-t) (ψ t z) = z
```

差异及额外假设：全局解及局部唯一性由C1保证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/GlobalFlow.lean:64`。

### CH01-100 · 未编号结论 · 印刷p.26 / PDF49

原文（忠实转述）：F_t F_s=F_s F_t=F_(t+s); the flow forms an Abelian group.

```lean
theorem globalMechanicalFlow_commute {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n}
    (hψ : IsGlobalMechanicalFlowOn m F Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    {z : PhaseSpace n} (hz : z ∈ S) (s t : ℝ) :
    ψ t (ψ s z) = ψ s (ψ t z)
```

差异及额外假设：既有add与commute定理，全局域。

状态：**proved**。位置：`MolecularDynamics/Chapter01/GlobalFlow.lean:72`。

### CH01-101 · 未编号结论 · 印刷p.26 / PDF49

原文（忠实转述）：Hamiltonian flows conserve H: H(F_t(xi))=H(xi).

```lean
theorem globalMechanicalFlow_energy {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n} (U : PotentialEnergy n)
    (hψ : IsGlobalMechanicalFlowOn m F Q S ψ) (hm : ∀ i, 0 < m i)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    {z : PhaseSpace n} (hz : z ∈ S) (t : ℝ) :
    massHamiltonian m U (ψ t z) = massHamiltonian m U z
```

差异及额外假设：机械保守力；已实际证明。

状态：**proved**。位置：`MolecularDynamics/Chapter01/GlobalFlow.lean:96`。

### CH01-102 · 定义 · 印刷p.27 / PDF50

原文（忠实转述）：The oscillator phase flow has the explicit sine-cosine position and momentum formula.

```lean
noncomputable def harmonicFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω * t) • z.1 + (Real.sin (Ω * t) / Ω) • z.2,
    (-Ω * Real.sin (Ω * t)) • z.1 + Real.cos (Ω * t) • z.2)
```

差异及额外假设：非零频率时，与打印公式相符。

状态：**proved**。位置：`MolecularDynamics/Chapter01/HarmonicOscillator.lean:18`。

### CH01-103 · 未编号结论 · 印刷p.27 / PDF50

原文（忠实转述）：If A has an eigenbasis, z(t)=sum_i c_i exp(lambda_i(t-t0)) eta_i.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem complexExponentialFlow_eigenbasis {ι : Type*} [Fintype ι]
    (A : E →L[ℂ] E) (b : Module.Basis ι ℂ E) (ν : ι → ℂ)
    (hb : ∀ i, A (b i) = ν i • b i) (z : E) (t : ℝ) :
    complexExponentialFlow A t z =
      ∑ i, (b.repr z i * Complex.exp (ν i * (t : ℂ))) • b i
```

差异及额外假设：有限维复数特征基，允许实矩阵的复特征值。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ComplexSpectralFlow.lean:58`。

### CH01-104 · 未编号结论 · 印刷p.27 / PDF50

原文（忠实转述）：For real A and real initial data, complex spectral expansion gives a real solution.

```lean
theorem realMatrix_complexSpectral_sum_isReal {m : ℕ}
    (A : Matrix (Fin m) (Fin m) ℝ)
    (b : Module.Basis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (ν : Fin m → ℂ)
    (hb : ∀ j, Matrix.toEuclideanCLM (n
```

差异及额外假设：共轭不变性，未假设所有特征值实。

状态：**proved**。位置：`MolecularDynamics/Chapter01/RealRecoveryFlow.lean:77`。

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

### CH01-106 · 未编号结论 · 印刷p.27 / PDF50

原文（忠实转述）：The linear IVP solution is z(t)=exp(A(t-t0))xi.

```lean
theorem matrixExponentialFlow_unique {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t₀ : ℝ) (γ : ℝ → Position m)
    (hγ : ∀ t, HasDerivAt γ (WithLp.toLp 2 (A.mulVec (γ t))) t)
    (hinit : γ t₀ = z) : γ = fun t => matrixExponentialFlow A (t - t₀) z
```

差异及额外假设：所有有限实方阵，不要求可对角化。

状态：**proved**。位置：`MolecularDynamics/Chapter01/MatrixFlow.lean:51`。

### CH01-107 · 定义 · 印刷p.27 / PDF50

原文（忠实转述）：exp(A)=I+A+A^2/2!+A^3/3!+... .

```lean
theorem matrixExponentialSeries_hasSum {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) :
    HasSum (fun k : ℕ => ((k.factorial : ℝ)⁻¹) • A^k) (NormedSpace.exp A)
```

差异及额外假设：所有有限实方阵；HasSum明确断言整个指数级数收敛，新增完整证明复用Mathlib。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewProofs.lean:10`。

### CH01-108 · 未编号结论 · 印刷p.28 / PDF51

原文（忠实转述）：The exponential series converges for every matrix.

```lean
theorem matrixExponential_series {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ) :
    NormedSpace.exp A = ∑' k : ℕ, ((k.factorial : ℝ)⁻¹) • A ^ k
```

差异及额外假设：完整HasSum含收敛，不重复证明。

状态：**proved**。位置：`MolecularDynamics/Chapter01/MatrixFlow.lean:62`。

## §1.5.2

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

### CH01-110 · 未编号结论 · 印刷p.28 / PDF51

原文（忠实转述）：A smooth I is a first integral exactly when gradient I dot f=0 everywhere.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem isFirstIntegralOn_iff_differential (f : E → E) (Q : Set E) (J : E → ℝ)
    (hQ : IsOpen Q) (hf : ∀ x ∈ Q, ContDiffAt ℝ 1 f x)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x) :
    IsFirstIntegralOn f Q J ↔ ∀ x ∈ Q, fderiv ℝ J x (f x) = 0
```

差异及额外假设：f局部C1、I可微、开放域；微分作用等价内积。

状态：**proved**。位置：`MolecularDynamics/Chapter01/FirstIntegrals.lean:61`。

### CH01-111 · 未编号结论 · 印刷p.28 / PDF51

原文（忠实转述）：A regular planar first-integral level can locally be solved as y=psi(x).

```lean
theorem exists_planarFirstIntegral_C1Graph (J : ℝ × ℝ → ℝ) (p : ℝ × ℝ)
    (hJ : ContDiffAt ℝ 1 J p) (hpartial : (fderiv ℝ J p) (0, 1) ≠ 0) :
    ∃ ψ : ℝ → ℝ, ψ p.1 = p.2 ∧ ContDiffAt ℝ 1 ψ p.1 ∧
      (∀ᶠ v in 𝓝 p, J v = J p ↔ ψ v.1 = v.2)
```

差异及额外假设：对y偏导非零，不遗漏隐函数条件。

状态：**proved**。位置：`MolecularDynamics/Chapter01/FirstIntegralQuadrature.lean:8`。

### CH01-112 · 未编号结论 · 印刷p.28 / PDF51

原文（忠实转述）：Substitution gives xdot=g(x,psi(x)), a separable scalar equation.

```lean
theorem planarFirstIntegral_localGraph_reduction (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J)
    (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (L : (ℝ × ℝ) →L[ℝ] ℝ) (hJ : HasStrictFDerivAt J L (γ t₀))
    (hpartial : L (0, 1) ≠ 0) :
    ∃ ψ : ℝ → ℝ, ψ (γ t₀).1 = (γ t₀).2 ∧ DifferentiableAt ℝ ψ (γ t₀).1 ∧
      (∀ᶠ v in 𝓝 (γ t₀), J v = J (γ t₀) ↔ ψ v.1 = v.2) ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).2 = ψ (γ t).1 ∧
        HasDerivAt (fun u => (γ u).1) ((f ((γ t).1, ψ (γ t).1)).1) t)
```

差异及额外假设：局部正则图。

状态：**proved**。位置：`MolecularDynamics/Chapter01/FirstIntegralGraph.lean:39`。

### CH01-113 · 未编号结论 · 印刷p.28 / PDF51

原文（忠实转述）：Separable equations with nonzero speed admit a local quadrature solution.

```lean
noncomputable def keplerPotential {n : ℕ} (q : Position n) : ℝ := -‖q‖⁻¹

noncomputable def momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : ℝ := ∑ i, (p i)^2 / (2 * m i)

noncomputable def massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : Hamiltonian n := (massSeparableEnergy m U).hamiltonian
```

差异及额外假设：非转向区间，真实积分与逆函数。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Kepler.lean:9;MolecularDynamics/Chapter01/Hamiltonian.lean:27;MolecularDynamics/Chapter01/Hamiltonian.lean:33`。

### CH01-114 · 未编号结论 · 印刷p.28 / PDF51

原文（忠实转述）：The scalar mechanical system is integrable by its energy first integral.

```lean
theorem scalarPotentialEnergy_isFirstIntegral (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U) :
    IsFirstIntegralOn (scalarPotentialVectorField U) univ (scalarPotentialEnergy U)
```

差异及额外假设：单位质量、U光滑；全局拼接另条。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ScalarIntegrability.lean:40`。

### CH01-115 · 定义 · 印刷p.29 / PDF52

原文（忠实转述）：The planar fixed-center Kepler energy is (xdot^2+ydot^2)/2-1/sqrt(x^2+y^2).

```lean
noncomputable def keplerPotential {n : ℕ} (q : Position n) : ℝ := -‖q‖⁻¹
```

差异及额外假设：排除原点，单位质量与引力常数。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Kepler.lean:9`。

### CH01-116 · 未编号结论 · 印刷p.29 / PDF52

原文（忠实转述）：Kepler energy is conserved.

```lean
theorem kepler_energy_const_on_Ioo {n : ℕ} (a b : ℝ) (γ : ℝ → PhaseSpace n)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position n | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ s) =
      massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ t)
```

差异及额外假设：非碰撞开放解区间。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Kepler.lean:51`。

### CH01-117 · 未编号结论 · 印刷p.29 / PDF52

原文（忠实转述）：Kepler angular momentum l_z=x ydot-y xdot is conserved.

```lean
theorem kepler_planarAngularMomentum_const_on_Ioo (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t)
```

差异及额外假设：非碰撞，平面模型。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Kepler.lean:62`。

### CH01-118 · 定义 · 印刷p.29 / PDF52

原文（忠实转述）：Polar coordinates are (x,y)=(r cos theta,r sin theta).

```lean
noncomputable def polarCoordinateMap (q : Position 2) : Position 2 :=
  WithLp.toLp 2 ![q 0 * Real.cos (q 1), q 0 * Real.sin (q 1)]
```

差异及额外假设：r>0时局部正则。

状态：**proved**。位置：`MolecularDynamics/Chapter01/PolarCoordinateMap.lean:9`。

### CH01-119 · 未编号结论 · 印刷p.29 / PDF52

原文（忠实转述）：In polar variables L=rdot^2/2+r^2 thetadot^2/2+1/r.

```lean
theorem keplerPolarLagrangian_identity (r θ v ω : ℝ) :
    ((v * Real.cos θ - r * ω * Real.sin θ) ^ 2 +
      (v * Real.sin θ + r * ω * Real.cos θ) ^ 2) / 2 + 1 / r =
    v ^ 2 / 2 + r ^ 2 * ω ^ 2 / 2 + 1 / r
```

差异及额外假设：代数恒等式，非零半径物理域。

状态：**proved**。位置：`MolecularDynamics/Chapter01/PolarCoordinates.lean:23`。

### CH01-120 · 未编号结论 · 印刷p.29 / PDF52

原文（忠实转述）：Polar Euler-Lagrange equations give rddot=-1/r^2+r thetadot^2 and d_t(r^2 thetadot)=0.

```lean
theorem keplerPolar_eulerLagrange_iff (I : Set ℝ) (r θ v ω : ℝ → ℝ) :
    IsKeplerPolarEulerLagrangeOn I r θ v ω ↔
      ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (ω t) t ∧
        HasDerivAt v (r t * ω t ^ 2 - (r t ^ 2)⁻¹) t ∧
        HasDerivAt (fun u => r u ^ 2 * ω u) 0 t
```

差异及额外假设：r非零，真实一阶/二阶导数。

状态：**proved**。位置：`MolecularDynamics/Chapter01/KeplerPolarDynamics.lean:56`。

### CH01-121 · 未编号结论 · 印刷p.29 / PDF52

原文（忠实转述）：l_z=r^2 thetadot.

```lean
theorem polarAngularMomentum_identity (r θ v ω : ℝ) :
    (r * Real.cos θ) * (v * Real.sin θ + r * ω * Real.cos θ) -
      (r * Real.sin θ) * (v * Real.cos θ - r * ω * Real.sin θ) = r ^ 2 * ω
```

差异及额外假设：展开平面坐标恒等式。

状态：**proved**。位置：`MolecularDynamics/Chapter01/PolarCoordinates.lean:16`。

### CH01-122 · 未编号结论 · 印刷p.29 / PDF52

原文（忠实转述）：Fixing l_z reduces the radial equation to rddot=-1/r^2+l_z^2/r^3.

```lean
theorem keplerPolar_radial_reduction (I : Set ℝ) (r θ v ω : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn I r θ v ω) (t : ℝ) (ht : t ∈ I)
    (l : ℝ) (hl : r t ^ 2 * ω t = l) :
    HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t
```

差异及额外假设：解区间内固定角动量。

状态：**proved**。位置：`MolecularDynamics/Chapter01/KeplerPolarDynamics.lean:91`。

### CH01-123 · 定义 · 印刷p.30 / PDF53

原文（忠实转述）：The radial energy is rdot^2/2-1/r+l_z^2/(2r^2).

```lean
noncomputable def keplerRadialEnergy (l r v : ℝ) : ℝ :=
  v ^ 2 / 2 - r⁻¹ + (l ^ 2 / 2) * (r⁻¹) ^ 2
```

差异及额外假设：实际径向函数。

状态：**proved**。位置：`MolecularDynamics/Chapter01/KeplerPolarDynamics.lean:103`。

### CH01-124 · 未编号结论 · 印刷p.30 / PDF53

原文（忠实转述）：The Kepler radius can be expressed via scalar quadratures and their inverses.

```lean
theorem keplerRadial_nonturning_quadrature
    (l a b t₀ : ℝ) (r v : ℝ → ℝ)
    (h : ∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t)
    (ht₀ : t₀ ∈ Ioo a b) (hv₀ : v t₀ ≠ 0) :
    ∃ (σ δ ε : ℝ) (g : ℝ → ℝ), σ ^ 2 = 1 ∧ 0 < δ ∧ 0 < ε ∧
      HasStrictDerivAt g (v t₀) 0 ∧ (∀ᶠ t in 𝓝 t₀, g (t - t₀) = r t) ∧
      (∀ᶠ x in 𝓝 (r t₀), g (separableTimePrimitive
        (keplerRadialBranchSpeed σ l (keplerRadialEnergy l (r t₀) (v t₀))) (r t₀) x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive
        (keplerRadialBranchSpeed σ l (keplerRadialEnergy l (r t₀) (v t₀))) (r t₀) (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        r t ∈ Ioo (r t₀ - δ) (r t₀ + δ) ∧
        separableTimePrimitive
          (keplerRadialBranchSpeed σ l (keplerRadialEnergy l (r t₀) (v t₀))) (r t₀) (r t) = t - t₀)

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def keplerQuadratureGlobal_statement : Prop :=
  ∀ (a b : ℝ) (r v : ℝ → ℝ) (ℓ : ℝ),
    (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t) →
    ∃ E : ℝ, (∀ t ∈ Ioo a b, keplerRadialEnergy ℓ (r t) (v t) = E) ∧
    ∀ s ∈ Ioo a b, v s ≠ 0 → ∃ δ > 0,
      Ioo (s-δ) (s+δ) ⊆ Ioo a b ∧
      ∀ t ∈ Ioo (s-δ) (s+δ),
        (∫ x in r s..r t, (Real.sign (v s) *
          Real.sqrt (2*E+2/x-ℓ^2/x^2))⁻¹) = t-s
```

差异及额外假设：已有非转向局部窗；不能声称一般全局轨道已解，补忠实全域拼接陈述。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/KeplerQuadrature.lean:154;MolecularDynamics/Chapter01/Statements.lean:120`。

### CH01-125 · 未编号结论 · 印刷p.30 / PDF53

原文（忠实转述）：theta(t)=theta(0)+integral_0^t l_z/r(s)^2 ds.

```lean
theorem keplerPolar_angle_integral (a b : ℝ) (r θ v ω : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn (Ioo a b) r θ v ω)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    θ t = θ s + ∫ u in s..t, (r s ^ 2 * ω s) / r u ^ 2
```

差异及额外假设：正半径，区间含0，可积/连续。

状态：**proved**。位置：`MolecularDynamics/Chapter01/KeplerPolarDynamics.lean:152`。

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

### CH01-127 · 定义 · 印刷p.30 / PDF53

原文（忠实转述）：Oscillator action-angle coordinates satisfy x=sqrt(2I/Omega)cos(theta), v=sqrt(2I Omega)sin(theta).

```lean
noncomputable def harmonicActionPosition (Ω J θ : ℝ) : ℝ :=
  harmonicActionAmplitude Ω J * Real.cos θ

noncomputable def harmonicActionVelocity (Ω J θ : ℝ) : ℝ :=
  Ω * harmonicActionAmplitude Ω J * Real.sin θ
```

差异及额外假设：I>0、Omega>0；另函数harmonicActionVelocity。

状态：**proved**。位置：`MolecularDynamics/Chapter01/HarmonicActionAngle.lean:12;MolecularDynamics/Chapter01/HarmonicActionAngle.lean:14`。

### CH01-128 · 未编号结论 · 印刷p.30 / PDF53

原文（忠实转述）：In action-angle variables E=I Omega.

```lean
theorem harmonicAction_energy (Ω J θ : ℝ) (hΩ : 0 < Ω) (hJ : 0 ≤ J) :
    harmonicScalarEnergy Ω (harmonicActionPosition Ω J θ)
      (harmonicActionVelocity Ω J θ) = J * Ω
```

差异及额外假设：正I及正频率。

状态：**proved**。位置：`MolecularDynamics/Chapter01/HarmonicActionAngle.lean:29`。

### CH01-129 · 未编号结论 · 印刷p.30 / PDF53

原文（忠实转述）：The oscillator equations become Idot=0 and thetadot=-Omega.

```lean
theorem harmonicAction_ode_iff (Ω : ℝ) (J θ : ℝ → ℝ) (d ω t : ℝ)
    (hΩ : 0 < Ω) (hJ : 0 < J t) (hd : HasDerivAt J d t) (hθ : HasDerivAt θ ω t) :
    (HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t) ↔ d = 0 ∧ ω = -Ω
```

差异及额外假设：非退化局部坐标。

状态：**proved**。位置：`MolecularDynamics/Chapter01/HarmonicActionAngle.lean:111`。

### CH01-130 · 未编号结论 · 印刷p.30 / PDF53

原文（忠实转述）：theta(t)=theta(0)-Omega t gives the action-angle solution.

```lean
theorem harmonicAction_explicit_solution (Ω J θ₀ t₀ : ℝ) (hΩ : 0 < Ω) (hJ : 0 < J) :
    ∀ t : ℝ,
      HasDerivAt (fun u => harmonicActionPosition Ω J (θ₀ - Ω * (u - t₀)))
        (harmonicActionVelocity Ω J (θ₀ - Ω * (t - t₀))) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω J (θ₀ - Ω * (u - t₀)))
        (-(Ω ^ 2) * harmonicActionPosition Ω J (θ₀ - Ω * (t - t₀))) t
```

差异及额外假设：正I/Omega、常数action。

状态：**proved**。位置：`MolecularDynamics/Chapter01/HarmonicActionAngle.lean:129`。

### CH01-131 · 定义 · 印刷p.30 / PDF53

原文（忠实转述）：d decoupled oscillators rotate on a d-dimensional torus with constant actions.

```lean
abbrev HarmonicTorus (n : ℕ) := Fin n → Real.Angle

noncomputable def harmonicTorusPhase {n : ℕ} (Ω J : Fin n → ℝ)
    (θ : HarmonicTorus n) : PhaseSpace n :=
  (WithLp.toLp 2 (fun j => harmonicActionAmplitude (Ω j) (J j) * (θ j).cos),
    WithLp.toLp 2 (fun j => Ω j * harmonicActionAmplitude (Ω j) (J j) * (θ j).sin))

theorem harmonicTorusPhase_rotation_isMechanical {n : ℕ} (Ω J : Fin n → ℝ)
    (hΩ : ∀ j, 0 < Ω j) (hJ : ∀ j, 0 < J j) (θ : HarmonicTorus n) :
    IsMechanicalSolutionOn (fun _ => (1 : ℝ)) (decoupledHarmonicForce Ω) univ univ
      (fun t => harmonicTorusPhase Ω J (harmonicTorusRotation Ω t θ))
```

差异及额外假设：角环面；phase实现见harmonicTorusPhase。

状态：**proved**。位置：`MolecularDynamics/Chapter01/HarmonicTorus.lean:9;MolecularDynamics/Chapter01/HarmonicTorus.lean:59;MolecularDynamics/Chapter01/HarmonicTorus.lean:143`。

### CH01-132 · 未编号结论 · 印刷p.30 / PDF53

原文（忠实转述）：Commensurate frequencies yield periodic torus motion.

```lean
theorem harmonicTorusRotation_periodic_iff_integer {n : ℕ}
    (Ω : Fin n → ℝ) (T : ℝ) (θ : HarmonicTorus n) :
    Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T ↔
      ∀ j, ∃ k : ℤ, (k : ℝ) * (2 * Real.pi) = Ω j * T
```

差异及额外假设：周期存在等价每频率乘周期为整圈。

状态：**proved**。位置：`MolecularDynamics/Chapter01/HarmonicTorus.lean:43`。

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

### CH01-201 · 未编号结论 · 印刷p.29 / PDF52

原文（忠实转述）：In the fixed-center Kepler problem linear momentum is generally not conserved.

```lean
def keplerMomentumNotConserved_statement : Prop :=
  ∀ q : Position 2, q ≠ 0 → keplerForce q ≠ 0
```

差异及额外假设：非零引力给真实动量导数非零，不声称所有轨迹所有坐标导数非零；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:326`。

### CH01-202 · 定义 · 印刷p.30 / PDF53

原文（忠实转述）：The harmonic action-angle coordinate pair is (I,theta).

```lean
abbrev actionAnglePair := ℝ × Real.Angle
```

差异及额外假设：原文随后写(I,Omega)疑似笔误；独立登记正确对象与原文差异；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:328`。

## §1.5.3

### CH01-135 · 定义 · 印刷p.31 / PDF54

原文（忠实转述）：An equilibrium of zdot=f(z) solves f(z*)=0, (1.6).

```lean
def equilibriumDefinition {n : ℕ} (f : Position n → Position n) (z : Position n) : Prop := f z = 0
```

差异及额外假设：通用有限维ODE；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:102`。

### CH01-136 · 未编号结论 · 印刷p.31 / PDF54

原文（忠实转述）：An equilibrium gives a constant solution.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem equilibrium_constant_ode_iff (f : E → E) (z₀ : E) (t : ℝ) :
    HasDerivAt (fun _ : ℝ => z₀) (f z₀) t ↔ f z₀ = 0
```

差异及额外假设：实际HasDerivAt。

状态：**proved**。位置：`MolecularDynamics/Chapter01/EquilibriumLinearization.lean:16`。

### CH01-137 · 未编号结论 · 印刷p.31 / PDF54

原文（忠实转述）：For C1 f near z*, f(z)=f(z*)+f'(z*)(z-z*)+o(norm(z-z*)).

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem equilibriumLinearizationRemainder_of_C1 (f : E → E) (z₀ : E)
    (hF : ContDiffAt ℝ 1 f z₀) (heq : f z₀ = 0) :
    (equilibriumLinearizationRemainder f z₀ (fderiv ℝ f z₀)) =o[𝓝 0] (fun h : E => h)
```

差异及额外假设：实际小o而非不明确近似符号。

状态：**proved**。位置：`MolecularDynamics/Chapter01/EquilibriumLinearization.lean:32`。

### CH01-138 · 定义 · 印刷p.31 / PDF54

原文（忠实转述）：The linearization is delta_z_dot=f'(z*) delta_z.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem equilibrium_linearized_IVP (f : E → E) (z₀ h₀ : E) (t₀ : ℝ)
    (hF : ContDiffAt ℝ 1 f z₀) (heq : f z₀ = 0) :
    ∃ δ : ℝ → E, δ t₀ = h₀ ∧
      (∀ t, HasDerivAt δ ((fderiv ℝ f z₀) (δ t)) t) ∧
      (equilibriumLinearizationRemainder f z₀ (fderiv ℝ f z₀)) =o[𝓝 0] (fun h : E => h)
```

差异及额外假设：有限维Banach接口。

状态：**proved**。位置：`MolecularDynamics/Chapter01/EquilibriumLinearization.lean:49`。

### CH01-139 · 定义 · 印刷p.31 / PDF54

原文（忠实转述）：Hyperbolic means every eigenvalue of f'(z*) has nonzero real part.

```lean
def hyperbolic {n : ℕ} (A : Position n →L[ℝ] Position n) : Prop :=
  ∀ (a b : ℝ) (x y : Position n), (x ≠ 0 ∨ y ≠ 0) →
    A x = a • x - b • y → A y = b • x + a • y → a ≠ 0
```

差异及额外假设：复数特征向量判据；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:171`。

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

### CH01-141 · 定义 · 印刷p.32 / PDF55

原文（忠实转述）：Lyapunov stability means for every epsilon>0 there is delta>0 such that all future flow points stay within epsilon.

```lean
def IsFutureMechanicalStableEuclidean {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (zstar : PhaseSpace n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ z₀ : PhaseSpace n, phaseEuclideanDistance z₀ zstar < δ →
    (∃ a < (0 : ℝ), ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioi a) γ ∧ γ 0 = z₀) ∧
    ∀ a < (0 : ℝ), ∀ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioi a) γ → γ 0 = z₀ →
      BddAbove (range (fun t : Ici (0 : ℝ) => phaseEuclideanDistance (γ t) zstar)) ∧
      sSup (range (fun t : Ici (0 : ℝ) => phaseEuclideanDistance (γ t) zstar)) < ε
```

差异及额外假设：采用真实未来解及欧氏相空间距离；sup严格版本补陈述。

状态：**proved**。位置：`MolecularDynamics/Chapter01/EuclideanStability.lean:18`。

### CH01-142 · 未编号结论 · 印刷p.32 / PDF55

原文（忠实转述）：Stability of a hyperbolic nonlinear equilibrium is determined by stability of its linearization.

```lean
def hyperbolicStabilityTransfer_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0)
```

差异及额外假设：局部共轭与完整未来轨迹；原文smooth疑点另条；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:190`。

### CH01-143 · 未编号结论 · 印刷p.32 / PDF55

原文（忠实转述）：At a mechanical Hamiltonian equilibrium p*=0 and gradient U(q*)=0.

```lean
theorem mechanicalEquilibrium_iff {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q p : Position n) (hm : ∀ i, 0 < m i) :
    IsMechanicalEquilibrium m (fun x => -gradient U x) (q,p) ↔ p=0 ∧ gradient U q=0
```

差异及额外假设：固定正质量；实际向量场平衡等价p=0与梯度U=0，已完整证明。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewProofs.lean:62`。

### CH01-144 · 定义 · 印刷p.32 / PDF55

原文（忠实转述）：A strong local minimum q* means 0<norm(q-q*)<epsilon implies U(q)>U(q*).

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def IsStrictPotentialMin {E : Type*} [MetricSpace E]
    (U : E → ℝ) (q₀ : E) : Prop :=
  ∃ R : ℝ, 0 < R ∧ ∀ q, 0 < dist q q₀ → dist q q₀ < R → U q₀ < U q
```

差异及额外假设：严格局部极小，不等于Hessian正定。

状态：**proved**。位置：`MolecularDynamics/Chapter01/PotentialBarriers.lean:34`。

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

### CH01-146 · 定义 · 印刷p.32 / PDF55

原文（忠实转述）：The linearized Hamiltonian is delta_p^T M^-1 delta_p/2+delta_q^T U''(q*) delta_q/2.

```lean
theorem linearizedHamiltonianQuadratic_eq_textbook_form {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (q₀ : Position n)
    (δq : Position n) (δp : Momentum n) :
    linearizedHamiltonianQuadratic m U q₀ δq δp =
      momentumKineticEnergy m δp +
        inner ℝ δq (fderiv ℝ (gradient U) q₀ δq) / 2
```

差异及额外假设：真实Hessian二次形式，C2。

状态：**proved**。位置：`MolecularDynamics/Chapter01/LinearizedHamiltonian.lean:15`。

### CH01-147 · 未编号结论 · 印刷p.33 / PDF56

原文（忠实转述）：A positive definite Hessian makes the quadratic Hamiltonian a strong local minimum.

```lean
def positiveHessianQuadraticMinimum_statement : Prop :=
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    IsStrictPotentialMin (fun z : PhaseSpace n =>
      inner ℝ z.2 (M⁻¹.toEuclideanLin z.2)/2 + inner ℝ z.1 (K.toEuclideanLin z.1)/2) 0
```

差异及额外假设：非负性已有；严格极小另行忠实陈述；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:195`。

### CH01-148 · 未编号结论 · 印刷p.33 / PDF56

原文（忠实转述）：Positive distinct Hessian eigenvalues imply a strong local minimum of U.

```lean
def positiveHessianMinimum_statement : Prop :=
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    gradient U q = 0 →
    (∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v)) →
    IsStrictPotentialMin U q
```

差异及额外假设：distinct非必要但忠实保留；C2；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:199`。

## §1.6

### CH01-149 · 定义 · 印刷p.33 / PDF56

原文（忠实转述）：Uniform pair potential energy is sum_{i<j} phi(abs(x_i-x_j)).

```lean
noncomputable def uniformPairPotentialEnergy {N : ℕ}
    (φ : ℝ → ℝ) (x : Fin N → ℝ) : ℝ :=
  ∑ i : Fin N, Finset.sum (Finset.Ioi i) (fun j => φ ‖x i - x j‖)
```

差异及额外假设：有限1维粒子。

状态：**proved**。位置：`MolecularDynamics/Chapter01/LatticePairPotential.lean:12`。

### CH01-150 · 未编号结论 · 印刷p.33 / PDF56

原文（忠实转述）：The unordered pair count is N(N-1)/2.

```lean
def unorderedPairCount_statement : Prop :=
  ∀ N : ℕ, (Finset.univ.filter (fun p : Fin N × Fin N => p.1 < p.2)).card = N*(N-1)/2
```

差异及额外假设：自然数除法；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:204`。

### CH01-151 · 定义 · 印刷p.33 / PDF56

原文（忠实转述）：Nearest-neighbor energy is sum_{i=1}^{N-1} phi(abs(x_{i+1}-x_i)).

```lean
noncomputable def nearestNeighborPotentialEnergy {N : ℕ}
    (φ : ℝ → ℝ) (x : Fin (N + 1) → ℝ) : ℝ :=
  ∑ i : Fin N, φ ‖x i.succ - x i.castSucc‖
```

差异及额外假设：N+1站点的Fin N索引。

状态：**proved**。位置：`MolecularDynamics/Chapter01/LatticePairPotential.lean:38`。

### CH01-152 · 定义 · 印刷p.33 / PDF56

原文（忠实转述）：Walled chain energy is phi_c(abs(x_1))+phi_c(abs(L-x_N))+nearest-neighbor sum, (1.7).

```lean
noncomputable def walledNearestNeighborPotentialEnergy {N : ℕ}
    (φ φc : ℝ → ℝ) (L : ℝ) (x : Fin (N + 1) → ℝ) : ℝ :=
  φc ‖x 0‖ + φc ‖L - x (Fin.last N)‖ + nearestNeighborPotentialEnergy φ x
```

差异及额外假设：固定端墙，可任意势。

状态：**proved**。位置：`MolecularDynamics/Chapter01/LatticePairPotential.lean:77`。

### CH01-153 · 定义 · 印刷p.33 / PDF56

原文（忠实转述）：Periodic chain energy adds phi(abs(L+x_1-x_N)), (1.8).

```lean
noncomputable def boxPeriodicNearestNeighborPotentialEnergy {N : ℕ}
    (φ : ℝ → ℝ) (L : ℝ) (x : Fin (N + 1) → ℝ) : ℝ :=
  nearestNeighborPotentialEnergy φ x + φ ‖L + x 0 - x (Fin.last N)‖
```

差异及额外假设：真实L偏移，非仅抽象循环。

状态：**proved**。位置：`MolecularDynamics/Chapter01/LatticePairPotential.lean:82`。

### CH01-154 · 定义 · 印刷p.34 / PDF57

原文（忠实转述）：Periodic boundary coordinates identify x with x+L.

```lean
def periodicBoundary (L : ℝ) (x y : ℝ) : Prop := ∃ k : ℤ, y = x + k*L
```

差异及额外假设：L>0，加性圆/商；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:103`。

### CH01-155 · 未编号结论 · 印刷p.34 / PDF57

原文（忠实转述）：Periodic boundary conditions preserve translations and thus momentum for internal pair forces.

```lean
theorem boxPeriodicNearestNeighborPotentialEnergy_translate {N : ℕ}
    (φ : ℝ → ℝ) (L : ℝ) (x : Fin (N + 1) → ℝ) (c : ℝ) :
    boxPeriodicNearestNeighborPotentialEnergy φ L (fun i => x i + c) =
      boxPeriodicNearestNeighborPotentialEnergy φ L x

def periodicMomentum_statement : Prop :=
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ) (q : Fin (N+1) → ℝ),
    DifferentiableAt ℝ (boxPeriodicNearestNeighborPotentialEnergy φ L) q →
    fderiv ℝ (boxPeriodicNearestNeighborPotentialEnergy φ L) q (fun _ => 1) = 0
```

差异及额外假设：已有能量平移恒等式；实际周期模型力与动量守恒补陈述。

状态：**weakened**。位置：`MolecularDynamics/Chapter01/LatticePairPotential.lean:86;MolecularDynamics/Chapter01/Statements.lean:206`。

### CH01-156 · 定义 · 印刷p.34 / PDF57

原文（忠实转述）：A one-dimensional regular lattice consists of points separated by fixed delta_x.

```lean
def regularLattice {N : ℕ} (a δ : ℝ) (x : Fin N → ℝ) : Prop :=
  0 < δ ∧ ∀ i, x i = a + i.val*δ
```

差异及额外假设：正间距，有限格点；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:104`。

### CH01-157 · 未编号结论 · 印刷p.34 / PDF57

原文（忠实转述）：For a uniform pair potential with periodic boundaries energy minimizers are regular lattices.

```lean
def regularLatticeMinimizer_statement : Prop :=
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ), 0 < L →
    ∀ x : Fin (N+1) → ℝ,
    (∀ y : Fin (N+1) → ℝ, boxPeriodicNearestNeighborPotentialEnergy φ L x ≤
      boxPeriodicNearestNeighborPotentialEnergy φ L y) →
    ∃ a : ℝ, regularLattice a (L/(N+1)) x
```

差异及额外假设：原文对任意均匀势过强，需额外凸性/密度条件；保留字面陈述待审；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:210`。

### CH01-158 · 定义 · 印刷p.35 / PDF58

原文（忠实转述）：In 3D PBC, U sums phi_ij(q_i,q_j+L(k,l,m)) over neighboring image cells and i<j.

```lean
def periodicImageEnergy {N : ℕ} (L : ℝ) (φ : Fin N → Fin N → twoBodyTerms)
    (q : Fin N → V3) :=
  ∑ k : Fin 3, ∑ l : Fin 3, ∑ m : Fin 3, ∑ i, ∑ j ∈ Finset.Ioi i,
    φ i j (q i) (q j + WithLp.toLp 2 ![L*((k.val:ℝ)-1),L*((l.val:ℝ)-1),L*((m.val:ℝ)-1)])
```

差异及额外假设：忠实有限27副本公式，不能等同无限求和；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:106`。

### CH01-159 · 定义 · 印刷p.35 / PDF58

原文（忠实转述）：The minimum-image convention uses the nearest periodic replica of another atom.

```lean
def minimumImage (L : ℝ) (q r image : V3) : Prop :=
  ∃ k : Fin 3 → ℤ, image = r + WithLp.toLp 2 (fun i => L*k i) ∧
    ∀ l : Fin 3 → ℤ, ‖q-image‖ ≤ ‖q-(r+WithLp.toLp 2 (fun i => L*l i))‖
```

差异及额外假设：最近副本关系，等距时可不唯一；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:110`。

### CH01-160 · 定义 · 印刷p.35 / PDF58

原文（忠实转述）：A planar rhombic lattice has sides n_x,n_y and included angle theta.

```lean
def rhombicLattice (a b θ : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}
```

差异及额外假设：正边长、非退化角；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:113`。

### CH01-161 · 定义 · 印刷p.35 / PDF58

原文（忠实转述）：The hexagonal lattice is the equal-side rhombic lattice at 60 or 120 degrees.

```lean
def hexagonalLattice (a : ℝ) := rhombicLattice a a (Real.pi/3)
```

差异及额外假设：角规范，两种基；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:115`。

### CH01-162 · 定义 · 印刷p.35 / PDF58

原文（忠实转述）：A unit cell is repeated in coordinate directions to describe an atomic lattice.

```lean
def unitCellLattice (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Set V3 :=
  {q | ∃ k : Fin 3 → ℤ, ∃ u ∈ motif,
    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}
```

差异及额外假设：三维格子与有限motif；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:116`。

### CH01-163 · 定义 · 印刷p.35 / PDF58

原文（忠实转述）：A bcc unit cell has cubic corners and a body-center atom.

```lean
def bccCell : Set V3 :=
  {x | (∀ i, x i = 0 ∨ x i = 1) ∨ x = WithLp.toLp 2 ![1/2,1/2,1/2]}
```

差异及额外假设：几何motif，尺度为1；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:119`。

### CH01-164 · 定义 · 印刷p.36 / PDF59

原文（忠实转述）：An fcc lattice is an ABCABC stacking of hexagonal layers.

```lean
def fccStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 3
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

差异及额外假设：层偏移加整数格子；不证明最密堆积；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:123`。

### CH01-165 · 定义 · 印刷p.36 / PDF59

原文（忠实转述）：An hcp lattice alternates ABAB hexagonal layers.

```lean
def hcpStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 2
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

差异及额外假设：层偏移及两层周期；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:127`。

## §1.6.1

### CH01-166 · 未编号结论 · 印刷p.36 / PDF59

原文（忠实转述）：At a differentiable interior potential minimum gradient U=0.

```lean
def minimumGradientZero_statement : Prop :=
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0

theorem minimumGradientZero_proved : minimumGradientZero_statement
```

差异及额外假设：内部极小、可微；不登记边界极小的错误版本；完整证明见ReviewProofs。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:216;MolecularDynamics/Chapter01/ReviewProofs.lean:56`。

### CH01-167 · 未编号结论 · 印刷p.37 / PDF60

原文（忠实转述）：Near equilibrium gradient U(q)=U''(q*)(q-q*)+o(norm(q-q*)).

```lean
theorem gradientLinearization_expansion {n : ℕ}
    (U : PotentialEnergy n) (q₀ h : Position n) :
    gradient U (q₀ + h) =
      fderiv ℝ (gradient U) q₀ h + gradientLinearizationRemainder U q₀ h

theorem gradientLinearizationRemainder_isLittleO {n : ℕ}
    (U : PotentialEnergy n) (q₀ : Position n)
    (hU : ContDiffAt ℝ 2 U q₀) (heq : gradient U q₀ = 0) :
    (gradientLinearizationRemainder U q₀) =o[𝓝 0] (fun h : Position n => h)
```

差异及额外假设：真实C2势、平衡梯度零；恒等式与小o余项两条一起映射。

状态：**proved**。位置：`MolecularDynamics/Chapter01/LatticeVibrations.lean:21;MolecularDynamics/Chapter01/LatticeVibrations.lean:13`。

### CH01-168 · 定义 · 印刷p.37 / PDF60

原文（忠实转述）：Linearized motion is delta_q_dot=M^-1 delta_p, delta_p_dot=-U''(q*) delta_q.

```lean
theorem conservative_mechanical_linearization {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (z₀ : PhaseSpace n) (hU : ContDiffAt ℝ 2 U z₀.1) :
    HasFDerivAt (mechanicalVectorField m (fun q => -gradient U q))
      (mechanicalLinearization m (-fderiv ℝ (gradient U) z₀.1)) z₀
```

差异及额外假设：真实向量场微分及C2。

状态：**proved**。位置：`MolecularDynamics/Chapter01/EquilibriumLinearization.lean:78`。

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

### CH01-170 · 定义 · 印刷p.37 / PDF60

原文（忠实转述）：The Hamiltonian block matrix A has blocks 0,M^-1,-U''(q*),0.

```lean
def mechanicalLinearization {n : ℕ} (m : CoordinateMasses n)
    (DF : Position n →L[ℝ] Momentum n) : PhaseSpace n →L[ℝ] PhaseSpace n :=
  ((velocityOperator m).comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n))).prod
    (DF.comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n)))
```

差异及额外假设：CLM块作用等价矩阵。

状态：**proved**。位置：`MolecularDynamics/Chapter01/EquilibriumLinearization.lean:61`。

### CH01-171 · 未编号结论 · 印刷p.37 / PDF60

原文（忠实转述）：For positive definite M and Hessian, the eigenvalues of A are purely imaginary pairs plus/minus i Omega.

```lean
def imaginarySpectrum_statement : Prop :=
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    let A := fun z : PhaseSpace n => (M⁻¹.toEuclideanLin z.2,-K.toEuclideanLin z.1)
    ∀ (a b : ℝ) (x y : PhaseSpace n), (x ≠ 0 ∨ y ≠ 0) →
      A x = a • x - b • y → A y = b • x + a • y → a = 0
```

差异及额外假设：不把条件性normal mode当完整谱定理；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:224`。

### CH01-172 · 未编号结论 · 印刷p.37 / PDF60

原文（忠实转述）：An imaginary eigenpair gives conjugate exponential normal-mode solutions.

```lean
def normalModeComplex_statement : Prop :=
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (η : Fin n → ℂ) (Ω : ℝ),
    (A.map (algebraMap ℝ ℂ)).mulVec η = (Complex.I * Ω) • η →
    ∀ a b : ℂ, ∀ t : ℝ,
      HasDerivAt (fun s : ℝ =>
        a • (Complex.exp (Complex.I*Ω*s) • η) +
          b • (Complex.exp (-Complex.I*Ω*s) • (fun i => star (η i))))
        ((A.map (algebraMap ℝ ℂ)).mulVec
          (a • (Complex.exp (Complex.I*Ω*t) • η) +
            b • (Complex.exp (-Complex.I*Ω*t) • (fun i => star (η i))))) t
```

差异及额外假设：共轭对、实矩阵；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:229`。

### CH01-173 · 未编号结论 · 印刷p.37 / PDF60

原文（忠实转述）：Real normal modes are alpha[sin(Omega t)Re eta+cos(Omega t)Im eta]+beta[cos(Omega t)Re eta-sin(Omega t)Im eta].

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
theorem hasDerivAt_realNormalMode {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (A : E →L[ℝ] E) (Ω α β : ℝ) (u v : E)
    (hu : A u = -Ω • v) (hv : A v = Ω • u) (t : ℝ) :
    HasDerivAt (realNormalMode Ω α β u v)
      (A (realNormalMode Ω α β u v t)) t
```

差异及额外假设：真实特征向量分解作用假设；未自动构造全套模式。

状态：**proved**。位置：`MolecularDynamics/Chapter01/NormalModes.lean:16`。

## §1.7

### CH01-174 · 定义 · 印刷p.38 / PDF61

原文（忠实转述）：Central pair potentials have U_ij=phi_ij(norm(q_i-q_j)), U=1/2 sum_{i!=j} U_ij.

```lean
def centralPairEnergy {N : ℕ} (φ : Fin N → Fin N → ℝ → ℝ) (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.univ.erase i, φ i j (pairDistance (q i) (q j)))/2
```

差异及额外假设：对称逐对势，非碰撞；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:131`。

### CH01-175 · 未编号结论 · 印刷p.38 / PDF61

原文（忠实转述）：For central forces partial_i U_ij=-partial_j U_ij.

```lean
def centralPairGradient_statement : Prop :=
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x => φ ‖x-r‖) q = -gradient (fun y => φ ‖q-y‖) r
```

差异及额外假设：势可微、非碰撞；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:239`。

### CH01-176 · 未编号结论 · 印刷p.39 / PDF62

原文（忠实转述）：Central internal forces conserve total momentum.

```lean
theorem totalMomentumCoordinate_const_on_Ioo {N d : ℕ}
    (m : CoordinateMasses (N * d)) (F : Force (N * d))
    (Q : Set (Position (N * d))) (a b : ℝ)
    (γ : ℝ → PhaseSpace (N * d))
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hFsum : ∀ q ∈ Q, ∀ c : Fin d,
      ∑ i : Fin N, F q (particleCoordinateEquiv N d (i, c)) = 0)
    (c : Fin d) (s t : ℝ)
    (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    totalMomentumCoordinate (γ s).2 c = totalMomentumCoordinate (γ t).2 c
```

差异及额外假设：净力零；结构推出净力另条。

状态：**proved**。位置：`MolecularDynamics/Chapter01/MomentumConservation.lean:44`。

### CH01-177 · 未编号结论 · 印刷p.39 / PDF62

原文（忠实转述）：Central pair torques cancel and total angular momentum is conserved.

```lean
def totalAngularMomentum_statement : Prop :=
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    ∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t
```

差异及额外假设：已有单粒子平面版本，不冒充一般N体3D版本；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:244`。

### CH01-178 · 未编号结论 · 印刷p.39 / PDF62

原文（忠实转述）：The center of mass moves linearly under zero net force.

```lean
def centerOfMassMotion_statement : Prop :=
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (I : Set ℝ) (a : ℝ), IsOpen I → IsPreconnected I → a ∈ I →
    (∀ i, 0 < m i) → 0 < ∑ i, m i →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) →
    ∀ t ∈ I,
      (∑ i, m i)⁻¹ • (∑ i, m i • q t i) =
        (∑ i, m i)⁻¹ • (∑ i, m i • q a i) +
          (t-a) • ((∑ i, m i)⁻¹ • (∑ i, m i • v a i))
```

差异及额外假设：正质量、真实二阶Newton轨迹；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:252`。

### CH01-179 · 未编号结论 · 印刷p.39 / PDF62

原文（忠实转述）：Conservation of angular momentum is said to imply rotation at a constant rate in time.

```lean
def rotationLiteral_statement : Prop :=
  ∀ (r θ : ℝ → ℝ) (ℓ : ℝ),
    (∀ t, 0 < r t ∧ (r t)^2*deriv θ t = ℓ) →
    ∃ freq : ℝ, ∀ t, deriv θ t = freq
```

差异及额外假设：字面推论一般不成立：r变化时theta_dot=l/r^2。Prop保留该断言供审阅，未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:262`。

### CH01-180 · 定义 · 印刷p.39 / PDF62

原文（忠实转述）：The isosceles trimer positions are (x,-y/3),(-x,-y/3),(0,2y/3).

```lean
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]
```

差异及额外假设：保留正文代数推导，排除轨迹数值实验；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:133`。

### CH01-181 · 未编号结论 · 印刷p.39 / PDF62

原文（忠实转述）：The isosceles trimer energy is xdot^2+ydot^2/3+2phi_LJ(sqrt(x^2+y^2))+phi_LJ(2x).

```lean
def isoscelesEnergy (x y v w : ℝ) := v^2 + w^2/3 + isoscelesPotential x y
```

差异及额外假设：x>0，各距离正；单位质量；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:137`。

### CH01-182 · 未编号结论 · 印刷p.40 / PDF63

原文（忠实转述）：The accessible position region satisfies U(x,y)<=E because kinetic energy is nonnegative.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def isoscelesEnergyBound_statement : Prop :=
  ∀ x y v w E : ℝ, isoscelesEnergy x y v w = E → isoscelesPotential x y ≤ E

theorem isoscelesEnergyBound_proved : isoscelesEnergyBound_statement
```

差异及额外假设：真实代数结论，不登记图中轨迹；完整证明见ReviewProofs。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:266;MolecularDynamics/Chapter01/ReviewProofs.lean:41`。

### CH01-203 · 未编号结论 · 印刷p.38 / PDF61

原文（忠实转述）：For the unit LJ trimer an equilateral triangle minimizes U=3 phi_LJ(r), at r=2^(1/6).

```lean
def trimerMinimum_statement : Prop :=
  ∀ q : Fin 3 → V3, (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ uniformLJEnergy 1 1 q ∧
    (uniformLJEnergy 1 1 q = -3 ↔
      ∀ i j, i ≠ j → pairDistance (q i) (q j) = Real.rpow 2 (1/6))
```

差异及额外假设：正文分析结论，排除图/模拟；全局势下界-3及等边实现；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:329`。

### CH01-204 · 未编号结论 · 印刷p.40 / PDF63

原文（忠实转述）：The unit LJ trimer cannot attain E<-3.

```lean
def trimerLowerBound_statement : Prop :=
  ∀ (q v : Fin 3 → V3), (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ (∑ i, ‖v i‖^2/2) + uniformLJEnergy 1 1 q

theorem trimerLowerBound_proved : trimerLowerBound_statement
```

差异及额外假设：动能非负，每对势最低-1；完整证明见ReviewProofs。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:334;MolecularDynamics/Chapter01/ReviewProofs.lean:35`。

### CH01-205 · 定义 · 印刷p.40 / PDF63

原文（忠实转述）：The collinear trimer potential is Uhat(x)=2 phi_LJ(x)+phi_LJ(2x).

```lean
def collinearTrimer (x : ℝ) :=
  2*lennardJonesPotential 1 1 x + lennardJonesPotential 1 1 (2*x)
```

差异及额外假设：x>0；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/Statements.lean:337`。

### CH01-206 · 未编号结论 · 印刷p.40 / PDF63

原文（忠实转述）：The minimum in the collinear configuration is a saddle: U increases along x and decreases along y.

```lean
def trimerSaddle_statement : Prop :=
  ∃ x > 0, (∀ y > 0, collinearTrimer x ≤ collinearTrimer y) ∧
    ∃ δ > 0, (∀ u : ℝ, 0 < |u-x| → |u-x| < δ →
      isoscelesPotential x 0 < isoscelesPotential u 0) ∧
    ∀ y : ℝ, 0 < |y| → |y| < δ → isoscelesPotential x y < isoscelesPotential x 0
```

差异及额外假设：明确局部严格不等式；原文无完整证明，不开展符号高阶计算；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:339`。

### CH01-207 · 未编号结论 · 印刷p.40 / PDF63

原文（忠实转述）：When E>0 the trimer bodies eventually escape to infinity.

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def trimerEscapeLiteral_statement : Prop :=
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∃ i j : Fin 3, i ≠ j ∧ Tendsto (fun t => pairDistance (q t i) (q t j)) atTop atTop
```

差异及额外假设：针对前文质心固定、等腰、零角动量的正能量模型；字面一般逃逸断言未证明，待人工判断。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:344`。

## §1.7.1

### CH01-183 · 定义 · 印刷p.41 / PDF64

原文（忠实转述）：Sensitive dependence means arbitrarily nearby initial points can later separate by a fixed visible amount.

```lean
def sensitiveDependence {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  ∃ ε > 0, ∀ x ∈ D, ∀ δ > 0, ∃ y ∈ D, dist x y < δ ∧
    ∃ t ≥ 0, ε ≤ dist (F t x) (F t y)
```

差异及额外假设：原文描述非严格，给标准量词版；不要求无限有界域指数增长；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:138`。

### CH01-184 · 定义 · 印刷p.41 / PDF64

原文（忠实转述）：Chaos includes sensitive dependence and topological transitivity on phase domain D.

```lean
def chaosConditions {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  sensitiveDependence F D ∧ topologicalTransitivity F D
```

差异及额外假设：只记录本章两个必要性质，不补密周期点条件；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:144`。

### CH01-185 · 定义 · 印刷p.42 / PDF65

原文（忠实转述）：Topological transitivity means a trajectory joins any two nonempty open neighborhoods in D.

```lean
def topologicalTransitivity {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  ∀ U V : Set (Position n), IsOpen U → IsOpen V → (U ∩ D).Nonempty →
    (V ∩ D).Nonempty → ∃ t ≥ 0, ∃ x ∈ U ∩ D, F t x ∈ V ∩ D
```

差异及额外假设：正时间流，相对拓扑；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:141`。

### CH01-186 · 未编号结论 · 印刷p.42 / PDF65

原文（忠实转述）：Topological transitivity is essentially equivalent to ergodicity.

```lean
def transitivityErgodicityLiteral_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n)
    (F : ℝ → Position n → Position n) (μ : Measure (Position n)),
    isFlowOf f F → Continuous (Function.uncurry F) →
    (∀ t, MeasurePreserving (F t) μ μ) →
    (topologicalTransitivity F univ ↔ flowErgodic F μ)
```

差异及额外假设：缺少不变测度，通常不等价；保留文字涉及的数学对象与待审问题；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:273`。

### CH01-187 · 定义 · 印刷p.42 / PDF65

原文（忠实转述）：The anisotropic oscillator energy is (xdot^2+ydot^2)/2+k(c3)(r-l(c3))^2/2, (1.9).

```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```

差异及额外假设：仅模型公式，排除其介绍性数值轨迹和实验结论；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:151`。

### CH01-188 · 定义 · 印刷p.42 / PDF65

原文（忠实转述）：c3=cos(3theta)=4c^3-3c, c=x/r.

```lean
def anisotropicAngular (x y : ℝ) :=
  let c := x/Real.sqrt (x^2+y^2)
  4*c^3-3*c
```

差异及额外假设：r>0，三倍角关系；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:146`。

### CH01-189 · 定义 · 印刷p.42 / PDF65

原文（忠实转述）：k(c3)=k0(1-epsilon c3/2), l(c3)=l0(1+epsilon c3/2).

```lean
def anisotropicParameters (κ₀ l₀ ε c₃ : ℝ) : ℝ × ℝ :=
  (κ₀*(1-ε*c₃/2),l₀*(1+ε*c₃/2))
```

差异及额外假设：参数函数，不登记数值实验；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:149`。

## §1.7.2

### CH01-190 · notation · 印刷p.44 / PDF67

原文（忠实转述）：The flow F_t is assumed continuously differentiable in its initial condition.

```lean
def differentiableFlow {n : ℕ} (F : ℝ → Position n → Position n) : Prop :=
  ∀ t, ContDiff ℝ 1 (F t)
```

差异及额外假设：原文C1假设，joint正则性另述；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:154`。

### CH01-191 · 定义 · 印刷p.44 / PDF67

原文（忠实转述）：The printed variational matrix is W(t)=F_t'(z(t,xi)).

```lean
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)
```

差异及额外假设：忠实原文取值点；通常应在xi取导数；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:156`。

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

### CH01-193 · 未编号结论 · 印刷p.45 / PDF68

原文（忠实转述）：Nearby trajectories differ to first order by W(t)(xi_hat-xi).

```lean
def flowFirstOrder_statement : Prop :=
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-fderiv ℝ (F t) ξ (x-ξ)) =o[𝓝 ξ] (fun x => x-ξ)
```

差异及额外假设：严格小o形式，固定t；W在初值xi取导数；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:290`。

### CH01-194 · 定义 · 印刷p.45 / PDF68

原文（忠实转述）：Singular values are square roots of eigenvalues of A^T A, ordered largest to smallest.

```lean
def singularValues {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ) : Prop :=
  (∀ i, 0 ≤ σ i) ∧ Antitone σ ∧
  ∃ O : Matrix (Fin n) (Fin n) ℝ,
    O.transpose*O=1 ∧ O.transpose*(A.transpose*A)*O=Matrix.diagonal (fun i => (σ i)^2)
```

差异及额外假设：有限维实矩阵，非负、有序；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:158`。

### CH01-195 · 未编号结论 · 印刷p.45 / PDF68

原文（忠实转述）：An invertible linear map sends a unit sphere to an ellipsoid whose semi-axes are its singular values.

```lean
def singularEllipsoid_statement : Prop :=
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ), IsUnit A →
    singularValues A σ →
    ∃ O : Matrix (Fin n) (Fin n) ℝ, O.transpose*O=1 ∧
      (A.toEuclideanLin '' {v : Position n | ‖v‖=1}) =
        {x : Position n | ∑ i, ((O.transpose.toEuclideanLin x) i / σ i)^2 = 1}
```

差异及额外假设：奇异值分解与像椭球，暂不建设谱几何理论；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:293`。

### CH01-196 · 定义 · 印刷p.45 / PDF68

原文（忠实转述）：lambda_i=limsup_{t->infinity} (1/t) log sigma_i(W(t)).

```lean
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
def lyapunovExponent (σ : ℝ → ℝ) : EReal :=
  Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop
```

差异及额外假设：扩展实值limsup，W可逆避免log0；定义/notation已实现，此状态不表示解存在或经验模型已验证。

状态：**proved**。位置：`MolecularDynamics/Chapter01/ReviewDefinitions.lean:162`。

### CH01-197 · 未编号结论 · 印刷p.45 / PDF68

原文（忠实转述）：A positive Lyapunov exponent implies exponential amplification of infinitesimal perturbations.

```lean
def positiveLyapunovGrowth_statement : Prop :=
  ∀ σ : ℝ → ℝ, (∀ t > 0, 0 < σ t) → 0 < lyapunovExponent σ →
    ∃ c > 0, ∀ T : ℝ, ∃ t > T, Real.exp (c*t) < σ t
```

差异及额外假设：limsup给无穷时间子列增长，不保证所有充分大t的统一增长；Prop陈述未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter01/Statements.lean:299`。
