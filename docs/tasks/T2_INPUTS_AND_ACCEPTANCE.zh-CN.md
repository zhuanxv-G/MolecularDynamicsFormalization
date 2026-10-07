# T2 输入和未来验收清单

状态：四份本地准备材料、输入清单及保护文件核查已完成；本轮不发送/上传、不实现正式 Lean、不提交/推送/合并/重置。

## 1. 固定基准与实际输入

- 工程：`C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization`。
- 分支 `chapter01-kinetic-energy-nonneg`，HEAD `54b75a14aaa968522903d82eef947ffdc7bbf165`；T1实现 `c7d9778fe981c24ba7281db730206d1cfefbba4d`。
- Lean v4.34.0，mathlib manifest/checkout `5ed2965256430c3649e86755f9576b54eca72435`；不升级。
- 教材PDF在工作区上层，461页；SHA256 `1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036`。需实际读取指定四张原页和补充动量定义页。
- 已有工作树修改及未跟踪文件保留。T2四份文档和上层探针不是这个HEAD中的文件；未来必须另给明确快照/内容/哈希。不能让网站只克隆HEAD后声称已经读过本轮材料。

并行原索引对话已将knowledge目录发布到 `052eea2edd51fd806edf6a9dacbb6cc3353fc82f`，后续收尾记录可能进一步改变HEAD；本轮保留其工作。已实查54→052的正式Lean/固定版本/验收入口无差异；T2源码基准仍固定54。最新网站记录（原对话16:21）已验证 `git show 052eea2:<路径>` 读取目录与原始模块可用，语义工具仍返回无关测试库。网站工作区 `bdcd1ecd` 与发布分支分叉；不得直接pull/merge/reset覆盖网站独有提交。固定Git对象读取和语义检索验收分别登记。

## 2. 必需文件与原页

| 输入 | 用途 |
| --- | --- |
| `AGENTS.md`、`lean-toolchain`、`lakefile.toml`、`lake-manifest.json` | 规则与固定版本 |
| `MolecularDynamics/Notation.lean`、`BasicDefinitions.lean` | 欧氏位置/速度/动量、相空间、既有能量类型 |
| `MolecularDynamics/Chapter01/NBody.lean`、`ParticleCoordinates.lean` | 点态方程及13条已证明 T1 依赖 |
| `MolecularDynamicsFormalization.lean`、`Scratch.lean`、`scripts/check.ps1`、`scripts/CheckAxioms.lean` | 实际导入闭包和未来正式验收入口 |
| `FORMALIZATION_MAP.md`、`ASSUMPTIONS.md`、`STATUS.md` | 当前实现与语义边界；旧网站故障状态以最新交接证据为准 |
| T2四份文档 | 本批候选陈述、真实API结果、网站任务和验收 |
| T1最新网站审阅和负责人签核（尚未返回） | 正式实现前核对是否影响T2依赖 |
| 上层 `tmp/t2-preparation/ORIGINAL_PAGES.zh-CN.md`、图像/元数据、探针源与log/result | 本轮原页和固定版本小型类型检查证据 |
| 教材印刷18–19/PDF41–42、25–26/PDF48–49、补充24/PDF47 | 双页码与公式原文；不能推断全书固定偏移 |

共享交接和 knowledge 正由其他对话维护，不纳入网站可修改范围。未来发送时冻结本批必要材料，按已有任务包模板建立 manifest；本轮只生成可复核的本地输入清单，不声称已有上传包。

## 3. 本轮与下一阶段的允许修改范围

本轮仅新增四份 `docs/tasks/T2_*.zh-CN.md`、上层 `tmp/t2-preparation/` 证据，并局部更新当前状态/追加日志。保护正式 `.lean`、共享Scratch、固定版本、验收脚本和既有 `FORMALIZATION_PLAN.md`；结束核对起始SHA256。

