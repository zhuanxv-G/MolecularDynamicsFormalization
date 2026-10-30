# 第4章原书疑误与双版本审阅单

教材：B. Leimkuhler 与 C. Matthews，Molecular Dynamics: With Deterministic and Stochastic Numerical Methods，Springer，2015。
页码采用原PDF从1起算的物理页。以下为工作勘误及资格补充，尚未经导师或作者裁定。定义、原有正确的数学子句和原书字面疑误分别保留；编译通过不表示未证命题已经成立。
原文引文沿用已逐页核对的来源记录；本轮网站返回保留其原有版本及判定。原有声明可能已经是限定解释或修正版，须按网站正文确定PASS的对象；本轮新增或修改版本均未再次送网站。
共26项问题，涉及46个source\_id。同一问题的多条来源已合并；各来源原文、版本和网站判定仍分别列出。

## 1. MD-4-PRKThreshold

- source\_id：MD-4-PRKThreshold。

### MD-4-PRKThreshold

- 印刷页 / PDF页：140 / 162。
- 原文引文（逐字）：

> Among explicit symplectic Partitioned Runge-Kutta methods this is the maximum stability threshold [74].

- 问题所在：已展开 Ch04\_deps.txt 中 MolecularDynamics/Chapter04/ReviewDefinitions.lean 的正式定义：matrixStable(A)=∃C∈ℝ,∀k∈ℕ,∀v∈ℝ², ‖A^k v‖≤C‖v‖，是统一幂有界而不是仅谱模≤1；symplecticEulerMatrix(Ω,h)=[[1-h²Ω²,h],[-hΩ²,1]]；verletMatrix(Ω,h)=[[1-h²Ω²/2,h],[-hΩ²(1-h²Ω²/4),1-h²Ω²/2]]。 prkOscillatorRelation 展开为 qᵢ=z₀+hΣⱼAᵢⱼpⱼ，pᵢ=z₁-hΩ²ΣⱼBᵢⱼqⱼ，out₀=z₀+hΣᵢbᵢpᵢ，out₁=z₁-hΩ²Σᵢcᵢqᵢ。签名全称量化任意级数s和系数；一致性、辛条件及A严格下三角/B下三角均未限制子步数或成本。将“最大阈值”编码为任意稳定步长均≤2更强，且本方法类内已有反例。此判断无需缺失定义或查阅[74]。实际声明含sorry，另记为未完成证明。 网站原文审校另记：
- 反例或理由：s=2，b=c=(1/2,1/2)，A=[[0,0],[1/2,0]]，B=[[1/2,0],[1/2,1/2]]，G(Ω,h)=S(Ω,h/2)^2（S为symplecticEulerMatrix）。全部系数和、辛关系和三角条件成立，阶段关系有唯一解。Ω=1,h=3时G=[[7/16,-3/8],[3/8,1/4]]，det G=1，trace G=11/16，两个不同单位圆复根，故matrixStable(G)，但|hΩ|=3>2。实际上连通内区间为0<hΩ<4。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.prkThreshold`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：删除一般多级PRK的普遍阈值2，只给反例所用两个半步辛Euler的实际稳定区0<hΩ<4；未对所有PRK给新的最优阈值。；`MD.Ch04.prkThreshold_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“删除一般多级PRK的普遍阈值2，只给反例所用两个半步辛Euler的实际稳定区0<hΩ<4；未对所有PRK给新的最优阈值。”。
- 导师选项：删除或明确标记当前泛化为错误；先核实原书[74]中是否按级数/力计算成本归一化或限制方法类，再据真实限制重写阈值定义及结论；不能只补证明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.prkThreshold。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 2. MD-4-SymplecticEulerBoundaryPrinted / MD-4-VerletBoundaryPrinted / MD-4-VerletStability / MD-4-SymplecticEulerUnitRoots / MD-4-SymplecticEulerStability

- source\_id：MD-4-SymplecticEulerBoundaryPrinted；MD-4-VerletBoundaryPrinted；MD-4-VerletStability；MD-4-SymplecticEulerUnitRoots；MD-4-SymplecticEulerStability。

### MD-4-SymplecticEulerBoundaryPrinted

- 印刷页 / PDF页：140 / 162。
- 原文引文（逐字）：

> if $`h\Omega\le2`$ the integrator is stable.

- 问题所在：已展开 Ch04\_deps.txt 中 MolecularDynamics/Chapter04/ReviewDefinitions.lean 的正式定义：matrixStable(A)=∃C∈ℝ,∀k∈ℕ,∀v∈ℝ², ‖A^k v‖≤C‖v‖，是统一幂有界而不是仅谱模≤1；symplecticEulerMatrix(Ω,h)=[[1-h²Ω²,h],[-hΩ²,1]]；verletMatrix(Ω,h)=[[1-h²Ω²/2,h],[-hΩ²(1-h²Ω²/4),1-h²Ω²/2]]。 Ω>0和h>0是频率/步长背景的合理显式假设；≤2忠实保留印刷端点，但将稳定解释成matrixStable使印刷断言为假。[ERRATUM?]端点反例成立。忠实保留错误原句与数学真伪分别记录；声明含sorry，不能视作已证明。 网站原文审校另记：
- 反例或理由：Ω=1,h=2：S=[[-3,2],[-2,1]]=-I+N，N=[[-2,2],[-2,2]]，N²=0。对v=(1,0)，S^k v=(-1)^k(1+2k,2k)，范数无界。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.symplecticEulerBoundaryPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。；`MD.Ch04.symplecticEulerBoundaryPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。”。
- 导师选项：原文≤2单独保存并标为错误；正确幂有界定理用0<hΩ<2（Ω,h>0），或将含端点结论明确改为谱模为1的结论。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.symplecticEulerBoundaryPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4-VerletBoundaryPrinted

- 印刷页 / PDF页：141 / 163。
- 原文引文（逐字）：

> the numerical solution stays bounded for all time) provided $`h\Omega\le2`$

- 问题所在：已展开 Ch04\_deps.txt 中 MolecularDynamics/Chapter04/ReviewDefinitions.lean 的正式定义：matrixStable(A)=∃C∈ℝ,∀k∈ℕ,∀v∈ℝ², ‖A^k v‖≤C‖v‖，是统一幂有界而不是仅谱模≤1；symplecticEulerMatrix(Ω,h)=[[1-h²Ω²,h],[-hΩ²,1]]；verletMatrix(Ω,h)=[[1-h²Ω²/2,h],[-hΩ²(1-h²Ω²/4),1-h²Ω²/2]]。 Ω>0和h>0是频率/步长背景的合理显式假设；≤2忠实保留印刷端点，但将稳定解释成matrixStable使印刷断言为假。[ERRATUM?]端点反例成立。忠实保留错误原句与数学真伪分别记录；声明含sorry，不能视作已证明。 网站原文审校另记：
- 反例或理由：Ω=1,h=2：V=[[-1,2],[0,-1]]=-I+N，N²=0。对v=(0,1)，V^k v=(-1)^k(-2k,1)，范数无界。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.verletBoundaryPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。；`MD.Ch04.verletBoundaryPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。”。
- 导师选项：原文≤2单独保存并标为错误；正确幂有界定理用0<hΩ<2（Ω,h>0），或将含端点结论明确改为谱模为1的结论。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.verletBoundaryPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4-VerletStability

- 印刷页 / PDF页：141 / 163。
- 原文引文（逐字）：

> For example, applying the Verlet method to the harmonic oscillator with frequency $`\Omega`$ we find that the origin is stable (and the numerical solution stays bounded for all time) provided $`h\Omega\le2`$ (the same condition as for stability of Symplectic Euler).

- 问题所在：两个签名分别为 0<|hΩ|<2 时的矩阵幂有界和任意 Ω 下 h=0 的幂有界；matrixStable 是同一 C 同时控制所有自然步数和所有实初值，非仅谱模≤1。verletMatrix 为实际速度Verlet矩阵。严格区间的正定二次型 p²+Ω²(1-h²Ω²/4)q²保持，h=0 为恒等矩阵，修订合理且陈述正确；PASS仅针对明示修订版，不认可原印≤端点。引用的 BoundaryPrinted 不在19条内，未据此宣称它已审。 网站原文审校另记：code：BOOK\_ENDPOINT\_ERRATUM；detail：原句确实印作 hΩ≤2 且声称所有时间有界；忠实转录，但端点陈述有数学疑误，保留原句。；code：CORRECTED\_SCOPE\_EXPLICIT；detail：修订版资格和原印断言不同，已明示且数学上合理；不以修订版PASS为原书背书。
- 反例或理由：Ω=1,h=2 时 Verlet 矩阵 A=[[-1,2],[0,-1]]。对 v=(0,1)，A^k v=((-1)^(k+1)2k,(-1)^k)，范数无界；原句 hΩ≤2 成立。此反例不反驳已明确的严格区间修订版。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.verletStability`（已证）；`MD.Ch04.verletStability_zero`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.verletStability_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留≤2原印文字及疑误标记；勘误版沿用0<|hΩ|<2与h=0分支，人工确认如何发表端点勘误。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch04.verletStability; MD.Ch04.verletStability\_zero。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4-SymplecticEulerUnitRoots

- 印刷页 / PDF页：140 / 162。
- 原文引文（逐字）：

> Then we observe that for $`h^2\Omega^2\le4`$, they are complex and their squared magnitude is

$$
|\lambda_{1,2}|^2=\left(1-\frac{h^2\Omega^2}{2}\right)^2+\frac14(4h^2\Omega^2-h^4\Omega^4)=1,
$$


> thus both eigenvalues lie on the unit circle in the complex plane as long as $`h\Omega\le2`$.

- 问题所在：∀Ω,h∈ℝ、∀ζ∈ℂ，在 h²Ω²≤4 及实际特征二次式为零的条件下 ‖ζ‖=1 正确，包括重根±1。借条目3明确连接到实际矩阵谱；未断言根非实、未把单位圆谱当幂有界。原模平方恒等式与该范数结论一致。 网站原文审校另记：code：BOOK\_NONREAL\_ENDPOINT\_AMBIGUITY；detail：不等式、模平方展开和末句均忠实。原文 they are complex 若指非实根，则在 h²Ω²=0、4 不成立；末句 hΩ≤2 依赖正步长正频率背景，任意实参数下须用绝对值。保留原句，交人工确认术语和隐含域。；code：IMPLICIT\_POSITIVE\_PARAMETER\_DOMAIN；detail：不等式、模平方展开和末句均忠实。原文 they are complex 若指非实根，则在 h²Ω²=0、4 不成立；末句 hΩ≤2 依赖正步长正频率背景，任意实参数下须用绝对值。保留原句，交人工确认术语和隐含域。
- 反例或理由：h=0 时根为1；hΩ=2 时根为-1，都不是非实数。若允许任意实hΩ，则hΩ=-3满足末句hΩ≤2却有一根模长>1；平方条件h²Ω²≤4不满足，故不反驳本条Lean。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.symplecticEulerUnitRoots`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.symplecticEulerUnitRoots_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原句，人工决定是否将非实解释限定为0<h²Ω²<4；一般实参数域的单位圆条件用|hΩ|≤2。现有Lean无需为此修改。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch04.symplecticEulerUnitRoots。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4-SymplecticEulerStability

- 印刷页 / PDF页：140 / 162。
- 原文引文（逐字）：

> This is the so-called linear stability condition of the Symplectic Euler method: if $`h\Omega\le2`$ the integrator is stable. When $`h\Omega\gt 2`$, the eigenvalues of the discretization method are both real, with one strictly inside and one strictly outside the unit circle. This implies that the method will exhibit exponentially growing solutions. We say that the stability threshold of the Symplectic Euler method is $`2/\Omega`$.

- 问题所在：首条在严格非零内区间给真实矩阵幂有界，在 2<|hΩ| 给实际复特征值在单位圆外。补充条要求 Ω>0，正步长稳定集合的实上确界为2/Ω；对任意超阈值 h，存在两个实根 a,b，0<|a|<1<|b|，完整谱等价式排除遗漏，并存在非零实初值满足所有 k 的 A^k v=b^k v。该精确轨道足以推出指数增长，不是仅有谱断言。修订范围和正频率条件已明示，陈述正确；PASS不认可原印端点。BoundaryPrinted 未随本任务给出，不纳入已审结论。 网站原文审校另记：code：BOOK\_ENDPOINT\_ERRATUM；detail：整段逐句一致；hΩ≤2 的端点稳定性有疑误，原文保留。；code：CORRECTED\_SCOPE\_EXPLICIT；detail：修订版资格和原印断言不同，已明示且数学上合理；不以修订版PASS为原书背书。
- 反例或理由：Ω=1,h=2 时 A=[[-3,2],[-2,1]]=-I+N，N=[[-2,2],[-2,2]]≠0且N²=0。对v=(1,0)，A^k v=(-1)^k(1+2k,2k)，无界。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.symplecticEulerStability`（已证）；`MD.Ch04.symplecticEulerStability_complete`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.symplecticEulerStability_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原印段落；勘误版继续严格稳定区间，阈值2/Ω理解为正步长稳定集合上确界，不宣称上确界处稳定。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch04.symplecticEulerStability; MD.Ch04.symplecticEulerStability\_complete。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 3. MD-4.1-ActualMidpointRelation / MD-4.1-PrintedImplicitRelation

- source\_id：MD-4.1-ActualMidpointRelation；MD-4.1-PrintedImplicitRelation。

### MD-4.1-ActualMidpointRelation

- 印刷页 / PDF页：142 / 164。
- 原文引文（逐字）：

> The Implicit Midpoint method which, for the ODE $`\dot z=f(z)`$ takes the form

$$
z_{n+1}=z_n+h\frac{f(z_n)+f(z_{n+1})}{2},
$$



- 问题所在：依赖摘录 MolecularDynamics/Chapter04/ReviewDefinitions.lean: Q n = Fin n → ℝ，Z n = Q n × Q n；向量运算逐坐标。 实际定义为 Z=z+h f((z+Z)/2)，而指定原页给的是 Z=z+(h/2)(f(z)+f(Z))。[EXTRA] 已坦陈这是另行更正候选，合理用于比较，但不使其成为原页忠实陈述。定义无 sorry。 网站原文审校另记：
- 反例或理由：取 n=1，f(x)=x²，z=0，Z=2，h=1：印刷式为 2=(0+4)/2，成立；实际中点式要求 2=1，不成立。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.actualMidpointRelation`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.actualMidpointRelation_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：将此条明确标为更正候选，来源注明 PDF166 的机械中点背景；若要求忠实于 PDF164，则使用 printedImplicitRelation。不要覆盖原书疑误。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.actualMidpointRelation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.1-PrintedImplicitRelation

