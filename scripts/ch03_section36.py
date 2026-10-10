"""First eight §3.6 entries, original PDF149–151."""
from ch03_data import add,copied,proposition,D
from blueprint_source import ChapterData
add('HamiltonianFlowStructures','3.6','127–128',[102],r'''The flow of a Hamiltonian system of the form $H=p^TM^{-1}p/2+U(q)$ will preserve all of the following:
1. The symplectic two-form $\mathrm dq\wedge\mathrm dp$.
2. The Hamiltonian (i.e., the energy) $H$.
3. The volume in phase space (as the vector field is divergence free).''',ChapterData(2).proposition('localHamiltonianStructures_statement','hamiltonianFlowStructures'),
context=['原列表第4项time-reversal symmetry由§3.6.1–2单独保留；此签名保留一般C¹局部流的前三性质，不能由较强jointC²桥接冒充。'],
extra=['原场在开放域C¹，真实局部流、反步与局部定义域资格显式。'],missing='完整C¹流可微性、变分及测度保持桥接仍缺；已存在jointC²特例不能替代本签名。')
add('VolumeNotSymplectic','3.6',128,[103],r'''The phase volume conservation can be seen as a consequence of the symplectic property, but it is a weaker condition. It is possible to construct methods that preserve volume but which are not symplectic, and we can build methods that exactly conserve the energy (as we shall show below).''',proposition('volumeNotSymplectic_statement'),
context=['四维实际光滑映射、Jacobian det=1且不辛；辛蕴含体积见第2章，能量投影见§3.5。'],missing='待构造四维线性det=1非辛映射并桥接真实Jacobian；缺完整有限矩阵到坐标映射桥接。')
add('LinearInvolution','3.6.1',128,[104],r'''By an involution we mean a linear mapping $\boldsymbol z\mapsto R\boldsymbol z$ where $R^2=I$, i.e. $R$ is its own inverse.''',copied(D,'linearInvolution'),kind='definition',context=['一般R²=I不蕴含Rᵀ=R或正交。'])
add('ReversedFieldPrinted','3.6.1',128,[105],r'''Given the involution $R$ we define the time reversal of the vector field $f$ with respect to $R$ by
\[\widetilde f(\boldsymbol z)=-R^Tf(R\boldsymbol z).\]
When a vector field is its own reversal we say that it is a time-reversible vector field.''',copied(D,'reversedField'),kind='definition',
issues=[dict(code='ERRATUM?',detail='一般线性involution的时间反转应−R⁻¹f(Rz)=−Rf(Rz)，不是−Rᵀ；机械R对称时两者相同。')],verdict='NEEDS_HUMAN',explanation='字面定义保留Rᵀ；不把它当任意involution的正确反转；p129使用R⁻¹=R与此不同。')
add('MomentumReversal','3.6.1',128,[106],r'''Let $H(q,p)=p^TM^{-1}p/2+U(q)$ be the Hamiltonian for a system of $N_c$ configuration variables. Define the $2N_c\times2N_c$ matrix $R$ by
\[R=\begin{bmatrix}I&0\\0&-I\end{bmatrix}.\]''',copied(D,'momentumReversal'),kind='definition',context=['在Z n=Q n×Q n的等价坐标给(q,−p)；canonicalReversal是同一动作的pack坐标。'])
add('MechanicalReversal','3.6.1',128,[107],r'''The vector fields involved are
\[f=\begin{bmatrix}M^{-1}p\\-\nabla U(q)\end{bmatrix},\qquad\widetilde f=-Rf(Rz)=\begin{bmatrix}-M^{-1}p\\\nabla U(q)\end{bmatrix},\]
which are clearly equal. Therefore the molecular dynamics Hamiltonian system is time-reversible.''',
'''theorem mechanicalReversalPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n),
      (-momentumReversal (mechanicalField m (fun q => -grad U q) (momentumReversal z)) =
        (-invMass m z.2, grad U z.1)) ∧
      ((-invMass m z.2, grad U z.1) = mechanicalField m (fun q => -grad U q) z) ∧
      mechanicalField m (fun q => -grad U q) (momentumReversal z) =
        -momentumReversal (mechanicalField m (fun q => -grad U q) z) := by
  sorry''',
context=['原页右侧列向量实际写−M⁻¹p,+∇U，与左侧不等；−Rf(Rz)实际应等f。正确代数结论桥接，原展示式保留待审。'],
verdict='FAIL',explanation='字面三项完整保留；n=1,m=1,U=0,z=(0,1)时f=(1,0)，原右列=(−1,0)，与“clearly equal”不符。正确反转结论另列桥接，未以正确结论替换印刷等式。',issues=[dict(code='ERRATUM?',detail='p128右端列向量符号与−Rf(Rz)实际计算不符；原文不静默更改。')],missing='本地FAIL不进入证明；正确机械反转已有正式库证明，原展示式待裁定。')
add('ReversedTrajectoryPrinted','3.6.1','128–129',[108],r'''For the system $\mathrm dz/\mathrm dt=f(\boldsymbol z)$, a coordinate transformation $\boldsymbol z\mapsto\widetilde{\boldsymbol z}=R\boldsymbol z$ results in
\[\frac{\mathrm d\widetilde{\boldsymbol z}}{\mathrm dt}=R\frac{\mathrm d\boldsymbol z}{\mathrm dt}=Rf(R^{-1}\widetilde{\boldsymbol z})=Rf(R\widetilde{\boldsymbol z}),\]
since $R^{-1}=R$. A change of time $t\mapsto\tau=-t$ results in
\[\frac{\mathrm d\boldsymbol z}{\mathrm d\tau}=\frac{\mathrm dt}{\mathrm d\tau}\frac{\mathrm d\boldsymbol z}{\mathrm dt}=-f(\boldsymbol z).\]''',proposition('reversedFieldPrinted_statement','reversedTrajectoryPrinted'),
context=['将p128字面−Rᵀ定义代入反向轨道得到的待审断言；不是p129实际R链式法则的正确版本。'],verdict='FAIL',explanation='R=[[1,1],[0,−1]]满足R²=I，取常场f=(1,0)；真实反向导数−Rf=(−1,0)，字面−Rᵀf=(−1,−1)不同。',issues=[dict(code='ERRATUM?',detail='p128的Rᵀ字面反转与p129的R链式法则不能一般同时成立；具体二维反例见本地审计。')],missing='字面FAIL不进入证明，等待网站与导师裁定。')
add('ReversedTrajectory','3.6.1',129,[],r'''In other words, for a reversible vector field, the coordinate transformation $\boldsymbol z\mapsto R\boldsymbol z$ is equivalent to the change of time $t\mapsto-t$.''',proposition('reversedTrajectory_statement'),
context=['p129正确R链式法则版本；与字面Rᵀ断言分开；γ的真实时间导数明示。'],extra=['[EXTRA]采用正确f(Rz)=−Rf(z)而非一般Rᵀ字面定义；每个实t均有真实γ导数。'],missing='待短链式法则证明；尚未把原文错误定义修成已审核签名。')
from blueprint_source import apply_saved_routes
from ch03_data import RECORDS
apply_saved_routes(3,RECORDS,['ReversedTrajectory'])
