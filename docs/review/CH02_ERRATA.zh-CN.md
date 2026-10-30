# 第2章原书疑误与双版本审阅单

教材：B. Leimkuhler 与 C. Matthews，Molecular Dynamics: With Deterministic and Stochastic Numerical Methods，Springer，2015。
页码采用原PDF从1起算的物理页。以下为工作勘误及资格补充，尚未经导师或作者裁定。定义、原有正确的数学子句和原书字面疑误分别保留；编译通过不表示未证命题已经成立。
原文引文沿用已逐页核对的来源记录；本轮网站返回保留其原有版本及判定。原有声明可能已经是限定解释或修正版，须按网站正文确定PASS的对象；本轮新增或修改版本均未再次送网站。
共25项问题，涉及31个source\_id。同一问题的多条来源已合并；各来源原文、版本和网站判定仍分别列出。

## 1. MD-2.2.1-Admissible

- source\_id：MD-2.2.1-Admissible。

### MD-2.2.1-Admissible

- 印刷页 / PDF页：60 / 82。
- 原文引文（逐字）：

> We consider the collection of all twice continuously differentiable curves in the configuration space which start from a certain point $`\boldsymbol Q`$ and end at another given point $`\boldsymbol Q'`$. We may think of any such curve as being represented by a parameterization $`\boldsymbol q(t)`$, $`t\in[\alpha,\beta]`$ with $`\boldsymbol q(\alpha)=\boldsymbol Q`$ and $`\boldsymbol q(\beta)=\boldsymbol Q'`$, where the components of $`\boldsymbol q(t)`$ are $`C^\infty`$ functions. Denote by $`G=G(\boldsymbol Q,\boldsymbol Q',\alpha,\beta)`$ the class of smooth parameterized curves such that $`\boldsymbol q(\alpha)=\boldsymbol Q`$, $`\boldsymbol q(\beta)=\boldsymbol Q'`$.

- 问题所在：已展开 Ch02.lean:106：admissibleSmooth a b x y q 为 ContDiff ℝ ∞ q ∧ q a=x ∧ q b=y，两端点完整。正式 Q 已找到，缺失定义不再是障碍。仍需裁定原文 PDF82 同段的“all twice continuously differentiable”与后续“C∞ functions / smooth”的冲突：本定义选择后一资格，不能同时代表首句全部 C² 曲线。[EXTRA] 对全实线代表函数要求 C∞，并非区间计算所必要；若以区间限制识别曲线、选择光滑延拓为表示约定，可以合理使用，但对任意给定全局 q 与局部光滑资格并不等价，现签名也未编码曲线商或存在延拓。a<b 是时间窗语境，谓词自身未保证它。NEEDS\_HUMAN 的唯一原因是原文曲线类的正则性及域含义需数学/编辑裁定，非依赖缺失。此项是定义，无 sorry。 依赖展开证据：Ch02\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean（段标 SHA256 3778ef36df51f5218bf14a00fa3a37b0f8ac7dcfa01a4a9f7450d82db5c490b7），第2816行 Q n := Fin n → ℝ；第2831–2832行 action L a b q := ∫ t in a..b, L (q t) (deriv q t)；第2833行 variation q η ε t := q t + ε • η t。Q 是有限维实坐标空间，向量加法和实标量乘法逐坐标作用；n 为坐标数而非强制粒子数。action/variation 与本地 bp\_action/bp\_variation 的函数体逐字同式，展开后对应相同对象。这里的 stationarySmoothAction 是 Ch02.lean 的本地 C∞ 变分谓词，不能混用依赖第2834行只要求 C² 变分的 stationaryAction。实际读取的蓝图附件路径为 /workspace/Ch02.lean，输出 input\_sha256 按请求使用逻辑名称 Blueprint/Ch02.lean，并未声称磁盘存在该子目录。 网站原文审校另记：
- 反例或理由：n=1，q(t)0=|t−1/2|³ 在 [0,1] 为 C²，端点均为1/8，却不是 C³，因而能区分原页前后两种资格；另 q(t)0=|t−2| 在 [0,1] 等于2−t，局部光滑且端点2、1，却在全线不光滑，因而不能满足当前 ContDiff ℝ ∞ q。这不排除该区间限制另有光滑延拓。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.admissibleSmooth`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：默认C∞区间版，补a<b；只对闭区间限制要求光滑，不强制任意全线代表光滑。C²与C∞的原文冲突保留导师选项。；`MD.Ch02.admissibleSmooth_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“默认C∞区间版，补a<b；只对闭区间限制要求光滑，不强制任意全线代表光滑。C²与C∞的原文冲突保留导师选项。”。
- 导师选项：裁定 G 取 C² 还是 C∞，并明确光滑在闭区间的含义。若选 C∞，使用区间光滑谓词，或显式按限制识别曲线并用存在光滑延拓表达资格；不要把任意代表的全线光滑当作局部资格。明确 a<b 的使用约定。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.admissibleSmooth。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 2. MD-2.2.1-VariationalDerivativePrinted

- source\_id：MD-2.2.1-VariationalDerivativePrinted。

### MD-2.2.1-VariationalDerivativePrinted

- 印刷页 / PDF页：62 / 84。
- 原文引文（逐字）：

> Define the variational derivative of a functional $`\mathcal F`$, $`\delta\mathcal F/\delta\boldsymbol q`$ so that

$$
\mathcal F(\boldsymbol q+\epsilon\boldsymbol\eta)=\epsilon\frac{\delta\mathcal F}{\delta\boldsymbol q}\boldsymbol\eta+O(\epsilon^2),
$$


> for all suitable (say, $`C^\infty`$) functions $`\boldsymbol\eta`$.

- 问题所在：printedVariationalDerivative逐η要求F(q+εη)-εAη=O(ε²)，确实没有减F(q)，忠实保留印刷公式；A为连续实线性泛函。抽象E表示允许的方向空间，结论不是通常HasFDerivAt定义。字面接口本身忠实，但原书所谓一般变分导数定义存在数学疑误，按任务规则整体转人工。 网站原文审校另记：code：PRINTED\_MISSING\_BASE\_VALUE；detail：印刷公式缺少F(q)常数项；忠实保留，通常定义应对增量F(q+εη)−F(q)展开。；stage：SOURCE\_MATHEMATICS
- 反例或理由：取恒定泛函F≡1和η=0，字面要求1=O(ε²)，不成立。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.printedVariationalDerivative`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：补被漏去的F(q)常项，保留逐方向O(ε²)及连续线性泛函，不将其混称一般Fréchet可微的必要条件。；`MD.Ch02.printedVariationalDerivative_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“补被漏去的F(q)常项，保留逐方向O(ε²)及连续线性泛函，不将其混称一般Fréchet可微的必要条件。”。
- 导师选项：保留printed字面定义；人工确认后另设corrected版本，以F(q+εη)−F(q)−εAη=O(ε²)表达。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.printedVariationalDerivative。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 3. MD-2.2.1-StationaryNotMin

- source\_id：MD-2.2.1-StationaryNotMin。

### MD-2.2.1-StationaryNotMin

- 印刷页 / PDF页：62 / 84。
- 原文引文（逐字）：

> Any curve which satisfies this equation will represent a “stationary point” (actually, “stationary curve” would be more accurate) of the classical action. Such curves could include smooth local action minimizers, local action maximizers, or “saddle points” of the actional functional in a generalized sense. Deciding whether a given stationary curve is an actual minimizer of the action would require analysis of the second variation (the coefficient of $`\epsilon^2`$ in the expansion above), which introduces additional complexity.