- 印刷页 / PDF页：142 / 164。
- 原文引文（逐字）：

> The Implicit Midpoint method which, for the ODE $`\dot z=f(z)`$ takes the form

$$
z_{n+1}=z_n+h\frac{f(z_n)+f(z_{n+1})}{2},
$$



- 问题所在：名称 printedImplicitRelation 标识字面版。∀维数、任意实向量场及实步长和两个实状态，关系 out=z+(h/2)(f(z)+f(out)) 正是原印梯形式，系数和端点函数值均正确。按任务只审忠实性，不要求把字面版改成真中点。 网站原文审校另记：code：BOOK\_METHOD\_NAME\_FORMULA\_MISMATCH；detail：原页确实把梯形更新式命名为 Implicit Midpoint，转录正确；保留疑误。
- 反例或理由：取f(x)=x²、h=1、z=0、out=2。原印梯形式2=0+(0²+2²)/2成立，真正中点式2=0+f((0+2)/2)=1不成立，说明两方法在非线性场上不同。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.printedImplicitRelation`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.printedImplicitRelation_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留Printed字面版；在注释中指明这是梯形法，真正中点另用out=z+h f((z+out)/2)，勿静默替换本字面声明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch04.printedImplicitRelation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 4. MD-4.1-PrintedModifiedFrequency / MD-4.1-ImplicitModulus

- source\_id：MD-4.1-PrintedModifiedFrequency；MD-4.1-ImplicitModulus。

### MD-4.1-PrintedModifiedFrequency

- 印刷页 / PDF页：143 / 165。
- 原文引文（逐字）：

> If the Implicit Midpoint method is viewed as the exact solution of a perturbed harmonic oscillator, then the frequency of this oscillator is

$$
\widehat\Omega=\frac1{ih}\ln\frac{1+ih\Omega/2}{1-ih\Omega/2}.
$$



- 问题所在：MD.Ch04.printedModifiedFrequency 展开为 (i h)⁻¹ * Complex.log factor，factor 的正式定义已查明。原文 ln 的分支未指定，这是需要裁定的原文问题，并非缺失项目定义。主支候选合理：有限实 x=hΩ/2 时 factor 的连续主相位为 2 atan x ∈ (-π,π)，与实频率解释相容；其他支给频率加 2πk/h。[EXTRA] 注释写 h≠0，但实际定义没有这一资格，Lean 总化逆元在 h=0 返回0；必须显式限制物理解读到非零步长。定义无 sorry。 网站原文审校另记：
- 反例或理由：分支 k 与0的频率相差 2πk/h（h≠0）；h=0 时 Lean 定义为0，而原式含 1/(ih)，未定义。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.printedModifiedFrequency`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.printedModifiedFrequency_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：裁定并记录原文 ln 采用连续于 h=0 的主相位解释；将来源等式的使用域明确设为 h≠0，并给与 2 atan(hΩ/2)/h 的桥接等式。若希望零步长连续延拓，应单独定义值 Ω。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.printedModifiedFrequency。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.1-ImplicitModulus

- 印刷页 / PDF页：142 / 164。
- 原文引文（逐字）：

> For all real $`\Omega`$, we find

$$
\left|\frac{1+ih\Omega/2}{1-ih\Omega/2}\right|=1.
$$


> This indicates that the Implicit Midpoint method has no stability threshold for the stepsize when solving a linear system!

- 问题所在：对任意实 Ω,h 的模长等式及任意复初值、自然步数的范数保持均正确，且涵盖零频率零步长。[EXTRA] 明确限定纯虚标量模态，足以表达当前振子无步长稳定阈值；不把它推广为任意线性系统有界性。原书泛称仍交人工，不以缩域签名静默消除疑误。 网站原文审校另记：code：BOOK\_LINEAR\_SYSTEM\_SCOPE\_AMBIGUITY；detail：公式和末句均忠实；末句 a linear system 若脱离纯虚振子背景会过强，保留原话并标注范围疑问。
- 反例或理由：若把原句解释为所有线性系统：z′=z的隐式中点因子(1+h/2)/(1-h/2)，h=1时为3，h=2时分母为0；甚至零谱Jordan系统z′=[[0,1],[0,0]]z也可有线性增长。两例均不在本条iΩ振子签名内。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.implicitModulus`（已证）；`MD.Ch04.implicitModulus_iterates`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.implicitModulus_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原句并由人工确认泛称范围；注释限于当前纯虚振子模态，不能宣称任意线性系统的所有轨道有界。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch04.implicitModulus; MD.Ch04.implicitModulus\_iterates。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 5. MD-4.2.1-RESPAStructure

- source\_id：MD-4.2.1-RESPAStructure。

### MD-4.2.1-RESPAStructure

- 印刷页 / PDF页：145 / 167。
- 原文引文（逐字）：

> Because $`U_F`$ requires small timesteps, we think of separating the calculation of a timestep, typically in a symmetric form.

- 问题所在：Ch04.lean 第412–416行量化 n、m、US、UF、r、h，要求所有 m\_i>0、US/UF 为 C²、r>0，然后结论为辛性与对所有 z 的 G_{−h}(G\_h(z))=z。所有依赖均已展开：Q n=Fin n→ℝ、Z n=Q n×Q n；dot u v=∑i u\_i v\_i；phaseForm(u,v)=dot(u.q,v.p)−dot(v.q,u.p)；symplecticMap G=∀z u v,phaseForm((fderiv ℝ G z)u,(fderiv ℝ G z)v)=phaseForm(u,v)。respa、kick、fastVerlet、Chapter02Review.verlet、invMass、grad→textbookConstraintGradient 分别是两次软势半 kick 包住 r 次快势 Verlet、p↦p−t∇U、实际坐标梯度及质量 drift，不是把保辛或可逆结论预先塞入定义。n 到 h 的量词顺序没有隐藏依赖，h 可为任意实数；C²保证实际梯度的 C¹ 及 Hessian 对称。[EXTRA] 正质量与 r>0 是合理的物理/算法资格，C² 是保辛的合理充分正则性；反步恒等式本身并不需要 C²，且作为代数映射的辛性也不严格需要质量为正，只需所用对角 drift 的适当解释。它们没有制造错误结论。FAIL 的原因是当前 statement\_scope 明定仅覆盖所引原句及展示公式，而第167页这句话只是对称分裂的动机，没有断言任意 C² 势、任意步长下的全局 Jacobian 辛性与恒等式。注释把第171页的辛性及算法名称合并，扩大了来源与结论范围；[EXTRA] 可以标明补充假设，但不能自动使两项额外结论成为当前冻结原句的忠实陈述。此外 G_{−h}∘G\_h=id 表示步长反号的自伴性；若 Reversible 专指 R(q,p)=(q,−p) 的动量反射可逆，还应显式交代 R∘G\_h∘R=G_{−h}。该具体算法在这些正则性条件下的保结构命题数学上合理，此 FAIL 是来源/范围不匹配，没有声称已找到数学反例。本条无 [ERRATUM?]。第416行存在 sorry，证明仍未完成；范围 FAIL 不以 sorry 为理由，亦不把 sorry 当作命题为假的证据。 网站原文审校另记：
- 反例或理由：未单列反例；问题在原文省略资格、术语、证明步骤或覆盖范围。请结合原句及下列修正核查。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.respaStructure`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.respaStructure_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：二选一修复来源对应关系：(1) 保持现有冻结原句，则仅把它登记为算法设计背景，不将 MD.Ch04.respaStructure 当作该句的忠实翻译；(2) 若保留现有保结构定理，则明确将当前 source\_id 的来源范围扩为第167页 (4.2) 算法及可逆标题、第171页 “just as with the MTS method ... remains symplectic” 的跨页声明，补列 printed/pdf 页码145/149、167/171，并标注这是据算法作出的精确化。若目标还包括动量反射可逆，增加并明示 R∘G\_h∘R=G_{−h}，不要把一般反步恒等式与该关系无说明地等同。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.respaStructure。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 6. MD-4.2.1-ResonanceEigenPrinted / MD-4.2.1-ResonanceTaylor

- source\_id：MD-4.2.1-ResonanceEigenPrinted；MD-4.2.1-ResonanceTaylor。

### MD-4.2.1-ResonanceEigenPrinted

- 印刷页 / PDF页：147 / 169。
- 原文引文（逐字）：

> For $`\varepsilon\lt 0`$, however, we have

$$
\lambda=-1\pm(|\varepsilon|/2)^{1/2}+O(\varepsilon).
$$



- 问题所在：已展开Ch04\_deps.txt中-- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean的slowMatrix、fastMatrix、impulseMatrix（原文件行4418–4421）；分别为[[1,0],[-h,1]]、[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]和S(h/2)F(Ω,h)S(h/2)，对象与原文(q,p)列向量一致。 原印刷(|ε|/2)^(1/2)确有系数错误，[ERRATUM?]成立：令t=h₀−h>0、a=π/Ω，则μ=−2−at+O(t²)，根为−1±sqrt(at)+O(t)，不是−1±sqrt(at/2)+O(t)。Lean保留了错误的正支近似，任何根都不能满足该O(t)误差。另外原±两支均需刻画，签名只存在一根。Ω>0合理；先∃C,δ后∀h正确，但不能救错误系数。实际文件含sorry；FAIL由假命题及缺支造成，非因sorry。 网站原文审校另记：
- 反例或理由：固定Ω=1、h=π−t，t↓0。两根r±满足(r±+1)/sqrt(t)→±sqrt(π)。目标正支为sqrt(πt/2)，故任一根与目标的差除以t均无界；正支差的首项是(1−1/sqrt(2))sqrt(πt)，负支更大。因此不存在所要求的固定C、δ。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.resonanceEigenPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：去掉平方根内错误因子1/2；本独立修正版仅一支特征根估计，完整双支谱分解列覆盖缺口。；`MD.Ch04.resonanceEigenPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“去掉平方根内错误因子1/2；本独立修正版仅一支特征根估计，完整双支谱分解列覆盖缺口。”。
- 导师选项：原文照录并保留已确认的ERRATUM记录；将数学修正版另立声明：sqrt(|(π/Ω)(h−π/Ω)|)，去掉/2，并同时给出两支实特征根、两条O(|h−h₀|)界及完整谱因子分解。不得把修正版冒充原印刷等式的证明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.resonanceEigenPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.2.1-ResonanceTaylor

- 印刷页 / PDF页：147 / 169。
- 原文引文（逐字）：

> We can see this by expanding $`\mu(h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega)`$ in a Taylor expansion around $`h=\pi/\Omega`$:

$$
\mu(h)=-2+\varepsilon,\qquad\varepsilon=\frac\pi\Omega(h-\pi/\Omega).
$$



- 问题所在：固定每个Ω>0后才选择C、δ，二者允许依赖Ω；对整个双侧邻域以二次余项一致控制。实际trace的常数项为−2，一阶导数为π/Ω，故与截断Taylor的合理修正版一致；不是声称对所有Ω使用同一C。sorry仅表明未完成证明，不影响本次签名审校。 网站原文审校另记：code：PRINTED\_TAYLOR\_REMAINDER；detail：原页展示为精确等号但叙述为Taylor展开，缺少二阶余项。保留原文并人工裁决；Lean二次余项修正版正确。
- 反例或理由：code：PRINTED\_TAYLOR\_REMAINDER；detail：原页展示为精确等号但叙述为Taylor展开，缺少二阶余项。保留原文并人工裁决；Lean二次余项修正版正确。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.resonanceTaylor`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.resonanceTaylor_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文等号照录保留；另明示这是带二阶余项的修正版，不把省略余项的字面等式当恒等式。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch04.resonanceTaylor。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 7. MD-4.2.1-ResonanceGrowth / MD-4.2.1-ResonanceLinearRate

- source\_id：MD-4.2.1-ResonanceGrowth；MD-4.2.1-ResonanceLinearRate。

### MD-4.2.1-ResonanceGrowth

- 印刷页 / PDF页：147 / 169。
- 原文引文（逐字）：

> and the norm of the solution will oscillate and grow linearly with $`n`$ as $`n\to\infty`$. This is the simplest type of linear resonance present in multiple timestepping.

