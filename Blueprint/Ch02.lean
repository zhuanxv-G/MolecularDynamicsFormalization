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
    (∀ ε : ℝ, action L a b (variation q η ε)-action L a b q =
      ∫ t in a..b, L (q t+ε • η t) (deriv q t+ε • deriv η t)-L (q t) (deriv q t)) ∧
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
[EXTRA] α<β，实际L和q C²；η按原文C∞、零端点；真实作用量驻值。 -/
theorem firstVariationParts : ∀ n (L : Q n → Q n → ℝ)
    (q η : ℝ → Q n) a b, a < b → ContDiff ℝ 2 (Function.uncurry L) →
    ContDiff ℝ 2 q → ContDiff ℝ ∞ η → η a=0 → η b=0 →
    stationarySmoothAction L a b q →
    (∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t)+
      (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) =
    (∫ t in a..b, ((fderiv ℝ (fun x => L x (deriv q t)) (q t))-
      deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t)) ∧
    (∫ t in a..b, ((fderiv ℝ (fun x => L x (deriv q t)) (q t))-
      deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t))=0 := by
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

/-- source_id: MD-2.3.1-Divergence · definition · §2.3.1 · 印刷p.72 / PDFp.94 -/
def bp_divergence {n : ℕ} (f : Q n → Q n) (z : Q n) : ℝ := (textbookCoordinateJacobian f z).trace

/-- source_id: MD-2.3.1-Liouville · Liouville’s theorem · §2.3.1 · 印刷p.72 / PDFp.94
[EXTRA] [EXTRA]实际解族Φ联合C²（原文未重复此较强正则性）；f C¹、Φ0=id、τ>0及实际时间ODE；只对可测S表达Lebesgue体积。 -/
theorem liouville
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set ((Fin n) → ℝ)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  apply MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2 <;> assumption

/-- source_id: MD-2.3.1-HamiltonDivergence · unnumbered_claim · §2.3.1 · 印刷p.72 / PDFp.94
[EXTRA] H C²，保证混合偏导对称。 -/
theorem hamiltonDivergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0 := by
  apply MolecularDynamics.textbookHamiltonianVectorField_divergence_zero <;> assumption

/-- source_id: MD-2.3.1-HamiltonVolume · unnumbered_claim · §2.3.1 · 印刷p.72 / PDFp.94
[EXTRA] [EXTRA]Φ联合C²；H C²、Φ0=id，τ>0；可测集S。 -/
theorem hamiltonVolume {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (SymplecticCoordinates Nc)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  apply MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 <;> assumption

/-- source_id: MD-2.3.1-VolumeChange · unnumbered_claim · §2.3.1 · 印刷p.73 / PDFp.95
[EXTRA] Φ C¹单射，可测S；正则流的固定时刻映射具备这些资格；真实Lebesgue体积和lintegral。 -/
theorem volumeChange :
  ∀ n (Φ : Q n → Q n) (S : Set (Q n)), ContDiff ℝ 1 Φ → Function.Injective Φ → MeasurableSet S →
    volume (Φ '' S) = ∫⁻ z in S, ENNReal.ofReal |(textbookCoordinateJacobian Φ z).det| ∂volume := by
  intro n Φ S hΦ hinj hS
  have hd : ∀ z ∈ S, HasFDerivWithinAt Φ (fderiv ℝ Φ z) S z := by
    intro z hz
    exact (hΦ.differentiable_one z).hasFDerivAt.hasFDerivWithinAt
  have hcv := lintegral_abs_det_fderiv_eq_addHaar_image
    (volume : Measure (Q n)) hS hd hinj.injOn
  have heq : ∀ z, (fderiv ℝ Φ z).det=(textbookCoordinateJacobian Φ z).det := by
    intro z
    change LinearMap.det (fderiv ℝ Φ z).toLinearMap=_
    rw [← LinearMap.det_toMatrix']
    rfl
  simpa only [heq] using hcv.symm

/-- source_id: MD-2.3.1-VariationalPrinted · unnumbered_claim · §2.3.1 · 印刷p.73 / PDFp.95
[ERRATUM?] 原文W在z(t)取Jacobian，而变分矩阵应在固定初值ζ取Jacobian；沿移动取值点会多一链式项。后式还需要W可逆，局部流可给但不能忽略域。 -/
theorem variationalPrinted : ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ ζ,
    flowC1 f Φ τ → ∀ t ∈ Ioo 0 τ,
    HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookCoordinateJacobian f (Φ (t,ζ)) *
        textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t ∧
    (deriv (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ))) t) *
      (textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ)))⁻¹ =
      textbookCoordinateJacobian f (Φ (t,ζ)) := by
  sorry

