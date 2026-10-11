"""Thresholds and complete spectral assertions, PDF162–163."""
from ch04_data import add,copied,proposition,D,NS
add('SymplecticEulerStability','4',140,[9],r'''This is the so-called linear stability condition of the Symplectic Euler method: if $h\Omega\le2$ the integrator is stable. When $h\Omega>2$, the eigenvalues of the discretization method are both real, with one strictly inside and one strictly outside the unit circle. This implies that the method will exhibit exponentially growing solutions. We say that the stability threshold of the Symplectic Euler method is $2/\Omega$.''',proposition('symplecticEulerStability_statement'),extra=['[EXTRA]正确的幂有界资格改为0<|hΩ|<2；原≤2字面版独立保留，未声称已审核修复。'],issues=[dict(code='ERRATUM?',detail='≤2端点有单位圆谱但通常Jordan线性增长；幂有界不能包含端点。')],missing='缺二维二次不变量到所有矩阵幂一致界及真实复谱外根桥接；端点错误版另列。')
add('PRKThreshold','4',140,[10],r'''Among explicit symplectic Partitioned Runge-Kutta methods this is the maximum stability threshold [74].''',proposition('prkThreshold_statement'),verdict='NEEDS_HUMAN',explanation='字面普适最大阈值2/Ω保留完整方法参数、阶一一致、显式分区与实际阶段关系；引用文献可能有阶段数/成本/方法类限制，不能凭泛称证明。',issues=[dict(code='NEEDS_HUMAN',detail='原文[74]的方法类限制需要审，未访问引用文献。')],missing='缺明确方法类与阈值定理，不建立PRK稳定性最优理论。')
add('VerletStability','4',141,[11],r'''For example, applying the Verlet method to the harmonic oscillator with frequency $\Omega$ we find that the origin is stable (and the numerical solution stays bounded for all time) provided $h\Omega\le2$ (the same condition as for stability of Symplectic Euler).''',proposition('verletStability_statement'),extra=['[EXTRA]真正幂有界版本0<|hΩ|<2；原文≤2字面版另列待审。'],issues=[dict(code='ERRATUM?',detail='Verlet的hΩ=2矩阵也有Jordan增长，不能以谱模1推出所有轨道有界。')],missing='待由真实二次不变量导出二维矩阵幂一致界，不把一条能量关系当完整稳定性。')
add('SymplecticEulerBoundaryPrinted','4',140,[],r'''if $h\Omega\le2$ the integrator is stable.''',
f'''theorem symplecticEulerBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → {NS}matrixStable ({NS}symplecticEulerMatrix Ω h) := by
  sorry''',verdict='FAIL',explanation='Ω=1,h=2时A=[[-3,2],[-2,1]]=−I+N,N²=0,N≠0；A^k=(−1)^k(I−kN)，对合适非零初值线性增长。',issues=[dict(code='ERRATUM?',detail='原≤2声明的端点反例；不证明FAIL。')],missing='本地FAIL，等待网站/导师裁定端点。')
add('VerletBoundaryPrinted','4',141,[],r'''the numerical solution stays bounded for all time) provided $h\Omega\le2$''',
f'''theorem verletBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → {NS}matrixStable ({NS}verletMatrix Ω h) := by
  sorry''',verdict='FAIL',explanation='Ω=1,h=2时A=[[-1,2],[0,−1]]=−I+N,N²=0；初值(0,1)位置分量模2k，无界。',issues=[dict(code='ERRATUM?',detail='原≤2端点不保证幂有界，单列原文不静默替换。')],missing='本地FAIL，等待网站/导师裁定。')
add('OscillatorSpectrum','4',140,[],r'''The eigenvalues are $\pm i\omega$.''',
f'''theorem oscillatorSpectrum :
    ∀ Ω : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ ({NS}oscillatorMatrix Ω).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ζ=Complex.I*Ω ∨ ζ= -Complex.I*Ω := by
  sorry''',context=['完整真实复特征值与±iΩ，包含Ω=0；原文ω与Ω记号不同。'],missing='有限二维复特征向量/行列式等价桥接尚缺；保留实际谱声明。')
add('SymplecticEulerRoots','4',140,[],r'''The eigenvalues of the matrix are easily found, they are
\[\lambda_{1,2}=1-\frac{h^2\Omega^2}{2}\pm\frac12\sqrt{h^4\Omega^4-4h^2\Omega^2}.\]''',
f'''theorem symplecticEulerRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ ({NS}symplecticEulerMatrix Ω h).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ∃ d : ℂ, d^2=(h^4*Ω^4-4*h^2*Ω^2 : ℝ) ∧
        (ζ=1-(h^2*Ω^2 : ℝ)/2+d/2 ∨ ζ=1-(h^2*Ω^2 : ℝ)/2-d/2) := by
  sorry''',extra=['以任意复平方根d²=判别式表达±，避免未指定复sqrt分支；不是仅特征多项式断言。'],missing='缺二维实际复谱与完整二次根等价的桥接。')
add('SymplecticEulerUnitRoots','4',140,[],r'''Then we observe that for $h^2\Omega^2\le4$, they are complex and their squared magnitude is
\[|\lambda_{1,2}|^2=\left(1-\frac{h^2\Omega^2}{2}\right)^2+\frac14(4h^2\Omega^2-h^4\Omega^4)=1,\]
thus both eigenvalues lie on the unit circle in the complex plane as long as $h\Omega\le2$.''',
f'''theorem symplecticEulerUnitRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ, h^2*Ω^2 ≤ 4 →
      ζ^2-(2-h^2*Ω^2 : ℝ)*ζ+1=0 → ‖ζ‖=1 := by
  sorry''',context=['采用原先明确的平方条件≤4；hΩ≤2没有负步长下界，原通常h,Ω≥0。包含重根边界但不声称幂有界。'],missing='待复根实虚部分和模平方有限代数推导。')
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['SymplecticEulerUnitRoots','OscillatorSpectrum','SymplecticEulerRoots','VerletStability','SymplecticEulerStability'])
# Put the complete Euler bound after its independently checked Verlet/root routes.
# Source IDs, original pages and old mappings stay unchanged.
_euler=next(r for r in RECORDS if r['source_id']=='MD-4-SymplecticEulerStability')
RECORDS.remove(_euler);RECORDS.append(_euler)
