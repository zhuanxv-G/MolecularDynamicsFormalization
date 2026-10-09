# T_audit_MD-1.5.1-FlowInverse

单目标：MD-1.5.1-FlowInverse。模板C，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.26 / PDF p.49；上下文页：PDF 48–49（印刷25–26）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。
- `Blueprint/Ch01.lean`，目标声明 `MD.Ch01.flow_inverse`（下面内嵌片段）。
- 以下相关定义文件（可以合并上传，必须点开检查，不能仅凭定义名推断）：
  - `MolecularDynamics/Notation.lean`
  - `MolecularDynamics/Chapter01/LocalTrajectories.lean`
  - `MolecularDynamics/Chapter01/GlobalFlow.lean`
  - `MolecularDynamics/Chapter01/LocalExistence.lean`
- `blueprint/ch01/dependency_inventory.json`：正式库传递导入文件和哈希；若不能读取依赖，明确标未验证。

正式库基线commit：`1b1cbae1bcb27177963a43018fb2c2ba7eb00cb6`。草稿以以下内容哈希锁定；网站不负责推送/改仓库。

```json
{
  "source_entry_sha256": "06763b993229b5b38845e23b63eb2ada6998e9c06565145ad521876f78a4a41a",
  "signature_sha256": "0612c669694cac25394cc94c88490c2844c0ae68af39ec6306d4ab0952450ee4",
  "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
  "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
}
```

本条当前JSON尚未approved，先完成模板A。若A有修复，Codex整合后用新任务版本重生成B/C；只读审计C必须使用approved JSON和当前哈希，不审旧稿。

## 任务正文

只读审计，不修改任何文件。审计条目：MD-1.5.1-FlowInverse 与对应 Lean 声明 MD.Ch01.flow_inverse。
证据优先级：PDF 原文 > approved JSON > 当前 Lean 声明。
逐条检查：
1. 对象与范围（维数、定义域、时间区间、局部/全局）；
2. 量词顺序与依赖（谁依赖谁）；
3. 假设与隐含前提：每个 Lean 假设是否原文有；[EXTRA] 是否合理必要；
4. 每个结论子句是否都在，唯一性等是否遗漏；
5. 层次是否混淆（逐点/几乎处处、存在/唯一等）；
6. 是否被平凡化、加强或减弱；所用项目定义（点开定义）是否与书中概念一致；
7. 尽量给出最小反例（例如 U(x)=x⁴、谐振子）说明问题。
每条输出：
{ "source_id": ..., "lean_decl": ...,
  "verdict": "PASS|TOO_WEAK|TOO_STRONG|MISSING_CLAUSE|EXTRA_ASSUMPTION|WRONG_OBJECT|WRONG_QUANTIFIER|WRONG_LEVEL|POSSIBLE_ERRATUM",
  "explanation": "...", "counterexample": "...或null", "suggested_fix": "...或null" }

注意：审计包含本条全部结论子句和[EXTRA]/[ERRATUM?]。缺上下文或无法检查Lean时明确记未验证；不得假报fresh Check。

## 返回件约定

用户保存到`blueprint/ch01/mathcopilot_results/T_audit_MD-1.5.1-FlowInverse.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_audit_MD-1.5.1-FlowInverse",
  "input_fingerprint": {
    "source_entry_sha256": "06763b993229b5b38845e23b63eb2ada6998e9c06565145ad521876f78a4a41a",
    "signature_sha256": "0612c669694cac25394cc94c88490c2844c0ae68af39ec6306d4ab0952450ee4",
    "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
    "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
  }
}
```

## 本条JSON输入

```json
{
  "source_id": "MD-1.5.1-FlowInverse",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "26",
  "pdf_page": "49",
  "statement_latex": "The classical systems treated here can be solved forward or backward in time. Observe that $\\mathcal{F}_{-t}\\mathcal{F}_t=\\operatorname{Id}$ (the identity map), thus the flow map is invertible and, indeed, the family of flow maps defined for different values of $t$ form an Abelian group under the operation of composition ($\\mathcal{F}_t\\mathcal{F}_s=\\mathcal{F}_s\\mathcal{F}_t=\\mathcal{F}_{t+s}$).",
  "proof_latex": null,
  "proof_note": "原文用Observe that直接断言；没有独立证明。随后Hamiltonian守恒属于另一个结论，不纳入本条。",
  "context_notation": [
    "式(1.5)：$\\dot{\\boldsymbol{z}}=\\boldsymbol{f}(\\boldsymbol{z})$，$\\boldsymbol{z}(0)=\\boldsymbol{\\xi}$；$m$维空间及flow map定义$\\mathcal{F}_t(\\boldsymbol{\\xi})=\\boldsymbol{z}(t)$：§1.5.1印刷p.26/PDF49。",
    "正文明确继承前小节存在唯一性前提；势能下界、固定正定质量、能量限制下位置紧性：§1.5印刷p.25–26/PDF48–49。",
    "IsGlobalMechanicalFlowOn只假设逐初值全实时间ODE解、ψ 0 z=z和状态域S不变；不把反演、群律或双射藏进假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch01.flow_inverse",
  "reusable_proofs": [
    "MolecularDynamics.globalMechanicalFlow_inverse",
    "MolecularDynamics.globalMechanicalFlow_add",
    "MolecularDynamics.globalMechanicalFlow_commute",
    "MolecularDynamics.globalMechanicalFlow_bijOn"
  ],
  "extra_assumptions": [
    "hψ: 显式全实时间解及S不变，落实正文双向可解和flow map前提；本条不证明全局流存在。",
    "hreg: F在Q为C¹，用于ODE唯一性，落实正文继承的存在唯一性前提。",
    "_hm: 正固定质量，使对象限于原文分子Hamiltonian系统。"
  ],
  "statement_scope": "完整反演/可逆/Abelian群律段；恒等元ψ0由flow定义，结论覆盖双向反演、双射和加法/交换律。",
  "review_status": "DRAFT",
  "repair_log": []
}
```

