# 第7章原书疑误与双版本审阅单

教材：Leimkuhler–Matthews《Molecular Dynamics》（2015）。正文为印刷261–326页、PDF282–347页，末页取Exercises之前。
每项公式疑点均已目视核对原页。以下是待导师裁定的工作版本；条件不足、符号歧义与已确认的代数不符分别说明，不能一概称为原书错误。网站尚未审阅。
定义只记录对象或待证目标；已证与未证分开列出。原文疑误版本不作为修正版的证明依据。

## 1. MD-7.2-PartitionPrinted

- 页码：印刷266 / PDF287。
- 原文引句与公式：

and $Z_{\rm can}$ is the canonical partition function
\[Z_{\rm can}^{-1}=\int_D\exp(-\beta H(q,p))d\omega,\]
ensuring the integral of $\rho_\beta$ is unity.

- 问题、理由或反例：已目视核对原页PDF287／印刷266：原书确为Z_can^{-1}=积分，和紧接的归一化断言不相容；不是转录错误。
- 限定与覆盖缺口：原文版严格保留倒数关系；修正版取Z_can=配分积分，并补正性、可积性。；反例的代数核心：取一点评价空间总质量1/2、H=0，则原式强制Z=2，密度积分为1/4；counterexample声明给出1/4≠1，测度实现的积分化简未另作声明。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.partitionPrinted`：未证。
  - `MD.Ch07.partitionPrinted_counterexample`：已证。
  - `MD.Ch07.partitionPrinted_corrected`：已证。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 2. MD-7.3.1-WordConvention

- 页码：印刷270 / PDF291。
- 原文引句与公式：

As a result we use the convention that if a letter appears $k$ times in a method's string, then each individual update piece uses a timestep $h/k$. For example, the scheme denoted $[OABAOBAO]$ has an update
\[\mathcal U_h^{[OABAOBAO]}=\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O,\]
where the random numbers used in each O update are independent. This scheme will require a total of $4N_c$ normal random numbers and two force evaluations per step (the force must be recomputed at the first B step following an A step); the number of force evaluations required is not directly related to the length of the string.

- 问题、理由或反例：已目视核对PDF291／印刷270：字串OABAOBAO有3个O，所印复合也仅3个O，却各用h/4并称4N_c个正态数；不符前句每字母总时长h的约定。
- 限定与覆盖缺口：原文图式照录3个h/4的O；修正版改3个h/3和3N_c随机数。力求值次数为实现说明，未形式化成本模型。；每个O的向量噪声需联合独立标准正态；字母计数结论独立证明。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.oabaobaoPrinted`：定义或记号。
  - `MD.Ch07.oabaobaoPrinted_corrected`：定义或记号。
  - `MD.Ch07.oabaobaoCount`：已证。
- 待人工核查点：完整复合图式、O计数及时间分配修正；力求值说明列于上下文，不声称已证明计算成本。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 3. MD-7.3.2-SPVPrinted

- 页码：印刷272 / PDF293。
- 原文引句与公式：

Stochastic Position Verlet (SPV)
\[q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\qquad
p_{n+1}=e^{-h\gamma}p_n-\eta\nabla U(q_n)+\zeta M^{1/2}R_n,\qquad
q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1}\]
where $\eta=(1-e^{-h\gamma})/\gamma$, $\zeta=[k_BT(1-e^{-2\gamma h})]^{1/2}$.

- 问题、理由或反例：已目视核对原页PDF293／印刷272：SPV展示式动量用∇U(q_n)，而前文说对两部分作对称积分，漂移半步后冻结位置应为q_{n+1/2}；两者分别保留，待导师判断。
- 限定与覆盖缺口：γ>0使用原印η商；γ=0的连续延拓η=h另需定义，不用实数除零总化声称正确。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.spvPrinted`：定义或记号。
  - `MD.Ch07.spvPrinted_corrected`：定义或记号。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 4. MD-7.4.2-BBKStarMomentSystemPrinted

- 页码：印刷278–279 / PDF299–300。
- 原文引句与公式：

Thus taking expectations of (7.8)–(7.10) and substituting in the constants gives
\[Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+2\psi_{12}\kappa_1 2\psi_{12}\kappa_1\kappa_3+\kappa_1^2,\]
\[P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+2\psi_{22}\kappa_2 2\psi_{22}\kappa_2\kappa_3+\kappa_2^2+\kappa_3^2,\]
\[C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\kappa_1\kappa_2+\psi_{12}\kappa_2\kappa_3+\psi_{22}\kappa_1\kappa_3.\]

- 问题、理由或反例：已目视核对PDF299／印刷278：前两条方程交叉项重复印出2ψ12κ1与2ψ22κ2；按前面已列相关矩，应分别为2ψ12κ1κ3和2ψ22κ2κ3。原文与修正方程均保留。
- 限定与覆盖缺口：PDF300续接第三条方程；此处定义保留方程组全部三式，不把修正方程定义计作概率推导已证。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.bbkStarMomentSystemPrinted`：定义或记号。
  - `MD.Ch07.bbkStarMomentSystemPrinted_corrected`：定义或记号。
  - `MD.Ch07.bbkStarExtraFactor_counterexample`：已证。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 5. MD-7.6-GeMarsdenRestriction

