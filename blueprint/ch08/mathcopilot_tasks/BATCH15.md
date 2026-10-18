# BATCH15 第8章原文与陈述审校

## MD-8.9.1-DPDSoftPotential
```json
{
  "source_id": "MD-8.9.1-DPDSoftPotential",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.9.1",
  "printed_page": "387–388",
  "pdf_page": "408–409",
  "statement_latex": "rᵢⱼ=|qᵢ−qⱼ|, eᵢⱼ=(qᵢ−qⱼ)/rᵢⱼ. Fᶜᵢⱼ=α(1−rᵢⱼ/r_c)eᵢⱼ for rᵢⱼ<r_c, zero otherwise; φ_DPD=(αr_c/2)(1−r/r_c)² below cutoff, U=Σᵢ<ⱼφ(rᵢⱼ). (8.80)–(8.84).",
  "statement_verbatim": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n387\nOne of the most popular scheme of this type is the technique of dissipative\nparticle dynamics (DPD) which was introduced in 1992 by Hoogerbrugge and\nKoelman [181]. DPD groups several ﬂuid molecules and treats these as a single\nparticle (which may be thought of as a lump of ﬂuid). The particles of a DPD system\ninteract through a short-ranged “soft” pairwise (distance-based) potential energy\nfunction. The use of such a soft potential increases the usable timestep, thus the\nbeneﬁt of using DPD as opposed to MD is felt both in reduction of system dimension\nand increase in the timestep and thus the accessible time interval in simulation [156].\nDPD can be viewed as a Langevin dynamics in which conﬁguration dependence is\npresent in both dissipative and stochastic perturbations. We will consider numerical\nmethods for DPD in this section; for discussion of coarse-graining applications of\nDPD, see for example [39, 88, 330].\nThe equations of DPD are a little more complicated than standard MD. It is\ntherefore important to design accurate and efﬁcient methods tailored to their special\nform. Most numerical methods for DPD simulation exhibit substantial statistical\nbias. Some methods have been developed to reduce the per timestep efﬁciency but\nat a price in terms of the conservation properties. The only way that the errors are\ntamed in some ad hoc schemes is by reducing the timestep size excessively (well\nbelow the stability threshold), but this may destroy the practical value of those\nmethods.\nIn this section we present numerical methods based on splitting for DPD and\nfor another stochastic momentum-conserving method, the pairwise Nosé-Hoover-\nLangevin (PNHL) method.\n8.9.1\nFormulation of DPD\nWe describe here the formulation of dissipative particle dynamics due to Español\nand Warren [122].\nLet the N particles be described in the usual way by positions qi and momenta pi.\nWe assume their masses to be mi for i D 1; : : : ; N. The DPD equations of motion\nare of the form\ndqi\ndt D pi\nmi\n;\ndpi\ndt D Fi;\n(8.80)\nwhere Fi is the total interparticle force acting on particle i due to the presence of the\nother particles. The force is composed of three pairwise contributions\nFi D\nX\nj¤i\n.FC\nij C FD\nij C FR\nij/;\n(8.81)\nwhere FC\nij, FD\nij and FR\nij represent conservative, dissipative and random forces, acting\non particle i due to the j-th particle, respectively.\n\n388\n8\nExtended Variable Methods\nMany choices are possible for the conservative force ﬁeld [219, 244, 342]. In case\nthe DPD equations are used simply to control the momentum (and not as a coarse-\ngraining device), any empirical molecular force ﬁeld may be used. When DPD is\nused for coarse-graining, it is common to adopt a simpliﬁed pair potential, namely\nFC\nij D\n8\n<\n:\n˛\n\b\n1 \u0003 rij\nrc\n\t\nOqij;\nrij < rcI\n0;\nrij \b rc;\n(8.82)\nwhere rij is the interparticle distance, Oqij D r\u00021\nij .qi \u0003 qj/, parameters ˛ deﬁne\nthe strength of the repulsion of particles i and j, and rc is the cutoff radius. The\nuse of a cutoff is important for efﬁciency reasons—in a large system, only the\nparticles interacting at close range will generate nonzero forces of interaction so\nthe force calculation may be substantially reduced. Both ˛ and rc could be allowed\nto be different for different particle pairs, although they are most often taken to be\nhomogeneous. The pair potential corresponding to the force is\n'DPD.r/ D\n8\nˆ<\nˆ:\n˛rc\n2\n\b\n1 \u0003 r\nrc\n\t2\n;\nr < rcI\n0;\nr \b rc:\n(8.83)\nso that the conservative potential energy is:\nUDPD D\nX\ni<j\n'DPD.rij/;\nrij D kqi \u0003 qjk:\n(8.84)\nThe choice of dissipative and random forces is made so as to maintain a\nprescribed temperature. The typical formulas used for this purpose are\nFD\nij D \u0003\n!D.rij/.Oqij \u0002 vij/Oqij;\n(8.85)\nFR\nij D \u0007!R.rij/\u000eijOqij;\n(8.86)\nwhere \n and \u0007 parameterize the forces (again, they could be taken to be different for\ndifferent pairs), and !D and !R are conﬁguration-dependent weight functions that\ntypically incorporate a cut-off similar to that used in the conservative force, e.g. one\nmay take\n!R.r/ D\n8\n<\n:\n1 \u0003 r\nrc\n;\nr < rcI\n0;\nr \b rc;\n(8.87)\nwhere rc is the same cutoff used in the conservative force. The relative velocities\nare denoted by vij D pi=mi \u0003 pj=mj, and \u000eij is a symmetric (\u000eij D \u000eji) Gaussian\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 408,
      "printed_page": 387,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n387\nOne of the most popular scheme of this type is the technique of dissipative\nparticle dynamics (DPD) which was introduced in 1992 by Hoogerbrugge and\nKoelman [181]. DPD groups several ﬂuid molecules and treats these as a single\nparticle (which may be thought of as a lump of ﬂuid). The particles of a DPD system\ninteract through a short-ranged “soft” pairwise (distance-based) potential energy\nfunction. The use of such a soft potential increases the usable timestep, thus the\nbeneﬁt of using DPD as opposed to MD is felt both in reduction of system dimension\nand increase in the timestep and thus the accessible time interval in simulation [156].\nDPD can be viewed as a Langevin dynamics in which conﬁguration dependence is\npresent in both dissipative and stochastic perturbations. We will consider numerical\nmethods for DPD in this section; for discussion of coarse-graining applications of\nDPD, see for example [39, 88, 330].\nThe equations of DPD are a little more complicated than standard MD. It is\ntherefore important to design accurate and efﬁcient methods tailored to their special\nform. Most numerical methods for DPD simulation exhibit substantial statistical\nbias. Some methods have been developed to reduce the per timestep efﬁciency but\nat a price in terms of the conservation properties. The only way that the errors are\ntamed in some ad hoc schemes is by reducing the timestep size excessively (well\nbelow the stability threshold), but this may destroy the practical value of those\nmethods.\nIn this section we present numerical methods based on splitting for DPD and\nfor another stochastic momentum-conserving method, the pairwise Nosé-Hoover-\nLangevin (PNHL) method.\n8.9.1\nFormulation of DPD\nWe describe here the formulation of dissipative particle dynamics due to Español\nand Warren [122].\nLet the N particles be described in the usual way by positions qi and momenta pi.\nWe assume their masses to be mi for i D 1; : : : ; N. The DPD equations of motion\nare of the form\ndqi\ndt D pi\nmi\n;\ndpi\ndt D Fi;\n(8.80)\nwhere Fi is the total interparticle force acting on particle i due to the presence of the\nother particles. The force is composed of three pairwise contributions\nFi D\nX\nj¤i\n.FC\nij C FD\nij C FR\nij/;\n(8.81)\nwhere FC\nij, FD\nij and FR\nij represent conservative, dissipative and random forces, acting\non particle i due to the j-th particle, respectively.\n"
    },
    {
      "pdf_page": 409,
      "printed_page": 388,
      "text": "388\n8\nExtended Variable Methods\nMany choices are possible for the conservative force ﬁeld [219, 244, 342]. In case\nthe DPD equations are used simply to control the momentum (and not as a coarse-\ngraining device), any empirical molecular force ﬁeld may be used. When DPD is\nused for coarse-graining, it is common to adopt a simpliﬁed pair potential, namely\nFC\nij D\n8\n<\n:\n˛\n\b\n1 \u0003 rij\nrc\n\t\nOqij;\nrij < rcI\n0;\nrij \b rc;\n(8.82)\nwhere rij is the interparticle distance, Oqij D r\u00021\nij .qi \u0003 qj/, parameters ˛ deﬁne\nthe strength of the repulsion of particles i and j, and rc is the cutoff radius. The\nuse of a cutoff is important for efﬁciency reasons—in a large system, only the\nparticles interacting at close range will generate nonzero forces of interaction so\nthe force calculation may be substantially reduced. Both ˛ and rc could be allowed\nto be different for different particle pairs, although they are most often taken to be\nhomogeneous. The pair potential corresponding to the force is\n'DPD.r/ D\n8\nˆ<\nˆ:\n˛rc\n2\n\b\n1 \u0003 r\nrc\n\t2\n;\nr < rcI\n0;\nr \b rc:\n(8.83)\nso that the conservative potential energy is:\nUDPD D\nX\ni<j\n'DPD.rij/;\nrij D kqi \u0003 qjk:\n(8.84)\nThe choice of dissipative and random forces is made so as to maintain a\nprescribed temperature. The typical formulas used for this purpose are\nFD\nij D \u0003\n!D.rij/.Oqij \u0002 vij/Oqij;\n(8.85)\nFR\nij D \u0007!R.rij/\u000eijOqij;\n(8.86)\nwhere \n and \u0007 parameterize the forces (again, they could be taken to be different for\ndifferent pairs), and !D and !R are conﬁguration-dependent weight functions that\ntypically incorporate a cut-off similar to that used in the conservative force, e.g. one\nmay take\n!R.r/ D\n8\n<\n:\n1 \u0003 r\nrc\n;\nr < rcI\n0;\nr \b rc;\n(8.87)\nwhere rc is the same cutoff used in the conservative force. The relative velocities\nare denoted by vij D pi=mi \u0003 pj=mj, and \u000eij is a symmetric (\u000eij D \u000eji) Gaussian\n"
    }
  ],
  "numbered_equations": [
    "8.80",
    "8.81",
    "8.82",
    "8.83",
    "8.84"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "d维Euclidean距离由坐标平方和开方，避免Pi最大范数；只在非碰撞且离开截断接缝的有效域声明梯度关系。N、d为物理正整数，mᵢ>0在动力学资格另列。"
  ],
  "issues": [],
  "statement_scope": "软势、保守成对力/总力与光滑有效域的梯度目标；完整SDE见后条。",
  "lean_decl": "MD.Ch08.pairDistance",
  "lean_declarations": [
    "MD.Ch08.pairDistance",
    "MD.Ch08.pairDirection",
    "MD.Ch08.dpdSoftPotential",
    "MD.Ch08.dpdPairConservative",
    "MD.Ch08.dpdPotential",
    "MD.Ch08.dpdConservative",
    "MD.Ch08.particleGradient",
    "MD.Ch08.dpdConservative_gradient"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pairDistance {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : ℝ :=
  Real.sqrt (dot (q i-q j) (q i-q j))
def pairDirection {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (pairDistance q i j)⁻¹ • (q i-q j)
def dpdSoftPotential (α rc r : ℝ) : ℝ := if r < rc then α*rc/2*(1-r/rc)^2 else 0
def dpdPairConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  if pairDistance q i j < rc then (α*(1-pairDistance q i j/rc)) • pairDirection q i j else 0
def dpdPotential {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ℝ :=
  ∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), dpdSoftPotential α rc (pairDistance q i j)
def dpdConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairConservative α rc q i j
def particleGradient {N d : ℕ} (U : ParticleConfig N d → ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i a ↦ fderiv ℝ U q (Pi.single i (Pi.single a 1))
theorem dpdConservative_gradient {N d : ℕ} (α rc : ℝ) (hα : 0 ≤ α) (hrc : 0 < rc)
    (q : ParticleConfig N d) (hnocoll : ∀ i j, i ≠ j → 0 < pairDistance q i j)
    (hcut : ∀ i j, i ≠ j → pairDistance q i j ≠ rc) :
    dpdConservative α rc q = -particleGradient (dpdPotential α rc) q := by
  sorry
```

