# Theorem 6.2 依赖：原 Hamiltonian 幂的实际核漂移

本批对应印刷251–254/PDF272–275原(6.47)与原H^l Lyapunov证明的实际过程依赖。原PDF哈希本批重新核对一致，视觉核对复用同一PDF的272、273页；未新增274、275页视觉检查。本批7个公开声明证明每个整数l≥1的真实H^l漂移，使用单位质量、U≥1、C∞周期势能、真实force Lipschitz与γ>0。σ任意；真正原Wiener/同一实际periodic process与κ保持不变。

实际动量物理坐标平方和界及真实周期势能界推出路径上的H界：H(YT)≤3 exp(-γT)²H(x)+A+(3/2)∑ξᵢ(T)²。A真实来自force及potential界，对所有初值统一；使用共同AE的全时过程。两个正项幂和不等式将H^l路径界分离为初值项与noise物理平方和幂。上一已验真实高次矩给余项可积，通过实际P积分单调性得到H^l期待界，未把目标可积性或漂移作假设。

实际κ的global law与真实endpoint可测性证明kernel H^l期待等于同一全时过程期待，因而推得sameκ期待界。选共同τ=log(6)/γ>0，对于所有T≥τ，a=3 exp(-γT)²≤1/4，并从l≥1推出2^(l-1)a^l≤1/2。故所有正整数l共用该τ，∀T≥τ，∃D_l(T)>0，对所有x：κ_T H^l(x)≤H^l(x)/2+D_l(T)。D有限且对x统一，允许依赖l与T，不宣称时间上一致有界。

将上述真实drift与已有原H^l连续、严格正及cocompact proper性组装为sameκ共同正时刻skeleton Lyapunov依赖。sup norm未替代物理坐标平方和；没有新的Gaussian law、漂移或矩假设，没有增加资源、项目公理或linter抑制。

local01仅实际积分常数rewrite误选初值常数；local02显式指定C²和(3/2)^l，全7退出0、零error/Leanwarning、空日志。Draft与正式源逐字节SHA一致。原诊断日志保留。DEP109/NOT118等待full-check01统一验收。

本成果是原实际过程的离散时刻高次漂移依赖，不等同于尚待的连续生成元身份或字面Assumption2。原joint density存在、原time0连续性语义、sameκ Harris唯一不变分布及weighted-test几何收敛、Theorem6.2整体与负责人最终语义仍pending。下一证明原density clause在指定正时刻的compact minorization，让小集与本批实际drift使用同一个κ_τ；density输入的具体能量集合须明确。

full-check01 passed：9144 jobs/2393公理声明/227exact inputs；10checks退出0、全部input/rawlog SHA匹配、7public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。same实际原H^l路径界/同P及κ期待界/共同正τ对所有l>=1和T>=τ halfdrift及samepositiveproperHl已机器验证；D允许依赖l/T，continuousgenerator/densityexists/Harris未证，owner semanticpending，Theorem6.2整体未完成。