- 页码：印刷282 / PDF303。
- 原文引句与公式：

All symplectic methods preserve the volume, but for a system with no first integrals except the energy, it is known from a theorem of Ge and Marsden [400] that a symplectic method cannot preserve the system energy exactly (unless the symplectic method is itself a time-reparameterization of the exact solution).

- 问题、理由或反例：原文省略技术条件或本条覆盖范围尚有限定；详见下列说明。
- 限定与覆盖缺口：原文引用的Ge–Marsden定理未列非可积性、局部性及精确流的全部技术条件；仅定义其非可积性和结论形式，未把geMarsdenConclusion宣称为真。；辛映射体积保持和Ge–Marsden结论均列入本条覆盖缺口，不能把该定义当成定理已证。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.onlyEnergyIntegrals`：定义或记号。
  - `MD.Ch07.timeReparametrizes`：定义或记号。
  - `MD.Ch07.geMarsdenConclusion`：定义或记号。
- 待人工核查点：原文数学主张已登记；Lean给出结论形式和第一积分资格，尚缺可核定的完整定理前提与定理陈述。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 6. MD-7.7.2-SpectralQualification

- 页码：印刷289 / PDF310。
- 原文引句与公式：

The assumption of validity becomes more credible as we find that the operator $\mathcal L_{LD}^\dagger$ has a compact resolvent and therefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous chapter. It will have one zero eigenvalue corresponding to the invariant density $\rho_\beta$ and all the remaining eigenvalues lie in the negative half plane.

- 问题、理由或反例：已目视核对PDF310：原文将discrete spectrum释为simple eigenvalues，这并非一般蕴含。紧预解式至多给离散谱及有限重数，不能直接给单重谱；Langevin谱还需前章所列势函数/空间条件。
- 限定与覆盖缺口：只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.simpleEigenvalue`：定义或记号。
  - `MD.Ch07.printedSpectralConclusion`：定义或记号。
  - `MD.Ch07.spectralConclusionPrinted`：定义或记号。
  - `MD.Ch07.spectralConclusionPrinted_corrected`：定义或记号。
- 待人工核查点：原文谱断言已登记，Lean定义其点谱目标；尚缺无界算符对象和完整限定定理。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 7. MD-7.7.3-PerturbativeSolvabilityCaution

- 页码：印刷290 / PDF311。
- 原文引句与公式：

It will be difficult to solve the perturbation equation (7.19) in general, although its linearity and the fact that $\mathcal L_{LD}^\dagger$ (with our assumptions) has a compact resolvent (and therefore a discrete spectrum) together imply that if the perturbation can be bounded, then it should be possible to solve for the correction function. We expect that this solution should be stable with respect to perturbation (and exponentially attracting). This also implies global existence (for all positive time) of the semigroup defining the solution of the time-dependent problem. We do not provide such a rigorous result here but simply plunge ahead, in the best tradition of applied mathematics, to obtain a perturbative expansion; verification of our results must therefore be obtained by numerical experiment, a posteriori.

