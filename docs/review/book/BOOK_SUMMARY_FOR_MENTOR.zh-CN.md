# 第1–8章正文数学形式化成果汇报

## 1. 结论与范围

已整理Leimkuhler–Matthews《Molecular Dynamics》（2015）第1–8章正文的原文、数学陈述、对照说明、独立语义审校意见与证明状态，不含习题及附录。共1282个正文条目、2285个命名声明，其中1135项定义、527项已证陈述、623项未证陈述。网站按当前整条内容通过967条，另46条按审校意见修复并经本地核验，265条需人工判断，4条仅补充摘录后完成本地核对。仍未处理的失败项为0。正式证明材料没有未完成证明，也没有新增公理；逐章待证材料与正式证明明确分列。

## 2. 方法与可信度

例如，原书“严格极小点的Hessian正定”不能照字面作为正确结论：U(x)=x⁴在0严格极小，但二阶导数为0。材料保留原句，另列半正定修正版及反例，核查人可直接比较结论与前提。相同方法用于其他正文条目：原文 → Lean数学陈述 → 成分对照表 → 独立语义审校 → 定义或证明状态。
编译检查确认陈述有正确类型，现有证明确实证明了所写结论；逐声明依赖检查区分完成证明与尚依赖未证结论的材料。编译本身不能判断陈述是否忠实于教材，也不能将未写证明的命题变成已证定理。语义审校比较对象、量词、假设、结论、符号和原页，能够指出转录、范围或原文问题；它仍可能遗漏细节，不能代替严格证明或导师逐条裁定。
使用Lean 4.34.0和固定Mathlib版本。正式材料中无证明占位、无新增公理，并不表示完全不使用通常的逻辑基础；逐章待证材料不冒充正式定理。此处复核既有成功检查与当前相同的数学文件，未重新开展证明。
定义确有一定重复。为了让每章能按原文独立阅读，常把坐标、梯度、概率权重及算法写成局部定义；这有助于对照，但定义数量不能当作定理成果。是否统一，应先比较对象及参数约定。
[EXTRA]表示为严格数学解释补充或明确的前提。例如规范平均须有可积性及非零归一因子；除法、平方根或经典导数还需相应有效域。它说明“在这些条件下讨论”，并不宣称这些条件已从原书推出。人工阅读时先看原句和并列修正版，再逐项核对[EXTRA]、适用域、反例及证明状态；修正版获认可不能替原书疑误作最终裁定。

## 3. 分章总表与主要内容

|章|印刷页 / PDF页|条目|整条通过|本地修复|需人工|定义|已证|未证|疑误单节数|
|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|1|1–46 / 24–69|141|110|10|21|90|70|46|22|
|2|53–94 / 75–116|160|125|4|31|85|59|78|25|
|3|97–136 / 119–158|149|97|10|42|73|59|103|30|
|4|139–174 / 161–196|179|126|7|44|130|65|79|26|
|5|179–209 / 200–230|183|140|6|35|97|57|100|26|
|6|211–258 / 232–279|249|203|8|38|123|110|91|33|
|7|261–326 / 282–347|118|90|1|27|251|53|69|29|
|8|329–399 / 350–420|103|76|0|27|286|54|57|31|
|合计|正文，不含习题|1282|967|46|265|1135|527|623|222|

第4、5章各另有2条摘录本地核对，所以每章“整条通过＋本地修复＋需人工＋摘录核对＝条目数”。通过数不含只对修正版给出的部分认可；疑误单节数是合并问题记录数，与需人工条目数不一一对应。页码给章正文所在物理范围；末页兼有习题时只取习题前正文，数学条目实际页界另见统计文件。

**第1章：经典力学与动力系统。** 整理势能、Newton与Hamilton方程、流、平衡与线性化；已有能量守恒、谐振子能量和同初值唯一性等证明。一般拓扑线性化、作用角及稠密性、散射与部分变分结果仍待补充。

**第2章：数值积分与几何结构。** 整理Verlet、变分构造、辛性、组合及Runge–Kutta类方法；包含可直接复用的导数、积分保持和算法关系结果。统一误差界、一般阶数与辛条件的完整证明仍有缺口。

**第3章：几何积分的误差分析。** 整理Lie导数、Poisson括号、修正Hamiltonian、时间对称与碰撞方法；已有部分代数恒等式和具体算法结果。形式展开与真实流的衔接、长时间和指数小误差结论尚未全部证明。

**第4章：稳定性、约束与刚体。** 整理振子稳定阈值、多时间步、SHAKE/RATTLE及刚体坐标；已有部分线性代数与具体模型结果。一般约束流、全局算法资格与刚体几何结果仍需理论支持。