## MD-8.9.1-DPDPairForces
```json
{
  "source_id": "MD-8.9.1-DPDPairForces",
  "kind": "definition",
  "label": null,
  "section": "8.9.1",
  "printed_page": "388",
  "pdf_page": "409",
  "statement_latex": "Fᴰᵢⱼ=−γ ωᴰ(rᵢⱼ)(eᵢⱼ·vᵢⱼ)eᵢⱼ, Fᴿᵢⱼ=σ ωᴿ(rᵢⱼ)θᵢⱼeᵢⱼ, ωᴿ(r)=1−r/r_c below cutoff. vᵢⱼ=pᵢ/mᵢ−pⱼ/mⱼ. (8.85)–(8.87).",
  "statement_verbatim": "388\n8\nExtended Variable Methods\nMany choices are possible for the conservative force ﬁeld [219, 244, 342]. In case\nthe DPD equations are used simply to control the momentum (and not as a coarse-\ngraining device), any empirical molecular force ﬁeld may be used. When DPD is\nused for coarse-graining, it is common to adopt a simpliﬁed pair potential, namely\nFC\nij D\n8\n<\n:\n˛\n\b\n1 \u0003 rij\nrc\n\t\nOqij;\nrij < rcI\n0;\nrij \b rc;\n(8.82)\nwhere rij is the interparticle distance, Oqij D r\u00021\nij .qi \u0003 qj/, parameters ˛ deﬁne\nthe strength of the repulsion of particles i and j, and rc is the cutoff radius. The\nuse of a cutoff is important for efﬁciency reasons—in a large system, only the\nparticles interacting at close range will generate nonzero forces of interaction so\nthe force calculation may be substantially reduced. Both ˛ and rc could be allowed\nto be different for different particle pairs, although they are most often taken to be\nhomogeneous. The pair potential corresponding to the force is\n'DPD.r/ D\n8\nˆ<\nˆ:\n˛rc\n2\n\b\n1 \u0003 r\nrc\n\t2\n;\nr < rcI\n0;\nr \b rc:\n(8.83)\nso that the conservative potential energy is:\nUDPD D\nX\ni<j\n'DPD.rij/;\nrij D kqi \u0003 qjk:\n(8.84)\nThe choice of dissipative and random forces is made so as to maintain a\nprescribed temperature. The typical formulas used for this purpose are\nFD\nij D \u0003\n!D.rij/.Oqij \u0002 vij/Oqij;\n(8.85)\nFR\nij D \u0007!R.rij/\u000eijOqij;\n(8.86)\nwhere \n and \u0007 parameterize the forces (again, they could be taken to be different for\ndifferent pairs), and !D and !R are conﬁguration-dependent weight functions that\ntypically incorporate a cut-off similar to that used in the conservative force, e.g. one\nmay take\n!R.r/ D\n8\n<\n:\n1 \u0003 r\nrc\n;\nr < rcI\n0;\nr \b rc;\n(8.87)\nwhere rc is the same cutoff used in the conservative force. The relative velocities\nare denoted by vij D pi=mi \u0003 pj=mj, and \u000eij is a symmetric (\u000eij D \u000eji) Gaussian\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 409,
      "printed_page": 388,
      "text": "388\n8\nExtended Variable Methods\nMany choices are possible for the conservative force ﬁeld [219, 244, 342]. In case\nthe DPD equations are used simply to control the momentum (and not as a coarse-\ngraining device), any empirical molecular force ﬁeld may be used. When DPD is\nused for coarse-graining, it is common to adopt a simpliﬁed pair potential, namely\nFC\nij D\n8\n<\n:\n˛\n\b\n1 \u0003 rij\nrc\n\t\nOqij;\nrij < rcI\n0;\nrij \b rc;\n(8.82)\nwhere rij is the interparticle distance, Oqij D r\u00021\nij .qi \u0003 qj/, parameters ˛ deﬁne\nthe strength of the repulsion of particles i and j, and rc is the cutoff radius. The\nuse of a cutoff is important for efﬁciency reasons—in a large system, only the\nparticles interacting at close range will generate nonzero forces of interaction so\nthe force calculation may be substantially reduced. Both ˛ and rc could be allowed\nto be different for different particle pairs, although they are most often taken to be\nhomogeneous. The pair potential corresponding to the force is\n'DPD.r/ D\n8\nˆ<\nˆ:\n˛rc\n2\n\b\n1 \u0003 r\nrc\n\t2\n;\nr < rcI\n0;\nr \b rc:\n(8.83)\nso that the conservative potential energy is:\nUDPD D\nX\ni<j\n'DPD.rij/;\nrij D kqi \u0003 qjk:\n(8.84)\nThe choice of dissipative and random forces is made so as to maintain a\nprescribed temperature. The typical formulas used for this purpose are\nFD\nij D \u0003\n!D.rij/.Oqij \u0002 vij/Oqij;\n(8.85)\nFR\nij D \u0007!R.rij/\u000eijOqij;\n(8.86)\nwhere \n and \u0007 parameterize the forces (again, they could be taken to be different for\ndifferent pairs), and !D and !R are conﬁguration-dependent weight functions that\ntypically incorporate a cut-off similar to that used in the conservative force, e.g. one\nmay take\n!R.r/ D\n8\n<\n:\n1 \u0003 r\nrc\n;\nr < rcI\n0;\nr \b rc;\n(8.87)\nwhere rc is the same cutoff used in the conservative force. The relative velocities\nare denoted by vij D pi=mi \u0003 pj=mj, and \u000eij is a symmetric (\u000eij D \u000eji) Gaussian\n"
    }
  ],
  "numbered_equations": [
    "8.85",
    "8.86",
    "8.87"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "白噪声θᵢⱼ不作为逐点函数使用；随机力的实际意义是下一条无序对独立Wiener驱动、双方相反的扩散向量。总化r=0只作辅助，在动力学中要求非碰撞。"
  ],
  "issues": [],
  "statement_scope": "全部成对/总耗散力、软随机权与成对守恒扩散方向。",
  "lean_decl": "MD.Ch08.dpdWeightR",
  "lean_declarations": [
    "MD.Ch08.dpdWeightR",
    "MD.Ch08.relativeVelocity",
    "MD.Ch08.dpdPairDissipative",
    "MD.Ch08.dpdPairRandom",
    "MD.Ch08.dpdDissipative",
    "MD.Ch08.pairImpulseVector",
    "MD.Ch08.dpdNoise"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def dpdWeightR (rc r : ℝ) : ℝ := if r < rc then 1-r/rc else 0
def relativeVelocity {N d : ℕ} (m : Fin N → ℝ) (p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (m i)⁻¹ • p i-(m j)⁻¹ • p j
def dpdPairDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (-γ*wD (pairDistance q i j)*dot (pairDirection q i j) (relativeVelocity m p i j)) • pairDirection q i j
def dpdPairRandom {N d : ℕ} (σ : ℝ) (wR : ℝ → ℝ) (q : ParticleConfig N d)
    (i j : Fin N) (R : ℝ) : Vec d := (σ*wR (pairDistance q i j)*R) • pairDirection q i j
def dpdDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairDissipative m γ wD q p i j
def pairImpulseVector {N d : ℕ} (i j : Fin N) (v : Vec d) : ParticleConfig N d :=
  Pi.single i v-Pi.single j v
def dpdNoise {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ) (wR : ℝ → ℝ)
    (q : ParticleConfig N d) (k : Fin K) : ParticlePhase N d :=
  (0,pairImpulseVector (pairs k).1 (pairs k).2
    ((σ*wR (pairDistance q (pairs k).1 (pairs k).2)) • pairDirection q (pairs k).1 (pairs k).2))
```

