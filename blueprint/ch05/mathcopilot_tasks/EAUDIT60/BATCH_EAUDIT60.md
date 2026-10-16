# EAUDIT60：第5章§5.6网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.6-BackwardEnergyDecay",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "both eigenvalues of the matrix lie in the interior of the unit disk, and hence all solutions of the recurrence relation tend to the origin with increasing $n$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.backwardEnergyDecay",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实有限步平方范数代数恒等式另列；全轨道趋原点及测度弱极限另保留。",
    "[EXTRA] 保留能量衰减已有证明，补两个完整复特征值及模严格小于1；迭代趋零由BackwardEulerLimit，实际模型由EulerLogCorrespondence/BackwardWeakStationary承担。"
  ],
  "statement_scope": "能量衰减与复谱/模；全部离散迭代趋零由MD-5.6-BackwardEulerLimit，连续模型对应和稳态由MD-5.6-EulerLogCorrespondence/BackwardWeakStationary承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:38.392728",
      "before_sha256": "d82835f1b14461879b5bd50884e1d2e7477081755c75bfcf14941b038324800c",
      "after_sha256": "a38e75c04d3e3bb44d1875d69e027a8fb788ffbe2f9f5536014c3a63301345c6",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem backwardEnergyDecay : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 1)^2=
    (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
  intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.backwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.backwardEuler h x 1)^2=(1+h^2)⁻¹*((x 0)^2+(x 1)^2) := by
    have hd : 1+h^2 ≠ 0 := ne_of_gt (by positivity)
    simp [MolecularDynamics.Chapter05Review.backwardEuler]
    field_simp
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring

theorem backwardEnergyDecay_spectrum (h : ℝ) (_hh : h ≠ 0) :
    let A : Matrix (Fin 2) (Fin 2) ℂ := !![1,(h : ℂ);-(h : ℂ),1]
    let B := ((1+h^2 : ℝ)⁻¹ : ℂ) • A
    (∀ ζ : ℂ,(∃ v : Fin 2 → ℂ,v ≠ 0 ∧ B *ᵥ v=ζ • v) ↔
      ζ=(1+Complex.I*h)/(1+h^2) ∨ ζ=(1-Complex.I*h)/(1+h^2)) ∧
    ‖((1 : ℂ)+Complex.I*h)/(1+h^2)‖=1/Real.sqrt (1+h^2) ∧
    ‖((1 : ℂ)-Complex.I*h)/(1+h^2)‖=1/Real.sqrt (1+h^2) ∧
    1/Real.sqrt (1+h^2) < 1 := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.backwardEuler
