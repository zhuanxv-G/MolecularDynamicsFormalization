# EAUDIT06：第1章§1.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.2-RadialLJForceLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "21",
  "pdf_page": "44",
  "statement_latex": "The equations of motion are, for $i=1,2,\\ldots,N$, using the chain rule,\n\\[m\\ddot{\\boldsymbol q}_i=\\sum_{j=1,\\ j\\ne i}^{N}\\frac{\\varphi'_{\\mathrm{LJ}}(r_{ij})}{r_{ij}}(\\boldsymbol q_i-\\boldsymbol q_j)\n=-24\\frac\\epsilon\\sigma\\sum_{j=1,\\ j\\ne i}^{N}r_{ij}^{-1}\\left[2\\left(\\frac\\sigma{r_{ij}}\\right)^{13}-\\left(\\frac\\sigma{r_{ij}}\\right)^7\\right](\\boldsymbol q_i-\\boldsymbol q_j).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "首个等式缺负号；所印次行实际为势的正梯度，不同于此前Newton负梯度。"
    }
  ],
  "lean_decl": "MD.Ch01.radial_lj_force_literal",
  "extra_assumptions": [
    "正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。"
  ],
  "old_ids": [
    "CH01-069"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem radial_lj_force_literal {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (-24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j)) := by
  sorry

/-- 修正版，对应原文 MD-1.2-RadialLJForceLiteral，改动：第一式补负梯度负号，第二式外系数由−24ε/σ改为+24ε/σ；其余对象和量词不变。 -/
theorem radial_lj_force_literal_corrected {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (-deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j)) := by
  have hphi (r : ℝ) (hr : r ≠ 0) :
      deriv (Chapter01Review.lennardJonesPotential ε σ) r =
        (24*ε/r)*((σ/r)^6-2*(σ/r)^12) := by
    have hx := (hasDerivAt_const r σ).div (hasDerivAt_id r) hr
    have hd := ((hx.pow 12).sub (hx.pow 6)).const_mul (4*ε)
    convert hd.deriv using 1
    · rfl
    · simp only [Pi.div_apply, Pi.pow_apply, id_eq, Nat.cast_ofNat]
      norm_num only [Nat.reduceSub]
      field_simp [hr] <;> ring
  constructor
  · exact hnewton
  · rw [hnewton]
    unfold ljForce
    rw [Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro j hj
    have hij : i ≠ j := (Finset.mem_erase.mp hj).1.symm
    have hr : ‖q i-q j‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr (hnc j hij))
    change (-deriv (Chapter01Review.lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) = _
    rw [hphi _ hr,smul_smul]
    congr 1
    field_simp [hr,hσ.ne'] <;> ring
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```
### 实际依赖 MolecularDynamics.Chapter01Review.ljForce
```lean
def ljForce {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) (i : Fin N) : V3 :=
  ∑ j ∈ Finset.univ.erase i,
    (-deriv (lennardJonesPotential ε σ) (pairDistance (q i) (q j)) /
      pairDistance (q i) (q j)) • (q i-q j)
```
### 实际依赖 MolecularDynamics.Chapter01Review.pairDistance
```lean
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
```

## 原文JSON
```json
{
  "source_id": "MD-1.2-LJTimeScaling",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "21–22",
  "pdf_page": "44–45",
  "statement_latex": "Thus we see that if we make the additional time transformation\n\\[\\tau=\\alpha t,\\qquad\\alpha^2=\\frac\\epsilon{m\\sigma^2},\\]\nthen the equations become\n\\[\\frac{\\mathrm d^2\\boldsymbol Q_i}{\\mathrm d\\tau^2}=-\\sum_{j=1,\\ j\\ne i}^{N}\\frac{\\hat\\varphi'_{\\mathrm{LJ}}(R_{ij})}{R_{ij}}(\\boldsymbol Q_i-\\boldsymbol Q_j).\\]\nThis means that a natural choice for the unit of time is\n\\[\\alpha^{-1}=\\sigma\\sqrt{\\frac m\\epsilon}\\approx2.17\\times10^{-12}\\mathrm s.\\]\nBy using the units given here, we may work with a simplified form of the Lennard-Jones system involving unit masses and a parameter-independent potential energy function.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$R_{ij}=\\|\\boldsymbol Q_i-\\boldsymbol Q_j\\|$；$\\hat\\varphi_{LJ}(R)=4[R^{-12}-R^{-6}]$。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.ljtimescaling",
  "extra_assumptions": [
    "m,ε,σ,α正；真实C2非碰撞轨迹。",
    "[EXTRA] 19号：补原书氩m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m的2.17ps近似，显式容差0.005ps；保留原双向缩放和时间单位证明。"
  ],
  "old_ids": [
    "CH01-200"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem ljtimescaling :
  ∀ (N : ℕ) (m ε σ α : ℝ) (Q : ℝ → Fin N → V3),
    0 < m → 0 < ε → 0 < σ → 0 < α → α^2=ε/(m*σ^2) →
    (∀ i, ContDiff ℝ 2 (fun t => Q t i)) →
    (∀ t i j, i ≠ j → Q t i ≠ Q t j) →
    (((∀ t i, m • deriv (deriv (fun s => σ • Q (α*s) i)) t =
      ljForce ε σ (fun j => σ • Q (α*t) j) i) ↔
    ∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i)) ∧
    α⁻¹ = σ * Real.sqrt (m / ε) := by
  intro N m ε σ α Q hm he hs ha hscale hQ hnc
  have hfirst (i : Fin N) (t : ℝ) :
      deriv (fun s => σ • Q (α*s) i) t = (σ*α) • deriv (fun s => Q s i) (α*t) := by
    have hd := ((hQ i).differentiable (by norm_num) (α*t)).hasDerivAt.scomp t
      ((hasDerivAt_id t).const_mul α)
    simpa [Function.comp_def, Pi.smul_def, smul_smul] using (hd.const_smul σ).deriv
  have hsecond (i : Fin N) (t : ℝ) :
      deriv (deriv (fun s => σ • Q (α*s) i)) t =
        (σ*α^2) • deriv (deriv (fun s => Q s i)) (α*t) := by
    have hf : deriv (fun s => σ • Q (α*s) i) = fun s => (σ*α) • deriv (fun s => Q s i) (α*s) :=
      funext (hfirst i)
    rw [hf]
    have hQi : ContDiff ℝ (1+1) (fun s => Q s i) := hQ i
    have hd := (hQi.deriv'.differentiable (by norm_num) (α*t)).hasDerivAt.scomp t
      ((hasDerivAt_id t).const_mul α)
    simpa [Function.comp_def, Pi.smul_def, smul_smul,pow_two,mul_assoc] using (hd.const_smul (σ*α)).deriv
  have hphi (e s r : ℝ) (hr : r ≠ 0) :
      deriv (Chapter01Review.lennardJonesPotential e s) r =
        (24*e/r)*((s/r)^6-2*(s/r)^12) := by
    have hx := (hasDerivAt_const r s).div (hasDerivAt_id r) hr
    have hd := ((hx.pow 12).sub (hx.pow 6)).const_mul (4*e)
    convert hd.deriv using 1
    · rfl
    · simp only [Pi.div_apply, Pi.pow_apply, id_eq, Nat.cast_ofNat]
      norm_num only [Nat.reduceSub]
      field_simp [hr] <;> ring
  have hforce (t : ℝ) (i : Fin N) :
      ljForce ε σ (fun j => σ • Q t j) i = (ε/σ) • ljForce 1 1 (Q t) i := by
    unfold ljForce
    rw [Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro j hj
    have hij : i ≠ j := (Finset.mem_erase.mp hj).1.symm
    have hr : 0 < ‖Q t i-Q t j‖ := norm_pos_iff.mpr (sub_ne_zero.mpr (hnc t i j hij))
    have hd : pairDistance (σ • Q t i) (σ • Q t j) = σ * pairDistance (Q t i) (Q t j) := by
      simp [pairDistance,← smul_sub,norm_smul,Real.norm_eq_abs,abs_of_pos hs]
    change (-deriv (Chapter01Review.lennardJonesPotential ε σ) (pairDistance (σ • Q t i) (σ • Q t j)) / pairDistance (σ • Q t i) (σ • Q t j)) • (σ • Q t i - σ • Q t j) = _
    rw [hphi _ _ _ (by rw [hd]; exact ne_of_gt (mul_pos hs hr)),hphi 1 1 (pairDistance (Q t i) (Q t j)) (ne_of_gt hr),hd]
    rw [← smul_sub,smul_smul,smul_smul]
    congr 1
    dsimp [pairDistance]
    field_simp [hs.ne',hr.ne'] <;> ring
  have hcoeff : m*(σ*α^2) = ε/σ := by
    rw [hscale]
    field_simp [hs.ne',hm.ne'] <;> ring
  have hunit : α⁻¹ = σ*Real.sqrt (m/ε) := by
    apply (sq_eq_sq₀ (inv_nonneg.mpr ha.le) (mul_nonneg hs.le (Real.sqrt_nonneg _))).mp
    rw [mul_pow,Real.sq_sqrt (div_nonneg hm.le he.le),inv_pow,hscale]
    field_simp [hm.ne',hs.ne',he.ne'] <;> ring
  refine ⟨?_,hunit⟩
  constructor
  · intro h τ i
    have hh := h (τ/α) i
    rw [hsecond,hforce,smul_smul,hcoeff] at hh
    have ht : α*(τ/α) = τ := by field_simp [ha.ne']
    rw [ht] at hh
    have hc := congrArg (fun v : V3 => (σ/ε) • v) hh
    simpa [smul_smul,div_eq_mul_inv,hs.ne',he.ne',mul_assoc,mul_comm,mul_left_comm] using hc
  · intro h t i
    rw [hsecond,hforce,smul_smul,hcoeff,h (α*t) i]

/- Argon SI specialization: the printed approximation uses an explicit 0.01 ps tolerance. -/
theorem ljtimescaling_argon :
    |(3.4 / 10^10 : ℝ) * Real.sqrt ((6.69 / 10^26) / (1.65 / 10^21)) -
      2.17 / 10^12| < 0.01 / 10^12 := by
  have hs := Real.sq_sqrt (show (0 : ℝ) ≤ (6.69 / 10^26) / (1.65 / 10^21) by norm_num)
  have hp := Real.sqrt_nonneg ((6.69 / 10^26 : ℝ) / (1.65 / 10^21))
  rw [abs_lt]
  constructor <;> nlinarith

/- END FULL SECTION 1.2 -/

/- BEGIN FULL SECTION 1.3 -/
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```
### 实际依赖 MolecularDynamics.Chapter01Review.ljForce
```lean
def ljForce {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) (i : Fin N) : V3 :=
  ∑ j ∈ Finset.univ.erase i,
    (-deriv (lennardJonesPotential ε σ) (pairDistance (q i) (q j)) /
      pairDistance (q i) (q j)) • (q i-q j)
```
### 实际依赖 MolecularDynamics.Chapter01Review.pairDistance
```lean
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
```
