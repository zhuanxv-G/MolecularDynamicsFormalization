# EAUDIT29：第5章§5.2.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.2.3-HamiltonianSkewExpression",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.3",
  "printed_page": "186",
  "pdf_page": "207",
  "statement_latex": "From the above we know that for a smooth scalar function $u=u(z)$, $\\mathcal L_f^\\daggeru=-\\nabla\\cdot(uf)=-f\\cdot\\nabla u-u\\nabla\\cdot f$. The term $\\nabla\\cdot f$ vanishes for $f=J\\nabla H$. Thus we have $\\mathcal L_f^\\daggeru=-f\\cdot\\nabla u=-\\mathcal L_fu$. If this holds for all smooth $u$, we write $\\mathcal L_f^\\dagger=-\\mathcal L_f$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.hamiltonianSkewExpression",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:56:45.362027",
      "before_sha256": "0bfa6a60ca51404b73d1cc331420c350d58b14475683b32b4024a7e366fcb947",
      "after_sha256": "0436e3160e5ea19aaa49dd82753faae592b472e50a24332b0502897fe258977b",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonianSkewExpression :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ),
  Differentiable ℝ f → Differentiable ℝ u → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  ∀ z,MolecularDynamics.Chapter05Review.liouvillian f u z= -MolecularDynamics.Chapter05Review.lie f u z := by
  intro n f u hf hu hdiv z
  rw [liouvilleProduct n f u z (hf z) (hu z),hdiv z]
  ring
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
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MolecularDynamics.Chapter05Review.liouvillian
```lean
def liouvillian {n : ℕ} (f : E n → E n) (u : E n → ℝ) (z : E n) :=
  -divergence (fun x => u x • f x) z
```
### 实际依赖 MD.Ch05.divergence
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
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

