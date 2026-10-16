# EAUDIT54：第3章§3.3.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.3.3-YoshidaRaiseOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.3",
  "printed_page": "109",
  "pdf_page": "131",
  "statement_latex": "giving us a scheme of order $2s+2$. We can then proceed recursively, as this new order $2s+2$ scheme can be composed similarly to wipe out successive higher order terms.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原方法对称且阶2s≥2，真实三步复合及系数同页；保留负时间步。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshidaRaiseOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "给定光滑场、G在(h,z)全域C∞、开放D与紧B、实际双向局部流、反步对称和局部阶；实际改阶是结论。",
    "[EXTRA] 将孤立B上的逐紧集阶改为D内每个紧集的一致阶资格，覆盖移动中间点；结论补新方法在每紧集升阶、光滑及对称，保留递归资格。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:16:24.137455",
      "before_sha256": "47675002c18a300ad35fea10d7b0556e95be59cc2f46e75fb28a6729cb239e67",
      "after_sha256": "f206b1f4c18e40fd01fdfd475cfea3d7c75dd40c33edc7f6bc97337a6efeb2cc",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT43_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:38:09.309129",
      "before_sha256": "f206b1f4c18e40fd01fdfd475cfea3d7c75dd40c33edc7f6bc97337a6efeb2cc",
      "after_sha256": "5a4eefce3171f54beacf3d8f5f0b8d1795dfe15c268803e24b5dbc938aadec46",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT43/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem yoshidaRaiseOrder :
  ∀ (n s : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    1 ≤ s → ContDiff ℝ ∞ f → ContDiff ℝ ∞ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η →
    (∀ h z, G (-h) (G h z)=z) → (∀ K : Set (Q n), IsCompact K → K ⊆ D → localOrder G Φ K (2*s)) →
    localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ B (2*s+2) ∧
    (∀ K : Set (Q n), IsCompact K → K ⊆ D →
      localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ K (2*s+2)) ∧
    (∀ h z, yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 (-h)
      (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 h z)=z) ∧
    ContDiff ℝ ∞ (fun hz : ℝ × Q n ↦
      yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 hz.1 hz.2) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter03Review.actualFlow
```lean
def actualFlow {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (D : Set E) (Φ : ℝ → E → E) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ D, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter03Review.localOrder
```lean
def localOrder {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G Φ : ℝ → E → E) (B : Set E) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
    ‖G h z-Φ h z‖ ≤ C*|h|^(r+1)
```
### 实际依赖 MD.Ch03.yoshidaCoefficients
```lean
def yoshidaCoefficients (s : ℕ) : ℝ × ℝ := (1/(2-yoshidaRoot s),-yoshidaRoot s/(2-yoshidaRoot s))
```
### 实际依赖 MD.Ch03.yoshidaCompose
```lean
def yoshidaCompose {E : Type*} (G : ℝ → E → E) (a b h : ℝ) : E → E := G (a*h) ∘ G (b*h) ∘ G (a*h)
```
### 实际依赖 MolecularDynamics.Chapter03Review.yoshidaRoot
```lean
def yoshidaRoot (s : ℕ) : ℝ := Real.rpow 2 (1/((2*s+1 : ℕ):ℝ))
```

## 原文JSON
```json
{
  "source_id": "MD-3.3.3-Yoshida4",
  "kind": "definition",
  "label": "Example 3.1 / (3.8)",
  "section": "3.3.3",
  "printed_page": "109–110",
  "pdf_page": "131–132",
  "statement_latex": "Example 3.1 Consider using velocity Verlet as the base second-order method to build a Yoshida fourth-order method from. As the scheme is second-order, we have $s=1$, and hence\n\\[\\tau_0=\\frac1{2-\\sqrt[3]2},\\qquad\\tau_1=-\\frac{\\sqrt[3]2}{2-\\sqrt[3]2}.\\]\nThe overall scheme is then three iterations of velocity Verlet, using stepsizes $\\tau_0h$, $\\tau_1h$ and $\\tau_0h$ respectively. We write this with subindices $\\alpha,\\beta$ to indicate the intermediate stages.\nYoshida fourth-order scheme (velocity Verlet):\n\\[\\begin{aligned}P_\\alpha&:=p-(\\tau_0h/2)\\nabla U(q),&Q_\\alpha&:=q+(\\tau_0h)M^{-1}P_\\alpha,\\\\\nP_\\alpha&:=P_\\alpha-(\\tau_0h/2)\\nabla U(Q_\\alpha),&P_\\beta&:=P_\\alpha-(\\tau_1h/2)\\nabla U(Q_\\alpha),\\\\\nQ_\\beta&:=Q_\\alpha+(\\tau_1h)M^{-1}P_\\beta,&P_\\beta&:=P_\\beta-(\\tau_1h/2)\\nabla U(Q_\\beta),\\\\\nP&:=P_\\beta-(\\tau_0h/2)\\nabla U(Q_\\beta),&Q&:=Q_\\beta+(\\tau_0h)M^{-1}P,\\\\\nP&:=P-(\\tau_0h/2)\\nabla U(Q).\\end{aligned}\\tag{3.8}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "三次速度Verlet与每次kick-drift-kick九阶段完全相同；算法名fourth-order，实际阶结论仍在YoshidaRaiseOrder且未证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshida4",
  "reusable_proofs": [],
  "extra_assumptions": [
    "M为固定对角质量；不假设正反步骤的实际无限时域流存在。",
    "[EXTRA] 教材算法接口明确正质量与经典可微势；后续结构定理调用使用正式总化辅助组合，证明不新增。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:16:24.137455",
      "before_sha256": "55beea723a227836b40154780442a823ebf11b14628ecdfabe9be7fe9851bf00",
      "after_sha256": "c423f36a90bfabe2e7a4ca9d43669d71e2a1643cdcda9e7f8f3f22c0dc7b4f80",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def yoshida4 {n : ℕ} (m : Fin n → ℝ) (_hm : positiveMass m) (U : Q n → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) : SymplecticCoordinates n → SymplecticCoordinates n :=
  yoshidaCompose (coordinateVerlet m (textbookPotentialForce U)) (yoshidaCoefficients 1).1 (yoshidaCoefficients 1).2 h
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.coordinateVerlet
```lean
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)
```
### 实际依赖 MolecularDynamics.Chapter02Review.positiveMass
```lean
def positiveMass {n : ℕ} (m : Fin n → ℝ) : Prop := ∀ i, 0 < m i
```
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```
### 实际依赖 MolecularDynamics.textbookPositionDrift
```lean
noncomputable def textbookPositionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
```
### 实际依赖 MolecularDynamics.textbookPositionProjection
```lean
noncomputable def textbookPositionProjection (Nc : ℕ) :
    SymplecticCoordinates Nc →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i => ContinuousLinearMap.proj (Sum.inl i)
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MD.Ch03.yoshida4
```lean
def yoshida4 {n : ℕ} (m : Fin n → ℝ) (_hm : positiveMass m) (U : Q n → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) : SymplecticCoordinates n → SymplecticCoordinates n :=
  yoshidaCompose (coordinateVerlet m (textbookPotentialForce U)) (yoshidaCoefficients 1).1 (yoshidaCoefficients 1).2 h
```
### 实际依赖 MD.Ch03.yoshidaCoefficients
```lean
def yoshidaCoefficients (s : ℕ) : ℝ × ℝ := (1/(2-yoshidaRoot s),-yoshidaRoot s/(2-yoshidaRoot s))
```
### 实际依赖 MD.Ch03.yoshidaCompose
```lean
def yoshidaCompose {E : Type*} (G : ℝ → E → E) (a b h : ℝ) : E → E := G (a*h) ∘ G (b*h) ∘ G (a*h)
```
### 实际依赖 MolecularDynamics.Chapter03Review.yoshidaRoot
```lean
def yoshidaRoot (s : ℕ) : ℝ := Real.rpow 2 (1/((2*s+1 : ℕ):ℝ))
```

## 原文JSON
```json
{
  "source_id": "MD-3.3.3-Yoshida4Structure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.3",
  "printed_page": "110",
  "pdf_page": "132",
  "statement_latex": "Yoshida fourth-order scheme (velocity Verlet)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页九阶段(3.8)全文见Yoshida4；p.109/PDF131的对称三次辛复合；本条只列辛性和反步对称，不假冒已证4阶。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshida4Structure",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.yoshida4Structure_proved"
  ],
  "extra_assumptions": [
    "U全域C²；真实kick/drift及三次回文复合。",
    "[EXTRA] 依赖小修：原无质量限制的结构定理继续对应正式总化辅助算法；教材受限接口另有正质量/可微资格，原已证结论保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:16:24.137455",
      "before_sha256": "db0d17ae22327e6fd52fc350df6f16112a32724638f77d3ee45e990bec19211f",
      "after_sha256": "c58eec4171ba21c4c5bb4f037b77e907875a9cc8d0c95dad19c7f9218e3593e8",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem yoshida4Structure :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), ContDiff ℝ 2 U →
    (∀ h, IsTextbookSymplecticMap (MolecularDynamics.Chapter03Review.yoshida4 m U h)) ∧ (∀ h z, MolecularDynamics.Chapter03Review.yoshida4 m U (-h) (MolecularDynamics.Chapter03Review.yoshida4 m U h z)=z) := by
  exact MolecularDynamics.Chapter03Review.yoshida4Structure_proved
```
### 实际依赖 MolecularDynamics.IsTextbookSymplectic
```lean
def IsTextbookSymplectic {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) : Prop :=
  Aᵀ * textbookJ Nc * A = textbookJ Nc
```
### 实际依赖 MolecularDynamics.IsTextbookSymplecticMap
```lean
def IsTextbookSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```
### 实际依赖 MolecularDynamics.Chapter03Review.yoshida4
```lean
def yoshida4 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : SymplecticCoordinates n → SymplecticCoordinates n :=
  yoshidaCompose (coordinateVerlet m (textbookPotentialForce U)) (yoshidaCoefficients 1).1 (yoshidaCoefficients 1).2 h
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.coordinateVerlet
```lean
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)
```
### 实际依赖 MolecularDynamics.Chapter02Review.positiveMass
```lean
def positiveMass {n : ℕ} (m : Fin n → ℝ) : Prop := ∀ i, 0 < m i
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```
### 实际依赖 MolecularDynamics.textbookPositionDrift
```lean
noncomputable def textbookPositionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
```
### 实际依赖 MolecularDynamics.textbookPositionProjection
```lean
noncomputable def textbookPositionProjection (Nc : ℕ) :
    SymplecticCoordinates Nc →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i => ContinuousLinearMap.proj (Sum.inl i)
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MD.Ch03.yoshida4
```lean
def yoshida4 {n : ℕ} (m : Fin n → ℝ) (_hm : positiveMass m) (U : Q n → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) : SymplecticCoordinates n → SymplecticCoordinates n :=
  yoshidaCompose (coordinateVerlet m (textbookPotentialForce U)) (yoshidaCoefficients 1).1 (yoshidaCoefficients 1).2 h
```
### 实际依赖 MD.Ch03.yoshidaCoefficients
```lean
def yoshidaCoefficients (s : ℕ) : ℝ × ℝ := (1/(2-yoshidaRoot s),-yoshidaRoot s/(2-yoshidaRoot s))
```
### 实际依赖 MD.Ch03.yoshidaCompose
```lean
def yoshidaCompose {E : Type*} (G : ℝ → E → E) (a b h : ℝ) : E → E := G (a*h) ∘ G (b*h) ∘ G (a*h)
```
### 实际依赖 MolecularDynamics.Chapter03Review.yoshidaRoot
```lean
def yoshidaRoot (s : ℕ) : ℝ := Real.rpow 2 (1/((2*s+1 : ℕ):ℝ))
```