```lean
def backwardEuler (h : ℝ) (z : E 2) : E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```
### 实际依赖 MD.Ch05.backwardEuler
```lean
def backwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-BackwardEulerLimit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "all solutions of the recurrence relation tend to the origin with increasing $n$ (the origin is an attractive equilibrium point). In this case, all densities evolve toward the Dirac distribution centered at the origin: $\\delta[q]\\delta[p]$. The only (distributional) solution of $\\mathcal L_{\\widetilde f}\\rho=0$ is again $\\delta[q]\\delta[p]$, which in this case is attractive.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.backwardEulerLimit",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]h≠0及实际任意初始概率测度；全轨道收缩与对每个有界连续测试函数的弱趋Dirac两个结论，非普通密度逐点收敛。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。"
  ],
  "statement_scope": "仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:38.392728",
      "before_sha256": "8e353e10cfab2df0bfc678304ee8e28b2a786a53f5d9a2d0a241aed35e73407e",
      "after_sha256": "27401cd7fa4c7f1aaebcbf5178373b8542db1e43d7f4027e84184c51008ff06f",
      "changed_fields": [
        "statement_latex",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem backwardEulerLimit :
  ∀ h : ℝ,h ≠ 0 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0)) ∧
  ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun k : ℕ => ∫ z,φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) ∂μ) atTop (𝓝 (φ 0)) := by
  intro h hh
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have hc : Continuous (MolecularDynamics.Chapter05Review.backwardEuler h) := by
    unfold MolecularDynamics.Chapter05Review.backwardEuler
    fun_prop
  have hz (z : MolecularDynamics.Chapter05Review.E 2) :
      Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0) := by
    apply tendsto_zero_iff_norm_tendsto_zero.mpr
    have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z‖^2=
        (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using backwardEnergyDecay h z k
    have hs : Tendsto (fun k : ℕ => (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2)) atTop (𝓝 0) := by
      simpa only [zero_mul] using (tendsto_pow_atTop_nhds_zero_of_lt_one
        (inv_nonneg.mpr (by positivity : 0 ≤ 1+h^2)) ((inv_lt_one₀ (by positivity)).mpr hp)).mul_const ((z 0)^2+(z 1)^2)
    convert (Real.continuous_sqrt.tendsto 0).comp hs using 1
    · funext k
      simp only [Function.comp_apply]
      rw [←he,Real.sqrt_sq (norm_nonneg _)]
    · simp
  refine ⟨hz,?_⟩
  intro μ hμ φ hφ hb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hd := tendsto_integral_filter_of_dominated_convergence
    (μ:=μ) (fun _ : MolecularDynamics.Chapter05Review.E 2 => C)
    (F:=fun k z => φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z))
    (f:=fun _ => φ 0)
    (Eventually.of_forall (fun k => (hφ.comp (hc.iterate k)).measurable.aestronglyMeasurable))
    (Eventually.of_forall (fun k => ae_of_all μ (fun z => hB (φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z)) (mem_range_self _))))
    (integrable_const C) (ae_of_all μ (fun z => (hφ.tendsto 0).comp (hz z)))
  simpa using hd
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.backwardEuler
```lean
def backwardEuler (h : ℝ) (z : E 2) : E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```
### 实际依赖 MD.Ch05.backwardEuler
```lean
def backwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-SymplecticEulerShadow",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "the solution through any given initial point remains confined to an ellipse for all $n$ defined by $\\widetilde H_h(q,p)=\\widetilde H_h(q_0,p_0)$, where $\\widetilde H_h$ is the perturbed Hamiltonian defined by the backward error analysis.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.symplecticEulerShadow",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]完整实际二次修正能量的一步保持恒等式；正定椭圆资格及所有n保持另条，不以一步式称全部椭圆结论已证。",
    "[EXTRA] 保留一步不变量证明，补稳定区内主对数Hamiltonian=c(h)·二次不变量、c>0、实际矩阵指数Hamiltonian流及其时间h恰为离散步，并给两能量有界域O(h²)比例差；全部k/椭圆由SymplecticEulerEllipse、弱稳态由SymplecticWeakStationary承担。新增模型是显式技术选择，不冒称唯一修正能量。"
  ],
  "statement_scope": "一步二次不变量与实际主对数modified Hamiltonian/流对应及比例阶次；全部k和椭圆/零退化由MD-5.6-SymplecticEulerEllipse、连续概率稳态/非吸引由MD-5.6-SymplecticWeakStationary承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:38.392728",
      "before_sha256": "6fd2893ea91e9289c5b1297d5dd7a8ec07b9428173d7fcbebdc2d36e345fdf1f",
      "after_sha256": "78f7723c9116fb0ff76aa67e6bb6f46afdb0200735de584e6a34be96c86f30df",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticEulerShadow : symplecticEulerShadow_statement := by
  apply MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved <;> assumption

def symplecticEulerLogScale (h : ℝ) : ℝ :=
  if h=0 then 1 else (2*Real.arcsin (h/2))/(h*Real.sqrt (1-h^2/4))

