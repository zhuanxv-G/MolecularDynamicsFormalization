# T1 固定输入包入口

包编号：`T1-preparation-v1`。阶段：**陈述/假设/依赖审阅**，不是证明实现。
用户于 2026-10-01 已确认 Math Brainstorm、Lean Blueprint、Lean Proof 启用及项目安装；这是用户确认，本地没有代替账号核查。此批使用 Lean Blueprint，必要时 Math Brainstorm，Lean Proof 留给后续实现批。

## 目标与停止条件

独立审阅 §1.2 粒子/坐标与正质量桥接的 11 个候选 ID：T1-I1/I2、M1/M2/M3、E1、P1/P2/P3/P4/P5。交付准确陈述、最小假设、依赖顺序和环境证据；不补新教材证明。

准确命题、变量、量词及定义草案以 `T1_SPEC.zh-CN.md` 第 3–5 节为准。不能将 `N_d` 与环境坐标数混用；反向正性桥接需 `d>0`；粒子/坐标动能表达一致性不要求正质量。任何修订先登记差异和原因。

## 输入与环境

- 源码提交：`6203fc19908312faf9c40d52cb299edb42422973`；分支 `chapter01-kinetic-energy-nonneg`；仓库 `https://github.com/zhuanxv-G/MolecularDynamicsFormalization`。
- 固定 Lean：`leanprover/lean4:v4.34.0`；mathlib revision：`5ed2965256430c3649e86755f9576b54eca72435`。
- 教材：Leimkuhler–Matthews (2015)，PDF SHA-256 `1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036`。
- 只附印刷 18–19 / PDF 41–42 的既有页图；包内 `textbook/section12-041.png`、`section12-042.png`。原图由此前本地原页核对生成，本轮未重新审阅数学内容。
- 已有源码含定义与 `nBodyKineticEnergy_nonneg` 的完整证明；本地 T1 API 探针只证明类型可表达，11 个新候选 ID 均未证明。
- 完整项目本地闭包、历史验证说明、19 项输入清单和所有本批文档一并提供；mathlib 缓存不随包发送。

## 包的使用

本地用 `scripts/package_task.py` 和 `T1_PACKET_CONFIG.json` 生成固定快照。归档内根目录为 `START_HERE.zh-CN.md`、`PACKET_METADATA.json`、`PACKET_MANIFEST.csv`；`project/` 保存项目相对路径，`textbook/` 保存两页图。

将归档作为附件提供给网站后，先在隔离附件目录阅读 `project/` 快照，核对其基准与当前项目。不要直接覆盖已有工作树。若网站只能读取单独文件，按 `PACKET_MANIFEST.csv` 提供同一快照中的文件，不混用后来改动的版本。

主任务指令为 `project/docs/tasks/T1_MATHCOPILOT_PROMPT.zh-CN.md` 的完整代码块。指令中的 `docs/tasks/...` 路径按正式工程根解析；附件阅读时对应 `project/docs/tasks/...`。报告写入项目中的 `docs/tasks/T1_mathcopilot_return/`。缺输入或实际基准不一致时明确报告。

## 返回与验收

必交 RETURN_METADATA.json、陈述审阅、依赖蓝图、环境/检查报告、逐项 ledger、修订差异表。若执行类型探针，另附 `.lean.txt` 与完整输出。模板位于 `docs/tasks/templates/`，待填写项不能当成成功证据。

元数据须回填包 ID 与收到的 PACKET_MANIFEST.csv SHA-256、实际项目/HEAD/Lean/mathlib、技能调用、每次检查及每个返回文件的 SHA-256。RETURN_METADATA.json 不记录自身哈希，避免循环；本地导回时再计算它的哈希。

`T1_INPUTS_AND_ACCEPTANCE.zh-CN.md` 第 4 节是此批验收；第 5 节只在未来授权证明实现后适用。没有执行的检查写未运行，版本未暴露写未知；本批不能标为 11 项证明完成。

本轮只生成本地包，没有发送网站任务、上传文件、修改正式 Lean、Git 提交/推送/合并或重置。
