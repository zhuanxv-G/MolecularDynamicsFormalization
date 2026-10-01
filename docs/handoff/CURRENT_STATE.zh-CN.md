# 当前状态与接续检查点

最后更新：2026-10-01 23:46 +08:00（Asia/Shanghai）。本文件由实际工程、检查证据和保存文档核实后维护。

## 现在进行到哪里

**当前任务进行中（用户已授权）：** 先整理并提交/推送已验证工作到当前工作分支，确认远端 CI；接着更新/核对 MathCopilot Lean 库及索引，最后发送并推进 T1。网站任务/必要输入材料发送与上述项目索引操作已有本轮明确授权，无须重复询问。T1 仍先做陈述/依赖复核，再进入完整证明实现；用户的“推进 T1”优先于旧准备批的等待实现授权文字。目标文件为已验证脚本/CI及配套文档、第四项证据与 T1 新运行记录。初次 Git HTTPS 只读查询遇到 Windows schannel 凭据错误，正在尝试保持证书校验的替代传输及已连接 GitHub 工具。

**第三项已在本地完成：沿用现有检查脚本与 CI，补齐版本、公理依赖及验收证据；最终机器检查通过。** 新增 `scripts/CheckAxioms.lean`、`docs/verification/LOCAL_ACCEPTANCE.zh-CN.md`、`SEMANTIC_REVIEW_TEMPLATE.zh-CN.md`，增强原 `scripts/check.ps1` 和原 CI，更新 README/STATUS。机器与负责人教材语义复核分别登记；T1 新证明、网站返回和负责人语义复核未发生。

最终检查于 2026-10-01T23:20:34.2290142+08:00 结束，退出码 **0**：实际 Lean 4.34.0、mathlib 固定提交匹配，源码扫描、8928 jobs 构建、Scratch 和导入的 36 项工程声明依赖审计通过。关键定理依赖 `[propext, Classical.choice, Quot.sound]`。八个隔离拒绝测试通过；最终输入 11 项及 10 份原始命令日志的 SHA-256 独立复核通过。证据在 `docs/verification/2026-10-01-step3/`，外部原目录 `../deliverables/local-check-20261001-step3-run2/`；CHECK_REPORT SHA-256 `f030e4cb3fd23d234d1719d4ca5f715a977f084735aee70b596c4fa20aa561de`。CI 配置已在本地核对，但尚未提交/推送或在 GitHub 执行，不能标为远端通过。

**用户已确认技能启用/项目安装（第一项）；固定任务输入包（第二项）已完成。T1 新证明尚未启动，网站本批任务尚未发送。**

第二项新增 `docs/tasks/T1_TASK_PACKET.zh-CN.md` 统一入口、`TASK_PACKET_TEMPLATE.zh-CN.md` 可复用模板、`T1_PACKET_CONFIG.json`/`T1_PACKET_FILES.csv`、三份返回模板及 `scripts/package_task.py`；更新既有任务指令和验收文档，刷新 19 项核心输入哈希。准确数学规格/API 证据复用此前准备，没有重做原页审计。

**可交付快照：** `C:\Users\ustc\Desktop\formal math\deliverables\T1-preparation-v1\T1-preparation-v1.zip`（555765 bytes，32 ZIP 条目；清单 30 条含生成入口）。归档 SHA-256 为 `4b80ba09755f1f518371fa89083a26554373faf51daaa8ffb2e86d73041af8d4`。同目录有 `START_HERE.zh-CN.md`、输入清单、元数据、SHA256SUMS 和校验报告；包含既有 PDF 41–42 两页图，不包含整本教材或 .git/.lake/账户资料。归档内容固定，不因之后的交接文档变化而改变。

第二项实际检查：打包及独立读取 ZIP 的 CRC/全文件 SHA-256/元数据/锁定版本/11 项 ledger 检查通过；19 项核心输入复核和 git diff --check 退出码 0。正式 Lean/Scratch 与三份版本文件无差异，没有重复 Lean 构建或新增数学证明结果。

此前 T1 准备文件保留：

补充说明（22:30）：已回答用户如何核对 Math Brainstorm、Lean Blueprint、Lean Proof 的启用及项目安装；具体操作追加到 `docs/MATHCOPILOT_WORKFLOW_ANALYSIS.zh-CN.md`。仅重新读取公开指南，没有核查或修改账号实际配置，也没有发送网站任务。下方 T1 状态与接续动作保留。