- 问题、理由或反例：原文省略技术条件或本条覆盖范围尚有限定；详见下列说明。
- 限定与覆盖缺口：原书明确未给严格可解性/指数吸引/半群全局存在定理；保留其全部原文主张并定义可解性目标。；不能由紧预解式和有界扰动单独推出任意rhs可解；核方向的Fredholm相容条件、定义域与谱隙均是覆盖缺口。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.correctionSolvable`：定义或记号。
- 待人工核查点：可解性目标与原书未证明的预期已登记；指数稳定和全局半群存在不作为已获定理。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 8. MD-7.8.1-FirstCorrectionTablePrinted

- 页码：印刷293–294 / PDF314–315。
- 原文引句与公式：

In summary, we find that
\[f_{1,[ABO]}(q,p)=f_{1,[OAB]}(q,p)=\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25a}\]
\[f_{1,[OBA]}(q,p)=f_{1,[BAO]}(q,p)=-\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25b}\]
\[f_{1,[AOB]}(q,p)=-\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25c}\]
\[f_{1,[BOA]}(q,p)=\frac\beta2(\gamma U(q)+p^TM^{-1}\nabla U(q)-c),\tag{7.25d}\]
where the constant $c$ is chosen to ensure each correction function has average 0, giving $c=\gamma\langle U(q)\rangle$.

- 问题、理由或反例：已目视核对PDF315／印刷294：(7.25c)中动量梯度项印为负号，与同页上一段推导给出的正号及f_AOB=-f_BOA矛盾；修正为括号内正号。
- 限定与覆盖缺口：六个排列分别编码ABO,OAB,OBA,BAO,AOB,BOA；原文版不证明，修正版陈述实际PDE。c任意常数时PDE不变，零均值另行规定c=γ〈U〉。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.firstCorrectionTablePrinted`：定义或记号。
  - `MD.Ch07.firstCorrectionTablePrinted_corrected`：定义或记号。
  - `MD.Ch07.firstCorrection_sign_counterexample`：已证。
  - `MD.Ch07.phaseComm`：定义或记号。
  - `MD.Ch07.firstCorrectionRHS`：定义或记号。
  - `MD.Ch07.firstCorrectionTable_pde`：未证。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 9. MD-7.9.1-TripleCommutatorPrinted

- 页码：印刷299 / PDF320。
- 原文引句与公式：

