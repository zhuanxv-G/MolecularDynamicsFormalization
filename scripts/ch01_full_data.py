"""Hand-transcribed Chapter 1 records. Never edits the formal library.

Transcriptions are checked against tmp/ch01_full/pdfNNN.png, not CSV paraphrases.
Each call is one complete source definition or conclusion; old IDs are coverage links.
"""
from pathlib import Path
import json, re, hashlib, csv

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT/'blueprint/ch01'
RECORDS = []
EXCLUDED = {}

def block(file, name):
    text=(ROOT/file).read_text(encoding='utf-8-sig')
    m=re.search(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem) '+re.escape(name)+r'\b', text)
    if not m: raise ValueError((file,name))
    rest=text[m.start():]
    end=re.search(r'\n(?:/--|/-!|(?:noncomputable )?(?:def|abbrev|theorem|lemma|end)\b)',rest)
    return rest[:end.start() if end else len(rest)].strip()

def definition(name):
    code=block('MolecularDynamics/Chapter01/ReviewDefinitions.lean',name)
    return re.sub(r'^(def|abbrev) '+name, 'def '+name, code)

def prop(name):
    return block('MolecularDynamics/Chapter01/Statements.lean',name).split(':=',1)[1].strip()

def theorem_type(file,name):
    header=block(file,name).split(':=',1)[0]
    rest=re.sub(r'^theorem '+name+r'\s*','',header)
    depth=0
    for i,c in enumerate(rest):
        if c in '({[': depth+=1
        if c in ')}]': depth-=1
        if c==':' and depth==0:
            args,conclusion=rest[:i].strip(),rest[i+1:].strip()
            return ('∀ '+args+',\n    ' if args else '')+conclusion
    raise ValueError(header)

def add(key, section, pages, old, statement, code, *, kind='definition', label=None,
        proof=None, context=(), extra=(), issue=None, verdict='PASS', explanation=None,
        prior=(), missing=None):
    sid='MD-'+section+'-'+key
    name=re.search(r'\b(?:theorem|def)\s+(\w+)',code).group(1)
    if isinstance(pages,int): pages=str(pages)
    nums=[int(x) for x in re.findall(r'\d+',pages)]
    pdf='–'.join(str(x+23) for x in nums)
    RECORDS.append(dict(source_id=sid,kind=kind,label=label,section=section,
        printed_page=pages,pdf_page=pdf,statement_latex=statement,proof_latex=proof,
        proof_note='原书无独立完整证明。' if proof is None else '按渲染原页逐字转录原文论证。',
        context_notation=list(context),review_status='DRAFT',issues=[] if issue is None else
        [dict(code='ERRATUM?',status='NEEDS_HUMAN',detail=issue)],
        lean_decl='MD.Ch01.'+name,extra_assumptions=list(extra),repair_log=[],
        old_ids=['CH01-'+str(n).zfill(3) for n in old],code=code,
        local_verdict=verdict,local_explanation=explanation or
        '逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。',
        priors=list(prior),missing=missing))

def exclude(ids,reason):
    for i in ids: EXCLUDED['CH01-'+str(i).zfill(3)]=reason

add('Schrodinger','1.1',5,range(1,7),r'''The Schrödinger equation itself is a partial differential equation of the following form:
\[i\hbar\frac{\partial\Phi}{\partial t}=-\hbar^2\sum_{j=1}^{13}\frac{1}{2\mu_j}\left(\frac{\partial^2\Phi}{\partial q_{j,x}^2}+\frac{\partial^2\Phi}{\partial q_{j,y}^2}+\frac{\partial^2\Phi}{\partial q_{j,z}^2}\right)+U_P(q_{1,x},q_{1,y},\ldots,q_{13,z})\Phi.\tag{1.1}\]''',
    definition('schrodingerEquation'),context=[r'$\Phi:\mathbb R\times\mathbb R^{39}\to\mathbb C$；$i^2=-1$；$\hbar$为Planck常数；$\mu_j$为第$j$粒子质量；$U_P$为原始原子势能。13粒子来自10电子+3核水分子示例。'],
    extra=['Lean质量及Planck常数以正参数给定；定义采用总导数算子，仅定义满足方程的关系，不声明存在解。'])
