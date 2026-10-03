请独立审阅并托管检查T3固定正对角质量Hamiltonian完整证明。本批已经在本地固定版本完整证明；请核实其教材语义、原九Goal一致性和Lean合法性，不只是登记类型。

独立审阅范围仅T3-K1/E1/P1/G1/G2/V1/R1。不要向T2运行中任务插入指令，不修改共享源码，不开启全书其他批次，不升级工具链或mathlib。新建本批审阅返回文件，保留原报告及RETURN_METADATA.json。

仓库https://github.com/zhuanxv-G/MolecularDynamicsFormalization，稳定T1基准121a9d02ad15500c630e505b363d5f04106d617f，本地最新已提交T2基准675fcaedbdef7b6ec57393c1ee99e9ca727da649。Lean固定leanprover/lean4:v4.34.0，mathlib固定5ed2965256430c3649e86755f9576b54eca72435。本批草稿尚未推送；不要声称仓库已有T3正式模块。以下附原字节文件，均UTF-8；按声明哈希核对输入，缺失或不匹配请报告阻断，不能猜测源码。

请逐项检查：正质量与整个矩阵逆的限制；任意实质量的总除法边界；n/N/d为0；粒子展开顺序；真实HasGradientAt与总gradient分层；位置可微性；普通乘积相空间的两个欧氏切片；静态向量场与真实时间ODE的边界。不要把要证明的结论作为假设。禁止sorry/admit/新公理/unsafe绕过。

交付：逐九Goal的接受/修订/阻断与明确理由、教材印刷24/25与PDF47/48对应语义、实际托管执行命令/版本/退出码/日志、公理依赖、每个输入及输出的SHA256台账。没执行完整编译就明说，不用本地日志冒充网站执行。教材原图本批不附，若无法访问原PDF请把原页核对标成未独立完成。

审阅主输入是独立完整草稿Probe06_ExactSpecProofs.lean，包含原九Goal及逐一完整证明；它只依赖T1四个源码文件。Probe07_Boundaries.lean给边界验证。正式候选与T2接口兼容的Probe08/10本地退出0；本次正文不附重复源，仅列其哈希，不要求网站据未附文件宣称编译通过。

Probe06 SHA 16145fad8913dec44e98a4ad9689b96f6d258c2b236513a6cc388f419e2b20e9；Probe07 SHA ecb56fe5bdca24f3cce412b5310dea69e8cb6d22c6171ca05fbaf7e7c700e975；Probe08 SHA de461733581b0f54f7ba879b8dfbd4c85fb83f8501095314bb037e8bb7b69ad7；Probe10 SHA 5ad24dfce71c9fdae6c9b15164abad63fab324dbd43d9151137394cc4bdd1b48。

文件：Probe06_ExactSpecProofs.lean；字节数14638；SHA256 16145fad8913dec44e98a4ad9689b96f6d258c2b236513a6cc388f419e2b20e9

