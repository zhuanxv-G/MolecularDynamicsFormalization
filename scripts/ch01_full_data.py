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
    try: code=block('MolecularDynamics/Chapter01/ReviewDefinitions.lean',name)
    except ValueError: code=block('MolecularDynamics/Chapter01/Statements.lean',name)
    return re.sub(r'^(def|abbrev) '+name, 'def '+name, code)

def prop(name):
    return block('MolecularDynamics/Chapter01/Statements.lean',name).split(':=',1)[1].strip()

def theorem_type(file,name):
    header=re.split(r'\s:=\s*(?:by|rfl)\b|\s:=\s*\n',block(file,name),maxsplit=1)[0]
    rest=re.sub(r'^theorem '+name+r'\s*','',header)
    depth=0
    for i,c in enumerate(rest):
        if c in '({[': depth+=1
        if c in ')}]': depth-=1
        if c==':' and depth==0:
            args,conclusion=rest[:i].strip(),rest[i+1:].strip()
            generic=''
            if re.search(r'\bE\b',args+' '+conclusion) and not re.search(r'\{E\s*:',args):
                field='ℂ' if 'ComplexSpectralFlow' in file else 'ℝ'
                generic=f'{{E : Type*}} [NormedAddCommGroup E] [NormedSpace {field} E] '+('' if name=='equilibrium_constant_ode_iff' else '[CompleteSpace E] ')
            result=('∀ '+generic+args+',\n    ' if generic or args else '')+conclusion
            return re.sub(r'(?<!\w)ω(?!\w)', 'omega', result)
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

def stated(key,section,pages,old,statement,name,*,proof=None,extra=(),context=(),issue=None,verdict='PASS',missing=None,prior=(),label=None):
    local=re.sub(r'\W','_',key).lower()
    add(key,section,pages,old,statement,'theorem '+local+' :\n  '+prop(name)+' := by\n  sorry',kind='unnumbered_claim',proof=proof,extra=extra,context=context,issue=issue,verdict=verdict,
        missing=missing,prior=prior,label=label,explanation='逐项核对展开后的陈述、真实定义、量词及[EXTRA]；'+('原文疑点保留，待导师裁定。' if issue else '语义本地通过，证明尚未完成。'))

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

add('Lagrangian','1.3',22,[70],r'''For the system (1.3) with N atoms and $N_c=3N$ configuration coordinates, the Lagrangian is
\[L\stackrel{\mathrm{def}}=\frac{\dot{\boldsymbol q}^{T}\boldsymbol M\dot{\boldsymbol q}}2-U(\boldsymbol q).\]''',
    '''def fixedMassLagrangian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : ℝ := nBodyKineticEnergy m v - U q''',context=['固定对角M；n=Nc，三维按质量重复坐标。nBodyKineticEnergy_eq_inner给出矩阵二次式一致性。'])
exclude([71],'excluded_qualitative：p.22仅历史介绍principle of least action并明确指向第2章；没有第1章独立变分陈述或论证，不能把第2章定理补造为第1章原文。')
add('GeneralizedCoordinates','1.3',23,[74,75,76,77],r'''When we introduce a smooth change of variables $\boldsymbol q=\boldsymbol\Phi(\boldsymbol Q)$, where $\boldsymbol\Phi:\mathbb R^{N_c}\to\mathbb R^{N_c}$, this induces a corresponding transformation of the velocity vector by
\[\dot{\boldsymbol q}=\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q},\]
where $\boldsymbol\Phi'$ is the $N_c\times N_c$ Jacobian matrix of $\boldsymbol\Phi$. Then the Lagrangian of the system is transformed to
\[\widetilde L=\frac{\dot{\boldsymbol Q}^{T}\boldsymbol\Phi'(\boldsymbol Q)^{T}\boldsymbol M\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q}}2-U(\boldsymbol\Phi(\boldsymbol Q)),\]''',
    '''theorem generalized_coordinates {n k : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Φ : Position k → Position n)
    (J : Matrix (Fin n) (Fin k) ℝ) (q : ℝ → Position k) (V : Velocity k) (t : ℝ)
    (hΦ : HasFDerivAt Φ J.toEuclideanLin.toContinuousLinearMap (q t))
    (hq : HasDerivAt q V t) :
    HasDerivAt (fun s => Φ (q s)) (J.toEuclideanLin V) t ∧
    massLagrangian m U (Φ (q t)) (J.toEuclideanLin V) =
      inner ℝ V ((generalizedMassMatrix m J).toEuclideanLin V) / 2 - U (Φ (q t)) := by
  exact ⟨hasDerivAt_coordinateChange Φ J q V t hΦ hq,
    massLagrangian_coordinateChange m U Φ J (q t) V⟩''',kind='unnumbered_claim',
    context=['J=Φ′(Q)真实Frechet导数；generalizedMassMatrix=JᵀMJ；后段允许k=Nd≤Nc参数化约束流形。'],
    extra=['原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。'],prior=['MolecularDynamics/Chapter01/GeneralizedCoordinates.lean:hasDerivAt_coordinateChange','MolecularDynamics/Chapter01/GeneralizedCoordinates.lean:massLagrangian_coordinateChange'])
bridge('GeneralizedMassRegular','1.3',23,[78],r'''We will assume that any such changes of variables are regular transformations in the sense that $\boldsymbol\Phi'$ is of full rank and the resulting generalized mass matrix is invertible.''','MolecularDynamics/Chapter01/GeneralizedCoordinates.lean','generalizedMassMatrix_isUnit',extra=['正粒子质量；full rank为Jacobian列单射，符合n≥k。'],context=['这是原文模型假设及其由正定质量推出的关系，不假设结论可逆。'])
add('ConvexLegendre','1.4',24,[79],r'''Abstractly, a Legendre transformation of a given convex function $g=g(\boldsymbol\xi):\mathbb R^m\to\mathbb R$ is a new function $\widetilde g=\widetilde g(\boldsymbol\eta):\mathbb R^m\to\mathbb R$ defined by
\[\widetilde g(\boldsymbol\eta)=\sup_{\boldsymbol\xi}(\boldsymbol\eta^T\boldsymbol\xi-g(\boldsymbol\xi)),\]''',definition('legendreTransform'),extra=['值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。'],issue='原文给任意凸g却称共轭R值；g=0,η≠0时上确界+∞。Blueprint保留sup定义并显式扩展值域，须导师裁定是否接受。',verdict='NEEDS_HUMAN',explanation='原文sup可非有限。EReal是显式[EXTRA]值域修复，不能宣称逐字的R值对象已经PASS。')
add('HamiltonEquations','1.4',24,[84],r'''The equations of motion can be written
\[\dot{\boldsymbol q}=\frac{\partial H}{\partial\boldsymbol p},\qquad\dot{\boldsymbol p}=-\frac{\partial H}{\partial\boldsymbol q}.\]''',
    '''def hamiltonEquations {n : ℕ} (H : PhaseSpace n → ℝ) (q p : ℝ → Position n) : Prop :=
  ∀ t, HasDerivAt q (gradient (fun v => H (q t,v)) (p t)) t ∧
    HasDerivAt p (-gradient (fun x => H (x,p t)) (q t)) t''',context=['速度与动量导数均是真导数；H可微的模型背景在使用时另给资格。'])
bridge('HamiltonFixedMass','1.4',24,[85],r'''For constant $\boldsymbol M$ we obtain the dynamical equations,
\[\dot{\boldsymbol q}=\boldsymbol M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol F=-\partial U/\partial\boldsymbol q.\]''','MolecularDynamics/Chapter01/Hamiltonian.lean','hamiltonianVectorField_eq',extra=['固定对角正质量；一般常SPD矩阵待扩展，原文M可指配置相关模型取常值。'],verdict='NEEDS_HUMAN',explanation='现有桥接仅固定对角M；原文常M含一般SPD。签名必须扩展一般常质量矩阵，不能把对角特例当全条PASS。')
stated('HamiltonLagrangeEquivalence','1.4',25,[86],r'''More generally, for molecular models, the Hamiltonian and Lagrangian formulations are interchangeable, but the use of the Hamiltonian form is preferred for allowing simplified description of the geometric character of the solutions of the system as we discuss in Chaps. 2–4.''','generalLegendreEquivalence_statement',extra=['一般配置相关M C2、U C2、M逐点正定；轨迹q′=v真实且时间域开放。'],missing='一般矩阵二次型速度梯度及配置导数、可微矩阵逆和Euler–Lagrange转换理论。')
add('PhaseSpace','1.4',25,[87,88],r'''The set of all positions and momenta for which the energy is finite is termed the phase space. The instantaneous state of a molecular system involving many, say N, particles moving in $\mathbb R^3$ is described by coordinates and positions, i.e., by a point in $\mathbb R^{6N}$.''',
    '''def finiteEnergyPhaseDomain {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}''',extra=['采用扩展实值H以明确排除奇异无穷能量；PhaseSpace n底层是位置×动量，n=3N。'])

add('LocalExistUnique','1.5',25,[89],'''One of the most important properties of a typical classical molecular Hamiltonian system is the existence and uniqueness of solutions started from a generic initial condition.''',
    '''theorem local_exist_unique {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (hQ : IsOpen Q) (t₀ : ℝ) (z₀ : PhaseSpace n) (hz : z₀.1 ∈ Q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∃ ε γ, IsLocalMechanicalIVP m (fun q => -gradient U q) Q t₀ z₀ ε γ) ∧
    ∀ I γ η, IsOpen I → t₀ ∈ I →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I γ →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I η →
      γ t₀ = z₀ → η t₀ = z₀ → γ =ᶠ[𝓝 t₀] η := by
  constructor
  · exact exists_localMechanicalIVP_open_of_force_contDiffAt m _ Q hQ t₀ z₀ hz (hreg _ hz)
  · intro I γ η hI ht hγ hη hi hj
    exact mechanicalSolution_eventually_unique_of_contDiffAt m _ Q I t₀ γ η z₀ hI ht hγ hη hi hj
      (mechanicalVectorField_contDiffAt m _ z₀ (hreg _ hz))''',kind='unnumbered_claim',
    extra=['generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。'],prior=['MolecularDynamics/Chapter01/LocalExistence.lean:exists_localMechanicalIVP_open_of_force_contDiffAt'])