add('NewtonModel','1.1',6,[7,8,9],r'''where the forces are determined from the potential energy function $U$. Denoting the coordinates of the $i$th nucleus of an N-atom system by $q_{i,x},q_{i,y},q_{i,z}$, and the atomic mass by $m_i$, the equations of motion for the nucleus can be written out as
\[m_i\frac{\mathrm d^2q_{i,x}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,x}},\qquad m_i\frac{\mathrm d^2q_{i,y}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,y}},\qquad m_i\frac{\mathrm d^2q_{i,z}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,z}}.\tag{1.2}\]
It is important to recognize that (1.2) does not, itself, give a complete description of the motion; it must be supplemented by initial conditions (positions and velocities given at some specified instant) for all atoms.''',
    '''def newtonInitialValueModel {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (q : ℝ → Position n) (t₀ : ℝ)
    (q₀ v₀ : Position n) : Prop :=
  IsNewtonTrajectoryOn m U Q I q ∧ q t₀ = q₀ ∧ HasDerivAt q v₀ t₀''',
    context=[r'$U=U_{BO}$仅依赖核位置；$n=3N$，每粒子质量重复三次。'],extra=['n为展平坐标数；三维实例n=3N，质量限制通过coordinateMassesOfParticles给出。'])
add('HardSphere','1.1',7,[10],'''The simplest model for a molecular interaction potential is the hard-sphere model. We assume that each atom is an impenetrable sphere which interacts with other atoms via perfectly elastic collision with the atoms transferring, according to standard rules, momentum and energy to one another during the collisions.''',
    '''def hardSphereModel (R₁ R₂ m₁ m₂ : ℝ) (q₁ q₂ v₁ v₂ w₁ w₂ : V3) : Prop :=
  0 < R₁ ∧ 0 < R₂ ∧ 0 < m₁ ∧ 0 < m₂ ∧ R₁ + R₂ ≤ dist q₁ q₂ ∧
  (dist q₁ q₂ = R₁ + R₂ →
    m₁ • v₁ + m₂ • v₂ = m₁ • w₁ + m₂ • w₂ ∧
    m₁ * ‖v₁‖^2 / 2 + m₂ * ‖v₂‖^2 / 2 = m₁ * ‖w₁‖^2 / 2 + m₂ * ‖w₂‖^2 / 2)''',
    extra=['只编码不可穿透与完全弹性守恒关系；原文未指定碰撞散射规则，此定义不唯一决定碰撞后速度。'],verdict='NEEDS_HUMAN',explanation='原文standard rules含方向/法向冲量等未明说内容；当前关系保留不可穿透和两守恒量，但尚不能据此声称完整散射模型。')
add('Multibody','1.1.1',8,[11,12,13,14],r'''In the most common situations, the potential energy function consists of a sum of 2-body, 3-body and/or 4-body terms,
\[U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\qquad U_{ijk}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k),\qquad U_{ijkl}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k,\boldsymbol q_l),\]
where $\boldsymbol q_i$ is the position vector of atom $i$ such that $(q_{i,x},q_{i,y},q_{i,z})=\boldsymbol q_i\in\mathbb R^3$.''',
    '''def multibodyPotential {N : ℕ} (U₂ : Fin N → Fin N → V3 → V3 → ℝ)
    (U₃ : Fin N → Fin N → Fin N → V3 → V3 → V3 → ℝ)
    (U₄ : Fin N → Fin N → Fin N → Fin N → V3 → V3 → V3 → V3 → ℝ)
    (q : Fin N → V3) : ℝ :=
  (∑ i, ∑ j ∈ Finset.Ioi i, U₂ i j (q i) (q j)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, U₃ i j k (q i) (q j) (q k)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, ∑ l ∈ Finset.Ioi k,
    U₄ i j k l (q i) (q j) (q k) (q l))''',extra=['按无序不同粒子组计数i<j<k<l；原文仅列成分未指定求和计数约定。'])
