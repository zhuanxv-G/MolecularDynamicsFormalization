# EAUDIT46：第5章§5.2.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.2.2-LieCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "$\\mathcal L_fv=\\sum_i f_i\\frac{\\partial v}{\\partial z_i}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "z∈ℝ^m，f_i为向量场f的第i个坐标，v为可微标量函数，求和遍历所有m个坐标；本页通过截断内积公式使用Lie导数的坐标表达，并无独立同形展示公式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.lieCoordinates",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Euclidean规范基、Fréchet导数线性和坐标投影，明确原文全部有限求和；恒等式不要求另造形式梯度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:52:37.087651",
      "before_sha256": "12f74bcd27fad6f0bbf1c0bd6ce060a6c12bcd844f67349d453c87372d7ad307",
      "after_sha256": "a6046891c82ad41f83df7f46993e7778145a33369bd582276687c3d76ccf50bd",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem lieCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  MolecularDynamics.Chapter05Review.lie f g z=∑ i,f z i*(fderiv ℝ g z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  intro n f g z
  unfold MolecularDynamics.Chapter05Review.lie
  have h := congrArg (fderiv ℝ g z) ((EuclideanSpace.basisFun (Fin n) ℝ).toBasis.sum_repr (f z)).symm
  simpa only [map_sum,map_smul,smul_eq_mul,OrthonormalBasis.coe_toBasis_repr_apply,EuclideanSpace.basisFun_repr,OrthonormalBasis.coe_toBasis] using h
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.2-DivergenceCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "$\\frac{\\partial\\rho}{\\partial t}=-\\sum_i\\left(\\rho\\frac{\\partial f_i}{\\partial z_i}+f_i\\frac{\\partial\\rho}{\\partial z_i}\\right)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "ρ(z;t)是随向量场f输运的光滑概率密度；z∈ℝ^m，求和遍历所有坐标，偏导对时间或相应空间坐标取。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.divergenceCoordinates",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际可微向量场的导数迹等于所有坐标对角偏导之和；和LiouvilleProduct共同保留原完整展开，不将任意矩阵命名为Jacobian。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。"
  ],
  "statement_scope": "仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:52:37.087651",
      "before_sha256": "b0765ee5a62a4af400f7bf434621a02611b4cdb51a25d1ee7b32e53502994cde",
      "after_sha256": "bd1b8471a5493647972e81ecb22b402972c467cf70c7c380ef3c34f43d818b67",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem divergenceCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) z,
  DifferentiableAt ℝ f z → MolecularDynamics.Chapter05Review.divergence f z=
    ∑ i,(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  intro n f z hf
  unfold MolecularDynamics.Chapter05Review.divergence
  rw [LinearMap.trace_eq_matrix_trace ℝ (EuclideanSpace.basisFun (Fin n) ℝ).toBasis]
  simp only [Matrix.trace,Matrix.diag,LinearMap.toMatrix_apply,OrthonormalBasis.coe_toBasis_repr_apply,EuclideanSpace.basisFun_repr,OrthonormalBasis.coe_toBasis]
  apply Finset.sum_congr rfl
  intro i hi
  have hc := (PiLp.proj 2 (fun _ : Fin n => ℝ) i).hasFDerivAt.comp z hf.hasFDerivAt
  change HasFDerivAt (fun x => f x i) _ z at hc
  rw [hc.fderiv]
  rfl
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.divergence
```lean
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MD.Ch05.divergence
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.2-LiouvilleProductCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "An alternative form for the continuity equation is:\n\\[\\frac{\\partial\\rho}{\\partial t}=-\\sum_i\\left(\\rho\\frac{\\partial f_i}{\\partial z_i}+f_i\\frac{\\partial\\rho}{\\partial z_i}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "ρ(z;t)是随向量场f输运的光滑概率密度；f_i为f的坐标分量，求和遍历所有空间坐标。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.liouvilleProductCoordinates",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际点可微性；保存原整个有限求和右侧，连续性PDE左侧的时间导数由LiouvilleEquation完整条目保留。",
    "[EXTRA] 保留原坐标乘积法则证明，并以真实自治流、光滑密度和Measure.map输运条件补全部时间导数PDE；不把PDE作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:52:37.087651",
      "before_sha256": "7b3f75ef0830fb0e8c433ee907bb97a48b5ad768dec9b4f467505add38269c2d",
      "after_sha256": "fb1da6db885b36f93ef38df66fe8104e54da177b0d31ed5a25564e05dfe86da2",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem liouvilleProductCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  MolecularDynamics.Chapter05Review.liouvillian f ρ z=-(∑ i : Fin n,(ρ z*(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+
    f z i*(fderiv ℝ ρ z) (EuclideanSpace.basisFun (Fin n) ℝ i))) := by
  intro n f ρ z hf hρ
  rw [liouvilleProduct n f ρ z hf hρ,divergenceCoordinates n f z hf,lieCoordinates n f ρ z]
  rw [Finset.sum_add_distrib,← Finset.mul_sum]
  ring

theorem liouvilleProductCoordinates_evolution : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (-(∑ i : Fin n,(ρ t z*(fderiv ℝ (fun x ↦ f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+f z i*(fderiv ℝ (ρ t) z) (EuclideanSpace.basisFun (Fin n) ℝ i)))) t := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.divergence
```lean
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.liouvillian
```lean
def liouvillian {n : ℕ} (f : E n → E n) (u : E n → ℝ) (z : E n) :=
  -divergence (fun x => u x • f x) z
```
### 实际依赖 MolecularDynamics.Chapter05Review.measurePropagator
```lean
def measurePropagator {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ
```
### 实际依赖 MD.Ch05.densityMeasureOn
```lean
def densityMeasureOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (volume.restrict D).withDensity (fun z => ENNReal.ofReal (ρ z))
```
### 实际依赖 MD.Ch05.densityOn
```lean
def densityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  NullMeasurableSet D volume ∧ AEMeasurable ρ (volume.restrict D) ∧
    (∀ z ∈ D,0 ≤ ρ z) ∧ IntegrableOn ρ D
```
### 实际依赖 MD.Ch05.divergence
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MD.Ch05.liouvillian
```lean
def liouvillian {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  -MolecularDynamics.Chapter05Review.divergence (fun x => u x • f x) z
```
### 实际依赖 MD.Ch05.measurePropagator
```lean
def measurePropagator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) := Measure.map (Φ t) μ
```
### 实际依赖 MD.Ch05.probabilityDensityOn
```lean
def probabilityDensityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  densityOn D ρ ∧ (∫ z in D,ρ z)=1
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.2-FaceFlux",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "$\\frac{d\\nu}{dt}=-\\int_{\\partial A}f\\cdot n\\,\\rho(z;t)\\,d\\sigma$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "ν(t)=∫_Aρ(z;t)dω；ρ为随f输运的光滑概率密度；n(z)为∂A上的单位外法向，dσ为表面积元。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.faceFlux",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]矩形单个面上ρfi的真实Hausdorff面积积分；正负法向由上下两个面的组合体现。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。"
  ],
  "statement_scope": "仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:52:37.087651",
      "before_sha256": "9b99e73b42a0316a394b871f75be8cea7b46b7d861a25da8a885e9c0692a77ea",
      "after_sha256": "1f7000bbeabe5ec6f010e00b47eb0bfba78282e82b0ac4f256022d6bfd6dcdea",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.boxFace
```lean
def boxFace {n : ℕ} (a b : E n) (i : Fin n) (side : ℝ) := {z : E n | z ∈ rectangle a b ∧ z i=side}
```
### 实际依赖 MD.Ch05.faceFlux
```lean
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.rectangle
```lean
def rectangle {n : ℕ} (a b : E n) := {z : E n | ∀ i,a i ≤ z i ∧ z i ≤ b i}
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.2-BoxFluxBalance",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "Using the divergence theorem, we may rewrite the latter quantity as a volume integral:\n\\[\\frac{d\\nu}{dt}=-\\int_A\\nabla\\cdot(f(z)\\rho(z;t))\\,d\\omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "ν(t)=∫_Aρ(z;t)dω；ρ为随f输运的光滑概率密度；A为适合散度定理的区域，矩形为原文例子，dω为体积元。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.fluxBalance",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:52:37.087651",
      "before_sha256": "973aa38e2cb970ef4586012eaacd22f6d6057247a7978261e039eaf81ea5a649",
      "after_sha256": "e30caa25dc759969b545c4156a5b4dc58e755ba2d4b8c8b934453c81e1f7ca45",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem fluxBalance :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n),
  0 < n → (∀ i,a i < b i) → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 (Function.uncurry ρ) →
  (∀ t,MolecularDynamics.Chapter05Review.probabilityDensity (ρ t)) →
  (∀ t,MolecularDynamics.Chapter05Review.densityMeasure (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (ρ 0))) →
  ∀ t, HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ (rectangle a b))
    (∑ i,(faceFlux f (ρ t) a b i (a i)-faceFlux f (ρ t) a b i (b i))) t ∧
    (∫ z in rectangle a b,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∑ i,(faceFlux f (ρ t) a b i (b i)-faceFlux f (ρ t) a b i (a i)) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.densityMeasure
```lean
def densityMeasure {n : ℕ} (ρ : E n → ℝ) : Measure (E n) := volume.withDensity (fun z => ENNReal.ofReal (ρ z))
```
### 实际依赖 MolecularDynamics.Chapter05Review.divergence
```lean
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.massFraction
```lean
def massFraction {n : ℕ} (ρ : ℝ → E n → ℝ) (A : Set (E n)) (t : ℝ) := ∫ z in A,ρ t z
```
### 实际依赖 MolecularDynamics.Chapter05Review.measurePropagator
```lean
def measurePropagator {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.probabilityDensity
```lean
def probabilityDensity {n : ℕ} (ρ : E n → ℝ) : Prop := density ρ ∧ (∫ z, ρ z)=1
```
### 实际依赖 MolecularDynamics.Chapter05Review.boxFace
```lean
def boxFace {n : ℕ} (a b : E n) (i : Fin n) (side : ℝ) := {z : E n | z ∈ rectangle a b ∧ z i=side}
```
### 实际依赖 MolecularDynamics.Chapter05Review.density
```lean
def density {n : ℕ} (ρ : E n → ℝ) : Prop :=
  Measurable ρ ∧ (∀ z, 0 ≤ ρ z) ∧ Integrable ρ volume
```
### 实际依赖 MolecularDynamics.Chapter05Review.densityMeasure
```lean
def densityMeasure {n : ℕ} (ρ : E n → ℝ) : Measure (E n) := volume.withDensity (fun z => ENNReal.ofReal (ρ z))
```
### 实际依赖 MD.Ch05.divergence
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MD.Ch05.faceFlux
```lean
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.massFraction
```lean
def massFraction {n : ℕ} (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) := ∫ z in A,ρ t z
```
### 实际依赖 MD.Ch05.measurePropagator
```lean
def measurePropagator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) := Measure.map (Φ t) μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.probabilityDensity
```lean
def probabilityDensity {n : ℕ} (ρ : E n → ℝ) : Prop := density ρ ∧ (∫ z, ρ z)=1
```
### 实际依赖 MolecularDynamics.Chapter05Review.rectangle
```lean
def rectangle {n : ℕ} (a b : E n) := {z : E n | ∀ i,a i ≤ z i ∧ z i ≤ b i}
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.2-BoundaryTerm",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "where the term $B=\\sum_i\\int_{\\partial A_\\ell}uf_iv\\nu_i\\,d\\sigma$, is a surface integral over the boundary of $A_\\ell$, where $\\nu_i$ is the $i$’th component of the unit outward normal to the surface $\\partial A_\\ell$ bounding the region $A_\\ell$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A_ℓ为以原点为中心、边长2ℓ的m维盒，ℓ>0；u,v为标量函数，f_i为向量场坐标，ν_i是∂A_ℓ单位外法向的第i分量，dσ为表面积元。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.boxBoundaryTerm",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:52:37.087651",
      "before_sha256": "46f9be25cc67f9ab223a84ef6463a47c6431174b200afe5348b7fd4b3c052cc4",
      "after_sha256": "2f7034605c4e2e25398d1c12f945b7339fd95372998ca55581d91fe443694ed8",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def boxBoundaryTerm {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) (ell : ℝ) : ℝ :=
  let a : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => -ell)
  let b : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,(MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i ell-
    MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i (-ell))
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.faceFlux
```lean
def faceFlux {n : ℕ} (f : E n → E n) (ρ : E n → ℝ) (a b : E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(hausdorffArea (n-1))
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.boxBoundaryTerm
```lean
def boxBoundaryTerm {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) (ell : ℝ) : ℝ :=
  let a : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => -ell)
  let b : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,(MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i ell-
    MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i (-ell))
