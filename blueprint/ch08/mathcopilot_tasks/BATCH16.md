# BATCH16 第8章原文与陈述审校

## MD-8.9.2-DPDVelocityVerlet
```json
{
  "source_id": "MD-8.9.2-DPDVelocityVerlet",
  "kind": "algorithm",
  "label": null,
  "section": "8.9.2",
  "printed_page": "389–391",
  "pdf_page": "410–412",
  "statement_latex": "p½=p+hFᶜ(q)/2+hFᴰ(q,p)/2+√h Fᴿ(q,Rold)/2; q'=q+hM⁻¹p½; p'=p½+hFᶜ(q')/2+hFᴰ(q',p½)/2+√h Fᴿ(q',Rnew)/2. Reuse Rnew next step. (8.91)–(8.93).",
  "statement_verbatim": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n\n390\n8\nExtended Variable Methods\n8.9.2\nNumerical Treatment of the DPD System\nIn comparing the DPD system to standard molecular dynamics, a key feature is the\n“soft” nature of the repulsive potential UDPD deﬁned by (8.84). The lack of any sort\nof stiff harmonic component or steep repulsive potentials such as those present in\ntypical molecular models means that the stepsize is not dominated by the stability\nrestriction, but rather by accuracy requirements. That is, DPD simulations may be\nstable for stepsizes which lead to very large errors in thermodynamic averages.\nMany efforts have been made to develop accurate integration schemes for the\nDPD system. With few exceptions, the methods used are variants of the velocity-\nVerlet integrator, owing to its long history in MD. Some early integration schemes\nare to be found in the papers of Groot and Warren [157], Gibson et al. [148], and\nBesold et al. [34, 385]. The latter work describes the so-called DPD-Velocity Verlet\n(DPD-VV) method. Unfortunately [34, 385], all of these methods exhibit signiﬁcant\nsimulation errors for large stepsize. Much of the error can be seen as the result of\nrequiring an explicit treatment of the dissipative terms, for reasons of computational\nefﬁciency. More accurate schemes are possible by using implicit (or semi-implicit)\nmethods such the self-consistent leap-frog integrator (see [34, 295]). However, these\nmethods are typically much slower than the simpler, explicit methods [73, 281], the\nconsequence being that the simpler DPD-VV is most often used (with a relatively\nsmall timestep). Further alternatives to the DPD-VV method include a scheme of\nden Otter and Clarke [101], splitting methods (Shardlow [333], De Fabritiis et al.\n[96] and Thalmann and Farago [363]), and multiple time step schemes of Jakobsen\net al. [191].\n8.9.2.1\nDPD Velocity-Verlet\nWith integration stepsize h, the DPD-VV method may be written as\npnC1=2 D pn C h\n2FC.qn/ C h\n2FD.qn; pn/ C\np\nh\n2 FR.qn/;\n(8.91)\nqnC1 D qn C hM\u00021pnC1=2;\n(8.92)\npnC1 D pnC1=2 C h\n2FC.qnC1/ C h\n2FD.qnC1; pnC1=2/ C\np\nh\n2 FR.qnC1/:\n(8.93)\nIn this scheme, the conservative forces are recalculated once per timestep (the\nconservative force computed may be re-used at the following timestep). The\ndissipative force must be computed twice, and the new random force used in (8.93)\nshould also be used in the subsequent step. This scheme is not symmetric for\n\n8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n391\ndeterministic systems and would be expected to be only ﬁrst order accurate. It\ncould be made symmetric by a simple change, for example replacing pn in the force\ncomputation at the ﬁrst step by pnC1=2, but these changes would make the method\nimplicit.\n8.9.2.2\nShardlow’s Splitting Method\nShardlow [333] proposed splitting methods for DPD based on dividing the force\nﬁeld of the DPD system into its separate (conservative+dissipative+random) parts.\nSeveral integrators are then derived based on approximating the various terms. In\nthe most popular and efﬁcient variant, the scheme of Brünger, Brooks and Karplus\n(BBK) [55] is used to solve the dissipative+stochastic terms, with standard velocity\nVerlet applied to the conservative part.\nWe ﬁrst separate the system of stochastic differential equations for DPD (8.90)\ninto three pieces, which we label as A, B and O:\nd\n\u0002qi\npi\n\u0003\nD\n\u0002 m\u00021\ni pi\n0\n\u0003\ndt\n„\nƒ‚\n…\nA\nC\n\u0002 0\nFC\ni\n\u0003\ndt\n„ ƒ‚ …\nB\nC\n\u0002\n0\nFD\ni dt C \u0007Ri\n\u0003\n„\nƒ‚\n…\nO\n;\n(8.94)\nwhere Ri D P\nj¤i !R.rij/OqijdWij, for standard i.i.d. Wiener processes Wij.t/, such\nthat dWij D dWji. The generators for each part of the SDE may be written out as\nfollows:\nLA D\nX\ni\npi\nmi\n\u0002 rqi;\n(8.95)\nLB D\nX\ni\nFC\ni \u0002 rpi D \u0003\nX\ni\nrqiU.q/ \u0002 rpi;\n(8.96)\nLO D\nX\ni\nX\nj¤i\n\b\n\u0003\n!D.rij/.Oqij \u0002 vij/ C \u00072\n2 Œ!R.rij/\t2Oqij \u0002\n\u0002\nrpi \u0003 rpj\n\u0003\t\nOqij \u0002 rpi:\n(8.97)\nThus, the generator for the DPD system can be written as\nLDPD D LA C LB C LO;\n(8.98)\nand the ﬂow map may be written in the standard shorthand as\nFt D etLDPD:\nApproximations of Ft can be constructed as for Langevin dynamics.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 410,
      "printed_page": 389,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n389\nwhite-noise term with the following stochastic property\nh\u000eij.t/i D 0;\nh\u000eij.t/\u000ekl.t0/i D .ıikıjl C ıilıjk/ı.t \u0003 t0/;\n(8.88)\nand are independent for each pair of interacting particles at each time step.\nInvariance of the canonical distribution under these equations of motion follows if\n!D.rij/ D Œ!R.rij/\t2;\n\u00072 D 2\nkBT;\n(8.89)\nwhere kB is the Boltzmann constant and T the equilibrium temperature. Note that\nthe “canonical distribution” in the case of the DPD system or other momentum-\nconserving thermostat should have a density which is reduced to the leaves of\nconstant total momentum, i.e.\nO\u0005ˇ\ndef\nD Z\u00021e\u0002ˇH.q;p/ \u0004 ı\n\" N\nX\niD1\npi;x \u0003 \u0014x\n#\nı\n\" N\nX\niD1\npi;y \u0003 \u0014y\n#\nı\n\" N\nX\niD1\npi;z \u0003 \u0014z\n#\nwhere \u000f D .\u0014x; \u0014y; \u0014z/ is the total momentum vector.\nThe conservation of the total momentum is a direct result of the symmetric form\nof the various forces, thus DPD may be viewed as an isotropic Galilean-invariant\nthermostat which preserves hydrodynamics [8]. The ergodicity of DPD (i.e. that O\u0005ˇ\nis the unique measure sampled by the dynamics) has only been demonstrated in the\ncase of a high density of particles in one dimension [334].\nThe DPD system may be viewed as a special case of the generalized Langevin\ndynamics with equations\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \u0006.q/pdt C ˙.q/dW;\n(8.90)\nwhere the potential U is given in (8.84), and the damping matrix \u0006 and stochastic\nmultiplier matrix ˙ are related by\n\u0006 D M\u00021\n2kBT˙˙ T:\nIn the next subsection we describe the numerical treatment of the DPD system.\nWe then take up the alternative scheme, the pairwise Nosé-Hoover-Langevin\n(PNHL) method, of [228] which also conserves momentum exactly. Other alter-\nnatives to the DPD system include the Peters thermostat [299], the Lowe-Andersen\nmethod [241], and the Nosé-Hoover-Lowe-Andersen thermostat [347]. We do not\ndiscuss these schemes here, but note that they are compared to DPD and some of\nthe other schemes introduced below in [228].\n"
    },
    {
      "pdf_page": 411,
      "printed_page": 390,
      "text": "390\n8\nExtended Variable Methods\n8.9.2\nNumerical Treatment of the DPD System\nIn comparing the DPD system to standard molecular dynamics, a key feature is the\n“soft” nature of the repulsive potential UDPD deﬁned by (8.84). The lack of any sort\nof stiff harmonic component or steep repulsive potentials such as those present in\ntypical molecular models means that the stepsize is not dominated by the stability\nrestriction, but rather by accuracy requirements. That is, DPD simulations may be\nstable for stepsizes which lead to very large errors in thermodynamic averages.\nMany efforts have been made to develop accurate integration schemes for the\nDPD system. With few exceptions, the methods used are variants of the velocity-\nVerlet integrator, owing to its long history in MD. Some early integration schemes\nare to be found in the papers of Groot and Warren [157], Gibson et al. [148], and\nBesold et al. [34, 385]. The latter work describes the so-called DPD-Velocity Verlet\n(DPD-VV) method. Unfortunately [34, 385], all of these methods exhibit signiﬁcant\nsimulation errors for large stepsize. Much of the error can be seen as the result of\nrequiring an explicit treatment of the dissipative terms, for reasons of computational\nefﬁciency. More accurate schemes are possible by using implicit (or semi-implicit)\nmethods such the self-consistent leap-frog integrator (see [34, 295]). However, these\nmethods are typically much slower than the simpler, explicit methods [73, 281], the\nconsequence being that the simpler DPD-VV is most often used (with a relatively\nsmall timestep). Further alternatives to the DPD-VV method include a scheme of\nden Otter and Clarke [101], splitting methods (Shardlow [333], De Fabritiis et al.\n[96] and Thalmann and Farago [363]), and multiple time step schemes of Jakobsen\net al. [191].\n8.9.2.1\nDPD Velocity-Verlet\nWith integration stepsize h, the DPD-VV method may be written as\npnC1=2 D pn C h\n2FC.qn/ C h\n2FD.qn; pn/ C\np\nh\n2 FR.qn/;\n(8.91)\nqnC1 D qn C hM\u00021pnC1=2;\n(8.92)\npnC1 D pnC1=2 C h\n2FC.qnC1/ C h\n2FD.qnC1; pnC1=2/ C\np\nh\n2 FR.qnC1/:\n(8.93)\nIn this scheme, the conservative forces are recalculated once per timestep (the\nconservative force computed may be re-used at the following timestep). The\ndissipative force must be computed twice, and the new random force used in (8.93)\nshould also be used in the subsequent step. This scheme is not symmetric for\n"
    },
    {
      "pdf_page": 412,
      "printed_page": 391,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n391\ndeterministic systems and would be expected to be only ﬁrst order accurate. It\ncould be made symmetric by a simple change, for example replacing pn in the force\ncomputation at the ﬁrst step by pnC1=2, but these changes would make the method\nimplicit.\n8.9.2.2\nShardlow’s Splitting Method\nShardlow [333] proposed splitting methods for DPD based on dividing the force\nﬁeld of the DPD system into its separate (conservative+dissipative+random) parts.\nSeveral integrators are then derived based on approximating the various terms. In\nthe most popular and efﬁcient variant, the scheme of Brünger, Brooks and Karplus\n(BBK) [55] is used to solve the dissipative+stochastic terms, with standard velocity\nVerlet applied to the conservative part.\nWe ﬁrst separate the system of stochastic differential equations for DPD (8.90)\ninto three pieces, which we label as A, B and O:\nd\n\u0002qi\npi\n\u0003\nD\n\u0002 m\u00021\ni pi\n0\n\u0003\ndt\n„\nƒ‚\n…\nA\nC\n\u0002 0\nFC\ni\n\u0003\ndt\n„ ƒ‚ …\nB\nC\n\u0002\n0\nFD\ni dt C \u0007Ri\n\u0003\n„\nƒ‚\n…\nO\n;\n(8.94)\nwhere Ri D P\nj¤i !R.rij/OqijdWij, for standard i.i.d. Wiener processes Wij.t/, such\nthat dWij D dWji. The generators for each part of the SDE may be written out as\nfollows:\nLA D\nX\ni\npi\nmi\n\u0002 rqi;\n(8.95)\nLB D\nX\ni\nFC\ni \u0002 rpi D \u0003\nX\ni\nrqiU.q/ \u0002 rpi;\n(8.96)\nLO D\nX\ni\nX\nj¤i\n\b\n\u0003\n!D.rij/.Oqij \u0002 vij/ C \u00072\n2 Œ!R.rij/\t2Oqij \u0002\n\u0002\nrpi \u0003 rpj\n\u0003\t\nOqij \u0002 rpi:\n(8.97)\nThus, the generator for the DPD system can be written as\nLDPD D LA C LB C LO;\n(8.98)\nand the ﬂow map may be written in the standard shorthand as\nFt D etLDPD:\nApproximations of Ft can be constructed as for Langevin dynamics.\n"
    }
  ],
  "numbered_equations": [
    "8.91",
    "8.92",
    "8.93"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "物理用法要求mᵢ>0、h≥0、无序对枚举、每步Rnew独立标准正态并与历史独立；本条确定性给定输入的扩展状态映射。",
    "尚未证明书中预期的一阶弱收敛；未把随机输入映射称为对称确定性流。"
  ],
  "issues": [],
  "statement_scope": "三条更新式和新噪声在下一步复用的状态机制。",
  "lean_decl": "MD.Ch08.dpdRandomForce",
  "lean_declarations": [
    "MD.Ch08.dpdRandomForce",
    "MD.Ch08.dpdVerlet",
    "MD.Ch08.dpdVerlet_reuse"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def dpdRandomForce {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ)
    (wR : ℝ → ℝ) (q : ParticleConfig N d) (R : Vec K) : ParticleConfig N d :=
  ∑ k, R k • (dpdNoise pairs σ wR q k).2

def dpdVerlet {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ)
    (state : ParticlePhase N d × Vec K) (Rnew : Vec K) : ParticlePhase N d × Vec K :=
  let q := state.1.1
  let p := state.1.2
  let ph := p+(h/2) • dpdConservative α rc q+(h/2) • dpdDissipative m γ wD q p+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR q state.2
  let qn := fun i ↦ q i+(h/m i) • ph i
  let pn := ph+(h/2) • dpdConservative α rc qn+(h/2) • dpdDissipative m γ wD qn ph+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR qn Rnew
  ((qn,pn),Rnew)

theorem dpdVerlet_reuse {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ) (z : ParticlePhase N d × Vec K) (R : Vec K) :
    (dpdVerlet pairs m α rc γ σ h wD wR z R).2=R := rfl
```

