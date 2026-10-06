# Theorem 6.2 依赖：真实物理 Hamiltonian 的实际转移核漂移

本批对应原(6.47)、Theorem6.2及印刷251–254/PDF272–275的 Hamiltonian Lyapunov 证明需求。原PDF SHA本批重新核对一致，视觉检查复用相同PDF此前272、273页；不宣称本批新增274、275的视觉检查。11个公开声明作为目标定理的必要证明依赖，不作独立一般化交付。

从同一真实动量Duhamel等式出发，对每个坐标用(a+b+c)²≤3a²+3b²+3c²和原实际force卷积M/γ界，再作真实坐标求和。得到物理∑pᵢ(T)²≤3exp(−γT)²∑pᵢ(0)²+3N(M/γ)²+3∑ξᵢ(T)²，保留原动能的欧氏坐标平方和。初值项系数没有用sup norm替换，也没有额外N系数。

同一all-time periodic process的共同满测集积分解和真实周期force界给出上述物理界。已有实际momentum L²推坐标平方和可积，真正周期势能界和原下降Hamiltonian连续性推H(ZT)可积。对真实P积分，使用前一已验noise二阶矩，而非假设过程矩或漂移，得到每个指定有限T上 E H(ZT)≤3exp(−γT)²H(x)+D(T)，D≥0与初值x无关。原U≥1用于初能量吸收势能项；γ>0、原unit mass、同C∞周期U和原process/noise保持。

通过同一实际κ的global law和真实integral_map，把可积性及期待身份转为真实kernel Hamiltonian期待。显式构造t=log(6)/γ>0，阻尼系数3exp(−γt)²=1/12≤1/2，加1使余项严格正，导出真实κt H≤H/2+D，并合并同一H的连续、严格正及proper/cocompact发散性质。

local01首3退出0但有真实unusedSimp警告，删除多余参数后local02整批11退出0、零error/Leanwarning、空日志。全程默认资源、固定版本，不增项目公理，不藏漂移或过程矩进假设。Draft/正式源逐字节SHA一致，DEP107/NOT116等待full-check01统一验收。

本批实际漂移限定l=1及固定时间skeleton。它不是原连续时间SDE生成元身份或一般H^l漂移的完成；不替代原Assumption2的字面微分陈述。实际joint density存在、完整Harris唯一不变概率/原加权测试类几何收敛、负责人语义仍待补。下一继续原H^l实际过程高次矩依赖及原目标证明，不因density或负责人签核等待停止独立工作。

full-check01 passed：9142 jobs/2377公理声明/225exact inputs；10checks退出0、全部input/rawlog SHA匹配、11public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。same实际κ在真正正时间l1物理Hamiltonian期待H/2+D及positiveproperH已机器验证，owner semanticpending，Theorem6.2整体未完成。
