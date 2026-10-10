"""Chapter 2 verbatim source records and explicitly audited Lean declarations."""
from pathlib import Path
import re
ROOT=Path(__file__).resolve().parents[1]
BASE=ROOT/'blueprint/ch02'
RECORDS=[]
EXCLUDED=[]

def add(key,section,page,old,text,code,*,kind='unnumbered_claim',label=None,proof=None,
        context=(),extra=(),issues=(),verdict='PASS',explanation='',prior=(),missing=None,
        correspondence=(),discussion=None,proof_note=None):
    pages=str(page); nums=[int(n) for n in re.findall(r'\d+',pages)]
    pdf='–'.join(str(n+22) for n in nums)
    decl=re.search(r'\b(?:def|theorem)\s+(\w+)',code).group(1)
    sid='MD-'+section+'-'+key
    RECORDS.append(dict(source_id=sid,kind=kind,label=label,section=section,
        printed_page=pages,pdf_page=pdf,statement_latex=text,proof_latex=proof,
        proof_note=proof_note or ('原书未给独立完整证明。' if proof is None else '原书计算按原页转录。'),
        proof_discussion_latex=discussion,context_notation=list(context),issues=list(issues),
        lean_decl='MD.Ch02.'+decl,reusable_proofs=list(prior),extra_assumptions=list(extra),
        statement_scope='本条所引原句及展示公式；单个记号归入context_notation。',
        review_status='DRAFT',repair_log=[],source_page_verification='VERIFIED_RENDERED; source_page_checks.json',
        old_ids=['CH02-'+str(i).zfill(3) for i in old],code=code,local_verdict=verdict,
        local_explanation=explanation or '已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。',
        priors=list(prior),missing=missing,correspondence=list(correspondence)))

def copied(relative,name,newname=None,prove=True):
    """Reuse a library signature exactly, with a genuine theorem bridge."""
    text=(ROOT/relative).read_text(encoding='utf-8-sig')
    m=re.search(r'(?m)^(?:noncomputable )?(def|theorem|lemma) '+re.escape(name)+r'\b',text)
    if not m:raise ValueError((relative,name))
    start=m.start(); stop=re.search(r'\n(?:(?:noncomputable )?(?:def|abbrev|theorem|lemma|end)\b|/--|/-!)',text[m.end():])
    end=m.end()+stop.start() if stop else len(text)
    if m.group(1)=='def':
        # Definitions can contain blank lines only after their body in these inputs.
        block=text[start:end if end>=0 else len(text)].strip()
        return re.sub(r'\bdef '+re.escape(name)+r'\b','def '+(newname or name),block,count=1)
    match=re.search(r'\s:=\s*(?:by\b)?',text[m.end():])
    if not match:raise ValueError('theorem body boundary '+name)
    signature=text[start:m.end()+match.start()].strip()
    signature=re.sub(r'^(theorem|lemma) '+re.escape(name), 'theorem '+(newname or name),signature)
    namespace=re.findall(r'(?m)^namespace ([\w.]+)',text[:start])[-1]
    # Let elaboration apply the existing theorem to all explicit arguments.
    return signature+' := by\n  '+('apply '+namespace+'.'+name+' <;> assumption' if prove else 'sorry')

def proposition(name,newname=None,proof='sorry'):
    text=(ROOT/'MolecularDynamics/Chapter02/Statements.lean').read_text(encoding='utf-8-sig')
    m=re.search(r'(?m)^def '+re.escape(name)+r'\s*: Prop :=\n',text)
    end=text.find('\ndef ',m.end())
    body=text[m.end():end if end>=0 else text.rfind('end MolecularDynamics')].strip()
    return 'theorem '+(newname or name.removesuffix('_statement'))+' :\n  '+body+' := by\n  '+proof

