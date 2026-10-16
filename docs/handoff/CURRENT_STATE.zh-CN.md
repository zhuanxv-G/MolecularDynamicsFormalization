# 19号：第1章收口 + 原文/修正版双版本（2026-10-16 用户指令，覆盖此前“第1章暂停/低优先级”）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部，并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重），然后再开始执行。

## 0. 优先级
- 第6章：把当前 WIP（批27）提交为 WIP 检查点后暂停，不再推进；不进入第7章。
- 第2–5章：修复已完成（终验 93d2d3e5），保持不动，等待用户提交 EAUDIT 复审包。
- 当前唯一任务：第1章收口，目标是可以交给导师（师兄）审阅的完整版本。
- 正式库 MolecularDynamics/ 仍保持 0 sorry、字节冻结；所有改动在 blueprint/ 内。

## 1. 先登记未处理的网站返回
- blueprint/ch01/mathcopilot_results/eaudit/EAUDIT02_result.json、EAUDIT03_result.json（目前 untracked）以及 ch01/validation/EAUDIT01-return-registration/ 登记入库。
- 注意：EAUDIT02 的 HardSphere、EAUDIT03 的 MorseMinimum/LengthBond/HeterogeneousLJ 曾被网站 /workspace 中的旧 Ch01.lean 干扰；判定时以返回中对附件签名的语义结论为准，哈希不一致仅由旧文件引起的，记为“需复审”，不要记为 FAIL。
- 更新 WEBSITE_SUMMARY.json、PROGRESS.md。

## 2. 修复第1章 21 条网站 FAIL
- 按第2–5章相同做法（REPAIR_QUEUE 四类：漏前提/漏结论/对象不忠实/原书疑误）修签名，每节完成后生成 EAUDIT 复审包，PASTE 开头沿用第2–5章的“以本 PASTE 和附件为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信”，并内嵌哈希。
- 62 条“已修待复审”中凡尚无现行复审包的，一并生成；最后写 ch01/mathcopilot_tasks/EAUDIT_INDEX.md，只列现行待提交包。

## 3. 原书疑误条目：原文版 + 修正版 + 问题标注（导师明确要求）
导师意见：“既要留原文和修正后的，也要标注一下问题所在，方便找人来 check。”
适用范围：NEEDS_HUMAN.md (ii) 的 9 条，以及 PROGRESS.md 中所有标注“字面假命题/待导师裁定/勘误”的条目（如 MinimumHessianLiteral、HartmanGrobmanLiteral、ConstantRotationLiteral、TransitivityErgodicityLiteral、VariationalEquationLiteral、NearbyTrajectoryLiteral、TrimerEscapeLiteral、TorusDense、LocalActionAngleReduction、ConvexLegendre、LJRepulsion 等）。对每一条：
1. 原文版：保留现有 *Literal 声明，签名逐字忠实，不改；仍为 sorry；docstring 首行加【原书疑误】。
2. 修正版：新增独立声明（命名 `<原名>_corrected`，若有两种合理修正可加 `_corrected_a/_b`，对应 NEEDS_HUMAN 中的两个选项），docstring 写“修正版，对应原文 <source_id>，改动：……”。修正版能用现有材料证明的就证明（遵守时间盒：同一路线失败3次即止，保留 sorry 并记录原因）；需要大型缺失理论（一般 Hartman–Grobman、一般 Kronecker 稠密、Liouville–Arnold 等）的只写陈述、保留 sorry，不建设大理论。
3. 若某条原文按字面实际可以被反驳，尽量给出 Lean 反例证明（如极小点 Hessian 只能半正定：U(x)=x⁴ 在 0），声明命名 `<原名>_counterexample`；做不出就在文档里写数学反例。
4. 问题标注：新建 docs/review/CH01_ERRATA.zh-CN.md，每条一节，固定字段：
   - source_id；印刷页 / PDF 页；原文引文（逐字）
   - 问题所在（一两句话，说清楚哪里不严谨）
   - 反例或理由
   - 原文版 Lean 名称及状态（sorry，不证）
   - 修正版 Lean 名称、改动内容、证明状态（已证 / sorry + 原因）
   - 待人工核查点（请核查人重点看什么）
   - 导师选项（沿用 NEEDS_HUMAN 的选项，标注我们默认采用哪个）
   该文件要能脱离仓库单独发给第三方核查人阅读。
5. 修正版也纳入网站复审包（与原文版同包，PASTE 中说明“原文版为忠实转录，修正版为勘误版本，请分别审校”）。