add('Morse','1.1.1',8,[15],r'''A simple potential energy function whose graph can be used to approximate the potential energy of bond dissociation is the Morse potential
\[\varphi_{\mathrm{Morse}}(r)=D\left(1-e^{-a(r-r_e)}\right)^2.\]''',definition('morsePotential'),context=[r'$D,a,r_e>0$为物理参数；$r>0$为核距离。'])
add('MorseMinimum','1.1.1',8,[16],r'''(See Fig. 1.5.) $r_e$ is the location of the minimum, $D$ gives the well depth, and $a$ is a shape parameter that can be used to control the curvature at the minimum.''',
    'theorem morse_minimum :\n  '+prop('morseMinimum_statement')+' := by\n  sorry',kind='unnumbered_claim',extra=['D,a,rₑ正；well depth解释为无穷远极限减最小值。'],missing='指数无穷远极限及严格最小值/曲率完整对应待补。',verdict='NEEDS_HUMAN',explanation='已保留最小值和井深；原文还提到a控制曲率，当前签名未含二阶导数，须补齐后进入证明。')
add('LengthBond','1.1.1',9,[17,18],r'''Because they often do not need to be allowed to break during simulation and are very strong compared to the other potential terms, chemical bonds such as the covalent $\mathrm H_2^+$ bond described above are sometimes treated as springs with given rest-length:
\[\varphi_{ij}^{\mathrm{len}}(r_{ij})=\frac{k_{ij}^{\mathrm{len}}}{2}(r_{ij}-r_{ij}^0)^2,\qquad r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|.\]''',definition('lengthBond'),context=[r'$r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|$；Lean pairDistance；$k>0$，$r_0$静长。'])
add('Dispersion','1.1.1',10,[19],r'''This leads to an instantaneous polarization and an attractive interaction termed London dispersion; it is most often modelled using an inverse sixth power potential:
\[\varphi_{\mathrm{disp}}(r)\sim-\frac K{r^6},\qquad K>0.\]''',definition('dispersionPotential'),context=[r'$r>0$；$\sim$表示经验模型形式，此def只定义右侧模型。'])
add('Buckingham','1.1.1',10,[20],r'''Buckingham [56] suggested a combined potential of the form
\[\varphi_B(r)=Ae^{-Br}-\frac C{r^6},\qquad A>0,\ B>0,\ C>0.\]''',definition('buckinghamPotential'),context=[r'$r>0$；参数正。'])
add('LennardJones','1.1.1',10,[21],r'''A more common choice in simulation is the Lennard-Jones (6–12) potential
\[\varphi_{\mathrm{LJ}}(r)=4\epsilon\left[\left(\frac\sigma r\right)^{12}-\left(\frac\sigma r\right)^6\right].\]''',definition('lennardJonesPotential'),context=[r'$\epsilon,\sigma,r>0$。'])
add('LJRepulsion','1.1.1',11,[22,198],r'''of short-ranged soft walls in molecular dynamics, i.e., the fact that $\varphi_{\mathrm{LJ}}$ tends rapidly to positive infinity as $r\to0$, the atoms remain well separated in long simulations. The singularity at $r=0$ is therefore rarely encountered in dynamics trajectories, however the presence of the singularity may nonetheless create problems for mathematical analysis, as many theoretical techniques rely on assumed smoothness.''',
    'theorem lj_repulsion :\n  '+prop('lennardJonesSingularity_statement')+' := by\n  sorry',kind='unnumbered_claim',context=['p.10末句开头为Because of the strongly repulsive character，当前引用从p.11延续部分开始；定性模拟经验不等同严格无碰撞定理。'],verdict='NEEDS_HUMAN',explanation='数学极限对应原文论据；atoms remain well separated为定性模拟描述，须裁定是否作为严格无碰撞结论。',missing='忠实范围待裁定；单侧有理函数极限可另行短证明。')
