# 33号：把全书收口结果合并到 main（2026-10-19 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第8章最终收口完成；全书第1–8章正文收口，等待用户新指令”），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“按33号合并到 main”，停止条件为第4节完成标准），然后执行。

## 0. 现状（Claude 已核对，开始前请复核）
- 历史是线性的：main = origin/main = d5dd5722（10-01）；chapter01-kinetic-energy-nonneg、chapter02–07-blueprint 全部是 chapter08-blueprint 的祖先，没有任何分支领先于 chapter08-blueprint。
- chapter08-blueprint = origin/chapter08-blueprint = 8dd49d72，比 main 多 526 个提交。
- 因此只需要**快进（fast-forward）**，不需要 merge commit，不会有冲突。

## 1. 步骤
1. 复核：`git fetch origin`；确认上面 0 节的关系仍成立（`git merge-base --is-ancestor main chapter08-blueprint`，以及各章分支都是其祖先）。若不成立，停止并在 CURRENT_STATE 报告，不要自行合并。
2. 不切换分支，直接移动本地 main：`git branch -f main chapter08-blueprint`（当前在 chapter08-blueprint 上，所以可以这样做）。
3. 推送：`git push origin main`。必须是快进；如被拒绝，**禁止 --force**，停止并报告。
4. 切到 main：`git switch main`（与 chapter08-blueprint 同一提交，工作区不受影响）。
5. 打标签：`git tag -a book-ch01-08-closeout -m "第1–8章正文收口（32号）"`，然后 `git push origin book-ch01-08-closeout`。
6. 在 main 上跑一次完整 check（正式库 + Blueprint/Ch01–08.lean），确认与 8dd49d72 时的结果一致。
7. 以后默认在 main 上工作；把 AGENTS.md / CURRENT_STATE / 交接文档中的“当前分支”改为 main，作为一个新提交推送到 main（只改文档）。

## 2. 不做的事
- **不删除**任何本地或远程分支（chapter01…08 全部保留作为存档）。
- 不 rebase、不 squash、不 force push，不改写历史。
- 不提交工作区中现有的未跟踪/已修改残留文件（第2–5章 validation 日志、各章 closeout 下的 **__pycache__**、ActiveCheck.lean、pdf259-raster*.pdf 等），保持原样，只在 CURRENT_STATE 里列出清单，等用户决定。
- 不改任何 .lean 文件和审阅文档内容。

## 3. 检查
- `git rev-parse main origin/main chapter08-blueprint` 中 main 与 origin/main 一致，且包含 8dd49d72。
- 正式库 0 sorry、0 axiom；Blueprint/Ch01–08.lean 字节与 8dd49d72 一致。

## 4. 完成标准
- origin/main 已快进到包含 8dd49d72，标签 book-ch01-08-closeout 已推送，完整 check 通过，文档已改为以 main 为当前分支。
- CURRENT_STATE 顶部写“全书第1–8章已合并到 main，等待用户新指令”，然后停止。