add('EnergySurface','1.5',25,[90],r'''For given $E_0\geq U_{\min}$ define $\Sigma_{E_0}=\{(\boldsymbol q,\boldsymbol p)\mid H(\boldsymbol q,\boldsymbol p)=E_0\}$.''',definition('energySurface'),context=['Σ是指定H的能量层，E0≥Umin为使用背景，不声称层非空。'])
add('EnergyBounds','1.5',25,[91,92,93],r'''Assume that $U$ is a potential energy function which is bounded below, $U\geq U_{\min}$. For given $E_0\geq U_{\min}$ define $\Sigma_{E_0}=\{(\boldsymbol q,\boldsymbol p)\mid H(\boldsymbol q,\boldsymbol p)=E_0\}$. Then, for $(\boldsymbol q,\boldsymbol p)\in\Sigma_{E_0}$
\[\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.\]
$\boldsymbol M^{-1}$ is a positive definite matrix (assumed here to be constant), so we can infer that the momenta are bounded at fixed total energy. We would like to say something similar for positions. We have, at energy $E_0$,
\[U_{\min}\leq U(\boldsymbol q)\leq E_0.\]''',
    '''theorem energy_bounds {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : ∀ q, Umin ≤ U q) :
    (∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ →
      inner ℝ p (matrixAction M⁻¹ p) / 2 = E₀ - U q ∧
      inner ℝ p (matrixAction M⁻¹ p) / 2 ≤ E₀ - Umin ∧ Umin ≤ U q ∧ U q ≤ E₀) ∧
    ∃ R : ℝ, ∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ → ‖p‖ ≤ R := by
  sorry''',kind='unnumbered_claim',extra=['U定义在整个欧氏位置域；保持一般常M⁻¹正定，未换成固定对角特例。'],missing='一般SPD二次型的正下界/紧单位球coercivity桥接；已有对角MomentumBounds只覆盖特例。')
add('UniformLevelsCompact','1.5',26,[94,96],r'''What is needed is an assumption that the level sets $\widehat\Sigma_\alpha=\{\boldsymbol q\mid U(\boldsymbol q)=\alpha\}$ are bounded uniformly for $\alpha\in[U_{\min},E_0]$. Then it follows that solutions satisfying the energy constraint remain confined to a compact (closed and bounded) set.''',
    '''theorem uniform_levels_compact {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : Continuous U) (hlower : ∀ q, Umin ≤ U q)
    (hlevels : ∃ R : ℝ, ∀ α ∈ Icc Umin E₀, ∀ q, U q = α → ‖q‖ ≤ R) :
    IsCompact {z : PhaseSpace n | variableMassHamiltonian (fun _ => M) U z.1 z.2 = E₀} := by
  sorry''',kind='unnumbered_claim',extra=['U连续保证能量层闭；一般常逆质量正定继承p.25；无奇异域的全欧氏模型，若有奇异域需紧集留域。'],missing='一般SPD能量界+有限维闭有界紧性；原文confining性质只在能量子水平集要求，不把所有位置集先设紧。')
add('CompactContinuation','1.5','25–26',[95],'''The uniqueness of solutions is easily verified in the usual way (as for the local result for uniqueness of solutions). The key point is that, with the energy constraint, solutions typically remain bounded for all time.''',
    '''theorem compact_continuation {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (K : Set (PhaseSpace n)) (z₀ : PhaseSpace n)
    (hQ : IsOpen Q) (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q) (hz : z₀ ∈ K)
    (hconfine : ∀ a b γ, 0 ∈ Ioo a b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ 0 = z₀ → ∀ t ∈ Ioo a b, γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q univ γ ∧ γ 0 = z₀ ∧ ∀ t, γ t ∈ K := by
  sorry''',kind='unnumbered_claim',extra=['共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。'],missing='双向紧集延拓：已有正式定理仅供给未来Ioi，须反向系统并拼接；本批保留完整双向签名。')
stated('Nonconfining','1.5',26,[97],r'''The assumption on $U$ is not satisfied by some simple potentials. For example consider $U(x,y)=x^2$ which is completely independent of $y$ and so places no restriction on that variable for constant energy.''','nonconfiningExample_statement',missing='有界集坐标投影/序列反证，计划短证明。')
add('FlowMap','1.5.1',26,[98],r'''Consider now the initial value problem
\[\dot{\boldsymbol z}=f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi,\tag{1.5}\]
in a $m$-dimensional space. If we assume that $f$ corresponds to a molecular Hamiltonian system satisfying the assumptions of the existence and uniqueness result of the previous subsection, then we may define a mapping from a point in phase space to the point $t$ units later along the time-evolution starting from the initial point. We refer to this map as the flow map and denote it by $\mathcal F_t$. $\mathcal F_t(\boldsymbol\xi)=\boldsymbol z(t)$ solves the initial value problem (1.5).''',
    '''def flowMap {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ ξ, F 0 ξ = ξ) ∧ ∀ ξ t, HasDerivAt (fun s => F s ξ) (f (F t ξ)) t''',context=['这里只定义已存在全局流满足IVP；不假设群律，不声明任意f全局可解。'])
bridge('FlowEnergy','1.5.1',26,[101],r'''The flow map of a Hamiltonian system conserves its Hamiltonian, thus
\[H(\mathcal F_t(\boldsymbol\xi))=H(\boldsymbol\xi).\]''','MolecularDynamics/Chapter01/GlobalFlow.lean','globalMechanicalFlow_energy',extra=['固定对角机械Hamiltonian；真实全局流、正质量、势可微、F=-∇U。一般非机械Hamiltonian尚待全局光滑Hamilton理论。'],verdict='NEEDS_HUMAN',explanation='原文为一般Hamiltonian flow；当前库桥接限可分离机械H，须写一般H陈述后本地PASS。')
add('HarmonicPhaseFlow','1.5.1',27,[102],r'''for which the solution subject to initial values $q(0)=q_0,p(0)=p_0$ is
\[\begin{pmatrix}q(t)\\p(t)\end{pmatrix}=\mathcal F_t\begin{pmatrix}q_0\\p_0\end{pmatrix}=\begin{pmatrix}q_0\cos(\Omega t)+p_0\sin(\Omega t)/\Omega\\-q_0\Omega\sin(\Omega t)+p_0\cos(\Omega t)\end{pmatrix}.\]''',
    '''def harmonicPhaseFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2,
    (-Ω*Real.sin (Ω*t)) • z.1 + Real.cos (Ω*t) • z.2)''',context=['p.26方程q′=p,p′=-Ω²q；Ω≠0域；§1.2已有真实解与初值证明。'])
bridge('SpectralSolution','1.5.1',27,[103],r'''If $\boldsymbol A$ has a basis of eigenvectors $\boldsymbol\eta_i$, $i=1,\ldots,m$, with corresponding eigenvalues $\lambda_1,\lambda_2,\ldots,\lambda_m$, then we may write the solution at time $t$ as
\[\boldsymbol z(t)=\sum_{i=1}^{m}c_i e^{\lambda_i(t-t_0)}\boldsymbol\eta_i\]
where the coefficients $c_i$ are obtained by solving the equation
\[\boldsymbol z(t_0)=\boldsymbol\xi=\sum_{i=1}^{m}c_i\boldsymbol\eta_i.\]''','MolecularDynamics/Chapter01/ComplexSpectralFlow.lean','complexExponentialFlow_eigenbasis',extra=['有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。'],context=['允许复数特征值，不偷换为实谱。'])
bridge('BasisCoefficients','1.5.1',27,[105],r'''(ii) with our assumption that the $\{\boldsymbol\eta_i\}$ form a basis, the calculation of the coefficients will always be possible, since the matrix $\boldsymbol X$ whose columns are the eigenvectors will be invertible, that is, the coefficients $c_i$ can be enumerated as the components of a vector $\boldsymbol c$ which satisfies the square linear system
\[\boldsymbol\xi=\boldsymbol X\boldsymbol c.\]''','MolecularDynamics/Chapter01/BasisMatrix.lean','basisColumnMatrix_inverse_coefficients',extra=['RCLike域包含实/复两种；真实有限基。'])
bridge('MatrixExponentialSolution','1.5.1',27,[106],r'''An alternative expression for the solution is in terms of the exponential of the matrix $\boldsymbol A$ scaled by time,
\[\boldsymbol z(t)=e^{\boldsymbol A(t-t_0)}\boldsymbol\xi.\]''','MolecularDynamics/Chapter01/MatrixFlow.lean','matrixExponentialFlow_unique',context=['matrixExponentialFlow_eq把连续算子指数对应到真正矩阵指数。'])
add('MatrixExpSeries','1.5.1','27–28',[107,108],r'''Alternatively, we may think of $\exp(\boldsymbol A)$ as the sum of the exponential series
\[e^{\boldsymbol A}=\boldsymbol I+\boldsymbol A+\frac1{2!}\boldsymbol A^2+\frac1{3!}\boldsymbol A^3+\cdots\]
although this is seldom the most efficient method to compute it (this series converges for all matrices $\boldsymbol A$, and so in fact the exponential expression for the solution of the linear system is well defined even in the absence of a full set of eigenvectors).''',
    '''theorem matrix_exp_series {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) :
    HasSum (fun k : ℕ => ((k.factorial : ℝ)⁻¹) • A^k) (NormedSpace.exp A) := by
  exact MolecularDynamics.Chapter01Review.matrixExponentialSeries_hasSum A''',kind='unnumbered_claim',prior=['MolecularDynamics/Chapter01/ReviewProofs.lean:matrixExponentialSeries_hasSum'],context=['HasSum包含级数收敛和等式；需要Matrix.Norms.L2Operator范数约定。'])
add('FirstIntegral','1.5.2',28,[109],r'''Another term for constants of motion is first integral. In general, if we have a dynamical system $\dot{\boldsymbol z}=f(\boldsymbol z)$, a first integral is a smooth function $I(\boldsymbol z)$ which is constant along solutions, for all values of the initial condition.''',
    '''def smoothFirstIntegral {n : ℕ} (f : Position n → Position n) (Q : Set (Position n))
    (I : Position n → ℝ) : Prop := ContDiffOn ℝ ∞ I Q ∧ IsFirstIntegralOn f Q I''',context=['IsFirstIntegralOn量化每条真实曲线及其存在区间，不附加全局存在。'])