def symplecticEulerModifiedHamiltonian (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : ℝ :=
  symplecticEulerLogScale h*MolecularDynamics.Chapter05Review.shadowOscillator h z

def symplecticEulerModifiedFlow (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :
    MolecularDynamics.Chapter05Review.E 2 :=
  let A : Matrix (Fin 2) (Fin 2) ℝ := symplecticEulerLogScale h • !![-h/2,1;-1,h/2]
  WithLp.toLp 2 (NormedSpace.exp (t • A) *ᵥ WithLp.ofLp z)

theorem symplecticEulerShadow_modified_model (h : ℝ) (_hh : |h| < 2) :
    0 < symplecticEulerLogScale h ∧
    (∀ z,symplecticEulerModifiedFlow h h z=MolecularDynamics.Chapter05Review.symplecticEuler h z) ∧
    MolecularDynamics.Chapter05Review.flow
      (fun z : MolecularDynamics.Chapter05Review.E 2 ↦ WithLp.toLp 2
        ![(gradient (symplecticEulerModifiedHamiltonian h) z) 1,
          -(gradient (symplecticEulerModifiedHamiltonian h) z) 0])
      (symplecticEulerModifiedFlow h) := by
  sorry

theorem symplecticEulerShadow_modified_scale_order (R : ℝ) (_hR : 0 < R) :
    ∃ C > 0,∃ δ > 0,δ < 2 ∧ ∀ h : ℝ,|h| < δ →
      ∀ z : MolecularDynamics.Chapter05Review.E 2,‖z‖ ≤ R →
        |symplecticEulerModifiedHamiltonian h z-MolecularDynamics.Chapter05Review.shadowOscillator h z| ≤ C*h^2 := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.shadowOscillator
```lean
def shadowOscillator (h : ℝ) (z : E 2) := (z 0^2+z 1^2-h*z 0*z 1)/2
```
### 实际依赖 MolecularDynamics.Chapter05Review.symplecticEuler
```lean
def symplecticEuler (h : ℝ) (z : E 2) : E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.shadowOscillator
```lean
def shadowOscillator (h : ℝ) (z : E 2) := (z 0^2+z 1^2-h*z 0*z 1)/2
```
### 实际依赖 MD.Ch05.symplecticEuler
```lean
def symplecticEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
```
### 实际依赖 MD.Ch05.symplecticEulerLogScale
```lean
def symplecticEulerLogScale (h : ℝ) : ℝ :=
  if h=0 then 1 else (2*Real.arcsin (h/2))/(h*Real.sqrt (1-h^2/4))
```
### 实际依赖 MD.Ch05.symplecticEulerModifiedFlow
```lean
def symplecticEulerModifiedFlow (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :
    MolecularDynamics.Chapter05Review.E 2 :=
  let A : Matrix (Fin 2) (Fin 2) ℝ := symplecticEulerLogScale h • !![-h/2,1;-1,h/2]
  WithLp.toLp 2 (NormedSpace.exp (t • A) *ᵥ WithLp.ofLp z)
```
### 实际依赖 MD.Ch05.symplecticEulerModifiedHamiltonian
```lean
def symplecticEulerModifiedHamiltonian (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : ℝ :=
  symplecticEulerLogScale h*MolecularDynamics.Chapter05Review.shadowOscillator h z
```
### 实际依赖 MolecularDynamics.Chapter05Review.symplecticEulerShadow_statement
```lean
def symplecticEulerShadow_statement : Prop := ∀ h (z : E 2),
  shadowOscillator h (symplecticEuler h z)=shadowOscillator h z
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-SymplecticEulerEllipse",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "the solution through any given initial point remains confined to an ellipse for all $n$ defined by $\\widetilde H_h(q,p)=\\widetilde H_h(q_0,p_0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.symplecticEulerEllipse",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]稳定条件|h|<2；原不加资格的椭圆说法在|h|≥2失败。本条保留正定/紧性和所有迭代保持；0能量是退化点。",
    "[EXTRA] 保留正定/全部k保持证明，并补正能级椭圆拓扑及零能级单点退化；二次不变量作为modified Hamiltonian的显式固定选择，实际场/流资格见SymplecticWeakStationary，不声称唯一修正能量。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:38.392728",
      "before_sha256": "956ab57d80f5e1a2f9c03fcdc9cdccbd99aa04b237af3dcbaf8167f4a19f428e",
      "after_sha256": "9aeefdeb13868e416857eb3495374d6d252a9182cf94a41b91eaf6bb0bf8eeb0",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticEulerEllipse : ∀ h : ℝ,|h| < 2 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 → 0 < MolecularDynamics.Chapter05Review.shadowOscillator h z) ∧
  (∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c}) ∧
  (∀ z : MolecularDynamics.Chapter05Review.E 2,∀ k : ℕ,MolecularDynamics.Chapter05Review.shadowOscillator h ((MolecularDynamics.Chapter05Review.symplecticEuler h)^[k] z)=
    MolecularDynamics.Chapter05Review.shadowOscillator h z) := by
  intro h hh
  let d := 2-|h|
  have hd : 0 < d := by dsimp [d];linarith
  have lower (z : MolecularDynamics.Chapter05Review.E 2) :
      d*((z 0)^2+(z 1)^2) ≤ 4*MolecularDynamics.Chapter05Review.shadowOscillator h z := by
    unfold MolecularDynamics.Chapter05Review.shadowOscillator
    dsimp [d]
    by_cases hp : 0 ≤ h
    · rw [abs_of_nonneg hp]
      nlinarith [mul_nonneg hp (sq_nonneg (z 0-z 1))]
    · rw [abs_of_neg (lt_of_not_ge hp)]
      nlinarith [mul_nonneg (neg_nonneg.mpr (le_of_lt (lt_of_not_ge hp))) (sq_nonneg (z 0+z 1))]
  have normeq (z : MolecularDynamics.Chapter05Review.E 2) : ‖z‖^2=(z 0)^2+(z 1)^2 := by
    rw [EuclideanSpace.norm_sq_eq]
    simp [Fin.sum_univ_two,Real.norm_eq_abs]
  refine ⟨?_,?_,?_⟩
  · intro z hz
    have hnorm : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    have hl := lower z
    rw [←normeq] at hl
    nlinarith [mul_pos hd hnorm]
  · intro c
    have hc : Continuous (MolecularDynamics.Chapter05Review.shadowOscillator h) := by
      unfold MolecularDynamics.Chapter05Review.shadowOscillator;fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|/d+1)).of_isClosed_subset hclosed
    intro z hz
    have hl := lower z
    rw [←normeq] at hl
    change MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c at hz
    have hle : ‖z‖^2 ≤ 4*|c|/d := (le_div_iff₀ hd).mpr (by nlinarith [le_abs_self c])
    have hB : 0 ≤ 4*|c|/d := by positivity
    rw [Metric.mem_closedBall,dist_zero_right]
    nlinarith [norm_nonneg z]
  · intro z k
    induction k with
    | zero => simp
    | succ k ih =>
      rw [Function.iterate_succ_apply',MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved,ih]

theorem symplecticEulerEllipse_geometry (h : ℝ) (_hh : |h| < 2) :
    {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z=0}={0} ∧
    (∀ c : ℝ,0 < c → Nonempty
      (↥{z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z=c} ≃ₜ
        ↥(Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.shadowOscillator
```lean
def shadowOscillator (h : ℝ) (z : E 2) := (z 0^2+z 1^2-h*z 0*z 1)/2
```
### 实际依赖 MolecularDynamics.Chapter05Review.symplecticEuler
```lean
def symplecticEuler (h : ℝ) (z : E 2) : E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
```
### 实际依赖 MolecularDynamics.Chapter05Review.shadowOscillator
```lean
def shadowOscillator (h : ℝ) (z : E 2) := (z 0^2+z 1^2-h*z 0*z 1)/2
```
### 实际依赖 MD.Ch05.symplecticEuler
```lean
def symplecticEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-SymplecticEulerDensity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "This implies that a density which is a function of $\\widetilde H_h$ will remain invariant under the associated Liouville equation. There are many solutions of $\\mathcal L_{\\widetilde f}^{\\dagger}\\rho=0$, none of which is attractive.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.symplecticEulerDensity",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]真实离散映射MeasurePreserving、不变二次能量、实际概率密度r∘Htilde；完整弱Liouville稳态及非吸引另条，所有r都可归一不能自动推出。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。"
  ],
  "statement_scope": "仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:38.392728",
      "before_sha256": "8cbd5817e04d2dd6452179cd6e9dbefd8d439510b7d30ad710684c6504cc8037",
      "after_sha256": "e3b78d09e8cbafac9bcd6e913fe7550297878a01aaf0da308f2e454206c831e0",
      "changed_fields": [
        "statement_latex",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticEulerDensity :
  ∀ h : ℝ, |h| < 2 → ∀ r : ℝ → ℝ,
  MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h) →
    MeasurePreserving (MolecularDynamics.Chapter05Review.symplecticEuler h) (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h))
      (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h)) := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.probabilityDensity
```lean
def probabilityDensity {n : ℕ} (ρ : E n → ℝ) : Prop := density ρ ∧ (∫ z, ρ z)=1
```
### 实际依赖 MolecularDynamics.Chapter05Review.shadowOscillator
```lean
def shadowOscillator (h : ℝ) (z : E 2) := (z 0^2+z 1^2-h*z 0*z 1)/2
```
### 实际依赖 MolecularDynamics.Chapter05Review.symplecticEuler
```lean
def symplecticEuler (h : ℝ) (z : E 2) : E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
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
### 实际依赖 MolecularDynamics.Chapter05Review.probabilityDensity
```lean
def probabilityDensity {n : ℕ} (ρ : E n → ℝ) : Prop := density ρ ∧ (∫ z, ρ z)=1
```
### 实际依赖 MolecularDynamics.Chapter05Review.shadowOscillator
```lean
def shadowOscillator (h : ℝ) (z : E 2) := (z 0^2+z 1^2-h*z 0*z 1)/2
```
### 实际依赖 MD.Ch05.symplecticEuler
```lean
def symplecticEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-Theorem51",
  "kind": "theorem",
  "label": "Theorem 5.1",
  "section": "5.6",
  "printed_page": "208–209",
  "pdf_page": "229–230",
  "statement_latex": "Theorem 5.1 Let $H(q,p)$ and $\\widetilde H(q,p)=H(q,p)+\\varepsilon\\eta(q,p)$ be two Hamiltonian functions. Suppose the energy surface $\\Sigma_E=\\{(q,p)\\mid H(q,p)=E\\}$ to be compact and define the perturbed energy surface by $\\widetilde\\Sigma_E=\\{(q,p)\\mid\\widetilde H(q,p)=E\\}$, also assumed compact.\nSuppose that $w$ is an arbitrary smooth vector field such that $w\\cdot\\nabla H\\ne0$ on $\\Sigma_E$. Then the perturbation of the microcanonical average of a smooth function $g$ is given by\n\\[\\operatorname{Av}_{H=E}(g)-\\operatorname{Av}_{\\widetilde H=E}(g)=\\operatorname{Av}_{\\widetilde H=E}(\\nabla\\cdot gu)-\\operatorname{Av}_{\\widetilde H=E}(g)\\operatorname{Av}_{\\widetilde H=E}(\\nabla\\cdot u)+O(\\varepsilon^2),\\]\nwhere $u=\\varepsilon\\eta w/(w\\cdot\\nabla H)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.theorem51",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际C∞和regularEnergy含梯度非零及raw总质量有限正；补统一紧能量带与其上分母不为零，量化完整O(ε²)平均差。不只陈述分母下界，不将校正关系作前提。",
    "[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:38.392728",
      "before_sha256": "277af45f514a4a6e3acebf6929ed2d10a606512befe1c234616938a19e40cf11",
      "after_sha256": "6c8f52b1b8c1481e6c69d1718539f6d8c76543d51c3cadfe75b3c7b7b521d55c",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH26_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem theorem51 :
  ∀ n (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c,
    0 < n → ContDiff ℝ ∞ H → ContDiff ℝ ∞ η → ContDiff ℝ ∞ g → ContDiff ℝ ∞ w →
    MolecularDynamics.Chapter05Review.regularEnergy H c → (∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) →
    (∃ δ > 0, ∃ K : Set (MolecularDynamics.Chapter05Review.E n), IsCompact K ∧
      ∀ ε ∈ Ioo (-δ) δ, MolecularDynamics.Chapter05Review.regularEnergy (fun z => H z+ε*η z) c ∧
        MolecularDynamics.Chapter05Review.energySurface (fun z => H z+ε*η z) c ⊆ K ∧
        (∀ z ∈ K,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0)) →
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |MolecularDynamics.Chapter05Review.microAverage H c g-MolecularDynamics.Chapter05Review.microAverage (fun z => H z+ε*η z) c g-
        MolecularDynamics.Chapter05Review.perturbationCorrection H η g w c ε| ≤ C*ε^2 := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.divergence
```lean
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MolecularDynamics.Chapter05Review.energySurface
```lean
def energySurface {n : ℕ} (H : E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.microAverage
```lean
def microAverage {n : ℕ} (H : E n → ℝ) (c : ℝ) (g : E n → ℝ) := average (microMeasure H c) g
```
### 实际依赖 MolecularDynamics.Chapter05Review.microMeasure
```lean
def microMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  ((microRaw H c) univ)⁻¹ • microRaw H c
```
### 实际依赖 MolecularDynamics.Chapter05Review.microRaw
```lean
def microRaw {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖grad H z‖⁻¹))
```
### 实际依赖 MolecularDynamics.Chapter05Review.perturbationCorrection
```lean
def perturbationCorrection {n : ℕ} (H η g : E n → ℝ) (w : E n → E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := perturbationDisplacement H η w ε
  microAverage Hε c (divergence (fun z => g z • u z))-
    microAverage Hε c g*microAverage Hε c (divergence u)
```
### 实际依赖 MolecularDynamics.Chapter05Review.perturbationDisplacement
```lean
def perturbationDisplacement {n : ℕ} (H η : E n → ℝ) (w : E n → E n) (ε : ℝ) (z : E n) :=
  (ε*η z/inner ℝ (w z) (grad H z)) • w z
```
### 实际依赖 MolecularDynamics.Chapter05Review.regularEnergy
```lean
def regularEnergy {n : ℕ} (H : E n → ℝ) (c : ℝ) : Prop :=
  (energySurface H c).Nonempty ∧ IsCompact (energySurface H c) ∧
  (∀ z ∈ energySurface H c, grad H z ≠ 0) ∧
  0 < (microRaw H c) univ ∧ (microRaw H c) univ < ∞
```
### 实际依赖 MolecularDynamics.Chapter05Review.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (hausdorffArea (n-1)).restrict (energySurface H c)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.divergence
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MD.Ch05.energySurface
```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.microAverage
```lean
def microAverage {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) := MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.microMeasure H c) g
```
### 实际依赖 MD.Ch05.microMeasure
```lean
def microMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c
```
### 实际依赖 MD.Ch05.microRaw
```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```
### 实际依赖 MD.Ch05.perturbationCorrection
```lean
def perturbationCorrection {n : ℕ} (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := MolecularDynamics.Chapter05Review.perturbationDisplacement H η w ε
  MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence (fun z => g z • u z))-
    MolecularDynamics.Chapter05Review.microAverage Hε c g*MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence u)
```
### 实际依赖 MD.Ch05.perturbationDisplacement
```lean
def perturbationDisplacement {n : ℕ} (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  (ε*η z/inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)) • w z
```
### 实际依赖 MolecularDynamics.Chapter05Review.regularEnergy
```lean
def regularEnergy {n : ℕ} (H : E n → ℝ) (c : ℝ) : Prop :=
  (energySurface H c).Nonempty ∧ IsCompact (energySurface H c) ∧
  (∀ z ∈ energySurface H c, grad H z ≠ 0) ∧
  0 < (microRaw H c) univ ∧ (microRaw H c) univ < ∞
```
### 实际依赖 MD.Ch05.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-PerturbationCorrection",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "209",
  "pdf_page": "230",
  "statement_latex": "$\\operatorname{Av}_{H=E}(g)-\\operatorname{Av}_{\\widetilde H=E}(g)=\\operatorname{Av}_{\\widetilde H=E}(\\nabla\\cdot gu)-\\operatorname{Av}_{\\widetilde H=E}(g)\\operatorname{Av}_{\\widetilde H=E}(\\nabla\\cdot u)+O(\\varepsilon^2)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际div(g u)，保留g·div u项；不是仅grad g·u。定义校正函数不等于完整Theorem5.1已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.perturbationCorrection",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。"
  ],
  "statement_scope": "仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:38.392728",
      "before_sha256": "df023626f377af2d0b9d359b2c9981779601adc40f2565c973005405746ba919",
      "after_sha256": "807f3253c15aa93af7f0f8452421f424b9f2de8d590586c164b9d5e17c3ef9d0",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH26_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def perturbationCorrection {n : ℕ} (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := MolecularDynamics.Chapter05Review.perturbationDisplacement H η w ε
  MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence (fun z => g z • u z))-
    MolecularDynamics.Chapter05Review.microAverage Hε c g*MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence u)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.divergence
```lean
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MolecularDynamics.Chapter05Review.energySurface
```lean
def energySurface {n : ℕ} (H : E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.microAverage
```lean
def microAverage {n : ℕ} (H : E n → ℝ) (c : ℝ) (g : E n → ℝ) := average (microMeasure H c) g
```
### 实际依赖 MolecularDynamics.Chapter05Review.microMeasure
```lean
def microMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  ((microRaw H c) univ)⁻¹ • microRaw H c
```
### 实际依赖 MolecularDynamics.Chapter05Review.microRaw
```lean
def microRaw {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖grad H z‖⁻¹))
```
### 实际依赖 MolecularDynamics.Chapter05Review.perturbationDisplacement
```lean
def perturbationDisplacement {n : ℕ} (H η : E n → ℝ) (w : E n → E n) (ε : ℝ) (z : E n) :=
  (ε*η z/inner ℝ (w z) (grad H z)) • w z
```
### 实际依赖 MolecularDynamics.Chapter05Review.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (hausdorffArea (n-1)).restrict (energySurface H c)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.divergence
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MD.Ch05.energySurface
```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.microAverage
```lean
def microAverage {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) := MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.microMeasure H c) g
```
### 实际依赖 MD.Ch05.microMeasure
```lean
def microMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c
```
### 实际依赖 MD.Ch05.microRaw
```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```
### 实际依赖 MD.Ch05.perturbationCorrection
```lean
def perturbationCorrection {n : ℕ} (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := MolecularDynamics.Chapter05Review.perturbationDisplacement H η w ε
  MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence (fun z => g z • u z))-
    MolecularDynamics.Chapter05Review.microAverage Hε c g*MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence u)
```
### 实际依赖 MD.Ch05.perturbationDisplacement
```lean
def perturbationDisplacement {n : ℕ} (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  (ε*η z/inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)) • w z
```
### 实际依赖 MD.Ch05.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-DenominatorBound",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "209",
  "pdf_page": "230",
  "statement_latex": "Suppose that $w$ is an arbitrary smooth vector field such that $w\\cdot\\nabla H\\ne0$ on $\\Sigma_E$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.denominatorBound",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.denominatorBound_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]单独保留紧集上实际连续绝对分母的正下界，是完整定理的基础后果，不替代完整校正关系。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。"
  ],
  "statement_scope": "仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT22_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:19:08.743239",
      "before_sha256": "7ffc1e6719befd426708f98fb039c9ec3b79302030151150f995d22bf353ec2e",
      "after_sha256": "94e8e47ad9768e3ada9ccbbc499b08480e2054ee35605865089de3cc0a5ba694",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH26_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT22/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem denominatorBound {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c
    (hK : IsCompact (MolecularDynamics.Chapter05Review.energySurface H c))
    (hc : ContinuousOn (fun z => |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)|) (MolecularDynamics.Chapter05Review.energySurface H c))
    (hn : ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,a ≤ |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)| := by
  apply MolecularDynamics.Chapter05Review.denominatorBound_proved <;> assumption
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.energySurface
```lean
def energySurface {n : ℕ} (H : E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch05.energySurface
```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