add('HeterogeneousLJ','1.1.1',11,[23],r'''When there are many atoms of different types, the parameters of the potential will depend on this, so we obtain contributions to the total potential energy of the form
\[\varphi_{ij}^{\mathrm{LJ}}(r_{ij})=4\epsilon_{ij}\left[\left(\frac{\sigma_{ij}}{r_{ij}}\right)^{12}-\left(\frac{\sigma_{ij}}{r_{ij}}\right)^6\right],\]
where $r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|$.''',definition('heterogeneousLJ'))
add('Coulomb','1.1.2',12,[24,25],r'''When, as in the case of the alanine dipeptide, net charges are present on the atoms, one may model this by means of Coulomb potentials:
\[\varphi_{ij}^{\mathrm{Coulomb}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}},\]
where $\epsilon>0$ is the dielectric constant, and $Q_i,Q_j$ are the charges on atoms $i$ and $j$, respectively. $C$ is a positive coefficient allowing the adjustment of units. Obviously the effect of the Coulombic potential depends strongly on whether the atoms have the same or oppositely signed charges.''',definition('coulombPotential'),context=['不同电荷符号的影响是定性背景；原页没有旧清单声称的导数符号定理。'])
add('Cutoff','1.1.2',12,[26],r'''In the simplest treatments, the Coulomb potential is simply cut off at distance $r_{\mathrm{cut}}$, i.e., is taken to be zero for $r>r_{\mathrm{cut}}$. This should be done in such a way that the potential remains at least continuously differentiable, preferably smoother (see Exercise 11).''',definition('smoothCutoff'))
add('Yukawa','1.1.2',12,[27],r'''More accurate treatments of the long range behavior include the use of an exponential term involving the Debye length $\kappa$ which models screening due to the presence of a polar solvent, in which case the potential is modified to have the form of a Yukawa potential:
\[\varphi_{ij}^{\mathrm{screened}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}}e^{-\kappa r_{ij}}.\]''',
    '''def yukawaScreened (C Qᵢ Qⱼ dielectric κ r : ℝ) : ℝ :=
  C * Qᵢ * Qⱼ / (dielectric * r) * Real.exp (-κ * r)''',context=['保留原文κ；不把指数改成-r/κ。原文称Debye length但式子以逆长度参数使用，待导师判断。'],issue='原文κ称Debye length，但e^{-κr}的量纲通常对应逆长度；本定义保留字面公式。')
add('AngleBond','1.1.2',13,[28,29],r'''When a trio of atoms with labels $i,j,k$ and $k$ admits a pair of length bonds, say $(i,j)$ and $(j,k)$, then an additional three-body term will need to be incorporated:
\[\varphi_{ijk}^{\mathrm{ang}}=\frac{k_{ijk}^{\mathrm{ang}}}{2}(\theta_{ijk}-\theta_{ijk}^0)^2,\]
where the angle $\theta_{ijk}$ is given in terms of the positions as
\[\theta_{ijk}=\arccos\frac{(\boldsymbol q_i-\boldsymbol q_j)\cdot(\boldsymbol q_j-\boldsymbol q_k)}{r_{ij}r_{jk}}.\]''',
    '''def angleBondModel (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3) : ℝ :=
  k / 2 * (Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) /
    (‖qᵢ-qⱼ‖ * ‖qⱼ-qₖ‖)) - θ₀)^2''',context=['k正、两键长非零；保留原页(qᵢ-qⱼ)·(qⱼ-qₖ)方向及重复and k。'])
