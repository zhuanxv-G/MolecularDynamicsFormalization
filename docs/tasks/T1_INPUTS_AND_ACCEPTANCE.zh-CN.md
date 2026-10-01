# T1 输入包与导回本地验收

状态：可复制初始任务已准备；尚未发送/上传，尚无本批网站输出。授权边界与陈述见 `T1_SPEC.zh-CN.md`。

2026-10-01 补充：用户已确认三个技能启用和安装；本批现在提供 `T1_TASK_PACKET.zh-CN.md` 统一入口、返回模板及可冻结归档。包内 `PACKET_MANIFEST.csv` 覆盖全部实际发送材料，原 `T1_INPUT_MANIFEST.csv` 保留 19 项核心输入的核对用途。归档含教材 PDF 41–42 两页图，不含整本 PDF、依赖缓存或账户资料。

生成入口（在正式工程根运行）：

```powershell
python scripts/package_task.py --config docs/tasks/T1_PACKET_CONFIG.json --refresh-input-manifest --output ../deliverables/T1-preparation-v1
```

该命令检查基准与白名单、刷新核心输入清单并生成不覆盖现有目录的 ZIP、清单、元数据、开始说明及校验报告。修改输入后必须建立新包 ID/输出目录。复制 `T1_MATHCOPILOT_PROMPT.zh-CN.md` 中完整代码块时，须与同一包内文件配套。

## 1. 输入版本

- 正式工程：`C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization`。
- 仓库：`https://github.com/zhuanxv-G/MolecularDynamicsFormalization`。
- 分支/HEAD：`chapter01-kinetic-energy-nonneg` / `6203fc19908312faf9c40d52cb299edb42422973`。
- 当前本地 main 为 `d5dd5722602fba9ff252311b2c93ff85a6801ed0`；本轮用 `git merge-base --is-ancestor HEAD main` 得退出码 1，即当前 HEAD 未被本地 main 包含。origin 引用只是本地已保存的远端引用，本轮没有 fetch 或查询最新远端状态。
- 固定 Lean/mathlib `v4.34.0`；mathlib manifest 与本地 checkout 均为 `5ed2965256430c3649e86755f9576b54eca72435`。

机器可读清单见 `T1_INPUT_MANIFEST.csv`，其中记录相对路径、SHA-256、用途及是否来自已提交基线。该清单不包含自身，不形成循环哈希。

## 2. 必需输入清单

| 文件/组合 | 用途 | 获取方式 |
| --- | --- | --- |
| `MolecularDynamics/Notation.lean` | 现有欧氏空间、质量矩阵与模型别名 | 已提交 HEAD，或用户提供原文件 |
| `MolecularDynamics/BasicDefinitions.lean` | 抽象可分离能量 | 同上 |
| `MolecularDynamics/Chapter01/NBody.lean` | 坐标质量、点态方程、动能/总能量及非负性 | 同上；必须核对完整原文件而非摘取单定理 |
| `MolecularDynamicsFormalization.lean`、`Scratch.lean` | 顶层导入和既有检查入口 | 同上；Scratch 不单独算正式成果 |
| `lean-toolchain`、`lakefile.toml`、`lake-manifest.json` | 版本和全依赖锁定 | 同上；不可自动重建为新版本 |
| `scripts/check.ps1` | 本地正式验收逻辑 | 同上；网站没有 PowerShell 时只报告不能执行 |
| `AGENTS.md` | 形式化与工作区维护规则 | 本地未跟踪，需由用户提供 |
| `FORMALIZATION_MAP.md`、`ASSUMPTIONS.md`、`STATUS.md` | 现有成果、表示选择和历史检查边界 | 已提交 HEAD；历史成功不等于本批新验证 |
| `docs/tasks/T1_SPEC.zh-CN.md` | 本批准确目标、原页核对、假设和候选结论 | 本地新准备，需由用户提供 |
| `docs/tasks/T1_API_CHECK.zh-CN.md`、`T1_APIProbe.lean.txt`、`T1_APIProbe.result.txt` | 固定版本 API / 类型检查及复现证据 | 本地新准备，需由用户提供 |
| `docs/tasks/T1_MATHCOPILOT_PROMPT.zh-CN.md` | 本批任务指令 | 由用户复制代码块发送 |
| 本文件 | 输入和双重验收标准 | 本地新准备，需由用户提供 |

可选背景：首轮审计的 `CHAPTER01_DEPENDENCIES.zh-CN.md`、`MATHLIB_AUDIT.zh-CN.md`、`NEXT_TASKS.zh-CN.md`。其中旧“习题范围待确认”和旧索引警示的歧义已由当前用户要求与 `T1_SPEC` 覆盖。缺少这些可选历史文件不妨碍完成本批陈述整理。

教材语义的直接输入可由用户提供 PDF 41–42 页图，或从给定教材截取对应页。只需这两页和 T1 规格，不要求为了本批上传整本 PDF。未提供原页时网站应明确仅审阅本地已核对转述。本轮只在本地生成原页图，没有任何上传。

不把 `.git`、`.lake`、密钥、账户配置或整个未提交工作树当输入附件。mathlib 的固定来源由 manifest 确认，实际调用的 API 和局部源码位置列在 API 文档中。

