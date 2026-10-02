# 已通过机器验收的 Lean 声明目录

用途：供 MathCopilot 及后续任务从固定 Git 快照检索本库依赖。当前语义工具返回无关测试库，故先按本目录查找名字，再读取相应原始源码。这是源码检索路径，不代表网站语义索引已通过。

例如：要把按坐标写的动能转换成按粒子写的动能，先查 `MolecularDynamics.nBodyKineticEnergy_particle_eq`，导入 `MolecularDynamics.Chapter01.ParticleCoordinates`，再核对下方完整声明。它不要求质量为正；逆矩阵引理则要求逐坐标质量严格为正。

固定源码快照 `54b75a14aaa968522903d82eef947ffdc7bbf165`；数学实现 `c7d9778fe981c24ba7281db730206d1cfefbba4d`。本目录在后续文档提交中新增，读取目录应使用包含它的发布提交；旧源码快照不包含本次新增的目录文件。Lean v4.34.0，mathlib revision `5ed2965256430c3649e86755f9576b54eca72435`。机器验收依据见 `docs/verification/2026-10-02-T1/`，负责人教材语义签核仍待完成。

本目录从两份实际源码提取定理头，逐字节核对两份已记录的源码 SHA-256；14 条均有完整证明。机器可读名字、模块、完整类型和哈希见 `LEAN_DECLARATIONS.json`。下方定理头在 `namespace MolecularDynamics` 中解释，不是新建的正式 Lean 模块。

| 完整名字 | 导入模块 |
| --- | --- |
| `MolecularDynamics.nBodyKineticEnergy_nonneg` | `MolecularDynamics.Chapter01.NBody` |
| `MolecularDynamics.flattenParticleVectors_apply` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.unflatten_flatten` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.flatten_unflatten` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.coordinateMassesOfParticles_apply` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.coordinateMassesOfParticles_pos` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.coordinateMassesOfParticles_pos_iff` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.nBodyKineticEnergy_particle_eq` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.diagonalMassMatrix_posDef_iff` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.diagonalMassMatrix_isUnit` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.diagonalMassMatrix_mul_inv` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.diagonalMassMatrix_inv_mul` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.diagonalMassMatrix_inv_eq` | `MolecularDynamics.Chapter01.ParticleCoordinates` |
| `MolecularDynamics.diagonalMassMatrix_inv_mulVec` | `MolecularDynamics.Chapter01.ParticleCoordinates` |

## MolecularDynamics.nBodyKineticEnergy_nonneg

```lean
theorem nBodyKineticEnergy_nonneg {n : ℕ} (masses : CoordinateMasses n)
    (velocity : Velocity n) (hm : ∀ i, 0 ≤ masses i) :
    0 ≤ nBodyKineticEnergy masses velocity
```

## MolecularDynamics.flattenParticleVectors_apply

```lean
@[simp] theorem flattenParticleVectors_apply {N d : ℕ} (v : ParticleVectors N d)
    (i : Fin N) (a : Fin d) :
    flattenParticleVectors v (particleCoordinateEquiv N d (i, a)) = v i a
```

## MolecularDynamics.unflatten_flatten

```lean
@[simp] theorem unflatten_flatten {N d : ℕ} (v : ParticleVectors N d) :
    unflattenParticleVectors (flattenParticleVectors v) = v
```

## MolecularDynamics.flatten_unflatten

```lean
@[simp] theorem flatten_unflatten {N d : ℕ} (w : Velocity (N * d)) :
    flattenParticleVectors (unflattenParticleVectors w) = w
```

## MolecularDynamics.coordinateMassesOfParticles_apply

```lean
@[simp] theorem coordinateMassesOfParticles_apply {N d : ℕ} (m : ParticleMasses N)
    (i : Fin N) (a : Fin d) :
    coordinateMassesOfParticles m (particleCoordinateEquiv N d (i, a)) = m i
```

## MolecularDynamics.coordinateMassesOfParticles_pos

```lean
theorem coordinateMassesOfParticles_pos {N d : ℕ} (m : ParticleMasses N)
    (hm : ∀ i, 0 < m i) : ∀ k, 0 < coordinateMassesOfParticles (d := d) m k
```

## MolecularDynamics.coordinateMassesOfParticles_pos_iff

```lean
theorem coordinateMassesOfParticles_pos_iff {N d : ℕ} (m : ParticleMasses N)
    (hd : 0 < d) :
    (∀ k, 0 < coordinateMassesOfParticles (d := d) m k) ↔ (∀ i, 0 < m i)
```

## MolecularDynamics.nBodyKineticEnergy_particle_eq

```lean
theorem nBodyKineticEnergy_particle_eq {N d : ℕ}
    (m : ParticleMasses N) (v : ParticleVectors N d) :
    nBodyKineticEnergy (coordinateMassesOfParticles (d := d) m)
      (flattenParticleVectors v) = particleKineticEnergy m v
```

## MolecularDynamics.diagonalMassMatrix_posDef_iff

```lean
theorem diagonalMassMatrix_posDef_iff {n : ℕ} (m : CoordinateMasses n) :
    (diagonalMassMatrix m).PosDef ↔ ∀ i, 0 < m i
```

## MolecularDynamics.diagonalMassMatrix_isUnit

```lean
theorem diagonalMassMatrix_isUnit {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) : IsUnit (diagonalMassMatrix m)
```

## MolecularDynamics.diagonalMassMatrix_mul_inv

```lean
theorem diagonalMassMatrix_mul_inv {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) :
    diagonalMassMatrix m * (diagonalMassMatrix m)⁻¹ = 1
```

## MolecularDynamics.diagonalMassMatrix_inv_mul

```lean
theorem diagonalMassMatrix_inv_mul {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) :
    (diagonalMassMatrix m)⁻¹ * diagonalMassMatrix m = 1
```

## MolecularDynamics.diagonalMassMatrix_inv_eq

```lean
theorem diagonalMassMatrix_inv_eq {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) :
    (diagonalMassMatrix m)⁻¹ = Matrix.diagonal (fun i => (m i)⁻¹)
```

## MolecularDynamics.diagonalMassMatrix_inv_mulVec

```lean
theorem diagonalMassMatrix_inv_mulVec {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (w : Velocity n) (i : Fin n) :
    ((diagonalMassMatrix m)⁻¹).mulVec ((diagonalMassMatrix m).mulVec w) i = w i
```

## 使用边界

- 每次使用先核对任务基准提交和原模块；后续源码变化时重新生成目录并验收。
- 质量正性恢复的 iff 要求 `0 < d`；矩阵逆结论不能丢掉 `∀ i, 0 < m i`。
- `NBodyEquationAt` 是点态定义，尚不是时间轨道、局部 ODE 解或能量守恒定理。
- 未完成的教材命题及任务文档候选不能冒充本目录已证明依赖。
- 本目录未将 pending 的负责人语义签核改为通过。

建议任务指令：从目标分支指定提交读取本目录及对应 `.lean` 文件；以完整类型选择依赖，报告读取的提交与模块。禁止使用 `mathcopilot-lean-test` 命中作为本工程依据。
