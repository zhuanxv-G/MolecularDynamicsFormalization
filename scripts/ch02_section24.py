"""§2.4 original pages105–110 inspected as rendered images."""
from ch02_data import add,copied,proposition,EXCLUDED
RD='MolecularDynamics/Chapter02/ReviewDefinitions.lean'
SE='MolecularDynamics/Chapter02/SymplecticEuler.lean'
SP='MolecularDynamics/Chapter02/SplittingError.lean'
CM='MolecularDynamics/Chapter02/CompositionMethods.lean'
PM='MolecularDynamics/Chapter02/ProcessedMethods.lean'
def d(name):return copied(RD,name,'bp_'+name)
def c(path,name,key):return copied(path,name,key)
def pr(name,key):return proposition(name,key,proof='exact MolecularDynamics.Chapter02Review.'+name.replace('_statement','_proved'))

add('Splitting','2.4.1',83,[115],r'''Suppose that a Hamiltonian $H$ can be split into two parts, i.e. $H=H_1+H_2$, and that the flow maps $\mathcal F_{1,t}$ and $\mathcal F_{2,t}$ are known in closed form for the Hamiltonians $H_1$ and $H_2$, respectively. It is natural to think of using the composition of the flow maps $\mathcal G_h=\mathcal F_{1,h}\circ\mathcal F_{2,h}$ as an approximation to $\mathcal F_h$, the flow map of the combined Hamiltonian $H$.''',d('splittingMap'),kind='definition',context=['只定义给定实际子流的组合；近似精度由后项给出，不把任意映射称为实际流。'])
add('FieldAdd','2.4.1',83,[116],r'''$J\nabla H=J\nabla H_1+J\nabla H_2$.''',c(SP,'textbookHamiltonianVectorField_add','fieldAdd'),extra=['H₁,H₂在实际点可微，实际Fréchet梯度。'],prior=['MolecularDynamics.textbookHamiltonianVectorField_add'])
add('SplittingLocal','2.4.1',83,[117],r'''For this to be a first order method, we need at least $\|\mathcal G_h(\boldsymbol u)-\mathcal F_h(\boldsymbol u)\|\le C(\boldsymbol u)h^2$.''',c(SP,'exists_hamiltonian_splitting_localError_bound','splittingLocal'),
 proof=r'''We expand the map $\mathcal F_h$ into its Taylor series:
\[\mathcal F_h(\boldsymbol u)=\boldsymbol u+hJ\nabla H(\boldsymbol u)+\mathcal O(h^2)=\boldsymbol u+h(J\nabla H_1(\boldsymbol u)+J\nabla H_2(\boldsymbol u))+\mathcal O(h^2).\tag{2.24}\]
For the individual maps $\mathcal F_{1,h}$ and $\mathcal F_{2,h}$, we have
\[\mathcal F_{1,h}(\boldsymbol u)=\boldsymbol u+hJ\nabla H_1(\boldsymbol u)+\mathcal O(h^2),\qquad\mathcal F_{2,h}(\boldsymbol u)=\boldsymbol u+hJ\nabla H_2(\boldsymbol u)+\mathcal O(h^2).\]
Composing the two maps we obtain
\[\mathcal F_{1,h}(\mathcal F_{2,h}(\boldsymbol u))=\boldsymbol u+hJ\nabla H_2(\boldsymbol u)+hJ\nabla H_1(\boldsymbol u+hJ\nabla H_2(\boldsymbol u))+\mathcal O(h^2).\]
Assuming $H_1$ is twice continuously differentiable, we may expand further in the last term and collect
\[\mathcal F_{1,h}(\mathcal F_{2,h}(\boldsymbol u))=\boldsymbol u+h(J\nabla H_2(\boldsymbol u)+J\nabla H_1(\boldsymbol u))+\mathcal O(h^2).\]
Thus the splitting method does indeed provide a second order local approximation to the flow map.''',
 extra=['实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。'],prior=['MolecularDynamics.exists_hamiltonian_splitting_localError_bound'])
