"""Seven final §3.4 claims, checked against original PDF138–140."""
from ch03_data import add,copied,proposition,D,EXCLUDED
add('AnalyticDefect','3.4',116,[83],r'''It is possible to prove (see discussions in [164, 227] for more detail), that for many standard classes of numerical methods, there are real, positive constants $C,D$ such that
\[\|\mathcal G_h(\cdot)-\mathcal F_h^{(k)}(\cdot)\|\le Ch[D(k+1)h]^{k+1},\]
giving a precise bound on the magnitude of the difference between the time $h$ evolution under the truncated perturbed Hamiltonian and the numerical method.''',proposition('analyticBEA_statement'),
context=[r'$\mathcal F_h^{(k)}$ is the actual truncated Hamiltonian flow, not a formal series.'],
extra=['原文many standard classes未明说正则性；显式H和联合步映射解析、原有smoothSymplecticData及紧域；全阶系数构造与指数截断仍为结论。'],
verdict='NEEDS_HUMAN',explanation='解析资格是补充而非原书明说；一般解析辛方法所需复邻域与统一常数的精确条件待审。',
issues=[dict(code='NEEDS_HUMAN',detail='many standard classes的精确方法类及解析邻域条件原文未给。')],missing='缺解析Hamiltonian jet、Cauchy阶乘界和实际流统一余项；不建设大型BEA理论。')
add('OptimalTruncation','3.4',116,[84],r'''If $h$ is small, then for $k$ sufficiently small the quantity in brackets is less than one and the difference from the truncated approximation decreases in magnitude with increasing $k$. As soon as $k$ satisfies
\[k+1>\frac1{Dh}\]
the power grows monotonically without bound. We can minimize the difference between $\mathcal G_h$ and $\mathcal F_h^{(k)}$ by choosing
\[k=\frac1{Dh\mathrm e}-1,\]
in which case,
\[\|\mathcal G_h(\cdot)-\mathcal F_h^{(k)}(\cdot)\|<Ch\mathrm e^{-\gamma/h},\qquad\gamma=\frac1{D\mathrm e}.\]''',proposition('optimalTruncation_statement'),
context=['Lean k表示原文k+1的整数近似floor(1/(D e h))；本条只给括号幂的整数界，完整实际流指数缺陷在AnalyticDefect。'],
extra=['D>0；足够小正h；取整后允许独立正C吸收误差。'],
verdict='NEEDS_HUMAN',explanation='书中实数最优k与整数截断需量化；幂函数的单调增长阈值也不是导数最小阈值，字面段落与整数界需独立裁定。',issues=[dict(code='NEEDS_HUMAN',detail='连续最优k未必整数；Lean整数界不冒充原文全部连续最小化结论。')],missing='缺整数最优截断与一致指数常数界；原文取整问题待审。')
add('ExponentialFlat','3.4',116,[85],r'''This bound tends to zero extremely rapidly (more rapidly than any power of $h$) as $h\to0$.''',proposition('exponentialFlat_statement'),
context=[r'上式$Ch\exp(-\gamma/h)$；对$\exp(-\gamma/h)/h^k$的极限给每个固定自然数k的更强标量结论。'],extra=['γ>0、h→0⁺；不声称只有C∞就有指数缺陷。'],missing='待短证明：Mathlib exp压过多项式，组合γ/h→∞。')
add('ScalarVerletShadow4','3.4',117,[86],r"""The modified energy for the Verlet method for a single degree of freedom system with energy $H=p^2/2+U(q)$ is
\[\widetilde H_h=H+\frac{h^2}{24}(2p^2U''-(U')^2)
+h^4\left(\frac1{720}p^4U''''-\frac1{120}p^2U'U'''-\frac1{240}(U')^2U''-\frac1{60}p^2((U'')^2+U'U''')\right)+O(h^6).\]""",copied(D,'scalarVerletShadow4'),kind='definition',
context=['原文脚注1；有限式只定义h⁴截断，O(h⁶)系数匹配和实际流余项不从定义证明，关联VerletModifiedMatching。'],
verdict='NEEDS_HUMAN',explanation='有限式定义忠实保留；原文modified energy的O(h⁶)真实性需完整Verlet BCH匹配，不能只凭定义记为已证。',issues=[dict(code='NEEDS_HUMAN',detail='O(h⁶)的实际修正匹配另为未完成理论；有限函数与余项分开。')])
add('CommutingEnergy','3.4',117,[87],r'''Suppose that, somehow, $H$ were exactly conserved along the numerical solution, so
\[\dot H=0\Rightarrow\{H,\widetilde H_h\}=0.\]''',proposition('commutingEnergy_statement'),
context=['解释为由实际修正Hamiltonian流对全部初值守恒推出括号为零；离散快照守恒到连续修正流守恒不能无证混同。'],extra=['H在开放D为C¹、实际K-Hamiltonian流存在正η且全轨道H守恒。'],
verdict='NEEDS_HUMAN',explanation='书中从numerical solution到连续流导数的跳步需审；Lean只保留明确连续流版本，不将离散能量守恒作为连续守恒证明。',issues=[dict(code='NEEDS_HUMAN',detail='离散快照守恒不直接推出连续修正流守恒。')],missing='非PASS不进入证明；连续流版本可以另桥接Lie–Poisson导数。')
add('CommutingEnergySymmetry','3.4',118,[88],r'''Since $\{g_1,g_2\}=-\{g_2,g_1\}$, we have
\[\{\widetilde H_h,H\}=0.\]
This would imply that $\widetilde H_h$ is actually, itself, a first integral of the molecular system.''',proposition('commutingEnergySymmetry_statement'),
context=['K=H̃_h是实际C¹函数；只给已经有{H,K}=0后的独立条件推论，不声称修正无穷级数收敛。'],extra=['开放D、K为C¹、实际H流存在正η。'],missing='待桥接Poisson反对称和沿Hamiltonian曲线常导数。')
add('EnergySymplecticNoGo','3.4',118,[89],r'''This certainly seems unlikely to hold except in very special cases indeed, unless the numerical method happens to coincide with the exact solution (up to a time rescaling). Thus the properties of symplecticness and energy conservation for numerical methods are essentially mutually exclusive from a practical point of view. A more precise formulation of this result was first given by Ge and Marsden [400].''',proposition('energySymplecticNoGo_statement'),
extra=['[EXTRA]noExtraIntegrals明确所有光滑第一积分是H的函数；开放D、全光滑实际流与近恒等辛方法；该强资格原文未列。'],
verdict='NEEDS_HUMAN',explanation='定性no-go不能无条件成立；补全Ge–Marsden所需原理和全局流资格尚待审，忠实保留疑点。',issues=[dict(code='NEEDS_HUMAN',detail='原文practical排他陈述缺精确非可积性/无额外第一积分等假设。')],missing='缺Ge–Marsden精确理论及局部全局资格；不建设大型理论。')
EXCLUDED += [dict(printed_page='116–122',pdf_page='138–144',reason='推荐/警告、double-well及七原子Lennard-Jones数值实验和Fig3.3–3.9为定性或经验观测；能量/势公式复用第1章定义，非新普适定理；数学修正能量脚注已单列。')]

# Reuse only saved, successful proofs whose source and log bytes still agree.
import json,hashlib
from ch03_data import ROOT,BASE,RECORDS
for key in ['ExponentialFlat','CommutingEnergySymmetry']:
    path=BASE/'validation/short_search'/f'{key}.json'
    if not path.exists():continue
    routes=json.loads(path.read_text(encoding='utf-8'))
    target=next(x for x in RECORDS if x['source_id']=='MD-3.4-'+key)
    for result in routes:
        assert hashlib.sha256((ROOT/result['source']).read_bytes()).hexdigest()==result['source_sha256']
        assert hashlib.sha256((ROOT/result['log']).read_bytes()).hexdigest()==result['log_sha256']
        if result['exit_code']==0:
            target['code']=target['code'].replace('by\n  sorry','by\n  '+result['proof'])
            target['missing']=None
            break
    if key=='CommutingEnergySymmetry':
        # Blueprint has its own faithful copied Poisson definition; make the
        # bridge refer explicitly to the unchanged formal-library definition.
        target['code']=target['code'].replace('textbookPoissonBracket',
            'MolecularDynamics.textbookPoissonBracket')
