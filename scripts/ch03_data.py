"""Chapter 3 verbatim records. Add only after visually checking original pages."""
import csv
from blueprint_source import ChapterData
_c=ChapterData(3)
ROOT,BASE,RECORDS,EXCLUDED=_c.ROOT,_c.BASE,_c.RECORDS,_c.EXCLUDED
add,copied,proposition=_c.add,_c.copied,_c.proposition
OLD_ROWS=list(csv.DictReader((ROOT/'docs/review/CH03_CLAIMS.csv').open(encoding='utf-8-sig')))
D='MolecularDynamics/Chapter03/ReviewDefinitions.lean'
L='MolecularDynamics/Chapter03/LiePoisson.lean'

add('ModifiedConstruction','3',97,[1],r'''We can express the fundamental consequence as follows: not only are Hamiltonian flow maps symplectic, but also near-identity symplectic maps are (in an approximate sense) Hamiltonian flow maps [31]. The fact leads to the existence of a modified (perturbed) Hamiltonian from which the discrete trajectory may be derived (as snapshots of continuous trajectories). In some cases we may derive this perturbed Hamiltonian as an expansion in powers of the stepsize.''',
proposition('modifiedConstruction_statement'),
context=[r'The starting point is that symplectic integrators are symplectic maps that are “near to the identity” since they depend on a parameter (the stepsize $h$) which can be chosen as small as needed, and, if consistent, in the limit $h\to0$, such a map must tend to the identity map.'],
extra=['近恒等、光滑、阶r≥1用smoothSymplecticData实际定义表达：开放凸D、紧凸B⊆D、H及(h,z)↦G_h(z)无限可微、G₀=id、逐h辛、实际原始ODE流和局部阶。',
       '按任意有限截断匹配解释“in an approximate sense”；不将形式无限级数当实际收敛解，不将finiteMatching结论作前提。'],
missing='缺形式jet的Hamiltonian构造、逐阶匹配及实际截断ODE的统一余项；属于大型向后误差分析理论，保留sorry。')
add('AdjointEulerOscillator','3.1',98,[2],r'''Let us begin with an illustrative example. Consider the harmonic oscillator with frequency $\Omega$ which has Hamiltonian $H(q,p)=p^2/2+\Omega^2q^2/2$, and consider the adjoint symplectic Euler method
\[Q=q+hp,\qquad P=p-h\Omega^2Q,\]''',copied(D,'oscillatorAdjointEuler'),kind='definition',
context=[r'$q,p,Q,P,h,\Omega\in\mathbb R$；$H(q,p)=(p^2+\Omega^2q^2)/2$。'])
add('ShadowHamiltonian','3.1',98,[3],r'''However, if we modify the Hamiltonian from $H(q,p)=p^2/2+\Omega^2q^2/2$ to
\[\widetilde H(q,p)=\frac{p^2+h\Omega^2pq+\Omega^2q^2}{2},\tag{3.1}\]''',copied(D,'oscillatorShadow'),kind='definition',label='(3.1)',context=[r'同页$Q=q+hp$、$P=p-h\Omega^2Q$。'])
add('EnergyFailure','3.1',98,[4],r'''If $H(q,p)=E$, then, for typical steps, we cannot expect $H(Q,P)=E$. (Just insert the formulas for $Q$ and $P$ into the Hamiltonian and check that the value is not the same as $H(q,p)$.)''',
'''theorem oscillatorEnergyFailure :
    ∃ Ω h : ℝ, 0 < Ω ∧ h ≠ 0 ∧ ∃ z : ℝ × ℝ,
      oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z) ≠ oscillatorEnergy Ω z := by
  refine ⟨1, 1, by norm_num, by norm_num, (1,0), ?_⟩
  exact MolecularDynamics.Chapter03Review.oscillatorEnergyFailure_proved''',
context=[r'同页$H(q,p)=(p^2+\Omega^2q^2)/2$，$Q=q+hp$、$P=p-h\Omega^2Q$。'],
explanation='原文一般不守恒按存在实反例表达，不误称所有初值都不守恒；Ω=h=1,z=(1,0)给具体反例。',
prior=['MolecularDynamics.Chapter03Review.oscillatorEnergyFailure_proved'])
add('ShadowInvariant','3.1',99,[5],r'''This means that $\widetilde H$ is a conserved quantity of the numerical method.''',
proposition('oscillatorShadowInvariant_statement',proof='exact MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_proved'),
context=[r'$\widetilde H$及adjoint symplectic Euler见p.98/PDF120。'],
proof=r'''\[\begin{aligned}\widetilde H(Q,P)&=\frac{P^2}{2}+\frac{h\Omega^2PQ}{2}+\frac{\Omega^2Q^2}{2}\\
&=\frac12p^2-\frac{h\Omega^2pQ}{2}+\frac{\Omega^2Q^2}{2}\\&=\widetilde H(q,p).\end{aligned}\]''',
prior=['MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_proved'])
add('ShadowEllipses','3.1',99,[6],r'''Recall that the graph of
\[\frac{x^2}{a^2}+\frac{y^2}{b^2}=1\]
is an ellipse with major and minor axes aligned to the coordinate axes. If $\epsilon$ is a small value, then,
\[\frac{x^2}{a^2}+\frac{y^2}{b^2}+\epsilon xy=1\]
will be a slightly rotated ellipse (with slightly different major and minor axes). Thus we can think of the energy surface of the numerical method as being a small perturbation of the ellipse which represents the ‘energy surface’ (energy curve, in this case) of the harmonic oscillator itself.''',
'''theorem shadowEllipses :
    (∀ a b : ℝ, a ≠ 0 → b ≠ 0 →
      ∃ δ > 0, ∃ θ A B : ℝ → ℝ,
        Tendsto A (𝓝 0) (𝓝 |a|) ∧ Tendsto B (𝓝 0) (𝓝 |b|) ∧
        (∀ ε ∈ Ioo (-δ) δ, 0 < A ε ∧ 0 < B ε ∧ ∀ x y : ℝ,
          x^2/a^2+y^2/b^2+ε*x*y =
            (Real.cos (θ ε)*x+Real.sin (θ ε)*y)^2/(A ε)^2+
            (-Real.sin (θ ε)*x+Real.cos (θ ε)*y)^2/(B ε)^2)) ∧
    (∀ Ω h : ℝ, 0 < Ω → |h*Ω| < 2 →
      (∀ z : ℝ × ℝ, z ≠ 0 → 0 < oscillatorShadow Ω h z) ∧
      ∃ L : (ℝ × ℝ) ≃ₗ[ℝ] (ℝ × ℝ), ∀ z,
        oscillatorShadow Ω h (L z)=(z.1^2+z.2^2)/2) := by
  sorry''',
context=[r'$a,b\ne0$；小扰动一般二次曲线作为背景；本条完整原文的泛型二次曲线尚需与Lean振子特例统一。',r'$\widetilde H$见p.98/PDF120；正能量水平集。'],
extra=['显式Ω>0、|hΩ|<2，排除退化与不稳定步长；线性等价给出振子二次型标准形。'],
verdict='NEEDS_HUMAN',explanation='Lean同时保留一般a,b,ε二次曲线旋转及轴长连续性、振子正定与线性标准形；“slightly rotated”的角度趋零在a=b退化主轴时不成立，字面定量含义仍需裁定，不能记PASS。',
issues=[dict(code='NEEDS_HUMAN',detail='一般a,b,ε椭圆旋转与振子特例之间仍需完整统一；不以特例冒充全部结论。')],
missing='需一般正定二维二次型的轴长/旋转、小扰动连续性及与振子参数的完整对应；本地非PASS不进入证明。')
add('EulerGrowth','3.1',100,[7],'''Obviously this conservation property (the existence of a perturbed energy surface) is a special feature of the method we have considered. If we used Euler’s method to solve the harmonic oscillator we would find that energy grows without bound.''',
proposition('eulerOscillatorGrowth_statement',proof='''intro Ω h hΩ hh z hz
  have hfactor : 1 < 1+h^2*Ω^2 := by
    have hp := mul_pos (sq_pos_of_ne_zero hh) (sq_pos_of_ne_zero hΩ)
    linarith
  have hstep : ∀ w, oscillatorEnergy Ω (oscillatorEuler Ω h w) =
      (1+h^2*Ω^2)*oscillatorEnergy Ω w := by
    intro w
    simp only [oscillatorEnergy, oscillatorEuler]
    ring
  have hiter : ∀ ν : ℕ, oscillatorEnergy Ω ((oscillatorEuler Ω h)^[ν] z) =
      (1+h^2*Ω^2)^ν*oscillatorEnergy Ω z := by
    intro ν
    induction ν with
    | zero => simp
    | succ ν ih =>
      rw [Function.iterate_succ_apply', hstep, ih, pow_succ]
      ring
  simpa only [hiter] using
    (tendsto_pow_atTop_atTop_of_one_lt hfactor).atTop_mul_const hz'''),context=[r'振子及原始能量见p.98/PDF120；Euler为$(q+hp,p-h\Omega^2q)$。'],
extra=['Ω≠0、固定h≠0且初始能量>0，排除平衡点和零步长。'])
add('FormalHamiltonian','3.1',100,[8],r'''Now consider the more general Hamiltonian setting. Let $\mathcal G_h$ be a $r$th order symplectic integrator, $r\ge1$. Suppose that it is the flow map of a certain Hamiltonian system, with Hamiltonian $\widetilde H_h$. If the method order is $r$, we may expect this Hamiltonian to be a $O(h^r)$ approximation of $H$, thus we posit an expansion of the form
\[\widetilde H_h=H+h^rH^{(r)}+h^{r+1}H^{(r+1)}+\cdots.\]''',
copied(D,'formalHamiltonian'),kind='definition',context=[r'$r\ge1$；$H^{(j)}$为待确定光滑系数函数；h为形式变量而不是级数收敛参数。'],
explanation='仅定义原文所设形式展开；实际近似流的存在另列ModifiedConstruction，未借定义宣称向后误差理论成立。')
add('FormalHamiltonianField','3.1',100,[9],r'''To determine the terms $H^{(r)},H^{(r+1)},\ldots$, we write the differential equations on $\widetilde H_h$:
\[\dot{\boldsymbol z}=J\nabla H+h^rJ\nabla H^{(r)}+h^{r+1}J\nabla H^{(r+1)}+\cdots.\]''',
copied(D,'formalHamiltonianField'),kind='definition',context=[r'$r\ge1$；形式Hamiltonian见同页上段；每个系数取真实$J\nabla H^{(j)}$，不把无穷级数当收敛ODE。'],
discussion='The solution of this system can be expanded in powers of h and equated term-by-term with the expansion of G_h in powers of h. In this way, successive terms may be computed. Although mechanical, this procedure is tedious.')
EXCLUDED += [dict(printed_page='97–98',pdf_page='119–120',reason='导论误差比较、替代结构、文献历史、数值方法选择为定性背景；数学近恒等断言已单列。'),
dict(printed_page='99–100',pdf_page='121–122',reason='图3.1及Ω=h=1的六点数值轨道作为实验插图，excluded_qualitative；不将图像观测作为普适定理。')]