add('KineticFlow','2.4.1','83–84',[118],r'''Let $H_1(\boldsymbol q,\boldsymbol p)=\boldsymbol p^TM^{-1}\boldsymbol p/2$ and $H_2(\boldsymbol q,\boldsymbol p)=U(\boldsymbol q)$, and calculate the flow maps $\mathcal F_{1,h}$ and $\mathcal F_{2,h}$ for these individual Hamiltonians. Since
\[\dot{\boldsymbol q}=M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol0\quad(H_1),\]
we find the time-$h$ flow to be
\[\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p,\qquad\boldsymbol P=\boldsymbol p.\]''',c(SE,'textbookPositionDrift','bp_kineticFlow'),kind='definition',label='Example 2.4 (kinetic)',context=['固定对角质量，mᵢ≠0资格由机械模型；闭式映射逐坐标表达。'])
add('PotentialFlow','2.4.1',84,[119],r'''On the other hand, for the system with Hamiltonian $H_2$, we have
\[\dot{\boldsymbol q}=\boldsymbol0,\qquad\dot{\boldsymbol p}=-\nabla U(\boldsymbol q)\quad(H_2),\]
which implies the flow map
\[\boldsymbol Q=\boldsymbol q,\qquad\boldsymbol P=\boldsymbol p-h\nabla U(\boldsymbol q).\]''',c(SE,'textbookMomentumKick','bp_potentialFlow'),kind='definition',context=['F=-∇U；实际闭式映射。'])
add('SplitEuler','2.4.1',84,[120],r'''When these maps are composed, we obtain
\[\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol P,\qquad\boldsymbol P=\boldsymbol p-h\nabla U(\boldsymbol q),\]
which is the Symplectic Euler method. The reversed composition gives the adjoint Symplectic Euler method (2.22), (2.23).''',pr('kineticPotentialComposition_statement','splitEuler'),prior=['MolecularDynamics.Chapter02Review.kineticPotentialComposition_proved'])
add('VerletComposition','2.4.1','84–85',[121],r'''We compose the Symplectic Euler method $\mathcal G_h$ and its adjoint $\mathcal G_h^*$, in each case using step $h/2$; we define $\mathcal K_h=\mathcal G_{h/2}^*\circ\mathcal G_{h/2}$.''',pr('verletComposition_statement','verletComposition'),label='Example 2.5 (composition)',
 proof=r'''We obtain
\[\bar{\boldsymbol q}=\boldsymbol q+\frac h2M^{-1}\bar{\boldsymbol p},\quad\bar{\boldsymbol p}=\boldsymbol p-\frac h2\nabla U(\boldsymbol q),\]
\[\boldsymbol Q=\bar{\boldsymbol q}+\frac h2M^{-1}\bar{\boldsymbol p},\quad\boldsymbol P=\bar{\boldsymbol p}-\frac h2\nabla U(\boldsymbol Q).\]
These simplify to
\[\bar{\boldsymbol p}=\boldsymbol p-\frac h2\nabla U(\boldsymbol q),\quad\boldsymbol Q=\boldsymbol q+hM^{-1}\bar{\boldsymbol p},\quad\boldsymbol P=\bar{\boldsymbol p}-\frac h2\nabla U(\boldsymbol Q).\]
This is the leapfrog/Verlet scheme.''',prior=['MolecularDynamics.Chapter02Review.verletComposition_proved'])
add('VerletSymplectic','2.4.1',85,[122],'''Hence the leapfrog/Verlet scheme is a composition of two symplectic maps and is itself symplectic.''',pr('verletSymplectic_statement','verletSymplectic'),extra=['U C²；真实完整步映射。'],prior=['MolecularDynamics.Chapter02Review.verletSymplectic_proved'])
add('SymmetricComposition','2.4.1',85,[123],r'''In fact we can say even more, since $\mathcal K_h=\mathcal G_{h/2}^*\circ\mathcal G_{h/2}$, we have
\[\mathcal K_h^*=[\mathcal G_{h/2}^*\circ\mathcal G_{h/2}]^*=\mathcal G_{h/2}^*\circ\mathcal G_{h/2}=\mathcal K_h,\]
which is to say that this method is self-adjoint or symmetric.''',c(CM,'textbookSymmetricComposition_isSelfAdjoint','symmetricComposition'),extra=['实际可逆步Equiv.Perm；完整伴随半步组合。'],prior=['MolecularDynamics.textbookSymmetricComposition_isSelfAdjoint'])
add('SymmetricEven','2.4.1',85,[124],'''It is easy to show that symmetric discretization schemes must have even order [14, 29].''',proposition('symmetricEvenOrder_statement','symmetricEven'),extra=['[EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。'],missing='自伴随局部误差首个非零Taylor系数的奇偶性；需高阶展开及逆映射误差理论。')
add('CompositionSymplectic','2.4.2',85,[125],r'''Starting from two different methods $\mathcal G_{1,h}$ and $\mathcal G_{2,h}$, as long as they are both symplectic methods, we can use the composition of the maps
\[\mathcal G_h=\mathcal G_{1,h/2}\circ\mathcal G_{2,h/2}\]
as an alternative symplectic integrator.''',c(CM,'textbookComposeMaps_isSymplectic','compositionSymplectic'),prior=['MolecularDynamics.textbookComposeMaps_isSymplectic'])
add('CompositionOrder','2.4.2',85,[126],'''The order of accuracy of the resulting method is typically the minimum of that of the two starting integrators, but as the Verlet method shows, it can be higher in certain instances.''',proposition('compositionOrder_statement','compositionOrder'),extra=['[EXTRA]两个方法逼近同一实际流；第一个方法1+L|h|稳定；陈述保留至少min阶，允许更高，不把“typically”冒充确切阶相等。'],missing='组合局部误差分拆、h/2与原流半步群性质的BigO常数合并。')
add('HarmonicSplit','2.4.3','85–86',[127],r'''Suppose that we have a Hamiltonian of the form $H=H_0+H_1$ where $H_0=\boldsymbol p^TM^{-1}\boldsymbol p/2+\boldsymbol q^TA\boldsymbol q/2$ defines a system of harmonic oscillators, whereas $H_1(\boldsymbol q,\boldsymbol p)=\tilde U(\boldsymbol q)$ is an anharmonic perturbation. In the simplest case, we can consider $H_0=(1/2)p^2+(\Omega^2/2)q^2$, then a scheme of this type would be
\[\begin{bmatrix}Q\\\hat p\end{bmatrix}=\begin{bmatrix}\cos(h\Omega)&\sin(h\Omega)/\Omega\\-\Omega\sin(h\Omega)&\cos(h\Omega)\end{bmatrix}\begin{bmatrix}q\\p\end{bmatrix},\qquad P=\hat p-h\tilde U'(Q).\]''',d('harmonicAnharmonic'),kind='definition',context=['Lean定义是原文明确标量简例；一般矩阵分裂作为同条背景记号保留。'],extra=['[EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。'])
add('ImplicitLocal','2.4.4',86,[128],r'''An implicit method will typically result in a system of nonlinear equations of the form
\[g(\boldsymbol z_{n+1})=\boldsymbol\tau_n,\tag{2.25}\]
which will need to be solved at each timestep. The right hand $\boldsymbol\tau_n$ is a vector that depends on the previous time-step $\boldsymbol z_n$, perhaps in a complicated way. We may assume the number of equations represented by (2.25) is equal to the dimension of the phase space where $\boldsymbol z$ is defined, so we have a square nonlinear system. Typically $g$ will depend on the stepsize and coefficients of the method and will have the property that for $h$ sufficiently small, the solution is uniquely defined and is continuously defined in terms of $\boldsymbol\tau_n$, that is the mapping $g$ has a bounded and smooth inverse.''',proposition('implicitLocal_statement','implicitLocal'),extra=['[EXTRA]g C¹且实际导数为连续线性同构；只能保证局部逆，原文“typically”不构成任意g可逆定理。逆在更小紧邻域有界。'],verdict='NEEDS_HUMAN',explanation='现完整局部逆陈述还需加局部有界性以覆盖原句；不证明未完整签名。',missing='逆函数定理桥接、紧邻域有界及参数h的小步可逆资格。')
add('BackwardEulerSolve','2.4.4',86,[],r'''The Backward Euler method,
\[\boldsymbol z_{n+1}=\boldsymbol z_n+hf(\boldsymbol z_{n+1}),\]
is an example of an implicit method. The calculation of a timestep involves solving a system of equations of the form
\[g(\boldsymbol w)=\boldsymbol w-\boldsymbol z_n-hf(\boldsymbol w)=\boldsymbol0.\]
The map $\mathcal G_h$ is defined implicitly by the equation
\[\mathcal G_h(\boldsymbol z)=\boldsymbol z+hf(\mathcal G_h(\boldsymbol z)).\]''',
'''def backwardEulerResidual (f : E → E) (h : ℝ) (z w : E) : E := w-z-h • f w''',kind='definition',label='Example 2.6',context=['零点即隐式步关系；没有断言每个f/h存在唯一零点。'])
add('Newton','2.4.4','86–87',[129],r'''Solving the system may proceed from an initial guess $\boldsymbol z_{n+1}^{(0)}$ by use of Newton’s method:
\[\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}-[J^{(k)}]^{-1}(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),\]
where $J^{(k)}$ is the Jacobian matrix of the mapping $g$ evaluated at $\boldsymbol z_n^{(k)}$, or else an approximation of this Jacobian (assumed to be nonsingular due to the invertibility of the mapping). The iteration may be recast in the form
\[\boldsymbol b_k=-(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),\quad J^{(k)}\Delta\boldsymbol z_k=\boldsymbol b_k,\quad\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}+\Delta\boldsymbol z_k.\]''',
'''def newtonPrinted {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)''',kind='definition',issues=[dict(code='ERRATUM?',status='NEEDS_HUMAN',detail='原文混用zₙ⁽ᵏ⁾与zₙ₊₁⁽ᵏ⁾；保留两个不同输入，不静默改成相同迭代点。映射可逆也不保证任意近似Jacobian非奇异。')],verdict='NEEDS_HUMAN',explanation='字面双输入更新与标准Newton不同，待裁定索引；定义不证明收敛。')
add('NewtonQuadratic','2.4.4',87,[130],r'''Newton’s method (without approximation of the Jacobian matrix) has a remarkable quadratic convergence property, meaning that, when the initial guess is close to the solution, the errors $e_k,e_{k+1}$ at the $k$th and $k+1$st iterations satisfy the relation
\[e_{k+1}\le Ke_k^2.\]''',proposition('newtonQuadratic_statement','newtonQuadratic'),context=['标准Newton的同一个迭代点，前项字面索引疑点另列；e=‖y−x*‖。'],extra=['[EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。'],missing='定量Newton–Kantorovich局部定理、邻域导数逆有界与二阶余项。')
add('FrozenNewton','2.4.4',87,[131],r'''For example, if the Jacobian matrix is large and can be written in the form
\[J(\boldsymbol z)=D+E(\boldsymbol z),\]
where $E$ is small in norm and $D$ is a constant sparse matrix, then, in many cases, the Jacobian matrix may be replaced by the constant matrix $D$ and the iteration will still converge.
This rapid convergence is typically lost when the Jacobian matrix is approximated in some way, and one finds instead
\[e_{k+1}\le\rho e_k,\]
where $0<\rho<1$, i.e., quadratic convergence is replaced by geometric convergence.''',proposition('frozenNewton_statement','frozenNewton'),extra=['[EXTRA]固定D连续线性同构，邻域内实际I−D⁻¹g′范数≤ρ<1，ρ>0；精确可核的small资格，未声称任意近似Jacobian都收敛。'],missing='沿凸球积分/均值范数界、保持邻域与迭代几何界。')
add('Conjugacy','2.4.5',88,[132],r'''In general, we say that two maps $A$ and $B$ are conjugate if there is a homeomorphism $\chi$ such that
\[A=\chi^{-1}\circ B\circ\chi.\]
A homeomorphism is a continuous bijection which has a continuous inverse.''',c(PM,'textbookConjugateMap','bp_conjugateMap'),kind='definition',context=['χ为实际Homeomorph，包含正逆连续与双逆律。'])
add('ConjugateIterates','2.4.5',88,[133],r'''Conjugate maps have the property that their iterates are also conjugate, since
\[A^n=(\chi^{-1}\circ B\circ\chi)^n=(\chi^{-1}\circ B\circ\chi)\circ(\chi^{-1}\circ B\circ\chi)\circ\cdots\circ(\chi^{-1}\circ B\circ\chi)=\chi^{-1}B^n\circ\chi.\]''',c(PM,'textbook_conjugate_iterates','conjugateIterates'),prior=['MolecularDynamics.textbook_conjugate_iterates'])
add('ConjugateLimits','2.4.5',88,[134],r'''If $A$ and $B$ are maps of phase space, then the conjugacy implies that they have equivalent stability properties under iteration, since if $B^n(\boldsymbol z_0)\to\boldsymbol z^*$, as $n\to\infty$, for all initial points $\boldsymbol z_0$, then also $A^n(\boldsymbol z_0)\to\chi^{-1}(\boldsymbol z^*)$.''',
'''theorem conjugateLimits (χ : E ≃ₜ E) (A B : E → E) (hA : A=textbookConjugateMap χ B)
    (zStar : E) (hB : ∀ z, Tendsto (fun k : ℕ => B^[k] z) atTop (𝓝 zStar)) :
    ∀ z, Tendsto (fun k : ℕ => A^[k] z) atTop (𝓝 (χ.symm zStar)) := by
  intro z
  apply (MolecularDynamics.textbook_conjugate_iterates_tendsto_iff χ A B hA z (χ.symm zStar)).mpr
  simpa using hB (χ z)''',prior=['MolecularDynamics.textbook_conjugate_iterates_tendsto_iff'])