## MD-8.9.2-DPDSplitGenerator
```json
{
  "source_id": "MD-8.9.2-DPDSplitGenerator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.9.2",
  "printed_page": "391",
  "pdf_page": "412",
  "statement_latex": "The DPD system splits into A: free transport, B: conservative force, O: dissipative plus pair noise. L_DPD=L_A+L_B+L_O. (8.94)–(8.98).",
  "statement_verbatim": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n391\ndeterministic systems and would be expected to be only ﬁrst order accurate. It\ncould be made symmetric by a simple change, for example replacing pn in the force\ncomputation at the ﬁrst step by pnC1=2, but these changes would make the method\nimplicit.\n8.9.2.2\nShardlow’s Splitting Method\nShardlow [333] proposed splitting methods for DPD based on dividing the force\nﬁeld of the DPD system into its separate (conservative+dissipative+random) parts.\nSeveral integrators are then derived based on approximating the various terms. In\nthe most popular and efﬁcient variant, the scheme of Brünger, Brooks and Karplus\n(BBK) [55] is used to solve the dissipative+stochastic terms, with standard velocity\nVerlet applied to the conservative part.\nWe ﬁrst separate the system of stochastic differential equations for DPD (8.90)\ninto three pieces, which we label as A, B and O:\nd\n\u0002qi\npi\n\u0003\nD\n\u0002 m\u00021\ni pi\n0\n\u0003\ndt\n„\nƒ‚\n…\nA\nC\n\u0002 0\nFC\ni\n\u0003\ndt\n„ ƒ‚ …\nB\nC\n\u0002\n0\nFD\ni dt C \u0007Ri\n\u0003\n„\nƒ‚\n…\nO\n;\n(8.94)\nwhere Ri D P\nj¤i !R.rij/OqijdWij, for standard i.i.d. Wiener processes Wij.t/, such\nthat dWij D dWji. The generators for each part of the SDE may be written out as\nfollows:\nLA D\nX\ni\npi\nmi\n\u0002 rqi;\n(8.95)\nLB D\nX\ni\nFC\ni \u0002 rpi D \u0003\nX\ni\nrqiU.q/ \u0002 rpi;\n(8.96)\nLO D\nX\ni\nX\nj¤i\n\b\n\u0003\n!D.rij/.Oqij \u0002 vij/ C \u00072\n2 Œ!R.rij/\t2Oqij \u0002\n\u0002\nrpi \u0003 rpj\n\u0003\t\nOqij \u0002 rpi:\n(8.97)\nThus, the generator for the DPD system can be written as\nLDPD D LA C LB C LO;\n(8.98)\nand the ﬂow map may be written in the standard shorthand as\nFt D etLDPD:\nApproximations of Ft can be constructed as for Langevin dynamics.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 412,
      "printed_page": 391,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n391\ndeterministic systems and would be expected to be only ﬁrst order accurate. It\ncould be made symmetric by a simple change, for example replacing pn in the force\ncomputation at the ﬁrst step by pnC1=2, but these changes would make the method\nimplicit.\n8.9.2.2\nShardlow’s Splitting Method\nShardlow [333] proposed splitting methods for DPD based on dividing the force\nﬁeld of the DPD system into its separate (conservative+dissipative+random) parts.\nSeveral integrators are then derived based on approximating the various terms. In\nthe most popular and efﬁcient variant, the scheme of Brünger, Brooks and Karplus\n(BBK) [55] is used to solve the dissipative+stochastic terms, with standard velocity\nVerlet applied to the conservative part.\nWe ﬁrst separate the system of stochastic differential equations for DPD (8.90)\ninto three pieces, which we label as A, B and O:\nd\n\u0002qi\npi\n\u0003\nD\n\u0002 m\u00021\ni pi\n0\n\u0003\ndt\n„\nƒ‚\n…\nA\nC\n\u0002 0\nFC\ni\n\u0003\ndt\n„ ƒ‚ …\nB\nC\n\u0002\n0\nFD\ni dt C \u0007Ri\n\u0003\n„\nƒ‚\n…\nO\n;\n(8.94)\nwhere Ri D P\nj¤i !R.rij/OqijdWij, for standard i.i.d. Wiener processes Wij.t/, such\nthat dWij D dWji. The generators for each part of the SDE may be written out as\nfollows:\nLA D\nX\ni\npi\nmi\n\u0002 rqi;\n(8.95)\nLB D\nX\ni\nFC\ni \u0002 rpi D \u0003\nX\ni\nrqiU.q/ \u0002 rpi;\n(8.96)\nLO D\nX\ni\nX\nj¤i\n\b\n\u0003\n!D.rij/.Oqij \u0002 vij/ C \u00072\n2 Œ!R.rij/\t2Oqij \u0002\n\u0002\nrpi \u0003 rpj\n\u0003\t\nOqij \u0002 rpi:\n(8.97)\nThus, the generator for the DPD system can be written as\nLDPD D LA C LB C LO;\n(8.98)\nand the ﬂow map may be written in the standard shorthand as\nFt D etLDPD:\nApproximations of Ft can be constructed as for Langevin dynamics.\n"
    }
  ],
  "numbered_equations": [
    "8.94",
    "8.95",
    "8.96",
    "8.97",
    "8.98"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "采用独立无序对的Itô二阶导数形式，实现(8.97)有序双和的合并表达；未证明有序/无序表达等价。",
    "光滑测试函数上的形式生成元定义不等同于已建立Markov半群，Fₜ=eᵗᴸ及其定义域列缺口。"
  ],
  "issues": [],
  "statement_scope": "实际三个漂移、无序对扩散生成元和漂移分解恒等式。",
  "lean_decl": "MD.Ch08.dpdA",
  "lean_declarations": [
    "MD.Ch08.dpdA",
    "MD.Ch08.dpdB",
    "MD.Ch08.dpdO",
    "MD.Ch08.firstOrder8",
    "MD.Ch08.dpdLO",
    "MD.Ch08.dpdGenerator",
    "MD.Ch08.dpdDrift_split"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def dpdA {N d : ℕ} (m : Fin N → ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),0)
def dpdB {N d : ℕ} (α rc : ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  (0,dpdConservative α rc z.1)
def dpdO {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d := (0,dpdDissipative m γ wD z.1 z.2)
def firstOrder8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (f : E → ℝ) (z : E) : ℝ := fderiv ℝ f z (F z)
def dpdLO {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdO m γ wD) f z+
    (∑ k, fderiv ℝ (fun x ↦ fderiv ℝ f x) z (dpdNoise pairs σ wR z.1 k)
      (dpdNoise pairs σ wR z.1 k))/2
def dpdGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdA m) f z+firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z
theorem dpdDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : dpdDrift m α rc γ wD z=dpdA m z+dpdB α rc z+dpdO m γ wD z := by
  ext <;> simp [dpdDrift,dpdA,dpdB,dpdO]
```

