# T1 固定版本 API 与候选类型检查

2026-10-01（Asia/Shanghai）。这是声明检查与表达式类型检查，不是 T1 新证明。

## 环境与运行入口

- 正式源码基线：`chapter01-kinetic-energy-nonneg` / `6203fc19908312faf9c40d52cb299edb42422973`。
- Lean 实际输出：`Lean (version 4.34.0, x86_64-w64-windows-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)`。
- Lake 实际输出：`Lake version 5.0.0-src+293d5d0 (Lean version 4.34.0)`。
- mathlib manifest 与实际 checkout：`5ed2965256430c3649e86755f9576b54eca72435`，固定 `v4.34.0`。
- 探针临时源：工作区上层 `tmp/t1-preparation/APIProbe.lean`；仅导入已有 Mathlib 和正式顶层模块，使用 `#check` 与匿名表达式，无新定理/证明。
- 可供网站读取的探针副本：本目录 `T1_APIProbe.lean.txt`；原始最终输出：`T1_APIProbe.result.txt`。它们作为文本输入，不是正式 Lean 模块。

从正式工程根执行：

```powershell
$env:PATH = 'C:\Users\ustc\.elan\toolchains\leanprover--lean4---v4.34.0\bin;' + $env:PATH
lean --version
lake --version
lake env lean '..\tmp\t1-preparation\APIProbe.lean'
```

PATH 调整仅对该命令 shell 生效，不改账户/系统配置或工具链文件。没有触发 elan 下载，没有联网升级。

## 检查结果与覆盖范围

- 首次探针退出码 1：`pp.width` 在该版本是未知选项，猜测的 `finProdFinEquiv_apply` 名称不存在；其余输出列出了依赖声明及匿名表达式的类型。这次不能记为检查通过。
- 去掉未知选项，并将索引 API 改为实际存在的 `finProdFinEquiv_apply_val` 后，第二次探针退出码 **0**。覆盖质量展开、欧氏向量展开/还原、正定性实数有限维实例化、IsUnit/行列式与两侧逆的接口，以及逆坐标作用和动能为零的候选 Prop。
- 为补查本批核心 E1 与 M3 的完整候选表达式，最终探针另增加匿名的动能等式及带 `0<d` 参数的正性等价；最终运行于 21:41 前结束，退出码 **0**，没有错误/警告诊断，原始日志已保存为 `T1_APIProbe.result.txt`。所有输出均为现有声明或候选表达式的类型。

类型为 `Prop` 只说明陈述能表达，**没有生成该命题的证明项**。第二/最终探针成功不能标记 T1-I/M/E/P 的任何新结论为已证明。

## 关键声明的实际接口

下列实数有限索引摘要来自实际 `#check`；完整类型类参数见原始输出。

| 声明 | 实际接口要点 | 固定 mathlib 源码位置 |
| --- | --- | --- |
| `finProdFinEquiv` | `Fin N × Fin d ≃ Fin (N*d)` | `Mathlib/Logic/Equiv/Fin/Basic.lean:332` |
| `finProdFinEquiv_apply_val` | `↑(e(i,a)) = ↑a + d*↑i`，粒子优先排列 | 同文件生成的 simps 引理 |
| `WithLp.toLp` | 包装标量坐标函数为 Lp 型；本项目用 `p=2` | 完整类型见探针输出 |
| `EuclideanSpace.equiv` | 欧氏空间与坐标函数空间的连续线性等价，**不表示默认范数相同** | `Mathlib/Analysis/InnerProductSpace/PiL2.lean` |
| `EuclideanSpace.real_norm_sq_eq` | `‖x‖² = ∑ a, (x a)²` | 同文件 `:156` |
| `Equiv.sum_comp` | 有限等价换索引：`∑ i, g(e i) = ∑ k, g k` | `Mathlib/Algebra/BigOperators/Group/Finset/Defs.lean` 的 to_additive 生成声明 |
| `Fintype.sum_prod_type` | 有限乘积索引和等于两重和 | 精确类型见输出；本轮未继续定位其定义文件 |
| `Matrix.posDef_diagonal_iff` | `(diagonal μ).PosDef ↔ ∀ i, 0<μ i`；实数/Fin 实例通过 | `Mathlib/LinearAlgebra/Matrix/PosDef.lean:203` |
| `Matrix.PosDef.isUnit` | 矩阵正定推出 `IsUnit M`；实数有限维实例通过 | 同文件 `:557` |
| `Matrix.isUnit_iff_isUnit_det` | `IsUnit M ↔ IsUnit M.det` | `Mathlib/LinearAlgebra/Matrix/NonsingularInverse.lean:127` |
| `Matrix.mul_nonsing_inv`、`nonsing_inv_mul` | 从 `IsUnit M.det` 得 `M*M⁻¹=1`、`M⁻¹*M=1` | 同文件 `:211,:217` |
| `Matrix.inv_diagonal` | `(diagonal μ)⁻¹ = diagonal (Ring.inverse μ)`，这里 μ 是整条函数 | 同文件 `:566` |
| `Matrix.mulVec_diagonal` | `(diagonal μ).mulVec w i = μ i*w i` | `Mathlib/Data/Matrix/Mul.lean:752` |
| `Matrix.mulVec_mulVec` | `M.mulVec (A.mulVec w) = (M*A).mulVec w` | 同文件 `:889` |
| `Matrix.toEuclideanLin` | 矩阵到欧氏空间**线性映射**的线性等价；输出不是连续线性映射 | `Mathlib/Analysis/InnerProductSpace/PiL2.lean:1242` |

`inv_diagonal` 后还需要从正质量/可逆性得到逐坐标倒数的桥接，不能把输出中的 `Ring.inverse μ` 直接删去。该桥接是 T1 待做内容。

## 其他尝试与实际未做项

- 首次 PDF 文字输出受 Python 默认 GBK 编码限制，对连字 `ﬁ` 抛出 `UnicodeEncodeError`；PDF 页数已读为 461，渲染成功。改为 stdout UTF-8 后重取两页文本成功，且原页图已经人工查看；该输出问题不涉及教材或 Lean 源码失败。
- 一次按猜测路径搜索有限和源码，两个路径不存在；之后改用实际存在的 `Finset/Defs.lean` 及运行探针核对名称。不把失败的路径检索当作“库没有 API”。
- 未改正式 `.lean`、Scratch、工具链或 manifest；没有为文档重复完整构建/check，未运行新定理公理依赖检查（尚无新定理）。没有执行网站任务、上传、远端查询或 Git 写入操作。