- `docs/tasks/T1_SPEC.zh-CN.md`：原页核对、粒子/坐标定义草案、T1-I/M/E/P 候选陈述、假设与依赖。
- `docs/tasks/T1_MATHCOPILOT_PROMPT.zh-CN.md`：可由用户复制发送的初始指令；网站本批只整理陈述/依赖，不补证明。
- `docs/tasks/T1_INPUTS_AND_ACCEPTANCE.zh-CN.md`、`T1_INPUT_MANIFEST.csv`：19 个必要输入文件及 SHA-256、网站成果导回与本地双重验收步骤。
- `docs/tasks/T1_API_CHECK.zh-CN.md`、`T1_APIProbe.lean.txt`、`T1_APIProbe.result.txt`：固定版本 API 与匿名候选表达式的类型检查；最终退出码 0，无新定理证明。

**恢复后的第一条动作：** 用户在 MathCopilot 目标项目新任务选择 Lean Blueprint，提供上述固定包并复制同一包的 T1 指令；若已返回报告，先检查 RETURN_METADATA 的包 ID/输入清单哈希，再按验收文档第 4 节复核陈述/依赖。没有返回则本地准备包已可供使用，不重复原页审阅。第二项完成本地打包；第三项完成本地验收机制与现有源码检查。均没有发送/上传、新证明或 Git 提交/推送/合并/重置。原 ZIP 的输入清单对应冻结快照；check.ps1/STATUS 等本地维护变化后不要把它当成当前工作树清单。网站交互按后续明确授权执行。

接续差异补充：21:24 查询时 MathCopilot 分析文件尚未落盘；同工作区另一个分析任务于 21:31 完成并保存了 `docs/MATHCOPILOT_WORKFLOW_ANALYSIS.zh-CN.md`，并追加独立日志。本轮随后实际读取该文件，保留分析成果和并行日志，不声称它由本 T1 任务产出。真实分支和 HEAD 与旧记录一致，所有已有未提交/未跟踪文件保留。

现有工程已有基础类型、§1.2 点态方程和能量定义，以及一个动能非负性的完整证明。全书路线与首轮抽样审计已保存；逐页排漏、后续证明和关键语义复核尚未完成。

本轮已重新查看 §1.2 印刷 18–19 / PDF 41–42。确认 `n=N_c`，三维笛卡尔坐标有 `N_c=3N`，独立约束减少 `N_d` 而不直接减少环境坐标数。计划用 `Fin N × Fin d` 按粒子优先展开，质量按方向重复。`Notation.lean` 泛称自由度的注释与 NBody 的坐标语义不一致，已登记待实现时纠正，未改源码。正性双向桥接需要 `d>0`；动能两式一致无须正质量。

当前请求授权原页/源码核对、T1 陈述和依赖整理、可由用户发送的 MathCopilot 指令、本地导回验收流程；暂不启动新教材证明。网站参与本批陈述与依赖整理尚未执行。用户后来授权实现时按新授权继续，不能把旧草案的泛泛“待批准”变成反复等待范围确认的理由。

## 用户已确认的目标和偏好

- 形式化 Ben Leimkuhler、Charles Matthews 的 *Molecular Dynamics: With Deterministic and Stochastic Numerical Methods*（2015）整本给定 PDF 的数学内容。
- 包含 8 章、3 附录、数学类习题、正文新增符号、未编号结论、数值算法的数学性质及必要外部结果依赖。书目、历史叙述和纯经验图表不逐句形式化。
- 准确性优先，尽早完成，没有硬性截止日期。“国庆假期内完成更好”不是必须兑现的期限。
- 中文沟通；交接后应该能直接识别已有成果与下一步，不能要求用户重新描述全套背景。
- 用户明确说明师兄要求借助 MathCopilot 完成任务。网站是正式流程中的重要参与工具，负责证明路线探索、陈述/依赖整理、证明起草、托管检查和报告。本地正式工程保存成果，负责固定版本验收与 Git；不把托管成功等同于教材语义正确。
- 以上范围与时间要求来自已保存的最新全书路线。当前用户新确认：两个 Codex 账户轮换，希望用文件持续接续工作。

## MathCopilot 的参与与已知边界

