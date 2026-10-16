# EAUDIT17：第1章§1.6网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.6-PeriodicBoundary",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "34",
  "pdf_page": "57",
  "statement_latex": "If a particle moves to the right of $x=L$ we simply shift its position to $x-L$; likewise any particle exiting to the left of $x=0$ has its position shifted to $x+L$ (see Fig. 1.15).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "周期位置等价类：x与x+kL，k∈Z；实际越界wrap代表选择原文只给左右各一步。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.periodicBoundary",
  "extra_assumptions": [
    "[EXTRA] 19号：原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。"
  ],
  "old_ids": [
    "CH01-154"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def periodicPositionEquivalent (L : ℝ) (x y : ℝ) : Prop := ∃ k : ℤ, y = x + k*L

def periodicBoundary (L : {x : ℝ // 0 < x}) (x y : ℝ) : Prop :=
  y = if L.val < x then x-L.val else if x < 0 then x+L.val else x
```
### 实际依赖 MD.Ch01.periodicBoundary
```lean
def periodicBoundary (L : {x : ℝ // 0 < x}) (x y : ℝ) : Prop :=
  y = if L.val < x then x-L.val else if x < 0 then x+L.val else x
```
### 实际依赖 MD.Ch01.periodicPositionEquivalent
```lean
def periodicPositionEquivalent (L : ℝ) (x y : ℝ) : Prop := ∃ k : ℤ, y = x + k*L
```

## 原文JSON
```json
{
  "source_id": "MD-1.6-PeriodicTranslationMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6",
  "printed_page": "34",
  "pdf_page": "57",
  "statement_latex": "Periodic boundary conditions allow us to preserve Newton’s third law, the translational symmetry, and thus the conservation of momentum.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "翻译不变模型作用的常向量方向导数零，使总内力零；动量守恒复用MomentumConservation条目。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.periodic_translation_momentum",
  "extra_assumptions": [
    "一维周期链真实Newton导数、正质量、势沿轨迹可微及开连通时间域。",
    "[EXTRA] 19号：完整保留平移/方向导数/动量结论，补真实每条周期键两端负偏导相反的Newton第三定律（含闭合键），依赖包展开真实周期能量。"
  ],
  "old_ids": [
    "CH01-155"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem periodic_translation_momentum :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ),
    let U := boxPeriodicNearestNeighborPotentialEnergy φ L
    (∀ q c, U (fun i => q i+c) = U q) ∧
    (∀ q, DifferentiableAt ℝ U q → fderiv ℝ U q (fun _ => 1) = 0) ∧
    ∀ (m : Fin (N+1) → ℝ) (q v : ℝ → Fin (N+1) → ℝ) (I : Set ℝ),
      IsOpen I → IsPreconnected I → (∀ i, 0 < m i) →
      (∀ t ∈ I, DifferentiableAt ℝ U (q t)) →
      (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t ∧
        HasDerivAt (fun s => m i*v s i) (-fderiv ℝ U (q t) (Pi.single i 1)) t) →
      (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i*v s i) 0 t) ∧
      ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i*v a i) = ∑ i, m i*v b i := by
  sorry

/-- Both endpoint forces of each actual directed periodic bond, including the closing bond. -/
def periodicBondEnergy (φ : ℝ → ℝ) (L : ℝ) (x y : ℝ) (closing : Bool) : ℝ :=
  φ (y-x + if closing then L else 0)

theorem periodic_translation_third_law (φ : ℝ → ℝ) (L x y : ℝ) (closing : Bool)
    (hφ : DifferentiableAt ℝ φ (y-x + if closing then L else 0)) :
    -deriv (fun u => periodicBondEnergy φ L u y closing) x =
      -(-deriv (fun u => periodicBondEnergy φ L x u closing) y) := by
  have hx := hφ.hasDerivAt.scomp x
    (((hasDerivAt_const x y).sub (hasDerivAt_id x)).add_const (if closing then L else 0))
  have hy := hφ.hasDerivAt.scomp y
    (((hasDerivAt_id y).sub_const x).add_const (if closing then L else 0))
  have hx' : deriv (fun u => periodicBondEnergy φ L u y closing) x =
      -deriv φ (y-x + if closing then L else 0) := by
    simpa [periodicBondEnergy, Function.comp_def] using hx.deriv
  have hy' : deriv (fun u => periodicBondEnergy φ L x u closing) y =
      deriv φ (y-x + if closing then L else 0) := by
    simpa [periodicBondEnergy, Function.comp_def] using hy.deriv
  rw [hx',hy']
```
### 实际依赖 MolecularDynamics.boxPeriodicNearestNeighborPotentialEnergy
```lean
noncomputable def boxPeriodicNearestNeighborPotentialEnergy {N : ℕ}
    (φ : ℝ → ℝ) (L : ℝ) (x : Fin (N + 1) → ℝ) : ℝ :=
  nearestNeighborPotentialEnergy φ x + φ ‖L + x 0 - x (Fin.last N)‖
```
### 实际依赖 MolecularDynamics.nearestNeighborPotentialEnergy
```lean
noncomputable def nearestNeighborPotentialEnergy {N : ℕ}
    (φ : ℝ → ℝ) (x : Fin (N + 1) → ℝ) : ℝ :=
  ∑ i : Fin N, φ ‖x i.succ - x i.castSucc‖
```
### 实际依赖 MD.Ch01.periodicBondEnergy
```lean
def periodicBondEnergy (φ : ℝ → ℝ) (L : ℝ) (x y : ℝ) (closing : Bool) : ℝ :=
  φ (y-x + if closing then L else 0)
```

## 原文JSON
```json
{
  "source_id": "MD-1.6-RegularLatticeMinimizerLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6",
  "printed_page": "34",
  "pdf_page": "57",
  "statement_latex": "An obvious benefit of using periodic boundary conditions is that, with a uniform pair potential, the energy minimizers are points of a regular lattice; with confining potentials this is unlikely to be the case.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "对任意uniform φ断言规则格点极小不成立：φ=0时任何非均匀位置都最小；还缺势凸性、排斥、顺序/域资格。"
    }
  ],
  "lean_decl": "MD.Ch01.regularlatticeminimizerliteral",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-157"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem regularlatticeminimizerliteral :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ), 0 < L →
    ∀ x : Fin (N+1) → ℝ,
    (∀ y : Fin (N+1) → ℝ, boxPeriodicNearestNeighborPotentialEnergy φ L x ≤
      boxPeriodicNearestNeighborPotentialEnergy φ L y) →
    ∃ a : ℝ, regularLattice a (L/(N+1)) x := by
  sorry

/-- 修正版，对应原文 MD-1.6-RegularLatticeMinimizerLiteral，改动：改为一维周期有序粒子的正间距和L固定、严格凸最近邻势；Jensen给等间距最小且仅等间距等号。 -/
theorem regularlatticeminimizerliteral_corrected (N : ℕ) (φ : ℝ → ℝ)
    (L : ℝ) (hL : 0 < L) (hφ : StrictConvexOn ℝ (Ioi 0) φ) :
    let d := L / (N+1)
    ∀ gaps : Fin (N+1) → ℝ, (∀ i, 0 < gaps i) → (∑ i, gaps i) = L →
      (N+1 : ℝ) * φ d ≤ ∑ i, φ (gaps i) ∧
      ((∑ i, φ (gaps i)) = (N+1 : ℝ) * φ d ↔ ∀ i, gaps i = d) := by
  dsimp only
  intro gaps hg hs
  have hc : 0 < (N+1 : ℝ) := by positivity
  have hw : (∑ _ : Fin (N+1), (N+1 : ℝ)⁻¹) = 1 := by
    simp [Nat.cast_add, Nat.cast_one, hc.ne']
  have hm : (∑ i, (N+1 : ℝ)⁻¹ * gaps i) = L/(N+1) := by
    rw [← Finset.mul_sum,hs]
    ring
  have hv : (∑ i, (N+1 : ℝ)⁻¹ * φ (gaps i)) = (∑ i,φ (gaps i))/(N+1) := by
    rw [← Finset.mul_sum]
    ring
  have hpos : ∀ i ∈ (Finset.univ : Finset (Fin (N+1))), 0 < (N+1 : ℝ)⁻¹ :=
    fun _ _ => inv_pos.mpr hc
  have hmem : ∀ i ∈ (Finset.univ : Finset (Fin (N+1))), gaps i ∈ Ioi (0 : ℝ) :=
    fun i _ => hg i
  have hi := hφ.convexOn.map_sum_le (fun i hi => (hpos i hi).le) hw hmem
  have he := hφ.map_sum_eq_iff hpos hw hmem
  simp only [smul_eq_mul] at hi he
  rw [hm,hv] at hi he
  refine ⟨?_,?_⟩
  · simpa [mul_comm] using (le_div_iff₀ hc).mp hi
  · constructor
    · intro hh
      have hh' : φ (L/(N+1)) = (∑ i,φ (gaps i))/(N+1) := by
        apply (eq_div_iff hc.ne').mpr
        nlinarith
      exact fun i => he.mp hh' i (Finset.mem_univ i)
    · intro hh
      have hh' : φ (L/(N+1)) = (∑ i,φ (gaps i))/(N+1) :=
        he.mpr (by simpa using hh)
      have := (eq_div_iff hc.ne').mp hh'
      nlinarith

theorem regularlatticeminimizerliteral_counterexample :
    (∀ x y : Fin 2 → ℝ,
      boxPeriodicNearestNeighborPotentialEnergy (fun _ => 0) 1 x ≤
      boxPeriodicNearestNeighborPotentialEnergy (fun _ => 0) 1 y) ∧
    ¬ ∃ a : ℝ, regularLattice a (1/2) (fun _ : Fin 2 => 0) := by
  constructor
  · intro x y; simp [boxPeriodicNearestNeighborPotentialEnergy,nearestNeighborPotentialEnergy]
  · rintro ⟨a,ha⟩
    have h0 := ha.2 (0 : Fin 2)
    have h1 := ha.2 (1 : Fin 2)
    norm_num at h0 h1
    linarith
```
### 实际依赖 MolecularDynamics.boxPeriodicNearestNeighborPotentialEnergy
```lean
noncomputable def boxPeriodicNearestNeighborPotentialEnergy {N : ℕ}
    (φ : ℝ → ℝ) (L : ℝ) (x : Fin (N + 1) → ℝ) : ℝ :=
  nearestNeighborPotentialEnergy φ x + φ ‖L + x 0 - x (Fin.last N)‖
```
### 实际依赖 MolecularDynamics.nearestNeighborPotentialEnergy
```lean
noncomputable def nearestNeighborPotentialEnergy {N : ℕ}
    (φ : ℝ → ℝ) (x : Fin (N + 1) → ℝ) : ℝ :=
  ∑ i : Fin N, φ ‖x i.succ - x i.castSucc‖
```
### 实际依赖 MD.Ch01.regularLattice
```lean
def regularLattice {N : ℕ} (a δ : ℝ) (x : Fin N → ℝ) : Prop :=
  0 < δ ∧ ∀ i, x i = a + i.val*δ
```

## 原文JSON
```json
{
  "source_id": "MD-1.6-PeriodicImages",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "35",
  "pdf_page": "58",
  "statement_latex": "periodic boundary conditions involve an extended potential energy of the form\n\\[U^{\\mathrm{pbc}}(\\boldsymbol q)=\\sum_{klm}\\sum_{i=1}^{N-1}\\sum_{j=i+1}^{N}\\varphi_{ij}(\\boldsymbol q_i,\\boldsymbol q_j+k\\boldsymbol v_1+l\\boldsymbol v_2+m\\boldsymbol v_3),\\]\nwhere $k,l,m$ run over $-1,0,1$ (in case interactions are restricted to the simulation cell and its immediate neighboring copies), and $\\boldsymbol v_i^T=(L\\boldsymbol e_i^T,\\ldots,L\\boldsymbol e_i^T)$, $i=1,2,3$, where $\\boldsymbol e_i$ is the $i$th Euclidean basis vector in $\\mathbb R^3$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "Fin3索引减1枚举-1,0,1；逐原子3向量加L(k,l,m)，等价全配置向量重复位移。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.periodicImageEnergy",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-158"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def periodicImageEnergy {N : ℕ} (L : ℝ) (φ : Fin N → Fin N → twoBodyTerms)
    (q : Fin N → V3) :=
  ∑ k : Fin 3, ∑ l : Fin 3, ∑ m : Fin 3, ∑ i, ∑ j ∈ Finset.Ioi i,
    φ i j (q i) (q j + WithLp.toLp 2 ![L*((k.val:ℝ)-1),L*((l.val:ℝ)-1),L*((m.val:ℝ)-1)])
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.periodicImageEnergy
```lean
def periodicImageEnergy {N : ℕ} (L : ℝ) (φ : Fin N → Fin N → twoBodyTerms)
    (q : Fin N → V3) :=
  ∑ k : Fin 3, ∑ l : Fin 3, ∑ m : Fin 3, ∑ i, ∑ j ∈ Finset.Ioi i,
    φ i j (q i) (q j + WithLp.toLp 2 ![L*((k.val:ℝ)-1),L*((l.val:ℝ)-1),L*((m.val:ℝ)-1)])
```
### 实际依赖 MolecularDynamics.Chapter01Review.twoBodyTerms
```lean
abbrev twoBodyTerms := V3 → V3 → ℝ
```

## 原文JSON
```json
{
  "source_id": "MD-1.6-MinimumImage",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "35",
  "pdf_page": "58",
  "statement_latex": "The minimum image convention states that, in computing the force, a given atom interacts only with the nearest replica of any other atom.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "L>0，minimumImage只定义最近复制体关系，不断言任意选择同一atom自作用。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.minimumImage",
  "extra_assumptions": [
    "[EXTRA] 19号：最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。"
  ],
  "old_ids": [
    "CH01-159"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def minimumImage (L : ℝ) (q r image : V3) : Prop :=
  ∃ k : Fin 3 → ℤ, image = r + WithLp.toLp 2 (fun i => L*k i) ∧
    ∀ l : Fin 3 → ℤ, ‖q-image‖ ≤ ‖q-(r+WithLp.toLp 2 (fun i => L*l i))‖

def minimumImageForce {N : ℕ} (L : ℝ) (q : Fin N → V3)
    (image : Fin N → Fin N → V3) (pairForce : Fin N → Fin N → V3 → V3 → V3)
    (force : Fin N → V3) : Prop :=
  0 < L ∧ (∀ i j, i ≠ j → minimumImage L (q i) (q j) (image i j)) ∧
    ∀ i, force i = ∑ j ∈ Finset.univ.erase i, pairForce i j (q i) (image i j)
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.minimumImage
```lean
def minimumImage (L : ℝ) (q r image : V3) : Prop :=
  ∃ k : Fin 3 → ℤ, image = r + WithLp.toLp 2 (fun i => L*k i) ∧
    ∀ l : Fin 3 → ℤ, ‖q-image‖ ≤ ‖q-(r+WithLp.toLp 2 (fun i => L*l i))‖
```
### 实际依赖 MD.Ch01.minimumImageForce
```lean
def minimumImageForce {N : ℕ} (L : ℝ) (q : Fin N → V3)
    (image : Fin N → Fin N → V3) (pairForce : Fin N → Fin N → V3 → V3 → V3)
    (force : Fin N → V3) : Prop :=
  0 < L ∧ (∀ i j, i ≠ j → minimumImage L (q i) (q j) (image i j)) ∧
    ∀ i, force i = ∑ j ∈ Finset.univ.erase i, pairForce i j (q i) (image i j)
```

## 原文JSON
```json
{
  "source_id": "MD-1.6-RhombicLattice",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "35",
  "pdf_page": "58",
  "statement_latex": "In 2D, the typical geometry observed at low temperature is defined by a rhombic lattice, with sides of fixed length $n_x,n_y$ and the angle between them ($\\theta$), see Fig. 1.17.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "a=nx,b=ny；定义只编码基向量Z线性组合，不声称低温平衡一定如此。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.rhombicLattice",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-160"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rhombicLattice (a b θ : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.rhombicLattice
```lean
def rhombicLattice (a b θ : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}
```

## 原文JSON
```json
{
  "source_id": "MD-1.6-UnitCell",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "35",
  "pdf_page": "58",
  "statement_latex": "The unit cell is a description of the arrangement of atoms within a box; unit cells may be stacked in each direction to describe an atomic lattice.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "B为三基向量矩阵，motif为盒内点集；定义按整数平移重复。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.unitCellLattice",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-162"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def unitCellLattice (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Set V3 :=
  {q | ∃ k : Fin 3 → ℤ, ∃ u ∈ motif,
    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.unitCellLattice
```lean
def unitCellLattice (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Set V3 :=
  {q | ∃ k : Fin 3 → ℤ, ∃ u ∈ motif,
    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}
```

## 原文JSON
```json
{
  "source_id": "MD-1.6-FCCStacking",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "36",
  "pdf_page": "59",
  "statement_latex": "The fcc lattice corresponds to the common arrangement by which cannonballs are stacked into pyramidal structures; it can be viewed as a periodic stacking (ABCABC. . . ) of three hexagonally structured planar layers, as illustrated in Fig. 1.18.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.fccStacking",
  "extra_assumptions": [
    "将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。"
  ],
  "old_ids": [
    "CH01-164"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def fccStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 3
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.fccStacking
```lean
def fccStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 3
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```
### 实际依赖 MolecularDynamics.Chapter01Review.triangularLayer
```lean
def triangularLayer (u v : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k+l/2+u,l*Real.sqrt 3/2+v]}
```
