"""First eight domain-faithful density/probability records, PDF203–204."""
from ch05_data import add,NS
add('DensityOn','5.2.1',182,[9],r'''Let $D\subset\mathbb R^m$ be a suitable set comprising the collection of admissible phase space points $z$. A density on $D$ is a function $\rho:D\to\mathbb R$ such that (i) $\rho(z)\geq0,z\in D$, and (ii) $\int_D\rho\,d\omega<\infty$, where $d\omega=dz_1dz_2\cdots dz_m$ (i.e. $\int_D\rho\,d\omega$ is the integral of the measurable function $\rho$ in the Lebesgue sense).''',f'''def densityOn {{n : ℕ}} (D : Set ({NS}E n)) (ρ : {NS}E n → ℝ) : Prop :=
  NullMeasurableSet D volume ∧ AEMeasurable ρ (volume.restrict D) ∧
    (∀ z ∈ D,0 ≤ ρ z) ∧ IntegrableOn ρ D''',kind='definition',extra=['[EXTRA]域外值不影响受限积分；NullMeasurableSet表达Lebesgue完备化可测域，AEMeasurable表达受限Lebesgue可测函数；非负且可积对应有限非负积分。'])
add('ProbabilityDensityOn','5.2.1',182,[9],r'''A probability density function (or p.d.f.) on $D$ is a density which is normalized so that $\int_D\rho\,d\omega=1$.''',f'''def probabilityDensityOn {{n : ℕ}} (D : Set ({NS}E n)) (ρ : {NS}E n → ℝ) : Prop :=
  densityOn D ρ ∧ (∫ z in D,ρ z)=1''',kind='definition',context=['保留任意Lebesgue可测域D，不用全空间替代。'])
add('DensityOnNormalization','5.2.1',182,[10],r'''Any density (with positive total integral) can be normalized by dividing by $\int_D\rho\,d\omega$.''',f'''theorem densityOnNormalization : ∀ n (D : Set ({NS}E n)) (ρ : {NS}E n → ℝ),
  densityOn D ρ → 0 < (∫ z in D,ρ z) →
    probabilityDensityOn D (fun z => ρ z/(∫ x in D,ρ x)) := by
  sorry''',context=['实际受限Bochner积分及正的归一化分母，不把归一化作假设。'])
add('DensityProbability','5.2.1',182,[11],r'''For any measurable subset $A$ of $D$, and probability density $\rho$, we define $\operatorname{Pr}(A)\stackrel{\rm def}{=}\int_A\rho\,d\omega$.''',f'''def densityProbability {{n : ℕ}} (ρ : {NS}E n → ℝ) (A : Set ({NS}E n)) : ℝ :=
  ∫ z in A,ρ z''',kind='definition',context=['使用条件A⊆D、A可测、probabilityDensityOn D ρ在后续界定理中明确，不给域外概率意义。'])
add('DensityMeasureOn','5.2.1',182,[11],r'''For any measurable subset $A$ of $D$, and probability density $\rho$, we define $\operatorname{Pr}(A)\stackrel{\rm def}{=}\int_A\rho\,d\omega$.''',f'''def densityMeasureOn {{n : ℕ}} (D : Set ({NS}E n)) (ρ : {NS}E n → ℝ) : Measure ({NS}E n) :=
  (volume.restrict D).withDensity (fun z => ENNReal.ofReal (ρ z))''',kind='definition',extra=['[EXTRA]实际受限Lebesgue测度的withDensity实现；概率归一化需要上条完整条件，不限制一般概率测度都必须有密度。'])
add('LebesgueClosure','5.2.1',182,[12],r'''The technical requirement is that $D$ be Lebesgue-measurable. Open and closed sets in $\mathbb R^m$ are Lebesgue-measurable, for example a rectangular box. Sets which are constructed by taking countable unions or intersections of measurable sets are measurable.''',f'''theorem lebesgueClosure : ∀ n (s : Set ({NS}E n)) (A : ℕ → Set ({NS}E n)),
  (IsOpen s → NullMeasurableSet s volume) ∧ (IsClosed s → NullMeasurableSet s volume) ∧
  ((∀ k,NullMeasurableSet (A k) volume) →
    NullMeasurableSet (⋃ k,A k) volume ∧ NullMeasurableSet (⋂ k,A k) volume) := by
  sorry''',context=['保留Lebesgue完备化的可测族；Borel生成记号另条。'])
add('BorelSigma','5.2.1',182,[12],r'''A suitable family of sets on which Lebesgue measure can be defined is the so-called Borel $\sigma$-algebra obtained by countable unions, intersections, or relative complements of open balls in $\mathbb R^m$.''',f'''def borelSigma (n : ℕ) : MeasurableSpace ({NS}E n) := borel ({NS}E n)''',kind='definition',context=['Mathlib实际Borel生成σ代数；不混同其完备化的全部Lebesgue可测集合。'])
add('DensityProbabilityBounds','5.2.1',183,[13],r'''It is automatic that $0\leq\operatorname{Pr}(A)\leq1$.''',f'''theorem densityProbabilityBounds : ∀ n (D A : Set ({NS}E n)) (ρ : {NS}E n → ℝ),
  probabilityDensityOn D ρ → A ⊆ D → NullMeasurableSet A volume →
    0 ≤ densityProbability ρ A ∧ densityProbability ρ A ≤ 1 := by
  sorry''',extra=['原上下文的A⊆D和Lebesgue可测A明确写入，不把“µ已是概率测度”代替密度归一化所需证明。'])