```
### 实际依赖 MolecularDynamics.Chapter05Review.boxFace
```lean
def boxFace {n : ℕ} (a b : E n) (i : Fin n) (side : ℝ) := {z : E n | z ∈ rectangle a b ∧ z i=side}
```
### 实际依赖 MD.Ch05.faceFlux
```lean
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.rectangle
```lean
def rectangle {n : ℕ} (a b : E n) := {z : E n | ∀ i,a i ≤ z i ∧ z i ≤ b i}
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.2-TruncatedIntegrationByParts",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "We truncate the domain to a large box $A_\\ell$ with edge of length $2\\ell$ centered at the origin, approximating the inner product by:\n\\[\\langle u,\\mathcal L_fv\\rangle\\approx\\int_{A_\\ell}u\\mathcal L_fv\\,d\\omega=\\int_{A_\\ell}u\\sum_i f_i\\frac{\\partial v}{\\partial z_i}\\,d\\omega.\\]\nSplitting this sum up, we treat each term by integration by parts\n\\[\\int_{A_\\ell}u\\sum_i f_i\\frac{\\partial v}{\\partial z_i}\\,d\\omega=\\sum_i\\int_{A_\\ell}uf_i\\frac{\\partial v}{\\partial z_i}\\,d\\omega\\tag{5.4}\\]\n\\[=B-\\sum_i\\int_{A_\\ell}v\\frac{\\partial}{\\partial z_i}(uf_i)\\,d\\omega.\\tag{5.5}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "u,v为ℝ^m上标量函数，原文上一句假定其在无穷远充分迅速趋零；A_ℓ=[-ℓ,ℓ]^m，ℓ>0；B=∑i∫_{∂A_ℓ}u f_i v ν_i dσ，ν为单位外法向；dω为体积元。≈为截断近似，不是精确恒等式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.truncatedIntegrationByParts",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:52:37.087651",
      "before_sha256": "0bb47583d065c80fdd6073fc285ec186da4188a1b59c62af60b764b94afb5de8",
      "after_sha256": "efc4fc58a700da3ddfb5d7ed740d1c16aa7b0549c66a05848714e06b66b0014d",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem truncatedIntegrationByParts : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) ell,
  0 < n → 0 < ell → ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v →
  let A := MolecularDynamics.Chapter05Review.rectangle (WithLp.toLp 2 (fun _ => -ell)) (WithLp.toLp 2 (fun _ => ell))
  (∫ z in A,u z*MolecularDynamics.Chapter05Review.lie f v z)=boxBoundaryTerm f u v ell+
    (∫ z in A,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.divergence
```lean
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MolecularDynamics.Chapter05Review.faceFlux
```lean
def faceFlux {n : ℕ} (f : E n → E n) (ρ : E n → ℝ) (a b : E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(hausdorffArea (n-1))
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MolecularDynamics.Chapter05Review.liouvillian
```lean
def liouvillian {n : ℕ} (f : E n → E n) (u : E n → ℝ) (z : E n) :=
  -divergence (fun x => u x • f x) z
