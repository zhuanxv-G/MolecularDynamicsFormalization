# EAUDIT20：第1章§1.7网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.7-PlanarTrimerModel",
  "kind": "definition",
  "label": "Example 1.8 (Planar Lennard-Jones Trimer)",
  "section": "1.7",
  "printed_page": "38",
  "pdf_page": "61",
  "statement_latex": "One of the simplest illustrations of the chaotic nature of molecular systems is given by the Lennard-Jones model consisting of just three atoms with motion restricted to the plane. The energy is\n\\[E=K+U=\\frac{\\|\\dot{\\boldsymbol q}_1\\|^2}{2}+\\frac{\\|\\dot{\\boldsymbol q}_2\\|^2}{2}+\\frac{\\|\\dot{\\boldsymbol q}_3\\|^2}{2}+\\hat\\varphi_{\\mathrm{LJ}}(\\|\\boldsymbol q_1-\\boldsymbol q_2\\|)+\\hat\\varphi_{\\mathrm{LJ}}(\\|\\boldsymbol q_2-\\boldsymbol q_3\\|)+\\hat\\varphi_{\\mathrm{LJ}}(\\|\\boldsymbol q_1-\\boldsymbol q_3\\|),\\]\nwith the interatomic interaction given by $\\hat\\varphi_{\\mathrm{LJ}}(r)=4[r^{-12}-r^{-6}]$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "单位质量、平面R²、非碰撞物理域；inverse整数幂与(1/r)^k等价。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.planarTrimerEnergy",
  "extra_assumptions": [],
  "old_ids": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def planarTrimerEnergy (q v : Fin 3 → Position 2) : ℝ :=
  (∑ i, ‖v i‖^2/2) + lennardJonesPotential 1 1 ‖q 0-q 1‖ +
    lennardJonesPotential 1 1 ‖q 1-q 2‖ + lennardJonesPotential 1 1 ‖q 0-q 2‖
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```
### 实际依赖 MD.Ch01.planarTrimerEnergy
```lean
def planarTrimerEnergy (q v : Fin 3 → Position 2) : ℝ :=
  (∑ i, ‖v i‖^2/2) + lennardJonesPotential 1 1 ‖q 0-q 1‖ +
    lennardJonesPotential 1 1 ‖q 1-q 2‖ + lennardJonesPotential 1 1 ‖q 0-q 2‖
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-CentralPairPotential",
  "kind": "definition",
  "label": null,
  "section": "1.7",
  "printed_page": "38",
  "pdf_page": "61",
  "statement_latex": "In general, when the total potential is a sum of distance potentials\n\\[U=\\frac12\\sum_{i\\ne j}U_{ij},\\]\nwhere $U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j)=\\varphi_{ij}(\\|\\boldsymbol q_i-\\boldsymbol q_j\\|)$, we say that the system has central forces.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "φᵢⱼ=φⱼᵢ为同一无序对相互作用；qᵢ≠qⱼ和径向势可微用于后续导数，不是本定义存在条件。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.centralPairEnergy",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-174"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def centralPairEnergy {N : ℕ} (φ : Fin N → Fin N → ℝ → ℝ) (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.univ.erase i, φ i j (pairDistance (q i) (q j)))/2
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.centralPairEnergy
```lean
def centralPairEnergy {N : ℕ} (φ : Fin N → Fin N → ℝ → ℝ) (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.univ.erase i, φ i j (pairDistance (q i) (q j)))/2
```
### 实际依赖 MolecularDynamics.Chapter01Review.pairDistance
```lean
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-CentralPairGradient",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "38",
  "pdf_page": "61",
  "statement_latex": "In this case,\n\\[\\frac\\partial{\\partial\\boldsymbol q_i}U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j)=-\\frac\\partial{\\partial\\boldsymbol q_j}U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j),\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.centralpairgradient",
  "extra_assumptions": [
    "势在非碰撞距离可微；partial为欧氏梯度。"
  ],
  "old_ids": [
    "CH01-175"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem centralpairgradient :
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x => φ ‖x-r‖) q = -gradient (fun y => φ ‖q-y‖) r := by
  intro φ q r hqr hφ
  have hn : ‖q-r‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr hqr)
  have h₁ := (((hasFDerivAt_id q).sub_const r).norm_sq).sqrt (pow_ne_zero 2 hn)
  have h₂ := (((hasFDerivAt_const q r).sub (hasFDerivAt_id r)).norm_sq).sqrt (pow_ne_zero 2 hn)
  simp only [Real.sqrt_sq_eq_abs, abs_norm] at h₁ h₂
  have g₁ := hφ.hasDerivAt.comp_hasFDerivAt q h₁
  have g₂ := hφ.hasDerivAt.comp_hasFDerivAt r h₂
  apply ext_inner_right ℝ
  intro v
  simp only [Function.comp_def, id_eq, Pi.sub_apply] at g₁ g₂
  rw [inner_gradient_left, inner_neg_left, inner_gradient_left, g₁.fderiv, g₂.fderiv]
  simp [ContinuousLinearMap.comp_apply, innerSL_apply_apply, inner_neg_right]
  ring
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-CentralMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "and so, for central forces,\n\\[\\sum_{i=1}^N m_i\\ddot{\\boldsymbol q}_i=0,\\]\nwhich expresses the constancy of the momentum.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "∑mᵢq̈ᵢ=0为PairCancellation及IsMechanicalSolutionOn的组合；bridge结论对每坐标守恒即整个向量守恒。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.central_momentum",
  "extra_assumptions": [
    "真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。"
  ],
  "old_ids": [
    "CH01-176"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem central_momentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, (∑ i, ∑ j, F t i j) = 0) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i • v a i) = ∑ i, m i • v b i := by
  exact @momentum_conservation
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-CentralAngularMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "Moreover, viewing the $\\boldsymbol q_i$ as vectors in $\\mathbb R^3$ (with 0 as their third component),\n\\[\\boldsymbol q_i\\times\\frac\\partial{\\partial\\boldsymbol q_i}U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j)=-\\boldsymbol q_j\\times\\frac\\partial{\\partial\\boldsymbol q_j}U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j),\\]\nwhich implies\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\sum_{i=1}^N\\boldsymbol q_i\\times(m_i\\dot{\\boldsymbol q}_i)=0,\\]\nand tells us that the total angular momentum is also conserved.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "cross3为欧氏3D叉积；原文平面嵌入是特例，当前一般3D。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.centralangularmomentum",
  "extra_assumptions": [
    "真实位置和动量导数；反对称内力和沿位移方向中心力。",
    "[EXTRA] 19号：保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。"
  ],
  "old_ids": [
    "CH01-177"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem centralangularmomentum_derivative :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    ∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t := by
  intro N m q v F I _ hq hp hanti hcenter
  have hsub (u v w : V3) : cross3 (u-v) w = cross3 u w-cross3 v w := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have hneg (u w : V3) : cross3 u (-w) = -cross3 u w := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have ht (t : ℝ) (h : t ∈ I) (i j : Fin N) :
      cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i) := by
    have hc := hcenter t h i j
    rw [hsub] at hc
    rw [hanti t h j i,hneg,neg_neg]
    exact sub_eq_zero.mp hc
  have hcross (u w : ℝ → V3) (du dw : V3) (t : ℝ)
      (hu : HasDerivAt u du t) (hw : HasDerivAt w dw t) :
      HasDerivAt (fun s => cross3 (u s) (w s)) (cross3 du (w t)+cross3 (u t) dw) t := by
    have huc (k : Fin 3) : HasDerivAt (fun s => u s k) (du k) t :=
      (PiLp.proj (p := 2) (β := fun _ : Fin 3 => ℝ) k).hasFDerivAt.comp_hasDerivAt t hu
    have hwc (k : Fin 3) : HasDerivAt (fun s => w s k) (dw k) t :=
      (PiLp.proj (p := 2) (β := fun _ : Fin 3 => ℝ) k).hasFDerivAt.comp_hasDerivAt t hw
    have hc (k : Fin 3) : HasDerivAt (fun s => cross3 (u s) (w s) k)
        ((cross3 du (w t)+cross3 (u t) dw) k) t := by
      fin_cases k
      · convert! ((huc 1).mul (hwc 2)).sub ((huc 2).mul (hwc 1)) using 1 <;> simp [cross3] <;> ring
      · convert! ((huc 2).mul (hwc 0)).sub ((huc 0).mul (hwc 2)) using 1 <;> simp [cross3] <;> ring
      · convert! ((huc 0).mul (hwc 1)).sub ((huc 1).mul (hwc 0)) using 1 <;> simp [cross3] <;> ring
    let b : Fin 3 → V3 := fun k => WithLp.toLp 2 (Pi.single k 1)
    have hre (z : V3) : (∑ k, z k • b k) = z := by
      ext k; fin_cases k <;> simp [b,Fin.sum_univ_three]
    have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun k _ => (hc k).smul_const (b k))
    simpa only [hre] using hh
  have hself (a : ℝ) (u : V3) : cross3 u (a • u) = 0 := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have hsum (u : V3) (f : Fin N → V3) : cross3 u (∑ j,f j) = ∑ j,cross3 u (f j) := by
    ext k; fin_cases k <;> simp [cross3,Finset.mul_sum,Finset.sum_sub_distrib]
  refine ⟨ht,?_⟩
  intro t h
  have hz : (∑ i, ∑ j,cross3 (q t i) (F t i j)) = 0 := by
    apply paircancellation N (fun i j => cross3 (q t i) (F t i j))
    · intro i
      ext k
      have he := congrArg (fun u : V3 => u k) (ht t h i i)
      simp only [PiLp.neg_apply] at he
      change (cross3 (q t i) (F t i i)) k = 0
      linarith
    · exact ht t h
  have hd (i : Fin N) : HasDerivAt (fun s => cross3 (q s i) (m i • v s i))
      (∑ j,cross3 (q t i) (F t i j)) t := by
    simpa only [hself,zero_add,hsum] using hcross (fun s => q s i) (fun s => m i • v s i)
      (v t i) (∑ j,F t i j) t (hq t h i) (hp t h i)
  have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => hd i)
  rwa [hz] at hh

theorem centralangularmomentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, cross3 (q a i) (m i • v a i)) =
      ∑ i, cross3 (q b i) (m i • v b i) := by
  intro N m q v F I hI hc hq hp ha hf
  obtain ⟨ht,hd⟩ := centralangularmomentum_derivative N m q v F I hI hq hp ha hf
  refine ⟨ht,hd,?_⟩
  intro a ha b hb
  exact hI.is_const_of_deriv_eq_zero hc
    (fun t ht => (hd t ht).differentiableAt.differentiableWithinAt)
    (fun t ht => (hd t ht).deriv) ha hb
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MolecularDynamics.Chapter01Review.cross3
```lean
def cross3 (u v : V3) : V3 := WithLp.toLp 2
  ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-CenterOfMassMotion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "This means that the system will translate and rotate at a constant rate in time.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "本条仅translation；rotation字面部分分开保留下一条。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.centerofmassmotion",
  "extra_assumptions": [
    "质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。"
  ],
  "old_ids": [
    "CH01-178"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem centerofmassmotion :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (I : Set ℝ) (a : ℝ), IsOpen I → IsPreconnected I → a ∈ I →
    (∀ i, 0 < m i) → 0 < ∑ i, m i →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) →
    ∀ t ∈ I,
      (∑ i, m i)⁻¹ • (∑ i, m i • q t i) =
        (∑ i, m i)⁻¹ • (∑ i, m i • q a i) +
          (t-a) • ((∑ i, m i)⁻¹ • (∑ i, m i • v a i)) := by
  intro N m q v I a ho hi ha hm hM hq hp
  let P := ∑ i, m i • v a i
  have hPc (t : ℝ) (ht : t ∈ I) : (∑ i, m i • v t i) = P :=
    ho.is_const_of_deriv_eq_zero hi
      (fun s hs => (hp s hs).differentiableAt.differentiableWithinAt)
      (fun s hs => (hp s hs).deriv) ht ha
  have hQ (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => ∑ i, m i • q s i) P t := by
    have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => (hq t ht i).const_smul (m i))
    rwa [hPc t ht] at hh
  have hR (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => (∑ i, m i • q s i)-s • P) 0 t := by
    simpa only [one_smul, sub_self, id_eq] using (hQ t ht).fun_sub ((hasDerivAt_id t).smul_const P)
  intro t ht
  have hc := ho.is_const_of_deriv_eq_zero hi
    (fun s hs => (hR s hs).differentiableAt.differentiableWithinAt)
    (fun s hs => (hR s hs).deriv) ht ha
  have he : (∑ i, m i • q t i) = (∑ i, m i • q a i)+(t-a) • P := by
    calc
      _ = ((∑ i, m i • q a i)-a • P)+t • P := (sub_eq_iff_eq_add).mp hc
      _ = _ := by simp [sub_smul, sub_eq_add_neg, add_smul, neg_smul, add_assoc, add_comm, add_left_comm]
  have hh := congrArg (fun u => (∑ i,m i)⁻¹ • u) he
  simpa [P, smul_add, smul_smul, mul_comm] using hh
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-ConstantRotationLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "This means that the system will translate and rotate at a constant rate in time.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "角动量常数不推出角速度常数；中心运动r变时θ̇=ℓ/r²。例r(t)=sqrt(1+t²),θ(t)=arctan t,ℓ=1。"
    }
  ],
  "lean_decl": "MD.Ch01.constantrotationliteral",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-179"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem constantrotationliteral :
  ∀ (r θ : ℝ → ℝ) (ℓ : ℝ),
    (∀ t, 0 < r t ∧ (r t)^2*deriv θ t = ℓ) →
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  sorry