- 问题所在：当前声明对Ω>0、q₀≠0确实正确地断言Pi最大范数趋于无穷；然而它仅是发散推论，签名本身不表达线性率或振荡。EXTRA明确把线性率分配给本批未提供的ResonanceLinearRate，不能将那一外部声明视作本条已审通过。原句把解的交替符号说成范数振荡，且缺少q₀≠0，应保留并人工裁决。 网站原文审校另记：code：PRINTED\_NORM\_OSCILLATION；detail：原文norm ... oscillate与矩阵幂所给整体交替符号不同，且增长需q₀≠0。；code：INCOMPLETE\_LINEAR\_RATE；detail：本条签名只给发散，线性率被分配给本批未提供条目，不能在本次核验。
- 反例或理由：取z=(0,1)，则W^k z=(−1)^k z，任何范数均恒为1；取z=(1,0)，Pi范数为max(1,kπ/Ω)，最终单调线性增长，范数并不交替振荡。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.resonanceGrowth`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.resonanceGrowth_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原句并标疑误；本条补送实际线性率声明供审校，例如lim ‖W^k z‖/k=|(π/Ω)z₀|，再把交替性表述为解的整体符号。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.resonanceGrowth。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.2.1-ResonanceLinearRate

- 印刷页 / PDF页：147 / 169。
- 原文引文（逐字）：

> and the norm of the solution will oscillate and grow linearly with $`n`$ as $`n\to\infty`$. This is the simplest type of linear resonance present in multiple timestepping.

- 问题所在：已展开Ch04\_deps.txt中-- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean的slowMatrix、fastMatrix、impulseMatrix（原文件行4418–4421）；分别为[[1,0],[-h,1]]、[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]和S(h/2)F(Ω,h)S(h/2)，对象与原文(q,p)列向量一致。 Ω>0与q₀=z 0≠0合理且q₀≠0对正增长必要。Fin 2→ℝ的范数是max(|q|,|p|)，故极限为|h₀q₀|>0，定量地保留了线性增长；量词先Ω、再所有合格初值，没有假设增长本身。可是所引句还声称范数oscillate，签名没有该子句，且原句对范数的字面表述不成立。该签名适合作为明确纠正措辞后的线性率定理，不能判为所引全部原句忠实编码。实际文件有证明体、无sorry，本次未编译。 网站原文审校另记：
- 反例或理由：Ω=π（h₀=1），z=(1,0)，则W^k z=(−1)^k(1,−k)，Pi范数为max(1,k)，单调且最终恰等k，并不振荡；二范数sqrt(1+k²)也单调。z=(0,1)则范数恒为1，说明附加q₀≠0必要。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.resonanceLinearRate`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.resonanceLinearRate_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原引文并标注ERRATUM/措辞疑误；把修正版明确写为解的符号交替而范数线性增长。在线性率结论旁给出z\_k=(−1)^k(q₀,p₀−kh₀q₀)以表达解的交替行为，不要声称范数振荡。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.resonanceLinearRate。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 8. MD-4.3-ConstraintSet

- source\_id：MD-4.3-ConstraintSet。

### MD-4.3-ConstraintSet

- 印刷页 / PDF页：152 / 174。
- 原文引文（逐字）：

> Constraints such as those described above define a manifold in the configuration space $`\mathcal M=\{q\mid g(q)=0\}`$.

- 问题所在：零点集合定义忠实。regularLevel在l≤n、各g\_j光滑、q为零点及真实向量导数满射的EXTRA条件下给出开邻域、双向光滑互逆坐标、q映至0及前l个坐标为零的完整等价，确实是余维l局部嵌入流形正规形。∞用于C∞符合目标。修正版签名正确，但原句未注明正则性即泛称流形，不能用增加前提消除原书疑误。 网站原文审校另记：code：PRINTED\_REGULARITY\_OMITTED；detail：原文不带正则性泛称流形；所给EXTRA正规形正确但不是无条件原句。
- 反例或理由：在ℝ²取单一光滑约束g(x,y)=xy，零点集为两坐标轴的交叉；原点附近删去原点有四个分支，不是1维嵌入流形。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.constraintSet`（定义）；`MD.Ch04.constraintSet_regularLevel`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。；`MD.Ch04.constraintSet_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。”。
- 导师选项：保留原句；标注需在零点处满秩等正则性，regularLevel明确作为带EXTRA的修正版。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.constraintSet。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 9. MD-4.3-RestraintForcePrinted

- source\_id：MD-4.3-RestraintForcePrinted。

### MD-4.3-RestraintForcePrinted

- 印刷页 / PDF页：150 / 172。
- 原文引文（逐字）：


$$
F_\varepsilon=-\nabla\varphi_\varepsilon(q)=\varphi_\varepsilon(q).
$$



- 问题所在：Ch04.lean:642–647 实际量化所有 ε,r₀,q 并断言 −gradient φ q = gradient φ q。原 PDF172 的末项是 φε(q)，没有 prime，且 φ 为标量、力为向量，原书确有类型疑误。[EXTRA] 把 prime 解释为配置梯度既无原文依据，也产生错误等式。[ERRATUM?] 应改为原书的标量势/向量力疑误，不能把缺失的 prime 当成原书问题。Position 是欧氏空间；gradient 为真实总梯度，光滑点不是任意符号。该声明另有 sorry，但 FAIL 来自签名。 网站原文审校另记：
- 反例或理由：ε=1,r₀=1,q=(2,0,0)。在此非零点势光滑，∇φ(q)=(1,0,0)，故 −∇φ(q)=(−1,0,0)≠(1,0,0)。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.restraintForcePrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：独立定义物理恢复力为势能负梯度；不保留原书把标量势与向量力相等的类型混淆为可证定理。；`MD.Ch04.restraintForcePrinted_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“独立定义物理恢复力为势能负梯度；不保留原书把标量势与向量力相等的类型混淆为可证定理。”。
- 导师选项：忠实转录末项 φε(q)，明确标注原书类型疑误；不要将该印刷等式作为可证明定理。数学修订版本另立条目：定义 Fε(q)=−gradient φε q；若给显式径向公式，在 q≠0、ε>0 下证明 Fε(q)=−ε⁻¹(‖q‖−r₀)•(q/‖q‖)，并明确这是勘误版本。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.restraintForcePrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 10. MD-4.3-ConstrainedPendulum

- source\_id：MD-4.3-ConstrainedPendulum。

### MD-4.3-ConstrainedPendulum

- 印刷页 / PDF页：151 / 173。
- 原文引文（逐字）：

> The equations of motion for the constrained system take the form

$$
\dot q=v,\qquad\dot v=-\nabla U(q)-q\lambda,\qquad0=\|q\|^2-r_0^2.
$$



- 问题所在：按本页字面三个方程核对：真实欧氏q,v曲线，q′=v、v′=−gradient U−λq、‖q‖²−r₀²=0，开I使within导数等同普通导数，均忠实。原前页仍保留一般质量m，本页加速度式未说明单位质量或势的重新归一化；把因子2吸收到λ可行，但吸收质量不能同时消除势力中的1/m。另U未附可微资格，gradient作为标准总化算子时，只有可微U才是经典势力语义。 网站原文审校另记：code：PRINTED\_MASS\_NORMALIZATION；detail：与前页一般m衔接时，单位质量或势归一化约定未由原页明示。；code：CLASSICAL\_POTENTIAL\_DOMAIN；detail：U没有可微资格；总化gradient表达式作为字面关系可读，但经典机械系统应用需补资格。
- 反例或理由：若沿用前页m=2且U(q)=q的第一坐标，则对应无约束加速度的势力部分为−e₁/2，本页字面式为−e₁；这不是单纯重定义法向λ就能在所有位置吸收的切向差异。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.constrainedPendulum`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.constrainedPendulum_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原方程照录；请人工确认单位质量/势归一化约定。若作为经典光滑机械系统接口，增加U可微的资格；若推广一般m，使用m⁻¹势梯度并一致归一化乘子。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.constrainedPendulum。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 11. MD-4.3.2-PositionEulerForceConvention / MD-4.3.4-GramProjectedEuler / MD-4.3.4-ProjectedEulerRelation / MD-4.3.5-ConstrainedOrders

- source\_id：MD-4.3.2-PositionEulerForceConvention；MD-4.3.4-GramProjectedEuler；MD-4.3.4-ProjectedEulerRelation；MD-4.3.5-ConstrainedOrders。

### MD-4.3.2-PositionEulerForceConvention

- 印刷页 / PDF页：156 / 178。
- 原文引文（逐字）：

> A simple example of such a method is the constrained Symplectic Euler-like method

- 问题所在：依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:789–793 只给任意 F 的 +hF 更新；没有 F=−grad U 的约束，也没有 F\_printed=−F 的参数转换。额外说明属于改变力参数或修订原式，不能作为同一F下的额外假设消除负号差异。原句仅命名方法，不能证明改号公式忠实。定义无 sorry。 网站原文审校另记：
- 反例或理由：n=1,l=0,m=1,h=1,z=(0,0),F≡1：印刷关系输出 (−1,−1)，统一力关系输出 (1,1)，二者不同。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.positionEulerRelation`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.positionEulerRelation_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：明确区分 F\_printed 与 F\_force，要求 F\_printed=−F\_force，并记录力版本为显式派生/修订而非原式；如声明F=−∇U，应在签名中参数化U并使用该实际力。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.positionEulerRelation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.3.4-GramProjectedEuler

- 印刷页 / PDF页：159 / 181。
- 原文引文（逐字）：

> The demonstration that the method is symplectic can be seen as a consequence of the following lemma.

- 问题所在：签名逐项核对：Nc、Mc任意有限维，q、p及各λ在x为C¹，U和各γ为C²；旧、新位置约束在x邻域成立；新位置Gram行列式非零。结论第一合取是实际Gram末投影满足 g′M⁻¹pnew=0，第二合取对任意u、v给整个chart的辛形式拉回等式。Gram逆定义实现μ，未假设辛性。m未要求正或非零，但质量逆按实数总逆定义，M⁻¹仍对称，Gram非退化足够支持该几何结论；不能由此声称物理正质量或全局辛微分同胚。旧p不需隐藏约束是有效加强。general允许任意a且未冒充原印。就字面辛性声明可通过；整体因教材力号疑误分流人工。 网站原文审校另记：原句、页码、(4.20)–(4.24)及p.160三段二形式等式均忠实。原印(4.21)的−hF与附件p.163重述的+hF冲突；保留原印，不代作者裁定。该冲突不使本条辛性签名本身失真。
- 反例或理由：本条辛性本身无反例：任意常数势踢系数仍保辛。若把a=−h误读为物理Euler一致性，则无约束m=1、U(q)=q²/2时pnew=p+hq，与ṗ=−q的符号相反。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.gramProjectedEuler`（已证）；`MD.Ch04.gramProjectedEuler_general`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.gramProjectedEuler_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原文和a=−h；记录p.159/p.163力号冲突，由人工确认物理勘误。勿把general或a=h当作原印版。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 ['MD.Ch04.gramProjectedEuler', 'MD.Ch04.gramProjectedEuler\_general']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.3.4-ProjectedEulerRelation

- 印刷页 / PDF页：159 / 181。
- 原文引文（逐字）：

> The demonstration that the method is symplectic can be seen as a consequence of the following lemma.

- 问题所在：已读取实际 /workspace/Ch04.lean 与 Ch04\_deps.txt，而非仅按批次签名判断。以下为只读签名语义审计；未运行 Lean 编译，也不据 sorry 判定语义。展开与逐字版相同，唯一变化为+hF，但所绑定原句是方法辛性的论断；此定义只有五条更新约束，没有任何拉回二形式不变结论，也没有F来自势的限制。[EXTRA]符号修正版可以作为另一个算法定义，但不能充当所引辛性原句的形式化。 网站原文审校另记：
- 反例或理由：缺失条款：方法保持受约束辛形式。无约束n=2、m=1、h=1、F(q)=(q₂,0)满足该算法关系却非辛：输入方向u=(δq=e₂,δp=0)、v=(δq=e₁,δp=0)原二形式为0，更新后的二形式为−1。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.projectedEulerRelation`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.projectedEulerRelation_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：将此条重新绑定为明确标记的修正版(4.20–24)定义；若继续绑定辛性原句，应限制F=−∇U、U为C²及可微求解分支，并加入完整受约束拉回二形式不变结论。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.projectedEulerRelation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.3.5-ConstrainedOrders

- 印刷页 / PDF页：161 / 183。
- 原文引文（逐字）：

> The projected symplectic constrained method (4.20)–(4.24) is only first order accurate. We forego providing a detailed proof of this fact, but note that it could be demonstrated using standard methods [164]. There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.

- 问题所在：constrainedOrders：正质量、C⁴势/约束、初点余切约束及Gram非零；E/R/Φ为C³步长曲线且在0等于z，乘子为C²，末投影μE、μR在0为零；真实步关系与精确ODE在双侧小窗口成立。结论是同一起点单步Euler O(h²)、RATTLE O(h³)，并非全局阶。pE/pR未单列光滑性，但步关系已给其光滑表达式。global另在开放D上设联合C³ E/R、联合C²乘子、零步恒等及正则余切域；精确轨道在[0,T]落于D内紧集。结论对充分大正整数N、全部k≤N给Euler Ch和RATTLE Ch²全局误差；没有将误差作为假设。firstOrderSharp对T=1振子初值(1,0)给全步误差c/N下界，确实排除该方法统一二阶。以上对正力号修订方法数学上合理，但与原印负力号不能无标记等同。 网站原文审校另记：原文所选各句逐字吻合，非连续摘录已明确说明。；本条Lean使用projectedEulerRelation的+hF，而所引(4.21)原印为−hF；这是精度结论的实质勘误，现有[EXTRA]未明确标识该力号改动。；SHAKE位置二阶明确委托另一条，但其声明不在本任务，不能确认完整引文的SHAKE精度子句。附件(4.25)约束力质量因子及p.161隐藏约束记号亦有原书疑点，不擅自改写。
- 反例或理由：原印无约束m=1、U=q²/2、初值(q,p)=(1,0)时p(h)=h，而目标ODE动量为−sin h；误差h+sin h为2h+O(h³)，不满足局部O(h²)。这不是本条+hF版Lean的反例，而是原印与其精度解释的冲突。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.constrainedOrders`（未证）；`MD.Ch04.constrainedOrders_global`（未证）；`MD.Ch04.constrainedOrders_firstOrderSharp`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.constrainedOrders_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：人工确认后将+hF版本明确命名\_corrected，并在[EXTRA]记录力号改动；原印文本保留。提供被委托SHAKEPositionOrder的准确声明后再审其子句。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 ['MD.Ch04.constrainedOrders', 'MD.Ch04.constrainedOrders\_global', 'MD.Ch04.constrainedOrders\_firstOrderSharp']。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 12. MD-4.3.2-FrozenGramPrinted / MD-4.3.2-FrozenNewtonConstraint