## 3. 本批网站的可验收输出

初始批使用 Lean Blueprint 整理陈述/依赖；有实质路线分歧时再用 Math Brainstorm。本轮不调用 Lean Proof。
网站开始前报告技能已启用且安装到正确项目，报告实际输入 HEAD；没有可用技能/文件/检查环境就写明缺项，继续能做的语义与依赖整理，不能改写为已使用或已验证。

网站交付见初始任务代码块：返回元数据、陈述审阅、依赖蓝图、环境/检查报告、逐项 ledger、修订差异表，以及实际执行的探针原文和原始日志。模板位于 `docs/tasks/templates/`。返回元数据须记录包 ID 与输入清单 SHA-256，并列出各输出文件 SHA-256；不哈希自身。
本批输出判定标准是“能逐项复核并准备后续实现”，不要求新定理已证明。待证明陈述留在文档；网站托管版本未知时检查状态仍是网站试验，不能称本地验收。

## 4. 网站结果导回后的第一阶段：陈述复核

1. 核对 RETURN_METADATA.json 的包 ID 与 PACKET_MANIFEST.csv SHA-256，记录网站 Task/项目标识、输入 HEAD、运行时间、实际技能/版本及输出文件哈希；本地重算各输出与元数据本身的哈希。导回报告保存到 `docs/tasks/T1_mathcopilot_return/` 下的独立运行子目录，保留原始输出，不覆盖本地规格和旧源码。
2. 对照本地 HEAD 和输入 manifest。若网站用了 main、历史 `bdcd1ec`、新版本 mathlib 或不完整导入闭包，登记差异；它的建议仍可阅读，但必须按本地输入重新核对。
3. 逐项对照 T1 ID：粒子数量/索引、`N_c` 与 `N_d`、排列、质量重复、方向非空条件、任意实质量下的动能等式、正质量的用途、逆矩阵含义。修订目标、增强假设、特例与表示推广均入差异表，不悄悄覆盖。
4. 用 PDF 原页检查变量、量词、定义域与公式；区分“本地已看原页”“网站独立看原页”“负责人复核”。网站报告自称正确不能自动替代本地语义复核。
5. 输出合并后的最终陈述/依赖文档与未解决项。本批到此即可完成网站准备闭环；没有新实现授权时停在这里，不启动证明。

## 5. 以后授权证明实现后的正式验收

1. 网站证明草稿先导回工作区上层 `tmp/t1-return/`，保存原文件/补丁和日志；审查前不把有占位的 `.lean` 放进正式库。仅逐项合入经核对的增量，保留当前所有未提交/未跟踪文件。
2. 按最终陈述核对证明：禁止 `sorry`、`admit`、新项目公理、`unsafe` 绕过；不把目标藏入假设。不把普通函数范数换成欧氏范数，不把“正定”作为粒子正质量桥接的额外输入。
3. 固定版本检查局部草稿与完整项目导入闭包；拟新增模块导入现有 NBody，顶层补导入。修正 API/强制转换后才进入正式库，三份固定版本文件保持原内容。
4. 在正式工程目录运行以下命令，记录具体输入版本、改动文件、时间、退出码及完整错误。脚本包含 lake build，不必额外重复构建；出现失败时再针对原因补充检查。

```powershell
# 在正式工程根运行；仅本次 shell 使用已安装的固定版本。
$env:PATH = 'C:\Users\ustc\.elan\toolchains\leanprover--lean4---v4.34.0\bin;' + $env:PATH
lean --version
lake --version
pwsh -NoProfile -File .\scripts\check.ps1
```

5. 关键新定理用临时探针导入完整正式工程后执行 `#print axioms`（名称依最终实现），例如粒子动能一致性、质量矩阵正定、可逆与两側逆定理。保存输出，核查没有项目自建公理、`sorryAx` 或未经登记依赖。`propext`、`Classical.choice`、`Quot.sound` 等 Lean 标准依赖应原样登记，不能说“无任何公理”冒充结果。
6. 核心语义样例检查 `d=1`、`d=3` 的坐标/质量顺序，以及 `N=0`、`d=0` 边界；特别确认 M3 无非空前提时被拒绝，能量桥接没有不必要正质量条件。样例只补充一般证明，不能用样例替代证明。
7. 逐项更新 `FORMALIZATION_MAP.md`、`ASSUMPTIONS.md`、`STATUS.md` 和相关 ledger：分别记录源码声明、Lean 内核/固定版本工程成功、教材语义复核及尚未完成项。随后更新 CURRENT_STATE 并追加 WORK_LOG。
8. Git 提交/推送/合并按届时明确授权执行；当前用户明确禁止这些操作，不能因为证明或检查成功就自动执行。

网站若只有单文件认证成功、缺完整导入闭包、版本未知、缺本地全工程构建或语义审阅，本地验收状态保持未完成。

## 6. 本轮实际验证边界

本轮只准备陈述、检查 API/表达式类型、核对文档及源码保留情况。没有改正式 `.lean`，没有运行新教材证明，没有为文档重复跑全工程 `lake build` 或 `scripts/check.ps1`。历史成功保留在交接记录中，不改写为本轮新成功。API 探针检查结果单独见 `T1_API_CHECK.zh-CN.md`。