add('HamiltonianODE','2',53,[1],r'''The challenge before us is to compute solutions of
\[\dot{\boldsymbol q}=M^{-1}\boldsymbol p,\qquad \dot{\boldsymbol p}=F(\boldsymbol q)=-\nabla U(\boldsymbol q),\]
or, more compactly, with $\boldsymbol z$ representing the collection of all positions and momenta,
\[\dot{\boldsymbol z}=f(\boldsymbol z),\qquad f(\boldsymbol z)=J\nabla H.\tag{2.1}\]''',
'''def hamiltonianODE {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t''',kind='definition',
context=[r'$\boldsymbol z=(\boldsymbol q,\boldsymbol p)$；$J$及$H$见同页下两条；n为配置坐标数。'],
extra=['原文ODE按时间域I逐点解释；只定义关系，不宣称解存在。'])
add('Hamiltonian','2',53,[2],r'''and $H=\boldsymbol p^TM^{-1}\boldsymbol p/2+U(\boldsymbol q)$ is the Hamiltonian.''',
'''def mechanicalHamiltonian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n) :
    PhaseSpace n → ℝ := massHamiltonian m U''',kind='definition',
context=[r'$M$为第1章固定对角质量矩阵；$\boldsymbol q,\boldsymbol p\in\mathbb R^n$。'],
extra=['固定对角质量的机械模型来自第1章；一般非对角矩阵不纳入此复用接口。'])
add('CanonicalJ','2',53,[3],r'''where $J=\begin{bmatrix}0&I\\-I&0\end{bmatrix}$,''',
'''def canonicalJ (n : ℕ) : Matrix (Sum (Fin n) (Fin n)) (Sum (Fin n) (Fin n)) ℝ :=
  textbookJ n''',kind='definition',context=[r'$I$为$n\times n$单位阵；教材符号顺序$(q,p)$。'])
add('Euler','2',54,[4],r'''The simplest scheme is certainly Euler’s method which advances the solution from timestep to timestep by the formula
\[\boldsymbol z_{n+1}=\boldsymbol z_n+hf(\boldsymbol z_n).\]''',
'''def euler {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (h : ℝ) (z : E) : E := z + h • f z''',kind='definition',context=[r'$h$为步长；下标$n$为时间步而非向量分量。'])
add('OneStep','2',54,[5,6],r'''Suppose that the system under study has a well defined flow map $\mathcal F_t$ defined on the phase space (which is assumed to exclude any singular points of the potential energy function). The solution of the initial value problem, $\dot{\boldsymbol z}=f(\boldsymbol z)$, $\boldsymbol z(0)=\boldsymbol\zeta$, may be written $\boldsymbol z(t;\boldsymbol\zeta)$ (with $\boldsymbol z(0;\boldsymbol\zeta)=\boldsymbol\zeta$), and the flow-map $\mathcal F_t$ satisfies $\mathcal F_t(\boldsymbol\zeta)=\boldsymbol z(t;\boldsymbol\zeta)$: A one-step method, starting from a given point, approximates a point on the solution trajectory at a given time $h$ units later. Such a method defines a map $\mathcal G_h$ of the phase space as illustrated in Fig. 2.1.''',
'''def numericalTrajectory {E : Type*} (G : ℝ → E → E) (h : ℝ) (ζ : E) (n : ℕ) : E :=
  (G h)^[n] ζ''',kind='definition',context=[r'$\mathcal F_t(\zeta)$为给定实际ODE解；$\mathcal G_h$为单步近似映射；近似质量由后面的误差定义衡量。'],
explanation='定义只记录给定单步映射的有限迭代，不将任意映射称为收敛近似或宣称全球流存在。')
add('Convergence','2.1',55,[7],'''The convergence of a numerical method refers to the ability of the method to provide an arbitrary level of accuracy by using small enough timesteps.''',
'''def convergence {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  Tendsto (fun ν : ℕ => oneStepMaxError G (τ / ν) γ ν) atTop (𝓝 0)''',kind='definition',
context=[r'固定有限时间窗$[0,\tau]$，$h=\tau/\nu$，最大节点误差见p.56/PDF78。'],extra=['按固定时间窗网格h=τ/ν表达任意精度；τ>0在具体定理中明示。'])
add('Order','2.1',55,[8],r'''The order of accuracy is the exponent in the power law by which the error in the method is related to the stepsize. For example, when we say that a method is third order accurate, we mean that the global error (on a fixed finite time interval) can be bounded by $Kh^3$, where $h$ is a sufficiently small timestep and $K$ is a number which depends on the length of the time interval and the features of the problem, but which is independent of $h$.''',
'''def order {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (r : ℕ) : Prop :=
  ∃ K > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
    oneStepMaxError G (τ / ν) γ ν ≤ K * (τ / ν)^r''',kind='definition',context=[r'$r=3$为原文例子；定义扩展到一般自然数阶$r$，$h=\tau/\nu$。'],extra=['自然数阶r；ν₀>0避免零除；K选择严格正不损失误差上界。'])