## 4. 第1章完成标准
- 网站 FAIL 修复中 = 0；所有待复审条目都有现行复审包且列在 EAUDIT_INDEX.md。
- CH01_ERRATA.zh-CN.md 完成，覆盖第3节全部条目。
- 单文件编译 + 逐条 #print axioms + 一次完整 check 通过（只在第1章做完后跑一次完整 check）。
- 生成一份给导师的总结 docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md（≤2页）：条目总数、网站 PASS/待复审数、已证/sorry 数及 sorry 分类（原书疑误不证 / 缺大型理论 / 时间盒止）、勘误清单链接。
- 提交并 push 后，CURRENT_STATE 顶部写“第1章收口完成，等待用户提交第1章 EAUDIT 复审包（见 EAUDIT_INDEX.md）”，然后停止，不自动回第6章，等待用户新指令。


---

## 历史规则与状态（冲突处以19号指令为准）

# 当前可操作状态

当前任务：继续完成第6章本地流程（印刷211–258 / PDF232–279）；第2–5章沿用已完成修复验收，不进入第7章。
下一步：第6章§6.3.3的132条单文件编译已通过；完整检查正在blueprint/ch06/validation/section633-resume1运行，读取CHECK_REPORT及RUNNING进程证据复用结果。完成后提交/推送，再激活ch06_section635.py下一8条。

第2–5章修复终验沿用93d2d3e5；网站复审和导师判断待用户处理。第6章已验证至128条；132条批27尚未验证。

## 历史状态（旧第6章暂停已由用户恢复）

# 当前可操作状态

第2–5章修复完成，等待用户提交 EAUDIT 复审包（见各章 mathcopilot_tasks/EAUDIT*/INDEX.md）
下一步：本轮停止，只确认状态；等待用户明确新指令。第6章暂停，不进入第7章。

第2章：网站PASS 67 / 已修待复审 75 / 待导师 18 / 修复中 0。
第3章：网站PASS 51 / 已修待复审 78 / 待导师 20 / 修复中 0。
第4章：网站PASS 42 / 已修待复审 110 / 待导师 27 / 修复中 0。
第5章：网站PASS 51 / 已修待复审 117 / 待导师 15 / 修复中 0。
第6章：暂停，§6.3.3 WIP 6b822a9a524f；批27未验证，不重跑；batch26裁页document closed只记录。
heartbeat lean：新授权范围已保存，ACTIVE/15分钟/target/去重哈希已读回核对，未实测额度恢复接续。

最终交付：671条；800项声明公理已核对；380个逐条复审包、86个现行批次，哈希/预算/完整结论/定义闭包已验。
已验证：原PDF页、相关既有证明重查、固定版本单文件及各章完整check；未验证：网站新复审、导师裁定、额度恢复自动接续实测。
提交入口：[EAUDIT_SUBMISSION_INDEX.md](EAUDIT_SUBMISSION_INDEX.md)；终验：[REPAIR_DELIVERY_VALIDATION.json](REPAIR_DELIVERY_VALIDATION.json)。

## 历史状态（以下推进第6章、交替修复及旧停止条件均被2026-10-14指令覆盖）

# 当前可操作状态

当前任务：第2–6章本地流程继续；按2026-10-13规则交替修复第1→3→2章网站审计（第2章reaudit已到齐）。
下一步：第6章①–③§6.3.3 图6.4/6.5频率族及路径弱极限4条；已落盘132条，批27；从blueprint/ch06/PROGRESS.md读取缺项和现有编译结果继续。

