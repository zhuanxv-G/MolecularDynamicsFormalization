# 第2–6章本地流程总进度

| 章 | 范围（印刷/PDF页） | 分支 | 当前步骤（①–⑤） | 最近检查点 commit | 完成/未完成 |
|---|---|---|---|---|---|
| 2 | 53–94 / 75–116 | chapter02-blueprint | ⑤终验完成 | 8ca2ccf | 完成 |
| 3 | 97–136 / 119–158 | chapter03-blueprint | ①–⑤§3.2已检验；批3.2落盘（25条） | 7f0be4324697 | 未完成 |
| 4 | 139–174 / 161–196 | chapter04-blueprint（待建） | ①待开始 | 未开始 | 未完成 |
| 5 | 179–209 / 200–230 | chapter05-blueprint（待建） | ①待开始 | 未开始 | 未完成 |
| 6 | 211–258 / 232–279 | chapter06-blueprint（待建） | ①待开始 | 未开始 | 未完成 |

页界已渲染核对：第3章p.136/PDF158的Exercises之前保留；第4章正文至p.174/PDF196，Exercises为PDF197–199；第5章p.209/PDF230的Exercises之前保留；第6章正文至p.258/PDF279，Exercises为PDF280–281；第7章PDF282起不进入。
第5、6章PDF偏移为+21，与第3、4章的+22不同，不套用旧偏移。范围证据见blueprint/local_pipeline/boundaries.png。
此表为跨章唯一总进度；逐条状态仅在blueprint/chXX/PROGRESS.md。每完成≤8条即落盘并更新两者；每节完整check及commit+push。
第2章已完成证据复用：blueprint/ch02/DELIVERY_VALIDATION.json与五节CHECK_REPORT；不重做。未提交半成品核对后续做，不丢弃。
第1章与正式库字节冻结；新第1章返回件在当前节提交后按EAUDIT整合。网站一律待网站审计。
第5章不新建Mathlib缺失的大型理论，单节2小时；第6章不恢复封存断点/长证明，Thm6.1/6.2/Prop6.4无现成桥接则sorry。
全部完成后停止于第6章；入口改为第2–6章本地流程全部完成，各章等待用户提交网站批次。
