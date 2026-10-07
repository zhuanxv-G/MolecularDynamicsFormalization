# T3 固定输入、交付与验收边界

本批是2026-10-02的T3本地准备。七项规格/九个目标类型不计为七项证明成果。正式本地工程是验收基准；本批没有正式源码集成、全工程新构建、CI查询或MathCopilot任务发送。

## 输入快照

- 正式工程 `C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization`；分支chapter01-kinetic-energy-nonneg，源码基准121a9d02ad15500c630e505b363d5f04106d617f。
- Lean4.34.0固定二进制和manifest；mathlib checkout5ed2965256430c3649e86755f9576b54eca72435。
- 教材461页，SHA2561939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036。
- 起始 `../tmp/t3-preparation-20261002/baseline.json` 保存13个保护文件、20份冻结已有输入、实际Git/版本/教材哈希及开始时间。冻结副本在frozen-inputs/，不是网站已收到的副本。
- `T3_INPUT_MANIFEST.json` 保存本批各文件的工作区相对路径、字节数和SHA256，以及后续网站需要明确收到的必要附加文件；哈希不依赖LF/CRLF归一化，按原始字节计算。
- 正式源码可按固定Git对象读取；本轮四份T3文档、候选/探针和局部API报告尚未提交，必须单独附加。不能用HEAD或网站旧语义索引声称这些材料存在。

| 输入 | 用途 |
| --- | --- |
| BasicDefinitions/Notation正式源码 | 现有欧氏类型、普通Prod相空间、抽象SeparableEnergy接口 |
| Chapter01/NBody和ParticleCoordinates正式源码 | 速度动能/总能量、粒子展开、正质量矩阵逆 |
| 冻结T1规格与T1本地审阅 | 已有代数依赖；不冒充网站独立报告或负责人签核 |
| 冻结T2规格、API报告与最新本地陈述审阅 | 共享mass/velocityOperator候选和真实轨道接口边界；T2目标仍未证明 |
| 本轮source-audit/七图/提取/metadata | 真实原页和假设背景，尤其固定/变质量区别 |
| CandidateDefs和Probe03_TargetTypes及原始log/result | 七个候选定义和九个完整Prop目标的实际类型通过 |
| 三份根探针、四份导数最终探针及历史尝试 | 关键API/小型适配、零质量反例、公理检查；保留失败与未运行草稿 |
| spec-review与API_DERIVATIVE_REPORT/INPUTS | 独立数学边界复核和固定导数API完整声明 |

## 交付文件

1. T3_SPEC.zh-CN.md：原页定位、模型/定义域、七个候选定义、七项规格/九个目标完整类型、最小假设、样例与排除模型、依赖顺序。
2. T3_API_CHECK.zh-CN.md：实际版本、全部尝试/最终采用区分、完整API类型、命令/退出码/时长/哈希、小型适配、公理与未证明路线。
3. T3_MATHCOPILOT_PROMPT.zh-CN.md：仅第一阶段独立陈述/依赖审阅正文，后续起草进入条件；未发送。
4. 本输入与验收文件：冻结输入/必要附加清单、本批准备通过标准及正式证明后续标准。

临时证据、manifest、T3_SEND_BODY.txt及FINAL_VALIDATION.json在工作区上层tmp/t3-preparation-20261002/。保留实际失败与成功，不覆盖旧输出。工具脚本和所有路径可在manifest查找。

## 本批准备验收

最终结果以本轮实际生成的 `FINAL_VALIDATION.json` 为准。主对话执行以下检查后才把准备标记完成：

- 核对七页的源PDF/提取/渲染哈希和实际视觉审阅记录。
- 验证固定版本七个候选定义、九个待证Prop目标及最终七份探针均退出0；重核每份源码/log的SHA与结果记录。完整目标的任何未证明缺口不改成“通过”。
- 对命名小引理mixedMass_inv_zero与coordinateDualRepresentation读取实际#print axioms输出，只出现propext/Classical.choice/Quot.sound；没有用小引理审计替代未来全部目标审计。
- 核对规格中定义/目标代码片段与实际通过探针源码一致，检查必需ID、明确假设、UTF8、代码围栏与行末空白。
- 核对baseline的13保护文件与开始一致；核对20份冻结输入自身的原始字节。原T1/T2对话可以继续更新其审阅文件，若当前源与冻结副本不同则记录漂移，不覆盖对方文件。
- 逐项重核manifest记录、生成送审正文与meta，执行git diff --check，保存实际分支/HEAD/工作树和耗时。

本轮正式Lean/Scratch/工具链/验收入口未改变，所以只运行独立探针和文档/输入验收，不重复全工程check.ps1或远端CI。旧T1构建/CI记录只属于对应旧输入，不能当作T3构建证据。

## 尚未完成与后续正式验收

尚未完成：T3一般目标的完整证明、完整gradient K组合链、正式模块/顶层导入和映射/假设/STATUS集成、MathCopilot独立审阅、负责人语义签核。真实时间轨道Hamilton/Newton双向解等价须T2接口稳定；沿解守恒属T4。准备中的数值/空维数/奇异质量小适配不计为这些目标完成。

后续实施应固定新的源码和输入，复核T1网站结论及T2最终共享定义；逐目标准确陈述/完整证明，无sorry/admit/新增项目公理/unsafe绕过证明。修改正式Lean后运行 `pwsh -NoProfile -File scripts/check.ps1`，对关键定理保存#print axioms，同步FORMALIZATION_MAP.md、ASSUMPTIONS.md、STATUS.md，按授权处理Git与CI。机器验收和教材语义签核分别登记。

下一条具体动作：按T3_INPUT_MANIFEST明确提供未提交附加材料，发第一阶段Lean Blueprint逐ID审阅；既有T1/T2页面与发送由原对话协调，不并发覆盖共享网页编辑器。缺少网站会话时保留本地准备成果，如实记网站参与待完成。