- 问题所在：版本绑定：本次实际读取 BATCH06.md、根目录 Ch02.lean（所称 Blueprint/Ch02.lean 的提供副本；工作区无该 Blueprint 路径）和 Ch02\_deps.txt，哈希见 input\_sha256；不声称不存在的路径已读取或验证了完整工程。依赖合集声明 HEAD=acc4fc5f11c882dd78acc6151bbde1607afdc528；本审计依据实际附件字节，不以分段声明哈希替代整体哈希。 已展开 Ch02\_deps.txt:2816、2831–2836：Q 1=Fin 1→ℝ，action 是真实 L(q,q̇) 的时间区间积分，variation 是 q+εη，stationaryAction 对所有 C²、零端点 η 要求 ε↦action L 0 1 (q+εη) 的导数在0为0。它与本地量化 C∞ 的 stationarySmoothAction 不是定义相同，但 C² 驻值蕴含 C∞ 驻值，且在本 C² 的 L,q 资格下通过 Euler–Lagrange 残差可获得一致的经典驻值解释，不能仅凭名字断定相等。Ch02.lean:182–187 的量词为存在固定 L,q 后，对每个 δ>0 存在可依赖 δ 的 C² 零端点 η，且闭区间位置范数处处 <δ 并使真实 action 严格下降。Q 1 的函数范数在此对应唯一坐标绝对值，故明确表达位置一致范数意义的非局部极小。[EXTRA] 以一维、固定时间窗存在例说明驻值不保证极小合理，不是所有驻值均非极小；但这是所引完整三句中的一个子命题，不能取代完整 scope。缺失条款：任意满足所指方程的曲线为驻值的普遍结论；光滑局部极小、局部极大、广义鞍点的可能类型；第二变分在判断极小中的作用。签名完全未引入第二变分。通用 L 的存在例还未限定原机械 L 的正质量形式；C² 曲线/扰动强度不同于原页后文 C∞；原文未指定局部极值拓扑，不能把位置一致范数解释扩张为所有光滑拓扑的非极小。材料缺失已解除，FAIL 来自明确的 scope 遗漏而非 sorry 或缺库。所涉原印刷泛函导数的 ERRATUM? 仍成立，但本条正确采用真实一阶驻值，不能把漏项字面定义与该驻值定义无条件混同。:187 的 sorry 另表示证明未完成；未做编译检查。 网站原文审校另记：
- 反例或理由：缺失条款本身足以判 FAIL。可作修复子命题的正质量光滑例：将 Q 1 识别为 ℝ，L(x,v)=(v²−ω²x²)/2，ω>π，q(t)=0。所有零端点 C² 方向的一阶作用量导数在0为0；η(t)=c sin(πt)，0<|c|<δ，使 action 差=c²(π²−ω²)/4<0。该例验证存在子命题可以为真，但不能补足所引三句的其他结论，也不是对该存在命题的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.stationaryNotMinimum`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.stationaryNotMinimum_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：若保留完整 statement\_scope，拆出任意 Euler–Lagrange 解为驻值的结论、极值/鞍点类型的明确数学声明，以及有适用正则性与拓扑的第二变分声明；不把“需要分析”擅自改成无条件的第二变分充要判据。若仅保留存在非极小子命题，应另经明确范围修订缩小 scope，并说明采用何种曲线空间/范数，优先使用正质量机械 L、C∞ 曲线与扰动，例如上述谐振子例。本次只提出建议，不改 A 的 json\_review、原附件或证明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.stationaryNotMinimum。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 4. MD-2.2.2-DiscreteAction

- source\_id：MD-2.2.2-DiscreteAction。

### MD-2.2.2-DiscreteAction

- 印刷页 / PDF页：63 / 85。
- 原文引文（逐字）：

> and thus, by Riemann summation

$$
\mathcal A_L\approx\hat{\mathcal A}\stackrel{\rm def}{=}\sum_{n=0}^{\nu-1} L\left(\boldsymbol q_n,\frac{\boldsymbol q_{n+1}-\boldsymbol q_n}{h}\right)h.
$$


> In the case of a mechanical system with Lagrangian $`L(\boldsymbol q,\boldsymbol v)=\dot{\boldsymbol v}^TM\boldsymbol v/2+U(\boldsymbol q)`$, we then have

$$
\hat{\mathcal A}=\sum_{n=0}^{\nu-1}\left[\frac{(\boldsymbol q_{n+1}-\boldsymbol q_n)^TM(\boldsymbol q_{n+1}-\boldsymbol q_n)}{2h^2}-U(\boldsymbol q_n)\right]h.
$$



- 问题所在：展开 deps:2816、2844–2847：Q为实坐标空间，discreteVelocity的第i坐标为相邻差除h，Finset.range ν为0至ν−1，h*L与原文L*h相等，因此一般L的求和定义正确。但本条statement\_scope包含机械作用量展示式，而bp\_discreteAction只有一般L求和，未陈述机械式。deps:2842–2843 的 mechanicalL = (∑i m\_i v\_i²)/2−U(q) 确实支持展示式的−U模型，却没有作为本条的等式结论。原文Riemann近似亦仅被定义右端和式，未表达近似/极限；原文未给误差界，不能擅加具体阶数。保留的[ERRATUM?]成立于已沿用A证据：正文带点v及+U与展示式和前节−U不一致；选择一般L不能补全本条机械子句。该定义无sorry，FAIL来自结论覆盖不足。 网站原文审校另记：
- 反例或理由：未单列反例；问题在原文省略资格、术语、证明步骤或覆盖范围。请结合原句及下列修正核查。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.bp_discreteAction`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：按原展示式采用动能−U的机械离散作用量，并限制h>0；正文+U原印保留。Riemann收敛只作背景，未给极限定理。；`MD.Ch02.bp_discreteAction_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“按原展示式采用动能−U的机械离散作用量，并限制h>0；正文+U原印保留。Riemann收敛只作背景，未给极限定理。”。
- 导师选项：在本条增加h>0、固定对角质量语境下的等式：bp\_discreteAction (mechanicalL m U) q h ν = ∑ k∈Finset.range ν, ((∑i m i*(q(k+1)i-q k i)^2)/(2*h^2)-U(q k))*h。明确机械式采用原文展示式的−U修正版本，保留原文疑误；将没有量化的Riemann近似说明明确标为解释性语境，或另列准确的收敛命题及其假设。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.bp\_discreteAction。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 5. MD-2.2.2-DiscreteStationaryPrinted

- source\_id：MD-2.2.2-DiscreteStationaryPrinted。

### MD-2.2.2-DiscreteStationaryPrinted

- 印刷页 / PDF页：63–64 / 85–86。
- 原文引文（逐字）：

> Critical points of this function satisfy

$$
\nabla\hat{\mathcal A}=0,
$$


> where the gradient must be taken with respect to all configurational points on the path (and all coordinates). This condition leads to the equations

$$
\frac{\partial\hat{\mathcal A}}{\partial\boldsymbol q_n}=0,\qquad n=1,\ldots,\nu,
$$


> since we think of the starting point $`\boldsymbol q_0`$ as fixed.

- 问题所在：printedDiscreteStationary对所有0<k≤ν要求替换第k个节点后的真实HasFDerivAt为零；replaceNode为Function.update，discreteAction为k=0至ν-1的hL(q\_k,(q_{k+1}-q\_k)/h)和。q₀未被变动，q\_ν仍被变动，完全保留印刷范围。经典导数资格避免不可微处fderiv=0的伪驻值。[EXTRA]正确，但书中右端点是否固定的矛盾须人工裁定。 网站原文审校另记：code：PRINTED\_ENDPOINT\_RANGE；detail：印刷n=1,…,ν包含右端点，下一页只对1,…,ν−1求导并称端点固定；保留字面范围。；stage：SOURCE\_MATHEMATICS
- 反例或理由：取一维自由L(q,v)=v²/2、ν=1、h=1、q₀=0、q₁=1。固定两端点时没有内部驻值方程；字面末节点条件却要求d(x²/2)/dx|₁=0，即1=0。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.printedDiscreteStationary`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：双端点固定的驻值只变动0<k<ν内部节点，保留原印≤ν供比较。；`MD.Ch02.printedDiscreteStationary_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“双端点固定的驻值只变动0<k<ν内部节点，保留原印≤ν供比较。”。
- 导师选项：保留printed的≤ν；固定双端点版本另设0<k<ν。若确实仅固定起点，应另列右端点自然边界条件。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.printedDiscreteStationary。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 6. MD-2.2.3-Consistency

- source\_id：MD-2.2.3-Consistency。

### MD-2.2.3-Consistency

- 印刷页 / PDF页：66–67 / 88–89。
- 原文引文（逐字）：

> The first assumption is that $`\mathscr G_h`$ is an $`O(h^{p+1})`$ approximation of $`\mathscr F_h`$ in the sense that there is a constant $`K\ge0`$ and a constant $`\Delta\gt 0`$ such that, for $`t\in[0,\tau]`$, we have

$$
\|\mathscr F_h(\boldsymbol z(t))-\mathscr G_h(\boldsymbol z(t))\|\le\bar K h^{p+1},\qquad h<\Delta.\tag{2.10}
$$


> The assumption (2.10) that the local error is of order $`p+1`$, $`p\gt 0`$, is termed the consistency of the numerical method. We say the method is consistent of order $`p`$.

- 问题所在：consistency固定G、F、γ、τ和自然数阶p；要求p>0，并先存在与t、h无关的K≥0、δ>0，再对全部t∈[0,τ]、0<h<δ给局部误差界Kh^(p+1)。严格步长范围与原式一致，整数阶限制已明确为[EXTRA]。未要求F必须是流是此纯误差关系的抽象接口。正文K和式中Kbar不一致已保留，不能在来源层面擅自等同，转人工。 网站原文审校另记：code：SOURCE\_CALLIGRAPHY；detail：原页流与单步映射使用花体mathscr F、mathscr G，摘录写mathcal，统一为原页字形。；stage：A；code：PRINTED\_CONSTANT\_MISMATCH；detail：正文存在K≥0，式(2.10)使用Kbar，未在本段绑定二者；不能静默改书。；stage：SOURCE\_MATHEMATICS
- 反例或理由：code：SOURCE\_CALLIGRAPHY；detail：原页流与单步映射使用花体mathscr F、mathscr G，摘录写mathcal，统一为原页字形。；stage：A；code：PRINTED\_CONSTANT\_MISMATCH；detail：正文存在K≥0，式(2.10)使用Kbar，未在本段绑定二者；不能静默改书。；stage：SOURCE\_MATHEMATICS
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.consistency`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.consistency_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：人工确认K与Kbar是否仅为同一非负常数的排印差异；若确认，再在修正版显式统一。保留自然数阶限制的[EXTRA]。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.consistency。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 7. MD-2.2.3-ErrorBound

- source\_id：MD-2.2.3-ErrorBound。

### MD-2.2.3-ErrorBound

- 印刷页 / PDF页：67 / 89。
- 原文引文（逐字）：

> From this, the bound

$$
\epsilon_n\le\frac{\bar K}{L}e^{Lnh}h^p,\qquad n=0,1,\ldots,\nu,\tag{2.12}
$$


> follows by a straightforward calculation, for $`h\le\Delta`$.

- 问题所在：errorBound对给定正h、正L、非负K和ν，要求0至ν实际迭代与精确网格值均在D，G在D上稳定，且全部n<ν上的实际局部缺陷≤Kh^(p+1)。初始误差由迭代起点γ(0)保证为零。结论对所有n≤ν为(K/L)exp(Lnh)h^p；p为实数，h>0使实幂有意义。此加强前提的界正确，不需要额外p>0才能成立。但没有δ及h≤Δ的量词，不能据此消除书中从严格步长范围跳到闭端点的问题，整体转人工。 网站原文审校另记：code：PRINTED\_STEPSIZE\_ENDPOINT；detail：(2.10)为h<Δ，(2.12)结句为h≤Δ；前者未控制h=Δ。；stage：SOURCE\_MATHEMATICS；code：PRINTED\_ZERO\_STABILITY\_CONSTANT；detail：原界除以L，需取L>0或单独处理L=0，不能将实数除零延拓视为原数学公式。；stage：SOURCE\_MATHEMATICS
- 反例或理由：端点不足的抽象反例：h=Δ=1，γ≡0，G\_h(x)=x（0<h<1），G\_1(x)=x+1。h<1时局部误差常数K=0且G始终满足L=1的稳定上界，但h=1一步误差为1，印刷闭端点结论给0。此反例针对来源严格局部误差前提，不满足Lean在h=1明确要求的hconsistent。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.errorBound`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.errorBound_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文版保留h≤Δ并标疑误。严格修正版限制0<h<Δ，或将局部误差假设加强到h≤Δ；取L>0，L=0另给nKh^(p+1)界。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.errorBound。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 8. MD-2.2.3-DefectPrinted

- source\_id：MD-2.2.3-DefectPrinted。

### MD-2.2.3-DefectPrinted

- 印刷页 / PDF页：68 / 90。
- 原文引文（逐字）：

> We now examine the series expansions for the exact and Verlet solutions and find that these differ in the third (and higher) order terms.

$$
Q-q(t+h)=\frac{h^3}{6}F'p+O(h^4),
$$


> and

$$
P-p(t+h)=\frac{h^3}{12}[p^2F''+F'F]+O(h^4).
$$



- 问题所在：已展开 Ch02\_deps.txt:3026–3028，MolecularDynamics/Chapter02/Statements.lean 的正式 scalarVerlet：Q=q+hp+h²F(q)/2，P=p+h(F(q)+F(Q))/2，确与教材算法对应。Ch02.lean:386–392 的对象、量词、C³ 及实际标量轨迹假设与原印一致；两个残差也字面保留原印正号。然而正式定义给 Q−q(h)=−h³F′p/6+O(h⁴)，故位置残差中再减 h³F′p/6 不成立。动量三阶缺陷 (p²F″+F′F)/12 正确。原印的字面忠实与命题的数学错误须区分：本条 FAIL 是确认原书错误已被写成假定理；[ERRATUM?] 成立，不是翻译错号。依赖内另有 verletDefectExpansion\_statement（3043–3048）明确采用修正符号，但本次判断来自展开计算，而非仅凭该名字。[EXTRA] C³、实际轨迹及自治时间平移合理，全轴条件强于必要。本声明体为 sorry；该事实独立于数学反例。 网站原文审校另记：
- 反例或理由：取 F(x)=x，γ(t)=(sinh t,cosh t)。F 为 C∞ 且 γ′(t)=(cosh t,sinh t)=((γ t).2,F((γ t).1))，全部假设成立。γ(0)=(0,1)，正式 scalarVerlet 给 (Q,P)=(h,1+h²/2)。位置残差为 h−sinh h−h³/6=−h³/3+O(h⁵)，除以 h⁴ 的绝对值无界，非 O(h⁴)。动量残差 1+h²/2−cosh h 为 O(h⁴)，不影响第一合取项的失败。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.defectPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。；`MD.Ch02.defectPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。”。
- 导师选项：另立标明勘误的修正版定理，将位置 BigO 残差末项 −h³/6*deriv F (γ 0).1*(γ 0).2 改为 +h³/6*deriv F (γ 0).1*(γ 0).2；动量项保持不变。保留原印 statement\_latex 与 ERRATUM? 记录，把错误原印作为被否定的历史陈述，不继续把它当作待证明真命题。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.defectPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 9. MD-2.2.3-VerletConsistency

