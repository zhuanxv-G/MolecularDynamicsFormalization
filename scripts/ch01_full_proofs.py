"""Local PASS-only proof bodies, with explicit attempt accounting in local_audit."""
PROOFS = {
 'MD-1.4-HamiltonFixedMass': '''  let B := Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹
  have hsym := Matrix.isSymmetric_toEuclideanLin_iff.mpr hM.inv.isHermitian
  have hKD : HasFDerivAt (fun v : Position n => inner ℝ v (B v)/2)
      (InnerProductSpace.toDual ℝ (Position n) (B p)) p := by
    have hd := (hasFDerivAt_id (𝕜 := ℝ) p).inner ℝ B.hasFDerivAt
    convert hd.mul_const ((2:ℝ)⁻¹) using 1
    · simp only [div_eq_mul_inv, id_eq]
    · ext v
      simp [fderivInnerCLM_apply, InnerProductSpace.toDual_apply_apply]
      rw [← hsym p v]
      ring
  constructor
  · rw [hasGradientAt_iff_hasFDerivAt]
    exact hKD.add_const (U q)
  · rw [hasGradientAt_iff_hasFDerivAt]
    exact hU.hasGradientAt.hasFDerivAt.const_add (inner ℝ p (B p)/2)''',
 'MD-1.5.3-HamiltonEquilibrium': '''  have hg := hamilton_fixed_mass M U q p hM hU
  have hv : matrixAction M⁻¹ p = 0 := hg.1.gradient.symm.trans heq.1
  have hc : M⁻¹.mulVec (WithLp.ofLp p) = M⁻¹.mulVec 0 := by
    have hh := congrArg WithLp.ofLp hv
    simpa [matrixAction] using hh
  have hinj := Matrix.mulVec_injective_iff_isUnit.mpr hM.inv.isUnit
  have hp : p = 0 := by
    have hh := hinj hc
    simpa using hh
  exact ⟨hp,hg.2.gradient.symm.trans heq.2⟩''',
 'MD-1.7.2-PositiveLyapunovGrowth': '''  intro σ hσ hpos
  obtain ⟨c,hc,hclim⟩ := EReal.exists_between_coe_real hpos
  refine ⟨c,EReal.coe_pos.mp hc,?_⟩
  intro T
  change (c : EReal) < Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop at hclim
  have hf := Filter.frequently_lt_of_lt_limsup (h := hclim)
  obtain ⟨t,htc,htt⟩ := (hf.and_eventually (eventually_gt_atTop (max T 0))).exists
  have ht : 0 < t := lt_of_le_of_lt (le_max_right T 0) htt
  refine ⟨t,lt_of_le_of_lt (le_max_left T 0) htt,?_⟩
  have hl : c < Real.log (σ t)/t := EReal.coe_lt_coe_iff.mp htc
  have he : c*t < Real.log (σ t) := (lt_div_iff₀ ht).mp hl
  exact (Real.exp_lt_exp.mpr he).trans_eq (Real.exp_log (hσ t ht))''',
 'MD-1.7-CentralPairGradient': '''  intro φ q r hqr hφ
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
  ring''',
 'MD-1.5-Nonconfining': '''  intro h
  obtain ⟨R,hR⟩ := h.exists_norm_le
  let q : Position 2 := WithLp.toLp 2 ![1,|R|+1]
  have hb : ‖q‖ ≤ R := hR q (by simp [q])
  have hv : |R|+1 ≤ ‖q‖ := by
    simpa [q, abs_of_nonneg (by positivity : 0 ≤ |R|+1)] using PiLp.norm_apply_le q (1 : Fin 2)
  have := le_abs_self R
  linarith''',
 'MD-1.5.2-KeplerMomentum': '''  intro q hq
  simp [keplerForce, smul_eq_zero, hq, norm_ne_zero_iff.mpr hq]''',
 'MD-1.5.1-FlowEnergy': '''  intro ξ t
  have hd (s : ℝ) : HasDerivAt (fun u => H (F u ξ)) 0 s := by
    let z := F s ξ
    let A := fderiv ℝ H z
    have hA : HasFDerivAt H A z := (hH z).hasFDerivAt
    have hq := hA.comp z.1 ((hasFDerivAt_id (𝕜 := ℝ) z.1).prodMk (hasFDerivAt_const (𝕜 := ℝ) z.2 z.1))
    have hp := hA.comp z.2 ((hasFDerivAt_const (𝕜 := ℝ) z.1 z.2).prodMk (hasFDerivAt_id (𝕜 := ℝ) z.2))
    simp only [Function.comp_def, id_eq] at hq hp
    let gq := gradient (fun q => H (q,z.2)) z.1
    let gp := gradient (fun p => H (z.1,p)) z.2
    have eqQ (v : Position n) : A (v,0) = inner ℝ gq v := by
      rw [inner_gradient_left, hq.fderiv]
      rfl
    have eqP (v : Position n) : A (0,v) = inner ℝ gp v := by
      rw [inner_gradient_left, hp.fderiv]
      rfl
    have hz : A (symplecticGradient H z) = 0 := by
      change A (gp,-gq) = 0
      have he : (gp,-gq) = (gp,0)+(0,-gq) := by simp
      rw [he, map_add, eqQ, eqP, inner_neg_right, real_inner_comm gq gp]
      ring
    have hh := hA.comp_hasDerivAt s ((hF ξ).2 s)
    have he : A (symplecticGradient H (F s ξ)) = 0 := hz
    rw [he] at hh
    simpa only [Function.comp_def] using hh
  have hc := is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
  simpa [(hF ξ).1] using hc''',
 'MD-1.5.3-PositiveHessianQuadratic': '''  intro n M K hM hK
  have hn (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosSemidef) (v : Position n) :
      0 ≤ inner ℝ v (A.toEuclideanLin v) := by
    change 0 ≤ inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    simpa using ha.dotProduct_mulVec_nonneg (x := WithLp.ofLp v)
  have hp (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosDef) (v : Position n) (hv : v ≠ 0) :
      0 < inner ℝ v (A.toEuclideanLin v) := by
    change 0 < inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    have hv' : WithLp.ofLp v ≠ 0 := by simpa using hv
    simpa using ha.dotProduct_mulVec_pos hv'
  refine ⟨1,by norm_num,?_⟩
  intro z hz _
  have hzn : z ≠ 0 := dist_pos.mp hz
  have hq := hn K hK.posSemidef z.1
  have hpp := hn M⁻¹ hM.inv.posSemidef z.2
  have hz0 : inner ℝ ((0:PhaseSpace n).2) (M⁻¹.toEuclideanLin (0:PhaseSpace n).2)/2 +
      inner ℝ ((0:PhaseSpace n).1) (K.toEuclideanLin (0:PhaseSpace n).1)/2 = 0 := by
    change inner ℝ (0:Position n) (M⁻¹.toEuclideanLin 0)/2 + inner ℝ (0:Position n) (K.toEuclideanLin 0)/2 = 0
    simp
  dsimp only
  rw [hz0]
  by_cases hqz : z.1 = 0
  · have hpz : z.2 ≠ 0 := by
      intro h; exact hzn (Prod.ext hqz h)
    nlinarith [hp M⁻¹ hM.inv z.2 hpz]
  · nlinarith [hp K hK z.1 hqz]''',
 'MD-1.6-HexagonalLattice': '''  ext x
  have hc : Real.cos (2*Real.pi/3) = -(1/2:ℝ) := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]
  have hs : Real.sin (2*Real.pi/3) = Real.sqrt 3/2 := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.sin_pi_sub, Real.sin_pi_div_three]
  constructor
  · rintro ⟨k,l,rfl⟩
    refine ⟨k-l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring
  · rintro ⟨k,l,rfl⟩
    refine ⟨k+l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring''',
 'MD-1.6.1-ComplexNormalMode': '''  intro n A η Ω hη a b t
  let B := A.map (algebraMap ℝ ℂ)
  let C : (Fin n → ℂ) →L[ℂ] (Fin n → ℂ) := B.toLin'.toContinuousLinearMap
  have hc : B.mulVec (fun i => star (η i)) = (-Complex.I * Ω) • (fun i => star (η i)) := by
    ext i
    have hi := congrArg (fun v : Fin n → ℂ => star (v i)) hη
    simpa [B, Matrix.mulVec, dotProduct, map_sum, map_mul, Pi.smul_apply] using hi
  have h₁ := hasDerivAt_complexEigenmode C (Complex.I*Ω) η hη 0 t
  have h₂ := hasDerivAt_complexEigenmode C (-Complex.I*Ω) (fun i => star (η i)) hc 0 t
  convert! (h₁.const_smul a).add (h₂.const_smul b) using 1 <;>
    simp [C, B, sub_zero, Pi.add_def, Pi.smul_def, Matrix.mulVec_add, Matrix.mulVec_smul,
      map_add, map_smul, mul_assoc, neg_mul]''',
 'MD-1.6-PeriodicTranslationMomentum': '''  intro N φ L
  dsimp only
  let U := boxPeriodicNearestNeighborPotentialEnergy (N := N) φ L
  have hd (q : Fin (N+1) → ℝ) (hq : DifferentiableAt ℝ U q) :
      fderiv ℝ U q (fun _ => 1) = 0 := by
    have hc : HasDerivAt (fun c : ℝ => q+c • (fun _ => (1:ℝ))) (fun _ => 1) 0 := by
      simpa using (hasDerivAt_const (0:ℝ) q).add ((hasDerivAt_id (0:ℝ)).smul_const (fun _ => (1:ℝ)))
    have hqp : HasFDerivAt U (fderiv ℝ U q) (q+(0:ℝ) • (fun _ => (1:ℝ))) := by
      simpa using hq.hasFDerivAt
    have hf := hqp.comp_hasDerivAt (0:ℝ) hc
    have he : (fun c : ℝ => U (q+c • (fun _ => (1:ℝ)))) = fun _ => U q := by
      funext c
      simpa [U] using boxPeriodicNearestNeighborPotentialEnergy_translate φ L q c
    rw [he] at hf
    simpa using hf.unique (hasDerivAt_const 0 (U q))
  refine ⟨boxPeriodicNearestNeighborPotentialEnergy_translate φ L, hd, ?_⟩
  intro m q v I ho hi hm hU hq
  have hp (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => ∑ i, m i*v s i) 0 t := by
    have hh := HasDerivAt.sum (u := Finset.univ) (fun i _ => (hq t ht i).2)
    have hs : (∑ i : Fin (N+1), Pi.single i (1:ℝ)) = (fun _ => 1) := by
      exact Finset.univ_sum_single _
    have hz : (∑ i : Fin (N+1), -fderiv ℝ U (q t) (Pi.single i 1)) = 0 := by
      rw [Finset.sum_neg_distrib, ← map_sum, hs, hd (q t) (hU t ht), neg_zero]
    change HasDerivAt (fun s => ∑ i, m i*v s i)
      (∑ i : Fin (N+1), -fderiv ℝ U (q t) (Pi.single i 1)) t at hh
    rwa [hz] at hh
  refine ⟨hp, ?_⟩
  intro a ha b hb
  exact ho.is_const_of_deriv_eq_zero hi
    (fun t ht => (hp t ht).differentiableWithinAt) (fun t ht => (hp t ht).deriv) ha hb''',
 'MD-1.6-UnorderedPairCount': '''  intro N
  simpa [Nat.choose_two_right] using Finset.card_product_filter_lt (s := (Finset.univ : Finset (Fin N)))''',
 'MD-1.6.1-ForceLinearization': '''  let B := Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹
  have hg := (gradient_contDiffAt_of_potential_contDiffAt_two hU).differentiableAt (by norm_num)
  constructor
  · change HasFDerivAt (fun z : PhaseSpace n => (B z.2, -gradient U z.1)) _ (qstar,0)
    have hn : HasFDerivAt (fun q => -gradient U q) (-fderiv ℝ (gradient U) qstar) qstar :=
      hg.hasFDerivAt.neg
    have h₂ := hn.comp (qstar,0)
      ((ContinuousLinearMap.fst ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    have h₁ := B.hasFDerivAt.comp (qstar,0)
      ((ContinuousLinearMap.snd ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    exact h₁.prodMk h₂
  · have h := hasFDerivAt_iff_isLittleO.mp hg.hasFDerivAt
    simpa only [heq, sub_zero] using h''',
}

# Three independent compile failures exhausted the user's per-entry time box.
FAILED_PROOFS = {sid:PROOFS.pop(sid) for sid in
  ('MD-1.6.1-ComplexNormalMode','MD-1.6-PeriodicTranslationMomentum')}
