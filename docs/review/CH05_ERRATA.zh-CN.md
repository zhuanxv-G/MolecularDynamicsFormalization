# 第5章原书疑误与双版本审阅单

教材：B. Leimkuhler 与 C. Matthews，Molecular Dynamics: With Deterministic and Stochastic Numerical Methods，Springer，2015。
页码采用原PDF从1起算的物理页。以下为工作勘误及资格补充，尚未经导师或作者裁定。定义、原有正确的数学子句和原书字面疑误分别保留；编译通过不表示未证命题已经成立。
原文引文沿用已逐页核对的来源记录；本轮网站返回保留其原有版本及判定。原有声明可能已经是限定解释或修正版，须按网站正文确定PASS的对象；本轮新增或修改版本均未再次送网站。
共26项问题，涉及36个source\_id。同一问题的多条来源已合并；各来源原文、版本和网站判定仍分别列出。

## 1. MD-5.2.1-DomainL2 / MD-5.2.1-L2Complete / MD-5.2.1-L2Norm

- source\_id：MD-5.2.1-DomainL2；MD-5.2.1-L2Complete；MD-5.2.1-L2Norm。

### MD-5.2.1-DomainL2

- 印刷页 / PDF页：183 / 204。
- 原文引文（逐字）：

> The set of functions from $\mathcal D\subset\mathbb R^m$ to $\mathbb R$ which satisfy (5.3) is referred to as the space $L^2(\mathcal D)$.

- 问题所在：domainL2对任意n和D采用Lp ℝ 2 (volume.restrict D)，是可测平方可积函数的几乎处处等价类，数学上是合理的标准L²实现。[EXTRA]已披露AE商，然而原句字面是原生函数集合；这是原书的语义省略，不能把商空间静默当作逐字原文。修正方案合理，但忠实字面版与标准解释仍需人工确认。 网站原文审校另记：code：R1\_ATTACHMENT\_MISSING；detail：指定附件/workspace/R1\_PAGES.pdf未发现；已改以工作区现有原书PDF相应物理页进行视觉对照，但不能认证附件18页的同一性。A项不可冒称已按指定附件完成。；code：BOOK\_L2\_AE\_QUALIFICATION；detail：原书未显式说明可测性及AE等价类；标准L²解释合理，但原生函数集合上的积分平方根仅为半范数，原书数学资格省略保留供人工确认。
- 反例或理由：n=1，D=ℝ；φ=1_{ {0} }与零函数逐点不同，均平方可积且积分平方为0；在Lp中二者是同一元素。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.domainL2`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：明确采用Lebesgue可测函数按几乎处处相等取商的Lp空间；原生函数集合不直接宣称为Hilbert空间。；`MD.Ch05.domainL2_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“明确采用Lebesgue可测函数按几乎处处相等取商的Lp空间；原生函数集合不直接宣称为Hilbert空间。”。
- 导师选项：保留原书句子；人工确认标准解释，并在context明确Lebesgue可测及AE商。若需要字面原生函数集合，应另列定义，不能声称其积分半范数是正定范数。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 ['MD.Ch05.domainL2']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.2.1-L2Complete

- 印刷页 / PDF页：183 / 204。
- 原文引文（逐字）：

> This is a real Hilbert space or complete inner product space in which, for any $\phi,\psi\in L^2(\mathcal D)$, the inner product is defined by $\langle\phi,\psi\rangle_{L^2(\mathcal D)}\stackrel{\rm def}{=}\int_{\mathcal D}\phi(z)\psi(z)\,d\omega$.

- 问题所在：在domainL2采用标准AE商Lp解释下，∀n,D及所有Cauchy序列u存在同空间极限v的声明正确，等价于该度量空间完备性；Lp的实内积结构与积分自洽。但原书将前述原生函数集合直接称为Hilbert空间，正定性存在AE资格省略。[EXTRA]披露了修正；不能把修正版的正确性等同于原书字面正确性。所引内积积分定义不在本条主声明中，项目在条目7摘录了domainL2Inner，可作配套定义。 网站原文审校另记：code：R1\_ATTACHMENT\_MISSING；detail：指定附件/workspace/R1\_PAGES.pdf未发现；已改以工作区现有原书PDF相应物理页进行视觉对照，但不能认证附件18页的同一性。A项不可冒称已按指定附件完成。；code：BOOK\_L2\_AE\_QUALIFICATION；detail：原书未显式说明可测性及AE等价类；标准L²解释合理，但原生函数集合上的积分平方根仅为半范数，原书数学资格省略保留供人工确认。
- 反例或理由：D=ℝ、φ=1_{ {0} }非零而⟨φ,φ⟩=0，故逐点函数集合配该双线性型并非内积空间。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.domainL2Complete`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.domainL2Complete_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：由人工确认以AE商L²作为原书默认解释；保留字面摘录并明确这是资格补充，同时引用domainL2Inner的积分定义。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 ['MD.Ch05.domainL2Complete']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.2.1-L2Norm

- 印刷页 / PDF页：183 / 204。
- 原文引文（逐字）：

> we define the $L^2(\mathcal D)$ norm by $\|\phi\|_{L^2(\mathcal D)}\stackrel{\rm def}{=}[\int_{\mathcal D}\phi^2(z)\,d\omega]^{1/2}$.

- 问题所在：domainL2Norm的g属于先前标准Lp实现的domainL2 n D，定义为其真实范数。按用户允许直接采信Mathlib标准含义，该实L²范数正是积分平方的平方根；不需要额外假设g的可积性或另造范数。所给定义没有独立积分公式定理，不能据此宣称该独立接口已经提供；这不改变定义的数学签名正确性。 网站原文审校另记：code：R1\_ATTACHMENT\_MISSING；detail：指定附件/workspace/R1\_PAGES.pdf未发现；已改以工作区现有原书PDF相应物理页进行视觉对照，但不能认证附件18页的同一性。A项不可冒称已按指定附件完成。；code：BOOK\_L2\_AE\_QUALIFICATION；detail：原书未显式说明可测性及AE等价类；标准L²解释合理，但原生函数集合上的积分平方根仅为半范数，原书数学资格省略保留供人工确认。
- 反例或理由：code：R1\_ATTACHMENT\_MISSING；detail：指定附件/workspace/R1\_PAGES.pdf未发现；已改以工作区现有原书PDF相应物理页进行视觉对照，但不能认证附件18页的同一性。A项不可冒称已按指定附件完成。；code：BOOK\_L2\_AE\_QUALIFICATION；detail：原书未显式说明可测性及AE等价类；标准L²解释合理，但原生函数集合上的积分平方根仅为半范数，原书数学资格省略保留供人工确认。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.domainL2Norm`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.domainL2Norm_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文并注明范围 / 接受独立限定修正版。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 ['MD.Ch05.domainL2Norm']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 2. MD-5.2.2-OutwardNormal

- source\_id：MD-5.2.2-OutwardNormal。

### MD-5.2.2-OutwardNormal

- 印刷页 / PDF页：184 / 205。
- 原文引文（逐字）：

> where $n(z)$ is the unit outward normal to the surface $\partial \mathcal A$ at the point $z$ and $d\sigma$ is the surface element.

- 问题所在：outwardNormalFor在每个z∈frontier A要求开邻域O、C²局部定义函数r、A在O内恰为r<0、非零真实梯度及ν z=∇r/‖∇r‖。边界点连续性迫使r(z)=0，正梯度方向指向A外，范数为1；资格确实限定光滑开放域。矩形角点不满足此全点条件，但[EXTRA]明确分面版本另列，未将角点假称光滑。dσ的具体测度在条目12定义。 网站原文审校另记：code：R1\_ATTACHMENT\_MISSING；detail：指定附件/workspace/R1\_PAGES.pdf未发现；已改以工作区现有原书PDF相应物理页进行视觉对照，但不能认证附件18页的同一性。A项不可冒称已按指定附件完成。；code：BOOK\_NORMAL\_AE\_QUALIFICATION；detail：上下文允许矩形，而本句把外法线说成每个边界点均有定义；矩形角点需按分面或表面积几乎处处理解。原句保留；Lean的光滑边界限制已披露。
- 反例或理由：code：R1\_ATTACHMENT\_MISSING；detail：指定附件/workspace/R1\_PAGES.pdf未发现；已改以工作区现有原书PDF相应物理页进行视觉对照，但不能认证附件18页的同一性。A项不可冒称已按指定附件完成。；code：BOOK\_NORMAL\_AE\_QUALIFICATION；detail：上下文允许矩形，而本句把外法线说成每个边界点均有定义；矩形角点需按分面或表面积几乎处处理解。原句保留；Lean的光滑边界限制已披露。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.outwardNormalFor`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.outwardNormalFor_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文并注明范围 / 接受独立限定修正版。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 ['MD.Ch05.outwardNormalFor']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 3. MD-5.2.2-GeneralFluxBalance

- source\_id：MD-5.2.2-GeneralFluxBalance。

### MD-5.2.2-GeneralFluxBalance

- 印刷页 / PDF页：184 / 205。
- 原文引文（逐字）：

> this same rate of change may be written as the negative of the particle flux over the boundary of $\mathcal A$:

$$
\frac{d\nu}{dt}=-\int_{\partial \mathcal A}f\cdot n\,\rho(z,t)\,d\sigma,
$$


> Using the divergence theorem, we may rewrite the latter quantity as a volume integral:

$$
\frac{d\nu}{dt}=-\int_\mathcal A\nabla\cdot(f(z)\rho(z,t))\,d\omega.
$$



- 问题所在：两个结论本身在所列资格下合理：任意正维n、开放D与有界光滑开放A、closure A⊆D、真实外法线；f为D上C¹，Φ为全局C²实际自治流且保持D，ρ在ℝ×D上C¹，各时刻为D上的概率密度，受限密度测度按Measure.map输运。结论先给质量时间导数等于负边界通量，再给体散度积分等于边界通量，两者推出原第二式。hausdorffArea使用单位球体积/2^d归一化直径型Hausdorff测度，方向和负号正确。[EXTRA]中“不要求ρ在D外光滑或归一化”按“在D外”共同限定两项来读，与签名一致；为避免误读，corrected\_json进一步明确D内确有概率归一化要求。这是注释澄清，不构成定理签名错误。 网站原文审校另记：code：R1\_ATTACHMENT\_MISSING；detail：指定附件/workspace/R1\_PAGES.pdf未发现；已改以工作区现有原书PDF相应物理页进行视觉对照，但不能认证附件18页的同一性。A项不可冒称已按指定附件完成。；code：EXTRA\_NORMALIZATION\_AMBIGUITY；detail：“不要求ρ在D外光滑或归一化”未明确归一化限制的作用域；签名实际上要求D内每个时刻积分为1。应明确不要求的是D外资格，不可称不要求任何归一化。
- 反例或理由：code：R1\_ATTACHMENT\_MISSING；detail：指定附件/workspace/R1\_PAGES.pdf未发现；已改以工作区现有原书PDF相应物理页进行视觉对照，但不能认证附件18页的同一性。A项不可冒称已按指定附件完成。；code：EXTRA\_NORMALIZATION\_AMBIGUITY；detail：“不要求ρ在D外光滑或归一化”未明确归一化限制的作用域；签名实际上要求D内每个时刻积分为1。应明确不要求的是D外资格，不可称不要求任何归一化。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.generalFluxBalance`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.generalFluxBalance_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：建议把[EXTRA]改写为“不要求ρ在D外光滑或满足概率条件；实际要求ρ在D内每个时刻非负、可积且积分为1”，避免把“无需域外资格”误读成“无需D内归一化”。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 ['MD.Ch05.generalFluxBalance']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 4. MD-5.2.2-RapidAdjoint

- source\_id：MD-5.2.2-RapidAdjoint。

### MD-5.2.2-RapidAdjoint

- 印刷页 / PDF页：185–186 / 206–207。
- 原文引文（逐字）：

> Let $u,v$ be two scalar valued functions in $\mathbb R^m$ which tend to zero sufficiently rapidly at infinity. By our assumptions that $u$ and $v$ are rapidly decaying we know that $B\to0$, as $\ell\to\infty$. Taking the limit, we are thus left with the equation

$$
\langle u,\mathcal L_fv\rangle=-\sum_i\int_{\mathbb R^m}v\frac{\partial}{\partial z_i}(uf_i)\,d\omega=\langle M_fu,v\rangle.
$$


> We refer to $M_f$ as the adjoint operator of $\mathcal L_f$ and we write $M_f=\mathcal L_f^\dagger$.