```lean
import MolecularDynamics.Chapter01.ParticleCoordinates

/-!
Complete isolated T3 draft for the fixed diagonal mass Hamiltonian.
Printed pages 18--19 and 24--25, PDF pages 41--42 and 47--48.
This module does not change the formal library. Operator definitions match
T2-L0 and will be replaced by shared names on coordinated integration.
-/

open MolecularDynamics
open scoped InnerProductSpace

set_option synthInstance.maxHeartbeats 2000

namespace T3Implementation

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

noncomputable def massOperator {n : ℕ} (m : CoordinateMasses n) :
    Velocity n →L[ℝ] Momentum n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix m)).toContinuousLinearMap

noncomputable def velocityOperator {n : ℕ} (m : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix m)⁻¹).toContinuousLinearMap

noncomputable def coordinateVelocity {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : Velocity n := WithLp.toLp 2 (fun i => p i / m i)

noncomputable def momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : ℝ := ∑ i, (p i)^2 / (2 * m i)

noncomputable def massSeparableEnergy {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : SeparableEnergy n := ⟨momentumKineticEnergy m, U⟩

noncomputable def massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : Hamiltonian n := (massSeparableEnergy m U).hamiltonian

noncomputable def hamiltonianVectorField {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (z : PhaseSpace n) : PhaseSpace n :=
  (gradient (fun p => massHamiltonian m U (z.1, p)) z.2,
    -gradient (fun q => massHamiltonian m U (q, z.2)) z.1)

@[simp] theorem massOperator_apply {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) (i : Fin n) : massOperator m v i = m i * v i := by
  change (Matrix.diagonal m).mulVec v i = _
  simp [Matrix.mulVec, dotProduct, Matrix.diagonal]

@[simp] theorem coordinateVelocity_apply {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (i : Fin n) : coordinateVelocity m p i = p i / m i := rfl

theorem velocityOperator_apply {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) (i : Fin n) :
    velocityOperator m p i = p i / m i := by
  change ((diagonalMassMatrix m)⁻¹).mulVec p i = _
  rw [diagonalMassMatrix_inv_eq m hm]
  simp [Matrix.mulVec, dotProduct, Matrix.diagonal, div_eq_mul_inv, mul_comm]

theorem coordinateVelocity_eq_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    coordinateVelocity m p = velocityOperator m p := by
  ext i
  rw [coordinateVelocity_apply, velocityOperator_apply m hm]

theorem massOperator_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    massOperator m (velocityOperator m p) = p := by
  ext i
  rw [massOperator_apply, velocityOperator_apply m hm]
  field_simp [ne_of_gt (hm i)]

/-- T3-K1: the matrix expression uses the whole inverse and positive masses. -/
theorem momentumKineticEnergy_eq_inner {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    momentumKineticEnergy m p = inner ℝ p (velocityOperator m p) / 2 := by
  rw [EuclideanSpace.inner_eq_star_dotProduct]
  simp only [star_trivial, dotProduct, Finset.sum_div]
  unfold momentumKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [velocityOperator_apply m hm]
  ring

/-- T3-E1: total coordinate division makes the algebra valid for all real masses. -/
theorem momentumKineticEnergy_massOperator {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) : momentumKineticEnergy m (massOperator m v) =
    nBodyKineticEnergy m v := by
  unfold momentumKineticEnergy nBodyKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [massOperator_apply]
  by_cases h : m i = 0
  · simp [h]
  · field_simp

theorem massHamiltonian_massOperator {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) :
    massHamiltonian m U (q, massOperator m v) = nBodyTotalEnergy m U q v := by
  change momentumKineticEnergy m (massOperator m v) + U q = _
  rw [momentumKineticEnergy_massOperator]
  rfl

/-- T3-P1: particle energy is the coordinate model under the established flattening. -/
theorem massHamiltonian_particle {N d : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N*d)) (q v : ParticleVectors N d) :
    massHamiltonian (coordinateMassesOfParticles (d := d) m) U
      (flattenParticleVectors q,
        massOperator (coordinateMassesOfParticles (d := d) m) (flattenParticleVectors v)) =
    particleKineticEnergy m v + U (flattenParticleVectors q) := by
  rw [massHamiltonian_massOperator]
  unfold nBodyTotalEnergy
  rw [nBodyKineticEnergy_particle_eq]

/-- T3-R1: recover the velocity energy for an arbitrary momentum. -/
theorem massHamiltonian_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    massHamiltonian m U (q,p) = nBodyTotalEnergy m U q (velocityOperator m p) := by
  have h := massHamiltonian_massOperator m U q (velocityOperator m p)
  rw [massOperator_velocityOperator m hm] at h
  exact h

theorem coordinateDualRepresentation {n : ℕ} (g : Momentum n) :
    (∑ i : Fin n, g i • EuclideanSpace.proj (𝕜 := ℝ) i) =
      InnerProductSpace.toDual ℝ (Momentum n) g := by
  ext w
  simp [InnerProductSpace.toDual_apply_apply, EuclideanSpace.inner_eq_star_dotProduct,
    dotProduct, mul_comm]

/-- Each term is a fixed coefficient polynomial, including the mass-zero convention. -/
theorem hasFDerivAt_kinetic_term {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (i : Fin n) :
    HasFDerivAt (fun x : Momentum n => (x i)^2 / (2 * m i))
      ((p i / m i) • EuclideanSpace.proj (𝕜 := ℝ) i) p := by
  have hi : HasFDerivAt (fun x : Momentum n => x i)
      (EuclideanSpace.proj (𝕜 := ℝ) i) p :=
    (EuclideanSpace.proj (𝕜 := ℝ) i).hasFDerivAt
  have hcoeff : (2 * m i)⁻¹ * (p i + p i) = p i / m i := by
    by_cases h : m i = 0
    · simp [h]
    · field_simp; ring
  convert (hi.mul hi).mul_const ((2 * m i)⁻¹) using 1
  · ext x
    simp only [div_eq_mul_inv, pow_two, Pi.mul_apply]
  · ext x
    simp only [smul_apply, add_apply,
      smul_eq_mul, EuclideanSpace.coe_proj]
    rw [← hcoeff]
    ring

/-- T3-G1: a genuine Frechet derivative identifies the coordinate gradient. -/
theorem hasGradientAt_momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) :
    HasGradientAt (momentumKineticEnergy m) (coordinateVelocity m p) p := by
  rw [hasGradientAt_iff_hasFDerivAt]
  have hsum : HasFDerivAt (momentumKineticEnergy m)
      (∑ i : Fin n, (p i / m i) • EuclideanSpace.proj (𝕜 := ℝ) i) p :=
    HasFDerivAt.fun_sum (fun i _ => hasFDerivAt_kinetic_term m p i)
  have hdual := coordinateDualRepresentation (coordinateVelocity m p)
  simp only [coordinateVelocity_apply] at hdual
  rw [hdual] at hsum
  exact hsum

theorem gradient_momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : gradient (momentumKineticEnergy m) p = coordinateVelocity m p :=
  (hasGradientAt_momentumKineticEnergy m p).gradient

theorem gradient_momentumKineticEnergy_eq_velocityOperator {n : ℕ}
    (m : CoordinateMasses n) (hm : ∀ i, 0 < m i) (p : Momentum n) :
    gradient (momentumKineticEnergy m) p = velocityOperator m p := by
  rw [gradient_momentumKineticEnergy, coordinateVelocity_eq_velocityOperator m hm]

/-- T3-G2: this total-operation identity does not assert that U is differentiable. -/
theorem gradient_position_slice {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    gradient (fun x => massHamiltonian m U (x,p)) q = gradient U q := by
  simp only [massHamiltonian, massSeparableEnergy, SeparableEnergy.hamiltonian,
    gradient, fderiv_const_add]

theorem gradient_momentum_slice {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    gradient (fun x => massHamiltonian m U (q,x)) p =
      gradient (momentumKineticEnergy m) p := by
  simp only [massHamiltonian, massSeparableEnergy, SeparableEnergy.hamiltonian,
    gradient, fderiv_add_const]

/-- A differentiability premise supplies the classical position partial derivative. -/
theorem hasGradientAt_position_slice {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n)
    (hU : DifferentiableAt ℝ U q) :
    HasGradientAt (fun x => massHamiltonian m U (x,p)) (gradient U q) q := by
  rw [hasGradientAt_iff_hasFDerivAt]
  exact hU.hasGradientAt.hasFDerivAt.const_add (momentumKineticEnergy m p)

/-- T3-V1 is a static field identity, not a theorem about time trajectories. -/
theorem hamiltonianVectorField_eq {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (U : PotentialEnergy n) (z : PhaseSpace n) :
    hamiltonianVectorField m U z = (velocityOperator m z.2, -gradient U z.1) := by
  unfold hamiltonianVectorField
  rw [gradient_position_slice, gradient_momentum_slice,
    gradient_momentumKineticEnergy_eq_velocityOperator m hm]

#print axioms momentumKineticEnergy_eq_inner
#print axioms massHamiltonian_massOperator
#print axioms massHamiltonian_particle
#print axioms massHamiltonian_velocityOperator
#print axioms hasGradientAt_momentumKineticEnergy
#print axioms gradient_momentumKineticEnergy_eq_velocityOperator
#print axioms gradient_position_slice
#print axioms hasGradientAt_position_slice
#print axioms hamiltonianVectorField_eq

end T3Implementation

namespace T3Implementation

-- Proposition-valued descriptions only: no proof placeholders or target
-- conclusions disguised as premises.
def matrixKineticGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) : Prop :=
  (∀ i, 0 < m i) →
    momentumKineticEnergy m p = inner ℝ p (velocityOperator m p) / 2

def velocityEnergyGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : Prop :=
  massHamiltonian m U (q, massOperator m v) = nBodyTotalEnergy m U q v

def particleEnergyGoal {N d : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N*d)) (q v : ParticleVectors N d) : Prop :=
  massHamiltonian (coordinateMassesOfParticles (d := d) m) U
      (flattenParticleVectors q,
        massOperator (coordinateMassesOfParticles (d := d) m) (flattenParticleVectors v)) =
    particleKineticEnergy m v + U (flattenParticleVectors q)

def coordinateGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) : Prop :=
  HasGradientAt (momentumKineticEnergy m) (coordinateVelocity m p) p

def matrixGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) : Prop :=
  (∀ i, 0 < m i) → gradient (momentumKineticEnergy m) p = velocityOperator m p

def positionGradientGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : Prop :=
  DifferentiableAt ℝ U q →
    HasGradientAt (fun x => massHamiltonian m U (x, p)) (gradient U q) q

def positionTotalGradientGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : Prop :=
  gradient (fun x => massHamiltonian m U (x, p)) q = gradient U q

def vectorFieldGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z : PhaseSpace n) : Prop :=
  (∀ i, 0 < m i) →
    hamiltonianVectorField m U z = (velocityOperator m z.2, -gradient U z.1)

def inverseEnergyGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : Prop :=
  (∀ i, 0 < m i) →
    massHamiltonian m U (q, p) = nBodyTotalEnergy m U q (velocityOperator m p)

#print matrixKineticGoal
#print velocityEnergyGoal
#print particleEnergyGoal
#print coordinateGradientGoal
#print matrixGradientGoal
#print positionGradientGoal
#print positionTotalGradientGoal
#print vectorFieldGoal
#print inverseEnergyGoal

end T3Implementation

namespace T3Implementation

theorem prove_matrixKineticGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) :
    matrixKineticGoal m p := fun hm => momentumKineticEnergy_eq_inner m hm p

theorem prove_velocityEnergyGoal {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) :
    velocityEnergyGoal m U q v := massHamiltonian_massOperator m U q v

theorem prove_particleEnergyGoal {N d : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N*d)) (q v : ParticleVectors N d) :
    particleEnergyGoal m U q v := massHamiltonian_particle m U q v

theorem prove_coordinateGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) :
    coordinateGradientGoal m p := hasGradientAt_momentumKineticEnergy m p

theorem prove_matrixGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) :
    matrixGradientGoal m p :=
  fun hm => gradient_momentumKineticEnergy_eq_velocityOperator m hm p

theorem prove_positionGradientGoal {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    positionGradientGoal m U q p := fun hU => hasGradientAt_position_slice m U q p hU

theorem prove_positionTotalGradientGoal {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    positionTotalGradientGoal m U q p := gradient_position_slice m U q p

theorem prove_vectorFieldGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z : PhaseSpace n) : vectorFieldGoal m U z := fun hm => hamiltonianVectorField_eq m hm U z

theorem prove_inverseEnergyGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : inverseEnergyGoal m U q p :=
  fun hm => massHamiltonian_velocityOperator m hm U q p

#print axioms prove_matrixKineticGoal
#print axioms prove_velocityEnergyGoal
#print axioms prove_particleEnergyGoal
#print axioms prove_coordinateGradientGoal
#print axioms prove_matrixGradientGoal
#print axioms prove_positionGradientGoal
#print axioms prove_positionTotalGradientGoal
#print axioms prove_vectorFieldGoal
#print axioms prove_inverseEnergyGoal

end T3Implementation
```