## MD-8.9.2-DPDPairGeneratorPrinted
```json
{
  "source_id": "MD-8.9.2-DPDPairGeneratorPrinted",
  "kind": "definition",
  "label": null,
  "section": "8.9.2",
  "printed_page": "392",
  "pdf_page": "413",
  "statement_latex": "(8.100) prints L_Oij=[−γωᴰu+(σ²/2)(ωᴿ)² e·(∂pi−∂pj)] e·∂pi for each unordered pair i<j.",
  "statement_verbatim": "392\n8\nExtended Variable Methods\nAs an example, the phase space propagation of Shardlow’s method [333], may\nbe written as\nexp\n\u0006\nh OLDPD-S\n\u0007\nD exp .hLO/ exp\n\bh\n2LB\n\t\nexp .hLA/ exp\n\bh\n2LB\n\t\n;\n(8.99)\nwhere h is the stepsize and, as usual, exp\n\u0004\nhLf\n\u0005\nrepresents the phase space propaga-\ntor associated to the corresponding vector ﬁeld f. In practice, Shardlow’s method is\ntypically implemented by further reducing the vector ﬁeld O into interacting pairs:\nexp\n\u0006\nh OLO\n\u0007\nD exp\n\u0004\nhLON\u00021;N\n\u0005\n\u0002 \u0002 \u0002 exp\n\u0004\nhLO1;3\n\u0005\nexp\n\u0004\nhLO1;2\n\u0005\n;\nwith the operators associated to each interacting pair deﬁned as\nLOi;j D\n\b\n\u0003\n!D.rij/.Oqij \u0002 vij/ C \u00072\n2 Œ!R.rij/\t2Oqij \u0002\n\u0002\nrpi \u0003 rpj\n\u0003\t\nOqij \u0002 rpi:\n(8.100)\nEach interacting pair thus preserves the invariant distribution O\u0005ˇ.\n8.9.2.3\nDPD Trotter Scheme\nIn the stochastic DPD-Trotter scheme, the standard DPD system (8.90) is split into\ntwo parts, which are labelled “A” and “S” as indicated below\nd\n\u0002qi\npi\n\u0003\nD\n\u0002 m\u00021\ni pi\n0\n\u0003\ndt\n„\nƒ‚\n…\nA\nC\n\u0002\n0\nFC\ni dt C FD\ni dt C \u0007Ri\n\u0003\n„\nƒ‚\n…\nS\n:\n(8.101)\nThe corresponding operator of part A is exactly the same as in Shardlow’s method,\nwhile the operator of part S is actually the sum of the operators of B and O deﬁned\nabove\nLS D LB C LO:\n(8.102)\nAs in Shardlow’s method, the vector ﬁeld S is typically split into exactly solvable\ninteracting pairs. Subtracting dvj from dvi and multiplying Oqij on both sides gives\nmijdvij D FC\nij .rij/dt \u0003 \n!D.rij/vijdt C \u0007!R.rij/dWij;\n(8.103)\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 413,
      "printed_page": 392,
      "text": "392\n8\nExtended Variable Methods\nAs an example, the phase space propagation of Shardlow’s method [333], may\nbe written as\nexp\n\u0006\nh OLDPD-S\n\u0007\nD exp .hLO/ exp\n\bh\n2LB\n\t\nexp .hLA/ exp\n\bh\n2LB\n\t\n;\n(8.99)\nwhere h is the stepsize and, as usual, exp\n\u0004\nhLf\n\u0005\nrepresents the phase space propaga-\ntor associated to the corresponding vector ﬁeld f. In practice, Shardlow’s method is\ntypically implemented by further reducing the vector ﬁeld O into interacting pairs:\nexp\n\u0006\nh OLO\n\u0007\nD exp\n\u0004\nhLON\u00021;N\n\u0005\n\u0002 \u0002 \u0002 exp\n\u0004\nhLO1;3\n\u0005\nexp\n\u0004\nhLO1;2\n\u0005\n;\nwith the operators associated to each interacting pair deﬁned as\nLOi;j D\n\b\n\u0003\n!D.rij/.Oqij \u0002 vij/ C \u00072\n2 Œ!R.rij/\t2Oqij \u0002\n\u0002\nrpi \u0003 rpj\n\u0003\t\nOqij \u0002 rpi:\n(8.100)\nEach interacting pair thus preserves the invariant distribution O\u0005ˇ.\n8.9.2.3\nDPD Trotter Scheme\nIn the stochastic DPD-Trotter scheme, the standard DPD system (8.90) is split into\ntwo parts, which are labelled “A” and “S” as indicated below\nd\n\u0002qi\npi\n\u0003\nD\n\u0002 m\u00021\ni pi\n0\n\u0003\ndt\n„\nƒ‚\n…\nA\nC\n\u0002\n0\nFC\ni dt C FD\ni dt C \u0007Ri\n\u0003\n„\nƒ‚\n…\nS\n:\n(8.101)\nThe corresponding operator of part A is exactly the same as in Shardlow’s method,\nwhile the operator of part S is actually the sum of the operators of B and O deﬁned\nabove\nLS D LB C LO:\n(8.102)\nAs in Shardlow’s method, the vector ﬁeld S is typically split into exactly solvable\ninteracting pairs. Subtracting dvj from dvi and multiplying Oqij on both sides gives\nmijdvij D FC\nij .rij/dt \u0003 \n!D.rij/vijdt C \u0007!R.rij/dWij;\n(8.103)\n"
    }
  ],
  "numbered_equations": [
    "8.100"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。"
  ],
  "issues": [
    "已目视核对原页PDF413：单个无序对算子的最外层只对pᵢ求导，会对总动量产生非零漂移；对两粒子成对守恒更新应将最外层改为e·(∂pᵢ−∂pⱼ)。完整有序双和(8.97)另含反方向项，不能直接同样判错。"
  ],
  "statement_scope": "冻结配置下单对动量生成元的原式和守恒方向修正版。",
  "lean_decl": "MD.Ch08.pairDerivative",
  "lean_declarations": [
    "MD.Ch08.pairDerivative",
    "MD.Ch08.dpdPairGeneratorPrinted",
    "MD.Ch08.dpdPairGenerator_corrected"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pairDerivative {N d : ℕ} (i j : Fin N) (e : Vec d)
    (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  fderiv ℝ f p (pairImpulseVector i j e)
def dpdPairGeneratorPrinted {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*fderiv ℝ f p (Pi.single i e)+
    σ^2*wr^2/2*pairDerivative i j e (fun x ↦ fderiv ℝ f x (Pi.single i e)) p
def dpdPairGenerator_corrected {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*pairDerivative i j e f p+
    σ^2*wr^2/2*pairDerivative i j e (pairDerivative i j e f) p
```

