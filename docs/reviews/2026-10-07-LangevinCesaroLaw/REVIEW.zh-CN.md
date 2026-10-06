# Theorem 6.2 依赖：真实 Cesàro 概率律、紧性及弱子列

对应印刷251–254/PDF272–275原Theorem6.2实际核不变律存在路线的必要概率构造。原PDF哈希重新核对一致，复用同一PDF272、273页既有视觉核对，未新增274、275页视觉检查。本批7公开声明未宣称invariance；从原实际κ的平均到真正不变律仍需一步误差趋零及weak Feller证明。

定义真正平均测度：μ_n=(n+1)⁻¹ • ∑_{i=0}^n κ_(iτ)x。每项是同一原实际过程的概率law，标量为真实finite/nonzero整数n+1，不使用未定义的零次平均。真正κ Markov性和univ总质量推μ_n是probability；将完全相同测度包装到实际ProbabilityMeasure weak topology。该平均是实际kernel laws的Cesaro mean，不是Eq5.6 trajectory平均或一个额外抽象随机模型。

每个BCF f对实际概率κ可积，通过真实integral_smul_measure和固定版本integral_finsetSum_measure得到μ_n期待等于真实κ期待的有限平均，ENNReal scalar-to-real转换准确核对。未假设目标期待、密度或stationarity。

上一已验sameκ skeleton tightness给每个fixed x共同能量compact cutoff，本批对所有平均以原测度有限加和/归一化保留同一尾界，得到sameτ actual Cesaro law family tight。真Prokhorov theorem给原非紧phase空间ProbabilityMeasure中range closure compact；实际phase/probability metrizability及compact subsequence API给严格递增φ和真正weakly convergent μ_(φ n)。没有假设compactclosure、tight或弱收敛，更没有将subsequence limit直接认作invariant。

local01全部7退出0零error/Leanwarning空日志，Draft与正式源exactSHA一致；DEP112/NOT121等待full-check01。σ任意，tight构造使用原单位质量、U≥1/C∞periodic/forceLip和γ>0，目标矩及drift此前已从actualprocess验收，不作新假设。

实际continuousgenerator身份、density存在/原time0连续性语义、Harris唯一性/weighted-test指数收敛、Theorem6.2整体及负责人最终语义仍未完成。下一证明真实一步平均误差的telescoping身份、2‖f‖/(n+1)界及趋零，再由sameκ弱Feller与真实weaksubsequence推出同一skeleton kernel的不变律；全连续时间不变律及唯一性继续分别登记。

full-check01 passed：9147 jobs/2407公理声明/230exact inputs；10checks退出0、全部input/rawlog SHA匹配、7public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。actualκ前n+1真实finite/nonzero归一化Cesaro probability、BCF有限期待均值、eachfixedx averagedlaws tight及真实Prokhorov weakcompact/strict weaksubseq已机器验证；weaklimit未当invariantlaw，无density/stationarity前提，continuousgenerator/densityexists/Harris未证，owner semanticpending，Theorem6.2整体未完成。
