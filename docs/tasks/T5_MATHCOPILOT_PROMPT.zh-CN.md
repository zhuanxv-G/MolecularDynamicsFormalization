# T5 MathCopilot 独立陈述审阅指令（本轮未发送）

本轮生成送审材料，未上传或发送T5；T1/T2页面和回执收取仍由接续对话管理。不能把这个本地文件、任务技能选择或仓库HEAD当作网站参与证据。

## 可发送正文

```text
请在formal math项目实际调用Lean Blueprint，独立审阅T5「严格局部势能极小值的球面正能量屏障」的四候选定义、五规格ID和六待证Prop类型。必要时用Math Brainstorm检查数学边界。当前任务仅陈述/依赖审阅，不调用Lean Proof起草一般目标，不修改正式库，不提交/推送/合并/重置、不重建索引。历史输入中的未来起草指令不在本轮范围。

仓库https://github.com/zhuanxv-G/MolecularDynamicsFormalization，分支chapter01-kinetic-energy-nonneg，源码基准121a9d02ad15500c630e505b363d5f04106d617f，Lean v4.34.0，mathlib5ed2965256430c3649e86755f9576b54eca72435。先报告实际读取Git对象、网站工作区HEAD、工具/技能版本，三者不得混用，不覆盖网站分叉提交。取不到固定对象时报告缺口，不替换为网站当前工作区。

本批T5材料未提交，必须另行取得并按T5_INPUT_MANIFEST.json逐个核对SHA256：四份T5文档、CandidateDefs、Probe01_TargetTypes及五个最终采用探针的源/log/result、PROBE_AUDIT、拓扑/额外库输入清单、原页审计与截图、独立数学复核和冻结源码/版本。Git HEAD并不包含这些附加文件。只收到文件名不能开始声称完成输入审阅。当前指令优先于包内历史文件。

教材核心印刷32/从1起算PDF55；本轮视觉审计印刷30–34/PDF53–57。PDF461页/SHA2561939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036。原定义为∃R>0,0<‖q−q₀‖<R→U(q₀)<U(q)，Theorem1.1假设smooth U推出(q₀,0)稳定。原文仅给证明思路，紧球面/统一差是形式化补充。Hessian正定是充分特例，不替代严格极小。

逐ID检查：
T5-D1：固定mathlib没有IsStrictLocalMin/IsStrictLocalMinOn。候选相对严格极小定义IsStrictPotentialMinOn保留q₀∈Q；StrictPotentialMinRadius仅含正半径和去心严格差。桥接去心相对邻域Q\{q₀}；univ版匹配教材。严格只单向推出≤的IsLocalMinOn，常数势能反向不成立。
T5-C1：K紧、ContinuousOn U K、∀q∈K,c<U(q)推出∃δ>0,∀q∈K,c+δ≤U(q)。IsCompact.exists_forall_le'已处理空集；不得多加Nonempty或把一致δ放进假设。exists_isMinOn取点才需要非空。
T5-S1：给明确StrictPotentialMinRadius U Q q₀ R，0<r<R，sphere⊆Q，U仅球面连续；Position n有限维proper故球面紧。r=R不被原开球条件支持。纯位置屏障不加质量、动量、导数、守恒或轨道。
T5-O1：Q开且q₀∈Q、U在Q连续、strict见证，选域内R>0，再∀r,0<r→r<R→∃δ>0。不得交换∀r∃δ次序。内闭球包含可由r<R补得，便利开放域前提可局部化。
T5-E1：已编译实数x⁴的strict/δ=r⁴/连续性，常数势能非strict，Position0空球面与δ=1。n=0主屏障可真空成立，取极小点才需Nonempty；NormedSpace.sphere_nonempty实际要求NontrivialTopology。未编译的r=R反例、Hessian/二次增长、非紧/不连续例子必须如实区分。

六个Goal只是类型登记，一般目标未证明；六拓扑小适配不代表主屏障完成。源码/日志原始SHA和实际退出码优先于文字摘要；故意负探针和被替代尝试不能算成功。九个命名小引理公理输出只含标准三项。

本批不接管T1/T2回执，不依赖T2-L0/B3修订或T3完整Hamiltonian证明；正式稳定性仍需可微内点梯度零、真实Hamilton场、连续解、守恒、动量控制和紧困延拓。配置势能屏障不等于相空间全时间稳定；Prod范数/教材范数及sup严格界留待后续明确。禁止sorry/admit、项目新公理、unsafe绕过或把目标结论预置进假设。

返回T5_REVIEW.zh-CN.md和T5_RETURN_METADATA.json：实际读取Git对象、每个附加输入原始字节数/SHA256；实际工具/版本/技能调用；逐ID接受/修订/拒绝/依赖缺口；完整Lean假设与结论；固定库声明名/module/type；原页对应与补充条件；建议证明顺序；实际命令/退出码/原始日志；未验证事项和负责人待签核项。网站无固定环境时明确未检查类型/证明。本地之后仍须正式check.ps1和语义复核；不得把网页摘要当完整原报告。
```

## 后续起草的进入条件

实际取得逐ID原报告并核对输入/输出哈希，解决必要修订并固定新快照，再安排Lean Proof分批起草D1→C1→S1→O1，E1保留边界样例。正式实施前按依赖决定公开定义/名称；当前T5Preparation名字不直接混入库。稳定性连接另依T2–T4及延拓安排。

送审正文与附加包在工作区tmp/t5-preparation-20261002/T5_SEND_BODY.txt和T5_REVIEW_INPUTS.zip；精确哈希见T5_PACKAGE_META.json。本轮仅生成本地文件，没有发送成功回执。
