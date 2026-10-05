# Theorem6.2 的实际初值/噪声路径联合可测性依赖

对应原页印刷252/PDF273的真实Markov模型必要依赖，沿用上一批重新目视记录 tmp/chapter6-causal/page-273.png。Theorem6.2本身的条件Markov/密度/生成元/Harris证明仍分别pending。

## 实际数学链

对真正积分解使用已有noise compensation/right derivative，固定同一W、允许不同实际初值x/y，调用固定mathlib真实Gronwall trajectories theorem，证明指数界 dist(Xx(t),Xy(t))≤exp((1+L+|γ|)t)dist(x,y)。同一噪声补偿项实际抵消，所以此界直接适用于原phase坐标。将其接到actual Classical.choose存在解得到对初值的Lipschitz常数，常数不依赖整个noise path。

真实endpoint的路径连续性沿用已验收Gronwall噪声依赖；初值方向uniform Lipschitz+路径方向continuous推出initial×Cpath joint continuity/Borel measurability。对任意真正AEm随机初值，实际构造random endpoint AEm由joint map和initial/noise pair AEm推出；无需初值/未来独立假设即可证明此可测性（独立性用于后续law，不用于本项）。

actual periodic endpoint经真实相空间projection×id开商映射下降；既有任意real representative lift一致性将其composite识别为real endpoint后投影，故periodic initial×Cpath joint continuous/measurable及random periodic initial endpoint AEm不要求chosen representative本身连续或可测。

辅助real模型C² U、显式actual global forceLip、unit mass/finite Nc、T≥0、t∈[0,T]、任意γ/σ；periodic descent需actual C∞ lattice-periodic U和既有representative-independent endpoint，global forceLip可由已接受周期compact cube proof给出。random initial X的AEm是必要输入可测性，不把endpoint AEm或joint map结论藏入假设。

## 验证

local01 initial-Lip target需显式chosen endpoint/NNReal归约；后续random initial高阶composition推断触及default200000heartbeats。local02真实Gronwall/initial Lip/joint real与periodic continuity和joint measurability均无诊断，仅random initial composition；local03已显式声明pair AEm并先推导composition、最后exact，避免期待类型引发Classical.choose展开。针对joint measurable theorem保留局部maxHeartbeats800000，不变toolchain/mathlib/整工程选项。

full-check01 10/05/2026 19:46:26--10/05/2026 19:49:17退出0；9054jobs/零Lean警告/1063audit基础三公理/137inputs及全部raw SHA复核一致；9public逐名覆盖。 机器验收通过，详见full-check01/CHECK_REPORT和ACCEPTANCE。负责人教材语义签核pending。后续构造真实transition kernel并以actual future-history product law+restart和joint map识别conditional distribution；completed filtration/适应性、density/actual generator/Harris以及全CORE_SCOPE均未完成。