## 当前Blueprint片段

```lean
import MolecularDynamics.Chapter01.EuclideanStability
import MolecularDynamics.Chapter01.EnergyConservation
import MolecularDynamics.Chapter01.Lagrangian
import MolecularDynamics.Chapter01.LegendreTransform
import MolecularDynamics.Chapter01.GlobalFlow

/-!
Chapter 1 pilot: draft signatures for independent semantic review.
Existing formal-library sources and signatures are preserved.
The dimension n denotes N_c (3N for three-dimensional atomic coordinates).
The formal fixed diagonal model also supports the line case N_c = N.
No signature is frozen until the matching MathCopilot audit passes.
-/

open Set MolecularDynamics
open scoped ContDiff InnerProductSpace

namespace MD.Ch01

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

/-- Actual twice differentiable position curves satisfying M q̈ = -∇U.
The derivatives are genuine HasDerivAt witnesses, not total-derivative equations alone. -/
def IsNewtonTrajectoryOn {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (q : ℝ → Position n) : Prop :=
  (∀ t ∈ I, q t ∈ Q) ∧ ∀ t ∈ I,
    HasDerivAt q (deriv q t) t ∧
    HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
    massOperator m (deriv (deriv q) t) = -gradient U (q t)

/-- Matrix action for the configuration-dependent mass model on printed p.24. -/
noncomputable def matrixAction {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (v : Position n) : Position n := Matrix.toEuclideanLin A v

noncomputable def variableMassLagrangian {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : ℝ := inner ℝ v (matrixAction (M q) v) / 2 - U q

noncomputable def variableMassHamiltonian {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : ℝ := inner ℝ p (matrixAction (M q)⁻¹ p) / 2 + U q


/-- source_id: MD-1.5.1-FlowInverse · unnumbered claim · printed p.26 / PDF p.49
Original: Two-sided flow maps are inverse and form an Abelian composition group.
[EXTRA] hψ: actual all-real-time solutions, identity initial value and S-invariance;
these make the textbook's two-sided flow assumption explicit, not the group laws.
[EXTRA] hreg: C1 force for uniqueness, inherited from the preceding IVP discussion.
[EXTRA] _hm: positive fixed masses qualify the molecular Hamiltonian model.
The force is specifically -gradient U, as in the source Hamiltonian setting.
Quantification is on the invariant state domain S; no claim of global existence
for arbitrary forces or initial points outside S. Both inverses, bijectivity,
identity, addition and commutation clauses are included. -/
theorem flow_inverse {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (S : Set (PhaseSpace n))
    (ψ : ℝ → PhaseSpace n → PhaseSpace n)
    (_hm : ∀ i, 0 < m i)
    (hψ : IsGlobalMechanicalFlowOn m (fun q => -gradient U q) Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∀ z ∈ S, ψ 0 z = z) ∧
    (∀ t : ℝ, ∀ z ∈ S, ψ (-t) (ψ t z) = z ∧ ψ t (ψ (-t) z) = z) ∧
    (∀ t : ℝ, BijOn (ψ t) S S) ∧
    ∀ s t : ℝ, ∀ z ∈ S,
      ψ t (ψ s z) = ψ s (ψ t z) ∧ ψ t (ψ s z) = ψ (t + s) z := by
  refine ⟨fun z hz => (hψ.1 z hz).2, ?_, ?_, ?_⟩
  · intro t z hz
    exact ⟨globalMechanicalFlow_inverse hψ hreg hz t,
      by simpa only [neg_neg] using globalMechanicalFlow_inverse hψ hreg hz (-t)⟩
  · intro t
    exact globalMechanicalFlow_bijOn hψ hreg t
  · intro s t z hz
    exact ⟨globalMechanicalFlow_commute hψ hreg hz s t,
      (globalMechanicalFlow_add hψ hreg hz s t).symm⟩
end MD.Ch01
```