- source\_id：MD-4.3.2-FrozenGramPrinted；MD-4.3.2-FrozenNewtonConstraint。

### MD-4.3.2-FrozenGramPrinted

- 印刷页 / PDF页：157 / 179。
- 原文引文（逐字）：

> Moreover, in case we have chosen $`\Lambda^{(0)}=0`$, we have

$$
R^{(0)}=G_nM^{-1}G_n^T,
$$


> which is a symmetric matrix,

- 问题所在：核对位置：Ch04.lean LF 859–864。Q n 在 Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean LF 4377 展开为 Fin n → ℝ。正式库 projectionJacobian 的完整定义位于同文件 LF 4452–4455：R(η)=J(base−D J(q)ᵀη)D J(q)ᵀ，其中 invMass 的坐标式在 LF 4381，等价于 D=diag((m i)⁻¹) 的乘向量作用。J(x) 的每项为真实偏导 (fderiv ℝ (g j) x)(Pi.single i 1)，来自 -- FILE: MolecularDynamics/Chapter04/ConstrainedProjection.lean LF 2975–2977 及 -- FILE: MolecularDynamics/Chapter04/CotangentProjection.lean LF 3385–3387；D 的定义在后者 LF 3413–3414，textbookConstraintGram 在 LF 3417–3420 实际为 J(q)D J(q)ᵀ。令 η=0 后，左边是 J(base)D J(q)ᵀ；右边则是 J(q)D J(q)ᵀ。
对象与量词：签名先对 n,l,m,g,q,base 全称量化，随后无任何假设就断言两矩阵相等。这逐字承接了原书所印等式，但原书 (4.19) 和同页 R 的定义并不支持它；本条 [ERRATUM?] 成立，问题已可由完整定义和反例判定，无需因“缺定义”转交人工。正质量、C² 约束、旧点满足约束、约束 Jacobian 满行秩、预测点任意接近旧点、甚至 R(0) 可逆，都不能补救该无条件等式。
缺失结论：原摘录还明确说“which is a symmetric matrix”，Lean 签名仅给等式，没有列出 R(0) 的对称性断言。右端 Gram 的确对称，因为 D 为实对角矩阵；但实际左端是两个不同位置 Jacobian 的交叉乘积，一般连对称性也不成立。在正确的同点或同 Jacobian 限定下，等式可用于推导对称性；要审查全部结论子句，应把这一性质在对应正确声明中显式列出，而不能靠错误等式充当其依据。
本条没有 [EXTRA] 假设；修复必须清楚区分“保留原书勘误记录”和“新增可证明的正确声明”，不得直接修改 corrected\_json 的原文等式。
证明状态单独记录：Ch04.lean LF 863–864 为 := by / sorry。FAIL 来自展开定义后的错误普遍等式及缺失结论，与 sorry 是否存在是两个独立问题。 网站原文审校另记：
- 反例或理由：取 n=l=2，m=(1,1)，g₁(x,y)=x−1，g₂(x,y)=y+x²−1，q=(1,0)，base=(1+ε,0)，其中 ε>0 可任意小。约束均为多项式，g(q)=0，J(q)=[[1,0],[2,1]] 满秩，D=I，J(base)=[[1,0],[2+2ε,1]]。于是 projectionJacobian m g q base 0=[[1,2],[2+2ε,5+4ε]]，textbookConstraintGram m g q=[[1,2],[2,5]]。ε≠0 时二者不相等，且左矩阵的 (1,2) 与 (2,1) 项不同，故不对称；两矩阵行列式都为 1。取 p=0、h²=ε、Lean 的 F(q)=(1,0)，此 base 也来自本批投影预测式且初始隐藏约束成立；按原书字面负号则取 F\_n=(−1,0)。因此反例不是靠不相容初值或大步长构造。以 ε=1/10 作精确有理数复核，左矩阵为 [[1,2],[11/5,27/5]]，右矩阵为 [[1,2],[2,5]]，左行列式为 1。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.frozenGramPrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：真实残差Jacobian为新预测点/旧点的交叉矩阵，不无条件等于旧点Gram或对称矩阵。；`MD.Ch04.frozenGramPrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“真实残差Jacobian为新预测点/旧点的交叉矩阵，不无条件等于旧点Gram或对称矩阵。”。
- 导师选项：保留原书字面等式及 [ERRATUM?] 的来源记录，将可证明的基本声明改为 projectionJacobian m g q base 0 = textbookConstraintJacobian g base * textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ；这条正确交叉矩阵等式不附带一般对称性。若仍要声明它等于旧点 Gram，应另加 base=q，或更弱的 textbookConstraintJacobian g base = textbookConstraintJacobian g q，并在这个限定后的声明中显式加入 Aᵀ=A（A 为该冻结矩阵）或等价的矩阵对称性子句。这些假设只是足够条件，不是必要条件，必须标为额外限定，不能伪装成仅由 Λ^(0)=0 得出的原文结论。如果算法本意是冻结到旧点 Gram，则另定义该近似矩阵 J(q)D J(q)ᵀ 及相应更新映射，与真实 R(0) 区分；不要暗中改写本批前两条使用的正式库定义。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.frozenGramPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.3.2-FrozenNewtonConstraint

- 印刷页 / PDF页：157 / 179。
- 原文引文（逐字）：

> we may be able to fix $`R`$ at the beginning of the timestep, factor it once only, and then solve at each iteration with the same factors. Moreover, in case we have chosen $`\Lambda^{(0)}=0`$, we have

$$
R^{(0)}=G_nM^{-1}G_n^T,
$$


> which is a symmetric matrix,

- 问题所在：依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:823–825及依赖4459–4461固定的是R(0)=G(base)DG(q)ᵀ。这属于合理的冻结Newton实现，但未忠实表达原文另外声称的旧位置Gram等式、对称性以及一次分解复用。所标[ERRATUM?]一般成立；不能把正确的交叉矩阵版本当作已表达错误原式。若显式采用修订语义，可保留实现并对原式另标疑误。定义无 sorry。 网站原文审校另记：
- 反例或理由：n=l=1,m=1,g(x)=x²−1,q=1,base=2,η₀=0：G(q)=2,G(base)=4，R(0)=8，而旧位置Gram=4；即便q为合法位置亦不等。n=l=2,g₁(x,y)=x,g₂(x,y)=xy,q=(1,0),base=(1,1),D=I，则R(0)=[[1,0],[1,1]]，不对称。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.frozenNewtonConstraint`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.frozenNewtonConstraint_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：明确保留原式为教材疑误；将冻结交叉Jacobian方案与冻结旧位置Gram方案分列。对Gram等式加入G(base)DG(q)ᵀ=G(q)DG(q)ᵀ的条件（例如G(base)=G(q)）；对对称性与因子复用另写语义条款。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.frozenNewtonConstraint。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 13. MD-4.3.2-ProjectionScale

- source\_id：MD-4.3.2-ProjectionScale。

### MD-4.3.2-ProjectionScale

- 印刷页 / PDF页：158 / 180。
- 原文引文（逐字）：

> It is worth noting that $`\Lambda(h)=\mathcal{O}(h^2)`$, i.e. for small steps $`\Lambda`$ will also be small. This justifies the initial guess $`\Lambda^{(0)}=0`$,

- 问题所在：签名量化任意 n,l,m、位置力 F:Q n→Q n、约束 g、初始相点 z 及分支 η:ℝ→Q l；假设 z∈cotangentSet、g\_j∈C²、η∈C²、η(0)=0、Gram(z.q).det≠0，以及某个双侧开邻域内的实际零残差根方程。完整结论为存在 C>0、δ>0，对全部 h∈(−δ,δ) 有 ‖η(h)‖≤Ch²，包含 h=0。作为当前所写“加号预测器”的条件数学定理，该结论正确：由根方程在 0 的一阶微分、初始隐藏约束和 Gram 可逆得到 η′(0)=0，再由 C² 分支得到二阶界；F 只在固定 z.q 处取值，故无需 F 对位置可微。没有循环假设 O(h²)，也没有宣称已找到根分支。然而原文/notation 的预测器是 z.q+hM^{-1}z.p−h²M^{-1}F\_n，当前签名却写成加号，且未注明反号变量关系或修正版，故源文对应审校为 FAIL，而非数学定理本身被反例否定。原书 O(h²) 适用范围的疑问另在 json\_review 标记 NEEDS\_HUMAN，保持原文并交由人工判断。 网站原文审校另记：原页首行使用书写体大 O；corrected\_json 将 O(h²) 的排版恢复为 \mathcal{O}(h²)。摘录在初值从句后的逗号处停止，与原页后续 and it also suggests 的衔接已由 context\_notation 说明。；原书在前页明确允许隐藏约束被违反；若把本句视为仅要求初始位置约束成立的普遍陈述，则 Λ(h)=O(h²) 缺少隐藏约束相容性（或随步长为 O(h) 的隐藏残差）等资格。保留原书原句，提交 NEEDS\_HUMAN 判断其意指的初始状态和渐近范围；不将反例归咎于已经增加相容前提的 Lean 条件定理。；当前 Lean 根分支前提的预测位置含 +h²M^{-1}F(z.q)，而本条 context\_notation 和原印 Q\_n 均含 −h²M^{-1}F\_n；没有声明 F 是 −F\_n，也没有将该处标记为 corrected 版本。此为可独立确定的签名/原文对应失配。；分支 C²、η(0)=0、Gram 非奇异和初始 cotangentSet 相容性是明确的附加资格，extra\_assumptions 应统一标 [EXTRA]，并说明只给条件估计，不构造根分支。
- 反例或理由：scope：两例分别说明原书无隐藏相容性时的范围问题，以及加/减号预测器根分支不同；均不否定当前 Lean 条件估计本身。以下是直接代入的解析例，不是数值模拟或 Lean 验证。；source\_scope\_example：取 n=l=1，m=1，g(x)=x，q=0，p=1，F\_n=0。位置约束 g(q)=0、Gram=1，但隐藏约束不成立。原印残差为 h−Λ，唯一光滑根为 Λ(h)=h；|h|≤Ch² 不可能在任意固定 C 的零邻域成立。该例不满足 Lean 的 z∈cotangentSet。；predictor\_sign\_example：取 n=l=1，m=1，g(x)=x，q=p=0，F\_n=F(0)=1。此时初始余切相容且 Gram=1。原印负号预测器残差为 −h²−η，根为 η(h)=−h²；当前 Lean 加号预测器残差为 h²−η，根为 η(h)=h²。两分支均为 O(h²)，但不是同一原文根方程。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.projectionScale`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：独立限定版本采用原印负号预测器，并要求初态满足位置及隐藏余切约束、Gram非奇异、C²根分支且η(0)=0；只有位置约束不保证O(h²)。翻译预测器符号修复与原书缺相容性问题分开。；`MD.Ch04.projectionScale_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“独立限定版本采用原印负号预测器，并要求初态满足位置及隐藏余切约束、Gram非奇异、C²根分支且η(0)=0；只有位置约束不保证O(h²)。翻译预测器符号修复与原书缺相容性问题分开。”。
- 导师选项：不修改原书 statement\_latex。Lean 若仍以 F 表示原印 F\_n，将根方程预测位置中的 +h² • invMass m (F z.1) 改为 −h² • invMass m (F z.1)；若 F 特指物理力而与原印量反号，则需明确 F=−Fprinted 的记号关系并单独标名该版本。保留现有根分支、相容性和非奇异 [EXTRA] 条件；由人工确认原书 O(h²) 的初态/随步长范围。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.projectionScale。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 14. MD-4.3.3-ComponentPrinted / MD-4.3.3-ComponentSweep

- source\_id：MD-4.3.3-ComponentPrinted；MD-4.3.3-ComponentSweep。

### MD-4.3.3-ComponentPrinted

- 印刷页 / PDF页：158 / 180。
- 原文引文（逐字）：

> In general, we perform a sequence of updates

$$
\Delta\Lambda_j=[\nabla g_j(Q)^TM^{-1}G_j^1]^{-1}g_j(Q),\qquad Q:=Q-M^{-1}G_n^j\Delta\Lambda_j,
$$