**第5章：相空间分布与微正则平均。** 整理概率演化、Liouville方程、微正则测度和遍历平均；已有若干测度、代数与有限范围的推论。曲面测度识别、算子域及一般遍历结论仍未完成。

**第6章：正则分布与随机微分方程。** 整理Gaussian、OU过程、Itô及Fokker–Planck、Brownian与Langevin遍历性；已有部分概率恒等式和明确条件下的局部结果。一般随机积分、解的存在唯一性、闭算子和全局遍历性是主要缺口。

**第7章：随机数值方法与采样误差。** 整理强弱误差、分裂、谐振子矩、修正密度和受约束Langevin；已证明受约束组合输出的可测性与概率律等有限结果。一般阶数、长期误差和随机初值下条件解仍待证明。

**第8章：扩展变量恒温器。** 整理Nosé–Hoover、NHL、等动能、广义Langevin、活塞及DPD；已有部分局部恒等式、修正关系与不等质量反例。一般驻定测度、全局遍历性及若干交换子计算仍未完成。

## 4. 原书疑误与优先裁定项

全书勘误单共222个编号节，按本次区分有215项原书表述、论证或资格疑问，另7项解释、范围或原证明核查。相同数学矛盾可能影响多条，数量不代表独立排印错误数，也不代表导师已认可的错误数。按主要问题分为以下类型；混合问题仅归一类以便核对。

|主要类型|项数|
|---|---:|
|印刷或公式符号疑误|58|
|结论过强|22|
|缺前提或适用范围|56|
|记号或指代矛盾|33|
|论证或适用范围待核|46|

以下24项优先请导师裁定；建议版本均供选择，详细原句、理由及证据见各章勘误单。

