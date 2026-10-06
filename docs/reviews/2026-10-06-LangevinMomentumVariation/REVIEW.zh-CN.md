# Theorem 6.2 的依赖：真实动量变常数公式与力项卷积界

本批 11 个公开声明来自印刷 251–253 / PDF 272–274 的原 Langevin 方程 (6.47) 及 Theorem 6.2 的过程 Lyapunov 证明需求。它们是目标定理的必要依赖，未作为独立一般化或新教材定理交付。原 PDF 哈希本批重新核对一致，复用此前已经视觉核对的原页。

从同一真实积分解出发，噪声路径只需在实际区间连续，不假设 Wiener 路径可微。原补偿动量的真实右导数，结合指数积分因子和右导数 FTC，推出真实动量的加权积分恒等式、变常数公式和 Duhamel 分解。噪声卷积定义为同一实际路径的 σ[W(t)−γ∫exp(−γ(t−s))W(s)ds]；本批未把它与随机积分相等、Gaussian law 或矩界当作前提或已完成结论。

正摩擦 γ 下，实际阻尼核的积分严格等于 (1−exp(−γt))/γ。通过真实连续性、Bochner 积分范数界及积分单调性，力项卷积被原实际 force bound 控制，并得到时间一致 M/γ 界。周期势能的真实全局 force bound 由既有定理导出，未假设小集结论或过程漂移。所得动量范数界明确使用 Lean 的 Fin 函数 sup norm，不能直接冒充欧氏动能恒等式；后续物理能量依赖仍需坐标平方和桥接。

对已经构造的同一个 coherent all-time Wiener-driven process，先用其真正积分解定理，再将上述恒等式和界推到一个共同满测集上的所有非负时间。周期位置仍是真实商空间投影，动量及噪声路径未替换。

local01–05 保留实际 section 变量、导数 CLM 投影、标量函数 wrapper、noncomputable section、测度类型及连续区间诊断；固定版本 API 显式修复，不提高资源、不抑制 linter。local06 整批退出 0，零 error/Lean warning；日志含普通 tactic normalization suggestion，原样保留，不把它说成空日志。正式文件与该候选逐字节 SHA 一致。DEP105 / NOT114，统一全工程验收以 full-check01 为准。

实际噪声卷积的 law/moments、SDE 半群生成元与原微分表达式身份、真正过程 Lyapunov 漂移、density existence 和 Harris 完整定理仍未完成；负责人教材语义 pending，CORE_SCOPE 未完成。下一继续同一实际噪声卷积的矩，不把目标漂移界藏在前提中。

full-check01 passed：9140 jobs/2355公理声明/223exact inputs；10checks退出0、全部input/rawlog SHA匹配、11 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.2整体未完成。

full-check01的确切输入已全部通过，但提交前git diff --cached --check真实检出正式源末尾多余空行；未提交。仅规范化Draft/正式源末尾为一个换行，数学证明不变；原full-check01成功日志保留，对当前不同SHA再local07/full-check02验收，不复用旧输入哈希作为当前通过证据。

full-check02 passed：9140 jobs/2355公理声明/223exact inputs；10checks退出0、全部input/rawlog SHA匹配、11 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.2整体未完成。