文件：Probe07_Boundaries.lean；字节数12074；SHA256 ecb56fe5bdca24f3cce412b5310dea69e8cb6d22c6171ca05fbaf7e7c700e975

```lean
import MolecularDynamics.Chapter01.ParticleCoordinates

/-!
Complete isolated T3 draft for the fixed diagonal mass Hamiltonian.
Printed pages 18--19 and 24--25, PDF pages 41--42 and 47--48.
This module does not change the formal library. Operator definitions match
T2-L0 and will be replaced by shared names on coordinated integration.
-/

open MolecularDynamics
open scoped InnerProductSpace

set_option synthInstance.maxHeartbeats 2000

namespace T3Implementation

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

noncomputable def massOperator {n : ℕ} (m : CoordinateMasses n) :
    Velocity n →L[ℝ] Momentum n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix m)).toContinuousLinearMap

noncomputable def velocityOperator {n : ℕ} (m : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix m)⁻¹).toContinuousLinearMap

noncomputable def coordinateVelocity {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : Velocity n := WithLp.toLp 2 (fun i => p i / m i)

noncomputable def momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : ℝ := ∑ i, (p i)^2 / (2 * m i)

noncomputable def massSeparableEnergy {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : SeparableEnergy n := ⟨momentumKineticEnergy m, U⟩

noncomputable def massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : Hamiltonian n := (massSeparableEnergy m U).hamiltonian

noncomputable def hamiltonianVectorField {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (z : PhaseSpace n) : PhaseSpace n :=
  (gradient (fun p => massHamiltonian m U (z.1, p)) z.2,
    -gradient (fun q => massHamiltonian m U (q, z.2)) z.1)

@[simp] theorem massOperator_apply {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) (i : Fin n) : massOperator m v i = m i * v i := by
  change (Matrix.diagonal m).mulVec v i = _
  simp [Matrix.mulVec, dotProduct, Matrix.diagonal]

@[simp] theorem coordinateVelocity_apply {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (i : Fin n) : coordinateVelocity m p i = p i / m i := rfl

theorem velocityOperator_apply {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) (i : Fin n) :
    velocityOperator m p i = p i / m i := by
  change ((diagonalMassMatrix m)⁻¹).mulVec p i = _
  rw [diagonalMassMatrix_inv_eq m hm]
  simp [Matrix.mulVec, dotProduct, Matrix.diagonal, div_eq_mul_inv, mul_comm]

theorem coordinateVelocity_eq_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    coordinateVelocity m p = velocityOperator m p := by
  ext i
  rw [coordinateVelocity_apply, velocityOperator_apply m hm]

theorem massOperator_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    massOperator m (velocityOperator m p) = p := by
  ext i
  rw [massOperator_apply, velocityOperator_apply m hm]
  field_simp [ne_of_gt (hm i)]

/-- T3-K1: the matrix expression uses the whole inverse and positive masses. -/
theorem momentumKineticEnergy_eq_inner {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    momentumKineticEnergy m p = inner ℝ p (velocityOperator m p) / 2 := by
  rw [EuclideanSpace.inner_eq_star_dotProduct]
  simp only [star_trivial, dotProduct, Finset.sum_div]
  unfold momentumKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [velocityOperator_apply m hm]
  ring

/-- T3-E1: total coordinate division makes the algebra valid for all real masses. -/
theorem momentumKineticEnergy_massOperator {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) : momentumKineticEnergy m (massOperator m v) =
    nBodyKineticEnergy m v := by
  unfold momentumKineticEnergy nBodyKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [massOperator_apply]
  by_cases h : m i = 0
  · simp [h]
  · field_simp

theorem massHamiltonian_massOperator {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) :
    massHamiltonian m U (q, massOperator m v) = nBodyTotalEnergy m U q v := by
  change momentumKineticEnergy m (massOperator m v) + U q = _
  rw [momentumKineticEnergy_massOperator]
  rfl

/-- T3-P1: particle energy is the coordinate model under the established flattening. -/
theorem massHamiltonian_particle {N d : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N*d)) (q v : ParticleVectors N d) :
    massHamiltonian (coordinateMassesOfParticles (d := d) m) U
      (flattenParticleVectors q,
        massOperator (coordinateMassesOfParticles (d := d) m) (flattenParticleVectors v)) =
    particleKineticEnergy m v + U (flattenParticleVectors q) := by
  rw [massHamiltonian_massOperator]
  unfold nBodyTotalEnergy
  rw [nBodyKineticEnergy_particle_eq]

/-- T3-R1: recover the velocity energy for an arbitrary momentum. -/
theorem massHamiltonian_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    massHamiltonian m U (q,p) = nBodyTotalEnergy m U q (velocityOperator m p) := by
  have h := massHamiltonian_massOperator m U q (velocityOperator m p)
  rw [massOperator_velocityOperator m hm] at h
  exact h

theorem coordinateDualRepresentation {n : ℕ} (g : Momentum n) :
    (∑ i : Fin n, g i • EuclideanSpace.proj (𝕜 := ℝ) i) =
      InnerProductSpace.toDual ℝ (Momentum n) g := by
  ext w
  simp [InnerProductSpace.toDual_apply_apply, EuclideanSpace.inner_eq_star_dotProduct,
    dotProduct, mul_comm]

/-- Each term is a fixed coefficient polynomial, including the mass-zero convention. -/
theorem hasFDerivAt_kinetic_term {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (i : Fin n) :
    HasFDerivAt (fun x : Momentum n => (x i)^2 / (2 * m i))
      ((p i / m i) • EuclideanSpace.proj (𝕜 := ℝ) i) p := by
  have hi : HasFDerivAt (fun x : Momentum n => x i)
      (EuclideanSpace.proj (𝕜 := ℝ) i) p :=
    (EuclideanSpace.proj (𝕜 := ℝ) i).hasFDerivAt
  have hcoeff : (2 * m i)⁻¹ * (p i + p i) = p i / m i := by
    by_cases h : m i = 0
    · simp [h]
    · field_simp; ring
  convert (hi.mul hi).mul_const ((2 * m i)⁻¹) using 1
  · ext x
    simp only [div_eq_mul_inv, pow_two, Pi.mul_apply]
  · ext x
    simp only [smul_apply, add_apply,
      smul_eq_mul, EuclideanSpace.coe_proj]
    rw [← hcoeff]
    ring

/-- T3-G1: a genuine Frechet derivative identifies the coordinate gradient. -/
theorem hasGradientAt_momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) :
    HasGradientAt (momentumKineticEnergy m) (coordinateVelocity m p) p := by
  rw [hasGradientAt_iff_hasFDerivAt]
  have hsum : HasFDerivAt (momentumKineticEnergy m)
      (∑ i : Fin n, (p i / m i) • EuclideanSpace.proj (𝕜 := ℝ) i) p :=
    HasFDerivAt.fun_sum (fun i _ => hasFDerivAt_kinetic_term m p i)
  have hdual := coordinateDualRepresentation (coordinateVelocity m p)
  simp only [coordinateVelocity_apply] at hdual
  rw [hdual] at hsum
  exact hsum

theorem gradient_momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : gradient (momentumKineticEnergy m) p = coordinateVelocity m p :=
  (hasGradientAt_momentumKineticEnergy m p).gradient

theorem gradient_momentumKineticEnergy_eq_velocityOperator {n : ℕ}
    (m : CoordinateMasses n) (hm : ∀ i, 0 < m i) (p : Momentum n) :
    gradient (momentumKineticEnergy m) p = velocityOperator m p := by
  rw [gradient_momentumKineticEnergy, coordinateVelocity_eq_velocityOperator m hm]

/-- T3-G2: this total-operation identity does not assert that U is differentiable. -/
theorem gradient_position_slice {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    gradient (fun x => massHamiltonian m U (x,p)) q = gradient U q := by
  simp only [massHamiltonian, massSeparableEnergy, SeparableEnergy.hamiltonian,
    gradient, fderiv_const_add]

theorem gradient_momentum_slice {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    gradient (fun x => massHamiltonian m U (q,x)) p =
      gradient (momentumKineticEnergy m) p := by
  simp only [massHamiltonian, massSeparableEnergy, SeparableEnergy.hamiltonian,
    gradient, fderiv_add_const]

/-- A differentiability premise supplies the classical position partial derivative. -/
theorem hasGradientAt_position_slice {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n)
    (hU : DifferentiableAt ℝ U q) :
    HasGradientAt (fun x => massHamiltonian m U (x,p)) (gradient U q) q := by
  rw [hasGradientAt_iff_hasFDerivAt]
  exact hU.hasGradientAt.hasFDerivAt.const_add (momentumKineticEnergy m p)

/-- T3-V1 is a static field identity, not a theorem about time trajectories. -/
theorem hamiltonianVectorField_eq {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (U : PotentialEnergy n) (z : PhaseSpace n) :
    hamiltonianVectorField m U z = (velocityOperator m z.2, -gradient U z.1) := by
  unfold hamiltonianVectorField
  rw [gradient_position_slice, gradient_momentum_slice,
    gradient_momentumKineticEnergy_eq_velocityOperator m hm]

#print axioms momentumKineticEnergy_eq_inner
#print axioms massHamiltonian_massOperator
#print axioms massHamiltonian_particle
#print axioms massHamiltonian_velocityOperator
#print axioms hasGradientAt_momentumKineticEnergy
#print axioms gradient_momentumKineticEnergy_eq_velocityOperator
#print axioms gradient_position_slice
#print axioms hasGradientAt_position_slice
#print axioms hamiltonianVectorField_eq

end T3Implementation

namespace T3BoundaryVerification

open T3Implementation

def mixedMass : CoordinateMasses 2 := ![0, 2]
def mixedMomentum : Momentum 2 := WithLp.toLp 2 ![0, 4]

theorem mixedMass_inv_zero : (diagonalMassMatrix mixedMass)⁻¹ = 0 := by
  apply Matrix.nonsing_inv_apply_not_isUnit
  simp [diagonalMassMatrix, Matrix.det_diagonal, mixedMass, Fin.prod_univ_two]

theorem mixed_coordinate_kinetic : momentumKineticEnergy mixedMass mixedMomentum = 4 := by
  norm_num [momentumKineticEnergy, mixedMass, mixedMomentum, Fin.sum_univ_two]

theorem mixed_matrix_kinetic : inner ℝ mixedMomentum (velocityOperator mixedMass mixedMomentum) / 2 = 0 := by
  have hz : velocityOperator mixedMass mixedMomentum = 0 := by
    ext i
    change ((diagonalMassMatrix mixedMass)⁻¹).mulVec mixedMomentum i = 0
    rw [mixedMass_inv_zero]
    simp
  rw [hz]
  simp

theorem empty_kinetic (m : CoordinateMasses 0) (p : Momentum 0) :
    momentumKineticEnergy m p = 0 := by
  unfold momentumKineticEnergy
  exact Finset.sum_empty

theorem empty_hamiltonian (m : CoordinateMasses 0) (U : PotentialEnergy 0)
    (q : Position 0) (p : Momentum 0) : massHamiltonian m U (q,p) = U q := by
  change momentumKineticEnergy m p + U q = U q
  rw [empty_kinetic, zero_add]

def oneMass : CoordinateMasses 1 := fun _ => 2
def oneVelocity : Velocity 1 := WithLp.toLp 2 (fun _ => 3)

theorem scalar_example : massHamiltonian oneMass (fun _ => 7)
    (0, massOperator oneMass oneVelocity) = 16 := by
  rw [massHamiltonian_massOperator]
  norm_num [nBodyTotalEnergy, nBodyKineticEnergy, oneMass, oneVelocity, Fin.sum_univ_one]

theorem negative_mass_example :
    momentumKineticEnergy (fun _ : Fin 1 => -1) (WithLp.toLp 2 (fun _ => 2)) = -2 := by
  norm_num [momentumKineticEnergy, Fin.sum_univ_one]

#print axioms mixedMass_inv_zero
#print axioms mixed_coordinate_kinetic
#print axioms mixed_matrix_kinetic
#print axioms empty_kinetic
#print axioms empty_hamiltonian
#print axioms scalar_example
#print axioms negative_mass_example

end T3BoundaryVerification
```