## 原文JSON
```json
{
  "source_id": "MD-5.2.3-HamiltonianDensityPropagation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.3",
  "printed_page": "187",
  "pdf_page": "208",
  "statement_latex": "An important consequence of the skew symmetry of $\\mathcal L_f$ for a divergence-free system is that the propagator $e^{t\\mathcal L_f^\\dagger}$ preserves the integral over the whole phase space, i.e.\n\\[\\int_D e^{t\\mathcal L_f^\\dagger}\\rho(z)d\\omega=\\int_D e^{-t\\mathcal L_f}\\rho(z)d\\omega=\\int_D\\rho(\\mathcal F_{-t}(z))d\\omega=\\int_D\\rho(z)d\\omega,\\]\nsince we can view $\\mathcal F_{-t}(z)$ as a change of variables by a volume-preserving map.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.hamiltonianDensityPropagation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:56:45.362027",
      "before_sha256": "6dabf21009f2d7efa0b77b229ce4a53d6e0e7cd9172193abbbe45347051447cb",
      "after_sha256": "b6103327bde5940a1bd8ccc5f904adeded4a165ba3040f391d8e123fdc8c1ac3",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonianDensityPropagation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  (∀ t,Φ t '' D=D) → densityOn D ρ → ∀ t,
    (∫ z in D,ρ (Φ (-t) z))=(∫ z in D,ρ z) ∧
    densityMeasureOn D (fun z => ρ (Φ (-t) z))=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D ρ) := by
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
### 实际依赖 MD.Ch05.measurePropagator
```lean
def measurePropagator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) := Measure.map (Φ t) μ
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.3-MechanicalLiouvillian",
  "kind": "definition",
  "label": null,
  "section": "5.2.3",
  "printed_page": "187",
  "pdf_page": "208",
  "statement_latex": "The Liouvillian of a Hamiltonian system with $N_c$ degrees of freedom and a Hamiltonian of the form $H=\\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\\ldots,q_{N_c})$ can be written\n\\[\\mathcal L_H^\\dagger=-\\sum_{i=1}^{N_c}m_i^{-1}p_i\\frac{\\partial}{\\partial q_i}-\\sum_{i=1}^{N_c}F_i\\frac{\\partial}{\\partial p_i},\\]\nwhere $F_i=-\\partial U/\\partial q_i$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$q_i,p_i$ 为位置、动量坐标，$m_i$ 为质量；$U=U(q_1,\\ldots,q_{N_c})$，$F_i=-\\partial U/\\partial q_i$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.mechanicalLiouvillian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:56:45.362027",
      "before_sha256": "0f077433c70fef345d5940592e84f367a1256361b6ed4f7f8f01c5e4debb91bb",
      "after_sha256": "0c0ededbb1abb491b7988def395cb42fa026deb64debc638e8f55addcd11850b",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (u : MolecularDynamics.Chapter05Review.Phase n → ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.Phase
```lean
abbrev Phase (n : ℕ) := E n × E n
```
### 实际依赖 MolecularDynamics.Chapter05Review.Phase
```lean
abbrev Phase (n : ℕ) := E n × E n
```
### 实际依赖 MD.Ch05.mechanicalLiouvillian
```lean
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (u : MolecularDynamics.Chapter05Review.Phase n → ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.3-MechanicalLiouvillianIdentity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.3",
  "printed_page": "187",
  "pdf_page": "208",
  "statement_latex": "The Liouvillian of a Hamiltonian system with $N_c$ degrees of freedom and a Hamiltonian of the form $H=\\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\\ldots,q_{N_c})$ can be written\n\\[\\mathcal L_H^\\dagger=-\\sum_{i=1}^{N_c}m_i^{-1}p_i\\frac{\\partial}{\\partial q_i}-\\sum_{i=1}^{N_c}F_i\\frac{\\partial}{\\partial p_i},\\]\nwhere $F_i=-\\partial U/\\partial q_i$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.mechanicalLiouvillianIdentity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:56:45.362027",
      "before_sha256": "c4b4563c0427b0eb349b42730466fb8b8910840bf937e808c0bf335e50ed63ad",
      "after_sha256": "cb73f67f03c5398f0da25e8556902428333ee56c0403b31c77bca45821ab882e",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem mechanicalLiouvillianIdentity : ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ i,0 < m i) → ContDiff ℝ 2 U →
  ∀ (u : MolecularDynamics.Chapter05Review.Phase n → ℝ),Differentiable ℝ u → ∀ z,
    -(fderiv ℝ u z) (MolecularDynamics.Chapter05Review.hamiltonianField
      (fun x => (∑ i,(x.2 i)^2/(2*m i))+U x.1) z)=
    MolecularDynamics.Chapter05Review.mechanicalLiouvillian m (fun q => -gradient U q) u z := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.Phase
```lean
abbrev Phase (n : ℕ) := E n × E n
```
### 实际依赖 MolecularDynamics.Chapter05Review.hamiltonianField
```lean
def hamiltonianField {n : ℕ} (H : Phase n → ℝ) (z : Phase n) : Phase n :=
  (gradient (fun p => H (z.1,p)) z.2,-gradient (fun q => H (q,z.2)) z.1)
```
### 实际依赖 MolecularDynamics.Chapter05Review.mechanicalLiouvillian
```lean
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : E n → E n)
    (u : Phase n → ℝ) (z : Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
```
### 实际依赖 MolecularDynamics.Chapter05Review.Phase
```lean
abbrev Phase (n : ℕ) := E n × E n
```
### 实际依赖 MolecularDynamics.Chapter05Review.hamiltonianField
```lean
def hamiltonianField {n : ℕ} (H : Phase n → ℝ) (z : Phase n) : Phase n :=
  (gradient (fun p => H (z.1,p)) z.2,-gradient (fun q => H (q,z.2)) z.1)
```
### 实际依赖 MD.Ch05.mechanicalLiouvillian
```lean
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (u : MolecularDynamics.Chapter05Review.Phase n → ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
```