> as $`j`$ cycles repeatedly from $`1`$ to $`m`$.

- 问题所在：位置域为Fin n→ℝ，约束族Fin l，j任意；质量逐坐标为正，旧点q与当前点Qnow可微，当前标量分母非零。dot、grad、invMass展开后，返回值正是Qnow−[g\_j(Qnow)/(∇g\_j(Qnow)ᵀM⁻¹Gsup1\_j)]M⁻¹∇g\_j(q)。未把Gsup1认作梯度；这忠实保留原印分母G\_j^1，与更新方向G\_n^j分开。[EXTRA]均已明示，单步范围明确；但原印G\_j^1未定义，数学含义仍需人工确认。 网站原文审校另记：code：PRINTED\_INDEX\_UNDEFINED；detail：A：附件第1页一般式分母确为G\_j^1，更新方向为G\_n^j；原文JSON忠实。原页只定义G\_n^k，不能静默裁定G\_j^1的数学含义。C：字面版使用独立参数忠实；原书疑误保留。
- 反例或理由：code：PRINTED\_INDEX\_UNDEFINED；detail：A：附件第1页一般式分母确为G\_j^1，更新方向为G\_n^j；原文JSON忠实。原页只定义G\_n^k，不能静默裁定G\_j^1的数学含义。C：字面版使用独立参数忠实；原书疑误保留。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.componentPrinted`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：把一般分量式分母中的G\_j^1明确改为当前约束在旧点的梯度G\_n^j，与分子所用方向一致；原Gsup1参数版完整保留。；`MD.Ch04.componentPrinted_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“把一般分量式分母中的G\_j^1明确改为当前约束在旧点的梯度G\_n^j，与分子所用方向一致；原Gsup1参数版完整保留。”。
- 导师选项：人工确认一般式G\_j^1是否应为G\_n^j；字面版继续保留独立Gsup1，另列明确命名的修订版。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.componentPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.3.3-ComponentSweep

- 印刷页 / PDF页：158 / 180。
- 原文引文（逐字）：

> and continue to update $`\Lambda_2`$ in the same manner (using the second constraint). In general, we perform a sequence of updates

$$
\Delta\Lambda_j=[\nabla g_j(Q)^TM^{-1}G_j^1]^{-1}g_j(Q),\qquad Q:=Q-M^{-1}G_n^j\Delta\Lambda_j,
$$


> as $`j`$ cycles repeatedly from $`1`$ to $`m`$.

- 问题所在：componentSweep按finRange l升序foldl，每次用刚更新的Qcur，使用梯度修订方向；它调用的是Chapter04Review.componentConstraintStep，无有效域假设，是实数逆零总化下的辅助函数。componentPrintedDelta忠实保留Gsup1；Trajectory以k mod l循环、旧q不变，l=0时恒等；Iteration在正质量、l>0和每个已执行步骤可微/分母非零条件下返回rounds*l步位置。Stop检查round*l+j处、更新前计算的一整轮各分量增量，顺序正确，却使用<tol，原页是≤tol；故本条全部声明不能整体PASS。原印索引疑误另需人工裁定。 网站原文审校另记：code：PRINTED\_INDEX\_UNDEFINED；detail：A：原句忠实保留G\_j^1；其索引疑误仍待人工确认。；code：STOP\_BOUNDARY\_MISMATCH；detail：C：原页建议全部分量增量范数≤tol，componentPrintedStop却为绝对值<tol，排除了等号边界。；code：TOTALIZED\_AUXILIARY\_DOMAIN；detail：C：componentSweep、Delta、Trajectory、Stop本身没有有效域资格；Iteration只保证所执行前rounds*l步，不能自动保证另一round的Stop测试有效。须区分总化辅助与有效算法使用。
- 反例或理由：边界见证：n=l=1，m=1，g₀(t)=t，q=0，Q₀=1，Gsup1₀=1，round=0，tol=1。分母为1、增量为1；原书1≤1成立，而当前Stop要求1<1为假。此为精确代入，非数值搜索。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.componentSweep`（定义）；`MD.Ch04.componentPrintedDelta`（定义）；`MD.Ch04.componentPrintedTrajectory`（定义）；`MD.Ch04.componentPrintedIteration`（定义）；`MD.Ch04.componentPrintedStop`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.componentSweep_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：将componentPrintedStop的<tol改为≤tol，或另命名严格停止变体并保留原印非严格版；有效使用Stop时补测试轮全部步骤资格。保留G\_j^1疑误待人工裁定。本次不修改工程。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.componentSweep。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 15. MD-4.3.4-Lemma41

- source\_id：MD-4.3.4-Lemma41。

### MD-4.3.4-Lemma41

- 印刷页 / PDF页：159–160 / 181–182。
- 原文引文（逐字）：

> Lemma 4.1 Let $`\gamma:\mathbb R^{N_c}\to\mathbb R`$ be $`C^2`$. Let $`q,p\in\mathbb R^{N_c}`$ be constrained to the manifold defined by

$$
\gamma(q)=0,\quad p\cdot\nabla\gamma(q)=0,
$$


> and suppose $`P,\mu`$ satisfy $`P=p-\mu\nabla\gamma(q)`$. Then

$$
\sum_{j=1}^{N_c}dq_j\wedge dP_j=\sum_{j=1}^{N_c}dq_j\wedge dp_j.
$$



- 问题所在：任意Nc及实赋范空间E，γ全局C²，q,p,μ在x可微；hchart在x邻域同时保留γ(q)=0和p·∇γ(q)=0。ConstrainedMomentum定义P=p−μ∇γ(q)，CotangentChart把位置与动量合并；J=[0 I;−I 0]所得双线性形式即Σdq\_j∧dp\_j。结论对任意u,v比较两个参数图的完整拉回二形式，符合原引理。局部图及可微性是明确资格，不把点约束误当微分约束。签名匹配，但原书证明两处dq\_j链式指标疑误须保留并人工确认。 网站原文审校另记：code：PRINTED\_HESSIAN\_INDEX；detail：A：附件第5页两处Hessian内和确为dq\_j，原JSON保留正确；链式法则应为dq\_i，原书疑误不得静默修订。C：引理完整结论正确且签名忠实。；code：SOURCE\_SUM\_LIMITS；detail：A：原页各坐标求和均明确1至N\_c，proof\_latex多处简写sum\_j、sum\_i；补全求和范围，不改原印dq\_j。
- 反例或理由：code：PRINTED\_HESSIAN\_INDEX；detail：A：附件第5页两处Hessian内和确为dq\_j，原JSON保留正确；链式法则应为dq\_i，原书疑误不得静默修订。C：引理完整结论正确且签名忠实。；code：SOURCE\_SUM\_LIMITS；detail：A：原页各坐标求和均明确1至N\_c，proof\_latex多处简写sum\_j、sum\_i；补全求和范围，不改原印dq\_j。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.lemma41`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.lemma41_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原proof\_latex继续保留两处dq\_j并标注疑误；另列修正版将两处内和的dq\_j改为dq\_i，利用Hessian对称性；引理声明无需更改。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.lemma41。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 16. MD-4.3.5-SHAKEPositionMass

- source\_id：MD-4.3.5-SHAKEPositionMass。

### MD-4.3.5-SHAKEPositionMass

- 印刷页 / PDF页：161 / 183。
- 原文引文（逐字）：

> It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.

- 问题所在：已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。该签名只是质量一致位置关系的定义，不是“由相空间方法消去动量得到(4.25)–(4.26)”这一断言：无SHAKE步骤前提、无序列、无消元蕴含，且它的反力为M⁻¹Gᵀρ而非原印刷Gᵀρ。[EXTRA]是合理的勘误候选，但属于改变公式而不是额外假设；不能代替原句的形式化。定义无sorry。 网站原文审校另记：
- 反例或理由：取n=2,l=1,m=(1,2),g(q)=q₁+q₂,F=0,h=1,b=(0,0),a=(1,1/2),c=(0,0),ρ=-1。质量一致关系成立：c−2b+a=(1,1/2)=−M⁻¹Gᵀρ。印刷关系即使另选标量乘子也无法生成(1,1/2)，因为Gᵀρ总为(ρ,ρ)。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.shakePositionRelation`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.shakePositionRelation_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留印刷定义；另明确标注质量修正公式，并用连续两步shakeRelation作为前提陈述真正的消元定理，结论为质量一致关系。原书“reduces to (4.25)”不应静默改为修正式。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.shakePositionRelation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 17. MD-4.3.5-StaggeredConstraint

- source\_id：MD-4.3.5-StaggeredConstraint。

### MD-4.3.5-StaggeredConstraint

- 印刷页 / PDF页：162 / 184。
- 原文引文（逐字）：

> the iterations generated by them can be related to the following staggered iteration

$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\tag{4.35}
$$



$$
p_{n+1/2}=p_{n-1/2}+hF_n-hg'(q_n)^T\widetilde\lambda_n,\tag{4.36}
$$



$$
0=g(q_{n+1}),\tag{4.37}
$$


> where, for SHAKE, $`\widetilde\lambda_n=\lambda_n`$, while, in case of RATTLE, we must define $`\widetilde\lambda_n=(\lambda_n+\mu_n)/2`$.

- 问题所在：已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。参数rho是独立的交错乘子，关系完整记录(4.35)–(4.37)，无sorry。但原文还有SHAKE的tildeλ=λ和RATTLE的tildeλ=(λ+μ)/2及两种迭代可归约为此关系，签名没有原方法乘子、无换算公式、无归约断言，遗漏实质子句。[ERRATUM?]成立：合并上一RATTLE末步和当前首步得newHalf=oldHalf+hF−Gᵀ(μₙ+(h/2)λₙ)，故h≠0时tildeλ=λₙ/2+μₙ/h，非印刷平均。 网站原文审校另记：
- 反例或理由：取h=1、Gᵀ=1、F=0、oldHalf=0、λₙ=0、μₙ=1，两次动量子步合成newHalf=-1。印刷平均tildeλ=1/2代入(4.36)给newHalf=-1/2。即乘子换算矛盾。定义还没有陈述任何换算等式。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.staggeredConstraintRelation`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.staggeredConstraintRelation_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留交错关系定义；另明确列出印刷乘子公式及缩放疑误。增加SHAKE与RATTLE归约声明，RATTLE须按(4.33)的原μ使用tildeλ=λ/2+μ/h（h≠0），或明确重新定义缩放后的μ。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.staggeredConstraintRelation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 18. MD-4.3.5-SHAKERATTLEEquivalence

- source\_id：MD-4.3.5-SHAKERATTLEEquivalence。

### MD-4.3.5-SHAKERATTLEEquivalence

- 印刷页 / PDF页：162 / 184。
- 原文引文（逐字）：

> Given an initial condition $`(q_0^S,p_0^S)`$ for the SHAKE discretization, we easily determine $`\lambda_0^S`$ by taking a step. Then it follows that

$$
p_{-1/2}=p_0-(h/2)F(q_0^S)-(h/2)g'(q_0^S)^T\lambda_0^S,
$$


> by solving (4.29). Next we obtain $`p_0^R`$ by solving (4.33)–(4.34) with $`n=-1`$. Then the sequences generated using $`(q_0^S,p_0^S)`$ as the initial point for SHAKE and that generated using $`(q_0^S,p_0^R)`$ in RATTLE will have identical positions (the momenta can be made compatible by simply projecting the SHAKE momenta onto the constraints).