文件：BasicDefinitions.lean；字节数487；SHA256 db3ebc5216f3f4beeae14397b2997e23195edff7f370f0343a2cd727e5d46ff6

```lean
import MolecularDynamics.Notation

namespace MolecularDynamics

/-- Data for a separable Hamiltonian `H(q, p) = K(p) + U(q)`.
The relation of `K` to a mass matrix and of force to `U` is specified later. -/
structure SeparableEnergy (n : ℕ) where
  kinetic : KineticEnergy n
  potential : PotentialEnergy n

def SeparableEnergy.hamiltonian {n : ℕ} (energy : SeparableEnergy n) : Hamiltonian n :=
  fun state => energy.kinetic state.2 + energy.potential state.1

end MolecularDynamics
```

文件：Notation.lean；字节数999；SHA256 bb1a15770c904a355f60f7ee76b55d7bff040d0e225c379c56b467f116c90588

```lean
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Data.Matrix.Basic

/-!
Minimal real, finite-dimensional notation for the autonomous mechanical models.
`n` counts configuration coordinates (`N_c` in the textbook). It equals the
degrees of freedom only in an unconstrained coordinate model. Particle and
spatial indices are introduced in Chapter01.ParticleCoordinates.
-/

namespace MolecularDynamics

abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)

abbrev PhaseSpace (n : ℕ) := Position n × Momentum n
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ

abbrev Force (n : ℕ) := Position n → Position n
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
abbrev KineticEnergy (n : ℕ) := Momentum n → ℝ
abbrev Lagrangian (n : ℕ) := Position n → Velocity n → ℝ
abbrev Hamiltonian (n : ℕ) := PhaseSpace n → ℝ

end MolecularDynamics
```