- 问题所在：声明本身是正确的条件化版本：n>0，f为C¹，u,v为SchwartzMap，两个实际混合乘积分别可积，且真实盒边界项B趋0，才推出全空间积分配对相等。由紧盒分部积分和两个可积函数的盒截断极限可得该结论；没有将最终配对相等作为假设。但原页声称仅由u,v迅速衰减便知B→0，未明确f的增长控制；[EXTRA]把B→0改为前提是实质补充，不能据此宣布原书推论已成立。按任务规定保留原句并将原书条件疑点交人工；形式伴随记号也不等于闭Hilbert算子伴随的定义域识别。 网站原文审校另记：原书由u,v迅速衰减推出B→0，缺少对f增长或混合乘积的明确资格；当前Lean已把边界极限和可积性补成前提，但不能反向认证原书无条件推断。
- 反例或理由：针对原书未限制f的B→0推断：m=1，u(x)=v(x)=exp(-x²)均为Schwartz函数，取C∞场f(x)=x exp(2x²)。则uvf=x，盒[-ell,ell]的B=ell-(-ell)=2ell，不趋0。这里混合乘积并不可积，故此例不反驳当前带可积性及B→0前提的Lean声明，只说明原书需明确额外资格。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.rapidAdjoint`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.rapidAdjoint_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原书字面句，人工决定f的增长/边界条件应如何注明；可保留目前明确可积性与B→0的条件化Lean版本，或另列具有足够增长控制的f的推论。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 ['MD.Ch05.rapidAdjoint']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 5. MD-5.3.2-ConvergenceHeuristic

- source\_id：MD-5.3.2-ConvergenceHeuristic。

### MD-5.3.2-ConvergenceHeuristic

- 印刷页 / PDF页：190 / 211。
- 原文引文（逐字）：

> As the flow is Hamiltonian, $\int_{\mathcal D}\rho(\mathbf q,\mathbf p,t)\,d\omega\equiv\int_{\mathcal D}\rho(\mathbf q,\mathbf p,0)\,d\omega$. Thus the condition for $\bar\phi$ to converge is just that

$$
\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\frac{\partial\rho}{\partial t}(\mathbf q,\mathbf p,t)\,d\omega\to0.
$$



- 问题所在：本轮依补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义：EuclideanSpace ℝ (Fin n) 是欧氏 ℝⁿ，volume 是标准 Lebesgue 测度，积分是 Bochner 积分（不可积时为 0），受限测度、可测性、可积性、紧支撑、光滑性和极限均按标准含义解释；不在 Ch05\_deps.txt 寻找 Mathlib 定义体，不因其未收录而判材料不足。本次仅使用与 input\_sha256 一致的三个附件；不使用其他旧 Ch0x.lean 或 ch0x\_source.json。核对 Ch05.lean:707–716，并展开项目 flow、measurePropagator 以及本文件的 densityOn、probabilityDensityOn、densityMeasureOn、densityAverageOn。flow 含 Φ0=id、实时间群律及每条轨道的真实 ODE 导数；measurePropagator 是 Measure.map；densityOn 是受限体积下的可测、非负、可积资格，probabilityDensityOn 另含 ∫_Dρ=1；densityMeasureOn 是 (volume.restrict D).withDensity(ofReal ρ)；densityAverageOn 是实际积分商。标准定义足以确认这些对象，无缺失 Mathlib 定义问题。量词先给 n,D,f,Φ,ρ,φ，前提为零可测 D、真实流、D 流不变、每个 Φt 保体积、联合 C¹ 密度、C∞ 紧支撑 φ、各时刻实际概率密度及从初始测度的真实输运；最后假设导数配对趋零，并得依赖 φ 的某个平均极限。[EXTRA] 域不变、输运与保体积均合理，未假设最终平均收敛。质量等式可由各时刻概率归一化直接读出，两端都是 1，不因其未重复列在结论而判失败。保留 FAIL 的具体原因是 statement\_scope 的完整条件措辞：“the condition ... is just that”的条件读法包含必要方向，当前签名只有导数配对趋零 ⇒ 平均收敛；缺少反向，而且没有在映射中登记为单向子命题。原文未写显式 iff，这一范围问题不能通过默认把“condition”缩成充分性来静默消除；若采用这种作者解释，需明确登记缩窄范围。此 FAIL 不表示目前充分方向在上述动力学背景中为假，也不依据 Mathlib 缺失。一般标量导数趋零却不收敛的例子不是满足该签名全部前提的反例。证明体为 sorry，单独记录，不用于决定语义 verdict；无 [ERRATUM?] 标注。 网站原文审校另记：
- 反例或理由：缺失条款：在原段落的“condition ... is just that”完整条件读法下，缺少 (∃ L, Tendsto (ensembleAverageOn D ρ φ) atTop (𝓝 L)) → Tendsto (fun t => ∫ z in D,φ z*deriv (fun s => ρ s z) t) atTop (𝓝 0)。这是一项范围缺失，不是对现有充分方向的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.convergenceHeuristic`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。；`MD.Ch05.convergenceHeuristic_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。”。
- 导师选项：保留原句的字面记录。把质量守恒背景与收敛条件分清，并按本条完整范围补出必要方向；对必要方向登记足够的向量场/导数正则性，例如连续向量场使测试 Lie 导数在紧支撑上可控，不能仅凭一般微积分把它当作自动成立。若只拟形式化充分方向，应明确将该 Lean 项登记为原启发式的单向子命题，同时另列原句未覆盖的方向，不能把目前单向签名标作完整覆盖。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.convergenceHeuristic。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 6. MD-5.3.2-ShellWeakPrinted / MD-5.3.2-ShellWeakLimitCorrected

- source\_id：MD-5.3.2-ShellWeakPrinted；MD-5.3.2-ShellWeakLimitCorrected。

### MD-5.3.2-ShellWeakPrinted

- 印刷页 / PDF页：191 / 212。
- 原文引文（逐字）：

> As we decrease $\varepsilon$, the density remains invariant under Liouville's equation. The prefactor means that we can think of a sequence of smooth densities taken with successively smaller values of $\varepsilon$ as approaching the limiting distribution defined in terms of the delta function by

$$
\rho_0(q,p)=Z_{H=E}^{-1}\delta[H(q,p)-E].\tag{5.7}
$$


> To make this statement precise, the definition of the limit must be taken here in the weak sense, that is, we need to study the limit

$$
\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_D\phi(q,p)\rho_\varepsilon d\omega,\tag{5.8}
$$


> taken in relation to a test function $\phi\in\mathcal T$.

- 问题所在：按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v\_d/2^d) • Measure.hausdorffMeasure d，其中v\_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。shellWeight H c ε z = exp(−(H z−c)²/(2ε))；shellPartition H c ε = ∫shellWeight；shellDensity = shellWeight/shellPartition。testSpace n = {φ : ℝⁿ→ℝ | φ为C∞且有紧支撑}。microRaw = surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))；microMeasure = ((microRaw H c) univ)⁻¹ • microRaw H c；microAverage = average microMeasure，average μ g = ∫g dμ。regularEnergy H c展开为能量面非空、紧、每点grad≠0，以及raw总质量严格正且有限。 量词为∀n,H,c，在C²与regularEnergy前提后对每个C∞紧支φ，主张ε↓0时Z\_ε⁻¹∫φρ\_ε趋向microAverage。PDF211已将ρ\_ε定义为归一化密度，PDF212式(5.8)再次出现外层Z\_ε⁻¹；项目定义展开确认该签名确实重复归一化。全相空间D=ℝⁿ的EXTRA是合理范围选择，但不能消除反例；原书的尾部可积性也未由regularEnergy单独保证。原文所引Liouville不变性不在本签名结论中。相关原书疑误成立；FAIL来自错误极限和缺失结论，不是Mathlib材料不足。实际声明含sorry，此事实与语义判定分开。 网站原文审校另记：
- 反例或理由：取n=2，H(z)=‖z‖²，c=1。单位圆能量面非空紧，grad=2z，raw总质量π>0且有限，故全部签名前提满足。取C∞紧支φ，在能量面某邻域恒1。由极坐标Z\_ε=π∫₀^∞exp(−(u−1)²/(2ε))du ~ π√(2πε)→0，而∫φρ\_ε→1。因此额外乘Z\_ε⁻¹后的左侧发散，microAverage=1。此反例中权确实可积，Bochner总化不参与反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.shellWeakPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。；`MD.Ch05.shellWeakPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。”。
- 导师选项：将字面版保留为原书勘误记录；可证明的修正版删去外层Z\_ε⁻¹，补上控制尾部的紧能量带及小ε权可积等条件。若仍按当前statement\_scope覆盖全部所引文字，还需独立陈述Hamiltonian流下的Liouville不变性。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.shellWeakPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.3.2-ShellWeakLimitCorrected

- 印刷页 / PDF页：191 / 212。
- 原文引文（逐字）：


$$
\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\rho_\varepsilon\,d\omega,\tag{5.8}
$$



- 问题所在：这是 source\_id 明示的独立勘误版本，不能按字面(5.8)要求它再除一次 Zε。声明完整量化 n、H、c，要求 n>0、H 为 C²、regularEnergy H c、能级可达，以及存在正 δ 的紧能带与所有 ε∈(0,δ) 的真实权可积及正分母。regularEnergy 展开后含非空紧能量面、其上处处非零的真实梯度、microRaw 有限正总质量；单列可达条件虽冗余但无害。测试空间确为全部 C∞ 紧支撑函数。被积式是 φ乘已经归一化的 shellDensity，ε 从正侧趋零。microAverage 展开为将曲面 Hausdorff 面积按 1/‖∇H‖ 加权后，再以该 raw 总质量归一化的真实测度积分。所有对象和归一化均匹配正确的 coarea 弱极限；紧带及一个较大正参数下的权可积控制带外尾部，所以假设足够，没有把极限当假设。未缩放的 Zε 通常趋零，曲面质量对应 Zε/√(2πε) 的极限而非 Zε 的普通极限。故当前勘误签名 PASS；原书重复归一化仍作为独立疑误 NEEDS\_HUMAN 保留。 网站原文审校另记：code：SOURCE\_LITERAL\_TYPOGRAPHY；scope：A\_TRANSCRIPTION；location：statement\_latex；explanation：原页为积分域 \mathcal D 和粗体相变量 q,p；输入使用普通 D、q,p。；action：恢复原页记号，不改变积分或原书的重复归一化。；code：SOURCE\_EQUATION\_LABEL\_MISSING；scope：A\_METADATA；location：label / statement\_latex；explanation：原页此展示式有编号(5.8)，输入 label=null 且未记 tag。；action：补记 label="5.8" 与展示式 tag{5.8}。；code：BOOK\_DOUBLE\_NORMALIZATION；scope：A\_BOOK\_MATHEMATICS；location：原书(5.8)；explanation：PDF211已经定义 ρε=权/Zε，PDF212的(5.8)又对其配对除以 Zε；字面式通常发散，不能等于归一化微正则配对。；action：原文保持字面式并交人工勘误；当前 Lean 作为独立修正版删除多余因子是合理的。；code：BOOK\_UNSCALED\_PARTITION\_LIMIT；scope：A\_BOOK\_CONTEXT；location：原书(5.7)后对 Z_{H=E} 的说明；explanation：原页称曲面归一化常数为 Zε 的 appropriate limiting value，未说明必要的 √(2πε) 缩放；不能按通常未缩放极限理解。；action：保留原书说明作为疑误；正确曲面质量与 Zε/√(2πε) 对应。此处只作上下文登记，不扩审(5.7)的其他声明。
- 反例或理由：仅针对原书(5.8)，不是当前勘误 Lean：取二维 H(q,p)=(q²+p²)/2、c=1，以及在能量圆附近恒为1的 C∞ 紧支撑 φ。极坐标给出 Zε=2π∫₀∞exp(−(s−1)²/(2ε))ds，故 Zε/√(2πε)→2π、Zε→0；归一化配对 ∫φρε→1。因此原书额外乘 Zε⁻¹ 的式子发散，而当前 Lean 的配对极限为1。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.shellWeakLimit`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.shellWeakLimit_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：不改原文(5.8)；保留其重复 Zε⁻¹ 并登记人工勘误。独立修正版维持当前 Lean 的单次归一化；将曲面质量明确解释为缩放后的 Zε/√(2πε) 极限。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch05.shellWeakLimit。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 7. MD-5.3.2-SurfaceAreaFormula

- source\_id：MD-5.3.2-SurfaceAreaFormula。

### MD-5.3.2-SurfaceAreaFormula

- 印刷页 / PDF页：191 / 212。
- 原文引文（逐字）：

> If we can represent the $m-1$-dimensional set $\mathcal M$ as the image of an open set $\mathcal U\in\mathbb R^{m-1}$ under a smooth mapping $\mathbf g:\mathbb R^{m-1}\to\Sigma_E$, then we have

$$
\operatorname{Vol}(\mathcal M)=\int_{\mathcal U}\sqrt{\det[(\mathbf g^{\prime}(\boldsymbol\zeta))^T\mathbf g^{\prime}(\boldsymbol\zeta)]}\,d\zeta_1d\zeta_2\cdots d\zeta_{m-1}.
$$



- 问题所在：限定后的 Lean 面积公式在数学上正确：∀ d、g:E d→E(d+1)、开集 U，要求 U 上 C¹、g 全局单射，并要求 U 上每点的真实 fderiv 单射。结论左边使用项目 hausdorffArea d 在 g像U 上的测度，右边由标准欧氏基的导数向量内积构成完整 d×d Gram 矩阵，取 determinant 的非负平方根并在 U 上积分；正是 m=d+1 的无重数面积公式。hausdorffArea 的项目缩放为 d维单位球体积/2^d，落实标准欧氏面积。由于两边分别使用 ENNReal.toReal 和实值 Bochner 积分，非有限情形是总化解释，并不额外宣称面积有限；有限面积时即通常数值公式。未要求像落在某一特定能量面，是对与 H 无关的局部面积公式的合理推广。须明确的是 Function.Injective g 为全局单射，比仅在 U 上单射更强，且 C¹ 比原书 smooth 所需的正则性更弱；这两点都不使受限公式错误。[EXTRA] 确实补入了单射浸入资格，但原书仅凭任意 smooth mapping 的原句不成立，另有 ∈ 的类型错误；按任务要求原书疑误不能静默按 chart 解读，因此本条整体 NEEDS\_HUMAN，而非因 sorry 或限定后公式错误判 FAIL。 网站原文审校另记：code：SOURCE\_LITERAL\_TYPOGRAPHY；scope：A\_TRANSCRIPTION；location：statement\_latex / context\_notation；explanation：原页集合为花体 ℳ、𝒰，映射 g 和参数向量 ζ 使用粗体；输入统一成了普通 M、U、g、ζ。；action：只恢复原页字形及 ζ；不把原书 ∈ 改为子集符号。；code：BOOK\_OPEN\_SET\_MEMBERSHIP；scope：A\_BOOK\_MATHEMATICS；location：原句 open set 𝒰∈ℝ^{m−1}；explanation：开集应是 ℝ^{m−1} 的子集；原书却写为其元素。；action：原文保留 ∈ 并交人工处理，另行勘误时写 𝒰⊂ℝ^{m−1}。；code：BOOK\_AREA\_MULTIPLICITY\_GAP；scope：A\_BOOK\_MATHEMATICS\_AND\_C\_SCOPE；location：原书面积公式的 smooth mapping 前提；explanation：仅有光滑映射及给定像集不能推出无重数面积公式；重复覆盖会在参数积分中计算重数。Lean 的单射浸入 [EXTRA] 确实是对原书的资格补充。；action：保留原文；人工确认按单射参数化理解，或单列修正版／改成计重数面积公式。
- 反例或理由：针对缺少单射假设的原书字面公式：令 m=2，H(x,y)=(x²+y²)/2，E=1/2，g(t)=(cos t,sin t)，U=(0,4π)。g 是映到该能量圆的光滑浸入，像 M 是整个单位圆，面积即弧长为2π；Gram 因子恒为1，参数积分为4π。故原书任意 smooth mapping 版本不成立。此例不满足当前 Lean 的全局单射条件，不是限定后 Lean 公式的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.surfaceAreaFormula`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.surfaceAreaFormula_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文保持字面并保留 NEEDS\_HUMAN。将当前带单射浸入条件的 Lean 明确标作独立资格补充版；如需最小假设，可把全局单射减弱为在 U 上单射。若保留任意光滑映射，应使用计重数面积公式。不要仅为取有限实数而忽略 toReal／积分总化语义。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch05.surfaceAreaFormula。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 8. MD-5.3.2-PatchShellVolume