|章|印刷页|问题|建议版本|
|---|---|---|---|
|1|[21](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH01_ERRATA.zh-CN.md#2-md-12-radialljforceliteral)|径向Lennard–Jones力与势梯度的符号相反|采用力为负梯度的版本|
|1|[31–32](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH01_ERRATA.zh-CN.md#6-md-153-hartmangrobmanliteral)|一般双曲系统不保证光滑线性化|以拓扑共轭表述Hartman–Grobman定理|
|1|[37](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH01_ERRATA.zh-CN.md#10-md-161-minimumhessianliteral)|严格极小点的Hessian未必正定|改为半正定；正定需另加非退化条件|
|1|[42](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH01_ERRATA.zh-CN.md#13-md-171-transitivityergodicityliteral)|拓扑传递不能与测度遍历直接等同|明确拓扑及不变测度，分列两性质|
|1|[44–45](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH01_ERRATA.zh-CN.md#15-md-172-variationalequationliteral)|变分矩阵使用了演化后再次复合的取值点|使用初值处的真实流导数|
|2|[62](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH02_ERRATA.zh-CN.md#2-md-221-variationalderivativeprinted)|变分导数展开漏去泛函基值|对F(q+εη)−F(q)展开|
|2|[73; 79](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH02_ERRATA.zh-CN.md#11-md-231-variationalprinted--md-234-hamiltonsymplectic--md-234-hamiltonvariationalprinted)|Hamilton流的变分方程沿用错误取值点|在初值处求空间导数并沿轨道取系数|
|2|[92](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH02_ERRATA.zh-CN.md#22-md-253-newmarkreduction)|一般质量下Newmark关系与Verlet的对应缺质量因子|采用保留质量逆矩阵的版本|
|3|[113](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH03_ERRATA.zh-CN.md#8-md-334-processorenergyprinted)|处理后的能量估计漏去势能，常势即给反例|首界将动能T改为总能量H=T+U|
|3|[114–116; 115](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH03_ERRATA.zh-CN.md#10-md-34-thm31--md-34-truncatedconservation--md-34-energytelescoping--md-34-uniformtruncatedlipschitz--md-34-physicalenergydrift)|长时间能量估计依赖统一正则性与轨道域条件|明确有限截断、共同常数及时间尺度|
|4|[140; 141](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH04_ERRATA.zh-CN.md#2-md-4-symplecticeulerboundaryprinted--md-4-verletboundaryprinted--md-4-verletstability--md-4-symplecticeulerunitroots--md-4-symplecticeulerstability)|稳定边界的单位模特征值可伴随Jordan增长|有界稳定要求排除非平凡Jordan块|
|5|[183](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH05_ERRATA.zh-CN.md#1-md-521-domainl2--md-521-l2complete--md-521-l2norm)|L²函数作为逐点函数时范数和完备性存在商空间问题|采用几乎处处等价类并写清函数空间|
|6|[220](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH06_ERRATA.zh-CN.md#4-md-614-canonicalaverageprinted)|规范平均原印式出现重复归一因子|按概率密度或未归一权重择一归一|
|6|[250–251; 251](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH06_ERRATA.zh-CN.md#23-md-643-theorem61--md-643-theorem61timeaverageprinted)|分布平均收敛不能直接替代轨道时间平均|分列两结论并明确各自遍历条件|
|6|[252](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH06_ERRATA.zh-CN.md#26-md-644-minorizationprinted--md-644-minorizationcorrectedimplication)|空小集和无密度情形使小集推论不足|补非空内部及相应转移密度资格|
|6|[254](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH06_ERRATA.zh-CN.md#29-md-644-definition61)|把确定性漂移单独放入生成族不足以推出随机平滑|采用与噪声及其交换子相容的条件|
|7|[289](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH07_ERRATA.zh-CN.md#11-md-772-spectralqualification)|离散谱不意味着特征值均为单重|改为离散谱及有限重数，另审单重性|
|7|[299](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH07_ERRATA.zh-CN.md#13-md-791-triplecommutatorprinted)|三重交换子展示式的共同β因子疑漏|采用补齐β因子的独立版本|
|7|[318](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH07_ERRATA.zh-CN.md#23-md-712-constrainedhosplitting)|普通λdt不能一般抵消约束法向随机噪声|采用可含随机部分的约束反作用冲量|
|8|[333](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH08_ERRATA.zh-CN.md#1-md-811-nhfirstintegralprinted)|s′=ξ与含log s的Nosé–Hoover第一积分不相容|取s′=sξ，或同步修改第一积分|
|8|[334](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH08_ERRATA.zh-CN.md#3-md-8121-npequations)|同名Nosé能量的自由度系数前后不同|明确选择n版能量及匹配初始常量|
|8|[337–338](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH08_ERRATA.zh-CN.md#4-md-821-examples81and82)|正号耦合与所列Gaussian驻定密度不相容|采用负号耦合并保留原印式供比对|
|8|[345–346](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH08_ERRATA.zh-CN.md#8-md-841-nhl)|质量归一的坐标、动量缩放方向颠倒|取q̃=M¹ᐟ²q、p̃=M⁻¹ᐟ²p并同步变换势|
|8|[389](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH08_ERRATA.zh-CN.md#29-md-891-dpdmassorderprinted)|不等质量下DPD涨落耗散式的矩阵乘法次序不当|将质量逆矩阵置于噪声协方差右侧|

已更正的转录错误单列，不计入上述原书疑误：第6章OU方差根号、分部积分符号、定理6.2的κ，以及第7章九字母分裂串和一阶修正表符号。不能把先前抄错归责于教材。完整索引还保留只需解释而未确认有错的记录。

## 5. 未证明部分与下一阶段优先级

未证共623项：缺少理论或必要衔接347项，原书疑误原文版暂不证明155项，短证明尝试次数用尽121项。最后一类只说明当前路线未解决，不意味着命题错误；第一类也含已有理论与当前表示之间的衔接工作。

|缺失理论主组|涉及声明数|章节|
|---|---:|---|
|Hartman–Grobman与局部动力系统|3|1|
|Liouville–Arnold与环面稠密性|2|1|
|Hörmander与随机平滑|3|6、8|
|遍历性、混合与长期收敛|33|1、2、3、5、6、7、8|
|几何测度与微正则测度|12|5|
|凸分析、矩阵估计与势能几何|19|1、2、4、5、6、7、8|
|谱理论、偏微分方程与函数空间|54|1、2、3、4、5、6、7、8|
|随机极限与时间尺度|5|6、7|
|局部驻定散度与概率权重|17|2、6、7、8|
|Gaussian矩与有限维概率计算|17|6、7、8|
|SDE、随机积分与随机过程|21|5、6、7、8|
|反向误差、形式展开与修正测度|35|1、2、3、4、5、6、7、8|
|几何约束、辛结构与刚体|27|1、2、3、4、5、8|
|ODE、微积分与数值误差衔接|67|1、2、3、4、5、6、7、8|
|模型专门计算及其他衔接|32|1、2、3、4、5、7、8|

表中每项只进入一个主组，未重复相加；一个定理实际可能依赖多个领域。一般SDE存在唯一性等还可能只列在覆盖说明中，尚未单列为待证定理，不能把上表随机过程项数当成存在唯一性定理数。建议先评估随机分析基础，再决定遍历性、随机平滑及长期采样误差的优先次序；几何积分一侧可独立推进反向误差与辛结构证明。逐声明清单见[未证与理论缺口](BOOK_GAPS.zh-CN.md)。

## 6. 已知局限

定义复用扫描得到：逐章材料与正式材料同短名候选290对，涉及279项逐章定义；参数及定义体字面同式172对；跨章近似重复候选19组，涉及39项定义。这些集合重叠，不能相加。梯度、相空间坐标、Gibbs权重及规范平均是代表例子；同短名并不自动等价，具体清单见[定义复用与重复候选](BOOK_REDUNDANCY.zh-CN.md)。
本次只整理第1–8章正文，不做习题；图示经验现象、引用文献中的完整理论和未形式化的结论范围仍需按原文说明理解。独立语义审校是工具辅助，不是导师或第三方数学家逐条人工签认。对局部散度、生成元或有限维模型的结论，不自动提升为全局流不变性、概率平稳性或遍历性。

## 7. 请导师决定的事项

1. 疑误按“保留原印＋并列工作修正”裁定，还是逐项联系其他核查人；先审哪些高影响问题。
2. 下一阶段是否补完整证明；随机分析基础、遍历与混合、几何积分误差理论如何排序。
3. 是否统一重复定义，以及允许统一到何种坐标、质量和函数空间约定。
4. 正文对照材料的粒度、汇报篇幅和交付格式是否需要调整。

## 8. 文件导航

主入口为[仓库全书审阅导航](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/book/README.zh-CN.md)。数学内容基于[第1–8章收口版本](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/tree/book-ch01-08-closeout)，本汇报及导航固定于版本book-ch01-08-render-v2；均可在[仓库](https://github.com/zhuanxv-G/MolecularDynamicsFormalization)访问。
各章短摘要、勘误、完整逐条对照和Lean数学文件用途如下；数学文件仅链接，离线包不复制。

|章节|短摘要|疑误与选项|完整对照|数学文件|
|---|---|---|---|---|
|1|[SUMMARY](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md)|[ERRATA](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH01_ERRATA.zh-CN.md)|[BLUEPRINT](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH01_BLUEPRINT.zh-CN.md)|[Lean](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/Blueprint/Ch01.lean)|
|2|[SUMMARY](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH02_SUMMARY_FOR_MENTOR.zh-CN.md)|[ERRATA](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH02_ERRATA.zh-CN.md)|[BLUEPRINT](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH02_BLUEPRINT.zh-CN.md)|[Lean](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/Blueprint/Ch02.lean)|
|3|[SUMMARY](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH03_SUMMARY_FOR_MENTOR.zh-CN.md)|[ERRATA](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH03_ERRATA.zh-CN.md)|[BLUEPRINT](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH03_BLUEPRINT.zh-CN.md)|[Lean](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/Blueprint/Ch03.lean)|
|4|[SUMMARY](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH04_SUMMARY_FOR_MENTOR.zh-CN.md)|[ERRATA](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH04_ERRATA.zh-CN.md)|[BLUEPRINT](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH04_BLUEPRINT.zh-CN.md)|[Lean](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/Blueprint/Ch04.lean)|
|5|[SUMMARY](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH05_SUMMARY_FOR_MENTOR.zh-CN.md)|[ERRATA](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH05_ERRATA.zh-CN.md)|[BLUEPRINT](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH05_BLUEPRINT.zh-CN.md)|[Lean](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/Blueprint/Ch05.lean)|
|6|[SUMMARY](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH06_SUMMARY_FOR_MENTOR.zh-CN.md)|[ERRATA](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH06_ERRATA.zh-CN.md)|[BLUEPRINT](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH06_BLUEPRINT.zh-CN.md)|[Lean](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/Blueprint/Ch06.lean)|
|7|[SUMMARY](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH07_SUMMARY_FOR_MENTOR.zh-CN.md)|[ERRATA](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH07_ERRATA.zh-CN.md)|[BLUEPRINT](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH07_BLUEPRINT.zh-CN.md)|[Lean](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/Blueprint/Ch07.lean)|
|8|[SUMMARY](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH08_SUMMARY_FOR_MENTOR.zh-CN.md)|[ERRATA](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH08_ERRATA.zh-CN.md)|[BLUEPRINT](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/docs/review/CH08_BLUEPRINT.zh-CN.md)|[Lean](https://github.com/zhuanxv-G/MolecularDynamicsFormalization/blob/book-ch01-08-render-v2/Blueprint/Ch08.lean)|

全书[统计](BOOK_STATS.csv)、[统计口径差异](BOOK_STATS_DIFF.md)、[疑误索引](BOOK_ERRATA_INDEX.zh-CN.md)、[未证清单](BOOK_GAPS.zh-CN.md)可进一步定位。各章既有短摘要保留原状，数字差异以本次统一统计及其解释为准。