bridge('FirstIntegralCriterion','1.5.2',28,[110],r'''Since this should hold everywhere, the condition for $I$ to be a first integral is that $\nabla I\cdot f=0$.''','MolecularDynamics/Chapter01/FirstIntegrals.lean','isFirstIntegralOn_iff_differential',
    proof=r'''Let $\boldsymbol z(t)$ ($t\in\mathbb R$) be a solution, then
\[I(\boldsymbol z(t))=I(\boldsymbol z(0))\Rightarrow0=\frac{\mathrm d}{\mathrm dt}I(\boldsymbol z(t))=\nabla I(\boldsymbol z(t))\cdot\dot{\boldsymbol z}(t)=\nabla I(\boldsymbol z(t))\cdot f(\boldsymbol z(t)).\]''',extra=['开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral_gradient_criterion。'])
bridge('PlanarGraphReduction','1.5.2',28,[111,112],r'''In principle, such an equation can be solved (locally at least) for $y$ as a function of $x$ due to the implicit function theorem. Hence one may write $y=\psi(x)$. Reinsert this into the first differential equation to get a reduced equation in just one dependent variable:
\[\frac{\mathrm dx}{\mathrm dt}=g(x,\psi(x)).\]''','MolecularDynamics/Chapter01/FirstIntegralGraph.lean','planarFirstIntegral_localGraph_reduction',extra=['对y偏导非零，真实strict导数，局部时间窗；原文省略隐函数非退化条件。'],context=['正文前句二维f=(g,h)且第一积分I(x,y)=I0；不把IsFirstIntegralOn当证明目标假设，它是本条原文已有第一积分。'])
bridge('PlanarQuadrature','1.5.2',28,[113],'''Such an ordinary differential equation is said to be separable, and theoretically can be solved, given an initial condition, for x as a function of t.''','MolecularDynamics/Chapter01/FirstIntegralQuadrature.lean','planarFirstIntegral_nonturning_quadrature',extra=['正则第一积分图及非转向速度非零；真实C2、局部积分逆。'])
bridge('ScalarFirstIntegral','1.5.2',28,[114],'''Example 1.6 The single degree of freedom model of Example 1.4 has the energy as a first integral. The system is therefore integrable.''','MolecularDynamics/Chapter01/ScalarIntegrability.lean','scalarPotentialEnergy_isFirstIntegral',extra=['U C2；原文integrable的quadrature结论复用§1.2条目，不等同于全局闭式轨道。'])

bridge('RealSpectralSolution','1.5.1',27,[104],r'''Observations: (i) eigenvectors, eigenvalues, and coefficients $c_i$ may be complex, but if $\boldsymbol A$ and $\boldsymbol\xi$ have real coefficients, it is nonetheless possible to obtain a real solution,''','MolecularDynamics/Chapter01/RealRecoveryFlow.lean','realMatrix_complexSpectral_sum_isReal',context=['谱和结果每坐标虚部=0，对t-t0调用；不强制特征值为实。'])
add('KeplerEnergy','1.5.2',29,[115],r'''Example 1.7 The Kepler problem describes the motion of a body in the plane moving under gravitational force exerted by a second, fixed body (located at the origin); it has the energy $E(x,y,\dot x,\dot y)=\dot x^2/2+\dot y^2/2-1/\sqrt{x^2+y^2}$.''',
    '''def planarKeplerEnergy (x y v w : ℝ) : ℝ :=
  v^2/2 + w^2/2 - 1/Real.sqrt (x^2+y^2)''',context=['x²+y²>0非碰撞域；单位质量和引力系数。'])
bridge('KeplerConservedEnergy','1.5.2',29,[116],'''The two conserved quantities, energy and angular momentum, mean that the Kepler problem is an integrable system.''','MolecularDynamics/Chapter01/Kepler.lean','kepler_energy_const_on_Ioo',extra=['真实机械轨迹、非碰撞开放时间区间；n=2对应平面。'],context=['另一守恒量独立列KeplerAngularMomentum；可积重建列KeplerFullSolution。'])
bridge('KeplerAngularMomentum','1.5.2',29,[117],r'''however, due to the fact that the potential energy is rotationally invariant (dependent only on the distance of the moving particle from the origin), the angular momentum of the system is conserved.''','MolecularDynamics/Chapter01/Kepler.lean','kepler_planarAngularMomentum_const_on_Ioo',context=[r'$l_z=x\dot y-y\dot x$，p.29同页；非碰撞真轨迹。'])
stated('KeplerMomentum','1.5.2',29,[201],r'''Note that a consequence of fixing one of the bodies in the Kepler problem is that the two components of the total momentum vector, i.e. $(m\dot x,m\dot y)$, are obviously no longer conserved;''','keplerMomentumNotConserved_statement',extra=['q≠0；单位质量。'],missing='非零向量被非零径向系数缩放，计划短证明。')
add('PolarCoordinates','1.5.2',29,[118],r'''In polar coordinates $(x,y)=(r\cos\theta,r\sin\theta)$, the Lagrangian $L$ for the Kepler problem is''',
    '''def polarCoordinates (r θ : ℝ) : Position 2 := WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ]''',context=['r>0，角实数局部提升；0处排除。'])
bridge('KeplerPolarLagrangian','1.5.2',29,[119],r'''\[L=K-U=\frac12(\dot r\cos\theta-r\dot\theta\sin\theta)^2+\frac12(\dot r\sin\theta+r\dot\theta\cos\theta)^2+\frac1r=\frac{\dot r^2}2+\frac{r^2\dot\theta^2}2+\frac1r.\]''','MolecularDynamics/Chapter01/PolarCoordinates.lean','keplerPolarLagrangian_identity',context=['v=r′、ω=θ′；公式为代数恒等式，物理域r>0。'])
bridge('KeplerPolarODE','1.5.2',29,[120],r'''Working these out directly, one gets
\[\ddot r=-\frac1{r^2}+r\dot\theta^2,\qquad0=\frac{\mathrm d}{\mathrm dt}(r^2\dot\theta).\]''','MolecularDynamics/Chapter01/KeplerPolarDynamics.lean','keplerPolar_eulerLagrange_iff',context=['IsKeplerPolarEulerLagrangeOn包含真实一阶/二阶导数及r≠0，展开定义核对。'])
bridge('PolarAngularIdentity','1.5.2',29,[121],r'''Expressed in polar coordinates this is
\[l_z=(r\cos\theta)(\dot r\sin\theta+r\dot\theta\cos\theta)-(r\sin\theta)(\dot r\cos\theta-r\dot\theta\sin\theta)
=r^2\dot\theta(\cos^2\theta+\sin^2\theta)=r^2\dot\theta,\]''','MolecularDynamics/Chapter01/PolarCoordinates.lean','polarAngularMomentum_identity',context=['保留三角恒等式计算中的真实速度对应，代数定理不需r>0。'])
bridge('KeplerRadialReduction','1.5.2',29,[122],r'''Taking this quantity as fixed, we may write the remaining equation as $\ddot r=-1/r^2+l_z^2/r^3$.''','MolecularDynamics/Chapter01/KeplerPolarDynamics.lean','keplerPolar_radial_reduction',extra=['r非零、角动量l固定，既有极坐标Euler–Lagrange真实解；角动量常性先前已证。'])
add('KeplerRadialEnergy','1.5.2',30,[123],r'''system with energy
\[\widehat E(r,\dot r)=\frac{\dot r^2}2-\frac1r+\frac{l_z^2}{2r^2}.\]''',
    '''def radialKeplerEnergy (ℓ r v : ℝ) : ℝ := v^2/2-1/r+ℓ^2/(2*r^2)''',context=['r>0；ℓ固定z角动量；原句跨p.29–30，system指径向单自由度系统。'])
add('KeplerFullSolution','1.5.2',30,[124,125,126],r'''From our previous work, we know that this system (a single degree of freedom system) can be solved for $r$ as a function of $t$ and the initial conditions. Once $r=r(t)$ is known, we may obtain $\theta$ by integration:
\[\theta=\theta(0)+\int_0^t\frac{l_z}{r^2(s)}\,\mathrm ds.\]
The example shows that the full solution of the Kepler problem can be worked out given the initial conditions, as long as we are happy to express the solution in terms of antiderivatives of simple functions (and their inverses).''',
    '''theorem kepler_full_solution (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z) :
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = polarCoordinates (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = ((polarCoordinates (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀]) := by
  sorry''',kind='unnumbered_claim',extra=['完整非碰撞存在区间含0；原文不保证径向碰撞时仍有全局解；角θ为区间上的连续实提升。'],missing='全存在区间极坐标角提升、穿越全部转向点的quadrature图拼接；现有库只有固定初值局部重建。')
add('ActionAngleCoordinates','1.5.2',30,[127,202],r'''Define new variables
\[x=\sqrt{2I/\Omega}\cos\theta,\qquad v=\sqrt{2I\Omega}\sin\theta.\]''',
    '''def oscillatorActionAngle (Ω I θ : ℝ) : ℝ × ℝ :=
  (Real.sqrt (2*I/Ω)*Real.cos θ, Real.sqrt (2*I*Ω)*Real.sin θ)''',context=['Ω>0，I>0非退化action；(I,θ)是新坐标对，不另拆单符号。'])
bridge('ActionEnergy','1.5.2',30,[128],r'''In these variables, the energy is $E=I\Omega$.''','MolecularDynamics/Chapter01/HarmonicActionAngle.lean','harmonicAction_energy',extra=['Ω>0，I≥0；harmonicActionVelocity_formula保证v的sqrt(2IΩ)形式一致。'])
bridge('ActionODE','1.5.2',30,[129],r'''Introducing these formulas into the equations of motion and simplifying leads to $\dot I=0$, $\dot\theta=-\Omega$.''','MolecularDynamics/Chapter01/HarmonicActionAngle.lean','harmonicAction_ode_iff',extra=['Ω,I正；真实I′、θ′，非退化局部角坐标。'])
bridge('ActionSolution','1.5.2',30,[130],r'''The first equation expresses the constancy of energy; the second describes a rotation with frequency $\Omega$, i.e., the solution is $\theta(t)=\theta(0)-\Omega t$.''','MolecularDynamics/Chapter01/HarmonicActionAngle.lean','harmonicAction_time_formula',extra=['连通开放时间窗含起始s；正action及Ω，真实坐标解。'],context=['取s=0即原文公式；签名同时给I(t)=I(s)。'])
add('HarmonicTorus','1.5.2',30,[131],r'''The same change of variables $(x_j,v_j)\to(I_j,\theta_j)$, applied to each oscillator, would yield equations of motion $\dot I_j=0$, $\dot\theta_j=-\Omega_j$. This describes a point winding about a $d$-dimensional torus defined by angular rotation frequencies $\Omega_j$ and radii $|I_j|$ (Fig. 1.14).''',
    '''def oscillatorTorusMotion {d : ℕ} (I Ω : Fin d → ℝ) (θ₀ : HarmonicTorus d)
    (t : ℝ) : (Fin d → ℝ) × HarmonicTorus d := (I, harmonicTorusRotation Ω t θ₀)''',context=['HarmonicTorus d = Fin d→Real.Angle；角模2π；I为固定action，半径的几何映射不新造定理。'])