add('Dihedral','1.1.2',13,[30],r'''Dihedral potentials typically are modelled using a trigonometric potential function, as
\[\varphi_{ijkl}^{\mathrm{dih}}=k_{ijkl}^{\mathrm{dih}}[1+\cos(n_{ijkl}^{\mathrm{dih}}\eta_{ijkl}-d_{ijkl}^{\mathrm{dih}})].\]''',definition('dihedralPotential'),context=['η位置角的通用转换公式原文未给；角作为参数。'])
exclude([31,32,33,34],'excluded_qualitative：p.14–16分别介绍Stillinger–Weber/EAM/Bond Order/United atom模型与用途，未给确定函数或可检验数学量词；不把旧参数化模板当作原文公式。')
add('GayBerne','1.1.2','16–17',range(35,44),r'''The potential energy may be written as
\[\varphi_{\mathrm{GB}}(\boldsymbol q_1,\boldsymbol q_2,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=4\epsilon_{\mathrm{GB}}\left[\left(\frac{\sigma_0}{\Delta}\right)^{12}-\left(\frac{\sigma_0}{\Delta}\right)^6\right],\]
\[\epsilon_{\mathrm{GB}}(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2),\]
with
\[\Delta(\boldsymbol r,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\|\boldsymbol r\|-\sigma_0/\sqrt{W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)},\]
\[\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_0[1-\chi^2(\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2)^2]^{-1/2},\qquad\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi'),\]
and
\[W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)\stackrel{\mathrm{def}}=1-\frac\chi2\left[\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1+\hat{\boldsymbol u}_2))^2}{1+\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}+\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1-\hat{\boldsymbol u}_2))^2}{1-\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}\right].\]
Finally
\[\chi=\frac{[\sigma_e/\sigma_s]^2-1}{[\sigma_e/\sigma_s]^2+1},\qquad\chi'=\frac{1-[\epsilon_e/\epsilon_s]^{1/\mu}}{1+[\epsilon_e/\epsilon_s]^{1/\mu}}.\]''',
    '''def gayBerneModel (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : ℝ :=
  let r := q₂ - q₁
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  let Δ := ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
  let εGB := gayBerneEpsilonOne ε₀ χ u₁ u₂ * gayBerneEpsilonTwo (‖r‖⁻¹ • r) u₁ u₂ χ'
  4 * εGB * ((σ₀ / Δ)^12 - (σ₀ / Δ)^6)''',
    label='Example 1.2',context=[r'$\boldsymbol r=\boldsymbol q_{12}=\boldsymbol q_2-\boldsymbol q_1$；$\hat{\boldsymbol r}=\boldsymbol r/\|\boldsymbol r\|$；两取向单位向量；各根号正、分母非零。', '放大PDF39原页确认εGB=ε1ε2，无平方；旧库gayBerneWell有ε2²，不能桥接，Blueprint保留忠实公式。'],prior=['ReviewDefinitions.gayBerneChi/ChiPrime/W/EpsilonOne/EpsilonTwo'],explanation='逐项展开辅助定义核对所有8个公式；不复用旧gayBernePotential，其ε2平方与原页不一致。')

def bridge(key,section,pages,old,statement,file,name,*,proof=None,extra=(),context=(),issue=None,verdict='PASS',explanation=None):
    local=re.sub(r'\W','_',key).lower()
    code='theorem '+local+' :\n  '+theorem_type(file,name)+' := by\n  exact @MolecularDynamics.'+name
    add(key,section,pages,old,statement,code,kind='unnumbered_claim',proof=proof,extra=extra,context=context,issue=issue,verdict=verdict,
        explanation=explanation or '展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。',prior=[file+':'+name])

def stated(key,section,pages,old,statement,name,*,proof=None,extra=(),context=(),issue=None,verdict='PASS',missing=None):
    local=re.sub(r'\W','_',key).lower()
    add(key,section,pages,old,statement,'theorem '+local+' :\n  '+prop(name)+' := by\n  sorry',kind='unnumbered_claim',proof=proof,extra=extra,context=context,issue=issue,verdict=verdict,
        missing=missing,explanation='逐项核对展开后的陈述、真实定义、量词及[EXTRA]；'+('原文疑点保留，待导师裁定。' if issue else '语义本地通过，证明尚未完成。'))

add('NewtonCompact','1.2',18,[44,45,46,47,48,49,50],r'''In this book, we shall frequently use a compact, vectorial notation, where $\boldsymbol q$ and $\dot{\boldsymbol q}$ represent vectors of the positions and velocities, and $\boldsymbol M$ is a diagonal mass matrix, so the equations of motion (1.2) become
\[\boldsymbol M\frac{\mathrm d^2}{\mathrm dt^2}\boldsymbol q=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q).\tag{1.3}\]''',
    '''def compactNewton {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : ℝ → Position n) (t : ℝ) : Prop :=
  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
  massOperator m (deriv (deriv q) t) = -gradient U (q t)''',context=[r'$N_c=3N$；$\boldsymbol M=\operatorname{diag}(m_1,m_1,m_1,\ldots,m_N,m_N,m_N)$；一维时$N_c=N$。'],extra=['真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。'])