- source\_id：MD-5.3.2-PatchShellVolume。

### MD-5.3.2-PatchShellVolume

- 印刷页 / PDF页：192–193 / 213–214。
- 原文引文（逐字）：

> The volume of this thickened shell is clearly $\Delta V=\int_M\xi d\sigma$, but since $\Delta E=H(z+n\xi)-H(z)=\nabla H\cdot n\xi+O(\Delta E^2)$, and $n=\nabla H/\|\nabla H\|$, we have $\xi=\Delta E/\|\nabla H\|+O(\Delta E^2)$, and $\Delta V=\int_M\frac{\Delta E}{\|\nabla H\|}d\sigma+O(\Delta E^2)$. Taking the ratio of $\Delta V$ to $\Delta E$ we find $\Delta V/\Delta E=\int_M\|\nabla H\|^{-1}d\sigma+O(\Delta E)$. The limit of this as $\Delta E\to0$ defines a quantity $\mu(M)=\int_M\|\nabla H\|^{-1}d\sigma$.

- 问题所在：本轮按补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义：EuclideanSpace 是欧氏空间，volume 是其标准Lebesgue测度，积分为Bochner积分，MeasurePreserving 是可测映射的推前测度保持；restrict、withDensity、Tendsto、ContDiff、gradient、ENNReal.ofReal/toReal 等均按标准含义，不要求其定义体收录在依赖摘录。仅展开本项目自定义，使用与上一轮三项SHA256完全相同的附件；未采用其他旧工程文件。核对 Ch05.lean 的 MD.Ch05.patchShellVolume（810–817行）及PDF213–214/印刷192–193。在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 中逐项展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z | H z=c}；grad H z=gradient H z；normalField H z=‖grad H z‖⁻¹ • grad H z；hausdorffArea d=ENNReal.ofReal(vol(Ball(0:E d,1)).toReal/2^d) • hausdorffMeasure d；surfaceMeasure 是 hausdorffArea(n−1) 在 energySurface 上的限制；microRaw 是 surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))，即原文未归一化的曲面加权测度。欧氏空间中这个Hausdorff归一化对应通常诱导面积，不因工程尚有余面积证明义务而把定义判为未知。regularEnergy 并非仅正则值条件，而是能量面非空、紧、处处grad≠0、raw总质量严格正且有限的合取。实际签名对每个紧可测M⊂Σ\_c，先选C,δ>0，再对所有0<e<δ，给由x=z+s n(z)、0≤s<δ、H(x)−H(z)≤e定义的真实法线薄壳满足|vol(S\_e)/e−μ(M)|≤Ce。C²、紧正则面与可测片足以保证小管几何，额外全能量面非空及质量正并非局部估计的最小要求，但作为明确的物理背景合理。最终O(e)结论以及由它推出的极限正确；乘以e也得到体积的O(e²)式。然而本条statement\_scope覆盖所引整段，其“clearly ΔV=∫_M ξdσ”精确等式既未编码也一般不成立；[EXTRA]关于Jacobian的勘误判断成立，不能将该错误原印刷式视为已经保留。此FAIL针对完整引用范围的覆盖，不是否定修正后最终渐近估计。附件对应theorem的证明体仍为sorry；这里只判断签名语义，PASS不表示Lean证明已完成。 网站原文审校另记：
- 反例或理由：取ℝ²中H(z)=‖z‖²/2、c=1/2，M为单位圆，ξ>0为统一向外法向厚度。薄壳真实面积π((1+ξ)²−1)=2πξ+πξ²，但∫_M ξdσ=2πξ。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.patchShellVolume`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.patchShellVolume_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：把错误的原印刷精确式明确列为ERRATUM保留记录，将正确目标范围单列；用ΔV=∫_M∫_0^{ξ(z,e)}J(z,s)ds dσ、J(z,s)=1+O(s)说明修正。当前O(e)签名可作为修正版目标，不应标为已覆盖整段每个原等式。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.patchShellVolume。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 9. MD-5.3.2-WholeShellVolumeLimit

- source\_id：MD-5.3.2-WholeShellVolumeLimit。

### MD-5.3.2-WholeShellVolumeLimit

- 印刷页 / PDF页：192 / 213。
- 原文引文（逐字）：

> $\Delta V/\Delta E=\int_M\|\nabla H\|^{-1}d\sigma+O(\Delta E)$.

- 问题所在：本轮按补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义：EuclideanSpace 是欧氏空间，volume 是其标准Lebesgue测度，积分为Bochner积分，MeasurePreserving 是可测映射的推前测度保持；restrict、withDensity、Tendsto、ContDiff、gradient、ENNReal.ofReal/toReal 等均按标准含义，不要求其定义体收录在依赖摘录。仅展开本项目自定义，使用与上一轮三项SHA256完全相同的附件；未采用其他旧工程文件。核对 Ch05.lean 的 MD.Ch05.shellVolumeLimit（821–827行）及所引PDF213/印刷192比值式。在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 中逐项展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z | H z=c}；grad H z=gradient H z；normalField H z=‖grad H z‖⁻¹ • grad H z；hausdorffArea d=ENNReal.ofReal(vol(Ball(0:E d,1)).toReal/2^d) • hausdorffMeasure d；surfaceMeasure 是 hausdorffArea(n−1) 在 energySurface 上的限制；microRaw 是 surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))，即原文未归一化的曲面加权测度。欧氏空间中这个Hausdorff归一化对应通常诱导面积，不因工程尚有余面积证明义务而把定义判为未知。regularEnergy 并非仅正则值条件，而是能量面非空、紧、处处grad≠0、raw总质量严格正且有限的合取。microPartition H c=((microRaw H c) univ).toReal；regularEnergy确保有限性，在此处toReal无损。签名表达整能量面全壳{c≤H≤c+ε}的体积比值在ε→0+时收敛到该总质量。额外紧正则能量带避免远处分支贡献，是合理的全壳控制；其邻域∀z梯度非零明确且非循环。但所引式对任意片M并含O(ΔE)，而本签名无M且仅Tendsto，没有O(ε)误差界。[EXTRA]诚实标明这是特例，不能使较弱特例等同于所引全部结论；别条保留片定理也不改变本声明。附件对应theorem的证明体仍为sorry；这里只判断签名语义，PASS不表示Lean证明已完成。 网站原文审校另记：
- 反例或理由：缺失条款为任意紧可测M⊂Σ\_c的片壳结论及∃C,δ>0、∀0<ε<δ的误差≤Cε。一般仅极限不蕴含O(ε)：ε↦L+√ε趋于L却无该误差界；此例只说明结论强弱，不是本几何模型的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.shellVolumeLimit`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.shellVolumeLimit_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：将引用范围明确改为整面极限推论；若要求覆盖当前整条原式，则增加任意片M及O(ε)定量结论。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.shellVolumeLimit。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 10. MD-5.3.2-ShellPointValuePrinted

- source\_id：MD-5.3.2-ShellPointValuePrinted。

### MD-5.3.2-ShellPointValuePrinted

- 印刷页 / PDF页：191 / 212。
- 原文引文（逐字）：

> The proof that (5.8) can be taken and that

$$
\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_D\phi(q,p)\rho_\varepsilon d\omega=\rho_0(q,p)=Z_{H=E}^{-1}\int_D\phi(q,p)\delta[H(q,p)-E]d\omega
$$


> may be found in the PhD thesis of Hartmann [171, Appendix D].