- 已实际参与 Chapter 1 §1.2 定义及 `nBodyKineticEnergy_nonneg` 的起草；本地集成后进行了固定版本正式验证。
- 根据已读官方指南，`Math Brainstorm` 用于比较证明路线，`Lean Blueprint` 用于陈述/证明骨架和依赖地图，`Lean Proof` 用于补全局部证明及输出报告。调用前核对技能启用且安装到正确项目；未完成目标保留在文档，不把占位证明加入正式源码。
- 用户于 2026-10-01 当前对话明确确认上述三个技能的启用/项目安装已完成。此项记为用户确认，无须重复要求配置；实际网站调用与运行版本仍由返回报告记录。
- 已报告的 Task 克隆目录为 `/workspace/MolecularDynamicsFormalization`，原工作分支提交 `bdcd1ecd710db5fbd6b8698e9ee3d3e05d535045`。该提交曾因命令行 Git 缺少认证而推送失败；本地已发布的 `6203fc1` 多了本地正式验证记录，两者哈希不同。
- 网站 Lean 库已选择正式 GitHub 仓库并显示就绪；网站认证项目检查接口对嵌套工程根有已观察的解析限制。不要把旧 `Lean/` 包装层或缺少完整依赖闭包的单文件检查当正式验收。
- 托管 Lean/mathlib 实际版本仍未知。这是已知验证边界，不是重复配置所有服务的理由。
- 不假定新账户具有网站登录或 Task 访问权限；没有明确授权时先准备可复制的指令，由用户发送。发送、上传、切换云端分支或推送都需要核对已有授权和实际对象。

## 工作目录、教材和固定版本

| 项目 | 实际值 |
| --- | --- |
| 工作区 | `C:\Users\ustc\Desktop\formal math` |
| 正式 Git/Lean 工程 | `C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization` |
| 教材 PDF | `C:\Users\ustc\Desktop\formal math\Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf` |
| PDF SHA-256（本轮重核） | `1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036` |
| PDF 页数 | 461（本轮通过 pypdf 重新解析确认） |
| 分支（本轮实际查询） | `chapter01-kinetic-energy-nonneg` |
| HEAD（本轮实际查询） | `6203fc19908312faf9c40d52cb299edb42422973` |
| remote origin | `https://github.com/zhuanxv-G/MolecularDynamicsFormalization.git` |
| Lean | `leanprover/lean4:v4.34.0` |
| mathlib | `v4.34.0`；manifest 锁定 `5ed2965256430c3649e86755f9576b54eca72435` |
| Shell | Windows PowerShell；可用 `pwsh`、`lake`、`lean`、`rg` |

本轮未查询远端最新状态、未提交、未推送、未合并。已有路线记载该 HEAD 的历史 CI 通过；这是历史文档证据，本轮未重新查看 GitHub CI。下一账户必须重新查分支和 HEAD，不能假定本表永久有效。

**未提交内容必须保留：** 本轮开始已有 `FORMALIZATION_PLAN.md`、`README.md` 修改；工程 `AGENTS.md`、全书路线、3 个 CSV、初始审计与交接目录未跟踪。本轮新增 `docs/tasks/T1_*` 七份任务/证据文件，同工作区另一任务新增 MathCopilot 分析报告。工作区上层 AGENTS 与 `tmp/t1-preparation/` 不在正式 Git 工程内。所有这些本地文件都不会仅凭远端旧 HEAD 自动出现在另一台机器上；任务输入清单明确哪些需单独提供。

第三项新增/修改亦须保留：`.github/workflows/lean_action_ci.yml`、`scripts/check.ps1`、`scripts/CheckAxioms.lean`、`STATUS.md`、README、`docs/verification/` 和交接更新。数学源码和三份版本文件仍与 HEAD 一致；未提交/未跟踪内容不能仅靠旧远端 HEAD 转移。

## 已有 Lean 成果与边界

| 文件 | 已有内容 | 仍然不代表什么 |
| --- | --- | --- |
| `MolecularDynamics/Notation.lean` | `Position`、`Velocity`、`Momentum`、`PhaseSpace`、`MassMatrix`、`Force`、能量和 Lagrangian/Hamiltonian 类型别名 | 没有轨道、ODE 解或具体 Hamilton 方程 |
| `MolecularDynamics/BasicDefinitions.lean` | `SeparableEnergy` 与 `SeparableEnergy.hamiltonian`，抽象 `K(p)+U(q)` | 没有建立质量对应的具体动量动能公式 |
| `MolecularDynamics/Chapter01/NBody.lean` | `CoordinateMasses`、`diagonalMassMatrix`、`NBodyEquationAt`、`nBodyKineticEnergy`、`nBodyTotalEnergy` | 没有质量正性/可逆性，也没有时间轨道与二阶导数关系 |
| 同上 | `nBodyKineticEnergy_nonneg`：在 `hm : ∀ i, 0 ≤ masses i` 下，动能非负 | 不是严格正定性、能量守恒或 Theorem 1.1 |
| `MolecularDynamicsFormalization.lean` | 汇总导入基础模块及 NBody 模块 | 新模块仍需加入适当导入/构建范围 |
| `Scratch.lean` | API 检查和对应的草稿定义 | 草稿不单独计为正式成果，需另做 Lean 检查 |

