import MolecularDynamics.Chapter01.MechanicalContinuation

open Set Filter
open scoped Topology

theorem exists_glued_function_probe {α E ι : Type*} (s : ι → Set α)
    (f : ι → α → E) (z₀ : E) (hcompat : ∀ i j, EqOn (f i) (f j) (s i ∩ s j)) :
    ∃ γ : α → E, ∀ i, EqOn γ (f i) (s i) := by
  classical
  refine ⟨fun x => if h : ∃ i, x ∈ s i then f (Classical.choose h) x else z₀, ?_⟩
  intro i x hx
  have hcover : ∃ j, x ∈ s j := ⟨i, hx⟩
  dsimp only
  rw [dite_eq_left hcover]
  exact hcompat (Classical.choose hcover) i ⟨Classical.choose_spec hcover, hx⟩

#print axioms exists_glued_function_probe

namespace MolecularDynamics

theorem mechanical_open_cover_probe {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {ι : Type*} {s : ι → Set ℝ} {f : ι → ℝ → PhaseSpace n}
    (z₀ : PhaseSpace n) (hs : ∀ i, IsOpen (s i))
    (hf : ∀ i, IsMechanicalSolutionOn m F Q (s i) (f i))
    (hcompat : ∀ i j, EqOn (f i) (f j) (s i ∩ s j)) :
    ∃ γ, IsMechanicalSolutionOn m F Q (⋃ i, s i) γ ∧ ∀ i, EqOn γ (f i) (s i) := by
  obtain ⟨γ, heq⟩ := exists_glued_function_probe s f z₀ hcompat
  refine ⟨γ, ⟨?_, ?_⟩, heq⟩
  · intro t ht
    obtain ⟨i, hi⟩ := mem_iUnion.mp ht
    rw [heq i hi]
    exact (hf i).1 t hi
  · intro t ht
    obtain ⟨i, hi⟩ := mem_iUnion.mp ht
    have hevent : γ =ᶠ[𝓝 t] f i := by
      filter_upwards [(hs i).mem_nhds hi] with u hu
      exact heq i hu
    rw [heq i hi]
    exact (((hf i).2 t hi).hasDerivAt ((hs i).mem_nhds hi)).congr_of_eventuallyEq
      hevent |>.hasDerivWithinAt

theorem global_compact_probe {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {K : Set (PhaseSpace n)}
    {a t₀ b₀ : ℝ} {z₀ : PhaseSpace n} {γ₀ : ℝ → PhaseSpace n}
    (hat : a < t₀) (htb : t₀ < b₀) (hQ : IsOpen Q)
    (hF : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hγ₀ : IsMechanicalSolutionOn m F Q (Ioo a b₀) γ₀) (hinit₀ : γ₀ t₀ = z₀)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q)
    (hconfine : ∀ b γ, t₀ < b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ t₀ = z₀ → ∀ t ∈ Ioo a b, t₀ ≤ t → γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q (Ioi a) γ ∧ γ t₀ = z₀ ∧
      ∀ t, t₀ ≤ t → γ t ∈ K := by
  classical
  let A : Set ℝ := {b | t₀ < b ∧ ∃ γ, IsMechanicalSolutionOn m F Q (Ioo a b) γ ∧ γ t₀ = z₀}
  have hb₀ : b₀ ∈ A := ⟨htb, γ₀, hγ₀, hinit₀⟩
  have hA : A.Nonempty := ⟨b₀, hb₀⟩
  have hex : ∀ b : A, ∃ γ, IsMechanicalSolutionOn m F Q (Ioo a b) γ ∧ γ t₀ = z₀ :=
    fun b => b.property.2
  choose f hf hinit using hex
  have hcompat : ∀ i j : A, EqOn (f i) (f j) (Ioo a i ∩ Ioo a j) := by
    intro i j t ht
    have hmini : Ioo a (min (i : ℝ) j) ⊆ Ioo a i := Ioo_subset_Ioo le_rfl (min_le_left _ _)
    have hminj : Ioo a (min (i : ℝ) j) ⊆ Ioo a j := Ioo_subset_Ioo le_rfl (min_le_right _ _)
    have hfi := (hf i).mono hmini
    have hfj := (hf j).mono hminj
    apply mechanicalSolution_unique_on_preconnected_of_contDiffAt
      isOpen_Ioo isPreconnected_Ioo (show t₀ ∈ Ioo a (min (i : ℝ) j) from
        ⟨hat, lt_min i.property.1 j.property.1⟩) hfi hfj
      (fun u hu => mechanicalVectorField_contDiffAt m F (f i u) (hF _ (hfi.1 u hu)))
      ((hinit i).trans (hinit j).symm)
    exact ⟨ht.1.1, lt_min ht.1.2 ht.2.2⟩
  obtain ⟨γ, hγ, heq⟩ := mechanical_open_cover_probe z₀
    (s := fun b : A => Ioo a b) (f := f) (fun _ => isOpen_Ioo) hf hcompat
  have hinitγ : γ t₀ = z₀ := (heq ⟨b₀, hb₀⟩ ⟨hat, htb⟩).trans (hinit ⟨b₀, hb₀⟩)
  have hunbounded : ¬ BddAbove A := by
    intro hbdd
    let B := sSup A
    have htB : t₀ < B := lt_of_lt_of_le htb (le_csSup hbdd hb₀)
    have hcover : (⋃ b : A, Ioo a (b : ℝ)) = Ioo a B := by
      ext t
      constructor
      · intro ht
        obtain ⟨b, hbt⟩ := mem_iUnion.mp ht
        exact ⟨hbt.1, lt_of_lt_of_le hbt.2 (le_csSup hbdd b.property)⟩
      · intro ht
        obtain ⟨b, hb, htb'⟩ := exists_lt_of_lt_csSup hA ht.2
        exact mem_iUnion.mpr ⟨⟨b, hb⟩, ht.1, htb'⟩
    have hγB : IsMechanicalSolutionOn m F Q (Ioo a B) γ := by simpa [hcover] using hγ
    have hmem : MapsTo γ (Ioo t₀ B) K := by
      intro t ht
      exact hconfine B γ htB hγB hinitγ t ⟨lt_trans hat ht.1, ht.2⟩ ht.1.le
    obtain ⟨δ, hδ, η, hη, heqη⟩ := mechanicalSolution_extend_of_compact htB hQ
      (hγB.mono (Ioo_subset_Ioo hat.le le_rfl)) hK hmem hKQ
      (fun z hz => hF _ (hKQ z hz))
    obtain ⟨ζ, hζ, hζeq⟩ := mechanicalSolution_glue_on_Ioo htB hγB hη heqη.symm
    have hBnew : B + δ ∈ A :=
      ⟨by linarith, ζ, hζ, (hζeq ⟨hat, htB⟩).trans hinitγ⟩
    have hbound : B + δ ≤ B := le_csSup hbdd hBnew
    linarith
  have hcover : (⋃ b : A, Ioo a (b : ℝ)) = Ioi a := by
    ext t
    constructor
    · intro ht
      obtain ⟨b, hb⟩ := mem_iUnion.mp ht
      exact hb.1
    · intro ht
      obtain ⟨b, hb, htb'⟩ := not_bddAbove_iff.mp hunbounded t
      exact mem_iUnion.mpr ⟨⟨b, hb⟩, ht, htb'⟩
  have hγglobal : IsMechanicalSolutionOn m F Q (Ioi a) γ := by simpa [hcover] using hγ
  refine ⟨γ, hγglobal, hinitγ, ?_⟩
  intro t ht
  exact hconfine (t + 1) γ (by linarith)
    (hγglobal.mono fun u hu => hu.1) hinitγ t ⟨lt_of_lt_of_le hat ht, by linarith⟩ ht

#print axioms mechanical_open_cover_probe
#print axioms global_compact_probe

end MolecularDynamics