bridge('TorusPeriod','1.5.2',30,[132],'''Depending on the ratio of frequencies such motions may be periodic or quasi-periodic;''','MolecularDynamics/Chapter01/HarmonicTorus.lean','harmonicTorusRotation_periodic_iff_integer',extra=['给定周期T；每频率×T为整数圈是精确共振条件；原句没有单独定义commensurate。'])
stated('TorusDense','1.5.2',30,[133],'''in the latter case the paths do not “close up” but instead we see the curve gradually fills in the surface of the torus.''','torusDense_statement',extra=['高维全整数关系无共振；仅成对频率比无理不足，此为原文quasi-periodic intended meaning的数学资格。'],missing='一般d维Kronecker稠密轨道理论；正式库仅二维无理比。',verdict='NEEDS_HUMAN',issue='原文用ratio of frequencies描述高维填满环面，未区分准周期子环面与全维整数无共振；须导师明确。')
add('LocalActionAngleReduction','1.5.2',30,[134],'''More generally, one finds occasional examples of nonlinear systems which possess as many independent first integrals as degrees of freedom (satisfying a certain “involution” condition); such systems may be reduced via a coordinate transformation to action-angle variables, i.e. they exhibit tori motion.''',
    '''theorem local_action_angle_reduction (d : ℕ) (I : Fin d → PhaseSpace d → ℝ)
    (S : Set (PhaseSpace d)) (hS : IsOpen S)
    (hI : ∀ i, ContDiff ℝ ∞ (I i))
    (hcomm : ∀ i j z, poissonBracket (I i) (I j) z = 0)
    (hregular : ∀ z ∈ S, Function.Surjective (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) :
    localActionAngle I S := by
  sorry''',kind='unnumbered_claim',extra=['真实光滑Hamiltonian第一积分，正则满秩为independent；局部开集，原文未给紧连通正则层条件。'],issue='local canonical action-angle与全局torus motion不同；本条只保留局部规约，原文最后tori motion需额外紧共同能量层假设。',verdict='NEEDS_HUMAN',missing='一般Liouville–Arnold/Carathéodory–Jacobi–Lie理论；全局环面子句需另行裁定补齐。')
add('Equilibrium','1.5.3',31,[135],r'''An equilibrium point of such system is a solution of $f(\boldsymbol z)=0$.''',definition('equilibriumDefinition'))
bridge('ConstantEquilibrium','1.5.3',31,[136],r'''An equilibrium point $\boldsymbol z^*$ corresponds to an equilibrium solution, since if we define a constant function $\boldsymbol z(t)=\boldsymbol z^*$ then we have $\dot{\boldsymbol z}(t)=f(\boldsymbol z^*)=0$.''','MolecularDynamics/Chapter01/EquilibriumLinearization.lean','equilibrium_constant_ode_iff')
bridge('EquilibriumLinearization','1.5.3',31,[137,138],r'''We assume that $f$ is continuously differentiable in the vicinity of the equilibrium point $\boldsymbol z^*$ and make use of the fact that $f(\boldsymbol z)\approx f(\boldsymbol z^*)+f'(\boldsymbol z^*)(\boldsymbol z-\boldsymbol z^*)$ for $\|\boldsymbol z-\boldsymbol z^*\|$ sufficiently small. Since $f(\boldsymbol z^*)=0$ we have, defining $\delta\boldsymbol z:=\boldsymbol z-\boldsymbol z^*$,
\[\frac{\mathrm d\delta\boldsymbol z}{\mathrm dt}=\boldsymbol A\delta\boldsymbol z,\qquad\boldsymbol A=f'(\boldsymbol z^*).\]
The symbol $\approx$ is not very precise.''','MolecularDynamics/Chapter01/EquilibriumLinearization.lean','equilibrium_linearized_IVP',context=['小o余项将≈精确定义为一阶近似；δ的线性ODE是近似系统，不声称非线性扰动精确满足Aδ。'])
add('Hyperbolic','1.5.3','31–32',[139],r'''In case the equilibrium point is hyperbolic, meaning that the real parts of the eigenvalues of $\boldsymbol A=f'(\boldsymbol z^*)$ are nonzero,''',definition('hyperbolic'),context=['实算子用复特征向量的实虚部编码；所有非零特征对对应实部a≠0。'])
stated('HartmanGrobmanLiteral','1.5.3','31–32',[140],r'''then one can infer that the solutions of the nonlinear and linear systems are in fact topologically conjugate: if $\boldsymbol z$ is the solution of the nonlinear system and $\delta\boldsymbol z$ is the solution of the linear system, then there is a smooth, invertible map $\boldsymbol\Phi$ of $\mathbb R^m$ defined in a neighborhood of the origin such that
\[\boldsymbol z(t)=\boldsymbol z^*+\boldsymbol\Phi(\delta\boldsymbol z(t)).\]
This is referred to as the Hartman-Grobman theorem (for more discussion see [177], where this result is referred to as the “Linearization Theorem”; a proof may be found in [362]).''','hartmanGrobmanLiteral_statement',extra=['C1全域模型及真实全局流为局部应用的技术资格；共轭在轨迹保持局部域时断言。'],issue='原文smooth invertible强于常见Hartman–Grobman的homeomorphism，C1仅双曲不保证光滑共轭。',verdict='NEEDS_HUMAN',missing='一般Hartman–Grobman理论；光滑共轭字面断言需导师勘误。')
add('LyapunovStability','1.5.3',32,[141],r'''Let $\boldsymbol z^*$ be an equilibrium point. We say that $\boldsymbol z^*$ is stable (“in the sense of Lyapunov”) if, for all $\epsilon$, there exists $\delta$ such that, for all $\boldsymbol z_0$ such that $\|\boldsymbol z_0-\boldsymbol z^*\|<\delta$,
\[\sup_{t\geq0}\|\mathcal F_t(\boldsymbol z_0)-\boldsymbol z^*\|<\epsilon.\]''',
    '''def lyapunovStable {n : ℕ} (F : ℝ → Position n → Position n) (z : Position n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, ‖x-z‖ < δ →
    BddAbove (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) ∧
    sSup (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) < ε''',extra=['ε,δ正按Lyapunov容差惯例；有界性避免Lean实数总sup的未界伪结论。'])
stated('HyperbolicStabilityTransfer','1.5.3',32,[142],r'''The Hartman-Grobman theorem clearly implies that the stability of a given hyperbolic equilibrium point $\boldsymbol z^*$ of a nonlinear system can be inferred from the stability of the origin for the linearization of the system around $\boldsymbol z^*$.''','hyperbolicStabilityTransfer_statement',extra=['C1及真实全局流；stable谓词的统一界<ε与原文严格sup形式等价。'],missing='局部拓扑共轭与稳定性转移理论；不能用含疑误smooth共轭占位传递证明。')
add('HamiltonEquilibrium','1.5.3',32,[143],r'''Observe that an equilibrium point $\boldsymbol z^*=(\boldsymbol q^*,\boldsymbol p^*)$ of a Hamiltonian system in “kinetic plus potential” form
\[H(\boldsymbol q,\boldsymbol p)=\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p/2+U(\boldsymbol q)\]
will always have $\boldsymbol p^*=0$ and $\nabla U(\boldsymbol q^*)=0$.''',
    '''theorem hamilton_equilibrium {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q)
    (heq : gradient (fun v => variableMassHamiltonian (fun _ => M) U q v) p = 0 ∧
      gradient (fun x => variableMassHamiltonian (fun _ => M) U x p) q = 0) :
    p = 0 ∧ gradient U q = 0 := by
  sorry''',kind='unnumbered_claim',extra=['一般常M正定、U可微；heq为原文Hamilton平衡的两梯度定义。'],missing='一般矩阵速度梯度和逆单射；已有对角mechanicalEquilibrium_iff不能取代一般签名。')
add('StrongLocalMinimum','1.5.3',32,[144],r'''We say that $\boldsymbol q^*$ is a strong local minimum of the potential if there exists $\epsilon>0$ such that
\[0<\|\boldsymbol q-\boldsymbol q^*\|<\epsilon\Rightarrow U(\boldsymbol q)>U(\boldsymbol q^*).\]''',
    '''def strongLocalMinimum {n : ℕ} (U : PotentialEnergy n) (qstar : Position n) : Prop :=
  ∃ ε > 0, ∀ q, 0 < ‖q-qstar‖ → ‖q-qstar‖ < ε → U qstar < U q''')
add('LinearizedHamiltonian','1.5.3',32,[146],r'''If the potential is $C^2$, then the linearized version is of the same “kinetic plus potential” form with Hamiltonian
\[\widetilde H=\frac{\delta\boldsymbol p^T\boldsymbol M^{-1}\delta\boldsymbol p}2+\frac{\delta\boldsymbol q^T U''(\boldsymbol q^*)\delta\boldsymbol q}2.\]''',
    '''def linearizedHamiltonian {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (δq δp : Position n) : ℝ :=
  inner ℝ δp (matrixAction M⁻¹ δp)/2 + inner ℝ δq (fderiv ℝ (gradient U) qstar δq)/2''',context=['C2使fderiv gradient为真实Hessian；定义只登记该二次Hamiltonian形式。'])
stated('PositiveHessianQuadratic','1.5.3',33,[147],r'''A condition for this system to have a strong local minimum at $\delta\boldsymbol p=0$, $\delta\boldsymbol q=0$ is that the Hessian matrix $U''(\boldsymbol q^*)$ be positive definite.''','positiveHessianQuadraticMinimum_statement',extra=['M正定，K=U″对称正定；一般矩阵。'],missing='一般SPD矩阵逆正定、非零相空间二次型严格正；计划桥接Mathlib矩阵PosDef理论。')
stated('PositiveHessianMinimum','1.5.3',33,[148],r'''In case the eigenvalues of $U''(\boldsymbol q^*)$ are all distinct and positive, then the strong local minimum property will also follow for $\boldsymbol q^*$ in relation to the original potential.''','positiveHessianMinimum_statement',extra=['原文q*是平衡点，∇U=0；U C2；当前正定二次型签名未保留distinct eigenvalue原文条件。'],verdict='NEEDS_HUMAN',missing='需补原文distinct谱条件及正定Hessian局部极小的Taylor余项/二阶判别定理。')