/-- source_id: MD-2.3.1-DeterminantODE · unnumbered_claim · §2.3.1 · 印刷p.73 / PDFp.95
[EXTRA] 实际W′=AW且detW≠0，符合原文W⁻¹及D除法的资格；A=f′(z(t))。 -/
theorem determinantODE : ∀ n (A W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    HasDerivAt W (A t * W t) t → (W t).det ≠ 0 →
    HasDerivAt (fun s => (W s).det) ((A t).trace*(W t).det) t ∧
      deriv (fun s => (W s).det) t/(W t).det =
        Matrix.trace ((A t*W t)*(W t)⁻¹) := by
  intro n A W t hW hdet
  have hd := MolecularDynamics.textbookMatrixDet_hasDerivAt_of_linearODE W (A t) t hW
  refine ⟨hd,?_⟩
  rw [hd.deriv, mul_div_cancel_right₀ _ hdet, Matrix.mul_assoc,
    Matrix.mul_nonsing_inv _ (isUnit_iff_ne_zero.mpr hdet), Matrix.mul_one]

/-- source_id: MD-2.3.1-DeterminantExponential · unnumbered_claim · §2.3.1 · 印刷p.73 / PDFp.95
[EXTRA] 实际W′=AW，A连续；tr A=div f(z(s))，全实线ODE资格用于任意t积分。 -/
theorem determinantExponential :
  ∀ n (A : ℝ → Matrix (Fin n) (Fin n) ℝ) (W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    Continuous A → (∀ s, HasDerivAt W (A s * W s) s) →
    (W t).det = (W 0).det * Real.exp (∫ s in (0 : ℝ)..t, (A s).trace) := by
  sorry

/-- source_id: MD-2.3.1-FlowDet · unnumbered_claim · §2.3.1 · 印刷p.73 / PDFp.95
[EXTRA] [EXTRA]Φ联合C²、f C¹、Φ0=id，τ>0及实际ODE；D0=1由Jacobian初值而非结论假设。 -/
theorem flowDet
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, ∀ z, (textbookCoordinateJacobian (fun y => Φ (t, y)) z).det = 1 := by
  apply MolecularDynamics.textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2 <;> assumption

/-- source_id: MD-2.3.1-LJOscillator · Example 2.3 (model) · §2.3.1 · 印刷p.73–74 / PDFp.95–96 -/
def ljOscillatorEquation (φ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ ((γ t).2,-deriv φ (γ t).1) t

/-- source_id: MD-2.3.1-LJBoundedPeriodic · unnumbered_claim · §2.3.1 · 印刷p.74 / PDFp.96
[EXTRA] LJ参数正，实际全时轨迹且位置q>0；平衡解也允许任意正周期。 -/
theorem ljBoundedPeriodic : ∀ (σ ε : ℝ) (γ : ℝ → ℝ × ℝ),
    0 < σ → 0 < ε →
    ljOscillatorEquation (fun q => 4*ε*((σ/q)^12-(σ/q)^6)) γ Set.univ →
    (∀ t, 0 < (γ t).1) → Bornology.IsBounded (Set.range γ) →
    ∃ T > 0, ∀ t, γ (t+T) = γ t := by
  sorry

/-- source_id: MD-2.3.2-LinearDivergence · unnumbered_claim · §2.3.2 · 印刷p.74–75 / PDFp.96–97
[EXTRA] [EXTRA]实际全时C²解族Φ，Φ0=id并满足真实线性ODE；只量化可测T。 -/
theorem linearDivergence : ∀ n (S : Matrix (Fin n) (Fin n) ℝ)
    (Φ : ℝ × Q n → Q n), ContDiff ℝ 2 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t z, HasDerivAt (fun s => Φ (s,z)) (S.mulVec (Φ (t,z))) t) →
    (∀ z, divergence S.mulVec z=S.trace) ∧
    ((∀ t, ∀ T : Set (Q n), MeasurableSet T →
      volume ((fun z => Φ (t,z)) '' T)=volume T) ↔ S.trace=0) := by
  sorry

/-- source_id: MD-2.3.2-LinearEuler · definition · §2.3.2 · 印刷p.75 / PDFp.97 -/
def bp_linearEuler {n : ℕ} (S : Matrix (Fin n) (Fin n) ℝ) (h : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  1 + h • S

/-- source_id: MD-2.3.2-EulerVolumePrinted · unnumbered_claim · §2.3.2 · 印刷p.75 / PDFp.97
[ERRATUM?] 体积只要求|det|=1；原文省略正向/足够小步长条件。反射在大步长可保持体积但det=-1。 -/
theorem eulerVolumePrinted : ∀ n (S : Matrix (Fin n) (Fin n) ℝ) h,
    (∀ T : Set (Q n), MeasurableSet T →
      volume ((linearEuler S h).mulVec '' T)=volume T) ↔ (linearEuler S h).det=1 := by
  sorry

/-- source_id: MD-2.3.2-EulerVolumeCounterexample · unnumbered_claim · §2.3.2 · 印刷p.75 / PDFp.97 -/
theorem eulerVolumeCounterexample :
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → (linearEuler S h).det ≠ 1 := by
  exact MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_proved

/-- source_id: MD-2.3.2-AsymmetricEuler · definition · §2.3.2 · 印刷p.75 / PDFp.97 -/
def bp_asymmetricEulerRelation (f g : ℝ → ℝ → ℝ) (h u v U V : ℝ) : Prop :=
  U = u + h*f U v ∧ V = v + h*g U v

/-- source_id: MD-2.3.2-AsymmetricJacobian · unnumbered_claim · §2.3.2 · 印刷p.75 / PDFp.97
[EXTRA] f,g及实际隐式解映射Ψ C¹；分母1-hfu≠0；偏导在(U,v)取值。 -/
theorem asymmetricDet :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    ∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0 →
      (textbookCoordinateJacobian Ψ z) =
        !![(1/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) : ℝ),
          h*deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0));
          h*deriv (fun u => g u (z 1)) (Ψ z 0)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)),
          1+h*deriv (g (Ψ z 0)) (z 1)+h^2*deriv (fun u => g u (z 1)) (Ψ z 0)*
            deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0))] ∧
      (textbookCoordinateJacobian Ψ z).det =
        (1+h*deriv (g (Ψ z 0)) (z 1))/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) := by
  sorry