- source\_id：MD-2.2.3-VerletConsistency。

### MD-2.2.3-VerletConsistency

- 印刷页 / PDF页：68 / 90。
- 原文引文（逐字）：

> These relations can be summarized as telling us that

$$
\|\mathscr G_h(\boldsymbol z)-\mathscr F_h(\boldsymbol z)\|=\kappa(\boldsymbol z)h^3+O(h^4),
$$


> where $`\kappa(\boldsymbol z)=\kappa(q,p)`$ is a function of the position and momentum. We may then define

$$
\bar K=\max_{t\in[0,\tau]}\kappa(\boldsymbol z(t))
$$


> bounding the local error by (with neglect of the fourth order terms) $`\bar K h^3`$. Thus the Verlet method is consistent of order two.

- 问题所在：检查全部量词与四部分结论：F C³、τ和δ正、γ在闭窗连续；Φ从每个z出发在统一局部时间窗满足实际ODE且Φ₀z=z；γ与Φ在所需正步长内一致。κ在range γ上连续非负并逐z给正侧h→0的h³主项及O(h⁴)；闭窗上存在真正达到的最大值K；另有统一C、δ₀使闭窗全部t的局部误差≤Ch³。正侧避免|h|³与h³混淆，C吸收余项而不强称C=max κ。该严格修正版合理，但来源忽略余项的界仍需人工确认。 网站原文审校另记：code：SOURCE\_CALLIGRAPHY；detail：原页使用mathscr G\_h与mathscr F\_h，摘录写mathcal。；stage：A；code：NEGLECTED\_REMAINDER；detail：max κ只控制三阶主项；O(h⁴)不能未经吸收就从严格局部误差界中删除。；stage：SOURCE\_MATHEMATICS
- 反例或理由：code：SOURCE\_CALLIGRAPHY；detail：原页使用mathscr G\_h与mathscr F\_h，摘录写mathcal。；stage：A；code：NEGLECTED\_REMAINDER；detail：max κ只控制三阶主项；O(h⁴)不能未经吸收就从严格局部误差界中删除。；stage：SOURCE\_MATHEMATICS
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.verletConsistency`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.verletConsistency_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原引文及疑误；严格结论采用独立C≥0吸收统一余项，不宣称C等于max κ；现有Lean已采用该方案。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.verletConsistency。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 10. MD-2.2.4-IntegralErrorPrinted

- source\_id：MD-2.2.4-IntegralErrorPrinted。

### MD-2.2.4-IntegralErrorPrinted

- 印刷页 / PDF页：71 / 93。
- 原文引文（逐字）：

> This means if we know that $`\|\nabla I(\boldsymbol z)\|`$ remains bounded, say less than $`B`$, in an open domain containing the solution, we could conclude that the error in $`I`$-values computed along a numerical trajectory is of order $`h^p`$,

$$
|I(\boldsymbol z(t_n))-I(\boldsymbol z_n)|\le\frac{\bar K B}{2L}e^{nLh}h^p,\qquad h<\bar h,\tag{2.16}
$$


> with the same assumptions as are needed to characterize the convergence of the method.

- 问题所在：展开 Q n=Fin n→ℝ（Ch02\_deps.txt:2816），因此 n=1 的范数为绝对值、坐标评价的 Fréchet 导数算子范数为1。任意 n,I,D,B,K,L,h,p,k,a,b，在正性、开放域含整段、C¹、域内导数算子范数≤B 和先前点误差≤(K/L)exp(Lkh)h^p 后，结论要求 (KB/(2L))exp(Lkh)h^p。这一1/2无法由这些假设推出，以下反例完全落实到实际 Q。B,K≥0、L>0、h≥0、整段留域及C¹均合理，但不能产生额外1/2；以任意点替代实际轨迹也是更强的断言，且签名未显式保留 h<hbar 的窗口。[ERRATUM?] 对固定同一 K 的推导缺口成立；本审计不把它扩大为对教材所有可能常数约定的裁定。Q 的 Pi 范数在 n>1 时不是欧氏范数，导数算子范数界应明确为相应对偶范数或改用 EuclideanSpace。正文有 sorry，FAIL 与此独立。 网站原文审校另记：
- 反例或理由：取 n=1，I(q)=q 0，D=univ，B=3/2，K=L=1，h=1/2，p=1，k=0，a=fun _=>1/2，b=fun _=>0。I 为C∞、导数算子范数1<B，所有假设成立，先前误差界为1/2≤1/2，但结论为1/2≤3/8，假。即使添加 hbar=1、h<hbar、p>0，仍是反例。这是实际签名的点界反例，不声称来自满足原书全部方法假设的数值轨迹。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.integralErrorPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：由给定点误差只推出KB/L，去掉不成立的因子1/2，不加倍K也不预设待证积分误差。；`MD.Ch02.integralErrorPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“由给定点误差只推出KB/L，去掉不成立的因子1/2，不加倍K也不预设待证积分误差。”。
- 导师选项：保留字面印刷式及 ERRATUM 记录；另列修正版，将 KB/(2L) 改为 KB/L，或提供并独立证明更强点误差≤(K/(2L))exp(Lkh)h^p。补足小步长窗口并明确 K 与原文 Kbar 的同一性；若要忠实欧氏梯度范数，改用 EuclideanSpace ℝ (Fin n)。不得把待证积分误差直接设为假设或默默加倍K。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.integralErrorPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 11. MD-2.3.1-VariationalPrinted / MD-2.3.4-HamiltonSymplectic / MD-2.3.4-HamiltonVariationalPrinted

- source\_id：MD-2.3.1-VariationalPrinted；MD-2.3.4-HamiltonSymplectic；MD-2.3.4-HamiltonVariationalPrinted。

### MD-2.3.1-VariationalPrinted

- 印刷页 / PDF页：73 / 95。
- 原文引文（逐字）：

> To understand where Liouville’s theorem comes from, recall that the variational equations of the last chapter are a system of ordinary differential equations for $`W(t)=\mathcal F_t'(\boldsymbol z(t))`$:

$$
\frac{\mathrm dW}{\mathrm dt}=f'(\boldsymbol z(t))W.
$$


> Thus

$$
\dot W W^{-1}=f'(\boldsymbol z(t)).
$$



