"""Eight RESPA/impulse records, original PDF167–168."""
from ch04_data import add,copied,proposition,D
add('SplitHamiltonian','4.2.1',145,[19],r'''In many molecular dynamics applications, the system may be decomposed as $H(q,p)=p^TM^{-1}p/2+U_S(q)+U_F(q)$ where $U_S$ is a “soft” potential, in which the natural motion would be relatively slow, whereas $U_F$ is a much stronger term which would give rise to relatively rapid motion.''',copied(D,'splitHamiltonian'),kind='definition',context=['质量对角，US/UF实际势函数；软/强的定性比较不当数值假设。'])
add('FastVerlet','4.2.1',145,[20],r'''Let $\mathcal G_h^F$ denote the map associated to the Verlet method for the system without $U_S$, using a stepsize $h$:
\[\mathcal G_h^F=\mathrm e^{\frac h2L_{U_F}}\mathrm e^{hL_K}\mathrm e^{\frac h2L_{U_F}},\]
where $L_K$ is the Lie-derivative corresponding to the kinetic energy component of the Hamiltonian $(K=p^TM^{-1}p/2)$.''',copied(D,'fastVerlet'),kind='definition',context=['Lie指数按实际势kick与质量drift作用解释；复用第2章实际数学映射。'])
add('RESPA','4.2.1',145,[21],r'''Now consider the map constructed by taking $r$ steps using $\mathcal G_{F,h/r}$ and composing this with kicks from the soft force:
\[\mathcal G_h^{\mathrm{MTS}}=\mathrm e^{\frac h2L_{U_S}}[\mathcal G_{h/r}^F]^r\mathrm e^{\frac h2L_{U_S}}.\]
Reversible RESPA Algorithm
\[P:=p-(h/2)\nabla U_S(q),\quad Q:=q;\]
Repeat $r$ times:
\[P:=P-(h/2)\nabla U_F(Q)/r,\quad Q:=Q+hM^{-1}P/r,\quad P:=P-(h/2)\nabla U_F(Q)/r;\tag{4.2}\]
\[P:=P-(h/2)\nabla U_S(Q).\]''',copied(D,'respa'),kind='definition',label='(4.2)',extra=['r为正自然数，实际r次函数迭代；不把形式算子等式当实际ODE流。'])
add('RESPAStructure','4.2.1',145,[22],r'''Because $U_F$ requires small timesteps, we think of separating the calculation of a timestep, typically in a symmetric form.''',proposition('respaStructure_statement'),extra=['[EXTRA]本段Reversible名称及p149明确辛性合并成实际保结构声明：正质量、US/UF C²、r>0。'],context=['实际Jacobian辛性与反步恒等式，没有把任一结论作假设。'],missing='需桥接坐标kick/drift实际辛性、复合与迭代反步；不重新建立辛流理论。')
add('SlowMatrix','4.2.1',146,[],r'''with
\[S_h=\begin{bmatrix}1&0\\-h&1\end{bmatrix};\qquad F_h=\begin{bmatrix}\cos(\Omega h)&\Omega^{-1}\sin(\Omega h)\\-\Omega\sin(\Omega h)&\cos(\Omega h)\end{bmatrix}.\]''',copied(D,'slowMatrix'),kind='definition',context=['US(q)=q²/2的真实kick矩阵，质量1。'])
add('FastMatrix','4.2.1',146,[],r'''with
\[S_h=\begin{bmatrix}1&0\\-h&1\end{bmatrix};\qquad F_h=\begin{bmatrix}\cos(\Omega h)&\Omega^{-1}\sin(\Omega h)\\-\Omega\sin(\Omega h)&\cos(\Omega h)\end{bmatrix}.\]''',copied(D,'fastMatrix'),kind='definition',extra=['Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。'])
add('ImpulseMatrix','4.2.1',146,[23],r'''In the limit of small inner step, we solve the system with Hamiltonian $H_F=p^2/2+\Omega^2q^2/2$ exactly, meanwhile punctuating with impulses from $U_S$, thus the MTS flow map approximation, which is linear in this case, can be written in the form of a matrix-vector multiply
\[\begin{bmatrix}Q\\P\end{bmatrix}=W_h\begin{bmatrix}q\\p\end{bmatrix},\qquad W_h=S_{h/2}F_hS_{h/2}.\]''',copied(D,'impulseMatrix'),kind='definition',context=['这是理想精确内步的impulse模型；不以它替代有限r的RESPA矩阵。'])
add('ImpulseDet','4.2.1',146,[24],r'''Both of these matrices have unit determinant for any $h$, so the product of the eigenvalues of $W_h$ is $1$.''',proposition('impulseDet_statement'),extra=['Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。'],context=['有限实矩阵行列式；复谱根乘积来自其特征多项式，不假设谱结论。'],missing='待2×2行列式、sin²+cos²及乘积det短证明。')
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['ImpulseDet'])