for r in RECORDS:
    if r['source_id']=='MD-1.4-HamiltonFixedMass':
        r['code']='''theorem hamilton_fixed_mass {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q) :
    HasGradientAt (fun v => variableMassHamiltonian (fun _ => M) U q v)
      (matrixAction M⁻¹ p) p ∧
    HasGradientAt (fun x => variableMassHamiltonian (fun _ => M) U x p)
      (gradient U q) q := by
  sorry'''
        r['lean_decl']='MD.Ch01.hamilton_fixed_mass';r['local_verdict']='PASS'
        r['extra_assumptions']=['常质量矩阵M对称正定，来自机械模型满秩坐标变换；U真实可微。']
        r['local_explanation']='保留一般常质量矩阵，两个实际梯度给出全部Hamilton方程分量；旧库对角特例不匹配此忠实签名。'
        r['missing']='一般对称矩阵二次型梯度与矩阵逆正定桥接。'
    if r['source_id']=='MD-1.2-ScalarQuadrature':
        r['code']='''theorem scalar_quadrature (U : ℝ → ℝ) (hU : ContDiff ℝ ∞ U)
    (ξ η : ℝ) (hη : η ≠ 0) :
    ∃ δ > 0, ∃ ε > 0, ∃ V X : ℝ → ℝ → ℝ → ℝ,
      ContDiffOn ℝ ∞ (fun z : ℝ × ℝ × ℝ => V z.1 z.2.1 z.2.2)
        {z | |z.1-ξ| < δ ∧ |z.2.1-ξ| < δ ∧ |z.2.2-η| < δ} ∧
      ContDiffOn ℝ ∞ (fun z : ℝ × ℝ × ℝ => X z.1 z.2.1 z.2.2)
        {z | |z.1| < ε ∧ |z.2.1-ξ| < δ ∧ |z.2.2-η| < δ} ∧
      (∀ ζ κ, |ζ-ξ| < δ → |κ-η| < δ → V ζ ζ κ = κ ∧ X 0 ζ κ = ζ) ∧
      (∀ x ζ κ, |x-ξ| < δ → |ζ-ξ| < δ → |κ-η| < δ →
        scalarPotentialEnergy U (x,V x ζ κ) = scalarPotentialEnergy U (ζ,κ)) ∧
      (∀ x ζ κ v, |x-ξ| < δ → |ζ-ξ| < δ → |κ-η| < δ → |v-η| < δ →
        scalarPotentialEnergy U (x,v) = scalarPotentialEnergy U (ζ,κ) → v = V x ζ κ) ∧
      ∀ t ζ κ, |t| < ε → |ζ-ξ| < δ → |κ-η| < δ →
        HasDerivAt (fun s => X s ζ κ) (V (X t ζ κ) ζ κ) t ∧
        HasDerivAt (fun s => V (X s ζ κ) ζ κ) (-deriv U (X t ζ κ)) t ∧
        separableTimePrimitive (fun x => V x ζ κ) ζ (X t ζ κ) = t := by
  sorry'''
        r['lean_decl']='MD.Ch01.scalar_quadrature';r['local_verdict']='PASS'
        r['local_explanation']='已补完整x,ξ,η联合光滑参数化、局部唯一根、真实解与积分逆等式，未把固定初值局部定理当全条证明。'
        r['extra_assumptions']=['U光滑使原文smooth solutions和联合隐函数成立；η≠0保留原文非转向前提。']
        r['missing']='参数依赖的C∞隐函数与C∞ODE局部流、带参数quadrature逆理论；已有固定初值C1桥接不足。'

add('UniformPairLattice','1.6',33,[149],r'''Let us suppose we have a uniform pair potential $\varphi$ and define the total potential energy of a system of N atoms by
\[U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi(|x_i-x_j|).\]''',
    '''def latticePairPotential {N : ℕ} (φ : ℝ → ℝ) (x : Fin N → ℝ) : ℝ :=
  ∑ i, ∑ j ∈ Finset.Ioi i, φ |x i-x j|''')
stated('UnorderedPairCount','1.6',33,[150],r'''The computation of the energy requires $N(N-1)/2$ separate calculations, which could be very expensive if N is large.''','unorderedPairCount_statement',context=['只形式化无序pair计数；计算成本定性评价不作定理。'],missing='有序双索引lt计数和Nat.choose2组合，计划短证明。')
add('NearestNeighbor','1.6',33,[151],r'''We can reduce this by assuming only nearest neighbor forces, which means the energy becomes
\[U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(|x_{i+1}-x_i|).\]''',
    '''def nearestNeighborModel {N : ℕ} (φ : ℝ → ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  ∑ i : Fin N, φ |x i.succ-x i.castSucc|''',context=['Lean有N+1个site，对应原文N；加一避空首末索引，下同。'])
add('WalledChain','1.6',33,[152],r'''In order to keep such a system bounded we might then introduce walls at the ends of the chain, e.g. by adding confining potentials to $U$:
\[U(x_1,x_2,\ldots,x_N)=\varphi_c(|x_1|)+\varphi_c(|L-x_N|)+\sum_{i=1}^{N-1}\varphi(|x_{i+1}-x_i|).\tag{1.7}\]''',
    '''def walledChainModel {N : ℕ} (φ φc : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  φc |x 0| + φc |L-x (Fin.last N)| + nearestNeighborModel φ x''')
add('PeriodicChain','1.6',33,[153],r'''Alternatively one could restrict to a bounded domain by use of periodic boundary conditions, introducing the potential energy:
\[U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(|x_{i+1}-x_i|)+\varphi(|L+x_1-x_N|).\tag{1.8}\]''',
    '''def periodicChainModel {N : ℕ} (φ : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  nearestNeighborModel φ x + φ |L+x 0-x (Fin.last N)|''')
add('PeriodicBoundary','1.6',34,[154],r'''If a particle moves to the right of $x=L$ we simply shift its position to $x-L$; likewise any particle exiting to the left of $x=0$ has its position shifted to $x+L$ (see Fig. 1.15).''',definition('periodicBoundary'),context=['周期位置等价类：x与x+kL，k∈Z；实际越界wrap代表选择原文只给左右各一步。'])
stated('PeriodicTranslationMomentum','1.6',34,[155],'''Periodic boundary conditions allow us to preserve Newton’s third law, the translational symmetry, and thus the conservation of momentum.''','periodicMomentum_statement',context=['翻译不变模型作用的常向量方向导数零，使总内力零；动量守恒复用MomentumConservation条目。'],missing='从已证平移不变性用实际导数推总力零，再桥接动量；计划短证明。')
add('RegularLattice','1.6',34,[156],r'''On the line, we think of a (finite) lattice as a sequence of discrete points separated by a fixed distance $\Delta x$.''',definition('regularLattice'))
stated('RegularLatticeMinimizerLiteral','1.6',34,[157],'''An obvious benefit of using periodic boundary conditions is that, with a uniform pair potential, the energy minimizers are points of a regular lattice; with confining potentials this is unlikely to be the case.''','regularLatticeMinimizer_statement',issue='对任意uniform φ断言规则格点极小不成立：φ=0时任何非均匀位置都最小；还缺势凸性、排斥、顺序/域资格。',verdict='NEEDS_HUMAN',missing='原文需限定势和配置域；不可证明字面假命题。')
add('PeriodicImages','1.6',35,[158],r'''periodic boundary conditions involve an extended potential energy of the form
\[U^{\mathrm{pbc}}(\boldsymbol q)=\sum_{klm}\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{ij}(\boldsymbol q_i,\boldsymbol q_j+k\boldsymbol v_1+l\boldsymbol v_2+m\boldsymbol v_3),\]
where $k,l,m$ run over $-1,0,1$ (in case interactions are restricted to the simulation cell and its immediate neighboring copies), and $\boldsymbol v_i^T=(L\boldsymbol e_i^T,\ldots,L\boldsymbol e_i^T)$, $i=1,2,3$, where $\boldsymbol e_i$ is the $i$th Euclidean basis vector in $\mathbb R^3$.''',definition('periodicImageEnergy'),context=['Fin3索引减1枚举-1,0,1；逐原子3向量加L(k,l,m)，等价全配置向量重复位移。'])
add('MinimumImage','1.6',35,[159],'''The minimum image convention states that, in computing the force, a given atom interacts only with the nearest replica of any other atom.''',definition('minimumImage'),context=['L>0，minimumImage只定义最近复制体关系，不断言任意选择同一atom自作用。'])
add('RhombicLattice','1.6',35,[160],r'''In 2D, the typical geometry observed at low temperature is defined by a rhombic lattice, with sides of fixed length $n_x,n_y$ and the angle between them ($\theta$), see Fig. 1.17.''',definition('rhombicLattice'),context=['a=nx,b=ny；定义只编码基向量Z线性组合，不声称低温平衡一定如此。'])
add('HexagonalLattice','1.6',35,[161],r'''it can be viewed as a rhombic lattice with $n_x=n_y$ and $\theta=120^\circ$; it can also be viewed as a rhombic lattice with $\theta=60^\circ$''',
    '''def hexagonalLatticeModel (a : ℝ) : Set (Position 2) :=
  rhombicLattice a a (Real.pi/3)''',context=['Fig1.17图注；等长60°/120°两基给同一格。当前def采用60°；120°等价几何需独立证明不作为def存在假设。'])
add('UnitCell','1.6',35,[162],'''The unit cell is a description of the arrangement of atoms within a box; unit cells may be stacked in each direction to describe an atomic lattice.''',definition('unitCellLattice'),context=['B为三基向量矩阵，motif为盒内点集；定义按整数平移重复。'])
exclude([163],'excluded_qualitative：正文p.35只列bcc/fcc/hcp三个名称，p.36图1.19展示几何但无正文bcc函数/定理；不凭常识补造立方角点及体心公式作为逐字原文。')
add('FCCStacking','1.6',36,[164],'''The fcc lattice corresponds to the common arrangement by which cannonballs are stacked into pyramidal structures; it can be viewed as a periodic stacking (ABCABC. . . ) of three hexagonally structured planar layers, as illustrated in Fig. 1.18.''',definition('fccStacking'),extra=['将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。'],verdict='NEEDS_HUMAN',explanation='ABC三周期保留；旧库附带具体几何层高和偏移不是正文逐字公式，需要导师确认图示编码。')
add('HCPStacking','1.6',36,[165],'''Also shown in Fig. 1.18 is the hcp lattice, which, on the other hand, alternates two distinct planar lattices.''',definition('hcpStacking'),extra=['图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。'],verdict='NEEDS_HUMAN',explanation='AB两周期保留；具体几何参数来源图示而非正文公式，需导师确认编码。')
stated('MinimumGradientZero','1.6.1','36–37',[166],r'''Regardless of the choice of boundary and/or the inclusion of non-pairwise potentials, the minimum of the potential energy occurs where
\[\nabla U=0,\]
which gives in general a nonlinear system of $N_c$ equations in $N_c$ unknowns to be solved for the position vector $\boldsymbol q^*$ associated to mechanical equilibrium.''','minimumGradientZero_statement',extra=['可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。'],issue='不限定内点及可微时，Regardless of boundary的全梯度零过强；显式[EXTRA]内点解释。',missing='已有minimumGradientZero_proved可桥接完全一致的内点签名。')
bridge('ForceLinearization','1.6.1',37,[167,168,170],r'''At the equilibrium point, we can linearize the system of differential equations by computing the Hessian matrix, then we find
\[\nabla U(\boldsymbol q)\approx U''(\boldsymbol q^*)(\boldsymbol q-\boldsymbol q^*).\]
Then, letting $\delta\boldsymbol q=\boldsymbol q-\boldsymbol q^*$, $\delta\boldsymbol p$ represent small deviations from the equilibrium point at $(\boldsymbol q,\boldsymbol p)=(\boldsymbol q^*,0)$, we have
\[\frac{\mathrm d\delta\boldsymbol q}{\mathrm dt}=\boldsymbol M^{-1}\delta\boldsymbol p,\qquad\frac{\mathrm d\delta\boldsymbol p}{\mathrm dt}=-U''(\boldsymbol q^*)\delta\boldsymbol q.\]''','MolecularDynamics/Chapter01/EquilibriumLinearization.lean','conservative_mechanical_linearization',extra=['C2，固定对角质量；原文完整常M模型的通用矩阵版本另补。'],verdict='NEEDS_HUMAN',explanation='当前实际导数桥接保留机械块线性化；但签名只对角M且未含平衡∇U=0下梯度小o，须写一般M与小o全子句。')
stated('MinimumHessianLiteral','1.6.1',37,[169],r'''At the minimum of the potential energy, $U''$ is a positive definite symmetric matrix.''','minimumHessianLiteral_statement',issue='局部极小Hessian仅半正定；U(x)=x^4在0为严格极小但二阶导数0。',verdict='NEEDS_HUMAN',missing='字面假命题，不证明；正定需非退化额外假设，不能静默补。')
stated('ImaginarySpectrum','1.6.1',37,[171],r'''The eigenvalues of the matrix
\[\boldsymbol A:=\begin{bmatrix}0&\boldsymbol M^{-1}\\-U''(\boldsymbol q^*)&0\end{bmatrix}\]
are therefore all purely imaginary ($\pm i\Omega$, $\Omega^2\in\mathbb R^+$).''','imaginarySpectrum_statement',extra=['M和Hessian K正定；复谱实虚向量编码。'],verdict='NEEDS_HUMAN',missing='现有签名只实部零，缺±配对和Ω²>0结论，须补齐后PASS；一般SPD Hamiltonian谱理论。')
stated('ComplexNormalMode','1.6.1',37,[172],r'''Associated to each eigenvalue pair we have a pair of complex conjugate eigenvectors $\boldsymbol\xi,\overline{\boldsymbol\xi}$ and also a pair of solutions which can be written in the complex form
\[\boldsymbol z(t)=ae^{i\Omega t}\boldsymbol\xi+be^{-i\Omega t}\overline{\boldsymbol\xi},\]
($a,b$ complex coefficients),''','normalModeComplex_statement',context=['实A确保共轭模式；两个解的复线性组合，未强迫结果为实。'],missing='ComplexEigenmode真实导数及共轭线性作用求和桥接，计划短证明。')
bridge('RealNormalMode','1.6.1',37,[173],r'''or recast in real form as ($\alpha,\beta$ real coefficients):
\[\boldsymbol z(t)=\alpha[\sin(\Omega t)\operatorname{Re}(\boldsymbol\xi)+\cos(\Omega t)\operatorname{Im}(\boldsymbol\xi)]+\beta[\cos(\Omega t)\operatorname{Re}(\boldsymbol\xi)-\sin(\Omega t)\operatorname{Im}(\boldsymbol\xi)].\]''','MolecularDynamics/Chapter01/NormalModes.lean','hasDerivAt_realNormalMode',context=['u=Reξ,v=Imξ，Au=-Ωv、Av=Ωu来自实矩阵复特征向量方程；realNormalMode展开即原式。'])