add('EulerConjugacy','2.4.5',88,[135],'''As an illustration, the Symplectic Euler method turns out to be conjugate to the Verlet method (see Exercise 12). One sometimes refers to the “effective order” of a numerical method as the order attainable via processing, thus the effective order of the Symplectic Euler method would be two.''',proposition('symplecticEulerConjugacy_statement','eulerConjugacy'),context=['χh为半步momentum kick，反向kick是确实逆；有效二阶还依赖Verlet全局二阶，另列缺项。'],missing='半kick的共轭代数可以短证；完整Verlet全局阶理论尚缺。')
add('Processing','2.4.5',88,[136],r'''Let us suppose that we have such a conjugacy between two numerical methods $\mathcal G_h$ and $\tilde{\mathcal G}_h$, that is
\[\mathcal G_h=\chi_h^{-1}\circ\tilde{\mathcal G}_h\circ\chi_h,\]
defined in such a way that $\mathcal G_h$ has order $r$ and $\tilde{\mathcal G}_h$ has order $s<r$. Then, given an initial condition $\boldsymbol z_0$, we first modify (“pre-process”) this to $\tilde{\boldsymbol z}_0=\chi_h(\boldsymbol z_0)$, then take multiple steps with the method $\tilde{\mathcal G}_h$, and finally transform (“post-process”) each obtained point back by $\chi_h^{-1}$.''',c(PM,'textbookProcessedIterate','bp_processedIterate'),kind='definition',context=['G及χ给定真实共轭，定阶r/s是该算法外部资格；定义保存pre/iterate/post全过程。'])
add('ProcessingIterates','2.4.5',88,[137],'''The resulting approximation will be of order $r$ even though the timestepping is performed using a lower order method.''',c(PM,'textbookProcessedIterate_eq_of_conjugacy','processingIterates'),context=['先给出处理算法与高阶方法真实迭代相等；最大误差及阶结论下一项，不以共轭凭空推出r阶。'],prior=['MolecularDynamics.textbookProcessedIterate_eq_of_conjugacy'])
add('ProcessingOrder','2.4.5',88,[138],'''The resulting approximation will be of order $r$ even though the timestepping is performed using a lower order method.''',
'''theorem processingOrder (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (hG : ∀ h, G h=textbookProcessedMethod χ B h) (γ : ℝ → E) (τ : ℝ) (r : ℕ)
    (horder : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError G (τ/ν) γ ν ≤ C*(τ/ν)^r) :
    (∀ h ν, textbookProcessedMaxError χ B h γ ν=oneStepMaxError G h γ ν) ∧
    (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      textbookProcessedMaxError χ B (τ/ν) γ ν ≤ C*(τ/ν)^r) := by
  have heq := MolecularDynamics.textbookProcessedMaxError_eq_of_conjugacy χ B G hG
  refine ⟨fun h ν => heq h γ ν, ?_⟩
  simpa only [heq] using horder''',context=['原文明示G已具有r阶；这是对不同算法迭代的精确误差转移，不把待证processed误差作假设。'],extra=['r自然数有限时间窗误差界；χh为实际Homeomorph。'],prior=['MolecularDynamics.textbookProcessedMaxError_eq_of_conjugacy'])