/-- source_id: MD-2.3.2-AsymmetricArea · unnumbered_claim · §2.3.2 · 印刷p.75–76 / PDFp.97–98
[EXTRA] f,g及实际解映射Ψ C¹，分母处处非零；行列式1给局部面积保存，整集需单射域。
[EXTRA] [EXTRA]Ψ实际单射，保证整集面积换元；Jacobian1本身仅给局部面积。 -/
theorem asymmetricArea :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    (∀ u v, deriv (fun x => f x v) u + deriv (g u) v = 0) →
    (∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0) →
    Function.Injective Ψ →
    (∀ z, (textbookCoordinateJacobian Ψ z).det = 1) ∧
    (∀ T : Set (Q 2), MeasurableSet T → volume (Ψ '' T)=volume T) := by
  sorry

/-- source_id: MD-2.3.3-SymplecticMap · definition · §2.3.3 · 印刷p.76 / PDFp.98 -/
def bp_IsSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)

/-- source_id: MD-2.3.3-OneForm · definition · §2.3.3 · 印刷p.76 / PDFp.98 -/
def oneFormFamily (n : ℕ) := Q n → Q n →L[ℝ] ℝ

/-- source_id: MD-2.3.3-Differential · definition · §2.3.3 · 印刷p.76 / PDFp.98 -/
def bp_differential {n : ℕ} (g : Q n → ℝ) : oneForm n := fderiv ℝ g

/-- source_id: MD-2.3.3-CoordinateDifferentials · definition · §2.3.3 · 印刷p.76 / PDFp.98 -/
def coordinateDifferentials (n : ℕ) :
    (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) × (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) :=
  (textbookDq,textbookDp)

/-- source_id: MD-2.3.3-Wedge · definition · §2.3.3 · 印刷p.76 / PDFp.98 -/
def bp_wedge {Nc : ℕ} (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) α β -
    LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) β α

@[simp] theorem textbookWedgeOneForms_apply {Nc : ℕ}
    (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) (u v : SymplecticCoordinates Nc) :
    textbookWedgeOneForms α β u v = α u * β v - α v * β u := by
  change α u * β v - β u * α v = _
  ring

/-- source_id: MD-2.3.3-SymplecticForm · definition · §2.3.3 · 印刷p.77 / PDFp.99 -/
noncomputable def bp_symplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'

/-- source_id: MD-2.3.3-FormSumWedges · unnumbered_claim · §2.3.3 · 印刷p.77 / PDFp.99 -/
theorem formSumWedges (Nc : ℕ) :
    textbookSymplecticForm Nc =
      ∑ i : Fin Nc, textbookWedgeOneForms (textbookDq i) (textbookDp i) := by
  apply MolecularDynamics.textbookSymplecticForm_eq_sum_wedges <;> assumption

/-- source_id: MD-2.3.3-GeneralTwoForm · definition · §2.3.3 · 印刷p.77 / PDFp.99
[ERRATUM?] 双和系数A的实际双线性矩阵是A-Aᵀ；若A反对称为2A。后文直接用A作矩阵表示存在因子约定疑点。 -/
def coefficientTwoForm {n : ℕ} (A : Q n → Matrix (Fin n) (Fin n) ℝ)
    (z u v : Q n) : ℝ :=
  ∑ i, ∑ j, A z i j * (u i*v j-v i*u j)

/-- source_id: MD-2.3.3-PullbackOne · definition · §2.3.3 · 印刷p.77 / PDFp.99 -/
def bp_pullbackOne {n : ℕ} (Φ : Q n → Q n) (α : oneForm n) : oneForm n :=
  fun z => (α (Φ z)).comp (fderiv ℝ Φ z)

/-- source_id: MD-2.3.3-PullbackTwo · definition · §2.3.3 · 印刷p.77 / PDFp.99 -/
def bp_pullbackTwo {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) (z u v : Q n) : ℝ :=
  A.val (Φ z) ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v)

/-- source_id: MD-2.3.3-PullbackMatrix · unnumbered_claim · §2.3.3 · 印刷p.77–78 / PDFp.99–100 -/
theorem pullbackMatrix :
  ∀ n (Φ : Q n → Q n) (A : Q n → Matrix (Fin n) (Fin n) ℝ) z u v,
    dotProduct ((fderiv ℝ Φ z) u) ((A (Φ z)).mulVec ((fderiv ℝ Φ z) v)) =
      dotProduct u (((textbookCoordinateJacobian Φ z).transpose * A (Φ z) *
        textbookCoordinateJacobian Φ z).mulVec v) := by
  intro n Φ A z u v
  rw [← textbookCoordinateJacobian_mulVec Φ z u,
    ← textbookCoordinateJacobian_mulVec Φ z v]
  rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec,
    Matrix.dotProduct_transpose_mulVec]
  exact dotProduct_comm _ _

/-- source_id: MD-2.3.3-PreservesForm · definition · §2.3.3 · 印刷p.78 / PDFp.100
[ERRATUM?] 一般位置相关A的守恒式应DΦ(z)ᵀA(Φ(z))DΦ(z)=A(z)；原文省略底点，若只针对常矩阵才无歧义。 -/
def bp_preservesTwoForm {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) : Prop :=
  ∀ z u v, pullbackTwo Φ A z u v = A.val z u v