- 问题所在：已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。cotangentSet m g 展开为 g(q)=0 且 G(q)M⁻¹p=0；grad U 是实际 Fréchet 坐标梯度，textbookPotentialForce U=-grad U。已展开projectionResidual\_j=g\_j(base−M⁻¹G(q)ᵀeta)、Gram=GM⁻¹Gᵀ、cotangentMultiplier=Gram⁻¹GM⁻¹p、cotangentProjection=p−GᵀGram⁻¹GM⁻¹p。两套真实步骤、qS0=qR0、halfS0=halfR0推出位置相同及k+1动量投影关系，是合理的条件版本，未直接假设位置相同。正质量及约束上梯度独立为实际投影所需，合理。但原文从给定SHAKE初态构造RATTLE初态，签名把半步兼容直接作假设，没有构造pR0，也无k=0的动量投影结论。宣称“同一局部唯一投影分支”的[EXTRA]实际却量化所有q、所有base、所有eta/nu，要求全局根的法向修正唯一；未限制邻域或分支，远强于局部资格并排除常见非线性约束。[ERRATUM?]初始反力符号疑误成立：由(4.29)应得oldHalf=p0−(h/2)F+(h/2)Gᵀλ0，而印刷为负号。定理体为sorry；本FAIL针对原文初始化缺项与不合理全局资格，不声称这个强假设下的条件定理必然为假。 网站原文审校另记：
- 反例或理由：缺失条款：从SHAKE初态构造pR0、证明halfS0=halfR0，以及pR0=投影(pS0)。全局资格反例：n=2,l=1,m=(1,1),g(q)=‖q‖₂²−1，q=base=(1,0)，Gᵀ=(2,0)。eta=0和nu=1均使projectionResidual=0（投影点分别为(1,0)、(-1,0)），但Gᵀeta≠Gᵀnu；该约束处处正则且近eta=0分支局部唯一，却被签名排除。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.shakeRattlePositions`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.shakeRattlePositions_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：把唯一性限于所选局部邻域及实际步长分支，并要求两套步骤均取该分支。补初态投影/半步兼容的构造声明及k=0动量投影。分别保存原印刷初始化负号与由(4.29)推出的正号，显式说明勘误，不能把相容性假设当作原构造的证明。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.shakeRattlePositions。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 19. MD-4.3.5-SHAKEElimination

- source\_id：MD-4.3.5-SHAKEElimination。

### MD-4.3.5-SHAKEElimination

- 印刷页 / PDF页：161 / 183。
- 原文引文（逐字）：

> It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.

- 问题所在：依赖展开（Ch04\_deps.txt，MolecularDynamics/Chapter04/ReviewDefinitions.lean）：Q n=Fin n→ℝ；invMass m v 的第 i 分量为 (m i)⁻¹*v i；constraintSet g={x|∀j,g j x=0}；shakePositionRelation a b c rho 为 c−2b+a=h² M⁻¹(F(b)−G(b)ᵀrho) 且 g(c)=0。CotangentProjection.lean 中 textbookConstraintJacobian 的 (j,i) 项是 textbookConstraintGradient (g j) q i；ConstrainedProjection.lean 中该梯度为 (fderiv ℝ (g j) q)(Pi.single i 1)，即真实坐标导数。 shakeRelation 展开为 half=p+(h/2)(F(q)−G(q)ᵀrho)，qnew=q+hM⁻¹half，g(qnew)=0，pnew=half+(h/2)(F(qnew)−G(qnew)ᵀrhonew)。签名全称量化 n,l,m,F,g,h 及四套序列，假设每一步满足该关系；用连续两步消去 p，结论以 k+1 为中心、乘子 rho(k+1)，并包含 g(q(k+2))=0；指标及量词正确，代数不需 h≠0、质量正性或光滑性。[EXTRA] 实际是更换结论公式，非额外假设；质量一致消元在数学上正确，但并非原句声称的印刷 (4.25)。[ERRATUM?] 反力缺失 M⁻¹ 的判断成立，不能对一般非标量对角质量仅重命名乘子解决。故原文忠实性 FAIL，非判定修正式为假。Ch04.lean:1120 有显式代数证明，无 sorry；未运行 Lean 编译，证明完成状态与语义结论分开。 网站原文审校另记：
- 反例或理由：取 n=2,l=1,h=1,m=(1,2)，g(x)=x₁+x₂，F(x)=(1,1)。所有 k 取 q\_k=p\_k=half\_k=(0,0)，rho\_k=1。每一步 shakeRelation 成立，质量一致位置式右端为 0；印刷 (4.25) 右端为 (1,1/2)−(1,1)=(0,−1/2)，不等于左端 0。即使允许重选标量乘子，也不能让 (1,1/2) 成为 (1,1) 的标量倍数。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.shakeElimination`（已证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.shakeElimination_corrected`（已证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留当前命题作为明确标注的“质量一致修正式消元”；另记录原书到印刷 (4.25) 的字面消元声明存在错误。若要求忠实字面结论，可限制 M=I 后使用 shakePositionPrinted；一般质量下应明确建议原书 (4.25) 的反力项改为 −h²M⁻¹Gᵀλ，而不静默替换原句。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.shakeElimination。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 20. MD-4.3.5-SHAKEPositionOrder

- source\_id：MD-4.3.5-SHAKEPositionOrder。

### MD-4.3.5-SHAKEPositionOrder

- 印刷页 / PDF页：161 / 183。
- 原文引文（逐字）：

> There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.

- 问题所在：依赖展开（Ch04\_deps.txt，MolecularDynamics/Chapter04/ReviewDefinitions.lean）：Q n=Fin n→ℝ；invMass m v 的第 i 分量为 (m i)⁻¹*v i；constraintSet g={x|∀j,g j x=0}；shakePositionRelation a b c rho 为 c−2b+a=h² M⁻¹(F(b)−G(b)ᵀrho) 且 g(c)=0。CotangentProjection.lean 中 textbookConstraintJacobian 的 (j,i) 项是 textbookConstraintGradient (g j) q i；ConstrainedProjection.lean 中该梯度为 (fderiv ℝ (g j) q)(Pi.single i 1)，即真实坐标导数。 grad U=textbookConstraintGradient U，所以 F=−∇U。constrainedSolution 在 I=[0,tau] 的每个 t 要求 q 的区间导数为 M⁻¹p，p 的区间导数为 −∇U−Gᵀrho，且 g(q)=0；textbookInverseMassMatrix=diag(m\_i⁻¹)，textbookConstraintGram=G diag(m\_i⁻¹) Gᵀ。全称量化数据与精确解后，先要求 tau>0、正质量、U/g/q 为 C⁴、p 为 C³、实际受约束解、沿紧区间 Gram 行列式非零；然后存在与 N 无关的 C>0,N0≥2，每个 N≥N0 存在离散位置及乘子，精确两步初值 qn0=q0,qn1=q(h)，满足 k+2≤N 的递推与全部 k≤N 的误差 C h²。这是真实有限区间二阶位置误差及存在性结论，不是把误差作假设。[EXTRA] 正质量、正则性、独立约束和相容起步对通常二阶收敛论述合理，但 C⁴ 全局正则及精确第二初值属于较强的充分条件，不应称为最小必要条件；结论仅选择存在的好分支，不声称所有隐式根均收敛，也不含动量误差。主要忠实性问题仍是：原页 symmetry 句紧接印刷 (4.25)，Lean 却对质量一致修正式给阶数，改变了方法；一般质量下两者甚至不逼近同一受约束解。因此 FAIL 不由 sorry 引起。Ch04.lean:1142 的证明为 sorry，二阶修正式的证明仍待完成，本审计不把它视为已验证定理。 网站原文审校另记：
- 反例或理由：原印刷方法与精确受约束动力学的差异：n=2,l=1,m=(1,2)，g(x)=x₁+x₂，U(x)=−x₁，F=(1,0)，tau=1。精确解 q(t)=(t²/6,−t²/6)，p(t)=(t/3,−2t/3)，rho=2/3，Gram=3/2，均满足签名正则假设。质量一致加速度为 (1/3,−1/3)。印刷 (4.25) 配合 g(qnew)=0 强制每步 λ=1/2，加速度为 (1/2,−1/2)。用相同精确两步初值、h=1/N，其唯一位置序列为 qn\_k=(k h²/6+k(k−1)h²/4)(1,−1)，终点误差的范数为 (1−1/N)/12，不能被固定 C h² 控制。这是对字面原法二阶解释的反例，不是对当前质量一致 Lean 签名的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.shakePositionOrder`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.shakePositionOrder_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：明确将本 Lean 命题绑定到单独标注的质量一致 SHAKE 修正式，并把原文 (4.25) 的疑误及解释保留在原文审校记录中。若审计目标必须是印刷 (4.25) 的二阶声明，则使用 shakePositionPrinted 并限制 M=I（或另行给出质量与约束反力空间兼容条件）；同时说明结论是以精确两步起步、所选近轨道分支的位置收敛。之后另行补证当前 sorry；本次只读不改代码。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.shakePositionOrder。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 21. MD-4.4-InertiaTracePrinted

- source\_id：MD-4.4-InertiaTracePrinted。

### MD-4.4-InertiaTracePrinted

- 印刷页 / PDF页：169 / 191。
- 原文引文（逐字）：

> This matrix is closely related to the matrix $`R`$:

$$
R=\sum_{i=1}^Nm_i\delta_i\delta_i^T=\sum_{i=1}^Nm_i\|\delta_i\|^2I-T=(T_{11}+T_{22}+T_{33})I-T.\tag{4.40}
$$



- 问题所在：已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 secondMoment 展开为 ∑i m\_iδ\_iδ\_iᵀ；inertiaTensor 如上述定义，trace(T)=2∑i m\_i dot δ\_i δ\_i。签名忠实保留原书错误的末式，故并非转录系数错误，但该全称命题为假；还未显式列出原句中间等式。原书 ERRATUM? 成立，应改系数为 trace(T)/2。实际证明体为 sorry；FAIL 的数学反例独立于 sorry。 网站原文审校另记：
- 反例或理由：满足正质量及质心约束的反例：N=2，m₁=m₂=1，δ₁=(1,0,0)，δ₂=(−1,0,0)。R=diag(2,0,0)，T=diag(0,2,2)，trace(T)I−T=diag(4,2,2)≠R。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.inertiaTracePrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：二阶矩与惯性张量关系的trace(T)系数修正为1/2；原式保留。；`MD.Ch04.inertiaTracePrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“二阶矩与惯性张量关系的trace(T)系数修正为1/2；原式保留。”。
- 导师选项：保留原印刷版本作为原文记录/命题定义，不把它列为已成立定理；在独立纠正版用 trace(T)/2，并显式包含中间等式 R=(∑i m\_i dot δ\_i δ\_i)•I−T。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.inertiaTracePrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 22. MD-4.4-DipolarRotationalPrinted

- source\_id：MD-4.4-DipolarRotationalPrinted。

### MD-4.4-DipolarRotationalPrinted

- 印刷页 / PDF页：170 / 192。
- 原文引文（逐字）：

> Then $`K_{\rm rot}=\sum_{i=1}^N\operatorname{Tr}[\dot\Theta_iR\dot\Theta_i^T]`$, with $`R`$ defined in terms of $`T=\operatorname{diag}(I_1,I_2,I_3)`$ by (4.40).

- 问题所在：已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 函数准确保留印刷求和式且未擅自补1/2；但本条还明确要求 R 由 T=diag(I₁,I₂,I₃) 经(4.40)定义，签名 R 为自由矩阵，未含 T、I 或关系，dΘ 也不绑定旋转矩阵的导数。故全部原句的语义未覆盖；印刷动能缺1/2的 ERRATUM? 成立，并且所引(4.40)另有系数错误。此为 def，无 sorry；并非因没有证明而 FAIL。 网站原文审校另记：
- 反例或理由：缺失条款：R 与 T=diag(I₁,I₂,I₃) 的关系。物理系数核验：R=I₃、T=2I₃、Θ=I₃、Θ̇=skew(e₃)，则印刷函数值2，而 K\_rot=1/2 e₃ᵀT e₃=1。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.dipolarRotationalPrinted`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：转动动能补系数1/2；R应按trace(T)/2·I−T解释并与InertiaTracePrinted\_corrected共同核查。；`MD.Ch04.dipolarRotationalPrinted_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“转动动能补系数1/2；R应按trace(T)/2·I−T解释并与InertiaTracePrinted\_corrected共同核查。”。
- 导师选项：保留印刷函数作为记录，补充其所引 R/T 关系并明确关系本身有原书勘误；另立纠正版采用 R=(trace(T)/2)I−T 与 1/2∑i trace(Θ̇_iRΘ̇_iᵀ)。不要静默修改原印刷条目。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.dipolarRotationalPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 23. MD-4.4-RotationDerivativePrinted

- source\_id：MD-4.4-RotationDerivativePrinted。

### MD-4.4-RotationDerivativePrinted

- 印刷页 / PDF页：168 / 190。
- 原文引文（逐字）：

> An alternative form for the rotational kinetic energy may be obtained by writing

$$
\dot\delta_i=\dot\Theta\delta_i(0)=\dot\Theta\Theta^T\Theta\delta_i(0)=\dot\Theta\Theta^T\dot\delta_i,
$$


> where we have used the fact that $`\Theta`$ is orthogonal.

- 问题所在：签名忠实再现印刷末项：设δ=δ\_i(0)、d=dotΘ(t)，右端确为(dΘ(t)^T)(dδ)。ERRATUM?成立，印刷末项应使用当前配置Θ(t)δ而非速度dδ。它不是正交性和可微性推得的真命题，即使Θ整条轨道属于SO(3)仍失败。HasDerivAt为实际矩阵时间导数；ΘΘ^T=I是正确的正交条件。该decl明确含sorry；此处FAIL来自反例，不是因为sorry，原文忠实性单独为通过。 网站原文审校另记：
- 反例或理由：取Θ(s)=[[cos s,−sin s,0],[sin s,cos s,0],[0,0,1]]，t=0，δ=e1，d=[[0,−1,0],[1,0,0],[0,0,0]]。Θ是全局SO(3)轨道，Θ(0)=I且导数为d；左端de1=e2，右端d²e1=−e1，二者不同。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.rotationDerivativePrinted`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：右端末因子从Θ̇δ改为Θδ，恢复Θ̇δ=(Θ̇Θᵀ)(Θδ)。；`MD.Ch04.rotationDerivativePrinted_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“右端末因子从Θ̇δ改为Θδ，恢复Θ̇δ=(Θ̇Θᵀ)(Θδ)。”。
- 导师选项：原印刷等式仅作为错误陈述记录并显式标注勘误；另立正确命题 dδ=(dΘ(t)^T)(Θ(t)δ)。不要静默改原文，也不要试图证明当前假命题。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.rotationDerivativePrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

## 24. MD-4.4.1-PrincipalAxisField / MD-4.4.1-SecondAxisPrinted / MD-4.4.1-ThirdAxisPrinted

- source\_id：MD-4.4.1-PrincipalAxisField；MD-4.4.1-SecondAxisPrinted；MD-4.4.1-ThirdAxisPrinted。

### MD-4.4.1-PrincipalAxisField

- 印刷页 / PDF页：172 / 194。
- 原文引文（逐字）：

> If $`T`$ is a diagonal matrix, $`T=\operatorname{diag}(I_1,I_2,I_3)`$, then we split the Euler equations and approximate the solution by successive rotations around the three axes of inertia,

- 问题所在：数学上，定义cross3 π (Pi.single i (π i/I i))是对角惯性下合理且正确的单轴分裂场；在I各分量为正的物理域，三个子场之和对应Euler右端，轴编号0,1,2也正确。不得把这个分裂等式推广到任意奇异对角矩阵，因为矩阵总逆与逐分量总除法在奇异处可能不同。本条仅定义场，不声称已证明正角印刷旋转就是其时间h子流。但原书后续第二、第三项确实缺分量下标，当前非明确\_corrected名称的定义采用了补义版本。按原书数学疑误保留并分流要求，整条标NEEDS\_HUMAN，而非将正确的补义场判成数学反例型FAIL。 网站原文审校另记：code：PRINTED\_COMPONENT\_SUBSCRIPTS\_MISSING；stage：A/C；detail：印刷173页的第二、第三个单轴列向量分别印为T₂⁻¹π、T₃⁻¹π，π后没有分量下标；第一项明确印为T₁⁻¹π₁。Lean统一写π\_i/I\_i是已说明的补义，不可当成逐字原式。原书疑误保留待人工。；code：SOURCE\_CORRECTION\_REQUIRES\_HUMAN；stage：C；detail：principalAxisField既非Printed/literal名，也未标\_corrected；虽[EXTRA]披露了补分量下标，当前条目仍混合原文版本与修正解释。补义后的场合理，但本次不替原书裁定两处缺字。
- 反例或理由：code：PRINTED\_COMPONENT\_SUBSCRIPTS\_MISSING；stage：A/C；detail：印刷173页的第二、第三个单轴列向量分别印为T₂⁻¹π、T₃⁻¹π，π后没有分量下标；第一项明确印为T₁⁻¹π₁。Lean统一写π\_i/I\_i是已说明的补义，不可当成逐字原式。原书疑误保留待人工。；code：SOURCE\_CORRECTION\_REQUIRES\_HUMAN；stage：C；detail：principalAxisField既非Printed/literal名，也未标\_corrected；虽[EXTRA]披露了补分量下标，当前条目仍混合原文版本与修正解释。补义后的场合理，但本次不替原书裁定两处缺字。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.principalAxisField`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.principalAxisField_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留原书缺下标的字面记录和NEEDS\_HUMAN。人工确认后，将该统一公式明确登记为principalAxisField\_corrected或等效修正版映射；物理惯性资格与总除法延拓分开说明。不要在字面原式中直接补下标。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.principalAxisField。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.4.1-SecondAxisPrinted