## MD-8.9.1-DPDPairWiener
```json
{
  "source_id": "MD-8.9.1-DPDPairWiener",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.9.1",
  "printed_page": "388–389",
  "pdf_page": "409–410",
  "statement_latex": "θᵢⱼ=θⱼᵢ; E θᵢⱼ=0 and E[θᵢⱼ(t)θₖₗ(t′)]=(δᵢₖδⱼₗ+δᵢₗδⱼₖ)δ(t−t′). Distinct unordered pairs are independent. (8.88).",
  "statement_verbatim": "388\n8\nExtended Variable Methods\nMany choices are possible for the conservative force ﬁeld [219, 244, 342]. In case\nthe DPD equations are used simply to control the momentum (and not as a coarse-\ngraining device), any empirical molecular force ﬁeld may be used. When DPD is\nused for coarse-graining, it is common to adopt a simpliﬁed pair potential, namely\nFC\nij D\n8\n<\n:\n˛\n\b\n1 \u0003 rij\nrc\n\t\nOqij;\nrij < rcI\n0;\nrij \b rc;\n(8.82)\nwhere rij is the interparticle distance, Oqij D r\u00021\nij .qi \u0003 qj/, parameters ˛ deﬁne\nthe strength of the repulsion of particles i and j, and rc is the cutoff radius. The\nuse of a cutoff is important for efﬁciency reasons—in a large system, only the\nparticles interacting at close range will generate nonzero forces of interaction so\nthe force calculation may be substantially reduced. Both ˛ and rc could be allowed\nto be different for different particle pairs, although they are most often taken to be\nhomogeneous. The pair potential corresponding to the force is\n'DPD.r/ D\n8\nˆ<\nˆ:\n˛rc\n2\n\b\n1 \u0003 r\nrc\n\t2\n;\nr < rcI\n0;\nr \b rc:\n(8.83)\nso that the conservative potential energy is:\nUDPD D\nX\ni<j\n'DPD.rij/;\nrij D kqi \u0003 qjk:\n(8.84)\nThe choice of dissipative and random forces is made so as to maintain a\nprescribed temperature. The typical formulas used for this purpose are\nFD\nij D \u0003\n!D.rij/.Oqij \u0002 vij/Oqij;\n(8.85)\nFR\nij D \u0007!R.rij/\u000eijOqij;\n(8.86)\nwhere \n and \u0007 parameterize the forces (again, they could be taken to be different for\ndifferent pairs), and !D and !R are conﬁguration-dependent weight functions that\ntypically incorporate a cut-off similar to that used in the conservative force, e.g. one\nmay take\n!R.r/ D\n8\n<\n:\n1 \u0003 r\nrc\n;\nr < rcI\n0;\nr \b rc;\n(8.87)\nwhere rc is the same cutoff used in the conservative force. The relative velocities\nare denoted by vij D pi=mi \u0003 pj=mj, and \u000eij is a symmetric (\u000eij D \u000eji) Gaussian\n\n8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 409,
      "printed_page": 388,
      "text": "388\n8\nExtended Variable Methods\nMany choices are possible for the conservative force ﬁeld [219, 244, 342]. In case\nthe DPD equations are used simply to control the momentum (and not as a coarse-\ngraining device), any empirical molecular force ﬁeld may be used. When DPD is\nused for coarse-graining, it is common to adopt a simpliﬁed pair potential, namely\nFC\nij D\n8\n<\n:\n˛\n\b\n1 \u0003 rij\nrc\n\t\nOqij;\nrij < rcI\n0;\nrij \b rc;\n(8.82)\nwhere rij is the interparticle distance, Oqij D r\u00021\nij .qi \u0003 qj/, parameters ˛ deﬁne\nthe strength of the repulsion of particles i and j, and rc is the cutoff radius. The\nuse of a cutoff is important for efﬁciency reasons—in a large system, only the\nparticles interacting at close range will generate nonzero forces of interaction so\nthe force calculation may be substantially reduced. Both ˛ and rc could be allowed\nto be different for different particle pairs, although they are most often taken to be\nhomogeneous. The pair potential corresponding to the force is\n'DPD.r/ D\n8\nˆ<\nˆ:\n˛rc\n2\n\b\n1 \u0003 r\nrc\n\t2\n;\nr < rcI\n0;\nr \b rc:\n(8.83)\nso that the conservative potential energy is:\nUDPD D\nX\ni<j\n'DPD.rij/;\nrij D kqi \u0003 qjk:\n(8.84)\nThe choice of dissipative and random forces is made so as to maintain a\nprescribed temperature. The typical formulas used for this purpose are\nFD\nij D \u0003\n!D.rij/.Oqij \u0002 vij/Oqij;\n(8.85)\nFR\nij D \u0007!R.rij/\u000eijOqij;\n(8.86)\nwhere \n and \u0007 parameterize the forces (again, they could be taken to be different for\ndifferent pairs), and !D and !R are conﬁguration-dependent weight functions that\ntypically incorporate a cut-off similar to that used in the conservative force, e.g. one\nmay take\n!R.r/ D\n8\n<\n:\n1 \u0003 r\nrc\n;\nr < rcI\n0;\nr \b rc;\n(8.87)\nwhere rc is the same cutoff used in the conservative force. The relative velocities\nare denoted by vij D pi=mi \u0003 pj=mj, and \u000eij is a symmetric (\u000eij D \u000eji) Gaussian\n"
    },
    {
      "pdf_page": 410,
      "printed_page": 389,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n"
    }
  ],
  "numbered_equations": [
    "8.88"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "只对无序对使用独立标准Wiener；Wᵢⱼ=Wⱼᵢ由同一坐标实现，不能把有序对全部设独立。Dirac白噪声公式通过有限时间增量协方差表达。"
  ],
  "issues": [],
  "statement_scope": "对称噪声增量和对应所印δ协方差的积分版本。",
  "lean_decl": "MD.Ch08.pairEnumeration",
  "lean_declarations": [
    "MD.Ch08.pairEnumeration",
    "MD.Ch08.pairNoiseIncrement",
    "MD.Ch08.pairNoiseIncrement_symmetric",
    "MD.Ch08.pairNoiseIncrement_covariance"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pairEnumeration {N K : ℕ} (pairs : Fin K → Fin N × Fin N) : Prop :=
  (∀ k, (pairs k).1 < (pairs k).2) ∧ Function.Injective pairs ∧
  ∀ i j, i < j → ∃ k, pairs k=(i,j)
def pairNoiseIncrement {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) (sample : Ω) : ℝ :=
  ∑ k, if pairs k=(i,j) ∨ pairs k=(j,i) then W t sample k-W s sample k else 0
theorem pairNoiseIncrement_symmetric {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) :
    pairNoiseIncrement pairs W s t i j=pairNoiseIncrement pairs W s t j i := by
  sorry
theorem pairNoiseIncrement_covariance {N K : ℕ} (P : Measure Ω)
    (pairs : Fin K → Fin N × Fin N) (he : pairEnumeration pairs)
    (W : ℝ → Ω → Vec K) (hW : independentWiener P K W)
    (s t : ℝ) (hs : 0 ≤ s) (hst : s ≤ t) (i j k l : Fin N) (hij : i ≠ j) (hkl : k ≠ l) :
    (∫ sample, pairNoiseIncrement pairs W s t i j sample*pairNoiseIncrement pairs W s t k l sample ∂P)=
      if (i=k ∧ j=l) ∨ (i=l ∧ j=k) then t-s else 0 := by
  sorry
```