/-- source_id: MD-2.3.3-SymplecticIffForm · unnumbered_claim · §2.3.3 · 印刷p.78 / PDFp.100 -/
theorem symplecticIffForm {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    IsTextbookSymplecticMap Φ ↔ ContDiff ℝ 1 Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  apply MolecularDynamics.isTextbookSymplecticMap_iff_preserves_form <;> assumption

/-- source_id: MD-2.3.3-SymplecticDet · unnumbered_claim · §2.3.3 · 印刷p.78 / PDFp.100 -/
theorem symplecticDet {n : ℕ} (A : SymplecticCoordinateMatrix n) (hA : IsTextbookSymplectic A) :
    A.det^2=1 ∧ |A.det|=1 := by
  exact ⟨hA.det_square,hA.abs_det⟩

/-- source_id: MD-2.3.3-HamiltonDet · unnumbered_claim · §2.3.3 · 印刷p.78 / PDFp.100
[EXTRA] [EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。 -/
theorem hamiltonDet {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (hH : ContDiff ℝ 2 H) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t)
    (hinit : (fun z => Φ (0,z))=id) :
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t,y)) z).det=1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (SymplecticCoordinates n), MeasurableSet S →
      volume ((fun z => Φ (t,z)) '' S)=volume S) := by
  constructor
  · exact MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2 H hH Φ hΦ τ hODE hinit
  · exact MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 H hH Φ hΦ τ hODE hinit

/-- source_id: MD-2.3.4-Hessian · definition · §2.3.4 · 印刷p.79 / PDFp.101 -/
noncomputable def bp_hessian {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc := fun i j =>
  fderiv ℝ (fderiv ℝ H) z (Pi.single i 1) (Pi.single j 1)

/-- source_id: MD-2.3.4-HessianSymmetry · unnumbered_claim · §2.3.4 · 印刷p.79 / PDFp.101
[EXTRA] H在所取点C²，混合偏导相等。 -/
theorem hessianSymmetry {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) : (textbookHamiltonianHessian H z).IsSymm := by
  apply MolecularDynamics.textbookHamiltonianHessian_isSymm <;> assumption

/-- source_id: MD-2.3.4-HamiltonVariationalPrinted · unnumbered_claim · §2.3.4 · 印刷p.79 / PDFp.101
[ERRATUM?] 与p.73一样W应在固定初值ζ求导；原页后文明确W(t)=F′t(z(t,ζ))，本条保留该字面W。 -/
theorem hamiltonVariationalPrinted : ∀ n (H : SymplecticCoordinates n → ℝ)
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ ζ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, HasDerivAt
      (fun s => textbookJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,ζ)) *
        textbookJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t := by
  sorry

/-- source_id: MD-2.3.4-MatrixCancellation · unnumbered_claim · §2.3.4 · 印刷p.79 / PDFp.101
[EXTRA] S对称；任意矩阵W。 -/
theorem matrixCancellation {Nc : ℕ}
    (S W : SymplecticCoordinateMatrix Nc) (hS : S.IsSymm) :
    (textbookJ Nc * S * W)ᵀ * textbookJ Nc * W +
      Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) = 0 := by
  apply MolecularDynamics.hamiltonian_variational_matrix_cancellation <;> assumption