add('DegreesFreedom','1.2',18,[51],r'''The number of local directions in which the configurational (position) state can be varied is called the number of degrees of freedom $N_d$.''',definition('degreesOfFreedom'),extra=['在可微约束C局部正则层中以导数核维数表示；无约束取零约束。'])
stated('ConstraintDimension','1.2',18,[52],r'''For the N-body system in $\mathbb R^3$ without additional constraints there are $N_d=N_c=3N$ degrees of freedom. If $r$ independent constraints are present the number of degrees of freedom is $N_d=N_c-r$.''','constraintDimension_statement',extra=['约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。'],missing='有限维rank-nullity接口适配，计划短证明。')
add('TotalEnergy','1.2',18,[53,54,57],r'''The total energy of the N-body system is a function of positions and velocities,
\[E(\boldsymbol q_1,\ldots,\boldsymbol q_N,\dot{\boldsymbol q}_1,\ldots,\dot{\boldsymbol q}_N)=\sum_{j=1}^{N}\frac{m_j\|\dot{\boldsymbol q}_j\|^2}{2}+U(\boldsymbol q_1,\ldots,\boldsymbol q_N).\tag{1.4}\]''',
    '''def particleTotalEnergy {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → V3) → ℝ)
    (q v : Fin N → V3) : ℝ := (∑ j, m j * ‖v j‖^2 / 2) + U q''',context=['斜体E为函数，直立E为守恒能量值；动能是有限和。'])
stated('PairCancellation','1.2',19,[58],r'''This means that the sum of all the forces will vanish.''','pairForceCancellation_statement',context=['前文Newton第三定律：i作用j的力是j作用i的力的exact negative。'],extra=['Fi i=0，内部两体力反对称；无外力。'],missing='有限双重求和与反对称消去，计划短证明。')
bridge('MomentumConservation','1.2',19,[59,60,61],r'''and thus the three components of the total momentum vector $\boldsymbol p_{\mathrm{tot}}:=\sum_{i=1}^{N}\boldsymbol p_i$ will be conserved quantities.''','MolecularDynamics/Chapter01/MomentumConservation.lean','totalMomentumCoordinate_const_on_Ioo',
    proof=r'''Since
\[\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\boldsymbol F_i,\]
we have
\[\sum_{i=1}^{N}\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\sum_{i=1}^{N}\boldsymbol F_i=0\]''',context=['p=m qdot，三维d=3，任意d为推广；IsMechanicalSolutionOn是真正时间微分方程。'],extra=['开放连通时间区间；净力为零来自前文内部力消去，此桥接显式采用净力条件。'])
bridge('HarmonicSolution','1.2','19–20',[62,63],r'''Example 1.3 (Harmonic Oscillator) Consider the system
\[\dot x=v,\qquad\dot v=-\Omega^2x.\]
This system describes the behavior of a particle with unit mass in one dimension, with energy function $E(x,\dot x)=\dot x^2/2+\Omega^2x^2/2$, where its motion is governed by a linear 2nd order equation $\ddot x+\Omega^2x=0$. The solution, for given $x(0)=\xi$, $\dot x(0)=v(0)=\eta$, is
\[x(t)=\xi\cos(\Omega t)+\frac\eta\Omega\sin(\Omega t).\]''','MolecularDynamics/Chapter01/HarmonicOscillator.lean','harmonicFlow_isMechanicalSolution',context=['harmonicFlow同时给出位置与实际动量/速度；harmonicFlow_zero保证初值。'],extra=['Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。'])
add('ScalarMechanical','1.2',20,[64],r'''Example 1.4 (Single Degree of Freedom) Consider a simple system with a single degree of freedom (with unit mass $m=1$ for simplicity) and energy function $E(x,\dot x)=\dot x^2/2+U(x)$ (which includes the harmonic oscillator as a special case). The equations of motion are
\[\dot x=v,\qquad\dot v=-\frac{\partial U}{\partial x}.\]''',
    '''def scalarMechanicalModel (U : ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  ∀ t, HasDerivAt z ((z t).2, -deriv U (z t).1) t''',context=['scalarPotentialEnergy U z = z.2²/2+U z.1；定义方程不宣称解存在。'])