`n` 在 NBody 模型中是配置坐标数 `N_c`。`gradient` 是 mathlib 的全定义操作；定义能写下不代表在使用点可微。力的符号是 `F(q)=-∇U(q)`。后续按结果需要显式增加可微性、质量正性和位置域条件。

尚未形式化：时间轨道与一/二阶导数，ODE 解谓词及存在唯一性，具体 Hamiltonian 与速度能量的一致性，能量守恒，严格局部极小值能量屏障，Lyapunov 稳定性、全局延拓，以及 Theorem 1.1。第一章后续及第二章以后没有正式库成果。

## 清单与首轮审计的实际进度

以下计数来自此前接续与首轮审计；本 T1 准备轮未重数清单或重做全书审计：

- `docs/CHAPTER_SECTION_INVENTORY.csv`：196 个目录/习题节点，是覆盖骨架，不是 196 项证明。
- `docs/NOTATION_INVENTORY.csv`：72 条符号表记录；Lean 映射与语义审阅仍待完成。
- `docs/TEXTBOOK_DECLARATION_CANDIDATES.csv`：21 个编号匹配，其中 2 个为引用，其余 19 个是初步声明候选，不是全书全部定理数。
- `docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv`：72 行。已有审计报告记录 70 个所列对象看过渲染原页、2 个仅为重复引用；这仍不等于完整语义复核或全书逐页排漏。
- 首轮审计是抽样；没有由它新增任何已证明 Lean 教材结论。第一章各节、后续章、附录与习题均需继续逐页清点。

旧审计中的“习题范围待确认”以及 `FORMALIZATION_PLAN.md` 中“selected results / scope review”是历史文字；最新 `docs/WHOLE_BOOK_ROADMAP.zh-CN.md` 已明确整本 PDF 和数学类习题纳入范围，不再以这些旧文字等待重复确认。

## 下一批任务队列

| 顺序 | 任务 | 接续的具体产物 |
| --- | --- | --- |
| 1 | T1 粒子/坐标与正质量桥接 | 本地原页/陈述/API 准备完成；网站陈述/依赖报告待返回，正式桥接证明尚未开始 |
| 2 | T2 时间轨道与局部 ODE | 位置–动量轨道、时间区间、解谓词；正式证明轨道解与点态方程的桥接 |
| 3 | T3 具体 Hamiltonian 一致性 | 正对角质量的 `H(q,p)`；证明 `p=Mv` 时等于现有总能量 |
| 4 | T4 能量守恒最小闭环 | 沿充分光滑局部解导数为零；连通时间区间能量常值 |
| 5 | T5 严格极小值能量屏障 | 有限维、连续势能、足够小球面上的正屏障；不能改成 Hessian 正定假设 |
| 6 | 全局延拓与 Theorem 1.1 | 在前述依赖落实后单独审阅并证明；不是目前已完成内容 |

后续 T1 实现按 `docs/tasks/T1_SPEC.zh-CN.md` 与已复核的网站报告接续；本轮已经实际实例化相关固定 API，证据见 `T1_API_CHECK.zh-CN.md`。不得仅凭类型检查或蓝图把候选结论标为已证明。后续不要同时铺开多个未稳定章节。

数学风险：严格局部极小值不等于 Hessian 正定（`x⁴` 是核对例）；可逆质量矩阵本身不足以保证 Legendre 上确界有限；局部解不能称为全局流；一般力场不自动给总动量守恒。Hartman–Grobman 共轭正则性、紧困轨道延拓、SDE/Itô/Hörmander 等依赖仍待落实。mathlib 某次检索“未确认”不代表该库“不存在”对应 API。

## 验证记录与环境恢复