- 问题所在：本轮按补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义：EuclideanSpace 是欧氏空间，volume 是其标准Lebesgue测度，积分为Bochner积分，MeasurePreserving 是可测映射的推前测度保持；restrict、withDensity、Tendsto、ContDiff、gradient、ENNReal.ofReal/toReal 等均按标准含义，不要求其定义体收录在依赖摘录。仅展开本项目自定义，使用与上一轮三项SHA256完全相同的附件；未采用其他旧工程文件。核对 Ch05.lean 的 MD.Ch05.shellWeakPairing（853–854行）及PDF212/印刷191展示式。在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 中逐项展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z | H z=c}；grad H z=gradient H z；normalField H z=‖grad H z‖⁻¹ • grad H z；hausdorffArea d=ENNReal.ofReal(vol(Ball(0:E d,1)).toReal/2^d) • hausdorffMeasure d；surfaceMeasure 是 hausdorffArea(n−1) 在 energySurface 上的限制；microRaw 是 surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))，即原文未归一化的曲面加权测度。欧氏空间中这个Hausdorff归一化对应通常诱导面积，不因工程尚有余面积证明义务而把定义判为未知。项目定义链为shellWeakPairing H c φ=microAverage H c φ=average(microMeasure H c)φ，average μ φ=∫z,φ z ∂μ，microMeasure=(raw univ)⁻¹ • raw。故它是一个实值归一化曲面测试函数配对；标准Bochner积分不可积时取0，无测试函数或Integrable限制的def不能额外承诺其物理弱配对对所有φ都有效。本条实际没有ε、D、Z\_ε、ρ\_ε及Tendsto，不表达所引弱极限等式。[EXTRA]如实承认这里只给notation；这不够覆盖当前statement\_scope的整条原式。原式把依赖φ的标量配对写成分布ρ₀(q,p)点值，ERRATUM判断成立；重复的Z\_ε⁻¹按原印刷保留，其解释不得从本notation的类型正确性推出。此def本身无sorry，但也无待验证的弱极限定理。 网站原文审校另记：
- 反例或理由：原式若按字面点值解释，则φ=0使两端配对为0，中间ρ₀却是非零归一化Dirac型分布；该分布通常没有逐点ρ₀(q,p)。签名还缺全部ε→0的收敛条款，无法用一个固定配对定义替代。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.shellWeakPairing`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.shellWeakPairing_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留印刷式和ERRATUM标记；将shellWeakPairing单列为有限正质量、适当可积测试函数域上的记号。要覆盖弱极限应另列带shell族、测试函数、必要尾部/正则控制的Tendsto定理，显式说明重复归一化问题。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.shellWeakPairing。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 11. MD-5.3.2-HarmonicPartition / MD-5.3.2-HarmonicQuadraturePrinted

- source\_id：MD-5.3.2-HarmonicPartition；MD-5.3.2-HarmonicQuadraturePrinted。

### MD-5.3.2-HarmonicPartition

- 印刷页 / PDF页：193 / 214。
- 原文引文（逐字）：

> $\mu(\Sigma_E)=4\int_0^{\sqrt{2E}/\Omega}\frac1{\sqrt{2E-\Omega^2q^2}}dq=2\pi/\Omega$.

- 问题所在：NEEDS\_HUMAN 是原页推导疑误的分流，不是因 sorry 或因当前两个签名错误。两条 Lean 签名在 Ω,c>0 下均通过；quadrature 实现原印后两行的正确积分。原印第一行另有不一致上限，不能用这两条签名声称整段印刷推导已经逐字正确。 网站原文审校另记：code：PRINTED\_FIRST\_QUADRATURE\_BOUND；field：proof\_discussion\_latex；category：source\_math；description：原页第一行参数积分的上限印为 √(2E)，随后两行上限为 √(2E)/Ω。前者一般不能参数化整个第一象限椭圆弧；原印疑误须保留并转人工，不把它改成后者再称逐字正确。；code：PRINTED\_DERIVATION\_NOT\_RECORDED；field：proof\_note / proof\_discussion\_latex；category：annotation；description：原页确有 Example 5.1 的参数积分计算。补存原印推导（含可疑首上限），区分“未另设完整证明”和“没有计算论证”。
- 反例或理由：仅针对原印首上限：令 Ω=2、E=1，第一象限椭圆弧的 q 范围止于 √2/2；原印首积分却到 √2。其 p=√(2−4q²) 的实椭圆参数解释超出合法范围。当前 Lean 两条声明都使用正确上限或正确终值，未受此反例否定。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.harmonicPartition`（未证）；`MD.Ch05.harmonicPartition_quadrature`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.harmonicPartition_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：人工确认首行上限是否漏印 /Ω。原文字面证据保留 √(2E)，另将修正版标明 √(2E)/Ω；当前两个 Lean 签名可保留。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch05.harmonicPartition。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.3.2-HarmonicQuadraturePrinted

- 印刷页 / PDF页：193 / 214。
- 原文引文（逐字）：

> Parameterizing the surface by $q$, we have $p=\sqrt{2E-\Omega^2q^2}$, then

$$
\mu(\Sigma_E)=4\int_0^{\sqrt{2E}}\frac{\sqrt{1+p_q^2}}{\sqrt{H_p^2+H_q^2}}dq =4\int_0^{\sqrt{2E}/\Omega}\frac{\sqrt{1+\frac{\Omega^4q^2}{2E-\Omega^2q^2}}}{\sqrt{p^2+\Omega^4q^2}}dq =4\int_0^{\sqrt{2E}/\Omega}\frac1{\sqrt{2E-\Omega^2q^2}}dq=2\pi/\Omega.
$$



- 问题所在：按补充规则，Mathlib v4.34.0 的 EuclideanSpace、volume、gradient、Hausdorff 测度、restrict、withDensity、ENNReal.ofReal、toReal、实平方根、实数幂、Gamma 和区间 Bochner 积分均直接采用标准数学含义，不要求在 Ch05\_deps.txt 查找其定义体。只对项目自定义逐层展开；判断签名是否覆盖本 source\_id 的全部原文结论，与是否存在 sorry 分开。 PDF214/印刷193的第一积分上界确为√(2E)，后两项为√(2E)/Ω。附件签名量化所有Ω,c>0，将图形上的p\_q²展开为(Ω²q/√(2c−Ω²q²))²，将H\_p²+H\_q²展开为2c−Ω²q²+Ω⁴q²；这些在实图形内部正确，但不同上界的两积分一般不等。[EXTRA]正c在原页已有，正Ω为合理频率约定且排除退化；端点总化只修改零测点，不能修复区间长度的差异。原书首上界应为√(2E)/Ω的疑误可由下述反例确认；未静默修改原书。所引完整链的μ(Σ\_E)及2π/Ω还没有出现在本签名中。失败依据是假命题和缺失子句，并非Mathlib定义缺失；该theorem的sorry仅说明证明尚未完成。 网站原文审校另记：
- 反例或理由：取Ω=1/2、c=1/2，满足全部正性前提。在q∈[0,1]上左被积函数准确化为(1−q²/4)^(-1/2)，故左值4∫₀¹dq/√(1−q²/4)=4π/3。右值4∫₀²dq/√(1−q²/4)=4π；终点总化不改变该可积积分。因此当前等式为假。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.harmonicQuadraturePrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：首积分上界补/Ω，后续积分及microPartition由HarmonicPartition配套声明；原印上界不改。；`MD.Ch05.harmonicQuadraturePrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“首积分上界补/Ω，后续积分及microPartition由HarmonicPartition配套声明；原印上界不改。”。
- 导师选项：保留印刷原式及勘误记录；另立修正的数学签名，把首积分上界改为√(2c)/Ω，并补上microPartition与完整积分链及2π/Ω的等式。不能通过补证明解决当前反例。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.harmonicQuadraturePrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 12. MD-5.3.3-MicroMeasure

- source\_id：MD-5.3.3-MicroMeasure。

### MD-5.3.3-MicroMeasure

- 印刷页 / PDF页：194 / 215。
- 原文引文（逐字）：

> Let $d\mu_E=Z_E^{-1}\|\nabla H\|^{-1}d\sigma$. We refer to this as the microcanonical probability density and write, for an “appropriate” set $\mathcal A$, $\operatorname{Pr}(\mathcal A)=\mu_E(\mathcal A)=\int_{\mathcal A} d\mu_E$. The only requirement for this to make sense is that the set $\mathcal A$ be a measurable subset of the $H=E$ energy surface, i.e. that it be possible to compute its surface area.

- 问题所在：NEEDS\_HUMAN 针对原书“唯一要求”及可测性解释的资格问题。Lean 定义作为一个总化测度通过签名审校，[EXTRA] 也正确声明了概率解释必须有正有限 raw 总质量；不能因此把原书未写出的条件说成已在原句中出现。当前定义的每个值都是测度，而它成为概率测度的范围由第10条严格规定。 网站原文审校另记：code：PROBABILITY\_NORMALIZATION\_PREREQUISITES；field：statement\_latex / issues；category：source\_math；description：原书声称“唯一要求”是 A 为可测能级子集；若未在背景另保证 0<Z\_E<∞，可测性本身不足以产生概率测度。保留原句并转人工核实隐含的全局资格，不静默添加到原文。；code：MEASURABLE\_NOT\_COMPUTABLE；field：statement\_latex / issues；category：source\_math；description：“可测”与“能够计算其表面积”不是严格等价的数学定义；原书 i.e. 语句保留为解释性原话，不能用作可测性的定义。
- 反例或理由：取 H(q,p)=p²/2、c=1，位置 q 取整个ℝ。任意有界能级弧段 A 都可测，但全能级的 raw 总质量为∞，ENNReal 的逆为0，定义所得 microMeasure 是零测度而非概率测度。此例不满足 [EXTRA] 的正有限资格，所否定的是“仅可测性就足够”的无条件读法。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.microMeasure`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：归一化主接口显式要求原始质量正且有限；任意H,c的总化公式仍保留为原辅助，不声称退化能级也是概率分布。；`MD.Ch05.microMeasure_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“归一化主接口显式要求原始质量正且有限；任意H,c的总化公式仍保留为原辅助，不声称退化能级也是概率分布。”。
- 导师选项：人工确认前文是否已经全局假设 0<Z\_E<∞；若未假设，另设带该条件的修正版，原文版继续保留原句及 NEEDS\_HUMAN。将表面积可计算性仅作为非正式解释。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch05.microMeasure。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 13. MD-5.3.3-LowerDimensionNull

- source\_id：MD-5.3.3-LowerDimensionNull。

### MD-5.3.3-LowerDimensionNull

- 印刷页 / PDF页：195 / 216。
- 原文引文（逐字）：

> We also note that lower order objects such as a point or a curve in $\mathbb R^2$, or a surface in $\mathbb R^3$, have zero measure with respect to Lebesgue measure for the ambient space. Similarly, for a Hamiltonian system with $N_d$ degrees of freedom, the energy surface is of dimension $2N_d-1$ and the probability measure of sets of lower dimension than this will vanish.

- 问题所在：FAIL（整条原文的完整覆盖），同时原书的未限定维数语言需人工确认。三个现有 Lean 声明本身均数学正确，且第二条确有环境 volume=0；但这只覆盖位于能级且 d<n−1 的集合，不能冒称原文第一句的一般环境低维零测已覆盖。n=2,d=1 的曲线及 n=3,d=2 的曲面都不满足其严格维数前提，而它们恰是原文列举对象。第二句的正则能级、光滑低维零测已有合理受限实现；该部分通过不能补上第一句的缺口。 网站原文审校另记：code：AMBIENT\_NULL\_CLAUSE\_NOT\_COVERED；field：lean\_decl / extra\_assumptions；category：lean\_scope；description：本条原文第一句要求一般环境 Lebesgue 低维对象零测。现有唯一 volume 结论同时要求 d+1<n 且像集位于一个指定能级，未覆盖原文 R² 曲线(d=1,n=2) 或 R³ 曲面(d=2,n=3)。此为完整结论覆盖缺口，不是 sorry 问题。；code：DIMENSION\_REQUIRES\_REGULAR\_VALUE；field：statement\_latex / issues；category：source\_math；description：原文将能量面维数直接写作2N\_d−1；该断言需正则水平集资格，临界能级未必具有此维数。现有 Lean 已加正则性，但原文疑误仍需保留并转人工。；code：LOWER\_DIMENSION\_MEANING\_UNSPECIFIED；field：statement\_latex / context\_notation；category：source\_math；description：原文未界定 curve、surface 和 lower dimension 的正则性或维数概念；不能自动理解为任意拓扑低维集合。Lean 的 C¹ 可数紧参数块是一种明确且正确的受限版本。
- 反例或理由：覆盖缺口见光滑直线 g(t)=(t,0)⊂ℝ²，或光滑平面 g(s,t)=(s,t,0)⊂ℝ³：它们环境 Lebesgue 零测，但分别对应 d+1=n，无法实例化当前 countable 声明。这是缺少覆盖的见证，不是否定现有三个定理。针对原文无条件能级维数，取一自由度 H(q,p)=q²+p²、E=0，能级只有一点，维数0而非2·1−1=1；它不满足 Lean 的正则性前提。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.lowerDimensionNull`（未证）；`MD.Ch05.lowerDimensionNull_countable`（未证）；`MD.Ch05.lowerDimensionNull_level_dimension`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：本条网站意见已由FAIL修复处理，完整引文保留并独立登记覆盖问题；一般环境零测结论不作无条件能级维数定理。；`MD.Ch05.lowerDimensionNull_ambient_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“本条网站意见已由FAIL修复处理，完整引文保留并独立登记覆盖问题；一般环境零测结论不作无条件能级维数定理。”。
- 导师选项：另列一般环境零测声明：∀n,d，d<n，∀g:ℕ→E d→E n 及紧 K k，若每个 g k 为 C¹，则 volume(⋃k,g k  K k)=0；该声明无需 H、c 或像集位于能级的前提，即可覆盖原文光滑曲线/曲面的例子。保留当前三个声明，并将正则能级及“低维”的精确解释登记为修正版范围；原书字面句子保留 NEEDS\_HUMAN。本次不编辑工程、不补证明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.lowerDimensionNull。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 14. MD-5.4.1-UniformMicroErgodic

- source\_id：MD-5.4.1-UniformMicroErgodic。

### MD-5.4.1-UniformMicroErgodic

- 印刷页 / PDF页：197 / 218。
- 原文引文（逐字）：

> Definition 5.1 A Hamiltonian system is said to be ergodic on an energy surface $\Sigma_E$ (microcanonically ergodic) if, for almost all trajectories $\Gamma$ emanating from initial conditions on $\Sigma_E$, and for any observable $g$, the following holds $\bar g_\Gamma=\operatorname{Av}_{H=E}(g)$, where $\bar g_\Gamma$ is defined in (5.9). By “almost all” we mean that there could be a low-dimensional subset for which the trajectory averages fail to equal the space averages.

- 问题所在：主谓词的量词顺序准确为对 microMeasure 几乎处处 z，再对每个全局 C∞ 且该测度可积的实值 g；结论是实际无限时间平均等于实际空间平均。flow 明确零时恒等、实时间群律与逐时 ODE 导数；另有 H∈C²、全空间能量保持、非空紧正则面及正有限质量，并用常可逆反对称矩阵 J 指定 f=J∇H。这些 [EXTRA] 均在接口中，紧能量面上光滑 g 可积并不实质删去原文光滑观测量。问题在原书把 almost all 用 low-dimensional subset 解释：测度零与低维条件不能一般等同，Lean 未出现维数谓词。按通常微正则零测解释签名正确；若原文要求异常集严格低维则尚不忠实，需人工确定，不能静默裁定原书。 网站原文审校另记：stage：SOURCE\_MATH；code：ORIGINAL\_ALMOST\_ALL\_DIMENSION\_AMBIGUITY；description：原书 By “almost all”...low-dimensional subset 逐字相符，应保留。但低维与微正则零测并非同义：零测集合可以有满 Hausdorff 维数。当前 Lean 仅表述零测异常集，未表述低维异常集。需人工确认该句只是解释性直观还是额外维数要求。
- 反例或理由：测度论差异的例子：实直线上存在 Lebesgue 零测且 Hausdorff 维数为1的集合；故“零测”本身不推出“严格低维”。这是原书术语解释的反例，不声称已给出满足本条 Hamiltonian 假设的动力学反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.uniformMicroErgodic`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.uniformMicroErgodic_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文低维句；由人工决定其语义。若仅指 μ\_E 零测，现签名可批准并补语义注释；若要求严格低维，则须另行明确所用维数并增加对应异常集条件。本次不修改 Lean 或原书。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch05.uniformMicroErgodic。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 15. MD-5.4.1-ErgodicTimeEquivalence