for r in RECORDS:
    if r['source_id']=='MD-1.5.1-FlowEnergy':
        r['code']='''theorem flow_energy {n : ℕ} (H : PhaseSpace n → ℝ)
    (F : ℝ → PhaseSpace n → PhaseSpace n) (hH : Differentiable ℝ H)
    (hF : ∀ ξ, F 0 ξ = ξ ∧ ∀ t, HasDerivAt (fun s => F s ξ) (symplecticGradient H (F t ξ)) t) :
    ∀ ξ t, H (F t ξ) = H ξ := by
  sorry'''
        r['lean_decl']='MD.Ch01.flow_energy';r['local_verdict']='PASS'
        r['extra_assumptions']=['H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。']
        r['local_explanation']='已改一般H和一般Hamilton流，保留所有初值/时间守恒，未把机械可分离特例当通用证明。'
        r['missing']='一般H的乘积空间Frechet微分分解与Hamilton偏梯度相消；优先短证明。'
    if r['source_id']=='MD-1.5.1-BasisCoefficients':
        r['code']='''theorem basis_coefficients {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    IsUnit (basisColumnMatrix b) ∧ (basisColumnMatrix b).mulVec (b.repr z) = WithLp.ofLp z ∧
    (basisColumnMatrix b)⁻¹.mulVec (WithLp.ofLp z) = b.repr z := by
  exact ⟨basisColumnMatrix_isUnit b, basisColumnMatrix_mulVec_repr b z,
    basisColumnMatrix_inverse_coefficients b z⟩'''
        r['lean_decl']='MD.Ch01.basis_coefficients'
    if r['source_id']=='MD-1.5.2-LocalActionAngleReduction':
        r['code']='theorem local_action_angle_reduction :\n  '+prop('liouvilleArnold_statement')+' := by\n  sorry'
        r['extra_assumptions']=['全部积分C∞且Poisson括号两两零；正则共同能量层紧、连通；满秩=独立。']
        r['local_explanation']='完整保留局部坐标规约及全局环面运动，额外紧/连通资格逐条登记；原文未说这些限制，需导师裁定。'
    if r['source_id']=='MD-1.5.3-PositiveHessianMinimum':
        r['code']='''theorem positive_hessian_minimum {n : ℕ} (U : PotentialEnergy n) (q : Position n)
    (hU : ContDiff ℝ 2 U) (hq : gradient U q = 0)
    (B : Module.Basis (Fin n) ℝ (Position n)) (freq : Fin n → ℝ)
    (hdistinct : Function.Injective freq) (hpos : ∀ i, 0 < freq i)
    (heig : ∀ i, fderiv ℝ (gradient U) q (B i) = freq i • B i) :
    IsStrictPotentialMin U q := by
  sorry'''
        r['lean_decl']='MD.Ch01.positive_hessian_minimum';r['local_verdict']='PASS'
        r['local_explanation']='保留distinct及positive全部谱前提、平衡点与C2背景；不把distinct删掉。实Hessian对称确保可取实特征基。'
        r['extra_assumptions']=['C2与平衡∇U=0来自同节；显式特征基表达全部distinct positive eigenvalues。']
        r['missing']='Hessian谱正定转换与C2二阶Taylor严格极小判别理论。'

for r in RECORDS:
    if r['source_id']=='MD-1.6.1-ForceLinearization':
        r['code']='''theorem force_linearization {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hU : ContDiffAt ℝ 2 U qstar)
    (heq : gradient U qstar = 0) :
    HasFDerivAt (fun z : PhaseSpace n => (matrixAction M⁻¹ z.2, -gradient U z.1))
      (((Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹).comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n))).prod
        ((-fderiv ℝ (gradient U) qstar).comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n))))
      (qstar,0) ∧
    (fun q => gradient U q - fderiv ℝ (gradient U) qstar (q-qstar)) =o[𝓝 qstar]
      (fun q => q-qstar) := by
  sorry'''
        r['lean_decl']='MD.Ch01.force_linearization';r['local_verdict']='PASS'
        r['extra_assumptions']=['真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。']
        r['local_explanation']='一般质量矩阵、真实块Frechet导数及完整小o梯度线性化全部保留，未假设结论。'
        r['missing']='一般矩阵线性作用连续算子与已有conservative_mechanical_linearization拼接；计划短证明。'
    if r['source_id']=='MD-1.6.1-ImaginarySpectrum':
        r['code']='''theorem imaginary_spectrum :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    let A := fun z : PhaseSpace n => (M⁻¹.toEuclideanLin z.2, -K.toEuclideanLin z.1)
    ∀ (a b : ℝ) (x y : PhaseSpace n), (x ≠ 0 ∨ y ≠ 0) →
      A x = a • x - b • y → A y = b • x + a • y →
      a = 0 ∧ 0 < b^2 ∧ A x = -b • y ∧ A (-y) = -b • x := by
  sorry'''
        r['lean_decl']='MD.Ch01.imaginary_spectrum';r['local_verdict']='PASS'
        r['local_explanation']='补齐实部零、非零频率平方正及共轭实虚特征对给出的±ib配对；一般SPD M,K保留。'
        r['missing']='一般SPD块Hamiltonian谱的相似反自伴算子理论；对角/单个normal mode证明不足。'
    if r['source_id']=='MD-1.6.1-MinimumGradientZero':
        r['code']=r['code'].replace('  sorry','  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved')
        r['missing']=None;r['priors']=['MolecularDynamics/Chapter01/ReviewProofs.lean:minimumGradientZero_proved']

# Complete easily overlooked clauses before admitting a local PASS.
for r in RECORDS:
    if r['source_id']=='MD-1.2-HarmonicSolution':
        r['code']='''theorem harmonic_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
      univ univ (fun t => harmonicFlow Ω t z) ∧
    harmonicFlow Ω 0 z = z ∧
    ∀ t, (harmonicFlow Ω t z).1 = Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2 := by
  exact ⟨harmonicFlow_isMechanicalSolution Ω hΩ z, harmonicFlow_zero Ω z, fun _ => rfl⟩'''
        r['lean_decl']='MD.Ch01.harmonic_solution'
    if r['source_id']=='MD-1.2-LJCoordinateScaling':
        r['code']='''theorem lj_coordinate_scaling (Q : ℝ → V3) (σ t : ℝ) (v a : V3)
    (hσ : 0 < σ) (hv : HasDerivAt Q v t) (ha : HasDerivAt (deriv Q) a t) :
    HasDerivAt (fun s => σ • Q s) (σ • v) t ∧
    HasDerivAt (fun s => σ • deriv Q s) (σ • a) t ∧
    ∀ r s : V3, ‖σ • r - σ • s‖ = σ * ‖r-s‖ := by
  refine ⟨hv.const_smul σ, ha.const_smul σ, ?_⟩
  intro r s
  rw [← smul_sub, norm_smul, Real.norm_eq_abs, abs_of_pos hσ]'''
        r['lean_decl']='MD.Ch01.lj_coordinate_scaling';r['local_verdict']='PASS'
        r['local_explanation']='实际导数缩放与全部距离缩放结论均已保留；σ正保证原文范数缩放不缺绝对值。';r['missing']=None
    if r['source_id']=='MD-1.2-LJTimeScaling':
        r['code']=r['code'].replace('∀ (N : ℕ)', '∀ (N : ℕ)',1).replace('∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i)',
            '∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i) ∧\n    α⁻¹ = σ * Real.sqrt (m / ε)')
        # Parenthesize the iff as a conjunct, rather than letting ∧ bind only to its right.
        r['code']=r['code'].replace('((∀ t i, m •', '(((∀ t i, m •').replace('ljForce 1 1 (Q τ) i) ∧','ljForce 1 1 (Q τ) i)) ∧')
        r['local_verdict']='PASS';r['local_explanation']='修正旧遗漏后，保留真实时间二阶缩放双向等价及单位时间α⁻¹=σ√(m/ε)；原文数值近似不作为形式化精度定理。'

