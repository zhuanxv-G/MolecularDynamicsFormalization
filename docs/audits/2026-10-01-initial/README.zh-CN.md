# 2026-10-01 全书形式化前期审计交接

**状态：覆盖索引的起点和第一章依赖审计；没有开始新的教材定理证明。** 本次新增文件只在本目录。正式仓库的工作分支为 `chapter01-kinetic-energy-nonneg`，审计起点 HEAD 为 `6203fc19908312faf9c40d52cb299edb42422973`；起点时 `FORMALIZATION_PLAN.md` 已有未提交修改，`docs/` 已为未跟踪目录，本轮原样保留。没有提交、推送、合并、切换或重置分支。

## 可复核来源与产物

- 教材：上层目录的 `Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`，461 个 PDF 页面；本次重新核对 SHA-256：`1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036`，与 `docs/WHOLE_BOOK_ROADMAP.zh-CN.md` 一致。PDF 与全文提取不入 Git。
- 已有追踪基线：`docs/CHAPTER_SECTION_INVENTORY.csv` 为 196 个目录/习题节点（含 8 个习题节）；`docs/NOTATION_INVENTORY.csv` 为 72 条符号；`docs/TEXTBOOK_DECLARATION_CANDIDATES.csv` 为 21 个行首编号标题匹配，其中 2 个只是正文引用。其余 19 个仍只是初步编号声明候选，不能当全书总数。
- 本轮 `CLAIM_LEDGER.csv` 共 **72 行**：原 21 个编号匹配全保留；其中 2 个只是重复引用，另外 19 个候选均打开原页核对了定位和陈述概要；另补 3 个编号定义（Definition 3.1、5.1、6.1）和 2 个编号假设（Assumption 1、2）。其余为精选未编号结论、模型、算法、外部结果和语义风险。70 行的**所列对象**已看过渲染原页，2 行为 `reference_only`；“原页已核对”仍不等于逐字逐公式的完整语义复核或全页排漏。
- `CHAPTER01_DEPENDENCIES.zh-CN.md`：第一章原页核对、Theorem 1.1 的完整依赖路线和证明缺口。`MATHLIB_AUDIT.zh-CN.md`：固定版本本地 mathlib 源码的实际 API 名称、类型摘要、路径和检索边界。`NEXT_TASKS.zh-CN.md`：五项小任务的目标、前置依赖和验收条件。

## 覆盖范围和未排除的漏项

| 部分 | 本次实际覆盖 | 尚未完成 |
| --- | --- | --- |
| Chapter 1 | 视觉核对 (1.2)–(1.4)、守恒、Lagrangian/Hamiltonian、存在/流、第一积分、平衡、稳定性、Theorem 1.1、晶格、角动量、变分方程等选定原页；建立 27 个条目 | §1.1 的各势模型、§1.6 和 §1.7 的其余页尚未逐页清点；即使看过某节页，未编号断言和参考文献仍可能遗漏 |
| Chapters 2–4 | 编号候选原页已核；视觉核对 Euler 误差、辛定义/体积保持、修正 Hamiltonian、约束模型及 SHAKE/RATTLE 习题证明缺口等锚点 | 各节未逐页阅读；数值方法的存在性、误差余项、辛性及约束的证明缺口未全面枚举 |
| Chapters 5–6 | 补定位 Definition 5.1、Definition 6.1、Assumption 1/2；视觉核对 Liouville、遍历、Itô 积分分布、Fokker–Planck、几何遍历等锚点 | 测度、能量面、随机积分与 SDE 的条件尚未逐页核对；外部证明多数未追踪到原文献 |
| Chapters 7–8 | 核对弱误差、Gibbs 子流、Lemma 7.1、扩展不变密度、Theorem 8.1 等锚点；其他编号项保留自动候选 | BCH/形式级数、弱收敛、Hörmander/遍历依赖和全部算法尚未全页审阅 |
| Appendices A–C | 核对 A 的成对力、B 的概率空间、C 的 CLT/详细平衡锚点 | A 的 PME、B 的其余概率概念、C 的 Metropolis/HMC 与外部引用尚未细读 |
| Exercises | 原目录 8 个习题节均保留在基线目录清单 | 范围待确认；尤其正文把 Proposition 6.3 的证明指向习题，不能默默视为已证明 |