- source\_id：MD-5.4.1-ErgodicTimeEquivalence。

### MD-5.4.1-ErgodicTimeEquivalence

- 印刷页 / PDF页：198 / 219。
- 原文引文（逐字）：

> If we assume the system is ergodic, we must have $\operatorname{Pr}(\Sigma_E\setminus\mathcal A)=0$, thus $\operatorname{Pr}(\mathcal A)=1$. Since, according to the definition, equality of time and space averages is allowed to fail only on a set of probability measure zero, we have that either $\operatorname{Pr}(\mathcal A)=0$ or $\operatorname{Pr}(\mathcal A)=1$.

- 问题所在：已分别核对ergodicTimeAverage、ergodicTimeAverage\_common\_smooth、ergodicTimeAverage\_positive\_invariant。E n为任意有限维实欧氏空间；第一条在概率测度、每个实时间保测、零时恒等、全实时间群律及联合可测前提下，给出严格不变可测集的0/1性质与“每个L¹实观测量各自几乎处处具有空间均值时间平均”的双向等价；积分为真实0到T区间积分，极限为T→+∞。第二条另要求联合连续及紧支撑，结论确实把AE置于所有C∞实观测量之前，这些增加的条件已经[EXTRA]公开，不能把第二条当成第一条无条件交换量词。第三条显式要求可测不变集A有正概率，结论同时包含μ(A)=1、所有实时间轨道留在A、补集指标函数的实际时间平均为0；未把这些结论作假设。三条修订/扩展签名合理。本条PASS只涉及这些明确声明，不认可原书省略正概率分支的中间推理。 网站原文审校另记：code：SOURCE\_POSITIVE\_MASS\_BRANCH\_OMITTED；phase：A；field：statement\_latex；message：转录忠实，但原文直接从遍历性推出Pr(Σ\_E\A)=0，尚未排除Pr(A)=0；其后才陈述0/1分支。保留原句并转人工，不用正概率修订反写原文。
- 反例或理由：针对原书中间句：取任何概率遍历流及A=∅。A可测且不变，但Pr(Σ\_E\A)=1。此例不反驳Lean中要求0<μ A的positive\_invariant，也不反驳0/1结论。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.ergodicTimeAverage`（未证）；`MD.Ch05.ergodicTimeAverage_common_smooth`（未证）；`MD.Ch05.ergodicTimeAverage_positive_invariant`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.ergodicTimeAverage_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原句，人工确认应先分Pr(A)=0与Pr(A)>0两种情形。当前三个Lean签名无需据此修改；不得声称本次已完成它们的证明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch05.ergodicTimeAverage。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 16. MD-5.4.1-TwoOscillatorTori / MD-5.4.1-TwoOscillatorEnergyDecomposition

- source\_id：MD-5.4.1-TwoOscillatorTori；MD-5.4.1-TwoOscillatorEnergyDecomposition。

### MD-5.4.1-TwoOscillatorTori

- 印刷页 / PDF页：199 / 220。
- 原文引文（逐字）：

> For any $E_1,E_2>0$, the set of points satisfying $H_1=E_1,H_2=E_2$ is a two-dimensional torus. If the frequencies $\Omega_1$ and $\Omega_2$ are not rationally related (i.e. $\Omega_1/\Omega_2$ is an irrational number), then for any $E_1,E_2$ the torus will eventually be filled in by any trajectory. On the other hand, the energy surface $H=E$ is the union of all such 2-tori with $E_1+E_2=E$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.

- 问题所在：本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。项目依赖Chapter05/ReviewDefinitions.lean实际展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z|H z=c}；grad H=gradient H；hausdorffArea d=[vol(B₁⊂Rᵈ)/2ᵈ]·HausdorffMeasure d；surfaceMeasure=(hausdorffArea(n−1)).restrict(energySurface H c)；microRaw=surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))；microMeasure=(microRaw univ)⁻¹·microRaw；average μ g=∫g dμ；microAverage H c g=average(microMeasure H c)g。本地Hᵢ和Φ分别展开为上述分能量及无耦合旋转。签名∀Ω,c，∀i Ωᵢ≠0且cᵢ>0，然后令T={z|∀i,Hᵢ(z)=cᵢ}；其合取项分别是T与两个欧氏单位圆的积同胚、∀z∈T∀t∀i的分能量保持、Ω₁/Ω₂无理时每条全实时间轨道闭包等于T、以及∀E>0的总能量微正则非遍历性。项目flowInvariant Φ A=∀t,Φt ''A=A；setErgodic μ Φ=∀可测A,flowInvariant Φ A→μA=0∨μA=1。这些对象和量词均准确；正分能量及非零频率是非退化2-torus所需，“filled in”解释为稠密而非有限时间覆盖合理。但原文“总能量面是全部这类层的并”的分解结论不在本定理的四个合取项中；[EXTRA]指出退化圆，却没有在本lean\_decl写出包括它们的分解。原书按正分能量2-tori穷尽整面存在确定边界漏项，须明示勘误而非静默改变原文。FAIL是结论缺项；证明体sorry单独记录，标准Hausdorff测度/积分未提供定义体不是判定理由。 网站原文审校另记：
- 反例或理由：Ω=(1,1),E=1,z=(0,0,√2,0)位于总能量面，但H₂=0，不在任何两项都正的2-torus中。它反驳原书按严格正层解释的穷尽表述；当前签名则完全缺少分解子句。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.twoOscillatorTori`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.twoOscillatorTori_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：增加能量面等于所有cᵢ≥0且∑cᵢ=E的共同分能量层之并的声明，明确正层为2-tori、正总能量的端点层为圆；保留A原书引文，显式记录退化层勘误。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.twoOscillatorTori。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.4.1-TwoOscillatorEnergyDecomposition

- 印刷页 / PDF页：199 / 220。
- 原文引文（逐字）：

> On the other hand, the energy surface $H=E$ is the union of all such 2-tori with $E_1+E_2=E$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.

- 问题所在：twoOscillatorEnergyDecomposition逐点量化任意实频率Ω、任意实E和z:E 4。左侧是两个真实分能量之和等于E；右侧存在c:Fin 2→ℝ，各c\_i非负、总和等于E且逐项H\_i(z)=c\_i。各H\_i是平方项之和，故取c\_i=H\_i(z)得到这一双向分解；E<0时两侧均不能成立，E=0时也没有被排除。这是正确的、含边界退化层的静态修订。[EXTRA]与statement\_scope已明确不在本条断言各层都是二维环面、轨道稠密性或非遍历性；这些额外结论不能由当前静态等价式获得。本条签名PASS不改变原书关于“all such 2-tori”的疑误，外部TwoOscillatorTori未在本批复核。 网站原文审校另记：code：SOURCE\_DEGENERATE\_ENERGY\_FIBERS；phase：A；field：statement\_latex；message：原文such 2-tori回指前文E₁,E₂>0的共同层，不能覆盖H=E的零分能量边界层；保留字面并转人工。；code：SOURCE\_NONERGODIC\_ENERGY\_QUALIFICATION；phase：A；field：statement\_latex；message：“so the system is not ergodic”在此能量面语境需区分E>0与E=0；零能量面在非零频率时为单点，不能不加限定地说非遍历。
- 反例或理由：针对原书字面并集：Ω₁=Ω₂=1、E=1、z=(√2,0,0,0)时H₁=1、H₂=0，位于总能量面，却不在任何E₁,E₂>0的二维环面上。另E=0时能量面仅为原点，相应Dirac概率流遍历。这两点均不反驳当前含退化层的Lean静态等价式。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.twoOscillatorEnergyDecomposition`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.twoOscillatorEnergyDecomposition_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文与NEEDS\_HUMAN标记。人工修订时将全能量面写为包括E\_i=0退化层的并，并在非遍历论断中明确E>0及所用微正则测度；不要把静态分解冒充非遍历证明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch05.twoOscillatorEnergyDecomposition。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 17. MD-5.4.1-KAMPersistence

- source\_id：MD-5.4.1-KAMPersistence。

### MD-5.4.1-KAMPersistence

- 印刷页 / PDF页：200 / 221。
- 原文引文（逐字）：

> The energy surface is three-dimensional (represented as the zero-set of a single constraint in four-dimensional space), but apparently it bifurcates into a collection of isolated components (bounded by two-dimensional closed surfaces). These are none other than the tori predicted by the KAM theory [386].

- 问题所在：本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。项目E n=Rⁿ，Phase n=E n×E n。依赖hamiltonianField H(q,p)=(∇pH,−∇qH)；periodicPerturbation P为P(q+k,p)=P(q,p)（∀整数向量k）；diophantine ω κ τ为κ>0、τ>n−1及∀k≠0,κ/(1+‖k‖)^τ≤|k·ω|。附件1146–1158在n>0、全域解析H₀,P、周期扰动、I₀处频率映射导数双射、上述Diophantine条件下，量化∃δ>0∀|ε|<δ∃K；K为C¹、导数逐点单射、整数平移等变、DK·∇H₀(I₀)=X_{H₀+εP}∘K，且作用量距I₀<1。[EXTRA]的解析近可积资格和非退化性合理；这是通用KAM背景命题。但所引原文是特定双摆的三维能量面、隔离区域及图示环面的叙述；本签名没有该双摆、指定能量或其KAM适用资格的验证，[EXTRA]还明确不声称双摆参数满足资格。因此并非当前statement\_scope下完整原句的忠实形式化。导数单射本身只表示浸入；半共轭等式还须结合周期等变、Diophantine稠密性及光滑ODE唯一性来理解全局嵌入/共轭，不能用任意自交浸入充当满足全部条件的反例。本轮FAIL仅由确切来源对象与结论缺失支撑。原书components也未被静默提升为拓扑连通分支断言。证明体为sorry；标准解析性或导数定义未出现在摘录中不影响上述审计。 网站原文审校另记：
- 反例或理由：缺失对象/结论：原书双摆及其指定能量面，图示隔离区域与不变环面的对应。未提出通用KAM数学命题的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.kam`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.kam_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：把通用KAM命题明确绑定为书中KAM引用的补充背景，另保留双摆经验性叙述；若维持原句范围，则给出双摆对象与可核查资格，并承载其能量面和环面对应结论。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.kam。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 18. MD-5.4.1-AnisotropicAxisPrinted

- source\_id：MD-5.4.1-AnisotropicAxisPrinted。

### MD-5.4.1-AnisotropicAxisPrinted

- 印刷页 / PDF页：201 / 222。
- 原文引文（逐字）：

> Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $E_0$, with positions in a small interval on the positive $x$ axis, $1.05\le x\le1.15$ and $y=0$. For each point $(x,0)$ taken from this set select the initial velocities as $\dot x=0$, $\dot y=[2(E_0-U(x,0))]^{1/2}$. The set $y=0$, $\dot y=0$ is invariant under the differential equations of the perturbed central force problem, since the force acts in the radial direction; our choice of initial conditions ensures that trajectories explore the larger $H=E_0$ energy surface.