- 问题所在：已实际展开 Statements.lean 的 flowC1：f C¹、Φ 联合 C¹、∀z Φ(0,z)=z、∀t∈[0,τ]∀z 时间导数为 f(Φ(t,z))；没有把待证变分公式作为前提。Q 与 Jacobian 为真实有限实坐标空间与真实空间导数。签名忠实保留原书移动取值点 W(t)=D\_yΦ(t,Φ(t,ζ))，同时要求 W′=Df(Φ(t,ζ))W 及 W′W⁻¹=Df(Φ(t,ζ))。这两条一般均错误；移动点的链式项和 Df 的取值点均不能省略。以下全实线 C∞ 完整流满足所有前提且 W 可逆，排除了正则性不足或域问题，确证 ERRATUM? 成立。正确变分矩阵应取固定初值 D\_yΦ(t,ζ)。原签名只有联合 C¹，也未显式登记空间导数关于时间可微的更强充分资格；修正时可用联合 C²。当前证明体是 sorry，但 FAIL 来源于反例而非 sorry。 网站原文审校另记：
- 反例或理由：取 n=1，以 Q 1≅ℝ 识别。令 g(u)=u+u³，k=g⁻¹。g′=1+3u²>0，且 g 为满射，故 k 全局 C∞。设 f(x)=1+3k(x)²，Φ(t,x)=g(k(x)+t)，τ=1，ζ=0。Φ 联合 C∞、Φ(0,x)=x，∂tΦ=g′(k(x)+t)=f(Φ(t,x))，对全实线成立，因此满足 flowC1。Φ(t,0)=g(t)，W(t)=∂xΦ(t,g(t))=g′(2t)/g′(t)=(1+12t²)/(1+3t²)。W′(t)=18t/(1+3t²)²，Df(Φ(t,0))=6t/(1+3t²)。在 t=1/2∈(0,1)，W=16/7、W′=144/49，而 Df·W=192/49；W′/W=9/7，而 Df=12/7。两个合取子句均不成立，W 此时非零。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.variationalPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：Jacobian在固定初值ζ求值；联合C²及变分矩阵非奇异作为显式充分资格，Df仍在真实轨道点求值。；`MD.Ch02.variationalPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“Jacobian在固定初值ζ求值；联合C²及变分矩阵非奇异作为显式充分资格，Df仍在真实轨道点求值。”。
- 导师选项：保留原书文字及 ERRATUM 记录；另立明确更正版，将所有空间 Jacobian 的移动取值点 Φ(s,ζ)、Φ(t,ζ) 改为固定 ζ，但右侧 Df 仍在 Φ(t,ζ) 取值。登记足够资格（例如联合 C² 实际解族与 f C¹），并说明由正则流的可逆变分矩阵得到第二子句，或显式加入该点 detW≠0；不得尝试证明当前错误签名。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.variationalPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-2.3.4-HamiltonSymplectic

- 印刷页 / PDF页：79 / 101。
- 原文引文（逐字）：

> hence

$$
W^TJW\equiv W(0)^TJW(0)=J.
$$


> This proves that the flow map of a Hamiltonian system is a symplectic map.

- 问题所在：原页21（印刷79页）hence、WᵀJW≡W(0)ᵀJW(0)=J及最后流为辛映射原句忠实。Lean对象为真实H和联合C²实际解族Φ，Φ0=id且满足Hamilton ODE；结论对每个t∈[0,τ]为IsTextbookSymplecticMap，展开即C¹与每初值点的Jacobian辛恒等式，初始Jacobian由Φ0=id为I。该签名本身数学正确，且没有τ>0前提。但原页紧邻上下文实际写W(t)=F′_t(z(t,ξ))，而变分矩阵通常应为D\_ξF\_t(ξ)；随移动点评价的全导数另有空间链式项。当前context只称疑点另项记录，未具体登记；按照保留原书数学疑误要求，本条需人工明确W的约定，不将正确Lean结论冒充对原书该推导的逐字证明。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。 网站原文审校另记：code：NONEXISTENT\_TAU\_POSITIVITY；status：CORRECTED；fields：extra\_assumptions；detail：extra\_assumptions提到τ>0，但当前签名没有此假设；修正为任意τ及实际Icc 0 τ时间域。；code：PRINTED\_MOVING\_BASEPOINT；status：NEEDS\_HUMAN；fields：context\_notation；issues；detail：原书同页把W(t)写为F′_t(z(t,ξ))，与固定初值变分矩阵存在评价点疑误；不得以正确Lean流辛性结论掩盖原书推导的此项问题。
- 反例或理由：code：NONEXISTENT\_TAU\_POSITIVITY；status：CORRECTED；fields：extra\_assumptions；detail：extra\_assumptions提到τ>0，但当前签名没有此假设；修正为任意τ及实际Icc 0 τ时间域。；code：PRINTED\_MOVING\_BASEPOINT；status：NEEDS\_HUMAN；fields：context\_notation；issues；detail：原书同页把W(t)写为F′_t(z(t,ξ))，与固定初值变分矩阵存在评价点疑误；不得以正确Lean流辛性结论掩盖原书推导的此项问题。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.hamiltonSymplectic`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.hamiltonSymplectic_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：人工确认原书W的评价点：若意指初值灵敏度，应在勘误/说明中另写W(t)=D\_ξF\_t(ξ)，保留原书字面记录；当前Lean声明无需改动。同步采用corrected\_json中与实际签名一致的τ说明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 ['MD.Ch02.hamiltonSymplectic']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-2.3.4-HamiltonVariationalPrinted

- 印刷页 / PDF页：79 / 101。
- 原文引文（逐字）：

> For the Hamiltonian system $`\dot{\boldsymbol z}=J\nabla H(\boldsymbol z)`$, these take the form:

$$
\dot W=JS(t)W,
$$


> where $`S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))`$ is a symmetric matrix.

- 问题所在：已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。SymplecticMaps.lean 的 textbookJacobian Φ z=LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，第(i,j)项为DΦ(z)[e\_j]_i；SplittingError.lean 的 textbookHamiltonianVectorField H z=J乘以各基方向的DH，故确为(q̇,ṗ)=(H\_p,-H\_q)。HamiltonianVariational.lean 的 Hessian为实际二阶导数。Ch02.lean:793–803 对所有n,H,Φ,τ,ζ，在H C²、Φ联合C¹、Φ₀=id、闭区间所有初值满足真实ODE下，宣称移动点W(s)=DΦ\_s(Φ\_s(ζ))满足Ẇ=J Hzz(Φ\_t(ζ))W。它忠实保留印刷疑误，却不是正确变分方程；[ERRATUM?]由下列全局光滑反例确定成立。即使加强Φ为C∞也不能补救。通常固定初值W=DΦ\_t(ζ)才满足该式；移动点同时产生空间链式项，且固定底点的变分系数在Φ\_t(Φ\_t(ζ))取值。C¹本身也不足以直接保证所需二阶混合导数。τ≤0时开区间为空，不影响τ>0的反例。签名FAIL与证明体显式sorry分别记录；该sorry不作为判FAIL的理由。 网站原文审校另记：
- 反例或理由：取Nc=1，f(q)=2+sin q，H(q,p)=p f(q)。令Q\_t(q)为q̇=f(q)的全局流（f光滑有界且1≤f≤3），定义Φ\_t(q,p)=(Q\_t(q), p f(q)/f(Q\_t(q)))。它是全局C∞真实Hamilton流、Φ₀=id，满足全部前提。ζ=(0,0)，W(t)=DΦ\_t(Φ\_t(ζ))的(q,q)项a(t)=f(Q_{2t}(0))/f(Q\_t(0))，且W的(p,q)项为0。直接求导a′/a=2cos(Q_{2t}(0))−cos(Q\_t(0))；宣称右侧JHzz(Φ\_t(ζ))W的(q,q)项除以a却为cos(Q\_t(0))。取τ=1/4、t=1/8，则0<Q\_t(0)<Q_{2t}(0)≤3/4<π，余弦严格递减，二者不等。这一反例直接适用于附件已核实的J符号、坐标及导数定义。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.hamiltonVariationalPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。；`MD.Ch02.hamiltonVariationalPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。”。
- 导师选项：保留印刷式作为疑误记录，不把错误字面式作为待证真命题。正确版本将两处Jacobian取值点改为固定ζ，并采用联合C²流这一充分假设；附件ActualFlowVariations.lean的textbookHamiltonianFlowJacobian\_hasDerivAt正好给出该正确形式。若保留移动点，须用链式法则改写全部右侧，不能仅提高正则性。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.hamiltonVariationalPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 12. MD-2.3.2-EulerVolumePrinted

- source\_id：MD-2.3.2-EulerVolumePrinted。

### MD-2.3.2-EulerVolumePrinted

- 印刷页 / PDF页：75 / 97。
- 原文引文（逐字）：

> and the condition for Euler’s method to conserve volume is that $`\det(I+hS)=1`$.

- 问题所在：实际读取 Ch02.lean:634–638；展开依赖Q n=Fin n→ℝ及linearEuler S h=1+h • S（合集2816、2878–2879行）。volume是标准无向Lebesgue体积，合集LiouvilleVolume换元使用|det|；依赖Statements.lean:3129–3132的linearEulerVolume\_statement本身也明确写|det|=1，但当前Blueprint定理并未引用这个修正版，而是↔det=1。任意n、S、h且全部可测T的量词忠实照录原文，却产生数学错误：det=1是充分条件而非必要条件。[ERRATUM?]在当前明确的无向体积解释下成立，无须再NEEDS\_HUMAN。没有方向或小步长假设；仅h>0不能修复。证明体含sorry，不能使错误签名有效。 网站原文审校另记：
- 反例或理由：n=1，S=[-2]，h=1，则linearEuler S h=[-1]。映射x↦-x保存每个可测集合的Lebesgue体积，故左边为真；行列式=-1，右边为假。即使另加trace S=0：S=diag(-2,2)、h=1/√2时det(I+hS)=1-4h²=-1，同样反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.eulerVolumePrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：标准无向体积的判据为绝对行列式1；原det=1不作必要条件。；`MD.Ch02.eulerVolumePrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“标准无向体积的判据为绝对行列式1；原det=1不作必要条件。”。
- 导师选项：保留原文和ERRATUM标记；数学修正版改为体积保存↔|(linearEuler S h).det|=1。若必须保留det=1，则明确增加det(I+hS)>0，或给出确保其正值的小步长范围；h>0本身不够。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.eulerVolumePrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 13. MD-2.3.5-ChainRule

- source\_id：MD-2.3.5-ChainRule。

### MD-2.3.5-ChainRule

- 印刷页 / PDF页：79 / 101。
- 原文引文（逐字）：

> Let $`\Phi_1`$ and $`\Phi_2`$ be any pair of symplectic maps. Then

$$
(\Phi_1\circ\Phi_2)'=\Phi_1'\Phi_2',
$$


> by the chain rule,

