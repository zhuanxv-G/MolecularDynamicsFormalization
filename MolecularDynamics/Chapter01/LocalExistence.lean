import MolecularDynamics.Chapter01.LocalTrajectories
import Mathlib.Analysis.ODE.ExistUnique

open Set

namespace MolecularDynamics

/-- A differentiable force gives a differentiable fixed-mass mechanical field. -/
theorem mechanicalVectorField_contDiffAt {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (z₀ : PhaseSpace n)
    (hF : ContDiffAt ℝ 1 F z₀.1) :
    ContDiffAt ℝ 1 (mechanicalVectorField m F) z₀ := by
  have hfst : ContDiffAt ℝ 1 (fun z : PhaseSpace n => z.1) z₀ :=
    (ContinuousLinearMap.fst ℝ (Position n) (Momentum n)).contDiff.contDiffAt
  have hsnd : ContDiffAt ℝ 1 (fun z : PhaseSpace n => z.2) z₀ :=
    (ContinuousLinearMap.snd ℝ (Position n) (Momentum n)).contDiff.contDiffAt
  have hv : ContDiffAt ℝ 1 (fun z : PhaseSpace n => velocityOperator m z.2) z₀ :=
    (velocityOperator m).contDiff.contDiffAt.comp z₀ hsnd
  have hforce : ContDiffAt ℝ 1 (fun z : PhaseSpace n => F z.1) z₀ :=
    hF.comp z₀ hfst
  change ContDiffAt ℝ 1
    (fun z : PhaseSpace n => (velocityOperator m z.2, F z.1)) z₀
  exact hv.prodMk hforce


/-- A continuously differentiable mechanical field admits a local IVP solution
when the configuration domain is all of Euclidean space. -/
theorem exists_localMechanicalIVP_univ {n : ℕ}
    (m : CoordinateMasses n) (F : Force n)
    (t₀ : ℝ) (z₀ : PhaseSpace n)
    (hfield : ContDiffAt ℝ 1 (mechanicalVectorField m F) z₀) :
    ∃ ε : ℝ, ∃ γ : ℝ → PhaseSpace n,
      IsLocalMechanicalIVP m F univ t₀ z₀ ε γ := by
  obtain ⟨γ, hγ₀, ε, hε, hγ⟩ :=
    hfield.exists_forall_mem_closedBall_exists_eq_forall_mem_Ioo_hasDerivAt₀ t₀
  refine ⟨ε, γ, hε, hγ₀, ?_⟩
  refine ⟨fun _ _ => mem_univ _, ?_⟩
  intro t ht
  simpa only using (hγ t ht).hasDerivWithinAt


/-- Two solutions of a globally Lipschitz mechanical field with the same
initial state agree on their common open time interval. -/
theorem mechanicalSolution_unique_on_Ioo {n : ℕ}
    (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (a b t₀ : ℝ)
    (γ η : ℝ → PhaseSpace n) (K : NNReal)
    (hLip : LipschitzWith K (mechanicalVectorField m F))
    (ht₀ : t₀ ∈ Ioo a b)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hη : IsMechanicalSolutionOn m F Q (Ioo a b) η)
    (hinit : γ t₀ = η t₀) :
    EqOn γ η (Ioo a b) := by
  apply ODE_solution_unique_of_mem_Ioo
    (v := fun _ z => mechanicalVectorField m F z)
    (s := fun _ => univ) (K := K)
    (fun _ _ => hLip.lipschitzOnWith) ht₀
  · intro t ht
    exact ⟨(hγ.2 t ht).hasDerivAt (isOpen_Ioo.mem_nhds ht), mem_univ _⟩
  · intro t ht
    exact ⟨(hη.2 t ht).hasDerivAt (isOpen_Ioo.mem_nhds ht), mem_univ _⟩
  · exact hinit


/-- An open configuration domain can be respected by shrinking the local
existence interval around its prescribed initial state. -/
theorem exists_localMechanicalIVP_open {n : ℕ}
    (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (hQ : IsOpen Q)
    (t₀ : ℝ) (z₀ : PhaseSpace n) (hz₀ : z₀.1 ∈ Q)
    (hfield : ContDiffAt ℝ 1 (mechanicalVectorField m F) z₀) :
    ∃ ε : ℝ, ∃ γ : ℝ → PhaseSpace n,
      IsLocalMechanicalIVP m F Q t₀ z₀ ε γ := by
  obtain ⟨γ, hγ₀, ε, hε, hγ⟩ :=
    hfield.exists_forall_mem_closedBall_exists_eq_forall_mem_Ioo_hasDerivAt₀ t₀
  have ht₀ : t₀ ∈ Ioo (t₀ - ε) (t₀ + ε) := by
    constructor <;> linarith
  have hcont : ContinuousAt (fun t => (γ t).1) t₀ :=
    (hγ t₀ ht₀).continuousAt.fst
  have hq₀ : (γ t₀).1 ∈ Q := by simpa [hγ₀] using hz₀
  obtain ⟨δ, hδ, hsub⟩ := Metric.mem_nhds_iff.mp
    (hcont.preimage_mem_nhds (hQ.mem_nhds hq₀))
  let ε' := min ε δ
  have hε' : 0 < ε' := lt_min hε hδ
  refine ⟨ε', γ, hε', hγ₀, ?_⟩
  constructor
  · intro t ht
    apply hsub
    rw [Real.ball_eq_Ioo]
    dsimp [ε'] at ht
    rcases ht with ⟨htl, htr⟩
    constructor <;> linarith [min_le_right ε δ]
  · intro t ht
    apply (hγ t ?_).hasDerivWithinAt
    dsimp [ε'] at ht
    rcases ht with ⟨htl, htr⟩
    constructor <;> linarith [min_le_left ε δ]


/-- Local existence on an open position domain from the force's C¹ regularity. -/
theorem exists_localMechanicalIVP_open_of_force_contDiffAt {n : ℕ}
    (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (hQ : IsOpen Q)
    (t₀ : ℝ) (z₀ : PhaseSpace n) (hz₀ : z₀.1 ∈ Q)
    (hF : ContDiffAt ℝ 1 F z₀.1) :
    ∃ ε : ℝ, ∃ γ : ℝ → PhaseSpace n,
      IsLocalMechanicalIVP m F Q t₀ z₀ ε γ :=
  exists_localMechanicalIVP_open m F Q hQ t₀ z₀ hz₀
    (mechanicalVectorField_contDiffAt m F z₀ hF)


end MolecularDynamics
