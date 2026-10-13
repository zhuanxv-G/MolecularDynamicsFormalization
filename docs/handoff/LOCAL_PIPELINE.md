# 第2–6章本地流程总进度

| 章 | 范围（印刷/PDF页） | 分支 | 当前步骤（①–⑤） | 最近检查点 commit | 完成/未完成 |
|---|---|---|---|---|---|
| 2 | 53–94 / 75–116 | chapter02-blueprint | ⑤终验完成 | 8ca2ccf | 完成 |
| 3 | 97–136 / 119–158 | chapter03-blueprint | ⑤全部本地流程验收完成 | 433a13ca6407 | 完成 |
| 4 | 139–174 / 161–196 | chapter04-blueprint | ⑤全部本地流程验收完成 | ca2715c9646e | 完成 |
| 5 | 179–209 / 200–230 | chapter05-blueprint | ⑤全部本地流程验收完成 | c5887923f159 | 完成 |
| 6 | 211–258 / 232–279 | chapter06-blueprint | ①–⑤§6.3.1已检验；批6.3.1落盘（104条） | 910c3cc47205 | 未完成 |

页界已渲染核对：第3章p.136/PDF158的Exercises之前保留；第4章正文至p.174/PDF196，Exercises为PDF197–199；第5章p.209/PDF230的Exercises之前保留；第6章正文至p.258/PDF279，Exercises为PDF280–281；第7章PDF282起不进入。
第5、6章PDF偏移为+21，与第3、4章的+22不同，不套用旧偏移。范围证据见blueprint/local_pipeline/boundaries.png。
此表为跨章唯一总进度；逐条状态仅在blueprint/chXX/PROGRESS.md。每完成≤8条即落盘并更新两者；每节完整check及commit+push。
第2章已完成证据复用：blueprint/ch02/DELIVERY_VALIDATION.json与五节CHECK_REPORT；不重做。未提交半成品核对后续做，不丢弃。
正式库字节冻结；第1章按授权网站修复例外处理。网站状态以绑定版本及WEBSITE_AUDIT_RULES.zh-CN.md为准；第5/6章每节提交后交替处理一批网站修复。
第5章不新建Mathlib缺失的大型理论，单节2小时；第6章不恢复封存断点/长证明，Thm6.1/6.2/Prop6.4无现成桥接则sorry。
全部完成后停止于第6章；入口改为第2–6章本地流程全部完成，各章等待用户提交网站批次。

网站修复检查点：第1章§1.1 EAUDIT02已本地检验并生成3份复审包；回第6章§6.2，完成该节后处理第1章下一批。网站计数见CURRENT_STATE及各章WEBSITE_SUMMARY。


网站修复检查点：第1章§1.1.1 EAUDIT03已本地检验，4份复审包；回第6章§6.3。网站计数见CURRENT_STATE。


网站修复检查点：第3章章首/§3.1 EAUDIT01已本地检验，4份复审包；回第6章§6.3.2。历史第3章本地交付433a13ca不覆盖新签名，当前网站修复验收见EAUDIT01/ACCEPTANCE。
