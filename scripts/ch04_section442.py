"""Eight complete DLM objects, PDF195–196."""
from ch04_data import add,copied,proposition,D,NS,RECORDS
from ch04_table_text import TABLE_TEXT
add('RigidForce','4.4.2',173,[96],r'''The relevant expressions are $F_k=-\partial U/\partial q^k$.''',copied(D,'rigidForce'),kind='definition',context=['真实Fréchet偏导，不用新力公理。'])
add('MatrixRot','4.4.2',174,[96],r'''for a $3\times3$ matrix $A$, $\operatorname{rot}(A)=\operatorname{skew}^{-1}(A-A^T)$.''',copied(D,'matrixRot'),kind='definition',context=['没有额外1/2；明确skew逆在A−Aᵀ上的实际三个坐标。'])
add('RigidTorque','4.4.2',173,[96],r'''$\tau_k=-\operatorname{rot}(\Theta^{kT}\partial U/\partial\Theta^k)$.''',copied(D,'rigidTorque'),kind='definition')
add('DLMPrinted','4.4.2',174,[97],TABLE_TEXT,f'''def dlmPrinted (I : {NS}V) (U : {NS}V → {NS}Mat3 → ℝ) (h : ℝ) : {NS}RBState → {NS}RBState :=
  {NS}rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    {NS}rigidDrift 1 h ∘ {NS}rigidKick U (h/2)''',kind='definition',issues=[dict(code='ERRATUM?',detail='字面drift缺1/M；正角spin动量符号疑点保留。')],context=['原表列动量Rπ与方向ΘRᵀ，与正式库一致。'],extra=['[EXTRA]本条仅N=1实例；任意N体耦合势与完整算法另由DLMPrintedSystem忠实保存。'])
add('DLMMassOnly','4.4.2',174,[97],r'''“Drift”: step forward a whole step in positions $q^k:=q^k+hp^k$.''',f'''def dlmMassOnly (M : ℝ) (I : {NS}V) (U : {NS}V → {NS}Mat3 → ℝ) (h : ℝ) : {NS}RBState → {NS}RBState :=
  {NS}rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    {NS}rigidDrift M h ∘ {NS}rigidKick U (h/2)''',kind='definition',extra=['[EXTRA]只将drift质量修为q+h p/M；仍保留原spin，不能据此称完整正确几何积分器。'])
add('DriftSpinCommute','4.4.2',174,[98],r'''Note that the symmetric character of the algorithm could be revealed more clearly by dividing the “Drift” step into two half steps sandwiched around the Spin step (Kick, Drift, Spin, Drift, Kick), but as the updates Drift/Spin are decoupled, the order they are performed is not important.''',f'''theorem driftSpinCommute : ∀ M h (I : {NS}V) (z : {NS}RBState),
  {NS}rigidDrift M h (z.1,printedSpinStep I h z.2)=
    (({NS}rigidDrift M h z).1,printedSpinStep I h ({NS}rigidDrift M h z).2) := by
  intro M h I z
  rfl''',context=['真实原字面五轴spin与质量drift的全状态相等，非只算子标签。'])
add('DLMStructureFormal','4.4.2','173–174',[99],r'''The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.''',proposition('dlmStructure_statement'),verdict='NEEDS_HUMAN',explanation='正式库spin与原表一致；旧陈述为单体质量修正版及反步关系，不能冒充原任意N体完整算法。正角子流符号仍需审校。',extra=['[EXTRA]旧正式库单体质量一致对象单独保留；原任意N体耦合势的算法几何声明另列。'],missing='缺实际旋转约束/Poisson形式及完整kick结构；不搭大型刚体理论。')
add('DLMPrintedStructure','4.4.2','173–174',[],r'''The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.''',f'''theorem dlmPrintedStructure : ∀ (I : {NS}V) (U : {NS}V → {NS}Mat3 → ℝ),
  (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    {NS}rbSymplectic (dlmPrinted I U h) := by
    sorry''',verdict='NEEDS_HUMAN',explanation='实际字面算法完整rb拉回形式陈述；原spin的相反角动量符号需审校，不能先判PASS。',extra=['明确SO3初态与实际切向量在rbSymplectic定义内；单位质量为原字面drift。'],missing='待网站/导师裁定spin符号及结构；不建设新Poisson/刚体理论。')
