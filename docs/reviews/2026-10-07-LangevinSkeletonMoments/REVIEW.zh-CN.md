# Theorem 6.2 依赖：真实 skeleton 几何矩、物理能量尾界及紧性

对应印刷251–254/PDF272–275原Theorem6.2实际过程的Lyapunov与不变律存在证明路线。原PDF哈希重新核对一致；复用同一PDF272、273页既有视觉核对，未新增274、275页视觉检查。3个公开声明只补原实际核不变律构造所需矩/紧性依赖，不独立推广抽象Lp或Markov模型。

从已验sameκ H^l halfdrift取共同τ>0与各l≥1真实D>0。实际所有有限时刻H^l可积使真实Chapman–Kolmogorov可用Bochner integral_comp，而非在无可积性的totalized积分下推导。得到n步期待递推并从实际κ_0=Dirac x归纳：
κ_(nτ)H^l(x)≤(1/2)^n H^l(x)+2D(1-(1/2)^n)。
D从真正SDE路径和高次噪声矩推导，没有目标矩/drift或stationarity前提，σ任意、γ>0、单位质量、U≥1/C∞periodic/真实forceLip。

因此对每个固定初值x，所有n的期待≤H^l(x)+2D。实际非负物理H^l、真正可积性和Markov不等式推出
κ_(nτ)x({H^l≤R}ᶜ)≤ofReal((H^l(x)+2D)/R)，R>0。
使用概率测度的有限性核对real-to-ENNReal转换，不将supnorm当作物理坐标平方和。该估计对所有n与所有x分别成立，但右侧依赖初值，不声称所有x整体一致紧性。

对原H1的proper能量子水平集，以R=(H1(x)+2D)/ε.toReal+1处理有限正ε，ε=∞单独处理，给每个固定x的actualskeleton transition laws tight。共同τ不依赖l。紧性是同一真实law family的性质；未将弱收敛子列直接当作invariantlaw、未声称全连续时间uniformmoment或不变律唯一性/weighted-test指数收敛。

local01补集member类型需显式否定不等式，及field_simp已完成后多余ring警告；修为显式show ¬V y≤R并删除ring，未抬资源或禁linter。local02全3退出0、零error/Leanwarning、空日志，Draft正式源exactSHA一致；原失败保留。DEP111/NOT120等待full-check01。

原density exists/closed-time端点语义、actualcontinuousgenerator identity/literalAssumption2、Harris完整结论、Theorem6.2整体、负责人语义与全CORE_SCOPE继续pending。下一同actualκ的Cesaro概率平均、tight及真正weakcompact性，核对一步平均误差趋零后才推invariance，不把stationarity藏在输入。

full-check01 passed：9146 jobs/2400公理声明/229exact inputs；10checks退出0、全部input/rawlog SHA匹配、3public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。same实际原Hl的nτ几何期待界、物理energy Markov尾界和eachfixedx actualskeleton law tight已机器验证；无density/目标矩漂移/stationarity前提，tight未当作invariantlaw，continuousgenerator/densityexists/Harris未证，owner semanticpending，Theorem6.2整体未完成。
