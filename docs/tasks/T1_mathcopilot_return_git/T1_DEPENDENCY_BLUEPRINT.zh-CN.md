# T1 依赖蓝图审阅

这是 `lean-blueprint` 的只读使用记录：审阅现有契约和依赖 DAG，不生成新 skeleton，不改变任何声明。

## 冻结对象与记号

- `N : ℕ`：粒子数；粒子索引 `Fin N`。
- `d : ℕ`：统一空间维数；教材对应实例为 `d=1`、`d=3`。
- `n : ℕ`：通用配置坐标数 `N_c`。
- `ParticleMasses N = Fin N → ℝ`。
- `ParticleVectors N d = Fin N → EuclideanSpace ℝ (Fin d)`。
- `particleCoordinateEquiv N d = finProdFinEquiv`，排列为 `a.val + d*i.val`。
- `coordinateMassesOfParticles`：将粒子质量按空间方向重复。
- `flattenParticleVectors`/`unflattenParticleVectors`：粒子族与 `Velocity (N*d)` 之间的坐标表示。
- `particleKineticEnergy = ∑ i, m i * ‖v i‖² / 2`，范数是每粒子欧氏范数。

## 根节点与依赖 DAG

T1 不是单一 `main_theorem`，而是规格中 11 个验收 ID 的一个共同 DAG。每个叶结论均在正式顶层模块中被导入。

```text
particleCoordinateEquiv
├── flattenParticleVectors
│   ├── I1 flattenParticleVectors_apply
│   └── I2 unflatten_flatten / flatten_unflatten
├── coordinateMassesOfParticles
│   ├── M1 coordinateMassesOfParticles_apply
│   ├── M2 coordinateMassesOfParticles_pos
│   └── M3 coordinateMassesOfParticles_pos_iff
└── I1 + M1 + EuclideanSpace.real_norm_sq_eq + finite-sum reindexing
    └── E1 nBodyKineticEnergy_particle_eq

Matrix.posDef_diagonal_iff
└── P1 diagonalMassMatrix_posDef_iff
    └── Matrix.PosDef.isUnit
        └── P2 diagonalMassMatrix_isUnit
            ├── Matrix.isUnit_iff_isUnit_det + mul_nonsing_inv
            │   └── P3 diagonalMassMatrix_mul_inv
            └── Matrix.isUnit_iff_isUnit_det + nonsing_inv_mul
                └── P3 diagonalMassMatrix_inv_mul

strict positive coordinates + diagonal multiplication + Matrix.inv_eq_left_inv
└── P4 diagonalMassMatrix_inv_eq

P3 diagonalMassMatrix_inv_mul + Matrix.mulVec_mulVec
└── P5 diagonalMassMatrix_inv_mulVec
```

P4 的现有证明直接构造左逆，并不依赖 P2/P3；这是有效的证明 DAG，不是缺失边。P5 实际依赖 P3 的左侧逆公式，而不依赖 P4 的逐项表达。

## 固定 API 审阅

| API | 审阅结果 |
| --- | --- |
| `finProdFinEquiv` / `finProdFinEquiv_apply_val` | 类型与粒子优先排列一致。 |
| `WithLp.toLp` | 正确用于构造有限欧氏坐标；没有把速度和动量的语义混为一谈。 |
| `Equiv.sum_comp`; `Fintype.sum_prod_type` | 足以将 `Fin (N*d)` 求和换为粒子/方向两重求和。 |
| `EuclideanSpace.real_norm_sq_eq` | 正确连接每粒子欧氏范数平方与坐标平方和。 |
| `Matrix.posDef_diagonal_iff`; `Matrix.PosDef.isUnit` | P1/P2 的类型匹配。 |
| `Matrix.isUnit_iff_isUnit_det` | P3 正确从 `IsUnit M` 转成库要求的 `IsUnit M.det`。 |
| `Matrix.mul_nonsing_inv`; `Matrix.nonsing_inv_mul` | P3 两侧逆的假设没有被误读。 |
| `Matrix.inv_diagonal` | 正式证明没有依赖其可能被误读的函数级 `Ring.inverse` 结论。 |
| `Matrix.mulVec_mulVec`; `Matrix.one_mulVec` | P5 的矩阵作用复合正确。 |
| `Matrix.toEuclideanLin` | T1 未使用；未把线性映射误称为连续线性映射。 |

## 对 T2 的依赖接口

1. 从粒子严格正质量 `hm` 出发，M2 给出坐标严格正质量，随后 P1/P2/P3/P4/P5 可安全提供质量矩阵正定、可逆及逆作用。
2. T2 若只需要从粒子质量前推到坐标质量，不需要 M3 的 `0<d`；只有反向恢复粒子质量时才必须携带它。
3. E1 提供公式 (1.4) 的粒子式/坐标式桥接，不能替代沿轨道求导或能量守恒。
4. T2 仍需独立引入时间轨道、速度/加速度与导数的对应、势能可微性、链式法则和沿轨道的 (1.3)。
5. 在受约束系统中不得把 `N_d` 代入当前 `N*d=N_c` 的环境坐标接口；若改用内禀广义坐标，需要新的、可能依赖位置且非对角的质量矩阵模型。

## 蓝图结论

现有依赖图闭合，API 选择与冻结规格一致，没有游离引理、结论藏入假设或无条件奇异逆公式。无需为 T1 收尾修改声明。负责人语义签核仍为 `pending`。