## MD-8.9.1-DPDIntegralSystem
```json
{
  "source_id": "MD-8.9.1-DPDIntegralSystem",
  "kind": "definition",
  "label": null,
  "section": "8.9.1",
  "printed_page": "389",
  "pdf_page": "410",
  "statement_latex": "dq=M⁻¹pdt, dp=−∇Udt−Δ(q)pdt+Σ(q)dW. (8.90).",
  "statement_verbatim": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 410,
      "printed_page": 389,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n"
    }
  ],
  "numbered_equations": [
    "8.80",
    "8.81",
    "8.90"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "实际多维独立Wiener、共同自然历史适应、联合可测、路径连续、漂移可积、所有网格左和及积分代表L²均明示。",
    "选择强L²、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。"
  ],
  "issues": [],
  "statement_scope": "配置依赖扩散的真实积分解规格及正质量/涨落耗散/无序噪声资格。",
  "lean_decl": "MD.Ch08.strictItoIntegral8",
  "lean_declarations": [
    "MD.Ch08.strictItoIntegral8",
    "MD.Ch08.multiplicativeSDE8",
    "MD.Ch08.dpdDrift",
    "MD.Ch08.isDPDSolution"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def strictItoIntegral8 (P : Measure Ω) (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ k, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T k) 2 P) ∧ MemLp Y 2 P ∧
  Tendsto (fun k ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T k sample-Y sample)^2 ∂P)
    atTop (𝓝 0)
def multiplicativeSDE8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [MeasurableSpace E] [BorelSpace E] (P : Measure Ω) (r : ℕ)
    (W : ℝ → Ω → Vec r) (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : E → Fin r → E) : Prop :=
  independentWiener P r W ∧ Measurable (Function.uncurry X) ∧ (∀ j, Measurable (fun x ↦ B x j)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ T, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 T) ∧
    ∀ ell : E →L[ℝ] ℝ, ∃ Y : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral8 P (fun s sample ↦ W s sample j)
        (fun s sample ↦ ell (B (X s sample) j)) T (Y j)) ∧
      ∀ᵐ sample ∂P, ell (X T sample-x0-(∫ s in (0 : ℝ)..T, a (X s sample)))=∑ j, Y j sample
def dpdDrift {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),dpdConservative α rc z.1+dpdDissipative m γ wD z.1 z.2)
def isDPDSolution {N d K : ℕ} (m : Fin N → ℝ) (α rc γ σ θ : ℝ) (wD wR : ℝ → ℝ)
    (pairs : Fin K → Fin N × Fin N) (P : Measure Ω) (W : ℝ → Ω → Vec K)
    (X : ℝ → Ω → ParticlePhase N d) (x0 : ParticlePhase N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 ≤ α ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ r, wD r=(wR r)^2) ∧ σ^2=2*γ*θ ∧ pairEnumeration pairs ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1 i j) ∧
  multiplicativeSDE8 P K W X x0 (dpdDrift m α rc γ wD)
    (fun z ↦ dpdNoise pairs σ wR z.1)
```