这是**有意识的抽样式前期审计**，不是“全书扫描完成”或“全书定理已数清”。PDF 文字提取只用于候选定位；公式依赖渲染页视觉核对。教材印刷页与 PDF 物理页偏移非恒定，因此 ledger 每行同时列印刷页与从 1 起的 PDF 页。正文所列摘要是转述，没有大段复制教材。

## 关键发现与风险

1. 当前正式 Lean 只含点态 N-body 关系、能量定义和质量非负下的动能非负性；时间轨道、能量守恒、全局流、Theorem 1.1 的证明均未落实。已有分支的历史构建/CI 通过不代表这些目标已完成；本轮没有重跑构建，因为没有改 Lean 源码。
2. Theorem 1.1（印刷 32 / PDF 55）使用严格局部势能极小值。证明还需质量正定、局部 ODE、能量守恒、球面正能量屏障和紧困轨道延拓。正定 Hessian 是更强的充分条件，不能作为原定理的替身。
3. 第一章印刷 24 / PDF 47 的 Legendre 上确界推导只明说质量矩阵可逆；要使对应二次型上确界有限还需正定性。印刷 37 / PDF 60 把极小值处 Hessian 描述为正定，缺少非退化条件。印刷 32 / PDF 55 的 Hartman–Grobman “smooth” 共轭措辞需回查外部结果版本。均以语义问题登记，未将其当作已证引理。
4. 后半本的概率和 SDE 依赖跨度大。本地 mathlib 确认有测度、Brownian、filtration、单映射遍历等基础；此次关键词检索未确认可直接用的 Itô 积分/SDE 求解接口，不代表全库没有。Chapter 6 Theorem 6.2 引 [165]，相关证明又指向 [257, Theorem 2.5]，Langevin 可达性用 [257, Lemma 3.4]；Chapter 7 引 Ge–Marsden [400]，Chapter 8 省略 NHL 可达性证明。这些均已入 ledger 的外部依赖行。

## 审阅状态与下一步

`CLAIM_LEDGER.csv` 中 `original_page_checked` 仅指**页上所列对象的定位与概要**；陈述的所有量词、隐藏条件、证明、Lean 对应、正式构建、语义审阅均仍需逐项完成。`reference_only` 是已识别的重复提及。本轮已无仅靠文字提取而完全未打开原页的原 19 个编号候选，但扫描规则自身可能漏掉其他编号或未编号结论。没有任何本轮新增条目达到“Lean 已证明”状态。

首选下一步是 `NEXT_TASKS.zh-CN.md` 的 **T1：粒子/坐标与正质量桥接**，同时开始逐页复查 Chapter 1 §1.1–1.7 的漏项；随后按 T2–T5 小批推进。全书最终目标保留，具体排期须在完整清点、依赖审计和试点耗时后修订；不能据本轮抽样给出几天内全书证明完成的承诺。

本轮使用的仓库外辅助数据/脚本位于上层 `tmp/textbook-plan/`：`pages.json`、既有提取脚本、渲染的 `audit-page-*.png`、新建的 `build_audit_ledger.py`。这些文件不在正式仓库内。实际审计工作约 **58 分钟**（北京时间 2026-10-01 16:31 至 17:30），无为凑时长而等待。

交接时 `git diff --check` 通过；CSV 已检查 UTF-8、字段完整、72 个 ID 唯一、页码范围和章节 ID；`git ls-files -m` 只显示进入本轮前已有修改的 `FORMALIZATION_PLAN.md`。新文件仍未跟踪，没有修改任何现有 Lean 源码或覆盖既有规划文件。