- 问题所在：原页22（印刷79页）两辛映射、链式展示式和by the chain rule,逐字一致。Lean对任意两个全局可微实际映射Φ,Ψ及每个z，明确给Jacobian(Φ∘Ψ)(z)=Jacobian Φ(Ψ(z))·Jacobian Ψ(z)，矩阵乘法顺序正确。辛性对链式法则不必要，去掉该前提是有效推广；hΦ,hΨ是全局可微而不是extra说明中的仅在相应点可微。原文外导数评价点省略的NEEDS\_HUMAN问题已存在，本次保留：按标准简写约定可解释正确，若按同一z字面解释则不正确，需人工确认原文约定；不改动原文展示式。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。 网站原文审校另记：code：REGULARITY\_METADATA\_MISMATCH；status：CORRECTED；fields：extra\_assumptions；detail：extra\_assumptions所称在相应点可微不是当前全局Differentiable签名；修正并说明去掉辛前提的有效推广。；code：OMITTED\_EVALUATION\_POINT；status：NEEDS\_HUMAN；fields：issues；context\_notation；detail：保留原JSON已有NEEDS\_HUMAN：原文没有显写外导数在Φ₂(z)评价。Lean正确，但原文简写约定仍交人工确认。
- 反例或理由：说明为何必须确认评价点而非两处均取同一z：令Φ(q,p)=(q,p+q²)，Ψ(q,p)=(q+1,p)，二者均辛。在z=(0,0)，D(Φ∘Ψ)(z)=[[1,0],[2,1]]，而DΦ(z)DΨ(z)=I。正确的DΦ(Ψ(z))DΨ(z)与Lean一致。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.chainRule`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.chainRule_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：人工确认教材撇号乘积采用链式法则的通常基点约定。保留原文简写，在注释或独立勘误中显写D(Φ₁∘Φ₂)(z)=DΦ₁(Φ₂(z))DΦ₂(z)；当前Lean无须修改。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 ['MD.Ch02.chainRule']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 14. MD-2.3.5-GlobalGroupPrinted / MD-2.3.5-SymplecticInverse / MD-2.3.7-Adjoint

- source\_id：MD-2.3.5-GlobalGroupPrinted；MD-2.3.5-SymplecticInverse；MD-2.3.7-Adjoint。

### MD-2.3.5-GlobalGroupPrinted

- 印刷页 / PDF页：79 / 101。
- 原文引文（逐字）：

> The determinant of a symplectic map is $`\pm1`$, hence these maps are always invertible, and the inverse of a symplectic map is symplectic since $`\Phi'^TJ\Phi'=J`$ implies $`J=\Phi'^{-T}J\Phi'^{-1}`$. Thus the symplectic maps form a group under composition.

- 问题所在：已展开 Ch02\_deps.txt：SymplecticForm.lean 第33–41行将 SymplecticCoordinates n 定义为 (Fin n ⊕ Fin n) → ℝ（q 后 p），矩阵为该指标上的实方阵，textbookJ=[[0,I],[-I,0]]；第138–139行 IsTextbookSymplectic A 是 AᵀJA=J。SymplecticMaps.lean 第238–241行 textbookJacobian 是实际 Fréchet 导数 fderiv 的坐标矩阵，第272–274行 IsTextbookSymplecticMap Φ 是 ContDiff ℝ 1 Φ ∧ ∀ z, DΦ(z)ᵀJDΦ(z)=J，不含全球双射。 Ch02.lean 第859–862行量词为所有 n、所有 C¹ 辛自映射，推出全球双射及选择逆 Function.invFun Φ 为 C¹ 辛映射。在双射假设成立时 invFun 是真实唯一逆，但辛假设本身不保证双射。[ERRATUM?] 成立，正式谓词确实允许下面 n=1 的光滑反例。这一假命题保留了原书全球可逆性疑误，命题为假本身不等于错误转录；独立的签名忠实性问题是本条 statement\_scope 包含原句全部展示主张，而签名没有明示“Jacobian 行列式 ±1”子句，也未给实际群对象/群结构。行列式由 deps 第312–316行可推出更强的逐点 det=1，闭合、单位与逆可另由本批前项及库群构造组合，但这些未成为本声明的完整结论。故按全部结论子句审计 FAIL。deps 第366–382行已经提供由真正全球辛微分同胚构成的 Subgroup 及其复合运算，可用于另列修正版。正文直接 sorry：这单独表示证明未完成，不作为 FAIL 的理由，也不尝试补证。 网站原文审校另记：
- 反例或理由：取 n=1，将 z(Sum.inl 0)=q、z(Sum.inr 0)=p。设 a(q)=q+sqrt(1+q²)，b(q)=a′(q)=1+q/sqrt(1+q²)>0，定义 Φ(q,p)=(a(q),p/b(q))。这是 R² 上 C∞ 自映射，其实际导数矩阵为 [[b,0],[-p b′/b²,1/b]]，其中 b′=(1+q²)^(-3/2)，故 det DΦ=1，且对正式 J=[[0,1],[-1,0]] 有 DΦᵀ J DΦ=J，满足展开后的 IsTextbookSymplecticMap。a 是 R 到 (0,∞) 的双射，因此 Φ 的像为 (0,∞)×R，漏掉 (0,0)，不是满射，Function.Bijective Φ 为假。该反例直接匹配正式坐标空间与 C¹ 条件，不依赖缺失定义。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.globalGroupPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：只对已给全局双射且逆C¹的辛微分同胚断言逆辛；逐点非奇异不推出任意保辛自映射全局满射。；`MD.Ch02.globalGroupPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“只对已给全局双射且逆C¹的辛微分同胚断言逆辛；逐点非奇异不推出任意保辛自映射全局满射。”。
- 导师选项：原书字面条目应继续标记确凿疑误，不补证明。若仍要求覆盖原文完整范围，应分别明确逐点 det(DΦ)=1（蕴含 ±1）子句、字面全球可逆子句与群主张，并标注后两者在无全球双射条件时不成立；或明确缩小本条 statement\_scope 为“原书全球可逆且逆辛的疑误”。另列正确命题：固定 n 上给定全球 C¹ 辛微分同胚组成 textbookSymplecticDiffeomorphismGroup n（deps 第366–382行），群乘法为函数复合。不得静默把该修正版冒充原文。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.globalGroupPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-2.3.5-SymplecticInverse

- 印刷页 / PDF页：79 / 101。
- 原文引文（逐字）：

> and the inverse of a symplectic map is symplectic since $`\Phi'^TJ\Phi'=J`$ implies $`J=\Phi'^{-T}J\Phi'^{-1}`$.

- 问题所在：Lean对任意Nc、实际双射e，假设e全局C¹且保J，并另有e.symm全局C¹，结论给出逆映射保J以及其逆C¹；这个受限定理正确，[EXTRA]已披露。可是本页上下文把Jacobian非奇异当作全局可逆的理由；此Lean没有证明原文所暗含的任意保辛自映射均有全球逆。矩阵恒等式与映射可逆性必须分开，保留原书疑误供人工处理。 网站原文审校另记：code：BOOK\_GLOBAL\_INVERSE\_GAP；field：context\_notation；explanation：PDF同段从det非零推出映射全局可逆，结论不成立；本条逆矩阵恒等式忠实保留。现有[EXTRA]足以使Lean定理正确，但全球群性不得无条件推广。
- 反例或理由：二维例Φ(q,p)=(sqrt(2*exp(q))*cos(p*exp(-q)),sqrt(2*exp(q))*sin(p*exp(-q)))光滑。令r=sqrt(2exp(q)),θ=p exp(-q)，则dX∧dY=r dr∧dθ=dq∧dp，因此DΦᵀJDΦ=J；但Φ(q,p+2πexp(q))=Φ(q,p)，非单射。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.symplecticInverse`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.symplecticInverse_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文并注明全球逆须另假设存在。可将已给Lean清楚标为全局辛微分同胚版本；不要宣称它证明所有保辛自映射构成群。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.symplecticInverse。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-2.3.7-Adjoint

- 印刷页 / PDF页：81 / 103。
- 原文引文（逐字）：

> Given any numerical integrator $`\mathcal G_h`$, consider the map

$$
\mathcal G_h^\dagger=\mathcal G_{-h}^{-1}.
$$



- 问题所在：E任意类型，G为每个实数步长都取实际置换的族；对任意h输出(G(-h)).symm，负号及求逆顺序完全符合定义。全球双射族比教材局部可逆方法强，[EXTRA]已披露，不会把任意非可逆一步法直接变成置换。这个定义只给伴随运算，不主张其精度或所有数值法可逆。 网站原文审校另记：code：BOOK\_INVERTIBILITY\_QUALIFICATION；field：extra\_assumptions；explanation：原书“any numerical integrator”须在负步映射确实可逆的范围理解；如一维显式Euler f(x)=-x、h=1时G\_h恒为0，并非置换。已给[EXTRA]是限定版本，保留原书字面，泛称的严格解释交人工。
- 反例或理由：code：BOOK\_INVERTIBILITY\_QUALIFICATION；field：extra\_assumptions；explanation：原书“any numerical integrator”须在负步映射确实可逆的范围理解；如一维显式Euler f(x)=-x、h=1时G\_h恒为0，并非置换。已给[EXTRA]是限定版本，保留原书字面，泛称的严格解释交人工。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.bp_adjoint`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：把负步映射明示为Equiv可逆映射后定义伴随；不把任意数值积分器无条件当作全局可逆。原书any表述和Euler反例保留。；`MD.Ch02.bp_adjoint_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“把负步映射明示为Equiv可逆映射后定义伴随；不把任意数值积分器无条件当作全局可逆。原书any表述和Euler反例保留。”。
- 导师选项：保留原文并注明范围 / 接受独立限定修正版。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch02.bp\_adjoint。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 15. MD-2.4.1-SymmetricEven

- source\_id：MD-2.4.1-SymmetricEven。

### MD-2.4.1-SymmetricEven

- 印刷页 / PDF页：85 / 107。
- 原文引文（逐字）：

> Self-adjoint, or symmetric schemes have unique features; in particular they have even order [164, 227].

- 问题所在：Q n为有限维实空间；r为正自然数，G、F均实际可逆且联合C∞，F具有群律。逐点局部误差O(|h|^(r+1))且非O(|h|^(r+2))编码有限确切阶；光滑自伴随族的首个非零局部误差次数为奇数，故r偶。群律与可逆性推出F 0=id；正阶误差推出G 0=id。加强条件已标EXTRA，结论合理；原句省略有限确切阶资格须保留提醒。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。 网站原文审校另记：原书未写有限、正、确切阶及正则性；精确流没有有限确切阶。保留引文，人工确认资格注记。
- 反例或理由：若把order理解为误差界的下界，精确恒等流G=F=id满足每个r的局部阶界，也满足r=1；故必须保留非(r+1)阶的确切性。此例不反驳当前Lean前提。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.symmetricEven`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.symmetricEven_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原书未写有限、正、确切阶及正则性；精确流没有有限确切阶。保留引文，人工确认资格注记。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.symmetricEven。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 16. MD-2.4.2-CompositionOrder

- source\_id：MD-2.4.2-CompositionOrder。

### MD-2.4.2-CompositionOrder

- 印刷页 / PDF页：85 / 107。
- 原文引文（逐字）：

> The order of this method is typically the minimum of the orders of the two methods involved, but it can be higher, as the example of the Verlet method (constructed by composing symplectic Euler and its adjoint) shows.

