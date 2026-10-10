"""First <=8-item §3.4 batch, original PDF135–137."""
from ch03_data import add,copied,proposition,D,RECORDS
B='MolecularDynamics/Chapter03/ModifiedHamiltonianBounds.lean'
add('ModifiedField','3.4',113,[67],r'''Assume a smooth differential equation system
\[\frac{\mathrm d\boldsymbol z}{\mathrm dt}=f(\boldsymbol z)\]
with flow map $\mathcal F_t$, and a one-step method $\mathcal G_h$. We obtain, typically by matching of terms from Taylor expansion, a “modified differential equation” as a series expansion
\[\frac{\mathrm d\boldsymbol z}{\mathrm dt}=\widetilde f_h(\boldsymbol z)=f(\boldsymbol z)+h^rf_r(\boldsymbol z)+h^{r+1}f_{r+1}(\boldsymbol z)+\cdots,\]
where $r$ is the classical order of accuracy of the method.''',
copied(D,'formalField'),kind='definition',context=[r'r≥1；h为形式变量、f_j为系数向量场；实际匹配存在性单列。'])
add('LeadingModifiedField','3.4',113,[68],r'''In fact, it is straightforward to show that if numerical method satisfies
\[\mathcal G_h(\boldsymbol z)-\mathcal F_h(\boldsymbol z)=h^{r+1}\Gamma_{r+1}(\boldsymbol z)+O(h^{r+2}),\]
i.e. $h^{r+1}\Gamma_{r+1}$ is the leading term in the local error expansion, then we have
\[f_r(\boldsymbol z)=\Gamma_{r+1}(\boldsymbol z).\]''',
proposition('leadingModifiedField_statement'),context=[r'$\mathcal F$为原实际流；极限h^−(r+1)(G_h−F_h)给原文Γ系数，不把modified flow的匹配作前提。'],
extra=['r>0、全域C∞的f及(h,z)↦G_h、开放D与紧B及真实双向局部流；局部r阶条件。'],
missing='缺真实步长Taylor展开、系数极限及修正场ODE余项桥接；属于完整修正方程理论，保留sorry。')
add('TruncatedHamiltonian','3.4',114,[69],r'''Define
\[\widetilde H_k\stackrel{\mathrm{def}}=H+h^rH_r+h^{r+1}H_{r+1}+\cdots+h^kH_k.\tag{3.11}\]''',
copied(B,'textbookTruncatedHamiltonian','truncatedHamiltonian'),kind='definition',label='(3.11)',
context=[r'原文(3.10)为形式H̃_h=H+h^rH_r+h^{r+1}H_{r+1}+⋯；(3.11)是实际有限函数，不需无限级数收敛；r≤k。'])
add('TruncationSmooth','3.4',114,[70],r'''Suppose the Hamiltonian $H$ and modified Hamiltonian $\widetilde H_k$ are smooth functions globally defined on a convex, compact subset $\mathcal B$ of $\mathbb R^{2N_c}$.''',
copied(B,'contDiffOn_textbookTruncatedHamiltonian','truncationSmooth'),context=[r'旧CH03-070是(3.11)有限函数光滑性的证明辅助；实际 finite sum 不假设和已光滑。'],
extra=['各系数在开放环境D为C¹；这里只证明所需C¹子结论，原文smooth假设本身不作为新断言。'],
prior=['MolecularDynamics.contDiffOn_textbookTruncatedHamiltonian'])
add('Thm3.1','3.4','114–116',[71],r'''Theorem 3.1. Suppose the Hamiltonian $H$ and modified Hamiltonian $\widetilde H_k$ are smooth functions globally defined on a convex, compact subset $\mathcal B$ of $\mathbb R^{2N_c}$ and suppose that the exact solution and numerical approximations (for $h$ sufficiently small) are confined to $\mathcal B$. Then, we have asymptotically for $h\to0$ that
\[H(\boldsymbol z_n)=H(\boldsymbol z_0)+O(h^r),\]
for $n=0,1,\ldots,\nu$ where $\tau=\nu h=O(h^{-k+r})$.''',
proposition('theorem31_statement'),kind='theorem',label='Theorem 3.1',
context=[r'(3.11)来自前面的modified Hamiltonian构造；逐阶匹配不能作为“已经构造成功”的无证假设。'],
extra=['smoothSymplecticData显式添加原方法r阶/近恒等辛/joint C∞、开放凸环境D、紧凸B⊆D、真实原流；r>0。','本签名保留完整构造H_j与finiteMatching为结论，k≥r固定；数值迭代和截断ODE留B，常数可依赖k,T而非所有k统一。'],
verdict='NEEDS_HUMAN',explanation='完整构造/匹配/长时间能量结论均未假设；但原文给定H̃_k，本签名以存在H_j重建它，量词严格化及截断轨道资格仍需导师裁定，不宣称已证原书定理。',
issues=[dict(code='NEEDS_HUMAN',detail='给定H̃_k与存在一组构造系数的量词对应、截断轨道留B及所有n≤ν的长时间范围需审；任意n和T的量化包含原文每个n≤ν。')],
missing='缺Hamiltonian形式jet构造、全阶匹配与实际局部ODE统一余项；不建设大型BEA理论。')
add('CompactLipschitz','3.4',114,[72],r'''Proof First observe that due to smoothness and the assumptions on $\mathcal B$, we have a global Lipschitz constant
\[|H(\boldsymbol u)-H(\boldsymbol v)|\le L\|\boldsymbol u-\boldsymbol v\|\]
for all $\boldsymbol u,\boldsymbol v\in\mathcal B$.''',
copied(B,'exists_compact_C1_lipschitz_constant','compactLipschitz'),
context=[r'“global”指固定紧凸B上统一，不是整个无限相空间；H光滑原文资格。'],
extra=['显式开放环境D及B⊆D、H在D为C¹；L由真实导数紧集界推出，未作假设。'],
prior=['MolecularDynamics.exists_compact_C1_lipschitz_constant'])
add('TruncatedFlow','3.4',115,[73],r'''Denote by $\mathcal F_h^{(k)}$ the flow map of the truncated Hamiltonian expansion $\widetilde H_k$,
\[\mathcal F_h^{(k)}\stackrel{\mathrm{def}}=\exp(h\mathcal L_{\widetilde H_k}).\]''',
copied(D,'truncatedFlow'),kind='definition',context=[r'实际γ(0)=z、γ满足J∇H̃_k的ODE，F_h^(k)(z)=γ(h)；本关系不把exp记号当解存在证明。'])
add('FiniteMatchingConstruction','3.4',115,[74],r'''By construction, we have
\[\boldsymbol z_{n+1}=\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n\]
where $\|\boldsymbol\eta_n\|\le Ch^{k+1}$.''',
proposition('modifiedConstruction_statement','finiteMatchingConstruction'),
context=[r'真实数值一步与截断Hamiltonian实际一步的差；construction完整存在性同MD-3-ModifiedConstruction，旧CH03-074以此处原文独立映射。'],
extra=['smoothSymplecticData与原书构造上下文相同；保留任意k的真实finiteMatching为结论，不当作前提。'],
missing='缺形式jet的Hamiltonian构造与实际有限截断匹配/余项；大型BEA理论缺项。')