for r in RECORDS:
    if r['source_id']=='MD-1.2-ConstraintDimension':
        r['code']=r['code'].replace('  sorry', '  intro n r C q _ hs\n  have hrange : LinearMap.range (fderiv ℝ C q).toLinearMap = ⊤ :=\n    LinearMap.range_eq_top.mpr hs\n  have h := (fderiv ℝ C q).toLinearMap.finrank_range_add_finrank_ker\n  rw [hrange] at h\n  simpa [degreesOfFreedom, Position, finrank_euclideanSpace, Nat.add_comm] using h')
        r['missing']=None
    if r['source_id']=='MD-1.2-PairCancellation':
        r['code']=r['code'].replace('  sorry', '''  intro N F _ hanti
  have h : (∑ i, ∑ j, F i j) = -(∑ i, ∑ j, F i j) := by
    calc
      (∑ i, ∑ j, F i j) = ∑ j, ∑ i, F i j := Finset.sum_comm
      _ = ∑ j, ∑ i, -F j i := by
        apply Finset.sum_congr rfl
        intro j _
        apply Finset.sum_congr rfl
        intro i _
        exact hanti i j
      _ = -(∑ j, ∑ i, F j i) := by simp only [Finset.sum_neg_distrib]
  have hcoord (k : Fin 3) : (∑ i, ∑ j, F i j) k = 0 := by
    have hk := congrArg (fun v : V3 => v k) h
    simp only [PiLp.neg_apply] at hk
    linarith
  ext k
  exact hcoord k''')
        r['missing']=None

add('PlanarTrimerModel','1.7',38,[],r'''One of the simplest illustrations of the chaotic nature of molecular systems is given by the Lennard-Jones model consisting of just three atoms with motion restricted to the plane. The energy is
\[E=K+U=\frac{\|\dot{\boldsymbol q}_1\|^2}{2}+\frac{\|\dot{\boldsymbol q}_2\|^2}{2}+\frac{\|\dot{\boldsymbol q}_3\|^2}{2}+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_1-\boldsymbol q_2\|)+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_2-\boldsymbol q_3\|)+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_1-\boldsymbol q_3\|),\]
with the interatomic interaction given by $\hat\varphi_{\mathrm{LJ}}(r)=4[r^{-12}-r^{-6}]$.''',
    '''def planarTrimerEnergy (q v : Fin 3 → Position 2) : ℝ :=
  (∑ i, ‖v i‖^2/2) + lennardJonesPotential 1 1 ‖q 0-q 1‖ +
    lennardJonesPotential 1 1 ‖q 1-q 2‖ + lennardJonesPotential 1 1 ‖q 0-q 2‖''',
    label='Example 1.8 (Planar Lennard-Jones Trimer)',context=['单位质量、平面R²、非碰撞物理域；inverse整数幂与(1/r)^k等价。'])
add('CentralPairPotential','1.7',38,[174],r'''In general, when the total potential is a sum of distance potentials
\[U=\frac12\sum_{i\ne j}U_{ij},\]
where $U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=\varphi_{ij}(\|\boldsymbol q_i-\boldsymbol q_j\|)$, we say that the system has central forces.''',definition('centralPairEnergy'),context=['φᵢⱼ=φⱼᵢ为同一无序对相互作用；qᵢ≠qⱼ和径向势可微用于后续导数，不是本定义存在条件。'])
stated('CentralPairGradient','1.7',38,[175],r'''In this case,
\[\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\]''','centralPairGradient_statement',extra=['势在非碰撞距离可微；partial为欧氏梯度。'],missing='范数链式法则和反向仿射变量替换的梯度桥接，计划短证明。')
bridge('CentralMomentum','1.7',39,[176],r'''and so, for central forces,
\[\sum_{i=1}^N m_i\ddot{\boldsymbol q}_i=0,\]
which expresses the constancy of the momentum.''','MolecularDynamics/Chapter01/MomentumConservation.lean','totalMomentumCoordinate_const_on_Ioo',extra=['逐对作用反对称推出净力零；真实Newton解和连通时间区间。'],context=['∑mᵢq̈ᵢ=0为PairCancellation及IsMechanicalSolutionOn的组合；bridge结论对每坐标守恒即整个向量守恒。'])
stated('CentralAngularMomentum','1.7',39,[177],r'''Moreover, viewing the $\boldsymbol q_i$ as vectors in $\mathbb R^3$ (with 0 as their third component),
\[\boldsymbol q_i\times\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\boldsymbol q_j\times\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\]
which implies
\[\frac{\mathrm d}{\mathrm dt}\sum_{i=1}^N\boldsymbol q_i\times(m_i\dot{\boldsymbol q}_i)=0,\]
and tells us that the total angular momentum is also conserved.''','totalAngularMomentum_statement',extra=['真实位置和动量导数；反对称内力和沿位移方向中心力。'],context=['cross3为欧氏3D叉积；原文平面嵌入是特例，当前一般3D。'],missing='叉积双线性导数、有限双和反对称力矩相消；尚须完整中心势到力矩零的桥接。')
stated('CenterOfMassMotion','1.7',39,[178],'''This means that the system will translate and rotate at a constant rate in time.''','centerOfMassMotion_statement',extra=['质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。'],context=['本条仅translation；rotation字面部分分开保留下一条。'],missing='有限和真实导数与总动量常数的仿射轨迹桥接，计划短证明。')
stated('ConstantRotationLiteral','1.7',39,[179],'''This means that the system will translate and rotate at a constant rate in time.''','rotationLiteral_statement',verdict='NEEDS_HUMAN',issue='角动量常数不推出角速度常数；中心运动r变时θ̇=ℓ/r²。例r(t)=sqrt(1+t²),θ(t)=arctan t,ℓ=1。',missing='字面推论假，需导师裁定为定性旋转描述或修正为角动量守恒。')
add('IsoscelesCoordinates','1.7',39,[180],r'''Let us introduce new coordinates in the Lennard-Jones trimer as illustrated in Fig. 1.21, so that the center of mass is fixed at the origin: that is,
\[\boldsymbol q_1=\begin{bmatrix}x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_2=\begin{bmatrix}-x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_3=\begin{bmatrix}0\\2y/3\\0\end{bmatrix},\]''',definition('isoscelesCoordinates'),context=['单位质量；质心固定及等腰约束是特定对称初值，非所有零角动量三体配置。'],issue='同段“零平动/角动量→等腰”一般过强；这里只定义明确给定的对称配置，不把任意零动量当等腰。')
add('IsoscelesEnergyReduction','1.7',39,[181],r'''reducing the energy to
\[E=\dot x^2+\frac{\dot y^2}{3}+2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x),\]
which describes the vibrational motion.''',
    '''theorem isosceles_energy_reduction (x y v w : ℝ) (hx : 0 < x) :
    (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) +
      uniformLJEnergy 1 1 (isoscelesCoordinates x y) = isoscelesEnergy x y v w := by
  sorry''',kind='unnumbered_claim',extra=['单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。'],missing='具体Fin3向量范数平方与距离的代数计算；计划短证明。')
