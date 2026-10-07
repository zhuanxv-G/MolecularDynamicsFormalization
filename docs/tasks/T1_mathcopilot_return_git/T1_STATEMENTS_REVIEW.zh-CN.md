# T1 陈述独立审阅

批次：`T1-review-20261002-readonly`。审阅对象固定为 Git 提交
`052eea2edd51fd806edf6a9dacbb6cc3353fc82f`，不使用当前工作树源码替代。

## 总结

11 个 T1 ID、13 条 Lean 定理的前提、量词范围和结论均与 T1 规格一致；未发现需要阻止 T1 收尾的陈述错误。任意空间维数 `d` 是对教材实直线和三维情形的显式代数推广；真正对应原页的是 `d=1` 和 `d=3`。负责人最终语义签核仍为 `pending`。

本轮直接从哈希匹配的教材 PDF 提取了 PDF 41–42 的文本，确认原文涉及 `N`、`N_c=3N`、`N_d=N_c-r`、三维质量三次重复及每粒子欧氏范数动能。先前记录的页面 PNG 不在当前工作区，本轮没有图像级复核，因此不把先前人工看图记录冒充为本轮新检查。

## 逐 ID 审阅

| ID | 现有声明 | 审阅结论 | 前提与语义 |
| --- | --- | --- | --- |
| T1-I1 | `flattenParticleVectors_apply` | 接受 | `Fin N × Fin d ≃ Fin (N*d)` 使用粒子优先顺序，坐标值为 `a.val + d*i.val`。不需要质量、`N>0` 或 `d>0`。 |
| T1-I2 | `unflatten_flatten`; `flatten_unflatten` | 接受 | 对所有 `N,d` 互逆，包括空索引代数情形；没有把互逆误读为轨道或动力学结论。 |
| T1-M1 | `coordinateMassesOfParticles_apply` | 接受 | 每粒子质量沿其 `d` 个坐标重复；`d=3` 精确给出教材 `m₁,m₁,m₁,m₂,m₂,m₂,…` 排列。 |
| T1-M2 | `coordinateMassesOfParticles_pos` | 接受 | `∀i,0<m i` 正确推出全部坐标质量为正；`d=0` 时结论为空量词，但不被宣称为物理系统。 |
| T1-M3 | `coordinateMassesOfParticles_pos_iff` | 接受 | 反向恢复粒子质量明确要求 `hd : 0<d`，该条件必要；不需要额外的 `0<N`。 |
| T1-E1 | `nBodyKineticEnergy_particle_eq` | 接受 | 使用每个粒子 `EuclideanSpace ℝ (Fin d)` 的欧氏范数；对任意实质量成立，正确地没有增加正质量假设。 |
| T1-P1 | `diagonalMassMatrix_posDef_iff` | 接受 | 通用坐标质量矩阵正定当且仅当每个对角质量严格为正；不是伪装成教材编号定理。 |
| T1-P2 | `diagonalMassMatrix_isUnit` | 接受 | 严格正质量足以推出 `IsUnit`。非零质量已足以可逆，故该假设不是逻辑最弱，但与 T1 物理正质量路线一致。 |
| T1-P3 | `diagonalMassMatrix_mul_inv`; `diagonalMassMatrix_inv_mul` | 接受 | 两侧逆关系均在严格正质量下陈述；实际库接口所需的 `IsUnit det` 在证明中显式获得。 |
| T1-P4 | `diagonalMassMatrix_inv_eq` | 接受 | 逐坐标倒数公式仅在严格正质量下给出，没有把奇异矩阵的 `Ring.inverse` 无条件解释成逐项普通倒数。 |
| T1-P5 | `diagonalMassMatrix_inv_mulVec` | 接受 | 在严格正质量下逐坐标恢复速度；普通函数坐标与欧氏向量接口没有被替换成错误的外层函数空间范数。 |

## 共同语义边界

- `n` 始终表示环境配置坐标数 `N_c`，不是受约束自由度 `N_d`。`Notation.lean` 的模块注释已在固定对象中修正。
- `N*d` 是环境坐标数；约束只可能降低独立方向数，不改变这里的环境索引。
- `N=0` 或 `d=0` 只保留为 Lean 中合法的代数退化情形。
- T1 不包含时间轨道、ODE、Hamiltonian 一致性、势能正则性或能量守恒。
- `nBodyKineticEnergy_nonneg` 是既有上游定理，不计入 ParticleCoordinates 的 13 条 T1 定理。

## 非阻塞建议

- 后续应用定理应在物理层显式写出 `0<N` 以及 `d=1` 或 `d=3`，不要把这些条件不必要地加回纯代数桥接。
- P2–P5 可以在未来另行推广到非零质量或直接可逆性假设；本轮不建议改变现有 T1 陈述，因为统一的严格正质量前提更适合作为 T2 的物理入口。
- 可补充未带文档注释的定义说明，但这属于文档维护，不影响陈述验收。
