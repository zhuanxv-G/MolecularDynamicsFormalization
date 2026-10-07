# T1 审阅环境与检查边界

## 实际环境

- 工作目录：`/workspace/MolecularDynamicsFormalization`。
- 实际分支：`chapter01-kinetic-energy-nonneg`。
- 实际 HEAD：`bdcd1ecd710db5fbd6b8698e9ee3d3e05d535045`。
- 审阅开始时 `git status --short`：空。
- 附件所列后续本地 HEAD `121a9d02ad15500c630e505b363d5f04106d617f` 在本地 Git 对象库中不存在。
- 数学实现提交 `c7d9778fe981c24ba7281db730206d1cfefbba4d` 与固定审阅提交 `052eea2edd51fd806edf6a9dacbb6cc3353fc82f` 均存在。
- `c7d9778..052eea2` 之间没有 `.lean` 变化；后者只增加或更新状态、交接、知识和验证文档。

## 实际只读命令与结果

| 目的 | 命令类别 | 结果/退出码 |
| --- | --- | --- |
| 附件完整性 | `wc -c`; `sha256sum` | 4267 字节；哈希匹配；退出 0。 |
| 仓库状态 | `pwd`; `git branch --show-current`; `git rev-parse HEAD`; `git status --short`; `git remote -v` | 成功；退出 0。 |
| 固定对象存在性 | `git cat-file -e <rev>^{commit}` | `c7d9778`、`052eea2` 存在；`121a9d02` 不存在。 |
| 固定输入读取 | `git show 052eea2:<path>` | 所有指定源码、规格和验证证据均可读；退出 0。 |
| 固定 blob 哈希 | `git show ... | sha256sum` | `ParticleCoordinates.lean` 与 `NBody.lean` 均匹配授权哈希。 |
| T1 定理计数 | 固定对象输出经 `rg '^(@[simp] )?theorem'` | 13 条。 |
| 禁用标记扫描 | `git grep` 固定对象的 `*.lean` | 未发现 `sorry/admit/axiom/unsafe`；退出 0。 |
| 教材核对 | `wc -c`; `sha256sum`; `pdftotext -f 41 -l 42 -layout` | PDF 大小/哈希匹配；文本提取退出 0。 |

## 本轮未运行

- 未运行 `lake build`、`lake env lean`、`scripts/check.ps1` 或任何托管 Lean Check。
- 未运行新的 `#print axioms`、API probe 或小类型检查。
- 未查询、重建、配置或修复语义索引；没有把 `git show` 源码读取称为语义检索成功。
- 未安装或下载 Lean/mathlib 工具链。
- 未执行任何 checkout、pull、merge、reset、rebase、add、commit 或 push。

## 既有机器证据（非本轮重跑）

固定提交包含的验收报告记录：

- Lean `v4.34.0`，commit `293d5d0c0c3f3dded4688b3ccd6a33939ac5102b`。
- Lake `5.0.0-src+293d5d0`。
- mathlib `v4.34.0`，commit `5ed2965256430c3649e86755f9576b54eca72435`，工作树干净。
- 完整构建 8929 jobs、Scratch、60 个项目声明依赖审计均成功。
- T1 远端 CI 对提交 `c7d9778fe981c24ba7281db730206d1cfefbba4d` 的 run `36894446209` 结论为 success。

这些是固定对象中的历史证据，不是本轮网站或当前容器的新检查。

## 哈希与行尾说明

本报告记录的是 `git show 052eea2:<path>` 输出的 Git blob 字节 SHA-256。既有 `RESULT.zh-CN.md` 中 `CHECK_REPORT.json` 的哈希 `98b7...` 对应其 Windows CRLF 原始产物；固定 Git blob 经行尾规范化后的哈希为 `973e...`。将 Git blob 转回 CRLF 后可复现 `98b7...`，故这属于行尾表示差异，不是数学源码不一致。

## 教材可视核对限制

哈希匹配 PDF 的 41–42 页文本已直接读取，能够核对章节、公式编号、`N_c/N_d`、质量排列和动能结构。规格中提到的两个 PNG 文件在当前工作区缺失，本轮没有创建新渲染，因此没有独立完成公式字形/上下标的图像级复核。先前报告的人工看图结果仅作为既有证据保留。

## 未完成项

- 负责人最终语义签核：`pending`。
- 当前环境对固定版本工程的新构建：按授权未运行。
- 语义索引有效性：未验证且未操作。
- PDF 页面图像级独立复核：未完成。