/-- 修正版，对应原文 MD-1.7-ConstantRotationLiteral，改动：a增加恒定正半径才推恒角速；默认b保留角动量守恒并明确θ′=ℓ/r²。 -/
theorem constantrotationliteral_corrected_a (R ℓ : ℝ) (θ : ℝ → ℝ)
    (hR : 0 < R) (h : ∀ t, R^2 * deriv θ t = ℓ) :
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  refine ⟨ℓ/R^2,fun t => ?_⟩
  apply (eq_div_iff (pow_ne_zero 2 hR.ne')).mpr
  simpa [mul_comm] using h t

/-- 修正版，对应原文 MD-1.7-ConstantRotationLiteral，改动：角速度随半径变化。 -/
theorem constantrotationliteral_corrected_b (r θ : ℝ → ℝ) (ℓ : ℝ)
    (h : ∀ t, 0 < r t ∧ (r t)^2 * deriv θ t = ℓ) :
    ∀ t, deriv θ t = ℓ/(r t)^2 := by
  intro t
  apply (eq_div_iff (pow_ne_zero 2 (h t).1.ne')).mpr
  simpa [mul_comm] using (h t).2
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-IsoscelesCoordinates",
  "kind": "definition",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "Let us introduce new coordinates in the Lennard-Jones trimer as illustrated in Fig. 1.21, so that the center of mass is fixed at the origin: that is,\n\\[\\boldsymbol q_1=\\begin{bmatrix}x\\\\-y/3\\\\0\\end{bmatrix},\\qquad\\boldsymbol q_2=\\begin{bmatrix}-x\\\\-y/3\\\\0\\end{bmatrix},\\qquad\\boldsymbol q_3=\\begin{bmatrix}0\\\\2y/3\\\\0\\end{bmatrix},\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "单位质量；质心固定及等腰约束是特定对称初值，非所有零角动量三体配置。"
  ],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "同段“零平动/角动量→等腰”一般过强；这里只定义明确给定的对称配置，不把任意零动量当等腰。"
    }
  ],
  "lean_decl": "MD.Ch01.isoscelesCoordinates",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-180"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

/-- 修正版，对应原文 MD-1.7-IsoscelesCoordinates，改动：把三坐标公式作为主动选取的对称子模型，证明其质心为零；不把零总动量/角动量推出等腰。 -/
def isoscelesCoordinates_corrected (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

theorem isoscelesCoordinates_corrected_center (x y : ℝ) :
    (∑ i : Fin 3, isoscelesCoordinates_corrected x y i) = 0 := by
  ext k
  fin_cases k <;> simp [isoscelesCoordinates_corrected,Fin.sum_univ_three] <;> ring
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.isoscelesCoordinates
```lean
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]
```
### 实际依赖 MD.Ch01.isoscelesCoordinates_corrected
```lean
def isoscelesCoordinates_corrected (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]
```