/-- source_id: MD-2.3.4-FormConstant · unnumbered_claim · §2.3.4 · 印刷p.79 / PDFp.101
[EXTRA] S(t)逐点对称，W实际满足W′=JSW，闭连通时间窗；这一独立矩阵ODE陈述不把流的变分方程结论作流辛性前提。 -/
theorem formConstant {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (τ : ℝ)
    (hS : ∀ t ∈ Icc 0 τ, (S t).IsSymm)
    (hW : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt W (textbookJ Nc * S t * W t) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, (W t)ᵀ * textbookJ Nc * W t = (W 0)ᵀ * textbookJ Nc * W 0 := by
  apply MolecularDynamics.hamiltonian_variational_form_constant <;> assumption

/-- source_id: MD-2.3.4-HamiltonSymplectic · unnumbered_claim · §2.3.4 · 印刷p.79 / PDFp.101
[EXTRA] [EXTRA]实际解族联合C²；H C²、Φ0=id、τ>0及真实Hamilton ODE。 -/
theorem hamiltonSymplectic {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t, z)) := by
  apply MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 <;> assumption

/-- source_id: MD-2.3.5-ChainRule · unnumbered_claim · §2.3.5 · 印刷p.79 / PDFp.101
[EXTRA] 两个实际映射在相应点可微；外导数在Φ₂(z)取值，原文简写省略底点。
[OMITTED_EVALUATION_POINT] 原文Φ₁′Φ₂′未写外导数的Φ₂(z)取值点；Lean用正确链式法则，需审校确认简写约定。 -/
theorem chainRule {Nc : ℕ}
    (Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : Differentiable ℝ Φ) (hΨ : Differentiable ℝ Ψ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (Φ ∘ Ψ) z = textbookJacobian Φ (Ψ z) * textbookJacobian Ψ z := by
  apply MolecularDynamics.textbookJacobian_comp <;> assumption

/-- source_id: MD-2.3.5-SymplecticComposition · unnumbered_claim · §2.3.5 · 印刷p.79 / PDFp.101 -/
theorem symplecticComposition {Nc : ℕ}
    {Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc}
    (hΦ : IsTextbookSymplecticMap Φ) (hΨ : IsTextbookSymplecticMap Ψ) :
    IsTextbookSymplecticMap (Φ ∘ Ψ) := by
  apply MolecularDynamics.IsTextbookSymplecticMap.comp <;> assumption

/-- source_id: MD-2.3.5-SymplecticInverse · unnumbered_claim · §2.3.5 · 印刷p.79 / PDFp.101
[EXTRA] [EXTRA]e为确实全局双射且e和e⁻¹可微的辛微分同胚；原文前句从det非零推出全球逆无效，另项字面保留。 -/
theorem symplecticInverse {Nc : ℕ}
    {e : Equiv.Perm (SymplecticCoordinates Nc)} (he : IsTextbookSymplecticEquiv e) :
    IsTextbookSymplecticEquiv e.symm := by
  apply MolecularDynamics.IsTextbookSymplecticEquiv.symm <;> assumption

/-- source_id: MD-2.3.5-GlobalGroupPrinted · unnumbered_claim · §2.3.5 · 印刷p.79 / PDFp.101
[ERRATUM?] Jacobian可逆仅推出局部可逆，不能推出任意辛映射全球双射；正确群是给定全球辛微分同胚。 -/
theorem globalGroupPrinted : ∀ n (Φ : SymplecticCoordinates n → SymplecticCoordinates n),
    IsTextbookSymplecticMap Φ → Function.Bijective Φ ∧
      IsTextbookSymplecticMap (Function.invFun Φ) := by
  sorry

/-- source_id: MD-2.3.6-SymplecticIntegrator · definition · §2.3.6 · 印刷p.80 / PDFp.102 -/
def bp_symplecticIntegrator {n : ℕ} (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∀ h, IsTextbookSymplecticMap (G h)

/-- source_id: MD-2.3.6-SymplecticEuler · definition · §2.3.6 · 印刷p.80 / PDFp.102 -/
noncomputable def bp_symplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h

/-- source_id: MD-2.3.6-KickDifferential · unnumbered_claim · §2.3.6 · 印刷p.81 / PDFp.103
[EXTRA] U C²，实际Hessian。 -/
theorem kickDifferential : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    ContDiff ℝ 2 U → ∀ ξ : SymplecticCoordinates n, ∀ i : Fin n,
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inl i) =
        ξ (Sum.inl i)+h*(m i)⁻¹*((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) ∧
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) =
        ξ (Sum.inr i)-h*((fderiv ℝ (grad U) (z ∘ Sum.inl)) (ξ ∘ Sum.inl)) i := by
  sorry

/-- source_id: MD-2.3.6-WedgeSelf · unnumbered_claim · §2.3.6 · 印刷p.81 / PDFp.103 -/
theorem wedgeSelf :
  ∀ n (α : SymplecticCoordinates n →ₗ[ℝ] ℝ) u v, textbookWedgeOneForms α α u v = 0 := by
  exact MolecularDynamics.Chapter02Review.wedgeSelf_proved

/-- source_id: MD-2.3.6-SymplecticEulerPreserves · unnumbered_claim · §2.3.6 · 印刷p.81 / PDFp.103
[EXTRA] U C²，固定对角质量；真实完整步映射。 -/
theorem symplecticEulerPreserves {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticMap (textbookSymplecticEuler m U h) := by
  apply MolecularDynamics.textbookSymplecticEuler_isSymplectic <;> assumption

/-- source_id: MD-2.3.7-Adjoint · definition · §2.3.7 · 印刷p.81 / PDFp.103
[EXTRA] [EXTRA]方法G每个可用h为实际Equiv.Perm；只在负步可逆时定义伴随，不能宣称任意步映射天然可逆。 -/
noncomputable def bp_adjoint {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm

/-- source_id: MD-2.3.7-FlowSelfAdjoint · unnumbered_claim · §2.3.7 · 印刷p.82 / PDFp.104
[EXTRA] [EXTRA]给定全球Flow群；原文局部流若无全球存在，须在正负步都可用域解释，未宣称所有ODE有全球流。 -/
theorem flowSelfAdjoint {E : Type*} [TopologicalSpace E]
    (F : Flow ℝ E) : textbookAdjointMethod (textbookFlowMethod F) = textbookFlowMethod F := by
  apply MolecularDynamics.textbookFlowMethod_isSelfAdjoint <;> assumption

/-- source_id: MD-2.3.7-BackwardEuler · definition · §2.3.7 · 印刷p.82 / PDFp.104 -/
def bp_backwardEulerRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w = z + h • f w

/-- source_id: MD-2.3.7-EulerAdjoint · unnumbered_claim · §2.3.7 · 印刷p.82 / PDFp.104
[EXTRA] [EXTRA]给定负步Euler实际双射；G(-h)与Euler映射逐点一致，不假设所有f/h可逆。 -/
theorem eulerAdjoint (f : E → E) (G : ℝ → Equiv.Perm E)
    (h : ℝ) (hG : ∀ Z, G (-h) Z = eulerStep f (-h) Z) (z Z : E) :
    textbookAdjointMethod G h z = Z ↔ Z = z + h • f Z := by
  apply MolecularDynamics.euler_adjoint_iff_backward <;> assumption

/-- source_id: MD-2.3.7-AdjointSymplecticEuler · definition · §2.3.7 · 印刷p.82 / PDFp.104 -/
noncomputable def bp_adjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h

/-- source_id: MD-2.3.7-AdjointInvolution · unnumbered_claim · §2.3.7 · 印刷p.82 / PDFp.104
[EXTRA] 实际可逆步方法族Equiv.Perm；负步及双逆确实存在。 -/
theorem adjointInvolution {E : Type*} (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookAdjointMethod G) = G := by
  apply MolecularDynamics.textbookAdjointMethod_involutive <;> assumption

/-- source_id: MD-2.4.1-Splitting · definition · §2.4.1 · 印刷p.83 / PDFp.105 -/
def bp_splittingMap {E : Type*} (F₁ F₂ : ℝ → E → E) (h : ℝ) : E → E := F₁ h ∘ F₂ h

/-- source_id: MD-2.4.1-FieldAdd · unnumbered_claim · §2.4.1 · 印刷p.83 / PDFp.105
[EXTRA] H₁,H₂在实际点可微，实际Fréchet梯度。 -/
theorem fieldAdd {Nc : ℕ}
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (h₁ : DifferentiableAt ℝ H₁ z) (h₂ : DifferentiableAt ℝ H₂ z) :
    textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) z =
      textbookHamiltonianVectorField H₁ z + textbookHamiltonianVectorField H₂ z := by
  apply MolecularDynamics.textbookHamiltonianVectorField_add <;> assumption

/-- source_id: MD-2.4.1-SplittingLocal · unnumbered_claim · §2.4.1 · 印刷p.83 / PDFp.105
[EXTRA] 实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。 -/
theorem splittingLocal {Nc : ℕ}
    (D : Set (SymplecticCoordinates Nc)) (hD : IsOpen D)
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (hH₁ : ContDiffOn ℝ 2 H₁ D) (hH₂ : ContDiffOn ℝ 2 H₂ D)
    (F F₁ F₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (u : SymplecticCoordinates Nc) {τ : ℝ} (hτ : 0 ≤ τ)
    (hFD : ∀ t ∈ Icc 0 τ, F t u ∈ D)
    (hF₂D : ∀ t ∈ Icc 0 τ, F₂ t u ∈ D)
    (hF₁D : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, F₁ t (F₂ s u) ∈ D)
    (hF : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) (F t u)) (Icc 0 τ) t)
    (hF₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F₂ v u)
      (textbookHamiltonianVectorField H₂ (F₂ t u)) (Icc 0 τ) t)
    (hF₁ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, HasDerivWithinAt
      (fun v => F₁ v (F₂ s u)) (textbookHamiltonianVectorField H₁ (F₁ t (F₂ s u))) (Icc 0 τ) t)
    (hc : ContinuousOn (fun p : ℝ × ℝ => F₁ p.2 (F₂ p.1 u)) (Icc 0 τ ×ˢ Icc 0 τ))
    (hinit : F 0 u = u) (hinit₂ : F₂ 0 u = u)
    (hinit₁ : ∀ s ∈ Icc 0 τ, F₁ 0 (F₂ s u) = F₂ s u) :
    ∃ C : ℝ, 0 < C ∧
      (∀ h ∈ Icc 0 τ, ‖F₁ h (F₂ h u) - F h u‖ ≤ C * h ^ 2) ∧
      (0 < τ → Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
        (fun h => F₁ h (F₂ h u) - F h u) (fun h : ℝ => h ^ 2)) := by
  exact MolecularDynamics.exists_hamiltonian_splitting_localError_bound
    D hD H₁ H₂ hH₁ hH₂ F F₁ F₂ u hτ hFD hF₂D hF₁D hF hF₂ hF₁ hc hinit hinit₂ hinit₁

/-- source_id: MD-2.4.1-KineticFlow · Example 2.4 (kinetic) · §2.4.1 · 印刷p.83–84 / PDFp.105–106 -/
noncomputable def bp_kineticFlow {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))