EXCLUDED += [dict(printed_page='85–89',pdf_page='107–111',reason='任意高阶展望、第3章指引、隐式计算成本/稀疏实现及图2.7流程动机为excluded_qualitative；实际公式、误差与共轭结论已单列。')]

add('EulerEffectiveOrder','2.4.5',88,[],r'''One sometimes refers to the “effective order” of a numerical method as the order attainable via processing, thus the effective order of the Symplectic Euler method would be two.''',
'''theorem eulerEffectiveOrder : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ)
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
  sorry''',extra=['[EXTRA]正固定质量，U C⁴；真实机械Hamilton轨迹及紧时间窗；处理器为实际Homeomorph，完整processed误差界，不以待证二阶作假设。'],missing='实际半kick Homeomorph处理器构造及完整Verlet全局二阶，局部共轭代数条目不能单独证明有效二阶。')

from ch02_data import RECORDS
for r in RECORDS:
    if r['source_id']=='MD-2.4.1-SplittingLocal':
        r['code']=r['code'].split(' := by')[0]+''' := by
  exact MolecularDynamics.exists_hamiltonian_splitting_localError_bound
    D hD H₁ H₂ hH₁ hH₂ F F₁ F₂ u hτ hFD hF₂D hF₁D hF hF₂ hF₁ hc hinit hinit₂ hinit₁'''
    if r['source_id']=='MD-2.4.4-ImplicitLocal':
        r['code']=proposition('implicitLocal_statement','implicitLocal').replace(
          '(∀ y ∈ V, inv y ∈ U ∧ g (inv y) = y)',
          '(∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧ (∀ y ∈ V, inv y ∈ U ∧ g (inv y) = y)')
        r.update(local_verdict='PASS',local_explanation='完整局部唯一逆、正逆律、C¹及局部有界性均保留；原文typically的可逆导数资格逐项[EXTRA]，不宣称任意隐式关系全球可逆。',missing='实际逆函数定理局部Homeomorph、缩小紧邻域及连续逆有界。')
    if r['source_id']=='MD-2.4.5-EulerConjugacy':
        r['code']=proposition('symplecticEulerConjugacy_statement','eulerConjugacy',proof='''intro n m U h
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
    ring''')
        r.update(missing=None,local_explanation='完整实际半kick共轭恒等式已短证；有效二阶单列，不能据此冒充完整二阶误差已证。')