文件：NBody.lean；字节数2399；SHA256 45a16307a724348917d8bd9f9eab47cd1a74ec54ba32b468a0e8ead670432696

```lean
import Mathlib
import MolecularDynamics.BasicDefinitions

/-!
# The N-body problem

Foundational definitions for Leimkuhler--Matthews, Chapter 1, Section 1.2,
equations (1.3) and (1.4). Here `n` is the total number `N_c` of configuration
coordinates, rather than the number of particles.
-/

namespace MolecularDynamics

/-- One mass for each of the `n = N_c` configuration coordinates.

For particles in three dimensions, the same particle mass occurs in each of its
three coordinate entries. Positivity is not included because it is not needed to
state equations (1.3) and (1.4). -/
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ

/-- The diagonal mass matrix `M` in equation (1.3). -/
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses

/-- Equation (1.3) at a position with a specified acceleration:
`M q̈ = F(q)` and `F(q) = -∇U(q)`.

Mathlib's `gradient` is a total operation, so this definition itself requires no
differentiability hypothesis. Such hypotheses must be stated on later theorems
that use differentiation rules. -/
def NBodyEquationAt {n : ℕ} (masses : CoordinateMasses n) (force : Force n)
    (potential : PotentialEnergy n) (position acceleration : Position n) : Prop :=
  (diagonalMassMatrix masses).mulVec acceleration = force position ∧
    force position = -gradient potential position

/-- The kinetic term in equation (1.4), expressed using the `N_c` scalar
configuration coordinates. -/
noncomputable def nBodyKineticEnergy {n : ℕ} (masses : CoordinateMasses n)
    (velocity : Velocity n) : ℝ :=
  ∑ i, masses i * (velocity i) ^ 2 / 2

/-- The kinetic energy in equation (1.4) is nonnegative when every coordinate
mass is nonnegative. -/
theorem nBodyKineticEnergy_nonneg {n : ℕ} (masses : CoordinateMasses n)
    (velocity : Velocity n) (hm : ∀ i, 0 ≤ masses i) :
    0 ≤ nBodyKineticEnergy masses velocity := by
  unfold nBodyKineticEnergy
  apply Finset.sum_nonneg
  intro i _
  exact div_nonneg (mul_nonneg (hm i) (sq_nonneg (velocity i))) (by norm_num)

/-- Equation (1.4): the total mechanical energy `E(q, q̇) = T(q̇) + U(q)`. -/
noncomputable def nBodyTotalEnergy {n : ℕ} (masses : CoordinateMasses n)
    (potential : PotentialEnergy n) (position : Position n) (velocity : Velocity n) : ℝ :=
  nBodyKineticEnergy masses velocity + potential position

end MolecularDynamics
```