## MD-8.9.1-DPDCanonicalLeaf
```json
{
  "source_id": "MD-8.9.1-DPDCanonicalLeaf",
  "kind": "definition",
  "label": null,
  "section": "8.9.1",
  "printed_page": "389",
  "pdf_page": "410",
  "statement_latex": "ωᴰ=(ωᴿ)², σ²=2γk_BT. The canonical density is restricted to fixed total momentum π by δ(Σp−π). (8.89).",
  "statement_verbatim": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 410,
      "printed_page": 389,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n"
    }
  ],
  "numbered_equations": [
    "8.89"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "Dirac乘积解释为指定动量叶上的参考测度，未伪造Lebesgue密度；参考测度需另指定几何/周期体积。",
    "只是权重与概率资格目标；DPD保持该测度、流体力学保持及高密度一维遍历性的大型定理均列缺口。"
  ],
  "issues": [],
  "statement_scope": "涨落耗散资格、动量约束叶及其可归一canonical测度定义。",
  "lean_decl": "MD.Ch08.dpdFluctuationDissipation",
  "lean_declarations": [
    "MD.Ch08.dpdFluctuationDissipation",
    "MD.Ch08.momentumLeaf",
    "MD.Ch08.particleHamiltonian",
    "MD.Ch08.momentumCanonical",
    "MD.Ch08.momentumCanonicalQualification"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def dpdFluctuationDissipation (γ σ θ : ℝ) (wD wR : ℝ → ℝ) : Prop :=
  0 ≤ γ ∧ 0 < θ ∧ σ^2=2*γ*θ ∧ ∀ r, wD r=(wR r)^2
def momentumLeaf {N d : ℕ} (π : Vec d) : Set (ParticlePhase N d) :=
  {z | totalMomentum z.2=π}
def particleHamiltonian {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (z : ParticlePhase N d) : ℝ := (∑ i, dot (z.2 i) (z.2 i)/(2*m i))+U z.1
def momentumCanonical {N d : ℕ} (ν : Measure (ParticlePhase N d)) (m : Fin N → ℝ)
    (U : ParticleConfig N d → ℝ) (β : ℝ) : Measure (ParticlePhase N d) :=
  ν.withDensity (fun z ↦ ENNReal.ofReal (Real.exp (-β*particleHamiltonian m U z)/
    (∫ x, Real.exp (-β*particleHamiltonian m U x) ∂ν)))
def momentumCanonicalQualification {N d : ℕ} (ν : Measure (ParticlePhase N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ν (momentumLeaf π)ᶜ=0 ∧
  Integrable (fun z ↦ Real.exp (-β*particleHamiltonian m U z)) ν ∧
  (0 < ∫ z, Real.exp (-β*particleHamiltonian m U z) ∂ν) ∧
  IsProbabilityMeasure (momentumCanonical ν m U β)
```

