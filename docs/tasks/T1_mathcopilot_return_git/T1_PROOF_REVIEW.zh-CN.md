# T1 既有证明逐条审阅

这是 `lean-proof` 的只读使用记录。审阅的是固定对象
`052eea2edd51fd806edf6a9dacbb6cc3353fc82f:MolecularDynamics/Chapter01/ParticleCoordinates.lean` 中现成的 13 条完整证明；本轮没有重证明、编辑或新增目标。

## 逐定理结论

| # | 定理 | 证明路线审阅 | 假设/API 审阅 | 结论 |
| ---: | --- | --- | --- | --- |
| 1 | `flattenParticleVectors_apply` | 展开 `flattenParticleVectors` 后由等价正反向化简。 | 无多余前提；保持粒子优先索引。 | 通过 |
| 2 | `unflatten_flatten` | 对粒子和方向函数外延，再由 simp 使用展开坐标与等价互逆。 | 对所有 `N,d`，空类型也成立；没有隐藏动力学含义。 | 通过 |
| 3 | `flatten_unflatten` | 对扁平坐标外延，展开两定义并用等价互逆。 | 不需要维数正性；目标确为原表示，不是弱化后的逐点子集。 | 通过 |
| 4 | `coordinateMassesOfParticles_apply` | 展开质量映射并化简等价逆。 | 无质量符号假设；三维重复排列正确。 | 通过 |
| 5 | `coordinateMassesOfParticles_pos` | 任取扁平坐标，将其逆像粒子索引直接交给 `hm`。 | `d=0` 时结论为空量词；统一陈述可接受。 | 通过 |
| 6 | `coordinateMassesOfParticles_pos_iff` | 正向选取方向 `0 : Fin d`，反向复用定理 5。 | `hd : 0<d` 正是恢复粒子质量所需前提；没有缺失 `0<N`。 | 通过 |
| 7 | `nBodyKineticEnergy_particle_eq` | 用等价换索引，再拆乘积求和；通过 I1/M1 化简，使用欧氏范数平方坐标公式及有限和分配律。 | 对任意实质量；每粒子范数而非外层函数范数。未增加正性。 | 通过 |
| 8 | `diagonalMassMatrix_posDef_iff` | 直接实例化 `Matrix.posDef_diagonal_iff`。 | 与 `Fin n`、`ℝ`、项目包装定义精确一致。 | 通过 |
| 9 | `diagonalMassMatrix_isUnit` | P1 正向得到正定，再调用 `Matrix.PosDef.isUnit`。 | 严格正性比单纯非零更强，但为统一物理入口，不是错误。 | 通过 |
| 10 | `diagonalMassMatrix_mul_inv` | P2 经 `isUnit_iff_isUnit_det` 转成行列式单位，再调用 `mul_nonsing_inv`。 | 正确满足库的实际前提，没有把 `IsUnit M` 直接误传。 | 通过 |
| 11 | `diagonalMassMatrix_inv_mul` | 与定理 10 对称，调用 `nonsing_inv_mul`。 | 两侧逆均有同一严格正质量假设。 | 通过 |
| 12 | `diagonalMassMatrix_inv_eq` | 用 `Matrix.inv_eq_left_inv`；构造逐项倒数对角矩阵的左逆，按对角/非对角分支验证。 | `hm` 经 `ne_of_gt` 排除零对角元；未使用无条件 `inv_diagonal`，避开奇异矩阵陷阱。 | 通过 |
| 13 | `diagonalMassMatrix_inv_mulVec` | 用 `mulVec_mulVec` 合成矩阵作用，随后复用定理 11 和 `one_mulVec`。 | 点态结论与 `Velocity n` 坐标接口一致；严格正质量足够。 | 通过 |

## 假设最小性

- I1/I2/M1/E1 无须 `N>0`、`d>0` 或质量正性，现有陈述没有添加这些多余条件。
- M2 的 `hm` 在 `d=0` 的单个退化实例中并非结论所必需，但它是统一前向桥接的正确假设，不构成验收问题。
- M3 的 `hd : 0<d` 不可删除。
- P2–P5 的严格正质量不是可逆性的逻辑最弱条件；非零质量即可。但 T1 规格有意选择物理正质量路线，且所有证明均正确使用该假设。

## 自动化与隐藏依赖

- I1/I2/M1 依赖 simp 集中的等价逆律和 `[simp]` 桥接引理；这是证明自动化依赖，不是隐藏数学假设。
- P4 的 `simp` 使用由 `hm` 得到的非零事实；奇异矩阵情形并未进入证明。
- 没有证明以待证结论作为参数，也没有将结论弱化成 `True` 或把关键性质藏进假设。

## 公理与完整性

- 固定对象正式 Lean 源的只读词法检查没有发现 `sorry`、`admit`、`axiom` 或 `unsafe`。
- 已保存的隔离和集成审计均报告 13 条 T1 定理只依赖 `propext`、`Classical.choice`、`Quot.sound`；这些是项目允许的标准逻辑依赖，没有项目新增公理。
- 本轮禁止构建，故没有生成新的 `#print axioms` 结果；上述结论明确依赖固定对象内的既有证据。

## 对 T2 的影响

- 质量/坐标桥接和粒子动能等式可直接作为 T2 的代数前置层。
- P3–P5 足以在严格正质量下消去或反演对角质量矩阵；T2 不应无条件使用逐项倒数。
- 当前证明没有定义轨迹、导数、ODE 解或 Hamiltonian，因此不会提前锁死 T2 的时间域与正则性设计。
- 未发现会迫使 T2 修改质量索引、范数或逆矩阵接口的问题。

## 审阅结论

13 条证明均接受，无阻塞缺陷。建议仅在后续维护中增强定义文档和必要时提供非零质量的更一般可逆性版本；不建议为 T1 收尾改动现有证明。负责人语义签核：`pending`。