import ch03_section32
import ch03_section32b
import ch03_section33
import ch03_section33b
import ch03_section33c
import ch03_section33d
import ch03_section33e

# Reuse the bounded local algebra search only when its saved compiler evidence
# and exact generated source are unchanged. This never changes formal sources.
import json,hashlib
route_path=BASE/'validation/short_search/StrangCubic.json'
if route_path.exists():
    routes=json.loads(route_path.read_text(encoding='utf-8'))
    target=next(r for r in RECORDS if r['source_id']=='MD-3.3.2-StrangCubic')
    for route in routes:
        assert hashlib.sha256((ROOT/route['source']).read_bytes()).hexdigest()==route['source_sha256']
        assert hashlib.sha256((ROOT/route['log']).read_bytes()).hexdigest()==route['log_sha256']
        if route['exit_code']==0:
            target['code']=target['code'].replace('by\n  sorry','by\n  '+route['proof'])
            target['missing']=None
            break
    else:
        if len(routes)>=3:target['missing']='三条有限系数证明路线失败，已停止；证据见validation/short_search/StrangCubic.json。'
import ch03_section34
import ch03_section34b
import ch03_section34c
import ch03_section35
import ch03_section35b
import ch03_section36
import ch03_section36b
import ch03_section36c
import ch03_section36d
import ch03_section37
import ch03_section37b
import ch03_section37c