## MD-8.9.1-DPDMassOrderPrinted
```json
{
  "source_id": "MD-8.9.1-DPDMassOrderPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.9.1",
  "printed_page": "389",
  "pdf_page": "410",
  "statement_latex": "For dp=−∇Udt−Δ(q)pdt+Σ(q)dW, the book gives Δ=M⁻¹ΣΣᵀ/(2k_BT).",
  "statement_verbatim": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 410,
      "printed_page": 389,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "M应正定、θ>0；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。"
  ],
  "issues": [
    "已目视核对原页PDF410：对动量漂移−Δp、动量协方差k_BT M，应为Δ=ΣΣᵀM⁻¹/(2k_BT)；原印左乘仅在相应矩阵可交换（如等质量）时一致。两粒子不等质量的矩阵反例已证。"
  ],
  "statement_scope": "原印/校正的质量矩阵次序及具体代数反例。",
  "lean_decl": "MD.Ch08.dpdMatrixFDPrinted",
  "lean_declarations": [
    "MD.Ch08.dpdMatrixFDPrinted",
    "MD.Ch08.dpdMatrixFD_corrected",
    "MD.Ch08.dpdMassOrder_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def dpdMatrixFDPrinted {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • (M⁻¹*(B*B.transpose))
def dpdMatrixFD_corrected {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • ((B*B.transpose)*M⁻¹)
theorem dpdMassOrder_counterexample :
    (!![1,0;0,(1/2 : ℝ)]) * (!![1,-1;-1,1]) ≠
      (!![1,-1;-1,1]) * (!![1,0;0,(1/2 : ℝ)]) := by
  intro h
  have hh := congrArg (fun A : Matrix (Fin 2) (Fin 2) ℝ ↦ A 0 1) h
  norm_num [Matrix.mul_apply,Fin.sum_univ_two] at hh
```