- 印刷页 / PDF页：173 / 195。
- 原文引文（逐字）：

> $`\dot\pi=\pi\times[0,T_2^{-1}\pi,0]^T`$.

- 问题所在：依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 展开Ch04.lean定义得到π×e\_2·(a/I\_2)。依赖没有缺失定义。a是新增独立实参数；若原书无下标π意为独立标量，此参数化可用；若意为动量分量π\_2则a应绑定该分量。原书此标量未定义，不能以参数占位宣称已忠实翻译。惯量由T\_j映射为I\_j符合前文T=diag(I₁,I₂,I₃)的意图，但原式T\_j记法本身也应保留解释记录。[ERRATUM?]缺下标外观确认，数学裁定仍需明确原文标量π含义。无sorry。 网站原文审校另记：
- 反例或理由：未单列反例；问题在原文省略资格、术语、证明步骤或覆盖范围。请结合原句及下列修正核查。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.secondAxisPrinted`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将未定义标量a绑定第二动量分量π₂，补正主惯量；原无下标π保留。；`MD.Ch04.secondAxisPrinted_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将未定义标量a绑定第二动量分量π₂，补正主惯量；原无下标π保留。”。
- 导师选项：请裁定PDF195第2子系统的无下标标量π是否应为π\_2；如是，另建有明示勘误的π×e\_2(π\_2/I\_2)版本，保留当前印刷占位版本，并记录a的含义。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.secondAxisPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.4.1-ThirdAxisPrinted

- 印刷页 / PDF页：173 / 195。
- 原文引文（逐字）：

> $`\dot\pi=\pi\times[0,0,T_3^{-1}\pi]^T`$.

- 问题所在：依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 展开Ch04.lean定义得到π×e\_3·(a/I\_3)。依赖没有缺失定义。a是新增独立实参数；若原书无下标π意为独立标量，此参数化可用；若意为动量分量π\_3则a应绑定该分量。原书此标量未定义，不能以参数占位宣称已忠实翻译。惯量由T\_j映射为I\_j符合前文T=diag(I₁,I₂,I₃)的意图，但原式T\_j记法本身也应保留解释记录。[ERRATUM?]缺下标外观确认，数学裁定仍需明确原文标量π含义。无sorry。 网站原文审校另记：
- 反例或理由：未单列反例；问题在原文省略资格、术语、证明步骤或覆盖范围。请结合原句及下列修正核查。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.thirdAxisPrinted`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将未定义标量a绑定第三动量分量π₃，补正主惯量；原无下标π保留。；`MD.Ch04.thirdAxisPrinted_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将未定义标量a绑定第三动量分量π₃，补正主惯量；原无下标π保留。”。
- 导师选项：请裁定PDF195第3子系统的无下标标量π是否应为π\_3；如是，另建有明示勘误的π×e\_3(π\_3/I\_3)版本，保留当前印刷占位版本，并记录a的含义。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.thirdAxisPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 25. MD-4.4.1-AxisFlowFormal / MD-4.4.1-ExactPlanarRotation

- source\_id：MD-4.4.1-AxisFlowFormal；MD-4.4.1-ExactPlanarRotation。

### MD-4.4.1-AxisFlowFormal

- 印刷页 / PDF页：173 / 195。
- 原文引文（逐字）：

> Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).

- 问题所在：依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 spinAxis展开为R=axisRotation i(tπ\_i/I\_i)，输出(Rπ,ΘRᵀ)；HasDerivAt对实时间求整个三维动量的导数，∀I,π,i且I\_i>0，∀t。正角导数为ω×π，签名右端为π×ω，符号相反；[ERRATUM?]在原矩阵与列动量约定下成立。I\_i>0合理且足够，但不能修复符号。axisFlow含sorry，仅记录证明未完成，FAIL依据签名反例。 网站原文审校另记：
- 反例或理由：取I=(1,1,1)，π=(1,1,0)，i=0，t=0。γ(t)=(1,cos t,sin t)，γ′(0)=(0,0,1)；cross3(γ(0),Pi.single 0 1)=(0,0,−1)。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.axisFlow`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：采用负角旋转子流，独立给初值、轴分量恒定及π×ω的ODE，正角Printed算法保留。；`MD.Ch04.axisFlow_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“采用负角旋转子流，独立给初值、轴分量恒定及π×ω的ODE，正角Printed算法保留。”。
- 导师选项：忠实精确子流应使用axisRotation i(−tπ\_i/I\_i)作用于列动量，并显式γ(0)=π及轴分量恒定；保留原书正角算法作为独立印刷版本，不静默修书。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.axisFlow。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.4.1-ExactPlanarRotation

- 印刷页 / PDF页：173 / 195。
- 原文引文（逐字）：

> Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).

- 问题所在：依赖已展开：Ch04\_deps.txt中MolecularDynamics/Chapter04/ReviewDefinitions.lean的V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ；cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)。axisRotation的三分支分别是主动Rx=[[1,0,0],[0,cosφ,−sinφ],[0,sinφ,cosφ]]、Ry=[[cosφ,0,sinφ],[0,1,0],[−sinφ,0,cosφ]]、Rz=[[cosφ,−sinφ,0],[sinφ,cosφ,0],[0,0,1]]。Pi.single i a在i处为a，其余处为0；矩阵*ᵥ为逐行点积，HasDerivAt断言实际实参数向量导数。量词为任意I、初值π、轴i，在0<I\_i下，所有实t；γ(t)=R\_i(−tπ\_i/I\_i)π。旋转固定第i分量并在t=0为恒等，导数为−(π\_i/I\_i)e\_i×γ=γ×e\_i(γ\_i/I\_i)，因此该签名完整表达了预期主轴子场的精确平面旋转，三个结论均正确；不需要其它轴惯量的正性，选中惯量正性符合物理背景但数学上非零已足够。[EXTRA]负角是该主动矩阵与(4.41)叉积方向下必要的符号选择，并未将p.174正角算法替代为正确精确流。[EXTRA]把第二、第三子场的无下标π解释为π₂/π₃合理且符合p.172对角惯量分裂，但原页字面第二、第三式把向量π放在单个标量分量中，含义未定义；无法对原样展示公式无条件给PASS。需人工确认原书缺下标及T\_i与I\_i的意图；这是原文数学含义问题，不是缺库定义。[ERRATUM?]本条无独立该标签，所涉及缺下标确实存在；正角方向疑点由以上导数支持。签名语义与证明完成度分开：实际exactPlanarRotation的证明体为sorry，本次未写证明、未声称Lean已验证此结论。 网站原文审校另记：
- 反例或理由：未单列反例；问题在原文省略资格、术语、证明步骤或覆盖范围。请结合原句及下列修正核查。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.exactPlanarRotation`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.exactPlanarRotation_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：请确认原页第二、第三式非零项应分别为π₂/I₂、π₃/I₃，并确认T\_i表示对应主惯量。确认后现有负角Lean签名可就解释后的精确平面旋转判PASS；在JSON上下文保留原样展示和勘误说明，勿改原书转录或把sorry当已证。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=CORRECTED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.exactPlanarRotation。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。

## 26. MD-4.4.2-DLMMassOnly / MD-4.4.2-DLMPrintedSystem / MD-4.4.2-DLMPrintedSystemStructure / MD-4.4.2-DLMStructureFormal / MD-4.4.2-DLMPrinted

- source\_id：MD-4.4.2-DLMMassOnly；MD-4.4.2-DLMPrintedSystem；MD-4.4.2-DLMPrintedSystemStructure；MD-4.4.2-DLMStructureFormal；MD-4.4.2-DLMPrinted。

### MD-4.4.2-DLMMassOnly

- 印刷页 / PDF页：174 / 196。
- 原文引文（逐字）：

> “Drift”: step forward a whole step in positions $`q^k:=q^k+hp^k`$.

- 问题所在：已展开 Ch04\_deps.txt 中 Chapter04Review 的 V=Fin 3→ℝ、Mat3=3×3 实矩阵。以下判定针对陈述/定义语义，不以 sorry 的有无判定。展开 rigidDrift M h 得 q+(h/M)p，并且 dlmMassOnly 是含两次 Kick 和五轴 Spin 的完整单体映射。所绑定原文却只有 Step 2 的 q+hp，既引入质量分母，又扩大对象到完整算法。[EXTRA] 描述的是修订算法而非额外数学假设，不能使陈述忠实于所引原句。质量修订有 PDF193 的 dq/dt=p/M 依据，但必须与原式分开；无论证明是否完成均属签名不一致。 网站原文审校另记：
- 反例或理由：取 M=2、h=1、U=0、q=0、p=(1,0,0)、π=0、Θ=1、I=(1,1,1)。Lean 输出 q=(1/2,0,0)，原印刷 Drift 输出 q=(1,0,0)；两者在合法正质量下已不同。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.dlmMassOnly`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.dlmMassOnly_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：原文 Drift 单独绑定 rigidDrift 1 h 或等价字面定义；将 dlmMassOnly 明确标记为另一个有依据的质量修订算法，并补其完整修订陈述及单体范围，而不要把 q+hp 的原句绑定到它。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.dlmMassOnly。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.4.2-DLMPrintedSystem

- 印刷页 / PDF页：174 / 196。
- 原文引文（逐字）：

> DLM Rigid Body Molecular Dynamics Step
> 1. “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:

$$
p^k:=p^k+\tfrac h2 F^k,\quad\pi^k:=\pi^k+\tfrac h2\tau^k.
$$


> 2. “Drift”: step forward a whole step in positions

$$
q^k:=q^k+hp^k.
$$


> 3. “Spin”: update the rotational state of the kth rigid body by the sequence of steps

$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$


> 4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $`F^k`$ and torques $`\tau^k`$ evaluated at the current $`q,\Theta`$.

