# T5 输入、交付与验收边界

2026-10-02本地准备；本批没有网站发送、正式目标证明或源码集成。固定分支chapter01-kinetic-energy-nonneg/HEAD121a9d02ad15500c630e505b363d5f04106d617f；Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435。

## 已冻结输入

开始22:17:43+08:00，baseline捕获22:18:48。13个保护文件包括旧FORMALIZATION_PLAN、Scratch、顶层、4正式Lean模块、toolchain/lake配置和3验收入口。22个既有输入原始字节复制到frozen-inputs，baseline记录原路径/字节数/SHA。共享handoff不冻结为数学输入，更新本批标记区块并追加日志，保留其他对话工作。

教材11701675字节、461页、SHA2561939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036；重新提取/渲染/实际查看PDF53–57。metadata保留执行命令、页码、140DPI、退出码及各输出哈希。

## 四份交付与证据

| 文件 | 作用 |
| --- | --- |
| docs/tasks/T5_SPEC.zh-CN.md | 原页范围、4定义/5ID/6一般目标、精确条件、证明路线和边界 |
| docs/tasks/T5_API_CHECK.zh-CN.md | 固定实际完整类型、5最终探针、9次尝试、6小适配/边界样例、公理检查 |
| docs/tasks/T5_MATHCOPILOT_PROMPT.zh-CN.md | 只审阅任务正文、返回原件/metadata要求、后续起草进入条件 |
| docs/tasks/T5_INPUTS_AND_ACCEPTANCE.zh-CN.md | 输入冻结、交付、包使用和分层验收 |

完整证据在工作区tmp/t5-preparation-20261002：baseline；CandidateDefs；Probe01及目标tail；每次探针lean/log/result；PROBE_AUDIT；api-topology和API_EXTRA_INPUTS；source-audit；spec-review；保存/打包/验证脚本。失败尝试保留供复现，不作为必要的成功输入。

## 附加输入的提供规则

T5尚未提交到Git，MathCopilot不能仅按HEAD收到本地文档。T5_INPUT_MANIFEST.json的files列出本批证据的字节数/SHA，required_for_review列出真正应提供的文件；manifest保留全部失败历史，而审阅ZIP只含必要输入及manifest/当前发送正文。ZIP不含完整教材PDF，含五张原页图与审计；需要更多原页时另明确提供原PDF，不声称已经收到。

T5_SEND_BODY.txt由当前任务正文附加required文件的哈希生成，不嵌入旧任务的未来起草正文；T5_PACKAGE_META.json记录manifest/body/ZIP原始SHA及逐成员复核。文件数量以实际JSON为准；送审前重新确认这些字节未变、实际附件可读取。若原网站仅能读取Git，先解决未提交附加输入路径，不能假装Git读取已覆盖它们。

返回件要求原始T5_REVIEW.zh-CN.md、T5_RETURN_METADATA.json及实际运行日志，逐文件保存原件、字节数/SHA和逐ID结论。网页摘要不替代原件，网站自报哈希须与收到字节核对。无任务/附件能力时保持“本地准备完成、网站待参与”。现有T1/T2页面由接续对话协调，本批不抢用。

## 已验证的层级

- 原页层：461页/源SHA、PDF53–57提取和140DPI渲染退出0，五张实际视觉查看；印刷32/PDF55公式/Theorem1.1与证明边界，印刷33/PDF56Hessian充分段。
- 候选层：4定义/6一般目标Prop通过，目标代码与SPEC围栏逐字一致。只登记类型，没有证明一般目标。
- 接口层：23+6=29声明和IsMinFilter定义；6个小拓扑适配，5最终采用探针全部实际退出0且无警告。
- 边界层：实数quartic strict/球面r⁴/连续性、常数非严格且非strict、Position0空sphere和δ=1；六命名边界引理加三命名拓扑引理公理仅标准三项。
- 保存层：FINAL_VALIDATION核对冻结22、保护13、所有manifest/ZIP成员/源码日志哈希、固定mathlib、严格UTF8/围栏/空白、候选代码一致、git diff --check。实际结果以文件为准，若未通过不得宣称完成。

最终检查不重跑正式check.ps1，因为正式Lean/顶层/Scratch/版本/验收入口本批未改。既有工程成功不是T5一般目标证明。FormalizationMap/ASSUMPTIONS/STATUS随将来正式实现更新，本次不制造证明进度。

## 尚未验证与正式实施验收

一般D1/C1/S1/O1完整证明、Position1等距桥接、quartic二阶导数、其余手算反例、MathCopilot独立审阅、负责人语义签核、正式T5构建与远端CI均未完成。没有提交/推送/合并/重置、浏览器操作或T5任务发送。

后续陈述稳定后：在固定版本分批完整证明，检查所有假设与原页对应、公理扫描；集成正式模块并维护顶层和数学进度文件；重新运行scripts/check.ps1、关键#print axioms、负责人逐ID语义复核，Git操作按会话实际授权。静态势能屏障验收不能代替轨道不出球、真实守恒/动量控制、延拓和Theorem1.1全相空间全时间稳定性验收。
