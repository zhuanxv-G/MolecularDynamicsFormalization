# 网站返回件版本绑定与修复（2026-10-13）

本规则来自用户2026-10-13新指令，优先于旧的“缺绑定一律不提升”“第1章冻结暂停”“网站一律待审”。第2–6章本地流程顺序及heartbeat配置不变。

- 新格式：返回件的`input_sha256`逐项匹配对应BATCH、Blueprint Lean、依赖闭包文件当前或已登记的SHA256，即绑定到该输入快照。登记旧快照时必须验证原始返回件和收据的哈希，不能只信返回件自报的哈希。
- 旧格式：BATCH与该次整套任务包MANIFEST的`full_batch_sha256`一致，并以`git log <生成commit>..<返回登记commit> -- Blueprint/ChXX.lean`确认期间无修改，即绑定到生成commit。生成commit取MANIFEST所在的整套包生成检查点；不能把BATCH内容最后变化时间当作每次重生成时间。第1章旧MANIFEST的`task_sha256`是完整BATCH字节哈希，登记时明确记录其等价字段名，不改写历史MANIFEST。
- PASS显示“网站PASS（绑定版本 <commit/sha>）”；FAIL进入修复；NEEDS_HUMAN分材料缺失和原文数学判断。不满足绑定的仍为待网站审计，列明不符条件。绑定到历史输入的PASS不自动覆盖修复后的新签名。
- `../mathcopilot_bundles/`是Claude生成的import依赖闭包；核对BUNDLE_MANIFEST.json，只读引用，禁止复制进工程或修改。
- 第2章第一轮C仅参考；reaudit的audit优先，json_review仍取第一轮。reaudit目录JSON对象含batch/input_sha256/items，接收新文件时重新登记；不覆盖原始返回件和历史收据。
- 修复顺序：第1章→第3章→第2章reaudit到齐后。每完成第5/6章一节处理一批网站修复，再回本地流程；不恢复第1章长证明，不建设缺失大型理论。
- FAIL根据suggested_fix和反例修Blueprint签名，保留对象、量词及全部结论；忠实性优先，不弱化。原书疑误保留原句和[ERRATUM?]，涉及数学选择交导师，不自行裁定。
- 修复后单文件Lean、相关本地证明及完整节检查；逐条公理、七段文档更新。登记EAUDIT，逐条compact包含PASTE/原页PDF/MANIFEST且总字节<256000，要求网站实际写入`/workspace/.mathcopilot/reviews/chXX_eaudit/EAUDITxx_review.json`，对象含input_sha256及items。
- NEEDS_HUMAN.md分(i)材料缺失：补材料复审；(ii)原文数学判断：一句话问题和选项，供导师裁定。json_review CORRECTED仅在重新视觉核对PDF原页后合并，repair_log只追加，不覆盖旧issues或日志。
- 每节修复完成commit+push；CURRENT_STATE每章一行“网站PASS x / 修复中 y / 待导师 z / 待复审 w”。四项按有效网站工作队列互斥计数；待复审包括材料缺失、绑定不符及已修待网站复审。绑定和网站PASS不等于Lean证明完成，含sorryAx仍incomplete。

登记工具：`scripts/integrate_website_returns.py`；每章website_audit.json保留原判定及绑定证据，WEBSITE_SUMMARY.json给出计数，mathcopilot_results/binding20261013/保存本次不可覆写输入收据。历史原文/Lean验收只对应其记录的版本。