## MD-8.9.2-DPDSplittingCompositions
```json
{
  "source_id": "MD-8.9.2-DPDSplittingCompositions",
  "kind": "algorithm",
  "label": null,
  "section": "8.9.2",
  "printed_page": "392–393",
  "pdf_page": "413–414",
  "statement_latex": "Shardlow: O(h) B(h/2) A(h) B(h/2); S=B+O and Trotter: S(h/2) A(h) S(h/2). Pair products use the printed fixed unordered-pair order. (8.99),(8.101),(8.102).",
  "statement_verbatim": "392\n8\nExtended Variable Methods\nAs an example, the phase space propagation of Shardlow’s method [333], may\nbe written as\nexp\n\u0006\nh OLDPD-S\n\u0007\nD exp .hLO/ exp\n\bh\n2LB\n\t\nexp .hLA/ exp\n\bh\n2LB\n\t\n;\n(8.99)\nwhere h is the stepsize and, as usual, exp\n\u0004\nhLf\n\u0005\nrepresents the phase space propaga-\ntor associated to the corresponding vector ﬁeld f. In practice, Shardlow’s method is\ntypically implemented by further reducing the vector ﬁeld O into interacting pairs:\nexp\n\u0006\nh OLO\n\u0007\nD exp\n\u0004\nhLON\u00021;N\n\u0005\n\u0002 \u0002 \u0002 exp\n\u0004\nhLO1;3\n\u0005\nexp\n\u0004\nhLO1;2\n\u0005\n;\nwith the operators associated to each interacting pair deﬁned as\nLOi;j D\n\b\n\u0003\n!D.rij/.Oqij \u0002 vij/ C \u00072\n2 Œ!R.rij/\t2Oqij \u0002\n\u0002\nrpi \u0003 rpj\n\u0003\t\nOqij \u0002 rpi:\n(8.100)\nEach interacting pair thus preserves the invariant distribution O\u0005ˇ.\n8.9.2.3\nDPD Trotter Scheme\nIn the stochastic DPD-Trotter scheme, the standard DPD system (8.90) is split into\ntwo parts, which are labelled “A” and “S” as indicated below\nd\n\u0002qi\npi\n\u0003\nD\n\u0002 m\u00021\ni pi\n0\n\u0003\ndt\n„\nƒ‚\n…\nA\nC\n\u0002\n0\nFC\ni dt C FD\ni dt C \u0007Ri\n\u0003\n„\nƒ‚\n…\nS\n:\n(8.101)\nThe corresponding operator of part A is exactly the same as in Shardlow’s method,\nwhile the operator of part S is actually the sum of the operators of B and O deﬁned\nabove\nLS D LB C LO:\n(8.102)\nAs in Shardlow’s method, the vector ﬁeld S is typically split into exactly solvable\ninteracting pairs. Subtracting dvj from dvi and multiplying Oqij on both sides gives\nmijdvij D FC\nij .rij/dt \u0003 \n!D.rij/vijdt C \u0007!R.rij/dWij;\n(8.103)\n\n8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n393\nwhere mij D mimj=.mi C mj/ is the “reduced mass”, vij D Oqij \u0002 vij and FC\nij .rij/ is the\nmagnitude of the conservative force (8.82). This equation is an Ornstein-Uhlenbeck\nprocess with the exact (in the sense of distributions) solution [200]\nvij.t/ D\nFC\nij\n\u0002mij\nC e\u0002\u0002t\n \nvij.0/ \u0003\nFC\nij\n\u0002mij\n!\nC\ns\nkBT.1 \u0003 e\u00022\u0002t/\nmij\nRij.t/;\n(8.104)\nfor i < j with \u0002 D \n!D=mij, where vij.0/ are the initial relative velocities and\nRij.t/ are normally distributed variables with zero mean and unit variance. Thus the\nincremental velocities are given by\n\u0003ij D vij.t/ \u0003 vij.0/ D\n \nvij.0/ \u0003\nFC\nij\n\u0002mij\n!\n.e\u0002\u0002t \u0003 1/ C\ns\nkBT.1 \u0003 e\u00022\u0002t/\nmij\nRij.t/:\n(8.105)\nThe momenta are then obtained from\npnC1\ni\nD pn\ni C mij\u0003ijOqn\nij;\n(8.106)\npnC1\nj\nD pn\nj \u0003 mij\u0003ijOqn\nij;\n(8.107)\nthus deﬁning the propagator ehLSi;j for each particle pair. The DPD-Trotter propaga-\ntor is then\nexp\n\u0006\nh OLDPD-Trotter\n\u0007\nD exp\n\bh\n2LS\n\t\nexp .hLA/ exp\n\bh\n2LS\n\t\n;\nwhere the momentum part is deﬁned by\nexp\n\bh\n2\nOLS\n\t\nD exp\n\bh\n2LSN\u00021;N\n\t\n\u0002 \u0002 \u0002 exp\n\bh\n2LS1;3\n\t\nexp\n\bh\n2LS1;2\n\t\n:\n8.9.3\nExtended Variable Momentum-Conserving Thermostats:\nPairwise Nosé-Hoover/Nosé-Hoover-Langevin Methods\nBecause of the form of the force laws, the number of interaction terms (and\ncomputational cost) involved in the three force terms in DPD are roughly balanced.\nIn this setting the computational time needed to generate the independent random\nnumber streams can be signiﬁcant (depending on the particle density and cutoff\nradius), particularly in very large systems solved in parallel where communication\nbetween cells can require a signiﬁcant amount of time [1, 301]. For this reason,\nAllen and Schmid [8] proposed a Nosé-Hoover type thermostatting scheme in\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 413,
      "printed_page": 392,
      "text": "392\n8\nExtended Variable Methods\nAs an example, the phase space propagation of Shardlow’s method [333], may\nbe written as\nexp\n\u0006\nh OLDPD-S\n\u0007\nD exp .hLO/ exp\n\bh\n2LB\n\t\nexp .hLA/ exp\n\bh\n2LB\n\t\n;\n(8.99)\nwhere h is the stepsize and, as usual, exp\n\u0004\nhLf\n\u0005\nrepresents the phase space propaga-\ntor associated to the corresponding vector ﬁeld f. In practice, Shardlow’s method is\ntypically implemented by further reducing the vector ﬁeld O into interacting pairs:\nexp\n\u0006\nh OLO\n\u0007\nD exp\n\u0004\nhLON\u00021;N\n\u0005\n\u0002 \u0002 \u0002 exp\n\u0004\nhLO1;3\n\u0005\nexp\n\u0004\nhLO1;2\n\u0005\n;\nwith the operators associated to each interacting pair deﬁned as\nLOi;j D\n\b\n\u0003\n!D.rij/.Oqij \u0002 vij/ C \u00072\n2 Œ!R.rij/\t2Oqij \u0002\n\u0002\nrpi \u0003 rpj\n\u0003\t\nOqij \u0002 rpi:\n(8.100)\nEach interacting pair thus preserves the invariant distribution O\u0005ˇ.\n8.9.2.3\nDPD Trotter Scheme\nIn the stochastic DPD-Trotter scheme, the standard DPD system (8.90) is split into\ntwo parts, which are labelled “A” and “S” as indicated below\nd\n\u0002qi\npi\n\u0003\nD\n\u0002 m\u00021\ni pi\n0\n\u0003\ndt\n„\nƒ‚\n…\nA\nC\n\u0002\n0\nFC\ni dt C FD\ni dt C \u0007Ri\n\u0003\n„\nƒ‚\n…\nS\n:\n(8.101)\nThe corresponding operator of part A is exactly the same as in Shardlow’s method,\nwhile the operator of part S is actually the sum of the operators of B and O deﬁned\nabove\nLS D LB C LO:\n(8.102)\nAs in Shardlow’s method, the vector ﬁeld S is typically split into exactly solvable\ninteracting pairs. Subtracting dvj from dvi and multiplying Oqij on both sides gives\nmijdvij D FC\nij .rij/dt \u0003 \n!D.rij/vijdt C \u0007!R.rij/dWij;\n(8.103)\n"
    },
    {
      "pdf_page": 414,
      "printed_page": 393,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n393\nwhere mij D mimj=.mi C mj/ is the “reduced mass”, vij D Oqij \u0002 vij and FC\nij .rij/ is the\nmagnitude of the conservative force (8.82). This equation is an Ornstein-Uhlenbeck\nprocess with the exact (in the sense of distributions) solution [200]\nvij.t/ D\nFC\nij\n\u0002mij\nC e\u0002\u0002t\n \nvij.0/ \u0003\nFC\nij\n\u0002mij\n!\nC\ns\nkBT.1 \u0003 e\u00022\u0002t/\nmij\nRij.t/;\n(8.104)\nfor i < j with \u0002 D \n!D=mij, where vij.0/ are the initial relative velocities and\nRij.t/ are normally distributed variables with zero mean and unit variance. Thus the\nincremental velocities are given by\n\u0003ij D vij.t/ \u0003 vij.0/ D\n \nvij.0/ \u0003\nFC\nij\n\u0002mij\n!\n.e\u0002\u0002t \u0003 1/ C\ns\nkBT.1 \u0003 e\u00022\u0002t/\nmij\nRij.t/:\n(8.105)\nThe momenta are then obtained from\npnC1\ni\nD pn\ni C mij\u0003ijOqn\nij;\n(8.106)\npnC1\nj\nD pn\nj \u0003 mij\u0003ijOqn\nij;\n(8.107)\nthus deﬁning the propagator ehLSi;j for each particle pair. The DPD-Trotter propaga-\ntor is then\nexp\n\u0006\nh OLDPD-Trotter\n\u0007\nD exp\n\bh\n2LS\n\t\nexp .hLA/ exp\n\bh\n2LS\n\t\n;\nwhere the momentum part is deﬁned by\nexp\n\bh\n2\nOLS\n\t\nD exp\n\bh\n2LSN\u00021;N\n\t\n\u0002 \u0002 \u0002 exp\n\bh\n2LS1;3\n\t\nexp\n\bh\n2LS1;2\n\t\n:\n8.9.3\nExtended Variable Momentum-Conserving Thermostats:\nPairwise Nosé-Hoover/Nosé-Hoover-Langevin Methods\nBecause of the form of the force laws, the number of interaction terms (and\ncomputational cost) involved in the three force terms in DPD are roughly balanced.\nIn this setting the computational time needed to generate the independent random\nnumber streams can be signiﬁcant (depending on the particle density and cutoff\nradius), particularly in very large systems solved in parallel where communication\nbetween cells can require a signiﬁcant amount of time [1, 301]. For this reason,\nAllen and Schmid [8] proposed a Nosé-Hoover type thermostatting scheme in\n"
    }
  ],
  "numbered_equations": [
    "8.99",
    "8.101",
    "8.102"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "A/B/O/S为调用者指定的映射；只保留所印组合顺序。尚未实现BBK成对近似或其误差、全O/S流及生成元指数关系。",
    "两次S同顺序的非交换成对乘积不能仅凭外层回文判为对称；不作该声称。"
  ],
  "issues": [],
  "statement_scope": "两种外层组合、固定顺序逐对执行及S形式生成元；实际OU单对步骤见后条。",
  "lean_decl": "MD.Ch08.dpdShardlowComposition",
  "lean_declarations": [
    "MD.Ch08.dpdShardlowComposition",
    "MD.Ch08.dpdTrotterComposition",
    "MD.Ch08.sequentialPairComposition",
    "MD.Ch08.dpdSGenerator"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def dpdShardlowComposition {E : Type*} (A B O : ℝ → E → E) (h : ℝ) : E → E :=
  O h ∘ B (h/2) ∘ A h ∘ B (h/2)
def dpdTrotterComposition {E : Type*} (A S : ℝ → E → E) (h : ℝ) : E → E :=
  S (h/2) ∘ A h ∘ S (h/2)
def sequentialPairComposition {E : Type*} (steps : List (E → E)) : E → E :=
  fun x ↦ steps.foldl (fun y F ↦ F y) x
def dpdSGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z
```

