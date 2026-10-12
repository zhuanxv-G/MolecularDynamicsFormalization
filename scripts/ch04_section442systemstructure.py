"""Whole-system geometry and the exact original DLM structure obligation."""
from ch04_data import add,NS
add('RigidSystemSymplectic','4.4.2','173–174',[],r'''the combined scheme is a symplectic method in the generalized sense of constrained dynamics.''',f'''def rigidSystemSymplectic {{N : ℕ}} (G : rigidSystemState N → rigidSystemState N) : Prop :=
  ∀ (z : rigidSystemState N), (∀ k, (z k).2.2ᵀ*(z k).2.2=1 ∧ (z k).2.2.det=1) →
    (∀ k, (G z k).2.2ᵀ*(G z k).2.2=1 ∧ (G z k).2.2.det=1) ∧
    ∀ (u v : rigidSystemState N), (∀ k, {NS}rbTangent (z k) (u k)) → (∀ k, {NS}rbTangent (z k) (v k)) →
      (∑ k, {NS}rbForm (G z k) (((fderiv ℝ G z) u) k) (((fderiv ℝ G z) v) k))=
        ∑ k, {NS}rbForm (z k) (u k) (v k)''',kind='definition',extra=['[EXTRA]完整N体SO(3)配置、实际切向量和各体rbForm之和；明确包含输出配置约束及真实Fréchet拉回，不假设辛性或以抽象形式替代。'])
add('DLMPrintedSystemStructure','4.4.2','173–174',[99],r'''The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.''',f'''theorem dlmPrintedSystemStructure : ∀ N (I : Fin N → {NS}V)
    (U : (Fin N → {NS}V) → (Fin N → {NS}Mat3) → ℝ),
  (∀ k i, 0 < I k i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rigidSystemSymplectic (dlmPrintedSystem I U h) := by
  sorry''',verdict='NEEDS_HUMAN',explanation='忠实全N、任意耦合势与字面spin算法；未删量词或弱化成单体。原正角动量/旋转符号疑点和一般质量drift需网站/导师裁定。',extra=['C³耦合势和正主惯性矩为明确技术资格；实际全部SO3输入/输出约束及N体两形式在定义内。'],missing='原表spin符号与完整旋转余切结构待审；不建设新Poisson/刚体理论，不证明NEEDS_HUMAN。')