bridge('ScalarQuadrature','1.2',20,[65,66],r'''Near this point, provided $\eta\ne0$, let us solve the equation $E(x,v)=E(\xi,\eta)$ for $v$ as a unique smooth function of $x,\xi,\eta$ using the implicit function theorem: $v=V(x,\xi,\eta)$. Inserting this into the differential equations we then find
\[\frac{\mathrm dx}{\mathrm dt}=v=V(x,\xi,\eta).\]
This is a separable differential equation; it is therefore easily integrated from any provided initial value, $x(0)=\xi$, as a function of $t$, resulting in a relation $x=X(t,\xi,\eta)$. Then $v=V(X(t,\xi,\eta),\xi,\eta)$ and we see that it is possible to derive the formula for the solution $(x,v)$ as a function of $t$ and the initial conditions.''','MolecularDynamics/Chapter01/ScalarLocalIVP.lean','scalarPotential_exists_localIVP_integrable',extra=['U C2满足局部隐函数/唯一性资格；局部时间窗；非转向分支对应原文η≠0，其余分支为额外加强。'],context=['HasScalarQuadratureRepresentation保留真实积分原函数、局部逆与逆等式。原文只对给定ξ,η说明；联合参数光滑性尚未完整登记。'],verdict='NEEDS_HUMAN',explanation='旧库给定初值的真实局部quadrature已证；原文称V为x,ξ,η的smooth function，旧签名未包含联合参数光滑性。不可将点态初值解当完整参数化结论。')
exclude([67],'excluded_qualitative：原文提示全局需拼接局部表示、退化点逐案处理，未给一个带全局假设的拼接定理；此限制记ScalarQuadrature上下文，不能用局部解冒充全局。')
add('UniformLJSystem','1.2',21,[68],r'''The energy of the system is
\[E=\frac12\sum_{i=1}^{N}m\dot{\boldsymbol q}_i^2+\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{\mathrm{LJ}}(r_{ij}),\]
where $r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|$ and the mass $m$ of an argon atom is $6.69\times10^{-26}$ kg.''',
    '''def uniformLJSystem {N : ℕ} (m ε σ : ℝ) (q v : Fin N → V3) : ℝ :=
  (∑ i, m * ‖v i‖^2 / 2) + uniformLJEnergy ε σ q''',label='Example 1.5',context=['物理数值m只是原文参数背景，不形式化测量准确性；pairDistance=rij。'])
add('RadialLJForceLiteral','1.2',21,[69],r'''The equations of motion are, for $i=1,2,\ldots,N$, using the chain rule,
\[m\ddot{\boldsymbol q}_i=\sum_{j=1,\ j\ne i}^{N}\frac{\varphi'_{\mathrm{LJ}}(r_{ij})}{r_{ij}}(\boldsymbol q_i-\boldsymbol q_j)
=-24\frac\epsilon\sigma\sum_{j=1,\ j\ne i}^{N}r_{ij}^{-1}\left[2\left(\frac\sigma{r_{ij}}\right)^{13}-\left(\frac\sigma{r_{ij}}\right)^7\right](\boldsymbol q_i-\boldsymbol q_j).\]''',
    '''theorem radial_lj_force_literal {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (-24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j)) := by
  sorry''',kind='unnumbered_claim',extra=['正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。'],issue='首个等式缺负号；所印次行实际为势的正梯度，不同于此前Newton负梯度。',verdict='NEEDS_HUMAN',explanation='保留两条印刷等式，但由负梯度Newton不能推出；须导师裁定勘误，当前不证明假陈述。')
stated('LJCoordinateScaling','1.2',21,[199],r'''Now introduce the change of variables
\[\boldsymbol Q_i=\sigma^{-1}\boldsymbol q_i,\qquad i=1,2,\ldots,N,\]
then $\dot{\boldsymbol q}_i=\sigma\dot{\boldsymbol Q}_i$, $\ddot{\boldsymbol q}_i=\sigma\ddot{\boldsymbol Q}_i$, and $\|\boldsymbol q_i-\boldsymbol q_j\|=\sigma\|\boldsymbol Q_i-\boldsymbol Q_j\|$.''','ljCoordinateScaling_statement',extra=['σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。'],verdict='NEEDS_HUMAN',missing='旧签名遗漏距离缩放结论，须补齐后本地PASS；微分缩放本身是短证明。')
stated('LJTimeScaling','1.2','21–22',[200],r'''Thus we see that if we make the additional time transformation
\[\tau=\alpha t,\qquad\alpha^2=\frac\epsilon{m\sigma^2},\]
then the equations become
\[\frac{\mathrm d^2\boldsymbol Q_i}{\mathrm d\tau^2}=-\sum_{j=1,\ j\ne i}^{N}\frac{\hat\varphi'_{\mathrm{LJ}}(R_{ij})}{R_{ij}}(\boldsymbol Q_i-\boldsymbol Q_j).\]
This means that a natural choice for the unit of time is
\[\alpha^{-1}=\sigma\sqrt{\frac m\epsilon}\approx2.17\times10^{-12}\mathrm s.\]
By using the units given here, we may work with a simplified form of the Lennard-Jones system involving unit masses and a parameter-independent potential energy function.''','ljTimeScaling_statement',context=[r'$R_{ij}=\|\boldsymbol Q_i-\boldsymbol Q_j\|$；$\hat\varphi_{LJ}(R)=4[R^{-12}-R^{-6}]$。'],extra=['m,ε,σ,α正；真实C2非碰撞轨迹。'],missing='LJ导数、时间二阶链式法则及范数缩放组合，需补单位时间等式；大型缺失理论以外可分小批证明。',verdict='NEEDS_HUMAN')