- 问题所在：字面忠实性核对通过，未发现应判FAIL的Lean语义偏差：Drift确为q+h p，未私补质量；Spin保留正角及配对的Rπ、ΘRᵀ，矩阵乘法方向正确。每个子步从其输入重新计算角度，不冻结初始π；所有刚体均执行。两次kick分别从各自输入完整状态计算耦合力/力矩，末kick使用Drift/Spin后的全部q、Θ，不复用旧力。定义域包括N : ℕ、逐体三维惯性I、任意实数h及任意所给U；定义无I>0或光滑性前提，这些物理资格不能假称已在定义中。总体NEEDS\_HUMAN仅依任务对原书数学疑点的分流规则：质量归一化及旋转动力学约定待确认。Printed版忠实，故不判FAIL；质量/旋转方向疑点也不是不辛反例。 网站原文审校另记：code：SOURCE\_PUNCTUATION；field：statement\_latex；severity：correction；detail：步骤1原式以逗号连接两种动量更新；步骤3的五行旋转更新末尾没有输入所加的四个逗号和一个句号。已恢复这些字面标点，五个角度及所有更新公式保持原样。；code：SOURCE\_MASS\_CONVENTION\_UNRESOLVED；field：context\_notation / issues；severity：source\_needs\_human；detail：第195页称p^k为linear momentum vector，第196页原Drift却为q^k := q^k + h p^k。若质量未取单位值，通常需要质量约定；附件这两页没有给出归一化解释。按要求保留原式并交人审，不静默插入1/M\_k。；code：SOURCE\_SPIN\_CONVENTION\_UNRESOLVED；field：context\_notation / issues；severity：source\_needs\_human；detail：原表使用正角Θ^x/Θ^y/Θ^z、π^k := Θπ^k、Θ^k := Θ^kΘ^T，且页上明确Θ^x的正角矩阵；第195页另列方向演化方程。其与原物理动力学的一致性保留为原书约定/勘误疑点，不自动判为映射不辛。
- 反例或理由：code：SOURCE\_PUNCTUATION；field：statement\_latex；severity：correction；detail：步骤1原式以逗号连接两种动量更新；步骤3的五行旋转更新末尾没有输入所加的四个逗号和一个句号。已恢复这些字面标点，五个角度及所有更新公式保持原样。；code：SOURCE\_MASS\_CONVENTION\_UNRESOLVED；field：context\_notation / issues；severity：source\_needs\_human；detail：第195页称p^k为linear momentum vector，第196页原Drift却为q^k := q^k + h p^k。若质量未取单位值，通常需要质量约定；附件这两页没有给出归一化解释。按要求保留原式并交人审，不静默插入1/M\_k。；code：SOURCE\_SPIN\_CONVENTION\_UNRESOLVED；field：context\_notation / issues；severity：source\_needs\_human；detail：原表使用正角Θ^x/Θ^y/Θ^z、π^k := Θπ^k、Θ^k := Θ^kΘ^T，且页上明确Θ^x的正角矩阵；第195页另列方向演化方程。其与原物理动力学的一致性保留为原书约定/勘误疑点，不自动判为映射不辛。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.dlmPrintedSystem`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.dlmPrintedSystem_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留全部Printed公式和Lean定义。采用corrected\_json修复摘录标点并保留原书疑点；由人工核查单位质量/动量约定及Spin与原动力学的符号约定。若需物理勘误版，应另立\_corrected声明并单独审校，本轮不修改工程。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.dlmPrintedSystem。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.4.2-DLMPrintedSystemStructure

- 印刷页 / PDF页：173 / 195。
- 原文引文（逐字）：

> The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

- 问题所在：签名的字面忠实性核对通过。全部对象、域、量词及两个实质前提与给定定义相容：任意有限N体、逐体正主惯性矩、联合全局C³耦合势、任意实h。结论是该具体完整Printed组合对每一个SO(3)输入保持SO(3)输出，并对任意两条全系统切向量保持∑rbForm的真实Fréchet拉回；没有缩为单体、没有遗漏末次力/力矩重算、没有以预设辛性或抽象占位形式替换目标。正惯性和全环境全局C³属于显式[EXTRA]限缩，已细化披露。原句的可靠性解释不是额外定量定理，未形式化为误差界不构成结论遗漏。theorem中sorry仅表示证明未交付，不作为FAIL理由，本轮也不声称Lean证明已完成。总体NEEDS\_HUMAN依任务对原书质量及Spin动力学约定疑点的保留规则；这与签名忠实性通过并存。特别是无质量Drift及正角配对Spin本身都不能推出映射不辛，未据此提出辛性反例。 网站原文审校另记：code：EXTRA\_GLOBAL\_REGULARITY\_CLARIFIED；field：extra\_assumptions / statement\_scope；severity：correction；detail：原备注“C³耦合势”不够精确。Lean要求Function.uncurry U在完整位置×实矩阵环境空间上全局联合C³，强于仅在SO(3)配置上的光滑性，已按[EXTRA]技术资格明确；另逐项列出∀k i的正惯性及N、h的量词域。；code：SOURCE\_MASS\_CONVENTION\_UNRESOLVED；field：issues / context\_notation；severity：source\_needs\_human；detail：本条指向条目4同一个原表，而原表的p线动量与q+h p之间的质量约定仍待人工确认。保留原句和Printed对象，不把疑点写成Lean遗漏的质量变量。；code：SOURCE\_SPIN\_CONVENTION\_UNRESOLVED；field：issues / context\_notation；severity：source\_needs\_human；detail：combined scheme指向原表字面正角Spin，还是意指与原运动方程一致的物理方案，其符号约定需人审确认；原句不作静默勘误。此分流不是对所给两形式保持结论的否证。
- 反例或理由：code：EXTRA\_GLOBAL\_REGULARITY\_CLARIFIED；field：extra\_assumptions / statement\_scope；severity：correction；detail：原备注“C³耦合势”不够精确。Lean要求Function.uncurry U在完整位置×实矩阵环境空间上全局联合C³，强于仅在SO(3)配置上的光滑性，已按[EXTRA]技术资格明确；另逐项列出∀k i的正惯性及N、h的量词域。；code：SOURCE\_MASS\_CONVENTION\_UNRESOLVED；field：issues / context\_notation；severity：source\_needs\_human；detail：本条指向条目4同一个原表，而原表的p线动量与q+h p之间的质量约定仍待人工确认。保留原句和Printed对象，不把疑点写成Lean遗漏的质量变量。；code：SOURCE\_SPIN\_CONVENTION\_UNRESOLVED；field：issues / context\_notation；severity：source\_needs\_human；detail：combined scheme指向原表字面正角Spin，还是意指与原运动方程一致的物理方案，其符号约定需人审确认；原句不作静默勘误。此分流不是对所给两形式保持结论的否证。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.dlmPrintedSystemStructure`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.dlmPrintedSystemStructure_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：不修改该Printed声明或补证明。采用corrected\_json明确全局联合C³等[EXTRA]资格，并人工确认原书表格与物理约定、combined scheme的指代。若另需物理一致性修正版，应以独立\_corrected对象处理；不得在本条悄悄补质量、翻转角度或因sorry判FAIL。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=NEEDS\_HUMAN；该判定的声明为 MD.Ch04.dlmPrintedSystemStructure。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：未单列网站 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.4.2-DLMStructureFormal

- 印刷页 / PDF页：173–174 / 195–196。
- 原文引文（逐字）：

> The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

- 问题所在：依赖定位：Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean 分段。V=Fin 3→ℝ，Mat3=3×3 实矩阵，RBState=(V×V)×(V×Mat3)，依次为(q,p,π,Θ)。rbTangent(z,v) 为 ΘᵀδΘ+δΘᵀΘ=0；rbForm 用 ξ=rot(ΘᵀδΘ)/2、η=rot(Θᵀδ′Θ)/2，取 δq·δ′p−δ′q·δp+ξ·δ′π−η·δπ+π·(ξ×η)。rbSymplectic 量化所有满足 ΘᵀΘ=1、det Θ=1 的输入和两个实际切向量，要求真实 fderiv 的两形式拉回等式；它本身未要求输出 SO(3) 或输出导数切向性，不能仅凭谓词名字推断这些结论。axisRotation 的 x 轴矩阵为 [[1,0,0],[0,cos φ,−sin φ],[0,sin φ,cos φ]]，y、z 为对应标准主动旋转。spinAxis 每次由当前 π\_i 计算 φ=hπ\_i/I\_i，更新 (Rπ,ΘRᵀ)；spinStep 的函数复合从右向左执行 x(h/2),y(h/2),z(h),y(h/2),x(h/2)。rigidKick 同时以 −grad U 和 −rot(ΘᵀmatrixGrad U) 更新两种动量；rigidDrift 使用 q+h p/M；dlmMassConsistent 是半 kick、drift、spin、半 kick。签名量词为任意正 M、正主惯性 I、C³ 单体势 U、任意 h；另对每个 SO(3) 输入要求逆步复合为恒等及输出正交性。正质量和正惯性合理，C³ 是较强但合理的技术资格；回逆与正交性是原引用句以外的算法性质，不应当作该句逐字结论。该对象是质量修订的 N=1 实例，而原文为全部刚体、可耦合势的完整系统；[EXTRA] 明示单体并不能补足原结论。签名中的质量一致也只修订 drift，spin 仍是印刷正角，名称不能当作精确原动力学流的证据。正角子步可看作负旋转动能的 Hamilton 子流，因此与原方程符号不符本身不反证辛性。此 FAIL 针对原文对象范围与陈述对应，而非由 sorry 推断数学命题为假。实际证明体含 sorry，独立于签名审计。 网站原文审校另记：
- 反例或理由：缺失条款：N 任意、每体完整(q,p,π,Θ)状态、允许 U(q¹,…,qᴺ,Θ¹,…,Θᴺ) 耦合全部刚体。以 N=2 且 U=q¹₁q²₁ 为例，原文要求两体相互作用；该签名单个 V×Mat3 的 U 参数不能表示这个完整系统。此为范围缺失示例，不是单体辛性为假的反例。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.dlmStructure`（未证）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。；`MD.Ch04.dlmStructure_corrected`（未证）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。”。
- 导师选项：保留此条时明确标作单体特例，并将它与原文完整结构声明区分；原句的完整 formalization 应量化 N、各体惯性、C³ 耦合 U，使用 rigidSystemSymplectic(dlmPrintedSystem I U h)，并显式包含输入/输出 SO(3) 约束。质量修订对象须另列，不替换原表；若要求对应原动力学精确子流，另列带负角的修订 spin，并保留印刷正角疑误。 回逆性和输出正交性可作为单独算法性质保留，不能当作引用句明确给出的结论。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=APPROVED；原文版、旧限定解释或既有修正版的所交签名整体 verdict=FAIL；该判定的声明为 MD.Ch04.dlmStructure。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。


### MD-4.4.2-DLMPrinted

- 印刷页 / PDF页：174 / 196。
- 原文引文（逐字）：

> DLM Rigid Body Molecular Dynamics Step
> 1. “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:

$$
p^k:=p^k+\tfrac h2 F^k,\quad\pi^k:=\pi^k+\tfrac h2\tau^k.
$$


> 2. “Drift”: step forward a whole step in positions

$$
q^k:=q^k+hp^k.
$$


> 3. “Spin”: update the rotational state of the kth rigid body by the sequence of steps

$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T.
$$


> 4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $`F^k`$ and torques $`\tau^k`$ evaluated at the current $`q,\Theta`$.

- 问题所在：按Printed的字面忠实性标准PASS，限明确声明的N=1实例。右侧先作用的复合依次是Kick(h/2)、Drift(1,h)、Spin(h)、Kick(h/2)，与原表顺序一致。printedSpinStep虽为函数复合，回文轴序使实际顺序仍为x半、y半、z全、y半、x半；每一步角度从当前s.1分量重新取值。动量用Rπ，方向用ΘRᵀ；最后Kick在更新后的q、Θ处重新求力和力矩。没有擅自加入质量因子或改正角。原书质量和符号疑点在json\_review标NEEDS\_HUMAN，不作为字面定义的FAIL。 网站原文审校另记：code：PRINTED\_DRIFT\_MASS\_FACTOR\_QUERY；stage：A；detail：印刷drift确为qᵏ:=qᵏ+h pᵏ，无1/M。该字面算法可作单位质量约定；是否原书漏写一般质量因子，保留待人工，不擅自加因子。；code：PRINTED\_SPIN\_SIGN\_QUERY；stage：A；detail：印刷确为正角R、π:=Rπ、Θ:=ΘRᵀ。其一阶旋转方向与同页组Euler方程π×T⁻¹π及dotΘ=Θskew(T⁻¹π)存在符号疑点；这是原书问题，字面忠实性审校不能自动改成负角。；code：SOURCE\_DISPLAY\_PUNCTUATION；stage：A；detail：原表第1步p与π的更新由逗号分隔，JSON原用分号；现按原页恢复，算法含义不变。
- 反例或理由：kind：source\_consistency\_diagnostic\_not\_a\_counterexample\_to\_literal\_fidelity；detail：手工一阶符号核对：x轴单步取I₁=1、π=(1,1,0)。π×(π₁e₁/I₁)=(0,0,−1)，而原印R\_x(hπ₁/I₁)π在h=0的一阶变化为(0,0,1)。这说明不能从Printed定义另推其为同号Euler子流；不否定它逐字编码了原表，也不否定其辛性。非数值实验、非Lean验证。
- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：`MD.Ch04.dlmPrinted`（定义）。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。
- 修正版 Lean 名称、改动内容、证明状态：独立保留单位质量的印刷算法解释，质量取1才将Drift写成q+hp；Spin仍按印刷约定，仅解释该组合定义，不称其为一般质量或π×ω原动力学的一致子流。质量修订和轴流符号另列工作版本。；`MD.Ch04.dlmPrinted_corrected`（定义）。
- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“独立保留单位质量的印刷算法解释，质量取1才将Drift写成q+hp；Spin仍按印刷约定，仅解释该组合定义，不称其为一般质量或π×ω原动力学的一致子流。质量修订和轴流符号另列工作版本。”。
- 导师选项：保留dlmPrinted的正角、Rπ、ΘRᵀ和单位质量字面drift；人工核定一般质量约定及旋转方向。若需物理修正版，另立\_corrected声明并记录改动，不覆盖Printed。 默认仅采用本文并列的限定修正版，原书解释仍待确认。
- 网站复审结论：原文转录栏状态=NEEDS\_HUMAN；原文版、旧限定解释或既有修正版的所交签名整体 verdict=PASS；该判定的声明为 MD.Ch04.dlmPrinted。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source\_id保留原判定。反例：返回正文已讨论，未单列独立 verdict。 网站语义审校与本地证明状态分别记录。