private noncomputable def momentumKickDerivative {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i) + h •
      (ContinuousLinearMap.proj i).comp
        ((fderiv ℝ F (textbookPositionProjection Nc z)).comp
          (textbookPositionProjection Nc))))

private theorem momentumKick_hasFDerivAt {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) :
    HasFDerivAt (textbookMomentumKick F h) (momentumKickDerivative F h z) z := by
  apply hasFDerivAt_pi.mpr
  intro i
  rcases i with i | i
  · exact hasFDerivAt_apply (Sum.inl i) z
  · have hf := ((hF.differentiable_one (textbookPositionProjection Nc z)).hasFDerivAt.comp z
      (textbookPositionProjection Nc).hasFDerivAt)
    have hi := (hasFDerivAt_apply i (F (textbookPositionProjection Nc z))).comp z hf
    simpa only [textbookMomentumKick, Sum.elim_inr, Pi.add_apply, Pi.smul_apply,
      Function.comp_apply, smul_eq_mul] using
      (hasFDerivAt_apply (Sum.inr i) z).fun_add (hi.fun_const_smul h)

/-- source_id: MD-2.4.1-PotentialFlow · definition · §2.4.1 · 印刷p.84 / PDFp.106 -/
noncomputable def bp_potentialFlow {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)

/-- source_id: MD-2.4.1-SplitEuler · unnumbered_claim · §2.4.1 · 印刷p.84 / PDFp.106 -/
theorem splitEuler :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    splittingMap (textbookPositionDrift m) (textbookMomentumKick (textbookPotentialForce U)) h =
      textbookSymplecticEuler m U h ∧
    splittingMap (textbookMomentumKick (textbookPotentialForce U)) (textbookPositionDrift m) h =
      (fun z => textbookAdjointSymplecticEuler m U h z) := by
  exact MolecularDynamics.Chapter02Review.kineticPotentialComposition_proved

/-- source_id: MD-2.4.1-VerletComposition · Example 2.5 (composition) · §2.4.1 · 印刷p.84–85 / PDFp.106–107 -/
theorem verletComposition :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    coordinateVerlet m (textbookPotentialForce U) h z =
      pack (verlet m (textbookPotentialForce U) h (unpack z)) ∧
    coordinateVerlet m (textbookPotentialForce U) h z =
      textbookAdjointSymplecticEuler m U (h/2) (textbookSymplecticEuler m U (h/2) z) := by
  exact MolecularDynamics.Chapter02Review.verletComposition_proved

/-- source_id: MD-2.4.1-VerletSymplectic · unnumbered_claim · §2.4.1 · 印刷p.85 / PDFp.107
[EXTRA] U C²；真实完整步映射。 -/
theorem verletSymplectic :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h, ContDiff ℝ 2 U →
    IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) := by
  exact MolecularDynamics.Chapter02Review.verletSymplectic_proved