未来网站陈述阶段只返回报告和文档候选类型。获准进入证明起草后，只返回独立 `T2_DRAFT.lean` 及报告/日志，放 `T2Draft` 命名空间，不自行覆盖正式文件，不写共享交接、knowledge或T1实现。正式本地集成另由一个对话负责。

## 4. 返回格式与未来验收顺序

1. 网站读取确认：实际仓库工作目录、分支/完整HEAD、附加文件SHA256、教材页码、Lean/mathlib/检查工具版本；索引ready不代替版本或命中验证。
2. Lean Blueprint逐ID审阅：前提/结论、域和端点、差异/推广、API类型、未落实依赖；必要时Math Brainstorm路线探索，记录实际参与。
3. 本地核对T1审阅影响并更新基准、负责人审T2陈述；不能复制旧签核作为新陈述签核。
4. Lean Proof完整起草L0→S1→B1→B2→B3，随后B4和自由粒子；记录完整源码、精确运行日志和退出码。未完成项留文档。
5. 本地固定版本独立草稿检查与关键定理 `#print axioms`；不接受额外项目公理或sorryAx，不把“网站成功”当验收。
6. 正式集成后维护顶层导入、映射/假设/STATUS，运行 `pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory <本批证据目录>`，覆盖扫描、lake build、Scratch和项目声明依赖审计。
7. 保存源码/输入哈希；在用户授权的提交推送阶段运行对应CI，核对CI精确head_sha。负责人语义复核另登记，合并需其授权。

## 5. 本轮验收状态与输入清单位置

| 检查层 | 本轮实际状态 | 证据 |
| --- | --- | --- |
| 原文视觉核对 | 通过：印刷18–19/PDF41–42、25–26/PDF48–49，补充24/PDF47 | 上层 `ORIGINAL_PAGES.zh-CN.md`、5张渲染图、教材元数据/SHA256 |
| 固定API声明 | 通过：五组核心接口与18个直接声明 | `Probe01b_API_Types.lean/.log/.result.json`，退出0 |
| 小型适配 | 通过：5个候选定义、8个完整导数/坐标示例；2条写法提示 | `Probe02b_Adapters.*`，退出0 |
| 候选目标表达 | 通过：同样5个定义与7个Prop目标；无错误/警告 | `Probe03_TargetTypes.*`，退出0；只说明命题类型成立，不说明命题为真 |
| 失败记录 | 首次超时（运行器124）和短诊断失败（Lean1）保留，局部库实例已给出成功后继 | `Probe01_APIs.*`、`Probe02a_Instances.*` |
| 自由粒子样例 | 数学陈述/维数/符号和目标类型已核对；完整Lean解证明未完成 | T2_SPEC第7节及Probe03 |
| T2目标完整证明 | 未实施 | L0/S1/B1–B4/E1均待MathCopilot审阅后证明 |
| 本轮全工程构建/CI | 未运行；正式源码不变 | 不复制T1历史成功为本轮T2成功 |
| 网站T2参与/负责人语义签核 | 尚未执行/完成 | 本轮指令仅准备，未发送 |

本轮输入哈希清单保存在工作区上层 `tmp/t2-preparation/T2_INPUT_MANIFEST.csv`，使用相对于工作区的路径。它包含四份T2最终文档、必要正式源码/固定版本/验收入口、T1基准资料、成功和失败探针的源/log/result、教材原页证据。`FINAL_VALIDATION.json` 记录保护文件对比、T1已有验收输入重核、分支/开始与结束HEAD、文档检查和实际计时。清单文件不包含自身或可变的共享交接，避免循环哈希；所有内容保持本地，未上传。

未来发送材料时先按该清单逐字节校验，并另固定发送快照的完整Git提交和附加文件；如果T1审阅或正式源码变化，重新生成新清单，不将本轮哈希移植为新源码证据。清单和本轮检查不能代替未来正式 `check.ps1`、CI及负责人复核。
