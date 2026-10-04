import MolecularDynamics.Chapter01.HarmonicActionAngle

namespace MolecularDynamics

noncomputable def harmonicActionMap (Ω : ℝ) (q : Position 2) : Position 2 :=
  WithLp.toLp 2 ![harmonicActionPosition Ω (q 0) (q 1), harmonicActionVelocity Ω (q 0) (q 1)]

noncomputable def harmonicActionJacobian (Ω J θ : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos θ / (Ω * harmonicActionAmplitude Ω J), -harmonicActionAmplitude Ω J * Real.sin θ;
    Real.sin θ / harmonicActionAmplitude Ω J, Ω * harmonicActionAmplitude Ω J * Real.cos θ]

theorem harmonicActionAmplitude_hasStrictDerivAt (Ω J : ℝ) (hΩ : 0 < Ω) (hJ : 0 < J) :
    HasStrictDerivAt (harmonicActionAmplitude Ω) (1 / (Ω * harmonicActionAmplitude Ω J)) J := by
  have hx : 0 < 2 * J / Ω := div_pos (mul_pos (by norm_num) hJ) hΩ
  have h := (((hasStrictDerivAt_id J).const_mul 2).div_const Ω).sqrt (ne_of_gt hx)
  convert h using 1
  · funext u
    rfl
  · dsimp [harmonicActionAmplitude]
    field_simp

theorem harmonicActionJacobian_det (Ω J θ : ℝ) (hΩ : 0 < Ω) (hJ : 0 < J) :
    (harmonicActionJacobian Ω J θ).det = 1 := by
  rw [Matrix.det_fin_two]
  change (Real.cos θ / (Ω * harmonicActionAmplitude Ω J)) *
      (Ω * harmonicActionAmplitude Ω J * Real.cos θ) -
    (-harmonicActionAmplitude Ω J * Real.sin θ) *
      (Real.sin θ / harmonicActionAmplitude Ω J) = 1
  calc
    _ = Real.cos θ ^ 2 + Real.sin θ ^ 2 := by
      field_simp [ne_of_gt hΩ, ne_of_gt (harmonicActionAmplitude_pos Ω J hΩ hJ)]
      ring
    _ = 1 := Real.cos_sq_add_sin_sq θ

theorem hasStrictFDerivAt_harmonicActionMap (Ω : ℝ) (q : Position 2)
    (hΩ : 0 < Ω) (hq : 0 < q 0) :
    HasStrictFDerivAt (harmonicActionMap Ω)
      (Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (harmonicActionJacobian Ω (q 0) (q 1))) q := by
  have hA := (harmonicActionAmplitude_hasStrictDerivAt Ω (q 0) hΩ hq).comp_hasStrictFDerivAt q
    (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 2)).hasStrictFDerivAt
  have hc := (Real.hasStrictDerivAt_cos (q 1)).comp_hasStrictFDerivAt q
    (EuclideanSpace.proj (𝕜 := ℝ) (1 : Fin 2)).hasStrictFDerivAt
  have hs := (Real.hasStrictDerivAt_sin (q 1)).comp_hasStrictFDerivAt q
    (EuclideanSpace.proj (𝕜 := ℝ) (1 : Fin 2)).hasStrictFDerivAt
  apply hasStrictFDerivAt_euclidean.mpr
  intro i
  fin_cases i
  · have h := hA.mul hc
    have heq : Real.cos (q 1) • ((1 / (Ω * harmonicActionAmplitude Ω (q 0))) •
          EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 2)) +
        harmonicActionAmplitude Ω (q 0) • (-Real.sin (q 1) •
          EuclideanSpace.proj (𝕜 := ℝ) (1 : Fin 2)) =
        (PiLp.proj 2 (fun _ : Fin 2 => ℝ) 0).comp
          (Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (harmonicActionJacobian Ω (q 0) (q 1))) := by
      ext u
      change Real.cos (q 1) * ((1 / (Ω * harmonicActionAmplitude Ω (q 0))) * u 0) +
        harmonicActionAmplitude Ω (q 0) * (-Real.sin (q 1) * u 1) =
        ∑ j : Fin 2, harmonicActionJacobian Ω (q 0) (q 1) 0 j * u j
      simp [harmonicActionJacobian, Fin.sum_univ_two]
      ring
    dsimp only [Function.comp_def] at h
    rw [add_comm] at h
    simp only [EuclideanSpace.coe_proj] at h
    rw [heq] at h
    exact h
  · have h := (hA.mul hs).const_mul Ω
    have heq : Ω • (Real.sin (q 1) • ((1 / (Ω * harmonicActionAmplitude Ω (q 0))) •
          EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 2)) +
        harmonicActionAmplitude Ω (q 0) • (Real.cos (q 1) •
          EuclideanSpace.proj (𝕜 := ℝ) (1 : Fin 2))) =
        (PiLp.proj 2 (fun _ : Fin 2 => ℝ) 1).comp
          (Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (harmonicActionJacobian Ω (q 0) (q 1))) := by
      ext u
      change Ω * (Real.sin (q 1) * ((1 / (Ω * harmonicActionAmplitude Ω (q 0))) * u 0) +
        harmonicActionAmplitude Ω (q 0) * (Real.cos (q 1) * u 1)) =
        ∑ j : Fin 2, harmonicActionJacobian Ω (q 0) (q 1) 1 j * u j
      simp [harmonicActionJacobian, Fin.sum_univ_two]
      field_simp [ne_of_gt hΩ]
    dsimp only [Function.comp_def] at h
    rw [add_comm] at h
    simp only [EuclideanSpace.coe_proj] at h
    rw [heq] at h
    have hf : (fun u : Position 2 => Ω *
        (((fun x : Position 2 => harmonicActionAmplitude Ω (x 0)) *
          (fun x : Position 2 => Real.sin (x 1))) u)) =
        (fun u : Position 2 => (harmonicActionMap Ω u) 1) := by
      funext u
      change Ω * (harmonicActionAmplitude Ω (u 0) * Real.sin (u 1)) =
        Ω * harmonicActionAmplitude Ω (u 0) * Real.sin (u 1)
      ring
    rw [hf] at h
    exact h