- 问题所在：已展开全部本条自定义对象：Chapter02Review.Q n = Fin n → ℝ，r、s为自然数；F是每个实时间的双射族，假设∀h k z, F h(F k z)=F(h+k)z，因此F 0=id。G₁、G₂是任意方法族，不要求辛；这是阶数估计的合理推广。methodLocalOrder G F r 实为 ∀z, ∃C>0, ∃δ>0, ∀h, |h|<δ → ‖G h z−F h z‖≤C|h|^(r+1)，是每个固定初值的局部截断误差下界，C与δ可依赖z，既非确切阶也非全局误差阶。textbookComposeMaps 展开为G₁(h/2)∘G₂(h/2)。实际量词顺序为n,F,G₁,G₂,r,s，然后流律、两条逐点局部阶假设、G₁稳定假设，结论只有同一逐点局部意义的min r s阶下界。[EXTRA]同一实际流合理，误差传播稳定条件合理作为充分条件，但实际稳定性为∀δ>0 ∃L≥0 ∀|h|<δ ∀u v，与原文未言明的全域空间稳定性及每个有限步长区间要求相比明显更强；证明局部阶通常只需某个小δ，不能称该全部额外强度必要。逐点误差常数不能直接用于随h移动的初值F(h/2)z，若采用通常的误差分解证明，还需补足邻域一致性或另给严格论证；本审计不据此断言定理数学上为假。确定的FAIL理由是全部结论未覆盖：至少min阶仅允许、没有断言或展示严格更高阶的实例；原文明确的Verlet由辛Euler及其伴随复合并达到更高阶未表达，typically也未形式化为任何泛型结论。原文statement\_scope覆盖整句，不能以[EXTRA]注释把整句缩成下界定理而仍判完全忠实。无[ERRATUM?]，未发现需要据此修改原书的错误。Ch02.lean 1059–1065与本批签名一致，含直接sorry；证明缺口与上述签名语义FAIL分开。 网站原文审校另记：
- 反例或理由：缺失结论条款而非已建立的定理反例：原文“but it can be higher, as the example of the Verlet method (constructed by composing symplectic Euler and its adjoint) shows”没有对应Lean结论。min阶下界即使成立，也不能推出存在一对方法使复合确切阶严格高于两者最小确切阶。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.compositionOrder`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.compositionOrder_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：将现有声明明确拆为至少min局部阶的辅助定理，并补充同一实际流上的辛Euler、其伴随及半步复合等于Verlet的实例，以及两起始方法确切一阶、Verlet至少二阶（需声称确切二阶时再证非三阶）。对typically明确其非严格数学断言的处理范围，不宣称下界完整形式化整句。如意在全局精度阶，另定义并证明有限时间全局误差界；若保留局部阶，注明含义，采用邻域一致的局部截断误差及仅小步长的稳定条件，或提供现有逐点量词下充分性的严格论证。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.compositionOrder。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 17. MD-2.4.4-ImplicitLocal

- source\_id：MD-2.4.4-ImplicitLocal。

### MD-2.4.4-ImplicitLocal

- 印刷页 / PDF页：86 / 108。
- 原文引文（逐字）：

> An implicit method will typically result in a system of nonlinear equations of the form

$$
g(\boldsymbol z_{n+1})=\boldsymbol\tau_n,\tag{2.25}
$$


> which will need to be solved at each timestep. The right hand side $`\boldsymbol\tau_n`$ is a vector that depends on the previous time-step $`\boldsymbol z_n`$, perhaps in a complicated way. We may assume the number of equations represented by (2.25) is equal to the dimension of the space where $`\boldsymbol z`$ is defined, so we have a square nonlinear system. Typically $`g`$ will depend on the stepsize and coefficients of the method and will have the property that for $`h`$ sufficiently small, the solution is uniquely defined and is continuously defined in terms of $`\boldsymbol\tau_n`$, that is the mapping $`g`$ has a bounded and smooth inverse.

- 问题所在：对每个n、联合C∞的g(h,x)、基点x及零步可逆导数A，存在统一小步长δ；每个小步长有开U,V包含x,g\_h(x)，MapsTo及双向逆等式。inv在V内C∞且函数值有界；可通过缩小局部邻域取得该界，不等于宣称全域逆有界。前提和局部性均明确，未假设所需逆已经存在。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。 网站原文审校另记：原句bounded and smooth inverse未明说局部或正则性；全域有界解释不能成立。保留原文，将本条作为局部逆函数定理的有资格解释交人工确认。
- 反例或理由：g\_h(x)=x在实直线上全域可逆且光滑，但全域逆不有界；当前Lean只在缩小V内要求有界，避开该问题。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.implicitLocal`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.implicitLocal_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原句bounded and smooth inverse未明说局部或正则性；全域有界解释不能成立。保留原文，将本条作为局部逆函数定理的有资格解释交人工确认。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.implicitLocal。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 18. MD-2.4.4-Newton

- source\_id：MD-2.4.4-Newton。

### MD-2.4.4-Newton

- 印刷页 / PDF页：86–87 / 108–109。
- 原文引文（逐字）：

> Solving the system may then proceed, from an initial guess $`\boldsymbol z_{n+1}^{(0)}`$ by use of Newton’s method:

$$
\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}-[J^{(k)}]^{-1}(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),
$$


> where $`J^{(k)}`$ is the Jacobian matrix of the mapping $`g`$ evaluated at $`\boldsymbol z_n^{(k)}`$, or else an approximation of this Jacobian (assumed to be nonsingular due to the invertibility of the mapping). The iteration may be recast in the form

$$
\boldsymbol b_k=-(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),\quad J^{(k)}\Delta\boldsymbol z_k=\boldsymbol b_k,\quad\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}+\Delta\boldsymbol z_k.
$$



- 问题所在：newtonPrinted特意把当前被更新量xNext与残差求值量xPrev分开：xNext−J⁻¹(g(xPrev)−τ)，忠实保留原页n+1/n的混用，未擅改为标准Newton。J为连续线性同构对应可逆矩阵，也容纳所述可逆近似矩阵。原书的线性求解重写与该公式代数等价；未提供该等价的Lean定理，但定义没有错误变更字面公式。原书索引及“可逆映射所以Jacobian非奇异”的理由另须人工处理。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。 网站原文审校另记：原页确实混用z_(n+1)与z\_n的Newton迭代索引；此外可逆函数本身不能保证导数可逆。忠实版不改公式，原书疑误交人工。
- 反例或理由：实函数x↦x³是连续可逆光滑映射，但在0的导数为0；因此仅凭映射可逆不能推出Jacobian非奇异。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.newtonPrinted`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.newtonPrinted_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原页确实混用z_(n+1)与z\_n的Newton迭代索引；此外可逆函数本身不能保证导数可逆。忠实版不改公式，原书疑误交人工。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.newtonPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 19. MD-2.4.5-ConjugateLimits

- source\_id：MD-2.4.5-ConjugateLimits。

### MD-2.4.5-ConjugateLimits

- 印刷页 / PDF页：88 / 110。
- 原文引文（逐字）：

> If $`A`$ and $`B`$ are maps of phase space, then the conjugacy implies that they have equivalent stability properties under iteration, since if $`B^n(\boldsymbol z_0)\to\boldsymbol z^*`$, as $`n\to\infty`$, for all initial points $`\boldsymbol z_0`$, then also $`A^n(\boldsymbol z_0)\to\chi^{-1}(\boldsymbol z^*)`$.

- 问题所在：展开 textbookConjugateMap 后，签名的具体收敛命题忠实：先固定共同极限zStar，再假设∀z，B^[k] z→zStar，最后∀z，A^[k] z→χ⁻¹zStar。B轨道应从χ z出发；全称hB使这一换初值合法。ProcessedMethods.lean 的 textbook\_conjugate\_iterates\_tendsto\_iff（合集:1672附近）确实给对应初值和对应极限的双向收敛，并利用χ及χ⁻¹的连续性。所有实际用到的项目定义已找到，缺的不是库定义。需要数学判断的原文问题是 statement\_scope 中“equivalent stability properties under iteration”是否只指随后给出的全局共同极限例子，还是还要求一般Lyapunov稳定性、吸引性等性质的双向等价；签名仅明确形式化随后例子的单向结论，没有这些一般稳定性谓词。若来源范围只限该例子可判PASS；若包含一般稳定性断言则缺条款。无[ERRATUM?]；本地与所引收敛定理均无sorry。 网站原文审校另记：
- 反例或理由：未单列反例；问题在原文省略资格、术语、证明步骤或覆盖范围。请结合原句及下列修正核查。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.conjugateLimits`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.conjugateLimits_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：明确原文“equivalent stability properties”的数学范围；若包含一般稳定性，给出所需稳定性定义并添加对应点处的双向等价；若只形式化全局共同极限例子，明确缩小statement\_scope。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.conjugateLimits。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 20. MD-2.5.1-RKSymplectic

- source\_id：MD-2.5.1-RKSymplectic。

### MD-2.5.1-RKSymplectic

- 印刷页 / PDF页：89–90 / 111–112。
- 原文引文（逐字）：

> Let us emphasize that, while a typical RK method is not symplectic, some implicit Runge-Kutta methods are symplectic. The precise condition that must be satisfied [325] is

$$
b_i a_{ij}+b_j a_{ji}=b_i b_j,\qquad i=1,\ldots,s,\quad j=1,\ldots,s.
$$



- 问题所在：已展开依赖：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ，textbookJ=[[0,I],[-I,0]]；Hamilton向量场为J乘以实际fderiv的坐标梯度；textbookJacobian为实际fderiv矩阵，IsTextbookSymplecticMap为C¹且每点D Gᵀ J D G=J（deps:33–42,138–139,238–241,272–275,1921–1926）。 Ch02:1239–1248确实断言系数条件与所有维度、Hamilton量、实h及C¹实际求解映射/阶段的辛性等价；正则性[EXTRA]适于充分性，却不能修复对可约方法的必要性。正式deps:3230–3240只给充分性，不能替代Blueprint中的更强iff。无条件逆向为假，原条NECESSITY\_QUALIFICATION疑误已由展开语义下的明确反例确认。 本声明在Ch02.lean中以sorry结束；这里只审计签名语义，未作Lean编译或证明通过判断。 网站原文审校另记：
- 反例或理由：取s=2、A=0、b=(1,−1)。对任何n,H,h和满足关系的阶段，两阶段均等于X\_H(z)，输出必为G(z)=z。因此右侧普适命题成立：恒等映射C¹且Jacobian=I，IᵀJI=J。左侧i=j=0时为0=1，失败。即使补一致性也不足：A四项均1/4、b=(1,0)，重复阶段化为中点法而系数条件在首个对角项为1/2=1。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.rkSymplectic`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：保留系数条件的充分方向，删除对可约Butcher表不成立的必要性；未建设不可约表理论。；`MD.Ch02.rkSymplectic_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“保留系数条件的充分方向，删除对可约Butcher表不成立的必要性；未建设不可约表理论。”。
- 导师选项：将本声明改为系数条件⇒普适辛性；若保留必要性，加入精确定义并验证的不可约资格，或在等价约简后的RK表上表达。保留原书必要性资格疑误，不以sorry掩盖反例。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.rkSymplectic。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 21. MD-2.5.1-GaussFamily

- source\_id：MD-2.5.1-GaussFamily。

### MD-2.5.1-GaussFamily

- 印刷页 / PDF页：90 / 112。
- 原文引文（逐字）：

> The Gauss-Legendre family of Runge-Kutta (GLRK) methods correspond to approximating the vector field at the Gauss points, i.e. the zeros of the orthogonal polynomials that arise in Gaussian quadrature. As these points are symmetrically distributed the GLRK schemes are symmetric, hence have even order.