stated('IsoscelesAccessibleRegion','1.7',40,[182],r'''kinetic energy is non-negative, we must have
\[2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x)\le E.\]''','isoscelesEnergyBound_statement',prior=['MolecularDynamics/Chapter01/ReviewProofs.lean:isoscelesEnergyBound_proved'])
RECORDS[-1]['code']=RECORDS[-1]['code'].replace('  sorry','  exact MolecularDynamics.Chapter01Review.isoscelesEnergyBound_proved');RECORDS[-1]['missing']=None
stated('EquilateralTrimerMinimum','1.7',38,[203],r'''The global minimum of this simple system must be radially symmetric. Placing the atoms at the vertices of an equilateral triangle, we have
\[U=3\hat\varphi_{\mathrm{LJ}}(r),\]
where $r$ is the length of a side. This is minimized when $r=2^{1/6}\approx1.1225$.''','trimerMinimum_statement',label='Example 1.8 (Planar Lennard-Jones Trimer)',extra=['单位LJ；非碰撞配置。'],missing='LJ井底唯一性rpow与三条距离同时达到井底的等边几何；计划短证明后缺项记录。')
stated('TrimerEnergyLowerBound','1.7',40,[204],r'''(When $E>0$, the bodies eventually escape to infinity; $E<-3$ is not attainable.)''','trimerLowerBound_statement',context=['本条为E<-3不可达；E>0逃逸下一条字面保留。'],prior=['MolecularDynamics/Chapter01/ReviewProofs.lean:trimerLowerBound_proved'])
RECORDS[-1]['code']=RECORDS[-1]['code'].replace('  sorry','  exact MolecularDynamics.Chapter01Review.trimerLowerBound_proved');RECORDS[-1]['missing']=None
add('CollinearTrimer','1.7',40,[205],r'''Arranging the three atoms in a collinear configuration ($y=0$) the potential energy becomes $\hat U=\hat U(x)=2\hat\varphi_{\mathrm{LJ}}(x)+\hat\varphi_{\mathrm{LJ}}(2x)$.''',definition('collinearTrimer'),context=['x>0；本def逐字记录共线模型。'])
stated('TrimerSaddle','1.7','40–41',[206],r'''Minimizing the potential in the collinear configuration allows us to determine the saddle point $(x^*,0)$. Near this point, $U$ decreases if we move in the $\pm y$ direction and increases if we move in the $\pm x$ direction.''','trimerSaddle_statement',extra=['x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。'],missing='有理LJ势驻点根与二维严格鞍点的符号二阶导数计算。')
stated('TrimerEscapeLiteral','1.7',40,[207],r'''(When $E>0$, the bodies eventually escape to infinity; $E<-3$ is not attainable.)''','trimerEscapeLiteral_statement',verdict='NEEDS_HUMAN',issue='原文正能量必逃逸缺论证；现有字面Prop仅至少一对距离趋∞，不保证每个body均逃逸，须裁定对象和限定。',missing='全局三体散射/逃逸理论；字面every body与至少一对分离的差距不能冒充完整证明。')
add('ChaosConditions','1.7.1','41–42',[183,184,185],r'''Typical definitions of a “chaotic dynamical system” [103] require at least the following conditions to be satisfied on the phase space $D$:
• The solutions depend sensitively on the initial data taken from $D$;
• The flow is topologically transitive in $D$.
The second condition states that given arbitrarily small neighborhoods $D_1$ and $D_2$ of two different points in $D$ then it is possible to find a trajectory that goes from some point of $D_1$ to some point of $D_2$.''',definition('chaosConditions'),extra=['敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。','topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。'],verdict='NEEDS_HUMAN',explanation='两必要性质及transitivity邻域关系保留；敏感依赖正文随后“given pair rapidly grows”不是标准存在扰动量词，需导师确认数学化选择。')
stated('TransitivityErgodicityLiteral','1.7.1',42,[186],'''We will see later that this concept, which is essentially equivalent to ergodicity, is a crucial component of molecular theories.''','transitivityErgodicityLiteral_statement',extra=['为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。'],verdict='NEEDS_HUMAN',issue='拓扑传递和给定测度遍历通常不等价；μ=0时identity流遍历为真而传递为假。非退化概率测度也需进一步限定。',missing='字面等价不成立；不通过新增结论前提修补。')
add('AnisotropicOscillator','1.7.1',42,[187,188,189],r'''Consider the system with energy
\[E(x,y,\dot x,\dot y)=\frac12(\dot x^2+\dot y^2)+\frac{\kappa(c_3)}2(r-l(c_3))^2,\qquad r=\sqrt{x^2+y^2},\tag{1.9}\]
where
\[c_3=\cos(3\theta)\]
is defined in terms of the angular coordinate of the position $(x,y)$ with respect to the $(1,0)$-direction,
\[\cos\theta=c=\frac xr,\qquad c_3=4c^3-3c,\]
and we have defined
\[\kappa(c_3)=\kappa_0(1-\tfrac12\epsilon c_3),\qquad l(c_3)=l_0(1+\tfrac12\epsilon c_3).\]''',definition('anisotropicEnergy'),label='Example 1.9 (Anisotropic Oscillator)',context=['anisotropicAngular及anisotropicParameters是本定义依赖公式；r>0；c3三倍角关系须单独核对。','原文κ按PDF字形抄；数值实验κ₀=l₀=1、ε变化不转成全称轨迹定理。'],extra=['定义在r=0用Lean总函数延拓，物理域r>0。'])
add('FlowJacobianLiteral','1.7.2',44,[190,191],r'''Let a dynamical system $\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z)$ be given in $\mathbb R^m$ with flow map $F_t:\mathbb R^m\to\mathbb R^m$ which we assume to be continuously differentiable. Let $\boldsymbol z(t,\boldsymbol\xi)$ represent the solution of initial value problem
\[\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi.\]
We then compute the $m\times m$ Jacobian matrix of $F_t(\boldsymbol z(t,\boldsymbol\xi))$:
\[\boldsymbol W(t)=F_t'(\boldsymbol z(t,\boldsymbol\xi))=\frac{\partial F_t}{\partial\boldsymbol z}(\boldsymbol z(t,\boldsymbol\xi)).\]''',definition('variationalMatrixLiteral'),context=['F为C1真实flow，z(t,ξ)=Ftξ；原文字面在Ftξ处对初值变量微分。'],issue='标准变分矩阵应为DξFt(ξ)，原文把取值点写Ftξ；忠实保留字面定义，后续两条不静默改。')
stated('VariationalEquationLiteral','1.7.2','44–45',[192],r'''Differentiating $\boldsymbol W(t)$ with respect to $t$ and using the differential equation and the chain rule, we have
\[\frac{\mathrm d}{\mathrm dt}\boldsymbol W(t)=\boldsymbol f'(\boldsymbol z(t,\boldsymbol\xi))\boldsymbol W(t).\tag{1.10}\]
The system of Eq. (1.10) is referred to as the system of variational equations corresponding to the dynamical system $\mathrm d\boldsymbol z/\mathrm dt=\boldsymbol f(\boldsymbol z)$.''','variationalEquationLiteral_statement',verdict='NEEDS_HUMAN',issue='前条字面W=D Ft(Ftξ)多出取值点移动链式项。局部标量f(z)=z²,Ftξ=ξ/(1-tξ)：W=(1-tξ)²/(1-2tξ)²；t=0的W′=2ξ相合，但t≠0一般不满足原式。',missing='需导师确认取值点勘误；修正后一般非线性参数导数交换亦需理论，常系数已有证明不足。')
add('NearbyTrajectoryLiteral','1.7.2',45,[193],r'''If we have two solutions started from nearby initial conditions $\boldsymbol\xi,\hat{\boldsymbol\xi}$, then their difference is approximated by the solution of the variational equations
\[\boldsymbol z(t,\hat{\boldsymbol\xi})-\boldsymbol z(t,\boldsymbol\xi)\approx\boldsymbol W(t)(\hat{\boldsymbol\xi}-\boldsymbol\xi).\]''',
    '''theorem nearby_trajectory_literal :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  sorry''',kind='unnumbered_claim',extra=['≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。'],verdict='NEEDS_HUMAN',issue='原文字面W在Ftξ而不是ξ；前条非线性流提供不同Jacobian的反例，不能用修正版flowFirstOrder_proof冒充。',missing='等待导师判断W取值点勘误，修正版由可微定义直接推出。')
add('SingularValues','1.7.2',45,[194],r'''The square roots of the eigenvalues of $\boldsymbol A^T\boldsymbol A$, also called the singular values of $\boldsymbol A$, then give the axes of the image ellipsoid.''',definition('singularValues'),context=['有限维实矩阵；非负、largest-to-smallest顺序及正交对角化刻画全部谱，顺序原文随后给出。'],extra=['用存在正交特征基刻画谱关系；不是以要证明的椭球图像结论为假设。'])
stated('SingularEllipsoid','1.7.2',45,[195],r'''We may view a regular linear mapping $\boldsymbol v\mapsto\boldsymbol A\boldsymbol v$, where $\boldsymbol A\in\mathbb R^{m\times m}$, as a mapping of an $m-1$-dimensional sphere (embedded in the $m$-dimensional Euclidean space) to an ellipsoid in the same space (Fig. 1.26). The square roots of the eigenvalues of $\boldsymbol A^T\boldsymbol A$, also called the singular values of $\boldsymbol A$, then give the axes of the image ellipsoid.''','singularEllipsoid_statement',extra=['regular=可逆；单位球面，正交主轴O及半轴σ；平移/半径可按线性缩放恢复。'],missing='一般实矩阵奇异值分解与逆矩阵球面像几何理论。')
add('LyapunovExponents','1.7.2',45,[196],r'''The Lyapunov exponents $\lambda_1,\lambda_2,\ldots,\lambda_m$ are defined by
\[\lambda_i=\limsup_{t\to\infty}\frac1t\log\sigma_i(\boldsymbol W),\]
where $\sigma_i$ represents the ith singular value of the given matrix (to maintain continuity, these should be ordered in some way, say largest to smallest).''',definition('lyapunovExponent'),context=['σ:time→ith ordered singular value ofW(t)；与前条singularValues相接。'],extra=['扩展实数EReal允许±∞，原文未保证极限有限；σ(t)>0在可逆流Jacobian背景，避免log0。'])
stated('PositiveLyapunovGrowth','1.7.2',45,[197],'''The presence of a positive Lyapunov exponent implies exponential growth of perturbations, which, as we have seen, is one of the hallmarks of chaos.''','positiveLyapunovGrowth_statement',extra=['依据limsup只能得到任意晚时间仍有指数放大，即无穷时间子列；不添加所有足够大t统一增长。'],context=['σ来自实际W奇异值；大小增长描述无穷小扰动算子，有限扰动在有界相域会饱和。'],missing='EReal limsup的无穷晚超阈值与log/exp严格不等式桥接；一般Lyapunov存在性/可测谱理论不在本条证明内。')

for r in RECORDS:
    if r['source_id']=='MD-1.6-HexagonalLattice':
        r['code']='''theorem hexagonal_lattice_two_bases (a : ℝ) :
    rhombicLattice a a (2*Real.pi/3) = rhombicLattice a a (Real.pi/3) := by
  sorry'''
        r['lean_decl']='MD.Ch01.hexagonal_lattice_two_bases';r['kind']='unnumbered_claim'
        r['missing']='60°/120°基向量三角函数值及整数基替换；计划短证明。'
    if r['source_id']=='MD-1.7-TrimerEscapeLiteral':
        r['code']=r['code'].replace('∃ i j : Fin 3, i ≠ j ∧ Tendsto (fun t => pairDistance (q t i) (q t j)) atTop atTop',
            '∀ i : Fin 3, Tendsto (fun t => ‖q t i‖) atTop atTop')
        r['issues'][0]['detail']='保留原文每个body最终逃逸到∞的字面结论及前段质心固定、等腰、零角动量背景；正能量到散射的论证缺失，待导师裁定。'
    if r['source_id']=='MD-1.7-CentralAngularMomentum':
        r['code']=r['code'].replace('∀ t ∈ I, HasDerivAt',
            '(∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧\n    ∀ t ∈ I, HasDerivAt',1)
    if r['source_id']=='MD-1.6-PeriodicTranslationMomentum':
        r['code']='''theorem periodic_translation_momentum :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ),
    let U := boxPeriodicNearestNeighborPotentialEnergy φ L
    (∀ q c, U (fun i => q i+c) = U q) ∧
    (∀ q, DifferentiableAt ℝ U q → fderiv ℝ U q (fun _ => 1) = 0) ∧
    ∀ (m : Fin (N+1) → ℝ) (q v : ℝ → Fin (N+1) → ℝ) (I : Set ℝ),
      IsOpen I → IsPreconnected I → (∀ i, 0 < m i) →
      (∀ t ∈ I, DifferentiableAt ℝ U (q t)) →
      (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t ∧
        HasDerivAt (fun s => m i*v s i) (-fderiv ℝ U (q t) (Pi.single i 1)) t) →
      (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i*v s i) 0 t) ∧
      ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i*v a i) = ∑ i, m i*v b i := by
  sorry'''
        r['lean_decl']='MD.Ch01.periodic_translation_momentum'
        r['extra_assumptions']=['一维周期链真实Newton导数、正质量、势沿轨迹可微及开连通时间域。']
        r['local_explanation']='补齐全平移不变、净力零真实导数与动量守恒；Newton第三定律为相邻差值势的反向partial，CentralPairGradient另条编码，不把动量结论当假设。'
        r['missing']='平移轨迹链式法则、基向量和为常1的fderiv线性作用、有限和零导数及连通域常数桥接。'

def write_section(section):
    from ch01_full_proofs import PROOFS
    for r in RECORDS:
        if r['source_id'] in PROOFS:
            assert r['local_verdict']=='PASS'
            r['code']=r['code'].replace('  sorry',PROOFS[r['source_id']])
    original=json.loads((BASE/'ch01_source.json').read_text(encoding='utf-8-sig'))
    ids={r['source_id'] for r in RECORDS if r['section'].startswith(section)}
    new=[r for r in RECORDS if r['section'].startswith(section)]
    clean=[r for r in original if r['source_id'] not in ids]+[
        {k:v for k,v in r.items() if k not in ('code','local_verdict','local_explanation','priors','missing')} for r in new]
    (BASE/'ch01_source.json').write_text(json.dumps(clean,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    lean_path=ROOT/'Blueprint/Ch01.lean'
    text=lean_path.read_text(encoding='utf-8-sig')
    if 'open MeasureTheory' not in text:
        text=text.replace('namespace MD.Ch01','namespace MD.Ch01\nopen MeasureTheory',1)
    for r in new:
        for prior in r['priors']:
            if prior.startswith('MolecularDynamics/') and '.lean:' in prior:
                module=prior.split('.lean:')[0].replace('/','.')
                if 'import '+module+'\n' not in text: text='import '+module+'\n'+text
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