- 问题所在：依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ\_eff=κ₀(1−εc₃/2)、l\_eff=l₀(1+εc₃/2)，U=κ\_eff(r−l\_eff)²/2。声明对任意 κ₀,l₀>0、任意实 ε 以及任意全实时间 C¹ 相空间轨道 z，假定 z′=(p,−∇U(q))、y(0)=p\_y(0)=0，推出所有实 t 的 y(t)=p\_y(t)=0。该签名刻画轴不变性，没有把该结论作前提；但原文 statement\_scope 包含能量 E₀、给定短区间初值与“ensures ... explore the larger H=E₀ energy surface”，本声明不含这些初值约束和探索条款，不能把整段原句判为覆盖完整。初值构造已另有条目，不等于此声明包含了缺失结论。[EXTRA]正基准参数是合理物理资格，全时间轨道限制须区分于经典局部解；并且正基准参数不保证任意 ε 下有效参数为正。展开的势含角向依赖，故原书径向力理由一般不成立；远离原点的轴上则有反射对称性，可用于局部轴不变结论。全局签名未区分原点处总定义的 Lean gradient 与经典可微势，宜另加有效定义域资格。FAIL 的确定依据是全条覆盖缺失和原书理由的显式问题，无须因标准库定义缺失转为 NEEDS\_HUMAN。声明体为 sorry；这与签名语义分开记录。 网站原文审校另记：
- 反例或理由：缺失条款：E₀、x∈[1.05,1.15]、p\_x=0、p\_y=√(2(E₀−U(x,0))) 及探索描述。对原书“力沿径向”的反例：κ₀=l₀=1、ε=1/2，在 r=2、θ=π/6 处 ∂θU=9/8≠0，故力有切向分量；这只反驳径向力理由，不是对轴不变性的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.anisotropicAxisPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：只在整条经典轨道避开原点的光滑域内给轴不变性；原点的范数势不可微资格不能省去。；`MD.Ch05.anisotropicAxisPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“只在整条经典轨道避开原点的光滑域内给轴不变性；原点的范数势不可微资格不能省去。”。
- 导师选项：明确拆分轴不变性、能量合格初值与数值探索三部分：轴不变性用远离原点的真实最大解区间和光滑/唯一性资格；初值构造引用本批独立条目；探索全能量面的说法明确作为未经此定理推出的观察，且显式标记径向力理由疑误。若维持整段 statement\_scope，则须补齐所有数学结论或准确收窄范围。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.anisotropicAxisPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 19. MD-5.4.1-PendulumRegionPrinted

- source\_id：MD-5.4.1-PendulumRegionPrinted。

### MD-5.4.1-PendulumRegionPrinted

- 印刷页 / PDF页：200 / 221。
- 原文引文（逐字）：

> For given positive values of the coefficients, the region swept out in the plane by trajectories can be seen to be a union of intersections of pairs of disks centered at the origin and $(0,-2)$, with radii $r_1,r_2$ respectively, which themselves represent a point on an ellipse in the first quadrant. Determining the boundary of this region analytically is difficult but it is easy to find it numerically. For the special case $k_1=k_2=2$, $l_1=l_2=1$, and $E=4$ that the projected region covered by positions at this energy is the interior of the level set $U=E$ shown as a dark oval curve in the three panels of Fig. 5.4.

- 问题所在：依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件:1189–1191 的 pendulumPotential 逐项为双弹簧势 U(q)=k₁(d₁−l₁)²/2+k₂(d₂−l₂)²/2，其中 d₁=√(x²+y²)、d₂=√(x²+(y+2)²)。声明量化所有严格正 k₁,k₂,l₁,l₂,c。左集是存在动量使 |p|²/2+U(q)=c 的位置投影，按标准实欧氏语义恰为 {U≤c}；右集是存在正 r₁,r₂ 处于半径能量椭圆，且 d₁≤r₁、d₂≤r₂ 的圆盘交之并。平方项(r−l)²在 r<l 时并不单调递增，故半径上界不足以控制实际势。[EXTRA]单位质量及将可达区域解释为所有能量初值的位置投影合理，全部正参数也未把结论作前提，但它们不能消除下列反例。原书特例及 interior 的边界问题亦应区分；闭能量投影包含零动量边界。FAIL 是展开后等式为假的确定判定，无需查看 Mathlib 定义体。声明体为 sorry。 网站原文审校另记：
- 反例或理由：k₁=k₂=2、l₁=l₂=3、c=1、q=(0,0)。d₁=0、d₂=2、U=9+1=10，所以 q 不属于左集。取 r₁=r₂=3+1/√2>0，则(r₁−3)²+(r₂−3)²=1，且 d₁≤r₁、d₂≤r₂，故 q 属于右集。所有声明前提满足。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.pendulumRegionPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：能量面的位置投影修正为势能次水平集，删除不成立的一般圆盘并参数化。；`MD.Ch05.pendulumRegionPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“能量面的位置投影修正为势能次水平集，删除不成立的一般圆盘并参数化。”。
- 导师选项：数学陈述改为能量投影={q | U(q)≤c}；若需半径参数化，则以 r\_i=d\_i 和半径能量≤c 表述，不能以 r\_i≥d\_i 的圆盘交替代。原书一般圆盘并说法显式标疑误，特例 E=4 的闭次水平集、边界与数值图像观察分别陈述。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.pendulumRegionPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 20. MD-5.4.1-InitialSegmentPrinted

- source\_id：MD-5.4.1-InitialSegmentPrinted。

### MD-5.4.1-InitialSegmentPrinted

- 印刷页 / PDF页：201 / 222。
- 原文引文（逐字）：

> The set of initial conditions forms a line segment in the four-dimensional phase space.

- 问题所在：依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ\_eff=κ₀(1−εc₃/2)、l\_eff=l₀(1+εc₃/2)，U=κ\_eff(r−l\_eff)²/2。目标附件:1205–1206 的实际初值是 γ(x)=((x,0),(0,√(2(c−U(x,0)))))；1218–1220 量化任意实 κ₀,l₀,ε,c，假定闭区间 I=[21/20,23/20] 上 c−U≥0，结论存在 a,b∈Phase 2 使 γ(I)=segment ℝ a b。标准 Mathlib segment ℝ a b 是 {(1−s)a+s b | 0≤s≤1} 的仿射闭线段，不能理解成任意拓扑弧或参数曲线。[EXTRA]保留真实相空间对象、区间与非负根号资格正确且无循环，但不能使平方根动量关于 x 为仿射函数。该签名忠实复现原书 line segment 的字面措辞，同时把原书疑误写成了假的数学定理，应 FAIL；问题与 Mathlib 定义体是否提供无关。没有显式 [ERRATUM?] 标签可据此默认接受错误，疑误及修复必须明示。声明体为 sorry，独立记录。 网站原文审校另记：
- 反例或理由：取 κ₀=l₀=c=1、ε=0。对所有 x∈[21/20,23/20]，U(x,0)=(x−1)²/2<1，所以满足全部前提；p\_y(x)=√(2−(x−1)²)，在此区间的二阶导数为−2/(2−(x−1)²)^(3/2)<0。两端初值的中点位置是 x=11/10，其动量严格小于 p\_y(11/10)，故该中点不在 γ(I)。γ(I) 不凸，而每个 segment 都凸，因此不可能等于任何 segment。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.initialSegmentPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。；`MD.Ch05.initialSegmentPrinted_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。”。
- 导师选项：保留并标记原书四维 line segment 疑误：位置投影是直线段，相空间初值集应写为 γ(I) 的参数曲线。有严格正根号时可陈述光滑、正则（x 坐标导数为1）；仅非负根号时先保持连续参数曲线结论。若坚持仿射线段，则需另有使动量依赖仿射的特殊条件，原有资格不足。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.initialSegmentPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 21. MD-5.5-Correlation

- source\_id：MD-5.5-Correlation。

### MD-5.5-Correlation

- 印刷页 / PDF页：203–204 / 224–225。
- 原文引文（逐字）：

> Let $a$ and $b$ be mappings from the phase space to the same Euclidean space, and define the temporal correlation of $a$ and $b$ (on the surface of energy $E$) by

$$
C_{ab}(\tau)\stackrel{\rm def}{=}k\operatorname{Av}_{H=E}(a(\mathcal F_t(z))\cdot b(z)) =kZ_E^{-1}\int_{\Sigma_E}a(\mathcal F_t(z))\cdot b(z)\delta[H-E]d\omega;
$$


> where $k$ is a normalization constant that is often incorporated to ensure that $C_{ab}(0)=1$.

- 问题所在：correlation对任意状态维n、共同输出维d，接受μ、Φ及a,b:E n→E d和实k,t，返回k乘以真实实欧氏内积的μ积分；只在a上施加Φ\_t，b取初始状态，次序与源文相符。这里定义的是通用测度下的相关核，取μ为已归一化微正则概率测度时才对应原Av_(H=E)；不能据此声称对任意μ都等于原δ积分，也未在此定义或证明微正则测度构造。积分定义可以总延拓至任意观测量；作通常统计相关解释时仍须有相关乘积的可积性。k任意是正确的，“often”并未要求无条件C(0)=1；零lag积分非零时才能取其倒数归一化。Lean统一用一个lag参数t，是对源文τ/t混用的已公开合理修订。 网站原文审校另记：code：SOURCE\_LAG\_VARIABLE\_MISMATCH；phase：A；field：statement\_latex；message：原页左侧C\_ab(τ)，右侧两次使用F\_t，原JSON忠实保留。将t视为τ的勘误需人工确认，不在原文内悄改。；code：SOURCE\_LITERAL\_PUNCTUATION；phase：A；field：statement\_latex；message：原展示式以分号结束，随后跨页接where k；原JSON写逗号，作纯转录修正。；code：MICROCANONICAL\_SPECIALIZATION\_MUST\_BE\_EXPLICIT；phase：C；field：context\_notation/extra\_assumptions；message：当前Lean只定义任意μ下的积分核；微正则δ积分是μ选取后的解释，不是这条定义已证明的额外等式。
- 反例或理由：code：SOURCE\_LAG\_VARIABLE\_MISMATCH；phase：A；field：statement\_latex；message：原页左侧C\_ab(τ)，右侧两次使用F\_t，原JSON忠实保留。将t视为τ的勘误需人工确认，不在原文内悄改。；code：SOURCE\_LITERAL\_PUNCTUATION；phase：A；field：statement\_latex；message：原展示式以分号结束，随后跨页接where k；原JSON写逗号，作纯转录修正。；code：MICROCANONICAL\_SPECIALIZATION\_MUST\_BE\_EXPLICIT；phase：C；field：context\_notation/extra\_assumptions；message：当前Lean只定义任意μ下的积分核；微正则δ积分是μ选取后的解释，不是这条定义已证明的额外等式。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.correlation`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.correlation_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原书τ/t并标NEEDS\_HUMAN，人工决定统一的lag记号；采用corrected\_json中的微正则特化说明。现有通用相关定义无需修改。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch05.correlation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 22. MD-5.5-CorrelationTimePrinted / MD-5.5-CorrelationTimeAE

- source\_id：MD-5.5-CorrelationTimePrinted；MD-5.5-CorrelationTimeAE。

### MD-5.5-CorrelationTimePrinted

- 印刷页 / PDF页：204 / 225。
- 原文引文（逐字）：

> If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $H=E$ energy surface:

$$
C_{a,b}(t)=k\lim_{\tau\to\infty}\frac1\tau\int_0^{\tau} a(z(s+t))\cdot b(z(s))ds.
$$