```
### 实际依赖 MolecularDynamics.Chapter05Review.rectangle
```lean
def rectangle {n : ℕ} (a b : E n) := {z : E n | ∀ i,a i ≤ z i ∧ z i ≤ b i}
```
### 实际依赖 MD.Ch05.boxBoundaryTerm
```lean
def boxBoundaryTerm {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) (ell : ℝ) : ℝ :=
  let a : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => -ell)
  let b : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,(MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i ell-
    MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i (-ell))
```
### 实际依赖 MolecularDynamics.Chapter05Review.boxFace
```lean
def boxFace {n : ℕ} (a b : E n) (i : Fin n) (side : ℝ) := {z : E n | z ∈ rectangle a b ∧ z i=side}
```
### 实际依赖 MD.Ch05.divergence
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MD.Ch05.faceFlux
```lean
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.liouvillian
```lean
def liouvillian {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  -MolecularDynamics.Chapter05Review.divergence (fun x => u x • f x) z
```
### 实际依赖 MolecularDynamics.Chapter05Review.rectangle
```lean
def rectangle {n : ℕ} (a b : E n) := {z : E n | ∀ i,a i ≤ z i ∧ z i ≤ b i}
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.2-RapidAdjoint",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185–186",
  "pdf_page": "206–207",
  "statement_latex": "Let $u,v$ be two scalar valued functions in $\\mathbb R^m$ which tend to zero sufficiently rapidly at infinity. By our assumptions that $u$ and $v$ are rapidly decaying we know that $B\\to0$, as $\\ell\\to\\infty$. Taking the limit, we are thus left with the equation\n\\[\\langle u,\\mathcal L_fv\\rangle=-\\sum_i\\int_{\\mathbb R^m}v\\frac{\\partial}{\\partial z_i}(uf_i)\\,d\\omega=\\langle M_fu,v\\rangle.\\]\nWe refer to $M_f$ as the adjoint operator of $\\mathcal L_f$ and we write $M_f=\\mathcal L_f^\\dagger$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal M_f w=-\\nabla\\cdot(wf)$；原页将此算子记为$\\mathcal L_f^\\dagger$。",
    "$\\mathcal L_fv=\\sum_i f_i\\partial v/\\partial z_i$；$\\langle u,v\\rangle=\\int_{\\mathbb R^m}uv\\,d\\omega$，$d\\omega$为Lebesgue体积。",
    "$\\mathcal A_\\ell=[-\\ell,\\ell]^m$；$B=\\sum_i\\int_{\\partial\\mathcal A_\\ell}uf_i v\\nu_i\\,d\\sigma$，$\\nu$为外单位法向。",
    "原书由u,v迅速衰减推出B→0，未在该段明确f的增长约束；此处保留原句，不能视为对任意f已成立的无条件断言。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.rapidAdjoint",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:52:37.087651",
      "before_sha256": "bc6c9af90ba333593807cf428f5720ac0f423f551b3b1a99433f56a025576dad",
      "after_sha256": "480e487ca24db647c327f8dcdf9652cb0666774ba78dd67c6cc0ddb9da868bf7",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem rapidAdjoint : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*MolecularDynamics.Chapter05Review.lie f v z) volume →
  Integrable (fun z => MolecularDynamics.Chapter05Review.liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.divergence
```lean
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MolecularDynamics.Chapter05Review.faceFlux
```lean
def faceFlux {n : ℕ} (f : E n → E n) (ρ : E n → ℝ) (a b : E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(hausdorffArea (n-1))
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MolecularDynamics.Chapter05Review.liouvillian
```lean
def liouvillian {n : ℕ} (f : E n → E n) (u : E n → ℝ) (z : E n) :=
  -divergence (fun x => u x • f x) z
```
### 实际依赖 MolecularDynamics.Chapter05Review.schwartzSpace
```lean
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
```
### 实际依赖 MD.Ch05.boxBoundaryTerm
```lean
def boxBoundaryTerm {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) (ell : ℝ) : ℝ :=
  let a : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => -ell)
  let b : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,(MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i ell-
    MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i (-ell))
```
### 实际依赖 MolecularDynamics.Chapter05Review.boxFace
```lean
def boxFace {n : ℕ} (a b : E n) (i : Fin n) (side : ℝ) := {z : E n | z ∈ rectangle a b ∧ z i=side}
```
### 实际依赖 MD.Ch05.divergence
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MD.Ch05.faceFlux
```lean
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.liouvillian
```lean
def liouvillian {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  -MolecularDynamics.Chapter05Review.divergence (fun x => u x • f x) z
```
### 实际依赖 MolecularDynamics.Chapter05Review.rectangle
```lean
def rectangle {n : ℕ} (a b : E n) := {z : E n | ∀ i,a i ≤ z i ∧ z i ≤ b i}
```
### 实际依赖 MolecularDynamics.Chapter05Review.schwartzSpace
```lean
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
```