## MD-8.9.2-DPDPairOUUpdate
```json
{
  "source_id": "MD-8.9.2-DPDPairOUUpdate",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.9.2",
  "printed_page": "393",
  "pdf_page": "414",
  "statement_latex": "mred=mi mj/(mi+mj); mred du=Fdt−γωᴰu dt+σωᴿdW. a=γωᴰ/mred. u(t)=F/(a mred)+exp(−at)(u0−F/(a mred))+√[θ(1−exp(−2at))/mred]R. Δu=u(t)−u0; pi+=mred Δu e, pj−=mred Δu e. (8.103)–(8.107).",
  "statement_verbatim": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n393\nwhere mij D mimj=.mi C mj/ is the “reduced mass”, vij D Oqij \u0002 vij and FC\nij .rij/ is the\nmagnitude of the conservative force (8.82). This equation is an Ornstein-Uhlenbeck\nprocess with the exact (in the sense of distributions) solution [200]\nvij.t/ D\nFC\nij\n\u0002mij\nC e\u0002\u0002t\n \nvij.0/ \u0003\nFC\nij\n\u0002mij\n!\nC\ns\nkBT.1 \u0003 e\u00022\u0002t/\nmij\nRij.t/;\n(8.104)\nfor i < j with \u0002 D \n!D=mij, where vij.0/ are the initial relative velocities and\nRij.t/ are normally distributed variables with zero mean and unit variance. Thus the\nincremental velocities are given by\n\u0003ij D vij.t/ \u0003 vij.0/ D\n \nvij.0/ \u0003\nFC\nij\n\u0002mij\n!\n.e\u0002\u0002t \u0003 1/ C\ns\nkBT.1 \u0003 e\u00022\u0002t/\nmij\nRij.t/:\n(8.105)\nThe momenta are then obtained from\npnC1\ni\nD pn\ni C mij\u0003ijOqn\nij;\n(8.106)\npnC1\nj\nD pn\nj \u0003 mij\u0003ijOqn\nij;\n(8.107)\nthus deﬁning the propagator ehLSi;j for each particle pair. The DPD-Trotter propaga-\ntor is then\nexp\n\u0006\nh OLDPD-Trotter\n\u0007\nD exp\n\bh\n2LS\n\t\nexp .hLA/ exp\n\bh\n2LS\n\t\n;\nwhere the momentum part is deﬁned by\nexp\n\bh\n2\nOLS\n\t\nD exp\n\bh\n2LSN\u00021;N\n\t\n\u0002 \u0002 \u0002 exp\n\bh\n2LS1;3\n\t\nexp\n\bh\n2LS1;2\n\t\n:\n8.9.3\nExtended Variable Momentum-Conserving Thermostats:\nPairwise Nosé-Hoover/Nosé-Hoover-Langevin Methods\nBecause of the form of the force laws, the number of interaction terms (and\ncomputational cost) involved in the three force terms in DPD are roughly balanced.\nIn this setting the computational time needed to generate the independent random\nnumber streams can be signiﬁcant (depending on the particle density and cutoff\nradius), particularly in very large systems solved in parallel where communication\nbetween cells can require a signiﬁcant amount of time [1, 301]. For this reason,\nAllen and Schmid [8] proposed a Nosé-Hoover type thermostatting scheme in\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 414,
      "printed_page": 393,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n393\nwhere mij D mimj=.mi C mj/ is the “reduced mass”, vij D Oqij \u0002 vij and FC\nij .rij/ is the\nmagnitude of the conservative force (8.82). This equation is an Ornstein-Uhlenbeck\nprocess with the exact (in the sense of distributions) solution [200]\nvij.t/ D\nFC\nij\n\u0002mij\nC e\u0002\u0002t\n \nvij.0/ \u0003\nFC\nij\n\u0002mij\n!\nC\ns\nkBT.1 \u0003 e\u00022\u0002t/\nmij\nRij.t/;\n(8.104)\nfor i < j with \u0002 D \n!D=mij, where vij.0/ are the initial relative velocities and\nRij.t/ are normally distributed variables with zero mean and unit variance. Thus the\nincremental velocities are given by\n\u0003ij D vij.t/ \u0003 vij.0/ D\n \nvij.0/ \u0003\nFC\nij\n\u0002mij\n!\n.e\u0002\u0002t \u0003 1/ C\ns\nkBT.1 \u0003 e\u00022\u0002t/\nmij\nRij.t/:\n(8.105)\nThe momenta are then obtained from\npnC1\ni\nD pn\ni C mij\u0003ijOqn\nij;\n(8.106)\npnC1\nj\nD pn\nj \u0003 mij\u0003ijOqn\nij;\n(8.107)\nthus deﬁning the propagator ehLSi;j for each particle pair. The DPD-Trotter propaga-\ntor is then\nexp\n\u0006\nh OLDPD-Trotter\n\u0007\nD exp\n\bh\n2LS\n\t\nexp .hLA/ exp\n\bh\n2LS\n\t\n;\nwhere the momentum part is deﬁned by\nexp\n\bh\n2\nOLS\n\t\nD exp\n\bh\n2LSN\u00021;N\n\t\n\u0002 \u0002 \u0002 exp\n\bh\n2LS1;3\n\t\nexp\n\bh\n2LS1;2\n\t\n:\n8.9.3\nExtended Variable Momentum-Conserving Thermostats:\nPairwise Nosé-Hoover/Nosé-Hoover-Langevin Methods\nBecause of the form of the force laws, the number of interaction terms (and\ncomputational cost) involved in the three force terms in DPD are roughly balanced.\nIn this setting the computational time needed to generate the independent random\nnumber streams can be signiﬁcant (depending on the particle density and cutoff\nradius), particularly in very large systems solved in parallel where communication\nbetween cells can require a signiﬁcant amount of time [1, 301]. For this reason,\nAllen and Schmid [8] proposed a Nosé-Hoover type thermostatting scheme in\n"
    }
  ],
  "numbered_equations": [
    "8.103",
    "8.104",
    "8.105",
    "8.106",
    "8.107"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "原印转移律要求mr>0、a>0、θ>0、t≥0及R独立标准正态；F为冻结配置的成对保守力标量，FDT用于方差。",
    "单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。"
  ],
  "issues": [
    "已目视核对原页PDF414：原印F/(amred)须a>0；γ=0或截断外ωᴰ=0时需用积分系数连续延拓。修正版显式定义a=0为自由加速，噪声退化为零。"
  ],
  "statement_scope": "原印/零率延拓的OU转移公式、速度增量所用动量更新及总动量守恒。",
  "lean_decl": "MD.Ch08.reducedMass8",
  "lean_declarations": [
    "MD.Ch08.reducedMass8",
    "MD.Ch08.reducedMass8_pos",
    "MD.Ch08.dpdPairOUPrinted",
    "MD.Ch08.dpdPairOU_corrected",
    "MD.Ch08.dpdPairOU_zeroRate",
    "MD.Ch08.dpdPairMomentumStep",
    "MD.Ch08.dpdPairMomentumStep_conserves"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def reducedMass8 (mi mj : ℝ) : ℝ := mi*mj/(mi+mj)
theorem reducedMass8_pos (mi mj : ℝ) (hi : 0 < mi) (hj : 0 < mj) : 0 < reducedMass8 mi mj :=
  div_pos (mul_pos hi hj) (add_pos hi hj)
def dpdPairOUPrinted (mr a F θ t u R : ℝ) : ℝ :=
  F/(a*mr)+Real.exp (-a*t)*(u-F/(a*mr))+Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
def dpdPairOU_corrected (mr a F θ t u R : ℝ) : ℝ :=
  Real.exp (-a*t)*u+(F/mr)*(if a=0 then t else (1-Real.exp (-a*t))/a)+
    Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
theorem dpdPairOU_zeroRate (mr F θ t u R : ℝ) :
    dpdPairOU_corrected mr 0 F θ t u R=u+(F/mr)*t := by simp [dpdPairOU_corrected]
def dpdPairMomentumStep {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : ParticleConfig N d := p+pairImpulseVector i j ((mr*du) • e)
theorem dpdPairMomentumStep_conserves {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : totalMomentum (dpdPairMomentumStep i j e mr du p)=totalMomentum p := by
  simp [dpdPairMomentumStep,pairImpulseVector,totalMomentum,Finset.sum_add_distrib,Finset.sum_sub_distrib]
```

