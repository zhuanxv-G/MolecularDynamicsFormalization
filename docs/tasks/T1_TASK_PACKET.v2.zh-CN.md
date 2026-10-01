# T1 固定输入包 v2

包 ID：T1-preparation-v2。阶段：statement_review。11 个候选 ID 和数学规格沿用 T1_SPEC.zh-CN.md；此次仅独立审阅陈述、假设和依赖。

基准：chapter01-kinetic-energy-nonneg / 9587329cf646889b6ebbab7133ae76dce156450d。固定 Lean 4.34.0，mathlib 5ed2965256430c3649e86755f9576b54eca72435。

v1 是不可变历史包；v2 同步已经推送的验收机制和 GitHub CI。正式数学源码及固定版本与 v1 相同。原 SPEC/API 的旧提交是历史证据，不覆盖本包基准。现有动能非负证明仍只要求坐标质量非负；尚无新 T1 正式证明。

请读 START_HERE.zh-CN.md、PACKET_METADATA.json 并逐项验证 PACKET_MANIFEST.csv。project/ 是只读快照，textbook/ 包含 §1.2 印刷18–19 / PDF41–42。缺项、版本未暴露或基准不同必须明确报告；不直接覆盖项目，不升级依赖。

复制 project/docs/tasks/T1_MATHCOPILOT_PROMPT.v2.zh-CN.md 的完整代码块，使用 Lean Blueprint；确有路线选择时 Math Brainstorm。本次不调用 Lean Proof。回填包 ID、PACKET_MANIFEST.csv 哈希、实际项目/HEAD/环境和输出哈希。

报告输出到 docs/tasks/T1_mathcopilot_return_v2/，使用包内 templates。必交元数据、陈述审阅、依赖蓝图、环境检查、11项 ledger、陈述修订表。若执行检查，另附探针和完整原始输出。不得用类型检查替代证明。

T1_INPUTS_AND_ACCEPTANCE.zh-CN.md 是历史通用验收步骤；其 v1 包名/旧基准在本批由此 v2 入口、指令和清单替代，其数学与安全约定保持适用。集成后使用增强 scripts/check.ps1；机器通过与教材语义复核分别登记。

当前本地有隔离的完整证明草稿，未纳入附件，供后续实现/审阅批使用；本次要求独立审阅数学陈述，避免沿用草稿而省略条件审查。用户已授权发送必要材料并推进证明；网站审阅报告验收后继续后续批。