- 问题所在：已展开Q=Fin n→ℝ、rungeKuttaRelation的实际阶段/输出方程（deps:2816,2900–2902），legendreValue按P₀=1、P₁=x及标准三项递推给出P\_s（3241–3244）；lagrangeBasis为∏_{k≠j}(t−c\_k)/(c\_j−c\_k)（3245–3246）。s>0、节点单射和P\_s(2c\_i−1)=0准确给出移位Gauss节点，积分系数准确对应配点法。methodLocalOrder（deps:3183–3186）展开为∀z ∃C>0 ∃δ>0 ∀|h|<δ，‖G h z−F h z‖≤C|h|^(r+1)，常数可依赖z；它是至少r阶的局部误差上界，不是确切阶。 Ch02:1253–1264保留反向步对称性，但∃正偶r且上述上界不表达实际阶的偶性；任意至少三阶方法也满足r=2。另[EXTRA]所有实h、所有z的唯一阶段/输出及全时间真实流远强于通常局部适用条件，实质遗漏大量光滑标准GLRK应用，不能仅称必要资格。无显式ERRATUM标记；这两项是形式化范围和结论问题。 本声明在Ch02.lean中以sorry结束；这里只审计签名语义，未作Lean编译或证明通过判断。 网站原文审校另记：
- 反例或理由：范围反例：n=s=1、c=1/2、f(x)=x，精确流F(t,z)=e^t z全局光滑。h=2,z≠0时阶段方程K=z+K无解，因而被全实h的唯一可解前提排除；这不是条件定理为假的反例。结论缺失：methodLocalOrder是下界，未加入¬methodLocalOrder G F (r+1)，无法得到确切阶为偶数。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.gaussFamily`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.gaussFamily_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：在小步长且状态局部邻域内定义唯一阶段、步映射及流，确保反向步在域内；对称性在该域陈述。若要确切阶偶性，加入最高有限阶资格并证明Even r（精确方法需单独处理）；或明确改成偶数阶下界/标准GLRK至少2s阶，并标明与原文确切阶表述的区别。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.gaussFamily。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 22. MD-2.5.3-NewmarkReduction

- source\_id：MD-2.5.3-NewmarkReduction。

### MD-2.5.3-NewmarkReduction

- 印刷页 / PDF页：92 / 114。
- 原文引文（逐字）：

> For $`\eta=0`$ we then arrive at the Verlet method.

- 问题所在：Ch02.lean:1337–1339全称量化n、m、F、h、z、w，固定σ=1/2、η=0，断言关系与w=verlet的双向等价。已展开Ch02\_deps.txt:2923–2925：newmarkRelation确为缺力项质量因子的字面关系，未调用2926–2929的质量修正版。2859–2861的verlet则令Q=q+h invMass(m,p)+(h²/2)invMass(m,F(q))，P=p+(h/2)(F(q)+F(Q))。两种位置公式一般不相同，故原句的一般质量解释及当前Lean全称签名均为假，[ERRATUM?]成立。无[EXTRA]，质量正性也不能修复它。“仅M=I”只适用于对所有力和初值的普遍方法等价，不能排除特殊力或轨道的巧合。该定理体含sorry，签名失败由展开定义后的反例确定，不以sorry为判据。 网站原文审校另记：
- 反例或理由：n=1；m(0)=2；F(q)(0)=1（来自光滑势能U(q)=-q(0)）；h=1；z=(0,0)；w=(1/2,1)，各数视作单坐标向量。newmarkRelation m F (1/2) 0 h z w为真；invMass m F=1/2，verlet m F h z=(1/4,1)，因此右侧为假。质量严格为正。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.newmarkReduction`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：采用显式质量一致Newmark关系，再与Verlet对应；原漏质量公式及反例保留。；`MD.Ch02.newmarkReduction_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“采用显式质量一致Newmark关系，再与Verlet对应；原漏质量公式及反例保留。”。
- 导师选项：保留原书字面错误及反例，不将该一般质量假命题作为待证明定理。有效修订可把质量限制为m≡1（对应deps:3280–3282的newmarkPrintedReduction\_statement），或明确改用newmarkMassCorrected（对应3277–3279），并标为对原书公式的修订。仅增加positiveMass不足。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.newmarkReduction。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 23. MD-2.5.3-NewmarkNotSymplectic

- source\_id：MD-2.5.3-NewmarkNotSymplectic。

### MD-2.5.3-NewmarkNotSymplectic

- 印刷页 / PDF页：92 / 114。
- 原文引文（逐字）：

> The implicit Newmark methods are not symplectic, but a related family of symplectic methods can be constructed by replacing interpolated forces by forces evaluated at interpolated positions [395].

- 问题所在：Ch02.lean:1353–1358；以原样沿用json\_review中的校正文句为审计对象。已展开Ch02\_deps.txt:33的SymplecticCoordinates 1=(Fin 1⊕Fin 1)→ℝ、2936的unpack z=(z∘Sum.inl,z∘Sum.inr)、583–585的textbookPotentialForce U q i=-(fderiv ℝ U q)(Pi.single i 1)，以及2926–2929的newmarkMassCorrected。m≡1时invMass为恒等，故关系确与字面Newmark一致。238–242的textbookJacobian使用真实fderiv，272–275的IsTextbookSymplecticMap要求C¹且所有点的Jacobian满足138–139的AᵀJA=J，J由39–40定义为[[0,I],[-I,0]]。签名存在量化U、β、h、G，再同时要求C³势能、β≠0、h≠0、C¹全局求解、所有初值满足更新及非辛性；已有C¹，故非辛性真正意味着某点Jacobian不保持J。[EXTRA]单位质量、非零参数及一个实际反例可合理见证该方法并非普遍辛；全局求解是额外构造负担，不能代表所有隐式参数。注释声称非线性势能，但签名没有显式非线性谓词（该描述不应当作已明示假设）。决定性缺失是原句第二子句：通过以插值位置处的力替换插值力构造相关辛方法族。现有签名完全没有该族的构造或辛性结论，故整体FAIL。无[ERRATUM?]；定理体含sorry与此语义缺失分开。 网站原文审校另记：
- 反例或理由：缺失结论条款：a related family of symplectic methods can be constructed by replacing interpolated forces by forces evaluated at interpolated positions。存在一个非辛Newmark求解映射不会给出任何相关辛方法族或其构造。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.newmarkNotSymplectic`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.newmarkNotSymplectic_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留现有实际非辛反例为第一部分，补充相关方法族的插值位置、力评估更新关系、适用参数和求解存在/正则条件，并断言其辛性；必要时用两项声明共同覆盖本source\_id。不能把第一部分反例当作第二部分构造。若注释需要声明非线性，补精确谓词或给出具体非线性势能。无需修改本轮只读附件。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.newmarkNotSymplectic。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 24. MD-2.5.4-TIForce / MD-2.5.4-TIOrder / MD-2.5.4-TIPotential

- source\_id：MD-2.5.4-TIForce；MD-2.5.4-TIOrder；MD-2.5.4-TIPotential。

### MD-2.5.4-TIForce

- 印刷页 / PDF页：93 / 115。
- 原文引文（逐字）：

> The forces arising from such a modified potential can be worked out:

$$
\tilde F=-\nabla\tilde U=-\left[I+\frac{h^2}{12}U''M^{-1}\right]\nabla U,
$$


> where $`U''`$ is the Hessian matrix of the potential.

- 问题所在：展开依据：Ch02\_deps.txt:2816、2840、2932–2934、2948，Ch02.lean:1371–1376。量词覆盖所有 n,m,U,h,q；positiveMass 是逐坐标 m\_i>0，ContDiff ℝ 2 U 保证真实二阶导数及 Hessian 对称性；fderiv ℝ (grad U) q 对 invMass m (grad U q) 的作用是 Hess(U)M⁻¹∇U。实际改势含负号，其负梯度必须为 −∇U+(h²/12)Hess(U)M⁻¹∇U，签名却取减号。它逐字保留了原书力式，却与其所调用的实际改势矛盾并成为假定理，因此不能作为可证明的忠实数学陈述通过。ERRATUM? 成立。EXTRA 中 C² 是充分且合理的统一光滑性条件（强于某一点有二阶导数）；正质量保证教材机械质量可逆，但纯代数恒等式只需各质量非零，故是物理上合理而非最弱必要条件。签名体有 sorry，证明状态独立于已经确定的语义失败。 网站原文审校另记：
- 反例或理由：用已经展开的真实定义取 n=1，m(0)=1，U(q)=(q 0)²/2，h=1，q 0=1。grad U(q)=q，fderiv(grad U) 是恒等映射，invMass 为恒等，tildeU(q)=11(q 0)²/24。因此等式左侧的第0分量=−11/12，右侧=−1−1/12=−13/12；正质量与 C² 全部满足。此为依赖定义下的数学反例，未编写或检查 Lean 反例证明。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.tiForce`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：保留负号改势，负梯度力修正项应为加号；未改原书展示式。；`MD.Ch02.tiForce_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“保留负号改势，负梯度力修正项应为加号；未改原书展示式。”。
- 导师选项：保留原书字面转录和 ERRATUM 说明；另将可证明的 tiForce 右端改成 −grad U q + (h²/12) • (fderiv ℝ (grad U) q) (invMass m (grad U q))。若决定采用教材力式的减号修正，则必须另建加号改势版本，并同步修改方法及阶数陈述，不能只改本条注释。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.tiForce。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-2.5.4-TIOrder

- 印刷页 / PDF页：93 / 115。
- 原文引文（逐字）：

> This method can be shown to have effective order four, meaning that there is a change of variables $`\chi_h`$ which can be used to transform the Takahashi-Imada method into one of order four using the processing technique of Sect. 2.4.5. The potential energy modification has been specifically chosen to annihilate terms in the local error expansion (after coordinate transformation).