文件：ParticleCoordinates.lean；字节数5845；SHA256 c390c5d56eb3e55f6d0dc463c52321d777997fb6ba568e52e15e30eb9efafc48

```lean
import MolecularDynamics.Chapter01.NBody

/-!
# Particle and coordinate representations

Leimkuhler--Matthews, Section 1.2, printed page 18 (PDF page 41).
For `N` particles in `d` spatial dimensions there are `N * d` configuration
coordinates. Independent constraints may reduce the degrees of freedom but
do not change this ambient coordinate indexing.

The coordinate equivalence lists all directions of each particle together;
in three dimensions each particle mass is repeated three times. The kinetic
energy identity holds for arbitrary real masses. Positive masses are explicit
hypotheses for the positive-definiteness and inverse-matrix results.
-/

namespace MolecularDynamics

/-- Scalar particle masses, before repeating them across spatial directions. -/
abbrev ParticleMasses (N : ℕ) := Fin N → ℝ
/-- A Euclidean vector for each particle; the outer function norm is not used. -/
abbrev ParticleVectors (N d : ℕ) := Fin N → EuclideanSpace ℝ (Fin d)

/-- Particle-first ordering: the coordinate of `(i, a)` is `a.val + d * i.val`. -/
def particleCoordinateEquiv (N d : ℕ) : Fin N × Fin d ≃ Fin (N * d) :=
  finProdFinEquiv

def coordinateMassesOfParticles {N d : ℕ} (m : ParticleMasses N) :
    CoordinateMasses (N * d) :=
  fun k => m ((particleCoordinateEquiv N d).symm k).1

def flattenParticleVectors {N d : ℕ} (v : ParticleVectors N d) : Velocity (N * d) :=
  WithLp.toLp 2 (fun k =>
    v ((particleCoordinateEquiv N d).symm k).1
      ((particleCoordinateEquiv N d).symm k).2)

def unflattenParticleVectors {N d : ℕ} (w : Velocity (N * d)) : ParticleVectors N d :=
  fun i => WithLp.toLp 2 (fun a => w (particleCoordinateEquiv N d (i, a)))

noncomputable def particleKineticEnergy {N d : ℕ}
    (m : ParticleMasses N) (v : ParticleVectors N d) : ℝ :=
  ∑ i, m i * ‖v i‖ ^ 2 / 2

@[simp] theorem flattenParticleVectors_apply {N d : ℕ} (v : ParticleVectors N d)
    (i : Fin N) (a : Fin d) :
    flattenParticleVectors v (particleCoordinateEquiv N d (i, a)) = v i a := by
  simp [flattenParticleVectors]

@[simp] theorem unflatten_flatten {N d : ℕ} (v : ParticleVectors N d) :
    unflattenParticleVectors (flattenParticleVectors v) = v := by
  funext i
  ext a
  simp [unflattenParticleVectors]

@[simp] theorem flatten_unflatten {N d : ℕ} (w : Velocity (N * d)) :
    flattenParticleVectors (unflattenParticleVectors w) = w := by
  ext k
  simp [flattenParticleVectors, unflattenParticleVectors]

@[simp] theorem coordinateMassesOfParticles_apply {N d : ℕ} (m : ParticleMasses N)
    (i : Fin N) (a : Fin d) :
    coordinateMassesOfParticles m (particleCoordinateEquiv N d (i, a)) = m i := by
  simp [coordinateMassesOfParticles]

theorem coordinateMassesOfParticles_pos {N d : ℕ} (m : ParticleMasses N)
    (hm : ∀ i, 0 < m i) : ∀ k, 0 < coordinateMassesOfParticles (d := d) m k := by
  intro k
  exact hm ((particleCoordinateEquiv N d).symm k).1

/-- Recovering each particle mass from its coordinates requires a direction. -/
theorem coordinateMassesOfParticles_pos_iff {N d : ℕ} (m : ParticleMasses N)
    (hd : 0 < d) :
    (∀ k, 0 < coordinateMassesOfParticles (d := d) m k) ↔ (∀ i, 0 < m i) := by
  constructor
  · intro h i
    simpa using h (particleCoordinateEquiv N d (i, (⟨0, hd⟩ : Fin d)))
  · exact coordinateMassesOfParticles_pos m

/-- The scalar-coordinate kinetic term equals the particle expression in (1.4).
No positivity hypothesis is needed for this algebraic identity. -/
theorem nBodyKineticEnergy_particle_eq {N d : ℕ}
    (m : ParticleMasses N) (v : ParticleVectors N d) :
    nBodyKineticEnergy (coordinateMassesOfParticles (d := d) m)
      (flattenParticleVectors v) = particleKineticEnergy m v := by
  unfold nBodyKineticEnergy
  rw [← (particleCoordinateEquiv N d).sum_comp]
  rw [Fintype.sum_prod_type]
  simp only [coordinateMassesOfParticles_apply, flattenParticleVectors_apply]
  unfold particleKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [EuclideanSpace.real_norm_sq_eq]
  rw [Finset.mul_sum, Finset.sum_div]

theorem diagonalMassMatrix_posDef_iff {n : ℕ} (m : CoordinateMasses n) :
    (diagonalMassMatrix m).PosDef ↔ ∀ i, 0 < m i := by
  exact Matrix.posDef_diagonal_iff

theorem diagonalMassMatrix_isUnit {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) : IsUnit (diagonalMassMatrix m) :=
  ((diagonalMassMatrix_posDef_iff m).2 hm).isUnit

theorem diagonalMassMatrix_mul_inv {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) :
    diagonalMassMatrix m * (diagonalMassMatrix m)⁻¹ = 1 := by
  exact Matrix.mul_nonsing_inv _ ((Matrix.isUnit_iff_isUnit_det _).1
    (diagonalMassMatrix_isUnit m hm))

theorem diagonalMassMatrix_inv_mul {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) :
    (diagonalMassMatrix m)⁻¹ * diagonalMassMatrix m = 1 := by
  exact Matrix.nonsing_inv_mul _ ((Matrix.isUnit_iff_isUnit_det _).1
    (diagonalMassMatrix_isUnit m hm))

/-- Strictly positive diagonal masses have the coordinatewise reciprocal inverse.
The singular-matrix inverse convention does not justify this without hypotheses. -/
theorem diagonalMassMatrix_inv_eq {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) :
    (diagonalMassMatrix m)⁻¹ = Matrix.diagonal (fun i => (m i)⁻¹) := by
  apply Matrix.inv_eq_left_inv
  change Matrix.diagonal (fun i => (m i)⁻¹) * Matrix.diagonal m = 1
  rw [Matrix.diagonal_mul_diagonal]
  ext i j
  by_cases hij : i = j
  · subst j
    simp [ne_of_gt (hm i)]
  · simp [Matrix.diagonal, hij]

theorem diagonalMassMatrix_inv_mulVec {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (w : Velocity n) (i : Fin n) :
    ((diagonalMassMatrix m)⁻¹).mulVec ((diagonalMassMatrix m).mulVec w) i = w i := by
  rw [Matrix.mulVec_mulVec, diagonalMassMatrix_inv_mul m hm, Matrix.one_mulVec]

end MolecularDynamics
```