/-- source_id: MD-2.4.1-SymmetricComposition · unnumbered_claim · §2.4.1 · 印刷p.85 / PDFp.107
[EXTRA] 实际可逆步Equiv.Perm；完整伴随半步组合。 -/
theorem symmetricComposition {E : Type*}
    (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookSymmetricComposition G) =
      textbookSymmetricComposition G := by
  apply MolecularDynamics.textbookSymmetricComposition_isSelfAdjoint <;> assumption

/-- source_id: MD-2.4.1-SymmetricEven · unnumbered_claim · §2.4.1 · 印刷p.85 / PDFp.107
[EXTRA] [EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。 -/
theorem symmetricEven :
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ⊤ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ⊤ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r := by
  sorry

/-- source_id: MD-2.4.2-CompositionSymplectic · unnumbered_claim · §2.4.2 · 印刷p.85 / PDFp.107 -/
theorem compositionSymplectic {Nc : ℕ}
    (G₁ G₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hG₁ : ∀ h, IsTextbookSymplecticMap (G₁ h))
    (hG₂ : ∀ h, IsTextbookSymplecticMap (G₂ h)) (h : ℝ) :
    IsTextbookSymplecticMap (textbookComposeMaps G₁ G₂ h) := by
  apply MolecularDynamics.textbookComposeMaps_isSymplectic <;> assumption

/-- source_id: MD-2.4.2-CompositionOrder · unnumbered_claim · §2.4.2 · 印刷p.85 / PDFp.107
[EXTRA] [EXTRA]两个方法逼近同一实际流；第一个方法1+L|h|稳定；陈述保留至少min阶，允许更高，不把“typically”冒充确切阶相等。 -/
theorem compositionOrder :
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s) := by
  sorry

/-- source_id: MD-2.4.3-HarmonicSplit · definition · §2.4.3 · 印刷p.85–86 / PDFp.107–108
[EXTRA] [EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。 -/
def bp_harmonicAnharmonic (Ω : ℝ) (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := Real.cos (h*Ω)*z.1 + Real.sin (h*Ω)/Ω*z.2
  (q, -Ω*Real.sin (h*Ω)*z.1 + Real.cos (h*Ω)*z.2 - h*deriv U q)

/-- source_id: MD-2.4.4-ImplicitLocal · unnumbered_claim · §2.4.4 · 印刷p.86 / PDFp.108
[EXTRA] [EXTRA]g C¹且实际导数为连续线性同构；只能保证局部逆，原文“typically”不构成任意g可逆定理。逆在更小紧邻域有界。 -/
theorem implicitLocal :
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n), ContDiff ℝ 1 g → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ U V : Set (Q n), IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g x ∈ V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ 1 inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧ (∀ y ∈ V, inv y ∈ U ∧ g (inv y) = y) ∧ (∀ y ∈ U, inv (g y) = y) := by
  sorry

/-- source_id: MD-2.4.4-BackwardEulerSolve · Example 2.6 · §2.4.4 · 印刷p.86 / PDFp.108 -/
def backwardEulerResidual (f : E → E) (h : ℝ) (z w : E) : E := w-z-h • f w

/-- source_id: MD-2.4.4-Newton · definition · §2.4.4 · 印刷p.86–87 / PDFp.108–109
[ERRATUM?] 原文混用zₙ⁽ᵏ⁾与zₙ₊₁⁽ᵏ⁾；保留两个不同输入，不静默改成相同迭代点。映射可逆也不保证任意近似Jacobian非奇异。 -/
def newtonPrinted {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)

/-- source_id: MD-2.4.4-NewtonQuadratic · unnumbered_claim · §2.4.4 · 印刷p.87 / PDFp.109
[EXTRA] [EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。 -/
theorem newtonQuadratic :
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n),
    ContDiff ℝ 2 g → g x = 0 → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ C > 0, ∃ δ > 0, ∀ y : Q n, ‖y-x‖ < δ →
      ∃ B : Q n ≃L[ℝ] Q n, HasFDerivAt g B.toContinuousLinearMap y ∧ ‖newtonStep g 0 y B-x‖ ≤ C*‖y-x‖^2 := by
  sorry

/-- source_id: MD-2.4.4-FrozenNewton · unnumbered_claim · §2.4.4 · 印刷p.87 / PDFp.109
[EXTRA] [EXTRA]固定D连续线性同构，邻域内实际I−D⁻¹g′范数≤ρ<1，ρ>0；精确可核的small资格，未声称任意近似Jacobian都收敛。 -/
theorem frozenNewton :
  ∀ n (g : Q n → Q n) (A : Q n ≃L[ℝ] Q n) x δ ρ,
    g x = 0 → 0 < δ → 0 < ρ → ρ < 1 → ContDiff ℝ 1 g →
    (∀ y ∈ Metric.ball x δ, ‖ContinuousLinearMap.id ℝ (Q n)-A.symm.toContinuousLinearMap.comp (fderiv ℝ g y)‖ ≤ ρ) →
    ∀ y ∈ Metric.ball x δ, ‖newtonStep g 0 y A-x‖ ≤ ρ*‖y-x‖ := by
  sorry

/-- source_id: MD-2.4.5-Conjugacy · definition · §2.4.5 · 印刷p.88 / PDFp.110 -/
def bp_conjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ

/-- source_id: MD-2.4.5-ConjugateIterates · unnumbered_claim · §2.4.5 · 印刷p.88 / PDFp.110 -/
theorem conjugateIterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n]) := by
  apply MolecularDynamics.textbook_conjugate_iterates <;> assumption