\[[\mathcal L_A^\dagger,\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=(2\beta p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,\]
\[[\mathcal L_B^\dagger,\mathcal L_B^\dagger,\mathcal L_A^\dagger]\rho_\beta=-(2\beta p^T(\nabla^2U)\nabla U)\rho_\beta.\]

- 问题、理由或反例：已目视核对PDF320／印刷299：首条三重交换子的三阶导数项未带β；后面的PDE却把β乘整个括号，且直接微分给出共同β。原文版与补β修正版独立保留。
- 限定与覆盖缺口：M=I；Hessian、三阶张量及张量缩并均为实际坐标导数；原文版仅定义，不证明。反例先给系数代数区别，完整势函数测度反例未构造。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.hessianU`：定义或记号。
  - `MD.Ch07.thirdU`：定义或记号。
  - `MD.Ch07.hessianGrad`：定义或记号。
  - `MD.Ch07.cubicThird`：定义或记号。
  - `MD.Ch07.tripleCommutatorPrinted`：定义或记号。
  - `MD.Ch07.tripleCommutatorPrinted_corrected`：定义或记号。
  - `MD.Ch07.tripleCommutator_corrected`：未证。
  - `MD.Ch07.tripleCommutator_factor_counterexample`：已证。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 10. MD-7.9.1-ConjugateSymmetricCorrections

- 页码：印刷300–301 / PDF321–322。
- 原文引句与公式：

\[\widehat\rho_{[ZYOYZ]}=\exp((h/2)\mathcal L_Z^\dagger)\exp((h/2)\mathcal L_Y^\dagger)\exp((h/2)\mathcal L_O^\dagger)\widehat\rho_{[OYZYO]}.\]
\[f_{2,[ZYOYZ]}\rho_\beta=f_{2,[OYZYO]}\rho_\beta+\tfrac14\mathcal L_{1,[OYZ]}^\dagger\rho_\beta.\]
\[\mathcal L_{1,[OAB]}^\dagger\rho_\beta=\tfrac12\mathcal L_H^\dagger(g\rho_\beta),\qquad
\mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\tfrac12\mathcal L_H^\dagger(g\rho_\beta),\]
\[\mathcal L_H^\dagger(g\rho_\beta)=\beta(|\nabla U|^2-p^T\nabla^2Up)\rho_\beta,\]
\[f_{2,[ABOBA]}=f_{2,[OBABO]}-\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up),\tag{7.30a}\]
\[f_{2,[BAOAB]}=f_{2,[OABAO]}+\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up).\tag{7.30b}\]

- 问题、理由或反例：已目视核对PDF321：所印传播子展开末项为(h²/2)L_LD，按exp的二阶展开应为(h²/8)(L_LD)²；该项作用ρβ为零，不改变后续修正关系。
- 限定与覆盖缺口：Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.gradNormSq`：定义或记号。
  - `MD.Ch07.hessianQuadratic`：定义或记号。
  - `MD.Ch07.conjugateCorrectionChange`：定义或记号。
  - `MD.Ch07.conjugateCorrections`：定义或记号。
  - `MD.Ch07.conjugateCorrection_coefficient`：已证。
  - `MD.Ch07.conjugateExpansionPrinted`：定义或记号。
  - `MD.Ch07.conjugateExpansionPrinted_corrected`：定义或记号。
- 待人工核查点：形式传递系数的消项及(7.30)全部目标；未证明从具体分裂映射导出这些系数。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 11. MD-7.9.2-OUKernelQualification

- 页码：印刷302 / PDF323。
- 原文引句与公式：

The first equation at order one tells us that $f_{2,0,[OABAO]}(q,p)$ must be a function of position only, as the kernel of $\overline{\mathcal L}_O^\dagger$ is the set of functions that are constant with respect to $p$. Hence we shall denote $f_{2,0,[OABAO]}(q,p)=\nu(q)$, where $\langle\nu\rangle=0$.

- 问题、理由或反例：已目视核对PDF323：前向OU生成元的核实际是Gaussian密度倍数；对ρβf共轭后，合适L²域中的f才对p为常数。原文此句缺少共轭与定义域限定。
- 限定与覆盖缺口：修正版明确实际Gaussian L²域和光滑性；原文目标定义保留但不证明。零均值仅限制ν常数方向，不由OU核自动给出。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.ouKernelPrinted`：定义或记号。
  - `MD.Ch07.ouKernelPrinted_corrected`：未证。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 12. MD-7.9.2-FirstReciprocalCorrection

- 页码：印刷303–304 / PDF324–325。
- 原文引句与公式：

\[f_{2,1,[OABAO]}=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU)-p^T\nabla\nu-\mu.\]
\[\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})=-\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]}).\tag{7.35}\]
\[\int_{\mathcal P}\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})d\omega_p=0,\qquad
\int_{\mathcal P}\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]})d\omega_p=\overline\pi\mathcal L_H^\dagger f_{2,1,[OABAO]}=0,\tag{7.36}\]
where $(\overline\pi f)(q)=\int_{\mathcal P}f(q,p)\rho_\beta d\omega_p$.

- 问题、理由或反例：已目视核对PDF324–325：π̄定义带联合ρβ权，后续M公式却使用归一条件动量平均并隐含ρβ共轭。本文区分原文加权积分与修正的条件Gaussian平均，避免遗漏位置密度因子。
- 限定与覆盖缺口：给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.firstReciprocalCorrection`：定义或记号。
  - `MD.Ch07.momentumAverage`：定义或记号。
  - `MD.Ch07.momentumAveragePrinted_corrected`：定义或记号。
  - `MD.Ch07.momentumAveragePrinted`：定义或记号。
  - `MD.Ch07.firstReciprocalCorrection_pde`：未证。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 13. MD-7.10-LimitMethodAccuracy

- 页码：印刷308 / PDF329。
- 原文引句与公式：

We would expect that this scheme should have an $O(h^4)=O(\tau^2)$ error in configurational averages. For averages computed in finite time, work in [224] has shown that (7.40) does indeed give a first order error, albeit one that vanishes exponentially fast in time as the simulation progresses. Hence for suitably long simulations, the observed error will be $O(h^2)$.

- 问题、理由或反例：已目视核对PDF329：本段前面以τ为实际过阻尼步长并称长期二阶，末句却写O(h²)。若仍沿用τ=h²/2，应区分长期O(τ²)=O(h⁴)和有限时一阶O(τ)=O(h²)；原文符号存在歧义。
- 限定与覆盖缺口：用显式瞬态上界命题保留指数衰减的一阶项和二阶项，不宣称该命题已对任意势成立；其成立所需的增长/耗散与正则条件及真实分布误差识别尚缺。；原文称all values of h and τ亦不能由局部渐近展开推出全步长阶数结论。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.lmTransientErrorBound`：定义或记号。
  - `MD.Ch07.limitAccuracyPrinted`：定义或记号。
  - `MD.Ch07.limitAccuracyPrinted_corrected`：定义或记号。
  - `MD.Ch07.limitAccuracy_rescale`：已证。
- 待人工核查点：误差界目标和步长幂次转换；尚缺LM算法到该界的完整定理。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 14. MD-7.12-ConstrainedCanonicalErgodicity

- 页码：印刷317 / PDF338。
- 原文引句与公式：

In the infinite time limit, we have that solution trajectories of constrained Langevin (7.43)–(7.45) sample $\widetilde\rho_\beta$ ergodically, such that
\[\lim_{T\to\infty}\frac1T\int_0^T\phi(q(t),p(t))dt=\int_{\mathcal D}\phi(q,p)\widetilde\rho_\beta d\omega,\]
where $\widetilde\rho_\beta$ is the normalized constrained canonical distribution
\[\widetilde\rho_\beta=Z^{-1}\exp(-\beta H(q,p))\delta[g(q)]\delta[g'(q)M^{-1}p],\]
for normalizing constant $Z$ and where $\delta[z]:=\prod_i\delta[z_i]$ for a vector $z$.

- 问题、理由或反例：原文省略技术条件或本条覆盖范围尚有限定；详见下列说明。
- 限定与覆盖缺口：δ不是普通Lebesgue密度；用有支撑测度ν和正则化δ的弱积分极限规定其含义，不能用任意面测度替代而省略Jacobian因子。；实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.constrainedCanonical`：定义或记号。
  - `MD.Ch07.constrainedReference`：定义或记号。
  - `MD.Ch07.constrainedErgodicAverages`：定义或记号。
- 待人工核查点：全部分布及遍历平均目标的测度定义；约束参考测度存在与具体过程的遍历定理仍缺。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 15. MD-7.12-MidpointStabilityPrinted

- 页码：印刷319 / PDF340。
- 原文引句与公式：

The Lagrange multiplier $\lambda_{n+1/4}$ (and likewise $\lambda_{n+1}$) can be obtained by solving the linear system
\[g'(q_n)M^{-1}[(1-h\gamma/4)p_n+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4}]=0,\]
which is easily computed once the $R_n$ vector is evaluated in the step, and gives us a stability criterion
\[\gamma h<4.\tag{7.46}\]

- 问题、理由或反例：已目视核对PDF340／印刷319：所印γh<4保留为原书给出的限制。它保证中点OU放大因子为正；OU线性绝对稳定性本身对γh≥0均成立。原文没有写充要关系，不能把本条当作已确认的原书错误。完整耦合Verlet仍有独立步长限制。
- 限定与覆盖缺口：原文版仅保留γh<4条件，不增添充要关系；补充结论仅针对中点OU衰减模态。a=8说明γh<4不是该单独模态稳定的必要条件，不反驳原书整套算法的充分条件。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.multiplierLinearSystem`：定义或记号。
  - `MD.Ch07.midpointAmplification`：定义或记号。
  - `MD.Ch07.midpointStabilityPrinted`：定义或记号。
  - `MD.Ch07.midpointStabilityPrinted_corrected`：已证。
  - `MD.Ch07.midpointStability_counterexample`：已证。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 16. MD-7.12.1-ApproximateGeodesicOrder

- 页码：印刷320 / PDF341。
- 原文引句与公式：

We do not necessarily need to solve the geodesic flow exactly in practice, though for the purposes of analysis we shall assume we do. If we are considering a second order scheme, then solving the $A_c$ piece to at least second order would be sufficient to preserve the overall order of the scheme, although a scheme may have potentially better accuracy and stability properties if a higher order solve is used.

- 问题、理由或反例：原文省略技术条件或本条覆盖范围尚有限定；详见下列说明。
- 限定与覆盖缺口：用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.localMapErrorBound`：定义或记号。
  - `MD.Ch07.geodesicReplacementSecondOrder`：定义或记号。
- 待人工核查点：局部二阶替换的目标资格；从该资格推出随机全局/不变分布阶数尚未陈述完整定理。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 17. MD-7.13-UnderdampedPhasePrinted

- 页码：印刷325 / PDF346。
- 原文引句与公式：

We consider the case with $\gamma\ll\Omega$, allowing us to write $\eta=i\widehat\eta$ for $\widehat\eta\in\mathbb R$, and
\[\left|\cos\left(\frac{\widehat\eta h}{2}-\operatorname{atanh}\left(\frac h{\widehat\eta}\right)\right)\sqrt{1+\frac{h^2}{\widehat\eta^2}}\right|\le\cosh(\gamma h/2).\]

- 问题、理由或反例：已目视核对PDF346／印刷325：从η=iη̂化为实余弦时应使用+arctan(h/η̂)，所印-atanh(h/η̂)的函数与符号均不符。修正版从cos(a)-r sin(a)的标准幅相恒等式得到。
- 限定与覆盖缺口：原文版与修正版分别定义，原文版不证明；直接用幅相恒等式绕过复函数分支。η̂=√(4Ω²-γ²)>0需要明确欠阻尼条件。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.underdampedPhasePrinted`：定义或记号。
  - `MD.Ch07.underdampedPhasePrinted_corrected`：定义或记号。
  - `MD.Ch07.underdampedPhase_identity`：已证。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 18. MD-7.13-FrictionThresholdPrinted

- 页码：印刷325 / PDF346。
- 原文引句与公式：

The minimum required friction for stability can be found by considering the case of small timestep. This gives a bound
\[\frac1{\sqrt{4\Omega^2-\gamma^2}}\le\frac\gamma2,\]
which gives a stability condition for all step sizes $h$ as long as
\[\gamma\ge\Omega\sqrt{2-2\sqrt{1-\Omega^{-4}}}\ge\sqrt2/\Omega.\]
Therefore we expect that the minimum friction value required for stability for all timesteps $h>0$, scales with the value of inverse $\Omega$.

- 问题、理由或反例：已目视核对PDF346：最后链式下界√2/Ω不成立。将精确阈值有理化得√(2/(Ω²+√(Ω⁴-1)))，大Ω时约1/Ω；√2/Ω可作更保守的充分选择而非精确阈值下界。Ω²=5/4时精确阈值平方=1，小于2/Ω²=8/5。
- 限定与覆盖缺口：保留原精确根式，它本身与有理化修正版相同；疑误在后续比较方向/系数。欠阻尼上界γ<2Ω显式，不把该范围内的代数条件推广到任意大γ。；所有h包络由sinh x≥x推出，严格稳定与随机矩界仍需另证。反例给出有理平方数值，完整根式代入识别未另证明。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.frictionThresholdPrinted`：定义或记号。
  - `MD.Ch07.frictionThresholdPrinted_corrected`：定义或记号。
  - `MD.Ch07.frictionBoundPrinted`：定义或记号。
  - `MD.Ch07.frictionBoundPrinted_corrected`：定义或记号。
  - `MD.Ch07.frictionThreshold_rationalized`：未证。
  - `MD.Ch07.frictionThreshold_allSteps`：未证。
  - `MD.Ch07.frictionThreshold_asymptotic`：未证。
  - `MD.Ch07.frictionThreshold_squared_counterexample`：已证。
- 待人工核查点：本条逐字引用的全部数学对象与公式；未纳入的上下文另列。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。

## 19. MD-7.1-HamiltonianSamplingObstruction

- 页码：印刷262 / PDF283。
- 原文引句与公式：

Note that deterministic methods (e.g. Hamiltonian dynamics itself) can sometimes be used for molecular sampling, but without stochastic perturbation, such methods are not rigorously ergodic, since the Liouvillian operator does not possess a spectral gap and does not provide a unique stationary solution.

- 问题、理由或反例：原文省略技术条件或本条覆盖范围尚有限定；详见下列说明。
- 限定与覆盖缺口：本条只证明保能流的能量子水平集不变；结合非平凡概率质量可形成遍历性障碍。能量壳上的遍历性不能由原句否定。；原句未指定Liouvillian定义域、函数空间与参考概率。谱隙缺失和多个平稳解的完整算子陈述列为覆盖缺口，不把子水平集恒等式标作整段谱理论的证明。
- 原文版、工作修正版及相关证明：
  - `MD.Ch07.energyConservingFlow`：定义或记号。
  - `MD.Ch07.energySublevel_invariant`：已证。
  - `MD.Ch07.energyObstructionQualified`：定义或记号。
- 待人工核查点：保能流、非平凡不变集资格及不变集恒等式；原文的谱隙与平稳解主张仅逐字登记，尚缺明确函数空间后的完整陈述。
- 导师选项：接受所列限定或工作修正 / 保留原书表述并另补条件 / 指定新的修正。
- 网站结论：未送审。