- 问题所在：本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 energySurface H c := {z | H z=c}；grad H := gradient H；hausdorffArea m := ofReal(volume(单位ℝ^m球).toReal/2^m) • hausdorffMeasure m；surfaceMeasure H c := (hausdorffArea (n-1)).restrict(energySurface H c)；microRaw H c := (surfaceMeasure H c).withDensity(fun z => ofReal(‖grad H z‖⁻¹))；microMeasure H c := ((microRaw H c) univ)⁻¹ • microRaw H c；microAverage H c g := average(microMeasure H c)g。timeAverage z g T := T⁻¹*(∫s in 0..T,g(z s))；hasTimeAverage z g a := Tendsto(timeAverage z g) atTop (𝓝 a)；microErgodic H c Φ := ∀g, Integrable g (microMeasure H c) → ∀ᵐz∂microMeasure H c, hasTimeAverage(fun s=>Φs z)g(microAverage H c g)。签名依次全称量化n,d,H,c,Φ,a,b,k,t，假设Φ0=id、flow加法群律、microErgodic及给定lag观测的可积性，结论为所有z∈{H=c}的相关时间积分极限。原文any trajectory确实对应这个全点结论；但本项目microErgodic只提供对每个可积观测的AE性质，不能推出全能量面点性质。[EXTRA]给定lag可积和群律合理，却不足以支持原any；没有正有限微正则质量、正则能量资格或全点平均假设。原文any在通常测度遍历含义下应公开作AE勘误，不能由名字ergodic获得全点结论。下面给出当前签名的直接反例，不因未给Mathlib定义而待裁定。主声明有sorry，但签名失败独立于证明完成度。 网站原文审校另记：
- 反例或理由：取n=d=1，以ℝ¹坐标x写H(x)=x²，c=0；Φ(s,x)=x；a(x)=b(x)=单位向量1；k=1，t=0。Σ={0}，grad H(0)=0，实数‖grad H(0)‖⁻¹=0，故withDensity在Σ上的权重为0，microRaw=0。注意microMeasure的质量逆元是ENNReal逆元：0⁻¹=∞，但∞ • 零测度仍是零测度，故μ=0。microErgodic的AE命题在μ=0下自动成立，lag观测也可积，恒等flow满足两条群律。z=0∈Σ，时间被积函数恒为1，对所有T>0，T⁻¹∫₀ᵀ1 ds=1；右端correlation μ...=0。极限1不等于0。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.correlationTimePrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。；`MD.Ch05.correlationTimePrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。”。
- 导师选项：对标准遍历版改为∀ᵐz∂microMeasure，并公开标示原any→AE的勘误；如需物理微正则概率资格，补正有限microRaw质量或regularEnergy。regularEnergy的项目定义是能量面非空紧、面上grad非零、原始质量正有限；它能排除上述退化反例，但不单独把AE提升成所有初值。若坚持原any，须另给比通常遍历性更强的全点时间平均假设，不能把待证等式作为无说明的额外假设。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.correlationTimePrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.5-CorrelationTimeAE

- 印刷页 / PDF页：204 / 225。
- 原文引文（逐字）：

> If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $H=E$ energy surface:

$$
C_{a,b}(t)=k\lim_{\tau\to\infty}\frac1\tau\int_0^{\tau} a(z(s+t))\cdot b(z(s))ds.
$$



- 问题所在：correlationTime已逐项核对全部n,d,μ,Φ,a,b,k,t量词、零时恒等及群律。遍历资格在此作为“每个L¹实观测量有各自AE时间平均”的标准性质传入，并要求给定lag的相关观测量可积；在条目1的概率保测可测流条件下，这个资格可由setErgodic取得，未把特定相关等式直接作为假设。结论对给定t几乎处处z，保留k、T⁻¹、真实0到T积分以及a(Φ_(s+t)z)与b(Φ\_s z)的实内积。群律和实数加法交换保证该 integrand 是固定观测量g\_t沿Φ\_s的值，极限目标是同一μ、Φ、a、b、k、t的correlation。没有交换∀t与AE z；也没有从一般遍历性推出每个初值。因此AE修订版完整签名PASS，原书any trajectory仍独立标为待人工。 网站原文审校另记：code：SOURCE\_ANY\_TRAJECTORY\_OVERSTATEMENT；phase：A；field：statement\_latex；message：原页确写any trajectory；一般概率遍历结论允许零测异常初值，不能推出每条轨道。原文保留，当前AE修订合理，但不能把AE称为逐字原文。
- 反例或理由：反驳从一般测度遍历性推出逐点结论的简单模型：E 1上取μ=δ₀、Φ\_t=id、a(x)=x、b(x)=1、k=1。此概率流满足setErgodic，所有L¹观测量在μ几乎处处有正确时间平均；但初值z=1的相关时间平均为1，μ相关值为0。该例说明量词不能从AE改为所有环境空间初值，并非声称它是书中某个特定正则微正则能量面的物理反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.correlationTime`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.correlationTime_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文any并交人工确认其适用范围；将当前correlationTime明确保留为AE修订版，不改成∀z，也不把逐lag的AE集合当作对所有实lag共同适用。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch05.correlationTime。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 23. MD-5.5-MixingCorrelation / MD-5.5-MixingCorrelationPrinted

- source\_id：MD-5.5-MixingCorrelation；MD-5.5-MixingCorrelationPrinted。

### MD-5.5-MixingCorrelation

- 印刷页 / PDF页：205 / 226。
- 原文引文（逐字）：

> $\lim_{t\to\infty}C_{ab}(t)=\operatorname{Av}_{H=E}(a)\cdot\operatorname{Av}_{H=E}(b)$.

- 问题所在：C：主声明量化n,d、任意实k、概率μ、各时保持测度的Φ和有界连续向量a,b；密度测试混合前提作用于所有标量r,φ。有限维逐分量推出带k的内积均值极限，数学正确；scalar声明是相应d=1公式，k*Av(a)*Av(b)括号无误。未要求Φ群律不妨碍此蕴含。全部[EXTRA]与修正版相符，sorry不影响签名审核。但名为mixingCorrelation的结论是带k的修正版，不能同时认证为原书无k字面版本；需人工确认原文/勘误分流。 本条全部本地声明：MD.Ch05.mixingCorrelation, MD.Ch05.mixingCorrelation\_scalar。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。 网站原文审校另记：A：附件第2页原式右侧为Av(a) · Av(b)，JSON漏掉中间点乘号；向量语境下不能仅写并置乘积。原页确实没有k，须保留该原书疑误。附件不含所称PDF224–225，不能独立核实那两页对k的定义；此处仅按任务摘录的context核对其一致性。；C：主声明量化n,d、任意实k、概率μ、各时保持测度的Φ和有界连续向量a,b；密度测试混合前提作用于所有标量r,φ。有限维逐分量推出带k的内积均值极限，数学正确；scalar声明是相应d=1公式，k*Av(a)*Av(b)括号无误。未要求Φ群律不妨碍此蕴含。全部[EXTRA]与修正版相符，sorry不影响签名审核。但名为mixingCorrelation的结论是带k的修正版，不能同时认证为原书无k字面版本；需人工确认原文/勘误分流。
- 反例或理由：按所给C\_ab=k Av(a∘Φ\_t·b)定义，取μ=δ₀、Φ\_t=id、a=b=1、k=2；所有混合/概率/连续有界前提成立，左极限2而原印右侧1。向量版取d=1即可。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.mixingCorrelation`（未证）；`MD.Ch05.mixingCorrelation_scalar`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.mixingCorrelation_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文statement只补回点乘，不添加k；另在勘误字段记录k·⟨Av(a),Av(b)⟩。将现主声明标明\_corrected，并独立标记无k原式待人工裁定。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch05.mixingCorrelation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.5-MixingCorrelationPrinted

- 印刷页 / PDF页：205 / 226。
- 原文引文（逐字）：

> More generally, in a mixing system, if $a$ and $b$ are two arbitrary functions of the phase variables, then

$$
\lim_{t\to\infty}C_{ab}(t)=\operatorname{Av}_{H=E}(a)\operatorname{Av}_{H=E}(b).
$$



- 问题所在：按本轮规则，Mathlib标准定义直接按Lean 4.34.0 / Mathlib v4.34.0的标准数学含义采信：EuclideanSpace ℝ (Fin n)是欧氏ℝⁿ；integral为Bochner积分且不可积时取0；IsProbabilityMeasure μ表示μ全空间质量1；MeasurePreserving表示可测且推前测度等于μ；Integrable表示相对于指定μ可积；Continuous及IsBounded(range f)分别为连续和全局有界；Tendsto ... atTop (𝓝 L)为实时间趋向+∞时趋向L。不要求Ch05\_deps.txt提供这些Mathlib定义体。 已展开本项目定义：Ch05\_deps.txt的-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean中，E n:=EuclideanSpace ℝ (Fin n)，average μ g:=∫g dμ，correlation μ Φ a b k t:=k∫inner ℝ (a(Φ t z)) (b z)dμ，其中a,b:E n→E d且d任意。Ch05.lean中本地MD.Ch05.weakMixing的定义为：∀ r φ:E n→ℝ，Integrable r μ→(∀z,0≤r z)→∫r dμ=1→Continuous φ→IsBounded(range φ)→∫φ(Φ t z)r z dμ趋向average μ φ。它是原书PDF220（印刷199）所述概率初值弱收敛的测试函数版本，不因名称weakMixing而解释成通常Cesàro弱混合。它没有引用deps中那个使用Lebesgue可积density r的旧mixing定义。μ任意量化是对微正则参考概率测度的抽象推广；不额外断言任意μ就是微正则测度。 所有项目自定义符号均有定义可核对，无缺失定义导致的NEEDS\_HUMAN。 Ch05.lean:1335起量化任意实数k，结论左端为k∫a(Φ\_t z)b(z)dμ而右端为average μ a·average μ b，确实照录PDF226（印刷205）的漏k公式。PDF224–225（印刷203–204）的C\_ab定义含k；故原印归一化疑误成立，字面签名即使在全部函数可积的情形仍为假。[EXTRA]概率测度及有界连续函数是合理的统计/测试资格，不能弥补漏k。此条没有独立保测前提；下列反例甚至满足保测，所以添加保测也不能修复。另有对象范围遗漏：原C\_ab及项目correlation允许任意同一Euclidean空间值a,b，而本声明仅量化实值a,b。这与Mathlib定义是否提供无关。签名失败不由sorry推断；声明正文有sorry，须另外记为证明未完成。 网站原文审校另记：
- 反例或理由：n=1，μ=δ₀，Φ\_t=id，a=b≡2，k=1/4。对于每个可积非负r，∫r dδ₀=1即r(0)=1，因此任意有界连续φ都有∫φ(Φ\_t z)r(z)dδ₀=φ(0)=average μ φ，weakMixing成立。全部列出的前提成立，且Φ保测、C\_ab(0)=1。左端相关函数恒为(1/4)·4=1，右端为2·2=4；恒为1的函数不趋向4。该反例同时满足前文常用的归一化选择。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.mixingCorrelationPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：独立修正版恢复任意向量维数及k因子，给有界连续向量观测量的内积均值极限；无k实值原式独立保留。；`MD.Ch05.mixingCorrelationPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“独立修正版恢复任意向量维数及k因子，给有界连续向量观测量的内积均值极限；无k实值原式独立保留。”。
- 导师选项：保留原印式作为有明确[ERRATUM?]说明的原文记录，不把其当作已证数学事实；修正版右端补回k。若保留无k右端，只能额外限定k=1并明确其特例范围。为完整覆盖原文还须量化d，把a,b类型改为E n→E d，左端用k∫inner ℝ (a(Φ\_t z)) (b z)dμ，右端用k·inner ℝ (∫a dμ) (∫b dμ)；向量平均直接用Bochner积分（现有average只接受实值函数）。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.mixingCorrelationPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 24. MD-5.6-ForwardComponentsPrinted / MD-5.6-ForwardNormDivergence

- source\_id：MD-5.6-ForwardComponentsPrinted；MD-5.6-ForwardNormDivergence。

### MD-5.6-ForwardComponentsPrinted

- 印刷页 / PDF页：207 / 228。
- 原文引文（逐字）：

> we see that the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $(q_0,p_0)=(0,0)$.

- 问题所在：本轮以BATCH24附件签名及哈希绑定的Blueprint/Ch05.lean为准；Mathlib标准定义按补充规则直接采信，无须在Ch05\_deps.txt中展开。ReviewDefinitions.lean:5315、5401展开后，对象为实际欧氏平面的A\_h=[[1,h],[−h,1]]迭代。量词为所有非零实h、所有非零初值z；两个Tendsto atTop atTop按标准意义分别要求每个坐标绝对值最终超过任意实阈值。[EXTRA]h≠0、z≠0对增长是合理必要资格，绝对值解释也明确，但两坐标各自趋于+∞仍有反例，故原书疑误能够确定，不需NEEDS\_HUMAN。PDF228／印刷207的谱外扩子句亦未单独表达；特征值模大于1可导致范数发散，不保证每个坐标绝对值发散。不存在字面[ERRATUM?]标签，但应明确保留原句并报告此疑误。附件中本声明证明体直接含sorry；反例与遗漏子句是FAIL依据，sorry另记，不能混淆。 网站原文审校另记：
- 反例或理由：h=1，z=(1,0)。A²=[[0,2],[−2,0]]，A⁴=−4I。对所有m≥0，A^(4m)z=((-4)^m,0)，A^(4m+2)z=(0,−2(-4)^m)。故p的绝对值在4m子列为0，q的绝对值在4m+2子列为0，两个Tendsto结论均失败。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.forwardComponentsPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：两分量各自发散修正为非零初值的范数发散；原分量断言的旋转反例保留。；`MD.Ch05.forwardComponentsPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“两分量各自发散修正为非零初值的范数发散；原分量断言的旋转反例保留。”。
- 导师选项：原书字面版标记为有反例的疑误，不补成可证定理；独立修订为非零步长、非零初值的范数发散。若覆盖完整原句，另给复特征值1±ih及模sqrt(1+h²)>1的谱结论；不要把原句两分量发散静默替换。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.forwardComponentsPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.6-ForwardNormDivergence

- 印刷页 / PDF页：207 / 228。
- 原文引文（逐字）：

> and we see that the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $(q_0,p_0)=(0,0)$.

- 问题所在：C复审规则：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、内积、梯度、导数、Hausdorff测度、volume、Bochner integral、withDensity、restrict、ContDiff、HasCompactSupport、Tendsto 等均直接按其标准数学含义采信；未在依赖摘录中寻找Mathlib定义体，也不以缺少这些定义体为理由判NEEDS\_HUMAN。实际读取的三个文件已重新计算SHA256，并与上一轮附件哈希逐一相等；不使用其他旧版Ch0x.lean或source.json。项目自定义项已按依赖的ReviewDefinitions文件和当前附件MD.Ch05本地定义展开核对。 依赖展开依据：Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean，E n=EuclideanSpace ℝ (Fin n)，采用欧氏范数；不是坐标上确界范数。 Lean只给非零步长、非零初值下欧氏范数趋于+∞，既没有特征值位于单位圆外的结论，也没有原文“两分量趋于无穷”的结论。[EXTRA]h≠0必要，非原点对应原文例外；修正为范数发散在数学上正确，但不能作为原句全部结论的忠实形式化。没有显式ERRATUM标签，必须明确登记原书疑误。此定理正文未见sorry，但证明存在不消除语义偏差。 复审仍判FAIL的原因是与原书结论的绑定差异，而非Mathlib范数或Tendsto含义不明。[EXTRA]已明确承认是独立修正，修正合理不等于原句语义相同。 网站原文审校另记：
- 反例或理由：h=1，z₀=(1,0)。z\_k=(√2)^k(cos(kπ/4),−sin(kπ/4))；p_{4m}=0，q_{4m+2}=0，因此连两个分量的绝对值分别趋于∞都不成立，范数却确实趋于∞。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.forwardNormDivergence`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.forwardNormDivergence_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原书逐字引文，添加明确[ERRATUM?]及反例；将本Lean定理标为独立修正版，并另保留矩阵特征值模为√(1+h²)>1的结论。不要把范数命题标成原“两分量”句的PASS。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch05.forwardNormDivergence。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 25. MD-5.6-BackwardEulerLimit / MD-5.6-EulerInvariant