## MD-8.9.3-PairwiseNoseHoover
```json
{
  "source_id": "MD-8.9.3-PairwiseNoseHoover",
  "kind": "definition",
  "label": null,
  "section": "8.9.3",
  "printed_page": "394",
  "pdf_page": "415",
  "statement_latex": "dqᵢ=pᵢdt/mᵢ, dpᵢ=Fᶜᵢdt+ξ F̃ᴰᵢdt, dξ=Gdt; G=Q⁻¹Σᵢ<ⱼωᴰ(rᵢⱼ)[(vᵢⱼ·eᵢⱼ)²−θ/mred]. (8.108),(8.109).",
  "statement_verbatim": "394\n8\nExtended Variable Methods\nwhich the stochastic terms are eliminated and replaced by a kinetic energy control\nlaw based only on relative velocities of interacting pairs. We refer to this as the\npairwise Nosé-Hoover (PNH) thermostat; it is designed to conserve the momentum\nand is also Galilean-invariant. This method is particularly useful in nonequilibrium\nmolecular dynamics (NEMD) applications where the total momentum needs to be\npreserved under thermostatting [342].\nThe equations of motion of the PNH thermostat (for particle i) is given by\ndqi D m\u00021\ni pidt;\ndpi D FC\ni .q/dt C \u0012 QF\nD\ni dt;\nd\u0012 D G.q; p/dt;\n(8.108)\nwhere \u0012 is a dynamical variable, the dissipative/driving coupling term is deﬁned as\nQF\nD\ni D\nN\nX\njD1\nQF\nD\nij ;\nQF\nD\nij D \u0003!D.rij/.Oqij \u0002 vij/Oqij;\n(i.e. \n D 1 in the dissipative term for DPD), and G.q; p/ is the instantaneous accu-\nmulated deviation of the kinetic temperature away from the target temperature [8]\nG.q; p/ D \u0006\u00021 X\ni\nX\nj>i\n!D.rij/\nh\u0004\nvij \u0002 Oqij\n\u00052 \u0003 kBT=mij\ni\n;\n(8.109)\nwhere \u0006 is a coupling parameter which is referred to as the “thermal mass”. The\ninvariant distribution is deﬁned in the .q; p; \u0012/ extended space, with density\nO\u0005ˇ.q; p; \u0012/ D OZ\u00021 exp .\u0003ˇH.q; p// exp\n\u0004\n\u0003ˇ\u0006\u00122=2\n\u0005\n;\n(8.110)\nwhere OZ is a suitable normalizing coefﬁcient so that the density integrates to one\nover the entire accessible space (subject, as usual, to the conservation of momentum\nconstraint).\nA nonsymmetric integration algorithm was applied in the original paper [8] to\nsolve the system.\n8.9.4\nPairwise Nosé-Hoover-Langevin Thermostat\nTo improve ergodicity, it is intuitive to employ the same stochastic device used\nin the Nosé-Hoover-Langevin method, namely linear (OU-type) stochastic terms\nintroduced in the equation for the auxiliary variable \u0012. If the OU process is properly\ntuned the extended canonical distribution with density O\u0005ˇ will still be preserved.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 415,
      "printed_page": 394,
      "text": "394\n8\nExtended Variable Methods\nwhich the stochastic terms are eliminated and replaced by a kinetic energy control\nlaw based only on relative velocities of interacting pairs. We refer to this as the\npairwise Nosé-Hoover (PNH) thermostat; it is designed to conserve the momentum\nand is also Galilean-invariant. This method is particularly useful in nonequilibrium\nmolecular dynamics (NEMD) applications where the total momentum needs to be\npreserved under thermostatting [342].\nThe equations of motion of the PNH thermostat (for particle i) is given by\ndqi D m\u00021\ni pidt;\ndpi D FC\ni .q/dt C \u0012 QF\nD\ni dt;\nd\u0012 D G.q; p/dt;\n(8.108)\nwhere \u0012 is a dynamical variable, the dissipative/driving coupling term is deﬁned as\nQF\nD\ni D\nN\nX\njD1\nQF\nD\nij ;\nQF\nD\nij D \u0003!D.rij/.Oqij \u0002 vij/Oqij;\n(i.e. \n D 1 in the dissipative term for DPD), and G.q; p/ is the instantaneous accu-\nmulated deviation of the kinetic temperature away from the target temperature [8]\nG.q; p/ D \u0006\u00021 X\ni\nX\nj>i\n!D.rij/\nh\u0004\nvij \u0002 Oqij\n\u00052 \u0003 kBT=mij\ni\n;\n(8.109)\nwhere \u0006 is a coupling parameter which is referred to as the “thermal mass”. The\ninvariant distribution is deﬁned in the .q; p; \u0012/ extended space, with density\nO\u0005ˇ.q; p; \u0012/ D OZ\u00021 exp .\u0003ˇH.q; p// exp\n\u0004\n\u0003ˇ\u0006\u00122=2\n\u0005\n;\n(8.110)\nwhere OZ is a suitable normalizing coefﬁcient so that the density integrates to one\nover the entire accessible space (subject, as usual, to the conservation of momentum\nconstraint).\nA nonsymmetric integration algorithm was applied in the original paper [8] to\nsolve the system.\n8.9.4\nPairwise Nosé-Hoover-Langevin Thermostat\nTo improve ergodicity, it is intuitive to employ the same stochastic device used\nin the Nosé-Hoover-Langevin method, namely linear (OU-type) stochastic terms\nintroduced in the equation for the auxiliary variable \u0012. If the OU process is properly\ntuned the extended canonical distribution with density O\u0005ˇ will still be preserved.\n"
    }
  ],
  "numbered_equations": [
    "8.108",
    "8.109"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "Q为原文μ，F̃ᴰ是γ=1的相对速度耗散；排除i=j，物理轨道另需非碰撞且ωᴰ≥0。",
    "只落盘实际ODE规格；Galilean不变性、总动量沿轨道守恒、存在唯一性及遍历性列缺口。"
  ],
  "issues": [],
  "statement_scope": "PNH场、反馈和正质量/正热浴质量的ODE规格。",
  "lean_decl": "MD.Ch08.PNHLState",
  "lean_declarations": [
    "MD.Ch08.PNHLState",
    "MD.Ch08.pairwiseFeedback",
    "MD.Ch08.pnhDrift",
    "MD.Ch08.isPNHSolution"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
abbrev PNHLState (N d : ℕ) := ParticlePhase N d × ℝ
def pairwiseFeedback {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ℝ :=
  (∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), wD (pairDistance q i j)*
    ((dot (relativeVelocity m p i j) (pairDirection q i j))^2-θ/reducedMass8 (m i) (m j)))/Q
def pnhDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ (m i)⁻¹ • z.1.2 i),
    dpdConservative α rc z.1.1+z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),
   pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def isPNHSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (X : ℝ → PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧
  ∀ t, 0 ≤ t → HasDerivWithinAt X (pnhDrift m α rc θ Q wD (X t)) (Ici 0) t
```
