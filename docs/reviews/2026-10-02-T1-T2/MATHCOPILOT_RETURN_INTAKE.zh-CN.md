# MathCopilot T1/T2 原报告收件验收

检查时间：2026-10-02 23:41 +08:00。来源：同一 MathCopilot 项目的文件浏览器，T1 目录下载为 ZIP，T2 两个文件分别下载。原始下载保留在本机 `C:\Users\ustc\Downloads\`；九份报告保存到工程 `docs/tasks/T1_mathcopilot_return_git/` 和 `docs/tasks/T2_mathcopilot_statement_return/`。本收件未向网站上传或发送新任务。

## 原字节检查

T1 下载包 `T1_mathcopilot_return_git.zip` 的 SHA256 为 `33fa4c0501274b3b193496103ee51087aad162a6791d91bbeb718bc75ae66f83`。ZIP 恰含以下七个普通文件，路径不含子目录或上跳；每个本地解压件的字节数和 SHA256 与包内该 entry 实际解压字节相同。`RETURN_METADATA.json` 的 `outputs` 清单与七个文件名逐项一致。

| T1 文件 | 字节 | SHA256 |
| --- | ---: | --- |
| `RETURN_METADATA.json` | 6761 | `90ca5a3bf7f7c3266cf20da12fab44210cd697b8c1ab800875beacdcb0787f1c` |
| `T1_ENVIRONMENT_AND_CHECKS.zh-CN.md` | 3671 | `de7c5e40b56c03db31e17c580465f09b555c6c1399a69aa2a8f62e666262d5d8` |
| `T1_REVIEW_LEDGER.csv` | 3199 | `2394df6f5b58245d24607387d587cbba771d8c9b13034dc0160489d0ed6422ab` |
| `T1_DEPENDENCY_BLUEPRINT.zh-CN.md` | 4282 | `c7680324e0fcd15d9e79b5f2e5f66cbcb6e23a582e89947bbfe07883c7f2d4a9` |
| `T1_STATEMENTS_REVIEW.zh-CN.md` | 3908 | `3c63daa012de68ba4365a1c2feebe1ddc3f982bf5b5cb0e44b1c439c7f3b304d` |
| `T1_STATEMENT_CHANGES.csv` | 1677 | `95596d01346bd872d47060464c182d7248e688659325b0d5706a962217aca151` |
| `T1_PROOF_REVIEW.zh-CN.md` | 4857 | `d8fac0347c9322e4883e49c8ecce1b714fdac5bef31eddf44809d71f822adb85` |

T2 两份工程副本与下载原件的 SHA256 相同，并与网站项目页面事先列出的两个值相同：

| T2 文件 | 字节 | SHA256 |
| --- | ---: | --- |
| `T2_REVIEW.zh-CN.md` | 19724 | `bda5ac3cfbb088d508a05e4360ca6292d0412582ccc817957f32aff76f8b4801` |
| `T2_REVIEW_LEDGER.csv` | 3217 | `96ead0d71d97902e185db7ede2bda71e38a5ed2fbc18b09ab28b2c9993755c49` |

## 内容核对与界限

- T1 `RETURN_METADATA.json`、陈述/证明/依赖审阅、环境记录和两份 CSV 已读取。网站审阅的是固定提交 `052eea2edd51fd806edf6a9dacbb6cc3353fc82f`，其环境实际 HEAD 为 `bdcd1ecd710db5fbd6b8698e9ee3d3e05d535045`，并未声称读到本机后续 HEAD `121a9d02ad15500c630e505b363d5f04106d617f`。报告接受 11 个 T1 ID 和 13 条既有证明，未指出阻断项；负责人语义签核仍为 `pending`。这是只读独立审阅，不是本次重新编译。
- T2 完整报告及逐 ID CSV 已读取。网站报告称 20/20 输入区块原字节校验通过；本次验收确认收到的**报告文件**原字节哈希，没有重新取得和校验网站的 93795 字节输入附件。T2 的 S1/B1/B2/B4/E1 陈述接受，L0 要显式加入质量算子与矩阵作用的两个坐标桥接，B3 要把 `hFU` 代数核心和势能可微应用层分开。B4 不加 `IsOpen I`，E1 只限定 `F=0` 的一阶局部 IVP。
- 本地 `T2_SPEC_REVIEW_DELTA.zh-CN.md` 的 L0/B3 修订方向及其余五 ID 边界与上述完整报告和台账一致。其候选定义曾在固定 Lean v4.34.0/mathlib 的隔离探针中通过**类型检查**，未获得一般定理证明。T2 完整证明、正式构建/CI、负责人语义签核均未完成。

收件时实际分支为 `chapter01-kinetic-energy-nonneg`，HEAD `121a9d02ad15500c630e505b363d5f04106d617f`。正式 `.lean`、固定工具链、manifest 和检查脚本的 tracked diff 为空；旧 `FORMALIZATION_PLAN.md` 修改及其他未跟踪准备文件保留。未提交、推送、合并或重置。