theorem=next(r for r in RECORDS if r['source_id']=='MD-3.4-Thm3.1')
theorem['proof_latex']=r'''Proof First observe that due to smoothness and the assumptions on $\mathcal B$, we have a global Lipschitz constant
\[|H(\boldsymbol u)-H(\boldsymbol v)|\le L\|\boldsymbol u-\boldsymbol v\|\]
for all $\boldsymbol u,\boldsymbol v\in\mathcal B$.
Denote by $\mathcal F_h^{(k)}$ the flow map of the truncated Hamiltonian expansion $\widetilde H_k$,
\[\mathcal F_h^{(k)}\stackrel{\mathrm{def}}=\exp(h\mathcal L_{\widetilde H_k}).\]
By construction, we have
\[\boldsymbol z_{n+1}=\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n\]
where $\|\boldsymbol\eta_n\|\le Ch^{k+1}$.
Since $\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have
\[\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))=\widetilde H_k(\boldsymbol z_n).\]
Now
\[\begin{aligned}\widetilde H_k(\boldsymbol z_\nu)-\widetilde H_k(\boldsymbol z_0)
&=\sum_{n=0}^{\nu-1}\widetilde H_k(\boldsymbol z_{n+1})-\widetilde H_k(\boldsymbol z_n)\\
&=\sum_{n=0}^{\nu-1}\widetilde H_k(\boldsymbol z_{n+1})-\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))\\
&=\sum_{n=0}^{\nu-1}\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n)-\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)).\end{aligned}\]
Hence
\[|\widetilde H_k(\boldsymbol z_\nu)-\widetilde H_k(\boldsymbol z_0)|\le L\sum_{n=0}^{\nu-1}\|\boldsymbol\eta_n\|\le L\nu h^{k+1}.\]
We have $\nu=\tau/h$, thus
\[|\widetilde H_k(\boldsymbol z_\nu)-\widetilde H_k(\boldsymbol z_0)|\le L\tau h^k.\]
Next observe that
\[H=\widetilde H_k-h^rH_{(r)}-h^{r+1}H_{(r+1)}-\cdots-h^kH_{(k)}=\widetilde H_k+O(h^r).\]
Therefore
\[|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le L\nu h^{k+1}+O(h^r),\]
so that, as long as $\nu\le C_2h^{-k+r-1}$, we have
\[|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le O(h^r).\quad\square\]'''
theorem['proof_note']='完整原书证明按PDF136–138跨页拼接；保留原文L及省略C的展示式，不静默修订其常数。'
theorem['issues'].append(dict(code='NEEDS_HUMAN',detail='证明先对H取L，后对H̃_k沿用L，并在Lνh^(k+1)中省略缺陷常数C；本地辅助桥接显式给实际截断族统一L和C，但原文不改。'))