def write_section(section):
    original=json.loads((BASE/'ch01_source.json').read_text(encoding='utf-8-sig'))
    ids={r['source_id'] for r in RECORDS if r['section'].startswith(section)}
    new=[r for r in RECORDS if r['section'].startswith(section)]
    clean=[r for r in original if r['source_id'] not in ids]+[
        {k:v for k,v in r.items() if k not in ('code','local_verdict','local_explanation','priors','missing')} for r in new]
    (BASE/'ch01_source.json').write_text(json.dumps(clean,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    lean_path=ROOT/'Blueprint/Ch01.lean'
    text=lean_path.read_text(encoding='utf-8-sig')
    # One marked section at a time; Windows paths deliberately avoid Sec1_x imports.
    marker=f'/- BEGIN FULL SECTION {section} -/'
    endmarker=f'/- END FULL SECTION {section} -/'
    body=[]
    for r in new:
        notes='\n'.join('[EXTRA] '+s for s in r['extra_assumptions'])
        issues='\n'.join('[ERRATUM?] '+s['detail'] for s in r['issues'])
        body.append(f"/-- source_id: {r['source_id']} · {r['label'] or r['kind']} · printed p.{r['printed_page']} / PDF p.{r['pdf_page']}\n{notes}\n{issues}\n-/\n{r['code']}")
    rendered=marker+'\n\n'+'\n\n'.join(body)+'\n\n'+endmarker
    if marker in text: text=re.sub(re.escape(marker)+r'[\s\S]*?'+re.escape(endmarker),lambda _:rendered,text)
    else:text=text.replace('end MD.Ch01',rendered+'\n\nend MD.Ch01')
    if 'import MolecularDynamics.Chapter01.ReviewProofs' not in text:
        text='import MolecularDynamics.Chapter01.ReviewProofs\n'+text
        text=text.replace('namespace MD.Ch01','namespace MD.Ch01\n\nopen MolecularDynamics.Chapter01Review\nopen scoped BigOperators Topology\nnoncomputable section')
    lean_path.write_text(text,encoding='utf-8')
    ap=BASE/'local_audit.json'
    audit=json.loads(ap.read_text(encoding='utf-8')) if ap.exists() else dict(schema_version='1.0',reviewer='Codex local template C',items={})
    for r in new:
        audit['items'][r['source_id']]=dict(lean_decl=r['lean_decl'],verdict=r['local_verdict'],explanation=r['local_explanation'],
            counterexample=None,suggested_fix=r['missing'],correspondence=[dict(source='原页完整公式/陈述',lean=r['lean_decl'],note='一致' if r['local_verdict']=='PASS' else r['local_verdict'])]+[
                dict(source='原文未显式量化的技术资格',lean=s,note='[EXTRA]') for s in r['extra_assumptions']],
            documented_priors=r['priors'],proof_attempts=0,proof_status='definition' if r['kind']=='definition' else 'placeholder',
            website_audit='待网站审计',missing=r['missing'],checked=False)
    ap.write_text(json.dumps(audit,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    (BASE/'old_mapping.json').write_text(json.dumps({'mapped':{oid:r['source_id'] for r in RECORDS for oid in r['old_ids']},'excluded':EXCLUDED},ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(section,len(new),'entries; total',len(clean))

if __name__=='__main__':
    import sys
    write_section(sys.argv[1])