/-- source_id: MD-2.4.5-ConjugateLimits · unnumbered_claim · §2.4.5 · 印刷p.88 / PDFp.110 -/
theorem conjugateLimits (χ : E ≃ₜ E) (A B : E → E) (hA : A=textbookConjugateMap χ B)
    (zStar : E) (hB : ∀ z, Tendsto (fun k : ℕ => B^[k] z) atTop (𝓝 zStar)) :
    ∀ z, Tendsto (fun k : ℕ => A^[k] z) atTop (𝓝 (χ.symm zStar)) := by
  intro z
  apply (MolecularDynamics.textbook_conjugate_iterates_tendsto_iff χ A B hA z (χ.symm zStar)).mpr
  simpa using hB (χ z)

/-- source_id: MD-2.4.5-EulerConjugacy · unnumbered_claim · §2.4.5 · 印刷p.88 / PDFp.110 -/
theorem eulerConjugacy :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ textbookSymplecticEuler m U h ∘
      textbookMomentumKick (textbookPotentialForce U) (-h/2) = coordinateVerlet m (textbookPotentialForce U) h := by
  intro n m U h
  funext z
  let F := textbookPotentialForce U
  let q : Q n := fun i => z (Sum.inl i)+h*(m i)⁻¹*
    (z (Sum.inr i)+(h/2)*F (textbookPositionProjection n z) i)
  have hl : textbookPositionProjection n
      (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z))=q := by
    funext i
    simp [q,F,textbookPositionProjection,textbookSymplecticEuler,
      textbookMomentumKick,textbookPositionDrift,Function.comp_def]
    ring <;> simp
  have hr : textbookPositionProjection n
      (textbookPositionDrift m h (textbookMomentumKick F (h/2) z))=q := by
    funext i
    simp [q,textbookPositionProjection,textbookPositionDrift,textbookMomentumKick]
  funext i
  rcases i with i | i
  · change textbookPositionProjection n
      (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z)) i =
        textbookPositionProjection n (textbookPositionDrift m h (textbookMomentumKick F (h/2) z)) i
    rw [hl,hr]
  · change textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z) (Sum.inr i)+
      (h/2)*F (textbookPositionProjection n
        (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z))) i =
      textbookMomentumKick F (h/2) z (Sum.inr i)+(h/2)*F (textbookPositionProjection n
        (textbookPositionDrift m h (textbookMomentumKick F (h/2) z))) i
    rw [hl,hr,textbookSymplecticEuler_momentum,textbookPositionProjection_momentumKick]
    simp [F,textbookMomentumKick]
    ring

/-- source_id: MD-2.4.5-Processing · definition · §2.4.5 · 印刷p.88 / PDFp.110 -/
noncomputable def bp_processedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)

/-- source_id: MD-2.4.5-ProcessingIterates · unnumbered_claim · §2.4.5 · 印刷p.88 / PDFp.110 -/
theorem processingIterates (χ : ℝ → E ≃ₜ E)
    (B G : ℝ → E → E) (hG : ∀ h, G h = textbookProcessedMethod χ B h)
    (h : ℝ) (z₀ : E) (n : ℕ) :
    textbookProcessedIterate χ B h z₀ n = oneStepIterate G h z₀ n := by
  apply MolecularDynamics.textbookProcessedIterate_eq_of_conjugacy <;> assumption

/-- source_id: MD-2.4.5-ProcessingOrder · unnumbered_claim · §2.4.5 · 印刷p.88 / PDFp.110
[EXTRA] r自然数有限时间窗误差界；χh为实际Homeomorph。 -/
theorem processingOrder (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (hG : ∀ h, G h=textbookProcessedMethod χ B h) (γ : ℝ → E) (τ : ℝ) (r : ℕ)
    (horder : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError G (τ/ν) γ ν ≤ C*(τ/ν)^r) :
    (∀ h ν, textbookProcessedMaxError χ B h γ ν=oneStepMaxError G h γ ν) ∧
    (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      textbookProcessedMaxError χ B (τ/ν) γ ν ≤ C*(τ/ν)^r) := by
  have heq := MolecularDynamics.textbookProcessedMaxError_eq_of_conjugacy χ B G hG
  refine ⟨fun h ν => heq h γ ν, ?_⟩
  simpa only [heq] using horder

/-- source_id: MD-2.4.5-EulerEffectiveOrder · unnumbered_claim · §2.4.5 · 印刷p.88 / PDFp.110
[EXTRA] [EXTRA]正固定质量，U C⁴；真实机械Hamilton轨迹及紧时间窗；处理器为实际Homeomorph，完整processed误差界，不以待证二阶作假设。 -/
theorem eulerEffectiveOrder : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) τ,
    positiveMass m → ContDiff ℝ 4 U → 0 < τ →
    (∀ t ∈ Icc 0 τ, HasDerivWithinAt γ
      (textbookHamiltonianVectorField (fun z => (∑ i, z (Sum.inr i)^2/m i)/2+
        U (z ∘ Sum.inl)) (γ t)) (Icc 0 τ) t) → ContinuousOn γ (Icc 0 τ) →
    ∃ χ : ℝ → SymplecticCoordinates n ≃ₜ SymplecticCoordinates n,
      (∀ h, textbookProcessedMethod χ (textbookSymplecticEuler m U) h =
        coordinateVerlet m (textbookPotentialForce U) h) ∧
      (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        textbookProcessedMaxError χ (textbookSymplecticEuler m U) (τ/ν) γ ν ≤ C*(τ/ν)^2) := by
  sorry

end MD.Ch02
