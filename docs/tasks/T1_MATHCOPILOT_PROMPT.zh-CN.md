# T1 MathCopilot 初始任务指令（供用户复制发送）

本文件已准备，尚未发送。本批只授权网站整理陈述、依赖和报告；不进入新教材证明实现。
先按 `T1_INPUTS_AND_ACCEPTANCE.zh-CN.md` 的输入清单确认项目和文件。下面整个代码块是可复制指令。

```text
请承接 Leimkuhler–Matthews (2015) 分子动力学教材 Lean 形式化项目的 T1 准备批：粒子/坐标与正质量桥接。

用户已确认 Math Brainstorm、Lean Blueprint、Lean Proof 在目标项目启用并安装。请核对你正在正确的 MolecularDynamicsFormalization 项目中：以 Lean Blueprint 整理准确陈述与依赖；若确有不同路线需要比较，可先用 Math Brainstorm。报告实际调用的技能；若运行时仍缺技能，明确报告缺项，不重复配置或自行声称已调用。Lean Proof 留到陈述复核后的下一批，本批不调用它补证明。

本批固定包 ID：T1-preparation-v1。若收到归档，请先阅读 START_HERE.zh-CN.md 和 PACKET_METADATA.json，核对 PACKET_MANIFEST.csv 中各文件 SHA-256；project/ 是只读输入快照，不可直接覆盖现有项目。教材原页位于 textbook/。回填收到的输入清单 SHA-256；不要混用后来修改的本地文件。没有归档而仅收到独立文件时，同样按用户提供的清单核对缺项和版本。

正式仓库：https://github.com/zhuanxv-G/MolecularDynamicsFormalization
输入分支：chapter01-kinetic-energy-nonneg
输入提交：6203fc19908312faf9c40d52cb299edb42422973
该提交尚未由本地 main 包含。本批不能默认改用 main，不能用历史网站任务的 bdcd1ec 代替本输入提交。
本地固定 Lean：leanprover/lean4:v4.34.0
mathlib：v4.34.0；manifest 锁定提交 5ed2965256430c3649e86755f9576b54eca72435
若能访问 shell，请记录 pwd、git rev-parse --show-toplevel、git branch --show-current、git rev-parse HEAD、lean --version、lake --version、mathlib checkout 提交；若只能使用托管 Lean 检查，请说明接口和它暴露的实际版本，未知就写未知。不要为适配托管环境更改本地固定版本或生成新版 manifest。

输入文件及其 SHA-256 以 T1_INPUT_MANIFEST.csv 为准。正式 Lean 导入闭包是 Notation.lean、BasicDefinitions.lean、Chapter01/NBody.lean 与顶层 MolecularDynamicsFormalization.lean；另提供 Scratch.lean 和三份版本文件、项目规则、语义说明与 T1 准备文档。
docs/tasks/ 下的新准备文件目前只在本地，不能假定克隆上述旧提交会得到它们；以用户随本任务提供的文件为补充输入。若缺文件，具体列出缺项，不虚构内容。
教材为用户指定 PDF，461 页，SHA-256：1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036。
本批原文依据是 §1.2，印刷 18–19 / 从 1 起的 PDF 41–42。若提供了局部页图，请检查公式版面；没有原页时，应以 T1_SPEC 中已核对转述为输入，并明确未独立查看教材原页。不要在未读教材时声称原文复核完成。

请先阅读 T1_SPEC.zh-CN.md，独立检查以下内容：
1. N 是粒子数；N_c 是配置位置坐标数；N_d 是局部自由度。三维笛卡尔坐标 N_c=3N，无约束时 N_d=N_c；r 个独立约束使 N_d=N_c-r，不能据此把坐标类型维数改为 3N-r 后继续套用原对角矩阵。
2. 采用 Fin N × Fin d，经 finProdFinEquiv 展开到 Fin (N*d)，粒子优先排列，标量编号为 a.val+d*i.val。d=1、3 对应原页，其余 d 是明示推广。Lean 零起点索引 i 对应教材第 i.val+1 粒子。
3. 每个粒子的质量重复到它的全部 d 个坐标。通用 CoordinateMasses n 仍保留任意坐标质量，不改写已有 API。
4. 粒子速度为 Fin N → EuclideanSpace ℝ (Fin d)；动能是各粒子欧氏范数平方的加权和。不可把普通函数空间的整体范数当成全体坐标的欧氏范数。
5. 动能两种表达的等式对任意实质量成立。正质量是正定/可逆性所需模型条件；不得给能量表达桥接增加不必要正性假设。
6. 从坐标正性推出所有粒子正性需要 0<d。d=0,N>0 时空坐标正性不能证明粒子正性。N=0 的空模型只作为代数退化情形记录。
7. Matrix.inv_diagonal 的右端是整条对角函数的 Ring.inverse，不可无条件改成逐坐标倒数；Matrix.mul_nonsing_inv / nonsing_inv_mul 需要 IsUnit M.det。
8. NBodyEquationAt 只是点态关系；本批不处理轨道、ODE、Hamiltonian 一致性、能量守恒或 Theorem 1.1。原 Theorem 1.1 是严格局部势能极小处的稳定性，不能换成 Hessian 正定特例。

请按 T1-I1/I2、M1/M2/M3、E1、P1–P5 给出：准确 Lean 结论类型、所有变量及量词、最小假设、与教材的对应/差异、可用 mathlib 声明和导入路径、建议证明依赖顺序。逐项指出规格中的错误或类型接口风险，并给出可审阅的修订建议，不能悄悄改变假设或目标。
可进行必要的现有 API #check 和候选表达式类型检查；这类检查不能算作新定理证明完成。本地 T1_API_CHECK 是固定版本证据，可以对照，但不能把网站未暴露版本的成功等同于本地正式验收。

本批输出只保存为 Markdown / CSV / 原始检查日志；尚未证明的定理头和定义草案放在文档代码块中，不向正式库加入不完整 .lean 文件。禁止 sorry、admit、新增项目 axiom、unsafe 绕过、假设目标结论。不要提交、推送、合并、重置、覆盖既有源码、升级依赖或向别的聊天发送消息。

请交付以下文件（在 docs/tasks/T1_mathcopilot_return/ 下）：
- RETURN_METADATA.json：参考 docs/tasks/templates/RETURN_METADATA.template.json，记录包 ID、输入清单哈希、实际基准/版本、技能、检查和返回文件 SHA-256；元数据不记录自身哈希，未知项不能伪造为匹配。
- T1_STATEMENTS_REVIEW.zh-CN.md：逐项陈述审阅；若修订，列出原式、修订式及原因。
- T1_DEPENDENCY_BLUEPRINT.zh-CN.md：依赖图/表、固定版本 API 与模块安排、推荐实现顺序；不包含新证明实现。
- T1_ENVIRONMENT_AND_CHECKS.zh-CN.md：实际项目路径、输入 HEAD、技能使用、Lean/mathlib 版本或未知项、每项检查命令/输出/退出状态及检查范围。
- T1_REVIEW_LEDGER.csv：至少 item_id,statement_status,assumptions,textbook_correspondence,api_status,open_issue 字段；区分类型可写、API 已查、待证明、本地未验收。
- T1_STATEMENT_CHANGES.csv：参考 STATEMENT_CHANGES.template.csv，列出陈述/假设修订；没有修订时保留表头并在审阅报告说明。
- 若做了检查，另附可复现的探针文本（扩展名 .lean.txt）和完整原始输出（.txt）。不能只交成功截图或单文件认证提示。

完成后列出输出路径和未完成项，停在陈述/依赖复核阶段，等待下一批的证明实现指令。本地工程将独立复核教材语义、固定版本导入闭包、完整构建、源码扫描及关键定理公理依赖，才决定正式集成。
```

网站技能启用及安装由用户确认；本地没有登录账号代替核查。任务仍需报告实际技能调用和运行环境，不能把技能名称出现于指令当作使用记录。