网站版本绑定与修复规则：docs/handoff/WEBSITE_AUDIT_RULES.zh-CN.md；以下旧日期登记保留作历史，不代表当前有效状态。
第2章：网站PASS 108 / 已修待复审 5 / 待导师 2 / 修复中 45。
第3章：网站PASS 91 / 已修待复审 4 / 待导师 5 / 修复中 49。
第2章EAUDIT01：章首3条reaudit FAIL完整修复；原页75–76、单文件、完整check/160条公理、3份compact通过；仅定义，未新增定量误差或实际解存在证明，网站复审待提交。
第1章EAUDIT01新返回5份已登记；有效历史绑定5/5，原始判定保留，缺绑定列材料待复审；未合并原文或改变Lean。
§6.3.2检查点：112条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§6.3.1检查点：104条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
第3章EAUDIT01：四条完整签名修复，一般振子能量差/两条例外直线/不守恒已证；原页/单文件/完整check/149条公理/4份compact已验，网站复审待提交。
§6.2检查点：96条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
第1章EAUDIT03：§1.1.1两条签名修复与两条材料补齐；原页/单文件/完整check/141条公理/4份compact已验；LJ经验语义待导师。
第1章：网站PASS 49 / 修复中 21 / 待导师 9 / 待复审 62。
第1章EAUDIT02：§1.1两条FAIL签名已修、Schrodinger补材料；PDF28–30/单文件/完整check/141条公理/compact字节及裁页均已验；网站复审待提交。
顺序：第2章完成且复用 → 第3章 → 第4章 → 第5章 → 第6章；不进入第7章。
跨章唯一总进度：docs/handoff/LOCAL_PIPELINE.md；当前章逐条进度：blueprint/ch06/PROGRESS.md。
约束：正式库0 sorry且源码/签名不改；第1章交付冻结；其他任务文件保留不动。
第2章reaudit BATCH01–05共20条已登记；BATCH及Lean SHA匹配，依赖附件未找到；修订未应用，网站仍待审。
§6.1检查点：48条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§5.6检查点：183条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
第5章全部本地流程完成：183条、旧映射全覆盖、七段文档、compact预算/哈希/裁页、全部节完整检查已验；网站和导师审校待完成。
§5.5检查点：149条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§5.4.1检查点：137条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§5.4检查点：110条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
第2章BATCH01–32的160条新返回已登记（15 PASS/130 NEEDS/15 FAIL）；版本绑定未验，修订未应用，原文/Lean及已通过本地交付不变。继续第5章。
§5.3.3检查点：101条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§5.3.2检查点：97条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§5.3.1检查点：68条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§5.2.3检查点：55条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§5.2.2检查点：50条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§5.2.1检查点：31条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
第1章2026-10-12 BATCH02–23新返回136条已登记；44 PASS/66 NEEDS/26 FAIL为原返回，缺版本绑定不提升网站PASS；原文JSON及Lean不改，提案留待原页复核。回第5章§5.2.1。
§5.1检查点：11条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.4.2检查点：179条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
第4章全部本地流程完成：179条、旧映射全覆盖、七段文档、compact预算/哈希/裁页、全部节完整检查已验；网站和导师审校待完成。
§4.4.1检查点：160条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.4检查点：141条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.3.6检查点：110条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.3.5.1检查点：106条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.3.5检查点：100条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.3.4检查点：90条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.3.3检查点：79条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.3.2检查点：76条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.3.1检查点：65条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.2检查点：42条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§4.1检查点：24条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
第1章2026-10-11返回件例外：四条NEEDS与旧Legendre FAIL原样保留，来源/输入绑定未验证；仅Legendre原页字段及hPositive修订，141条公理与完整check通过，五份EAUDIT01预算/裁页已核，无网站PASS或冻结。
§4检查点：16条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§3.7检查点：149条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
第3章全部本地流程完成：149条、旧映射全覆盖、七段文档、compact预算/哈希/裁页、全部节完整检查已验；网站和导师审校待完成。
§3.6检查点：128条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§3.5检查点：101条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§3.4检查点：88条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§3.3检查点：65条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§3.2检查点：25条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§3.1检查点：9条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
自动续接：lean保持ACTIVE/15分钟及原target/去重记录；仅明确额度中断且恢复时发送，同一失败轮一次、间隔≥30分钟；同章同检查点连续3次无进展中断则停发并通知。
最近已验收：第2章160条、32批/160份compact，5节check通过且已推送8ca2ccf；网站审计与导师问题未验证。
启动预检：PDF章界已视觉核对；第3–6章旧清单分别143/100/86/126条，正文逐页核对尚待推进。

## 历史第2章交付（以下停止条件已被2026-10-10新指令取代）

# 当前可操作状态

第2章本地部分完成；第1、2章均等待用户提交 MathCopilot 批次（见 blueprint/ch01|ch02/mathcopilot_tasks/INDEX.md）
下一步：仅确认等待状态；有新返回件则按EAUDIT与追加repair_log规则整合、修签名后重审；不进入第3章。

范围：正文印刷p.53–94（PDF75–116），p.94 Exercises起排除；第3章PDF119起，不进入。
分支：chapter02-blueprint；起点8fac966abdc551c63ddaea7c8504f80f89ff812d。其他任务文件保留、不删不提交。
约束：正式库及第1章交付字节冻结，基线见blueprint/ch02/BASELINE.json；heartbeat lean ACTIVE/15分钟不修改。
§2.5检查点：160条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。
本地汇总：self-contained 65；checked+documented priors 40；incomplete 55。直接sorry 47，仅传递sorry 0；导师疑点20项。
交付：160旧条目全部映射；32批/160份compact，最大228893字节；终验见blueprint/ch02/DELIVERY_VALIDATION.json。
§2.4检查点：135条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。
§2.3检查点：110条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。
§2.2检查点：56条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。
§2.1检查点：12条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。
验证：42页正文原页已渲染并视觉核对；全章逐字转录、本地预审、Lean编译及公理检查完成。网站审计和导师裁定尚未验证。