theorem fderiv_harmonicActionMap (Ω : ℝ) (q : Position 2) (hΩ : 0 < Ω) (hq : 0 < q 0) :
    fderiv ℝ (harmonicActionMap Ω) q =
      Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (harmonicActionJacobian Ω (q 0) (q 1)) :=
  (hasStrictFDerivAt_harmonicActionMap Ω q hΩ hq).hasFDerivAt.fderiv

theorem exists_harmonicActionLocalChart (Ω : ℝ) (q : Position 2) (hΩ : 0 < Ω) (hq : 0 < q 0) :
    ∃ (L : Position 2 ≃L[ℝ] Position 2)
      (e : OpenPartialHomeomorph (Position 2) (Position 2)),
      (L : Position 2 →L[ℝ] Position 2) =
        Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (harmonicActionJacobian Ω (q 0) (q 1)) ∧
      q ∈ e.source ∧ (e : Position 2 → Position 2) = harmonicActionMap Ω ∧
      HasStrictFDerivAt (e.symm : Position 2 → Position 2)
        (L.symm : Position 2 →L[ℝ] Position 2) (harmonicActionMap Ω q) := by
  have hm : IsUnit (harmonicActionJacobian Ω (q 0) (q 1)) := by
    rw [Matrix.isUnit_iff_isUnit_det, harmonicActionJacobian_det Ω (q 0) (q 1) hΩ hq]
    exact isUnit_one
  have hu := hm.map
    (Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ)).toAlgEquiv.toAlgHom.toMonoidHom
  obtain ⟨u, hu⟩ := hu
  let L := ContinuousLinearEquiv.unitsEquiv ℝ (Position 2) u
  have hL : (L : Position 2 →L[ℝ] Position 2) =
      Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (harmonicActionJacobian Ω (q 0) (q 1)) := hu
  have hd : HasStrictFDerivAt (harmonicActionMap Ω) (L : Position 2 →L[ℝ] Position 2) q := by
    rw [hL]
    exact hasStrictFDerivAt_harmonicActionMap Ω q hΩ hq
  exact ⟨L, hd.toOpenPartialHomeomorph (harmonicActionMap Ω), hL,
    hd.mem_toOpenPartialHomeomorph_source, rfl, hd.to_localInverse⟩

#print axioms harmonicActionAmplitude_hasStrictDerivAt
#print axioms harmonicActionJacobian_det
#print axioms hasStrictFDerivAt_harmonicActionMap
#print axioms fderiv_harmonicActionMap
#print axioms exists_harmonicActionLocalChart
end MolecularDynamics