- 第三项最终实际验证已通过，详见本文件开头与 `docs/verification/2026-10-01-step3/RESULT.zh-CN.md`。后续每批代码变化重新运行同一入口；下面保留此前各批的历史检查边界。
- `STATUS.md` 保存了 2026-10-01 的历史本地成功构建/检查，以及 MathCopilot 托管检查的边界。
- 历史接续任务运行 `pwsh -NoProfile -File scripts/check.ps1` 时，默认 elan 启动器连接 `release.lean-lang.org` 失败；改用本机固定版本后成功，详见 21:08 日志。本 T1 准备轮没有重跑该脚本。
- 本机已安装固定版本：`C:\Users\ustc\.elan\toolchains\leanprover--lean4---v4.34.0\bin`。直接运行其 `lean.exe --version` 和 `lake.exe --version` 成功，Lean 为 4.34.0、commit `293d5d0c0c3f3dded4688b3ccd6a33939ac5102b`。
- 历史正式检查于 2026-10-01 21:07 退出码 0：源码扫描、`lake build`（8928 jobs）和 Scratch 检查通过。该历史记录的源码 HEAD 为上表提交；不是本 T1 准备轮的新构建结果。
- 本轮仅以固定版本运行 `lake env lean '..\tmp\t1-preparation\APIProbe.lean'`。首次因未知 `pp.width` 与不存在的 `finProdFinEquiv_apply` 退出码 1；修正后第二次退出码 0，增加核心能量等式与正性等价的匿名 Prop 后最终再次退出码 0。原始最终输出已保存；新教材定理均未证明。`Matrix.inv_diagonal` 的 Ring.inverse 与逐项倒数、`Matrix.toEuclideanLin` 的线性/连续线性区别已明确登记。
- 19 个输入 SHA-256、UTF-8 与任务/交接文档空白检查通过；输入中已提交文件的 Git blob 与 HEAD 一致，正式 Lean/Scratch 及三份版本文件没有修改。`git diff --check` 通过。原页关键记号已本地核对；网站独立报告与负责人对候选陈述的复核待完成。没有本轮新全工程构建或公理依赖检查，没有远端 CI 查询。

正常检查（在正式工程目录）：

```powershell
pwsh -NoProfile -File scripts/check.ps1
```

遇到同样的 elan 联网问题且上述安装目录确实存在，可在当前 shell 使用固定版本：

```powershell
$env:PATH = 'C:\Users\ustc\.elan\toolchains\leanprover--lean4---v4.34.0\bin;' + $env:PATH
pwsh -NoProfile -File scripts/check.ps1
```

Git 历史上在沙箱中报告过 `dubious ownership`；必要时可使用以下单次参数，不修改全局 Git 配置。本 T1 准备轮普通 Git 只读命令直接成功：

```powershell
git -c safe.directory='C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization' status --short
git -c safe.directory='C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization' branch --show-current
git -c safe.directory='C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization' rev-parse HEAD
```

## 按任务查阅的资料

- 工作规则：工程根 `AGENTS.md`；`FORMALIZATION_PLAN.md` 为早期简要计划。
- 最新范围与验收：`docs/WHOLE_BOOK_ROADMAP.zh-CN.md`。
- 已有成果、建模假设：`FORMALIZATION_MAP.md`、`ASSUMPTIONS.md`、`STATUS.md`。
- 首轮审计：`docs/audits/2026-10-01-initial/README.zh-CN.md`、`CHAPTER01_DEPENDENCIES.zh-CN.md`、`MATHLIB_AUDIT.zh-CN.md`、`NEXT_TASKS.zh-CN.md`、`CLAIM_LEDGER.csv`。
- 最新 T1：`docs/tasks/T1_SPEC.zh-CN.md`、`T1_MATHCOPILOT_PROMPT.zh-CN.md`、`T1_INPUTS_AND_ACCEPTANCE.zh-CN.md`、`T1_INPUT_MANIFEST.csv`、`T1_API_CHECK.zh-CN.md` 及两个探针文本。恢复时从这些产物继续，不重做旧准备。
- 同工作区独立分析：`docs/MATHCOPILOT_WORKFLOW_ANALYSIS.zh-CN.md`；21:31 的分析任务日志记载来源。本轮没有调用子 agent，也不以其中未来委派建议作为自动启动权限。
- 本地辅助提取与原页图：上层 `tmp/textbook-plan/pages.json`、`audit-page-*.png`、`theorem-1-1.png` 和提取/清单脚本，不在正式 Git 工程内；可重建，不能替代教材 PDF。

## 新账户接手检查

1. 确认能读到上述正式工程和教材；如换电脑，必须先转移完整工程（含未提交/未跟踪文件）及教材。单有提示词或旧远端 HEAD 不够。
2. 读本文件和日志最新条目；查询分支、HEAD、工作树，检查是否有上次中断留下的改动，不重置、不覆盖。
3. 用几句话说明理解到的目标、真正已完成的成果、本次第一动作，然后执行用户当前授权的任务。
4. 如果实际代码比此记录新，先检查差异并补写状态；记录未知，不假装已读取另一个账户的聊天。
5. 本次完成一个小目标后立刻更新本文件并追加日志；具体维护约定见工程根 `AGENTS.md`。
