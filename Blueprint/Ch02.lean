import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
import Mathlib.Tactic

open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review
open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator
noncomputable section
namespace MD.Ch02
variable {n Nc : ℕ}
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- source_id: MD-2-HamiltonianODE · definition · §2 · 印刷p.53 / PDFp.75
[EXTRA] 原文ODE按时间域I逐点解释；只定义关系，不宣称解存在。 -/
def hamiltonianODE {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t

/-- source_id: MD-2-Hamiltonian · definition · §2 · 印刷p.53 / PDFp.75
[EXTRA] 固定对角质量的机械模型来自第1章；一般非对角矩阵不纳入此复用接口。 -/
def mechanicalHamiltonian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n) :
    PhaseSpace n → ℝ := massHamiltonian m U

/-- source_id: MD-2-CanonicalJ · definition · §2 · 印刷p.53 / PDFp.75 -/
def canonicalJ (n : ℕ) : Matrix (Sum (Fin n) (Fin n)) (Sum (Fin n) (Fin n)) ℝ :=
  textbookJ n

/-- source_id: MD-2-Euler · definition · §2 · 印刷p.54 / PDFp.76 -/
def euler {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (h : ℝ) (z : E) : E := z + h • f z

/-- source_id: MD-2-OneStep · definition · §2 · 印刷p.54 / PDFp.76 -/
def numericalTrajectory {E : Type*} (G : ℝ → E → E) (h : ℝ) (ζ : E) (n : ℕ) : E :=
  (G h)^[n] ζ

/-- source_id: MD-2.1-Convergence · definition · §2.1 · 印刷p.55 / PDFp.77
[EXTRA] 按固定时间窗网格h=τ/ν表达任意精度；τ>0在具体定理中明示。 -/
def convergence {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  Tendsto (fun ν : ℕ => oneStepMaxError G (τ / ν) γ ν) atTop (𝓝 0)

/-- source_id: MD-2.1-Order · definition · §2.1 · 印刷p.55 / PDFp.77
[EXTRA] 自然数阶r；ν₀>0避免零除；K选择严格正不损失误差上界。 -/
def order {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (r : ℕ) : Prop :=
  ∃ K > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
    oneStepMaxError G (τ / ν) γ ν ≤ K * (τ / ν)^r

/-- source_id: MD-2.1-Error · definition · §2.1 · 印刷p.56 / PDFp.78 -/
def maximumError {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G : ℝ → E → E) (γ : ℝ → E) (h : ℝ) (ν : ℕ) : ℝ :=
  oneStepMaxError G h γ ν

/-- source_id: MD-2.1-Thm2.1 · Theorem 2.1 · §2.1 · 印刷p.56 / PDFp.78
[EXTRA] 时间长度τ≥0显式化；f以环境全函数表示，只在开放D上要求C¹。 -/
theorem theorem_2_1 {m : ℕ} (D : Set (Position m))
    (hDb : Bornology.IsBounded D) (hD : IsOpen D)
    (f : Position m → Position m) (hf : ContDiffOn ℝ 1 f D)
    (γ : ℝ → Position m) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t)
    (_hunique : ∀ η : ℝ → Position m, η 0 = γ 0 → MapsTo η (Icc 0 τ) D →
      (∀ t ∈ Icc 0 τ, HasDerivWithinAt η (f (η t)) (Icc 0 τ) t) →
      ∀ t ∈ Icc 0 τ, η t = γ t) :
    ∃ C : ℝ, 0 < C ∧ ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      (∀ n ≤ ν, eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D) ∧
        eulerMaxError f (τ / (ν : ℝ)) γ ν ≤ C * (τ / (ν : ℝ)) := by
  exact MolecularDynamics.theorem_2_1_euler D hDb hD f hf γ hτ hγD hγ

/-- source_id: MD-2.1.2-SecondDerivative · unnumbered_claim · §2.1.2 · 印刷p.59 / PDFp.81
[EXTRA] 解γ取C²；原文连续求两次时间导数的正则性显式化。 -/
theorem odeSecondDerivative :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n), ContDiff ℝ 1 f → ContDiff ℝ 2 γ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (deriv γ) ((fderiv ℝ f (γ t)) (f (γ t))) t := by
  intro n f γ hf hγ hode t
  have heq : deriv γ = fun s => f (γ s) := funext (fun s => (hode s).deriv)
  rw [heq]
  exact ((hf.differentiable (by norm_num)).differentiableAt.hasFDerivAt).comp_hasDerivAt t (hode t)

/-- source_id: MD-2.1.2-Taylor2 · Example 2.1 (map) · §2.1.2 · 印刷p.59 / PDFp.81 -/
def taylorSecond {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  z + h • f z + (h^2 / 2) • (fderiv ℝ f z) (f z)

/-- source_id: MD-2.1.2-Taylor2Order · Example 2.1 (order) · §2.1.2 · 印刷p.59 / PDFp.81
[EXTRA] compactTrajectory要求f全域C⁶及实际解在固定紧时间窗连续；强于二阶所需，标[EXTRA]，仍需证明局部误差及稳定留域。 -/
theorem taylor2Order :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → globalOrder (taylor2 f) γ τ 2 := by
  sorry

/-- source_id: MD-2.2-VerletOrder · unnumbered_claim · §2.2 · 印刷p.60 / PDFp.82
[EXTRA] 固定正对角质量、力全域C⁴、τ>0及实际解在闭时间窗连续；原文未逐一给出的阶定理正则性显式列出。 -/
theorem verletOrder :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) (γ : ℝ → Z n) τ,
    positiveMass m → ContDiff ℝ 4 F → 0 < τ →
    solution (mechanicalField m F) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
    ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError (verlet m F) (τ / ν) γ ν ≤ C * (τ / ν)^2 := by
  sorry

/-- source_id: MD-2.2.1-Lagrangian · definition · §2.2.1 · 印刷p.60 / PDFp.82 -/
def bp_mechanicalL {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (q v : Q n) : ℝ :=
  (∑ i, m i * v i ^ 2) / 2 - U q

/-- source_id: MD-2.2.1-Admissible · definition · §2.2.1 · 印刷p.60 / PDFp.82
[EXTRA] 全实线C∞延拓强于只在[α,β]光滑的局部资格。
[REGULARITY_AMBIGUITY] 原页先说twice continuously differentiable，后说C∞/smooth；按后一明确C∞登记，不能用旧CSV的C1转述。 -/
def admissibleSmooth {n : ℕ} (a b : ℝ) (x y : Q n) (q : ℝ → Q n) : Prop :=
  ContDiff ℝ ∞ q ∧ q a = x ∧ q b = y

/-- source_id: MD-2.2.1-Action · definition · §2.2.1 · 印刷p.60 / PDFp.82 -/
def bp_action {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : ℝ :=
  ∫ t in a..b, L (q t) (deriv q t)

/-- source_id: MD-2.2.1-Variation · definition · §2.2.1 · 印刷p.61 / PDFp.83 -/
def bp_variation {n : ℕ} (q η : ℝ → Q n) (ε : ℝ) (t : ℝ) : Q n := q t + ε • η t

/-- source_id: MD-2.2.1-FirstVariation · unnumbered_claim · §2.2.1 · 印刷p.61 / PDFp.83
[EXTRA] α<β；L、q、η C²以保证实际导数和紧时间窗余项资格。 -/
theorem firstVariation :
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    HasDerivAt (fun ε => action L a b (variation q η ε))
      (∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
        (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) 0 ∧
    Asymptotics.IsBigO (𝓝 0)
      (fun ε : ℝ => action L a b (variation q η ε)-action L a b q-
        ε*(∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
          (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)))
      (fun ε : ℝ => ε^2) := by
  sorry

/-- source_id: MD-2.2.1-TaylorPrinted · Footnote 3 · §2.2.1 · 印刷p.61 / PDFp.83
[ERRATUM?] 原脚注二阶及以后漏1/j!；f(x)=x²在0的k=2展开会给2x²，余项差为-x²而非O(x³)。 -/
theorem taylorPrinted : ∀ n (k : ℕ) (f : Q n → ℝ) z₀,
    1 ≤ k → ContDiff ℝ (k+1) f →
    Asymptotics.IsBigO (𝓝 0)
      (fun u => f (z₀+u)-f z₀-∑ j ∈ Finset.range k,
        iteratedFDeriv ℝ (j+1) f z₀ (fun _ => u))
      (fun u : Q n => ‖u‖^(k+1)) := by
  sorry

/-- source_id: MD-2.2.1-StationaryAction · definition · §2.2.1 · 印刷p.61–62 / PDFp.83–84
[EXTRA] 驻值以真实一阶变分导数为零定义；展开式相等由FirstVariation条目承担。 -/
def stationarySmoothAction {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : Prop :=
  ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
    HasDerivAt (fun ε => action L a b (variation q η ε)) 0 0

/-- source_id: MD-2.2.1-Parts · unnumbered_claim · §2.2.1 · 印刷p.62 / PDFp.84
[EXTRA] α<β；L及曲线C²；η端点为0。 -/
theorem firstVariationParts :
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    η a = 0 → η b = 0 →
    (∫ t in a..b, (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) =
      -(∫ t in a..b, (deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t)) := by
  sorry

/-- source_id: MD-2.2.1-EulerLagrange · unnumbered_claim · §2.2.1 · 印刷p.62 / PDFp.84
[EXTRA] α<β，L和q C²；变分按原文C∞且零端点。 -/
theorem hamiltonPrinciple :
  ∀ n (L : Q n → Q n → ℝ) (q : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q →
    (stationarySmoothAction L a b q ↔ ∀ t ∈ Ioo a b,
      HasDerivAt (fun s => fderiv ℝ (L (q s)) (deriv q s))
        (fderiv ℝ (fun x => L x (deriv q t)) (q t)) t) := by
  sorry

/-- source_id: MD-2.2.1-VariationalDerivativePrinted · definition · §2.2.1 · 印刷p.62 / PDFp.84
[ERRATUM?] 左式漏F(q)，原页实际如此。字面定义对于非零常值F无解，不能静默替成HasFDerivAt。 -/
def printedVariationalDerivative {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (q : E) (A : E →L[ℝ] ℝ) : Prop :=
  ∀ η : E, Asymptotics.IsBigO (𝓝 0)
    (fun ε : ℝ => F (q + ε • η) - ε * A η) (fun ε : ℝ => ε^2)

/-- source_id: MD-2.2.1-StationaryNotMin · Footnote 4 · §2.2.1 · 印刷p.62 / PDFp.84
[EXTRA] 用存在驻值但非局部极小的实际L与曲线反例表达could，不声称所有驻值不是极小。 -/
theorem stationaryNotMinimum :
  ∃ (L : Q 1 → Q 1 → ℝ) (q : ℝ → Q 1),
    ContDiff ℝ 2 (Function.uncurry L) ∧ ContDiff ℝ 2 q ∧ stationaryAction L 0 1 q ∧
    ∀ δ > 0, ∃ η : ℝ → Q 1, ContDiff ℝ 2 η ∧ η 0 = 0 ∧ η 1 = 0 ∧
      (∀ t ∈ Icc (0 : ℝ) 1, ‖η t‖ < δ) ∧ action L 0 1 (fun t => q t + η t) < action L 0 1 q := by
  sorry

/-- source_id: MD-2.2.2-DiscretePath · definition · §2.2.2 · 印刷p.63 / PDFp.85 -/
def finiteDiscretePath (n ν : ℕ) := Fin (ν+1) → Q n

/-- source_id: MD-2.2.2-DiscreteVelocity · definition · §2.2.2 · 印刷p.63 / PDFp.85 -/
def bp_discreteVelocity {n : ℕ} (q : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  h⁻¹ • (q (k+1) - q k)

/-- source_id: MD-2.2.2-DiscreteAction · definition · §2.2.2 · 印刷p.63 / PDFp.85
[ERRATUM?] 正文L写v上方点且+U，与p.60/PDF82和紧接展示离散作用量的-U冲突；定义只登记一般L离散求和，不把两种机械式同时认作正确。 -/
def bp_discreteAction {n : ℕ} (L : Q n → Q n → ℝ) (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : ℝ :=
  ∑ k ∈ Finset.range ν, h * L (q k) (discreteVelocity q h k)

/-- source_id: MD-2.2.2-DiscreteStationaryPrinted · definition · §2.2.2 · 印刷p.63–64 / PDFp.85–86
[ERRATUM?] 原页n=1,…,ν包含右端点，后页说端点固定且只对1,…,ν-1求导。保留字面≤ν，不默改为<ν。 -/
def printedDiscreteStationary {n : ℕ} (L : Q n → Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k ≤ ν →
    fderiv ℝ (fun x => discreteAction L (replaceNode q k x) h ν) (q k) = 0

/-- source_id: MD-2.2.2-DiscreteDerivative · unnumbered_claim · §2.2.2 · 印刷p.64 / PDFp.86
[EXTRA] 固定正对角质量、实际U可微、h≠0；仅内部节点0<k<ν；沿p.60及p.63展示的-U作用量。 -/
theorem discreteActionDerivative :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν k,
    positiveMass m → Differentiable ℝ U → h ≠ 0 → 0 < k → k < ν →
    ∀ v : Q n,
      (fderiv ℝ (fun x => discreteAction (mechanicalL m U) (replaceNode q k x) h ν) (q k)) v =
        ∑ i, (m i * (2*q k i-q (k-1) i-q (k+1) i)/h-h*grad U (q k) i) * v i := by
  sorry

/-- source_id: MD-2.2.2-DiscreteVerlet · unnumbered_claim · §2.2.2 · 印刷p.64 / PDFp.86
[EXTRA] 正对角质量、U可微、h≠0。 -/
theorem discreteStationaryVerlet :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν,
    positiveMass m → Differentiable ℝ U → h ≠ 0 →
    (discreteStationary (mechanicalL m U) q h ν ↔
      ∀ k, 0 < k → k < ν → stormerRelation m (fun x => -grad U x) h (q (k-1)) (q k) (q (k+1))) := by
  sorry

/-- source_id: MD-2.2.2-Stormer · definition · §2.2.2 · 印刷p.64 / PDFp.86 -/
def bp_stormerRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (a b c : Q n) : Prop :=
  c - (2 : ℝ) • b + a = h^2 • invMass m (F b)

/-- source_id: MD-2.2.2-VelocityVerlet · definition · §2.2.2 · 印刷p.64 / PDFp.86 -/
def bp_velocityVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vhalf := z.2 + (h/2) • invMass m (F z.1)
  let qnew := z.1 + h • vhalf
  (qnew, vhalf + (h/2) • invMass m (F qnew))

/-- source_id: MD-2.2.2-EliminateVelocity · unnumbered_claim · §2.2.2 · 印刷p.65 / PDFp.87 -/
theorem velocityVerletStormer :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h (a b c : Z n),
    b = velocityVerlet m F h a → c = velocityVerlet m F h b →
    stormerRelation m F h a.1 b.1 c.1 := by
  exact MolecularDynamics.Chapter02Review.velocityVerletStormer_proved

/-- source_id: MD-2.2.2-MomentumVerlet · definition · §2.2.2 · 印刷p.65 / PDFp.87 -/
def bp_verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))

/-- source_id: MD-2.2.2-Leapfrog · definition · §2.2.2 · 印刷p.65 / PDFp.87 -/
def bp_leapfrog {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vnew := z.2 + h • invMass m (F z.1)
  (z.1 + h • vnew, vnew)

/-- source_id: MD-2.2.2-LeapfrogInit · definition · §2.2.2 · 印刷p.65 / PDFp.87 -/
def bp_leapfrogInitialize {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 - (h/2) • invMass m (F z.1)

/-- source_id: MD-2.2.2-LeapfrogReconstruct · definition · §2.2.2 · 印刷p.65 / PDFp.87 -/
def bp_leapfrogReconstruct {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 + (h/2) • invMass m (F z.1)

/-- source_id: MD-2.2.3-ErrorDifference · unnumbered_claim · §2.2.3 · 印刷p.66 / PDFp.88 -/
theorem errorDifference :
  ∀ n (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) h k,
    γ ((k+1 : ℕ)*h) = F h (γ (k*h)) →
    oneStepIterate G h (γ 0) (k+1) - γ ((k+1 : ℕ)*h) =
      G h (oneStepIterate G h (γ 0) k) - F h (γ (k*h)) := by
  exact MolecularDynamics.Chapter02Review.errorDifference_proved

/-- source_id: MD-2.2.3-Consistency · definition · §2.2.3 · 印刷p.66–67 / PDFp.88–89 -/
def consistency {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  ∃ K ≥ 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t)-G h (γ t)‖ ≤ K*h^(p+1)

/-- source_id: MD-2.2.3-Stability · definition · §2.2.3 · 印刷p.66–67 / PDFp.88–89 -/
def stability {n : ℕ} (G : ℝ → Q n → Q n) (D : Set (Q n)) : Prop :=
  ∃ L ≥ 0, ∃ δ > 0, ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
    ‖G h u-G h w‖ ≤ (1+h*L)*‖u-w‖

/-- source_id: MD-2.2.3-ErrorRecursion · unnumbered_claim · §2.2.3 · 印刷p.67 / PDFp.89
[EXTRA] 精确流作用直接以γ后继节点表示；一般范数空间版本含有限维实例；实数p接口覆盖自然数正阶。 -/
theorem errorRecursion (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    (h L K p : ℝ) (ν : ℕ)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1))
    (n : ℕ) (hn : n < ν) :
    ‖oneStepIterate G h (γ 0) (n + 1) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤
      (1 + h * L) * ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ +
        K * h ^ (p + 1) := by
  apply MolecularDynamics.oneStep_error_recursion <;> assumption

/-- source_id: MD-2.2.3-ErrorBound · unnumbered_claim · §2.2.3 · 印刷p.67 / PDFp.89
[EXTRA] h>0、L>0及K≥0显式化；L=0时可增大为正L，除零界不能字面使用；假设精确与数值留域来自原文。 -/
theorem errorBound (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p := by
  apply MolecularDynamics.oneStep_error_bound <;> assumption

/-- source_id: MD-2.2.3-ConsistencyConvergence · unnumbered_claim · §2.2.3 · 印刷p.67 / PDFp.89
[EXTRA] τ,δ,L,p严格正，K≥0；D含精确及所有细网格数值解（原文明确简化前提）。 -/
theorem consistencyConvergence
    (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {τ δ L K p : ℝ} (hτ : 0 < τ) (hδ : 0 < δ) (hL : 0 < L)
    (hK : 0 ≤ K) (hp : 0 < p)
    (hexact : MapsTo γ (Icc 0 τ) D)
    (hnum : ∀ ν : ℕ, 0 < ν → τ / (ν : ℝ) ≤ δ →
      ∀ n ≤ ν, oneStepIterate G (τ / (ν : ℝ)) (γ 0) n ∈ D)
    (hstable : ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
      ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ h ∈ Ioo 0 δ, ∀ t ∈ Icc 0 τ, t + h ≤ τ →
      ‖G h (γ t) - γ (t + h)‖ ≤ K * h ^ (p + 1)) :
    Tendsto (fun ν : ℕ => oneStepMaxError G (τ / (ν : ℝ)) γ ν) atTop (𝓝 0) ∧
    ∀ᶠ ν : ℕ in atTop, oneStepMaxError G (τ / (ν : ℝ)) γ ν ≤
      ((K / L) * Real.exp (L * τ)) * (τ / (ν : ℝ)) ^ p := by
  constructor
  · exact MolecularDynamics.oneStep_converges_of_consistency_stability G γ D
      (τ := τ) (δ := δ) (L := L) (K := K) (p := p)
      hτ hδ hL hK hp hexact hnum hstable hconsistent
  · have hstep : Tendsto (fun ν : ℕ => τ / (ν : ℝ)) atTop (𝓝 0) :=
      tendsto_const_div_atTop_nhds_zero_nat τ
    have hbound : ∀ᶠ ν : ℕ in atTop,
        oneStepMaxError G (τ / (ν : ℝ)) γ ν ≤
          ((K / L) * Real.exp (L * τ)) * (τ / (ν : ℝ)) ^ p := by
      filter_upwards [eventually_gt_atTop (0 : ℕ), hstep.eventually_lt_const hδ]
        with ν hν hsmall
      have hνR : 0 < (ν : ℝ) := Nat.cast_pos.mpr hν
      have hh : 0 < τ / (ν : ℝ) := div_pos hτ hνR
      have hend : (ν : ℝ) * (τ / (ν : ℝ)) = τ := mul_div_cancel₀ _ hνR.ne'
      have htime : ∀ n ≤ ν, (n : ℝ) * (τ / (ν : ℝ)) ∈ Icc 0 τ := by
        intro n hn
        refine ⟨mul_nonneg (Nat.cast_nonneg n) hh.le, ?_⟩
        calc
          _ ≤ (ν : ℝ) * (τ / (ν : ℝ)) :=
            mul_le_mul_of_nonneg_right (Nat.cast_le.mpr hn) hh.le
          _ = τ := hend
      apply oneStepMaxError_order_bound G γ D ν hh hL hK hend.le
        (hnum ν hν hsmall.le) (fun n hn => hexact (htime n hn))
        (hstable _ ⟨hh, hsmall.le⟩)
      intro n hn
      have ht := htime n (Nat.le_of_lt hn)
      have hnext := (htime (n + 1) (Nat.succ_le_of_lt hn)).2
      simp only [Nat.cast_add, Nat.cast_one, add_mul, one_mul] at hnext ⊢
      exact hconsistent _ ⟨hh, hsmall⟩ _ ht hnext
    exact hbound

/-- source_id: MD-2.2.3-ScalarVerlet · Example 2.2 (map) · §2.2.3 · 印刷p.67 / PDFp.89 -/
def bp_scalarVerlet (F : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2+h^2/2*F z.1
  (q, z.2+h/2*(F z.1+F q))

/-- source_id: MD-2.2.3-VerletExpansion · unnumbered_claim · §2.2.3 · 印刷p.67–68 / PDFp.89–90
[EXTRA] F C³，使O(h⁴)余项有实际意义。 -/
theorem verletExpansion :
  ∀ (F : ℝ → ℝ) q p, ContDiff ℝ 3 F →
    Asymptotics.IsBigO (𝓝 0)
      (fun h => (scalarVerlet F h (q,p)).2 -
        (p+h*F q+h^2/2*p*deriv F q+h^3/4*(deriv F q*F q+p^2*deriv (deriv F) q)))
      (fun h : ℝ => h^4) := by
  sorry

/-- source_id: MD-2.2.3-ExactExpansion · unnumbered_claim · §2.2.3 · 印刷p.68 / PDFp.90
[EXTRA] F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。 -/
theorem exactExpansion :
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).1 -
      ((γ 0).1+h*(γ 0).2+h^2/2*F (γ 0).1+h^3/6*deriv F (γ 0).1*(γ 0).2)) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).2 -
      ((γ 0).2+h*F (γ 0).1+h^2/2*(γ 0).2*deriv F (γ 0).1+
        h^3/6*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))) (fun h : ℝ => h^4) := by
  sorry

/-- source_id: MD-2.2.3-DefectPrinted · unnumbered_claim · §2.2.3 · 印刷p.68 / PDFp.90
[EXTRA] 实际轨迹、F C³；t=0归一。
[ERRATUM?] 位置Q仅到h²，减精确q(t+h)应为负h³F′p/6；原页为正号，保留字面。 -/
theorem defectPrinted : ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1-
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))
      (fun h : ℝ => h^4) := by
  sorry

/-- source_id: MD-2.2.3-VerletConsistency · unnumbered_claim · §2.2.3 · 印刷p.68 / PDFp.90
[EXTRA] 实际标量M=1流、F C³、正时间窗和连续紧轨迹；O余项在h→0+解释；严格界C允许吸收余项，不宣称C=maxκ。
[NEGLECTED_REMAINDER] 原文忽略O(h⁴)后用maxκ界误差，不是严格界；保留κ主项和严格一致性，常数区分maxκ与吸收余项后的C。 -/
theorem verletConsistency : ∀ (F : ℝ → ℝ) (Φ : ℝ → (ℝ × ℝ) → (ℝ × ℝ))
    (γ : ℝ → ℝ × ℝ) τ δ,
    0 < τ → 0 < δ → ContDiff ℝ 3 F → ContinuousOn γ (Icc 0 τ) →
    (∀ z, Φ 0 z=z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun s => Φ s z) ((Φ t z).2,F (Φ t z).1) t) →
    (∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ, γ (t+h)=Φ h (γ t)) →
    ∃ κ : ℝ × ℝ → ℝ, ContinuousOn κ (Set.range γ) ∧
      (∀ z ∈ Set.range γ, 0 ≤ κ z ∧ Asymptotics.IsBigO (𝓝[>] 0)
        (fun h => ‖scalarVerlet F h z-Φ h z‖-κ z*h^3) (fun h : ℝ => h^4)) ∧
      (∃ K ≥ 0, (∀ t ∈ Icc 0 τ, κ (γ t) ≤ K) ∧
        (∃ t ∈ Icc 0 τ, κ (γ t)=K)) ∧
      (∃ C ≥ 0, ∃ δ₀ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ₀,
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3) := by
  sorry

/-- source_id: MD-2.2.3-VerletStability · unnumbered_claim · §2.2.3 · 印刷p.68–69 / PDFp.90–91
[EXTRA] 全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。 -/
theorem verletStability :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) L δ,
    positiveMass m → 0 ≤ L → 0 < δ →
    (∀ u w, ‖F u-F w‖ ≤ L*‖u-w‖) →
    ∃ C ≥ 0, ∀ h ∈ Icc 0 δ, ∀ z w : Z n,
      ‖verlet m F h z-verlet m F h w‖ ≤ (1+h*C)*‖z-w‖ := by
  sorry

/-- source_id: MD-2.2.4-FirstIntegral · definition · §2.2.4 · 印刷p.70 / PDFp.92 -/
def bp_firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0

/-- source_id: MD-2.2.4-IntegralPreserved · unnumbered_claim · §2.2.4 · 印刷p.70 / PDFp.92
[EXTRA] 开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。 -/
theorem firstIntegralPreserved :
  ∀ n (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) (γ : ℝ → Q n) a b,
    a ≤ b → DifferentiableOn ℝ I D → IsOpen D → firstIntegral I f D →
    MapsTo γ (Icc a b) D → solution f γ a b → ∀ t ∈ Icc a b, I (γ t) = I (γ a) := by
  intro n I f D γ a b hab hI hD hfirst hγD hγ
  have hd : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => I (γ s)) 0 (Icc a b) t := by
    intro t ht
    have hIt : DifferentiableAt ℝ I (γ t) :=
      (hI (γ t) (hγD ht)).differentiableAt (hD.mem_nhds (hγD ht))
    have hc : HasDerivWithinAt (fun s => I (γ s))
        ((fderiv ℝ I (γ t)) (f (γ t))) (Icc a b) t :=
      hIt.hasFDerivAt.comp_hasDerivWithinAt t (hγ t ht)
    rw [hfirst (γ t) (hγD ht)] at hc
    exact hc
  apply constant_of_has_deriv_right_zero (fun t ht => (hd t ht).continuousWithinAt)
  intro t ht
  exact (hd t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)

/-- source_id: MD-2.2.4-EnergyPreserved · unnumbered_claim · §2.2.4 · 印刷p.70 / PDFp.92
[EXTRA] 实际Hamilton轨迹，H在轨道点可微，闭时间窗；现有第3章库仅作已证依赖复用，不开展第3章任务。 -/
theorem energyPreserved (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  apply MolecularDynamics.textbookHamiltonian_energy_const_on_Icc <;> assumption

/-- source_id: MD-2.2.4-AngularMomentum · unnumbered_claim · §2.2.4 · 印刷p.71 / PDFp.93
[EXTRA] 中心力写ρ(x²+y²)(x,y)，单位约化质量、实际ODE轨迹，a<b；正质量模型可缩放。 -/
theorem centralAngularMomentum :
  ∀ (ρ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ × ℝ × ℝ) a b,
    a < b → (∀ t ∈ Icc a b, HasDerivWithinAt γ
      ((γ t).2.2.1,(γ t).2.2.2,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).1,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).2.1) (Icc a b) t) →
    ∀ t ∈ Icc a b, (γ t).1*(γ t).2.2.2-(γ t).2.1*(γ t).2.2.1 =
      (γ a).1*(γ a).2.2.2-(γ a).2.1*(γ a).2.2.1 := by
  sorry

/-- source_id: MD-2.2.4-IntegralMeanValue · unnumbered_claim · §2.2.4 · 印刷p.71 / PDFp.93
[EXTRA] 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。 -/
theorem integralMeanValue :
  ∀ n (I : EuclideanSpace ℝ (Fin n) → ℝ) (D : Set (EuclideanSpace ℝ (Fin n))) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b = (fderiv ℝ I c) (a-b) := by
  intro n I D a b hD hs hI
  have hd : ∀ x ∈ segment ℝ a b, HasFDerivWithinAt I (fderiv ℝ I x) (segment ℝ a b) x := by
    intro x hx
    exact ((hI.differentiableOn (by norm_num) x (hs hx)).differentiableAt (hD.mem_nhds (hs hx))).hasFDerivAt.hasFDerivWithinAt
  obtain ⟨c,hc,heq⟩ := domain_mvt hd (convex_segment a b)
    (right_mem_segment ℝ a b) (left_mem_segment ℝ a b)
  refine ⟨c, ?_, heq⟩
  rw [segment_symm] at hc
  exact hc

/-- source_id: MD-2.2.4-IntegralLipschitz · unnumbered_claim · §2.2.4 · 印刷p.71 / PDFp.93
[EXTRA] 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。 -/
theorem integralPointwiseBound : ∀ n (I : EuclideanSpace ℝ (Fin n) → ℝ) (D : Set (EuclideanSpace ℝ (Fin n))) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b=(fderiv ℝ I c) (a-b) ∧
      |I a-I b| ≤ ‖fderiv ℝ I c‖*‖a-b‖ := by
  intro n I D a b hD hs hI
  obtain ⟨c,hc,heq⟩ := integralMeanValue n I D a b hD hs hI
  refine ⟨c,hc,heq,?_⟩
  rw [heq, ← Real.norm_eq_abs]
  exact (fderiv ℝ I c).le_opNorm (a-b)

/-- source_id: MD-2.2.4-IntegralErrorPrinted · unnumbered_claim · §2.2.4 · 印刷p.71 / PDFp.93
[EXTRA] 域含连接线段，B,K≥0及L>0；用原文先前轨迹误差界，不把待证积分误差作前提。
[ERRATUM?] 由(2.12)及均值不等式只能得Kbar B/L，额外1/2未推导；常数Kbar若重命名需明确。 -/
theorem integralErrorPrinted :
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/(2*L))*Real.exp (L*k*h)*h^p := by
  sorry

end MD.Ch02