- 问题所在：全部使用定义已找到：Q/Z、grad、invMass、verlet、takahashiPotential、solution、mechanicalField、positiveMass 见 Ch02\_deps.txt:2816–2817、2840、2859–2861、2932–2934、2941–2948；oneStepIterate/oneStepMaxError 见1444–1463；textbookConjugateMap/textbookProcessedMethod 见 ProcessedMethods 段（用原始行编号1649、1690定位，段中有额外 CR）。solution 是闭区间每点 HasDerivWithinAt γ (f(γ t))，mechanicalField=(M⁻¹p,−∇U(q))，所以是原机械轨迹。HasDerivWithinAt 已蕴含区间内连续，显式 ContinuousOn γ 冗余但合理。处理映射确为 χ\_h⁻¹∘B\_h∘χ\_h，迭代从 γ(0) 开始，等价于先 χ\_h 预处理、迭代真实 B\_h、再逆变换；误差是网格 0,…,ν 上完整位置/动量乘积范数最大值，不是单步误差。量词 χ 在 γ,τ 之前，C,ν₀ 在其之后，保证统一处理器而允许误差常数依赖轨迹与时间窗，ν₀>0 排除零分母，均合理。正固定对角质量与 U C∞ 是足够光滑的背景条件，C∞ 并非四阶所需最弱条件。失败依据是结论范围与处理器条件：原文还明确说坐标变换后局部误差展开项被消去，签名只有全局四阶界，没有局部五阶缺陷或消项断言；它对任意光滑势能要求整个 Z n 上的 Homeomorph，强于通常在轨迹邻域的变量变换，却完全不要求 χ\_h 光滑、随 h 正则或趋于恒等，无法承载所引用的局部误差展开。这个无正则性的全局共轭存在性不能直接等同于原文有效阶陈述。DEPENDENT\_ERRATUM 所指来源符号冲突确实存在，但不能只据冲突断言负号版本无有效四阶；下方谐振子计算说明这一限制。这里不声称签名允许的任意不规则 Homeomorph 都不存在；本条 FAIL 已由上述具体缺失条款和不合理强化成立，无须借缺依赖写 NEEDS\_HUMAN。定理体为 sorry，未验证其证明。 网站原文审校另记：
- 反例或理由：局部有效阶的符号障碍：n=1，m=1，U(q)=q²/2。实际负号改势使弹簧系数 a=1−h²/12。Verlet 矩阵为 [[1−h²a/2,h], [−ha(1−h²a/4),1−h²a/2]]，行列式1，特征角满足 cos θ=1−h²/2+h⁴/24。因此 θ=h+h⁵/720+O(h⁷)，负号在此谐振子上反而消去 h³ 相位缺陷：谐振子不能用作负号版本二阶的反例。真正已确定的缺失条款是：签名没有处理器光滑性/近恒等条件及变换后局部误差项消去结论，且全局 Homeomorph 强化未获原段支持。不把原书力式与改势的冲突自动当作本定理必假的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.tiOrder`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch02.tiOrder_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：首先明确本条选择负号改势（与 TIPotential 一致）还是加号改势（与原书力式一致），保留来源冲突说明。将有效阶精确定义为在每条紧轨迹邻域存在随步长足够光滑、近恒等且局部可逆的处理器；补上经过共轭后相对原机械精确流的局部 O(h⁵) 缺陷或明确的低阶消项结论，并给出稳定性以导出当前全网格 O(h⁴) 界。若确需整个相空间 Homeomorph，必须另列并论证全局延拓条件，不能将其当作原文已经给出的假设。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.tiOrder。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-2.5.4-TIPotential

- 印刷页 / PDF页：92–93 / 114–115。
- 原文引文（逐字）：

> the Takahashi-Imada method [355] (also known as Rowlands’ method [316]) has the same form as the Verlet method

$$
\hat{\boldsymbol P}=\boldsymbol p-(h/2)\nabla\tilde U(\boldsymbol q),\quad\boldsymbol Q=\boldsymbol q+hM^{-1}\hat{\boldsymbol P},\quad\boldsymbol P=\hat{\boldsymbol P}-(h/2)\nabla\tilde U(\boldsymbol Q),
$$


> where the corresponding potential energy function is

$$
\tilde U(\boldsymbol q)=U(\boldsymbol q)-\frac{h^2}{24}\nabla U(\boldsymbol q)^TM^{-1}\nabla U(\boldsymbol q).
$$



- 问题所在：逐项展开定义：n∈ℕ，m:Fin n→ℝ，U:Q n→ℝ，h∈ℝ，输入输出均为位置/动量对Z n。takahashiPotential中的减号、1/24、h²及Σ\_i(∂_iU)²/m\_i，与原页在M=diag(m\_i)时的改势完全一致；tiMethod使用该改势的负梯度。令F=−grad Ũ，verlet的位置为q+h M⁻¹p+(h²/2)M⁻¹F(q)，等于原页用p̂=p+(h/2)F(q)所得q+hM⁻¹p̂；输出动量为p+(h/2)(F(q)+F(Q))，等于p̂+(h/2)F(Q)。故没有半步系数或力号的转录错误。但本定义忠实于原页负号改势，并不同时满足紧随的正号括号力式；按要求将原书数学疑误交人工，不静默修复。另需人工确认M的对角质量约定：此签名没有一般矩阵参数；m也没有正性/非零约束，U没有可微性约束，故只能把物理方法理解为限制到非零（通常正）质量和足够光滑势的使用域。Lean在零质量或不可微势处的总函数扩展不构成原书物理含义。无\_corrected/_counterexample声明可供另审；没有[EXTRA]说明来补充上述使用域。 网站原文审校另记：原文摘录本身忠实：改势确为减号，不能根据后续力式静默改成加号。原书同页力式与之不相容，需人工裁定。；原文写M及M⁻¹，当前摘录未明确M仅为对角矩阵；Lean仅提供逐坐标质量m。应明确这是对角质量矩阵情形，不能无说明声称覆盖任意质量矩阵。
- 反例或理由：说明原书两式冲突的精确一维例子（并非反驳字面负号定义）：m=1，U(q)=q²/2，则Ũ(q)=(1/2−h²/24)q²，因而−∂q Ũ=−(1−h²/12)q；原页后续力式给−(1+h²/12)q。取h=1、q=1，二者分别为−11/12与−13/12。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.tiMethod`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：选择原负号改势路线，物理包装明示正质量和C²势；力式修正的加号在TIForce\_corrected中另列。；`MD.Ch02.tiMethod_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“选择原负号改势路线，物理包装明示正质量和C²势；力式修正的加号在TIForce\_corrected中另列。”。
- 导师选项：保留当前负号字面版；人工决定是否另建明确命名的勘误版：保留负号改势则力式括号应为I−(h²/12)U″M⁻¹；保留原力式则改势应改为加号（对称常质量矩阵、光滑势下）。同时在context\_notation明确M=diag(m\_i)、m\_i>0及势的光滑使用域；若要覆盖任意对称正定M，需另用矩阵逆和二次型定义，不能将当前逐坐标版本视为一般矩阵版。不在本任务修改工程或补证明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch02.tiMethod。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 25. MD-2.5.5-BeemanOrder

- source\_id：MD-2.5.5-BeemanOrder。

### MD-2.5.5-BeemanOrder

- 印刷页 / PDF页：94 / 116。
- 原文引文（逐字）：

> The order of accuracy of the scheme above can be shown to be three.

- 问题所在：已展开正式依赖：Q、Z、mass、invMass 如上一项；positiveMass m = ∀ i, 0<m i；mechanicalField m F (q,p) = (invMass m p,F q)；solution f γ 0 τ = ∀ t∈Icc 0 τ, HasDerivWithinAt γ (f(γ t)) (Icc 0 τ) t（合集行2941–2948）。因此 γ 确实是位置/动量的机械ODE解。Ch02.lean 行1402–1410 的量词依次为 n,m,F,γ,τ、全部假设、统一 C>0 和 ν₀>1、所有 ν≥ν₀、所有满足 z0=γ0、z1=γh 和 k≥1 多步递推的 z、所有 k≤ν；Z 的积范数控制两坐标，而不是只控制位置或终点。没有遗漏展示的误差子句，也没有把数值序列替换成独立单步映射。[EXTRA] 正固定对角质量合理；F 全空间 C⁴ 是足够但较强的平滑性限制，不是阶性质必需的最弱假设；τ>0 与 ν₀>1 保证有效网格和两点启动；闭区间连续由 solution 的逐点相对可导性已蕴含，冗余但合理，并给出紧轨迹；精确两点启动强于通常 O(h³) 启动，合理作为理想启动测试，但只是原句的受限版本。即使在这些强假设下全状态 O(h³) 结论仍为假，见解析反例。因此该签名虽保留原文 three 的全局阶解释，不能作为正确、无疑误的原文正式对应判 PASS。[ERRATUM?] 在这里明确的固定时间窗全局阶解释下成立；原书可能使用其他阶概念的问题不妨碍否定这个具体签名。原批所述单步动量 −h³/12 首项仅是局部缺陷，单凭它不能推出全局失败；下面直接证明非零全局 O(h²) 位置误差。该声明末尾 by sorry，未完成证明；FAIL 根据签名的数学反例作出，与 sorry 分开。 网站原文审校另记：
- 反例或理由：取 n=1、m₀=1、F(q)=−q、γ(t)=(cos t,−sin t)、τ=π/2。F 为 C∞，质量正，γ 满足全部ODE和连续性假设。对每个 ν≥2 令 h=τ/ν，z0=γ0，z1=γh，并按实际 beeman 递推构造所有后续状态。记 q\_k,p\_k 为数值坐标：q_{k+1}=(1−2h²/3)q\_k+h p\_k+(h²/6)q_{k−1}，p_{k+1}=p\_k−(h/6)(2q_{k+1}+5q\_k−q_{k−1})。在状态 (q\_k,p\_k,q_{k−1}) 上的转移矩阵为 [[1−2h²/3,h,h²/6],[−7h/6+2h³/9,1−h²/3,h/6−h³/18],[1,0,0]]，特征多项式 λ[λ²−(2−h²)λ+1]。直接消元可得 q_{k+1}−(2−h²)q\_k+q_{k−1}=0（k≥2）。初值 q1=cos h，q2=(1−2h²/3)cos h−h sin h+h²/6。令 θ=2 arcsin(h/2)，A=(2−h²)q1−q2=(1−h²/3)cos h+h sin h−h²/6，B=(cos h−A cos θ)/sin θ，则所有 k≥1 有 q\_k=A cos(kθ)+B sin(kθ)。泰勒展开给出 A=1+h⁴/24+O(h⁶)、B=O(h⁵)、θ=h+h³/24+O(h⁵)。所以 νθ=τ+τ h²/24+O(h⁴)，qν−cos τ=−(τ sin τ/24)h²+O(h⁴)=−π h²/48+O(h⁴)。于是 |qν−cos τ|/h³→∞。积范数至少为该位置绝对误差，任何与 ν 无关的 C 都不能满足结论。这是满足所有假设的解析反例，不依赖数值实验或未证明的 Lean 引理。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch02.beemanOrder`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：全相空间有限时间收敛修正为二阶；原three的其它阶概念待导师，二阶正向估计尚需证明。；`MD.Ch02.beemanOrder_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“全相空间有限时间收敛修正为二阶；原three的其它阶概念待导师，二阶正向估计尚需证明。”。
- 导师选项：保留原文 three 及其 json\_review，不静默改书。将当前 beemanOrder 标记为在全相空间全局阶解释下有反例的待纠错陈述，不应尝试证明该假命题。若另立修订命题，可将误差上界中的指数3改为2，并明确标注这是对全局相空间阶的修正；二阶正向收敛仍需独立证明，反例本身只否定三阶。若坚持保留 three，必须先明确并另外定义原书所指的阶概念，再建立对应命题，不能沿用当前全网格、全状态 O(h³) 签名。无需修改 Beeman 更新公式。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch02.beemanOrder。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