add('Error','2.1',56,[9,10,11],r'''Let the approximate solution vectors at successive timesteps be $\boldsymbol z_0,\boldsymbol z_1,\ldots,\boldsymbol z_\nu$ where $\nu h=\tau$. We assume that $\tau$, the length of the time interval, is fixed, and $\nu$ is an integer parameter representing the total number of timesteps. In order to improve the quality of the approximation, the parameter $\nu$ may be increased, as the stepsize is proportionately decreased. The error at step $n$ is defined by $e_n=\|\boldsymbol z_n-\boldsymbol z(t_n)\|$, where $t_n=nh$; it clearly depends on $h$.''',
'''def maximumError {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G : ℝ → E → E) (γ : ℝ → E) (h : ℝ) (ν : ℕ) : ℝ :=
  oneStepMaxError G h γ ν''',kind='definition',context=[r'$\bar e=\max_{0\le n\le\nu} e_n$来自紧接Theorem2.1；$t_n=nh$，含n=0。'])
add('Thm2.1','2.1',56,[12,13],r'''Let $\mathcal D$ be a bounded, open region in $\mathbb R^m$ such that $f:\mathcal D\to\mathbb R^m$ is continuously differentiable. Let $\boldsymbol\zeta$ be an interior point of $\mathcal D$ and suppose the initial value problem (2.1) has a unique solution that remains in $\mathcal D$ for $t\in[0,\tau]$. Then there exists a constant $C(\tau)>0$ such that for sufficiently large $\nu\in\mathbb N$ the numerical solution $\boldsymbol z_n$ remains in $\mathcal D$ for $n=0,1,\ldots,\nu$, where $h\nu=\tau$, and, moreover, the maximum global error in Euler’s method satisfies
\[\bar e:=\max_{0\le n\le\nu}e_n\le C(\tau)h.\]''',
'''theorem theorem_2_1 {m : ℕ} (D : Set (Position m))
    (hDb : Bornology.IsBounded D) (hD : IsOpen D)
    (f : Position m → Position m) (hf : ContDiffOn ℝ 1 f D)
    (γ : ℝ → Position m) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t)
    (_hunique : ∀ η : ℝ → Position m, η 0 = γ 0 → MapsTo η (Icc 0 τ) D →
      (∀ t ∈ Icc 0 τ, HasDerivWithinAt η (f (η t)) (Icc 0 τ) t) →
      ∀ t ∈ Icc 0 τ, η t = γ t) :
    ∃ C : ℝ, 0 < C ∧ ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      (∀ n ≤ ν, eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D) ∧
        eulerMaxError f (τ / (ν : ℝ)) γ ν ≤ C * (τ / (ν : ℝ)) := by
  exact MolecularDynamics.theorem_2_1_euler D hDb hD f hf γ hτ hγD hγ''',kind='theorem',label='Theorem 2.1',
context=[r'$\zeta=\gamma(0)$，$e_n$和$h=\tau/\nu$见同页上段；Euler单步见p.54/PDF76。'],
extra=['时间长度τ≥0显式化；f以环境全函数表示，只在开放D上要求C¹。'],prior=['MolecularDynamics.theorem_2_1_euler'],
correspondence=[dict(source='有界开放D、f C¹、初值内部及唯一实际解',lean='hDb,hD,hf,hγD,hγ,_hunique；ζ=γ0',note='一致；唯一性保留但桥接证明不需使用'),dict(source='足够大ν后每个n≤ν数值留域，最大误差≤Ch',lean='C>0、ν₀>0、∀ν≥ν₀后的两个合取结论',note='一致；未将数值留域作假设')])
add('SecondDerivative','2.1.2',59,[14],r'''and the second derivative is obtained by differentiating the differential equation itself:
\[\ddot{\boldsymbol z}(t)=\frac{\mathrm d}{\mathrm dt}\dot{\boldsymbol z}(t)=\frac{\mathrm d}{\mathrm dt}f(\boldsymbol z(t))=f'(\boldsymbol z(t))\dot{\boldsymbol z}(t)=f'(\boldsymbol z(t))f(\boldsymbol z(t)),\]''',
proposition('odeSecondDerivative_statement',proof='''intro n f γ hf hγ hode t
  have heq : deriv γ = fun s => f (γ s) := funext (fun s => (hode s).deriv)
  rw [heq]
  exact ((hf.differentiable (by norm_num)).differentiableAt.hasFDerivAt).comp_hasDerivAt t (hode t)'''),
context=[r"$f\in C^1$，$\dot z=f(z)$；$f'$为实际Fréchet导数/Jacobian。"],extra=['解γ取C²；原文连续求两次时间导数的正则性显式化。'])
add('Taylor2','2.1.2',59,[15,17],r'''so one may write the 2nd order Taylor series method as
\[\boldsymbol z_{n+1}=\boldsymbol z_n+hf(\boldsymbol z_n)+\frac{h^2}{2}f'(\boldsymbol z_n)f(\boldsymbol z_n).\]
This method generates the flow map approximation
\[\mathcal G_h(\boldsymbol z)=\boldsymbol z+hf(\boldsymbol z)+\frac{h^2}{2}f'(\boldsymbol z)f(\boldsymbol z).\]''',
'''def taylorSecond {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  z + h • f z + (h^2 / 2) • (fderiv ℝ f z) (f z)''',kind='definition',label='Example 2.1 (map)',
context=[r"Note that by the notation $f'(\boldsymbol z)$ where $\boldsymbol z\in\mathbb R^m$ and $f:\mathbb R^m\to\mathbb R^m$, is meant the $m\times m$ Jacobian matrix whose $ij$-component is $(f'(\boldsymbol z))_{ij}=\partial f_i/\partial z_j$. An alternative notation for $f'$ is $\partial f/\partial\boldsymbol z$."])
add('Taylor2Order','2.1.2',59,[16],'''which is referred to as the 2nd order Taylor series method.''',proposition('taylor2Order_statement'),
label='Example 2.1 (order)',context=[r'同页方法公式及前段全局有限时间窗高阶误差定义；“2nd order”含阶陈述。'],
extra=['compactTrajectory要求f全域C⁶及实际解在固定紧时间窗连续；强于二阶所需，标[EXTRA]，仍需证明局部误差及稳定留域。'],
missing='缺一般Taylor方法局部截断误差、数值留域与全局阶桥接；当前库仅一般one-step条件误差定理。')
EXCLUDED += [dict(printed_page='53–55',pdf_page='75–77',reason='导论、固定步长经验、图2.1与文献建议为定性背景，excluded_qualitative。'),
             dict(printed_page='56–58',pdf_page='78–80',reason='§2.1.1 trimer数值轨迹、参考解与图2.2–2.3为实验观察，excluded_qualitative；不将观测斜率及增长冒充普适定理。')]

import ch02_section22

import ch02_section23
