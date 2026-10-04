import MolecularDynamics.Chapter01.LatticeVibrations

namespace MolecularDynamics
noncomputable section
noncomputable local instance (n : ℕ) : ContinuousSMul ℝ (PhaseSpace n) := by
  have h : IsBoundedSMul ℝ (PhaseSpace n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul
section RealModes
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- Real normal-mode expression on printed37/PDF60. -/
def realNormalMode (Ω α β : ℝ) (u v : E) (t : ℝ) : E :=
  α • (Real.sin (Ω * t) • u + Real.cos (Ω * t) • v) +
    β • (Real.cos (Ω * t) • u - Real.sin (Ω * t) • v)

theorem hasDerivAt_realNormalMode (A : E →L[ℝ] E) (Ω α β : ℝ) (u v : E)
    (hu : A u = -Ω • v) (hv : A v = Ω • u) (t : ℝ) :
    HasDerivAt (realNormalMode Ω α β u v)
      (A (realNormalMode Ω α β u v t)) t := by
  have hscale : HasDerivAt (fun y : ℝ => Ω * y) Ω t := by
    simpa using (hasDerivAt_id t).const_mul Ω
  have hs := (Real.hasDerivAt_sin (Ω * t)).comp t hscale
  have hc := (Real.hasDerivAt_cos (Ω * t)).comp t hscale
  have hd := ((hs.smul_const u).add (hc.smul_const v)).const_smul α |>.add
    (((hc.smul_const u).sub (hs.smul_const v)).const_smul β)
  convert hd using 1
  · funext y
    simp [realNormalMode, smul_add, smul_sub]
  · simp [realNormalMode, map_add, map_sub, map_smul, hu, hv,
      smul_add, smul_sub, smul_smul, add_comm, add_assoc]
    module

@[simp] theorem realNormalMode_zero (Ω α β : ℝ) (u v : E) :
    realNormalMode Ω α β u v 0 = α • v + β • u := by
  simp [realNormalMode]

variable [CompleteSpace E]
theorem realNormalMode_eq_linearExponentialFlow (A : E →L[ℝ] E)
    (Ω α β : ℝ) (u v : E) (hu : A u = -Ω • v) (hv : A v = Ω • u) (t : ℝ) :
    realNormalMode Ω α β u v t = linearExponentialFlow A t (α • v + β • u) := by
  have heq := linearExponentialFlow_unique A (α • v + β • u) 0
    (realNormalMode Ω α β u v) (hasDerivAt_realNormalMode A Ω α β u v hu hv)
    (realNormalMode_zero Ω α β u v)
  simpa using congrFun heq t
end RealModes

theorem mechanicalNormalMode_pair {n : ℕ} (m : CoordinateMasses n)
    (K : Position n →L[ℝ] Momentum n) (Ω : ℝ) (q : Position n)
    (hm : ∀ i, 0 < m i) (hq : K q = Ω ^ 2 • massOperator m q) :
    mechanicalLinearization m (-K) (q, 0) = -Ω • (0, Ω • massOperator m q) ∧
    mechanicalLinearization m (-K) (0, Ω • massOperator m q) = Ω • (q, 0) := by
  constructor
  · simp [mechanicalLinearization_apply, hq, pow_two, smul_smul]
  · simp [mechanicalLinearization_apply, velocityOperator_massOperator m hm]

theorem hasDerivAt_mechanicalNormalMode {n : ℕ} (m : CoordinateMasses n)
    (K : Position n →L[ℝ] Momentum n) (Ω α β : ℝ) (q : Position n)
    (hm : ∀ i, 0 < m i) (hq : K q = Ω ^ 2 • massOperator m q) (t : ℝ) :
    HasDerivAt (realNormalMode Ω α β (q, 0) (0, Ω • massOperator m q))
      (mechanicalLinearization m (-K)
        (realNormalMode Ω α β (q, 0) (0, Ω • massOperator m q) t)) t := by
  obtain ⟨hu, hv⟩ := mechanicalNormalMode_pair m K Ω q hm hq
  exact hasDerivAt_realNormalMode _ Ω α β _ _ hu hv t

end
end MolecularDynamics
#print axioms MolecularDynamics.hasDerivAt_realNormalMode
#print axioms MolecularDynamics.realNormalMode_eq_linearExponentialFlow
#print axioms MolecularDynamics.mechanicalNormalMode_pair
#print axioms MolecularDynamics.hasDerivAt_mechanicalNormalMode