- source\_id：MD-5.6-BackwardEulerLimit；MD-5.6-EulerInvariant。

### MD-5.6-BackwardEulerLimit

- 印刷页 / PDF页：207 / 228。
- 原文引文（逐字）：

> all solutions of the recurrence relation tend to the origin with increasing $n$ (the origin is an attractive equilibrium point). In this case, all densities evolve toward the Dirac distribution centered at the origin: $\delta[q]\delta[p]$. The only (distributional) solution of $\mathcal L_{\widetilde f}\rho=0$ is again $\delta[q]\delta[p]$, which in this case is attractive.

- 问题所在：C：声明对每个h≠0同时给所有二维初值的离散轨道趋0，以及对任意初始概率μ、任意有界连续φ的积分随自然k趋φ(0)，即概率推前弱趋δ₀；无矩条件需求，量词和结论完整，[EXTRA]准确。没有给连续密度生成元稳态唯一性/连续吸引性，scope将其交外部两个source\_id，本任务无其签名不可审。所给离散签名正确，但原页L无dagger和未限定分布类别是必须人工裁定的原书疑误。 本条全部本地声明：MD.Ch05.backwardEulerLimit。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。 网站原文审校另记：A：附件第13页此处确实印L\_f̃ ρ=0，没有dagger；JSON忠实，不应在原文字段擅补。其余all solutions、all densities、Dirac及attractive原句相符。；C：声明对每个h≠0同时给所有二维初值的离散轨道趋0，以及对任意初始概率μ、任意有界连续φ的积分随自然k趋φ(0)，即概率推前弱趋δ₀；无矩条件需求，量词和结论完整，[EXTRA]准确。没有给连续密度生成元稳态唯一性/连续吸引性，scope将其交外部两个source\_id，本任务无其签名不可审。所给离散签名正确，但原页L无dagger和未限定分布类别是必须人工裁定的原书疑误。
- 反例或理由：将L理解为作用于观测量的Lie算子时不能无说明把其核称为密度稳态；即便修为密度伴随算子，所有分布中零分布及δ₀的常数倍也破坏唯一性。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.backwardEulerLimit`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.backwardEulerLimit_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文保留无dagger；另列勘误为密度侧L†，限定稳态为概率测度，并提供所引连续模型/稳态声明。不能把离散收缩定理当连续分布方程的完整审核。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch05.backwardEulerLimit。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.6-EulerInvariant

- 印刷页 / PDF页：207 / 228。
- 原文引文（逐字）：

> This means that with the single exception $\rho(q,p;0)=\delta[q]\delta[p]$ there is no limiting (invariant) distribution for Forward Euler. To put it another way, the only solution, in the weak sense, of $\mathcal L_{\widetilde f}^{\dagger}\rho=0$ is the point distribution $\delta[q]\delta[p]$, and this solution is not “asymptotically stable.”

- 问题所在：C：eulerInvariant量化非零h及所有概率μ，以真实forwardEuler保持μ为前提，结论μ=δ₀正确；no\_probability\_limit对每个非Dirac概率μ排除任何概率ν的全部有界连续测试函数弱极限，强度和量词正确，部分质量留在0也仍不紧。已给[EXTRA]诚实限定为离散概率测度，并将连续模型/弱稳态分配外部source\_id；这些外部声明未在本任务摘录，不能认证其覆盖。原书声称唯一弱解若指所有分布而非概率测度，必须人工限定类别；亦不能把离散不变性直接当连续生成元核。故两条已给Lean声明本身通过，但整条原书弱稳态/稳定性尚不能PASS。 本条全部本地声明：MD.Ch05.eulerInvariant, MD.Ch05.eulerInvariant\_no\_probability\_limit。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。 网站原文审校另记：A：附件第10页原句、dagger、Dirac及not asymptotically stable相符，保留原句。；C：eulerInvariant量化非零h及所有概率μ，以真实forwardEuler保持μ为前提，结论μ=δ₀正确；no\_probability\_limit对每个非Dirac概率μ排除任何概率ν的全部有界连续测试函数弱极限，强度和量词正确，部分质量留在0也仍不紧。已给[EXTRA]诚实限定为离散概率测度，并将连续模型/弱稳态分配外部source\_id；这些外部声明未在本任务摘录，不能认证其覆盖。原书声称唯一弱解若指所有分布而非概率测度，必须人工限定类别；亦不能把离散不变性直接当连续生成元核。故两条已给Lean声明本身通过，但整条原书弱稳态/稳定性尚不能PASS。
- 反例或理由：若“distribution”按任意Schwartz分布理解，零分布已经解齐次稳态方程且不是δ₀；任意常数倍δ₀亦为解。唯一性至少须限制质量1非负概率类。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.eulerInvariant`（已证）；`MD.Ch05.eulerInvariant_no_probability_limit`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.eulerInvariant_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文，将解释明确限定概率测度；提供EulerLogCorrespondence和ForwardWeakStationary实际声明后再审连续模型、弱解及非吸引性，不能凭source\_id名称认证。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch05.eulerInvariant。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 26. MD-5.6-SymplecticEulerEllipse / MD-5.6-SymplecticEulerShadow

- source\_id：MD-5.6-SymplecticEulerEllipse；MD-5.6-SymplecticEulerShadow。

### MD-5.6-SymplecticEulerEllipse

- 印刷页 / PDF页：207 / 228。
- 原文引文（逐字）：

> the solution through any given initial point remains confined to an ellipse for all $n$ defined by $\widetilde H_h(q,p)=\widetilde H_h(q_0,p_0)$.

- 问题所在：C：修正版主定理对所有|h|<2给非零点Q\_h>0、每个实c的次水平集紧性、每个z及全部自然k的能量保持；包含负c时空集和k=0。geometry另断言零能级={0}，每个c>0的能级与单位圆同胚，数学正确。二次型矩阵[[1,−h/2],[-h/2,1]]特征值1±h/2均正，结合显式二次型可认定几何椭圆；单独同胚本身只表达拓扑圆，不能作为一般集合是几何椭圆的充分定义。条目14还提供与主对数Hamiltonian的正比例联系，故修正版范围内能级与modified模型一致。[EXTRA]明确，sorry不构成签名FAIL。原文无稳定区及零初值例外须人工裁定。 本条全部本地声明：MD.Ch05.symplecticEulerEllipse, MD.Ch05.symplecticEulerEllipse\_geometry。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。 网站原文审校另记：A：附件第15页原句及H̃_h(q,p)=H̃_h(q₀,p₀)相符；原书无限定any given initial point，不应悄改原文。；C：修正版主定理对所有|h|<2给非零点Q\_h>0、每个实c的次水平集紧性、每个z及全部自然k的能量保持；包含负c时空集和k=0。geometry另断言零能级={0}，每个c>0的能级与单位圆同胚，数学正确。二次型矩阵[[1,−h/2],[-h/2,1]]特征值1±h/2均正，结合显式二次型可认定几何椭圆；单独同胚本身只表达拓扑圆，不能作为一般集合是几何椭圆的充分定义。条目14还提供与主对数Hamiltonian的正比例联系，故修正版范围内能级与modified模型一致。[EXTRA]明确，sorry不构成签名FAIL。原文无稳定区及零初值例外须人工裁定。
- 反例或理由：h=2时Q=(q−p)²/2，正能级是两条平行直线而非椭圆，零能级是一整条直线；|h|<2但z₀=0则能级仅{0}。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.symplecticEulerEllipse`（已证）；`MD.Ch05.symplecticEulerEllipse_geometry`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.symplecticEulerEllipse_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文保持不变，另列|h|<2且初值非零的椭圆勘误，附零能级退化为单点；本批已给Lean修正版无须因sorry修改。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch05.symplecticEulerEllipse。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-5.6-SymplecticEulerShadow

- 印刷页 / PDF页：207 / 228。
- 原文引文（逐字）：

> the solution through any given initial point remains confined to an ellipse for all $n$ defined by $\widetilde H_h(q,p)=\widetilde H_h(q_0,p_0)$, where $\widetilde H_h$ is the perturbed Hamiltonian defined by the backward error analysis.

- 问题所在：C：symplecticEulerShadow\_statement是所有实h、所有z的一步Q\_h保持，Q\_h=(q²+p²−hqp)/2；对摘录辛Euler步[[1−h²,h],[-h,1]]此恒等式正确。新增c(h)在h=0特判1，|h|<2内为正；A=c(h)[[-h/2,1],[-1,h/2]]正是cQ\_h的Hamilton向量场。设s=sqrt(1−h²/4)，该未缩放矩阵平方=−s²I，角θ=2arcsin(h/2)满足sinθ=hs、cosθ=1−h²/2，故exp(hA)精确给数值步。flow定义含初值、群律和每时刻ODE，主模型全部合取正确，h=0亦成立。c(h)=1+h²/6+O(h⁴)，有界球上差界C h²合理，量词C,δ可依赖R。[EXTRA]准确；但原书无条件椭圆说法不成立，需保留疑误人工处理，新增正确模型不消除此原文问题。 本条全部本地声明：MD.Ch05.symplecticEulerShadow, MD.Ch05.symplecticEulerLogScale, MD.Ch05.symplecticEulerModifiedHamiltonian, MD.Ch05.symplecticEulerModifiedFlow, MD.Ch05.symplecticEulerShadow\_modified\_model, MD.Ch05.symplecticEulerShadow\_modified\_scale\_order。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。 网站原文审校另记：A：附件第14页the solution...ellipse...backward error analysis整句及H̃_h等能式相符，原页未在此处写|h|<2或排除原点。；C：symplecticEulerShadow\_statement是所有实h、所有z的一步Q\_h保持，Q\_h=(q²+p²−hqp)/2；对摘录辛Euler步[[1−h²,h],[-h,1]]此恒等式正确。新增c(h)在h=0特判1，|h|<2内为正；A=c(h)[[-h/2,1],[-1,h/2]]正是cQ\_h的Hamilton向量场。设s=sqrt(1−h²/4)，该未缩放矩阵平方=−s²I，角θ=2arcsin(h/2)满足sinθ=hs、cosθ=1−h²/2，故exp(hA)精确给数值步。flow定义含初值、群律和每时刻ODE，主模型全部合取正确，h=0亦成立。c(h)=1+h²/6+O(h⁴)，有界球上差界C h²合理，量词C,δ可依赖R。[EXTRA]准确；但原书无条件椭圆说法不成立，需保留疑误人工处理，新增正确模型不消除此原文问题。
- 反例或理由：h=3时辛Euler矩阵[[-8,3],[-3,1]]迹−7、行列式1，有模大于1的实特征值，部分轨道无界，不能全困于椭圆；z₀=0时任意稳定步长下能级为单点。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch05.symplecticEulerShadow`（已证）；`MD.Ch05.symplecticEulerLogScale`（定义）；`MD.Ch05.symplecticEulerModifiedHamiltonian`（定义）；`MD.Ch05.symplecticEulerModifiedFlow`（定义）；`MD.Ch05.symplecticEulerShadow_modified_model`（未证）；`MD.Ch05.symplecticEulerShadow_modified_scale_order`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch05.symplecticEulerShadow_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文；勘误版本明确|h|<2、z₀≠0给椭圆，原点给退化点。将新增模型与一步保持声明明确标记为修正版，全部迭代/几何使用条目15。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch05.symplecticEulerShadow。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