文件：lean-toolchain；字节数25；SHA256 8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632

```text
leanprover/lean4:v4.34.0
```

文件：lakefile.toml；字节数458；SHA256 bdfb6a94cabc34eafe50274555e00374bd976139054b7cf3d69f139d79ff5197

```text
name = "MolecularDynamicsFormalization"
version = "0.1.0"
keywords = ["math"]
defaultTargets = ["MolecularDynamicsFormalization"]

[leanOptions]
pp.unicode.fun = true # pretty-prints `fun a ↦ b`

[[require]]
name = "mathlib"
scope = "leanprover-community"
rev = "v4.34.0"

[[lean_lib]]
name = "MolecularDynamicsFormalization"
roots = ["MolecularDynamicsFormalization", "MolecularDynamics"]
globs = ["MolecularDynamicsFormalization", "MolecularDynamics.+"]
```

文件：lake-manifest.json；字节数3164；SHA256 5156c987301057f3386cd99b43d5125e87b82bd245e712c60152cc4b5f357aba

```json
{"version": "1.2.0",
 "packagesDir": ".lake/packages",
 "packages":
 [{"url": "https://github.com/leanprover-community/mathlib4",
   "type": "git",
   "subDir": null,
   "scope": "leanprover-community",
   "rev": "5ed2965256430c3649e86755f9576b54eca72435",
   "name": "mathlib",
   "manifestFile": "lake-manifest.json",
   "inputRev": "v4.34.0",
   "inherited": false,
   "configFile": "lakefile.lean"},
  {"url": "https://github.com/leanprover-community/plausible",
   "type": "git",
   "subDir": null,
   "scope": "leanprover-community",
   "rev": "118aa17ee84656b8bd727fef7c458ee8c833385c",
   "name": "plausible",
   "manifestFile": "lake-manifest.json",
   "inputRev": "main",
   "inherited": true,
   "configFile": "lakefile.toml"},
  {"url": "https://github.com/leanprover-community/LeanSearchClient",
   "type": "git",
   "subDir": null,
   "scope": "leanprover-community",
   "rev": "ddf04cf3949fa556442341e87d47f9f6e6074707",
   "name": "LeanSearchClient",
   "manifestFile": "lake-manifest.json",
   "inputRev": "main",
   "inherited": true,
   "configFile": "lakefile.toml"},
  {"url": "https://github.com/leanprover-community/import-graph",
   "type": "git",
   "subDir": null,
   "scope": "leanprover-community",
   "rev": "e928b72544873815af278d38681b31c0293588e3",
   "name": "importGraph",
   "manifestFile": "lake-manifest.json",
   "inputRev": "main",
   "inherited": true,
   "configFile": "lakefile.toml"},
  {"url": "https://github.com/leanprover-community/ProofWidgets4",
   "type": "git",
   "subDir": null,
   "scope": "leanprover-community",
   "rev": "106ff4fafc74ef4ac99d81dbf3ab399118f497a5",
   "name": "proofwidgets",
   "manifestFile": "lake-manifest.json",
   "inputRev": "main",
   "inherited": true,
   "configFile": "lakefile.lean"},
  {"url": "https://github.com/leanprover-community/aesop",
   "type": "git",
   "subDir": null,
   "scope": "leanprover-community",
   "rev": "355695d523e41d0554926416cba2a2b3544fbbc9",
   "name": "aesop",
   "manifestFile": "lake-manifest.json",
   "inputRev": "master",
   "inherited": true,
   "configFile": "lakefile.toml"},
  {"url": "https://github.com/leanprover-community/quote4",
   "type": "git",
   "subDir": null,
   "scope": "leanprover-community",
   "rev": "6a489d9af5d0c47e5b259e2e8bcdfc1811b5a259",
   "name": "Qq",
   "manifestFile": "lake-manifest.json",
   "inputRev": "master",
   "inherited": true,
   "configFile": "lakefile.toml"},
  {"url": "https://github.com/leanprover-community/batteries",
   "type": "git",
   "subDir": null,
   "scope": "leanprover-community",
   "rev": "f2effa3d803fda822b1f97b806c47cf2adfbcbc2",
   "name": "batteries",
   "manifestFile": "lake-manifest.json",
   "inputRev": "main",
   "inherited": true,
   "configFile": "lakefile.toml"},
  {"url": "https://github.com/leanprover/lean4-cli",
   "type": "git",
   "subDir": null,
   "scope": "leanprover",
   "rev": "e92c9f15fdfacc8536f31cfb3b7ad26c3c8cd204",
   "name": "Cli",
   "manifestFile": "lake-manifest.json",
   "inputRev": "v4.34.0",
   "inherited": true,
   "configFile": "lakefile.toml"}],
 "name": "MolecularDynamicsFormalization",
 "lakeDir": ".lake",
 "fixedToolchain": false}
```
