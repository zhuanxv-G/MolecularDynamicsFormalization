# Theorem6.1：真实 Fourier 字符与坐标微分依赖
原目标印刷250–251/PDF271–272已核对。本批只补真实Haar Poincare路线所需的Fourier微分；原一般正对角质量和周期势能Gibbs生成元保持既有定义。
26项公开声明：实际2πΣn_iq_i连续线性相位、真实cos/sin全Euclidean lifts的C∞/Frechet及一阶二阶坐标partials、全整数晶格周期性；固定UnitAddTorus.mFourier的actual乘积exp由exp_sum与complex cast化成此相位，实部/虚部正是cos/sin。
辅助Haar计算使用literal textbookBrownianGenerator m_i=1 U=0 β=1，真实约化为坐标二阶partial之和，cos/sin特征值为-4π²Σn_i²。非零整数index实际有Σn_i²≥1，故频率≥4π²，未假设频率界或Poincare/gap。
local01只2deprecated ContinuousLinearMap.smul_apply，改root smul_apply；local02原16声明退出0/空日志；local03补全26声明退出0但1deprecated push_neg，改push Not；local04退出0/空日志/0Leanwarnings。api01固定API退出0。全流程与日志保留。
正式集成root/Scratch/公理审计、DEP036/NOT045，统一full-check01进行中。
本批尚不含真实Laplace Fourier coefficient/Parseval梯度能量恒等式/HaarPoincare；原selfadjoint、compactresolvent、离散谱、Gibbs gap、actualsemigroup及Theorem6.1整体和CORE_SCOPE均未完成。负责人教材语义签核pending。

full-check01 passed：9071 jobs/1366公理声明/154exact inputs；10checks退出0、全部input/rawlog SHA匹配、26public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，HaarPoincare与Theorem6.1整体未完成。
