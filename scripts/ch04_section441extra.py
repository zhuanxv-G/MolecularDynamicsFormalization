"""Additional exact claims belonging to subsection 4.4.1."""
from ch04_data import add,NS
add('RigidPoissonSkew','4.4.1',172,[],r'''$\widetilde J(\pi)=\operatorname{skew}(\pi)$ is obviously skew symmetric.''',f'''theorem rigidPoissonSkew : ∀ π : {NS}V, ({NS}rigidPoissonMatrix π)ᵀ= -{NS}rigidPoissonMatrix π := by
  intro π
  ext i j
  fin_cases i <;> fin_cases j <;> simp [{NS}rigidPoissonMatrix,{NS}skewMatrix]''',context=['实际矩阵转置等式；不把Jacobi条件或抽象非退化形式混作skew。'])
add('RigidHamiltonianField','4.4.1',172,[],r'''Let us observe that (4.41) is in the form $\dot\pi=\widetilde J(\pi)\nabla\widetilde H$, where $\widetilde J(\pi)=\operatorname{skew}(\pi)$ is obviously skew symmetric, and $\widetilde H=\pi^TT^{-1}\pi/2$ is the energy function.''',f'''theorem rigidHamiltonianField : ∀ (T : {NS}Mat3) (π : {NS}V), T.PosDef →
  {NS}eulerRigidField T π={NS}rigidPoissonMatrix π *ᵥ
    {NS}grad (fun x => {NS}dot x (T⁻¹ *ᵥ x)/2) π := by
  sorry''',extra=['正定T确保对称可逆；真实Fréchet配置梯度，不把∇H=T⁻¹π作假设。'],missing='待实际二次能量梯度与逆对称矩阵桥接；不建设新刚体理论。')
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['RigidHamiltonianField'])
