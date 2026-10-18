# BATCH13 第8章原文与陈述审校

## MD-8.8-NPTDensity
```json
{
  "source_id": "MD-8.8-NPTDensity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8",
  "printed_page": "378–379",
  "pdf_page": "399–400",
  "statement_latex": "ρ_NPT=Z_NPT⁻¹ exp[−β(H+PV)], β⁻¹=k_BT; physical volume V is positive.",
  "statement_verbatim": "378\n8\nExtended Variable Methods\n8.8\nConstant Temperature and Pressure Molecular\nDynamics\nThe isobaric, isothermal or NPT ensemble models a system in contact with a heat\nbath (temperature T) and a “pressure reservoir” maintained at pressure P. The\npressure is deﬁned by the formula\nP D \u0003\n\u0002 @E\n@V\n\u0003\nS;N\nwhere E is the energy, V is volume, S is entropy. The notation Œ: : :\tx;y means that the\nindicated partial derivatives should be taken with respect to constant values of the\nindicated variables.\nAn isothermal-isobaric system exchanges energy with the bath in such a way\nas to maintain the constant temperature; at the same time the volume ﬂuctuates to\ncontrol the pressure. The state of the system can be expressed in terms of particle\npositions and momenta as well as the volume V, i.e. we think of the probability\ndensity as a function of q, p and V.\nLet N, V, E be the number of atoms, volume and energy, respectively, of the\nsystem of interest, and N2, V2, E2 be the corresponding quantities describing the\nbath system; we have NCN2 D QN, VCV2 D QV, ECE2 D QE all constant. We view\nthe entropy as a function of the other variables and expand in a Taylor series in both\nvolume and energy:\nS.N2; V2; E2/ D S. QN \u0003 N; QV \u0003 V; QE \u0003 E/ \u0007 S.N2; QV; QE/ \u0003 @S\n@EE \u0003 @S\n@VV:\nBear in mind that here E and V are small relative perturbations of the total energy\nand volume. The quantity @S\n@E is the reciprocal temperature.\nTo calculate @S\n@V we may use Maxwell’s thermodynamic relation [372]:\n\u0002@S\n@E\n\u0003\nV;N\n\u0002 @E\n@V\n\u0003\nS;N\n\u0002@V\n@S\n\u0003\nE;N\nD \u00031:\nSince\n\n @S\n@E\n\u000b\nV;N is T\u00021 and\n\n @E\n@V\n\u000b\nS;N is \u0003P, we obtain\n\u0002 @S\n@V\n\u0003\nE;N\nD\n1\n\n @V\n@S\n\u000b\nE;N\nD P=T:\nThis results in the formula\nS.N2; V2; E2/ \u0007 constant \u0003 E C PV\nT\n;\n\n8.8\nConstant Temperature and Pressure Molecular Dynamics\n379\nwhich leads to the probability density\n\u0005NPT D Z\u00021\nNPTe\u0002ˇ.HCPV/;\nwhere H is the Hamiltonian, and ˇ\u00021 D kBT.\nThe NPT model may be viewed as corresponding to a thermostatted system\nwhich incorporates a “piston” controlling the overall volume of the system to be\nconsistent with the target pressure. During simulation, the volume must be free\nto change; whereas the methods presented so far retain a ﬁxed volume. In NVE\nor NVT simulation, the volume enters in two ways into the molecular simulation\nmethod: (i) as a modiﬁcation of the potential (allowing for periodic replicas) and\n(ii) in the mechanism by which atoms are mapped from one boundary to the other\nof the rectangular domain, simulating motion on a torus. It is not obvious how to\ngeneralize these to the NPT setting where V is a dynamical variable.\nThe method of Andersen [11] (“Andersen’s piston”) is to control the volume\nby reparamaterizing the coordinates to lie in a cubic box with unit side. Assuming\nthe system occupies a cubic domain, say, Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t,\nwhere L D V1=3, we may write, for each three-dimensional atomic coordinate vector\nqi\nqi D V1=3Nqi;\n(8.71)\nwhere Nqi is conﬁned to the unit-side cube. Then we have\nPqi D 1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi:\nThe kinetic energy of the atomic system may be written\nK D\nN\nX\niD1\nmi\nkPqik2\n2\n:\nAfter coordinate transformation this becomes\nNK D\nN\nX\niD1\nmi\n2\n\n\n\n\n\n1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi\n\n\n\n\n\n2\nD\nN\nX\niD1\nmi\n2\n\u00021\n9V\u00024=3 PV2 kNqik2 C 2\n3V\u00021=3 PV Nqi \u0002 PNqi C V2=3 \n\nPNqi\n\n\n2\u0003\n;\nthus the momentum vector conjugate to Nqi becomes\nNpi D @ NK\n@PNqi\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 399,
      "printed_page": 378,
      "text": "378\n8\nExtended Variable Methods\n8.8\nConstant Temperature and Pressure Molecular\nDynamics\nThe isobaric, isothermal or NPT ensemble models a system in contact with a heat\nbath (temperature T) and a “pressure reservoir” maintained at pressure P. The\npressure is deﬁned by the formula\nP D \u0003\n\u0002 @E\n@V\n\u0003\nS;N\nwhere E is the energy, V is volume, S is entropy. The notation Œ: : :\tx;y means that the\nindicated partial derivatives should be taken with respect to constant values of the\nindicated variables.\nAn isothermal-isobaric system exchanges energy with the bath in such a way\nas to maintain the constant temperature; at the same time the volume ﬂuctuates to\ncontrol the pressure. The state of the system can be expressed in terms of particle\npositions and momenta as well as the volume V, i.e. we think of the probability\ndensity as a function of q, p and V.\nLet N, V, E be the number of atoms, volume and energy, respectively, of the\nsystem of interest, and N2, V2, E2 be the corresponding quantities describing the\nbath system; we have NCN2 D QN, VCV2 D QV, ECE2 D QE all constant. We view\nthe entropy as a function of the other variables and expand in a Taylor series in both\nvolume and energy:\nS.N2; V2; E2/ D S. QN \u0003 N; QV \u0003 V; QE \u0003 E/ \u0007 S.N2; QV; QE/ \u0003 @S\n@EE \u0003 @S\n@VV:\nBear in mind that here E and V are small relative perturbations of the total energy\nand volume. The quantity @S\n@E is the reciprocal temperature.\nTo calculate @S\n@V we may use Maxwell’s thermodynamic relation [372]:\n\u0002@S\n@E\n\u0003\nV;N\n\u0002 @E\n@V\n\u0003\nS;N\n\u0002@V\n@S\n\u0003\nE;N\nD \u00031:\nSince\n\n @S\n@E\n\u000b\nV;N is T\u00021 and\n\n @E\n@V\n\u000b\nS;N is \u0003P, we obtain\n\u0002 @S\n@V\n\u0003\nE;N\nD\n1\n\n @V\n@S\n\u000b\nE;N\nD P=T:\nThis results in the formula\nS.N2; V2; E2/ \u0007 constant \u0003 E C PV\nT\n;\n"
    },
    {
      "pdf_page": 400,
      "printed_page": 379,
      "text": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n379\nwhich leads to the probability density\n\u0005NPT D Z\u00021\nNPTe\u0002ˇ.HCPV/;\nwhere H is the Hamiltonian, and ˇ\u00021 D kBT.\nThe NPT model may be viewed as corresponding to a thermostatted system\nwhich incorporates a “piston” controlling the overall volume of the system to be\nconsistent with the target pressure. During simulation, the volume must be free\nto change; whereas the methods presented so far retain a ﬁxed volume. In NVE\nor NVT simulation, the volume enters in two ways into the molecular simulation\nmethod: (i) as a modiﬁcation of the potential (allowing for periodic replicas) and\n(ii) in the mechanism by which atoms are mapped from one boundary to the other\nof the rectangular domain, simulating motion on a torus. It is not obvious how to\ngeneralize these to the NPT setting where V is a dynamical variable.\nThe method of Andersen [11] (“Andersen’s piston”) is to control the volume\nby reparamaterizing the coordinates to lie in a cubic box with unit side. Assuming\nthe system occupies a cubic domain, say, Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t,\nwhere L D V1=3, we may write, for each three-dimensional atomic coordinate vector\nqi\nqi D V1=3Nqi;\n(8.71)\nwhere Nqi is conﬁned to the unit-side cube. Then we have\nPqi D 1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi:\nThe kinetic energy of the atomic system may be written\nK D\nN\nX\niD1\nmi\nkPqik2\n2\n:\nAfter coordinate transformation this becomes\nNK D\nN\nX\niD1\nmi\n2\n\n\n\n\n\n1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi\n\n\n\n\n\n2\nD\nN\nX\niD1\nmi\n2\n\u00021\n9V\u00024=3 PV2 kNqik2 C 2\n3V\u00021=3 PV Nqi \u0002 PNqi C V2=3 \n\nPNqi\n\n\n2\u0003\n;\nthus the momentum vector conjugate to Nqi becomes\nNpi D @ NK\n@PNqi\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "三维N粒子时n=3N；盒域明确依赖V，并用受限Lebesgue测度。正有限配分积分与可积性明示；没有由任意势假装得到NPT概率。"
  ],
  "issues": [],
  "statement_scope": "正体积盒内NPT权重和有资格时的概率归一化。",
  "lean_decl": "MD.Ch08.volumeScale",
  "lean_declarations": [
    "MD.Ch08.volumeScale",
    "MD.Ch08.nptBox",
    "MD.Ch08.nptWeight",
    "MD.Ch08.nptDensity",
    "MD.Ch08.nptDensity_normalizes"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def volumeScale (V : ℝ) : ℝ := Real.rpow V (1/3 : ℝ)
def nptBox (n : ℕ) : Set (Phase n × ℝ) :=
  {z | 0 < z.2 ∧ ∀ i, |z.1.1 i| ≤ volumeScale z.2/2}
def nptWeight (H : Phase n × ℝ → ℝ) (β P : ℝ) (z : Phase n × ℝ) : ℝ :=
  Real.exp (-β*(H z+P*z.2))
def nptDensity (H : Phase n × ℝ → ℝ) (β P : ℝ) (z : Phase n × ℝ) : ℝ :=
  (∫ y, nptWeight H β P y ∂volume.restrict (nptBox n))⁻¹*nptWeight H β P z
theorem nptDensity_normalizes (H : Phase n × ℝ → ℝ) (β P : ℝ) (hβ : 0 < β)
    (hi : Integrable (nptWeight H β P) (volume.restrict (nptBox n)))
    (hZ : 0 < ∫ z, nptWeight H β P z ∂volume.restrict (nptBox n)) :
    probabilityDensity (volume.restrict (nptBox n)) (nptDensity H β P) := by
  refine ⟨fun z ↦ mul_nonneg (inv_nonneg.mpr (le_of_lt hZ))
    (le_of_lt (Real.exp_pos _)),hi.const_mul _,?_⟩
  simp only [nptDensity,integral_const_mul]
  exact inv_mul_cancel₀ (ne_of_gt hZ)
```

## MD-8.8-AndersenCoordinates
```json
{
  "source_id": "MD-8.8-AndersenCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8",
  "printed_page": "379–380",
  "pdf_page": "400–401",
  "statement_latex": "qᵢ=V^{1/3}q̄ᵢ; q̇ᵢ=(1/3)V^{−2/3}V̇q̄ᵢ+V^{1/3}q̄̇ᵢ; p̄ᵢ=mᵢV^{1/3}q̇ᵢ. (8.71),(8.72).",
  "statement_verbatim": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n379\nwhich leads to the probability density\n\u0005NPT D Z\u00021\nNPTe\u0002ˇ.HCPV/;\nwhere H is the Hamiltonian, and ˇ\u00021 D kBT.\nThe NPT model may be viewed as corresponding to a thermostatted system\nwhich incorporates a “piston” controlling the overall volume of the system to be\nconsistent with the target pressure. During simulation, the volume must be free\nto change; whereas the methods presented so far retain a ﬁxed volume. In NVE\nor NVT simulation, the volume enters in two ways into the molecular simulation\nmethod: (i) as a modiﬁcation of the potential (allowing for periodic replicas) and\n(ii) in the mechanism by which atoms are mapped from one boundary to the other\nof the rectangular domain, simulating motion on a torus. It is not obvious how to\ngeneralize these to the NPT setting where V is a dynamical variable.\nThe method of Andersen [11] (“Andersen’s piston”) is to control the volume\nby reparamaterizing the coordinates to lie in a cubic box with unit side. Assuming\nthe system occupies a cubic domain, say, Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t,\nwhere L D V1=3, we may write, for each three-dimensional atomic coordinate vector\nqi\nqi D V1=3Nqi;\n(8.71)\nwhere Nqi is conﬁned to the unit-side cube. Then we have\nPqi D 1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi:\nThe kinetic energy of the atomic system may be written\nK D\nN\nX\niD1\nmi\nkPqik2\n2\n:\nAfter coordinate transformation this becomes\nNK D\nN\nX\niD1\nmi\n2\n\n\n\n\n\n1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi\n\n\n\n\n\n2\nD\nN\nX\niD1\nmi\n2\n\u00021\n9V\u00024=3 PV2 kNqik2 C 2\n3V\u00021=3 PV Nqi \u0002 PNqi C V2=3 \n\nPNqi\n\n\n2\u0003\n;\nthus the momentum vector conjugate to Nqi becomes\nNpi D @ NK\n@PNqi\n\n380\n8\nExtended Variable Methods\nD mi\n\u00021\n3V\u00021=3 PV Nqi C V2=3PNqi\n\u0003\n;\nfrom which, we observe\nNpi D miV1=3Pqi:\n(8.72)\nThere is still the question of how to adjust the volume in simulation. The idea\nof Andersen was to view the volume V as a dynamical quantity on equal footing\nwith the coordinates of the system by viewing PV as the potential energy term and\nintroducing an artiﬁcial kinetic energy term of the form \u0006V PV2. The barostat mass \u0006V\nbecomes a free parameter, analogous to the thermal mass used in Nosé dynamics.\nAn extended Hamiltonian may then be written by introducing a momentum variable\npV conjugate to V:\nOH.Nq; Np; V; pV/ D\nN\nX\niD1\nkNpik2\n2miV2=3 C NU.NqI V/ C p2\nV\n2\u0006V\nC PV;\n(8.73)\nwhere we have written NU.NqI V/ D U.V1=3Nq/.\nIn the extended space, we then observe that\n\u0005NPT D\ns\nˇ\n2\u0014\u0006V\nZ\ne\u0002ˇ OH.Nq;Np;V;pV/dpV;\nfrom the deﬁnitions (8.71) and (8.72).\nThere are several ways to proceed. Andersen suggested to use a Monte-\nCarlo method to control the temperature during simulation. This approach has\nthe advantage of simplicity, but only allows the determination of conﬁgurational\naverages. If dynamical information is required (e.g. an autocorrelation function\nor a diffusion coefﬁcient), some sort of dynamics-based scheme is needed. The\nprogress in developing formulations and numerical methods can be charted in\n[11, 32, 128, 183, 199, 248, 252, 288, 373].\nDeterministic methods can be used based on Nosé-Hoover to control the\ntemperature. A problem with methods of this type that one sometimes encounters\n“ringing” or “breathing” depending on the tuning of various parameters.\nStochastic-dynamical thermostats greatly improve control of the convergence to\nequilibrium. We have already seen several methods of this type, speciﬁcally the\nLangevin dynamics method and the Nosé-Hoover-Langevinmethod. These schemes\nmay be applied in conjunction with the Andersen Hamiltonian OH. The extended\nsystem approach outlined here was developed in collaboration with R. Elber and\nM. Di Pierro; it is close in spirit to the method of Klein [199], but incorporates\nstochastic terms as in Nosé-Hoover-Langevin in the equations deﬁning the auxiliary\nvariables to ensure ergodicity.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 400,
      "printed_page": 379,
      "text": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n379\nwhich leads to the probability density\n\u0005NPT D Z\u00021\nNPTe\u0002ˇ.HCPV/;\nwhere H is the Hamiltonian, and ˇ\u00021 D kBT.\nThe NPT model may be viewed as corresponding to a thermostatted system\nwhich incorporates a “piston” controlling the overall volume of the system to be\nconsistent with the target pressure. During simulation, the volume must be free\nto change; whereas the methods presented so far retain a ﬁxed volume. In NVE\nor NVT simulation, the volume enters in two ways into the molecular simulation\nmethod: (i) as a modiﬁcation of the potential (allowing for periodic replicas) and\n(ii) in the mechanism by which atoms are mapped from one boundary to the other\nof the rectangular domain, simulating motion on a torus. It is not obvious how to\ngeneralize these to the NPT setting where V is a dynamical variable.\nThe method of Andersen [11] (“Andersen’s piston”) is to control the volume\nby reparamaterizing the coordinates to lie in a cubic box with unit side. Assuming\nthe system occupies a cubic domain, say, Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t,\nwhere L D V1=3, we may write, for each three-dimensional atomic coordinate vector\nqi\nqi D V1=3Nqi;\n(8.71)\nwhere Nqi is conﬁned to the unit-side cube. Then we have\nPqi D 1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi:\nThe kinetic energy of the atomic system may be written\nK D\nN\nX\niD1\nmi\nkPqik2\n2\n:\nAfter coordinate transformation this becomes\nNK D\nN\nX\niD1\nmi\n2\n\n\n\n\n\n1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi\n\n\n\n\n\n2\nD\nN\nX\niD1\nmi\n2\n\u00021\n9V\u00024=3 PV2 kNqik2 C 2\n3V\u00021=3 PV Nqi \u0002 PNqi C V2=3 \n\nPNqi\n\n\n2\u0003\n;\nthus the momentum vector conjugate to Nqi becomes\nNpi D @ NK\n@PNqi\n"
    },
    {
      "pdf_page": 401,
      "printed_page": 380,
      "text": "380\n8\nExtended Variable Methods\nD mi\n\u00021\n3V\u00021=3 PV Nqi C V2=3PNqi\n\u0003\n;\nfrom which, we observe\nNpi D miV1=3Pqi:\n(8.72)\nThere is still the question of how to adjust the volume in simulation. The idea\nof Andersen was to view the volume V as a dynamical quantity on equal footing\nwith the coordinates of the system by viewing PV as the potential energy term and\nintroducing an artiﬁcial kinetic energy term of the form \u0006V PV2. The barostat mass \u0006V\nbecomes a free parameter, analogous to the thermal mass used in Nosé dynamics.\nAn extended Hamiltonian may then be written by introducing a momentum variable\npV conjugate to V:\nOH.Nq; Np; V; pV/ D\nN\nX\niD1\nkNpik2\n2miV2=3 C NU.NqI V/ C p2\nV\n2\u0006V\nC PV;\n(8.73)\nwhere we have written NU.NqI V/ D U.V1=3Nq/.\nIn the extended space, we then observe that\n\u0005NPT D\ns\nˇ\n2\u0014\u0006V\nZ\ne\u0002ˇ OH.Nq;Np;V;pV/dpV;\nfrom the deﬁnitions (8.71) and (8.72).\nThere are several ways to proceed. Andersen suggested to use a Monte-\nCarlo method to control the temperature during simulation. This approach has\nthe advantage of simplicity, but only allows the determination of conﬁgurational\naverages. If dynamical information is required (e.g. an autocorrelation function\nor a diffusion coefﬁcient), some sort of dynamics-based scheme is needed. The\nprogress in developing formulations and numerical methods can be charted in\n[11, 32, 128, 183, 199, 248, 252, 288, 373].\nDeterministic methods can be used based on Nosé-Hoover to control the\ntemperature. A problem with methods of this type that one sometimes encounters\n“ringing” or “breathing” depending on the tuning of various parameters.\nStochastic-dynamical thermostats greatly improve control of the convergence to\nequilibrium. We have already seen several methods of this type, speciﬁcally the\nLangevin dynamics method and the Nosé-Hoover-Langevinmethod. These schemes\nmay be applied in conjunction with the Andersen Hamiltonian OH. The extended\nsystem approach outlined here was developed in collaboration with R. Elber and\nM. Di Pierro; it is close in spirit to the method of Klein [199], but incorporates\nstochastic terms as in Nosé-Hoover-Langevin in the equations deﬁning the auxiliary\nvariables to ensure ergodicity.\n"
    }
  ],
  "numbered_equations": [
    "8.71",
    "8.72"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "V>0用于实分数幂的导数与乘法；质量物理解读取正，等式本身是坐标变换，不包含随体积变化的全局正则流或规范测度。"
  ],
  "issues": [],
  "statement_scope": "位置、速度、共轭动量的实际变换式与两个局部等式目标。",
  "lean_decl": "MD.Ch08.andersenPosition",
  "lean_declarations": [
    "MD.Ch08.andersenPosition",
    "MD.Ch08.andersenVelocity",
    "MD.Ch08.andersenMomentum",
    "MD.Ch08.andersenPosition_derivative",
    "MD.Ch08.andersenMomentum_velocity"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def andersenPosition (V : ℝ) (qbar : Vec n) : Vec n := volumeScale V • qbar
def andersenVelocity (V Vdot : ℝ) (qbar vbar : Vec n) : Vec n :=
  ((1/3 : ℝ)*Real.rpow V (-2/3 : ℝ)*Vdot) • qbar+volumeScale V • vbar
def andersenMomentum (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : Vec n :=
  fun i ↦ m i*((1/3 : ℝ)*Real.rpow V (-1/3 : ℝ)*Vdot*qbar i+
    Real.rpow V (2/3 : ℝ)*vbar i)
theorem andersenPosition_derivative (V : ℝ → ℝ) (qbar : ℝ → Vec n)
    (t Vdot : ℝ) (vbar : Vec n) (hV : 0 < V t)
    (hdV : HasDerivAt V Vdot t) (hdq : HasDerivAt qbar vbar t) :
    HasDerivAt (fun s ↦ andersenPosition (V s) (qbar s))
      (andersenVelocity (V t) Vdot (qbar t) vbar) t := by
  sorry
theorem andersenMomentum_velocity (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n)
    (hV : 0 < V) :
    andersenMomentum m V Vdot qbar vbar =
      fun i ↦ m i*volumeScale V*andersenVelocity V Vdot qbar vbar i := by
  sorry
```

## MD-8.8-AndersenKineticEnergy
```json
{
  "source_id": "MD-8.8-AndersenKineticEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8",
  "printed_page": "379",
  "pdf_page": "400",
  "statement_latex": "After q=V^{1/3}q̄, K̄=Σᵢ(mᵢ/2)[(1/9)V^{−4/3}V̇²|q̄ᵢ|²+(2/3)V^{−1/3}V̇q̄ᵢ·q̄̇ᵢ+V^{2/3}|q̄̇ᵢ|²].",
  "statement_verbatim": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n379\nwhich leads to the probability density\n\u0005NPT D Z\u00021\nNPTe\u0002ˇ.HCPV/;\nwhere H is the Hamiltonian, and ˇ\u00021 D kBT.\nThe NPT model may be viewed as corresponding to a thermostatted system\nwhich incorporates a “piston” controlling the overall volume of the system to be\nconsistent with the target pressure. During simulation, the volume must be free\nto change; whereas the methods presented so far retain a ﬁxed volume. In NVE\nor NVT simulation, the volume enters in two ways into the molecular simulation\nmethod: (i) as a modiﬁcation of the potential (allowing for periodic replicas) and\n(ii) in the mechanism by which atoms are mapped from one boundary to the other\nof the rectangular domain, simulating motion on a torus. It is not obvious how to\ngeneralize these to the NPT setting where V is a dynamical variable.\nThe method of Andersen [11] (“Andersen’s piston”) is to control the volume\nby reparamaterizing the coordinates to lie in a cubic box with unit side. Assuming\nthe system occupies a cubic domain, say, Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t,\nwhere L D V1=3, we may write, for each three-dimensional atomic coordinate vector\nqi\nqi D V1=3Nqi;\n(8.71)\nwhere Nqi is conﬁned to the unit-side cube. Then we have\nPqi D 1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi:\nThe kinetic energy of the atomic system may be written\nK D\nN\nX\niD1\nmi\nkPqik2\n2\n:\nAfter coordinate transformation this becomes\nNK D\nN\nX\niD1\nmi\n2\n\n\n\n\n\n1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi\n\n\n\n\n\n2\nD\nN\nX\niD1\nmi\n2\n\u00021\n9V\u00024=3 PV2 kNqik2 C 2\n3V\u00021=3 PV Nqi \u0002 PNqi C V2=3 \n\nPNqi\n\n\n2\u0003\n;\nthus the momentum vector conjugate to Nqi becomes\nNpi D @ NK\n@PNqi\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 400,
      "printed_page": 379,
      "text": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n379\nwhich leads to the probability density\n\u0005NPT D Z\u00021\nNPTe\u0002ˇ.HCPV/;\nwhere H is the Hamiltonian, and ˇ\u00021 D kBT.\nThe NPT model may be viewed as corresponding to a thermostatted system\nwhich incorporates a “piston” controlling the overall volume of the system to be\nconsistent with the target pressure. During simulation, the volume must be free\nto change; whereas the methods presented so far retain a ﬁxed volume. In NVE\nor NVT simulation, the volume enters in two ways into the molecular simulation\nmethod: (i) as a modiﬁcation of the potential (allowing for periodic replicas) and\n(ii) in the mechanism by which atoms are mapped from one boundary to the other\nof the rectangular domain, simulating motion on a torus. It is not obvious how to\ngeneralize these to the NPT setting where V is a dynamical variable.\nThe method of Andersen [11] (“Andersen’s piston”) is to control the volume\nby reparamaterizing the coordinates to lie in a cubic box with unit side. Assuming\nthe system occupies a cubic domain, say, Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t\u0004Œ\u0003L=2; L=2\t,\nwhere L D V1=3, we may write, for each three-dimensional atomic coordinate vector\nqi\nqi D V1=3Nqi;\n(8.71)\nwhere Nqi is conﬁned to the unit-side cube. Then we have\nPqi D 1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi:\nThe kinetic energy of the atomic system may be written\nK D\nN\nX\niD1\nmi\nkPqik2\n2\n:\nAfter coordinate transformation this becomes\nNK D\nN\nX\niD1\nmi\n2\n\n\n\n\n\n1\n3V\u00022=3 PV Nqi C V1=3 d\ndt Nqi\n\n\n\n\n\n2\nD\nN\nX\niD1\nmi\n2\n\u00021\n9V\u00024=3 PV2 kNqik2 C 2\n3V\u00021=3 PV Nqi \u0002 PNqi C V2=3 \n\nPNqi\n\n\n2\u0003\n;\nthus the momentum vector conjugate to Nqi becomes\nNpi D @ NK\n@PNqi\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "坐标逐分量求和就是三维点积展开，避免把Pi类型的最大范数误作物理Euclidean长度；V正。"
  ],
  "issues": [],
  "statement_scope": "所印动能展开的逐标量坐标版本。",
  "lean_decl": "MD.Ch08.andersenKinetic",
  "lean_declarations": [
    "MD.Ch08.andersenKinetic",
    "MD.Ch08.andersenKineticExpanded",
    "MD.Ch08.andersenKinetic_expansion"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def andersenKinetic (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : ℝ :=
  ∑ i, m i*(andersenVelocity V Vdot qbar vbar i)^2/2
def andersenKineticExpanded (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : ℝ :=
  ∑ i, m i/2*((1/9 : ℝ)*Real.rpow V (-4/3 : ℝ)*Vdot^2*qbar i^2+
    (2/3 : ℝ)*Real.rpow V (-1/3 : ℝ)*Vdot*qbar i*vbar i+
    Real.rpow V (2/3 : ℝ)*vbar i^2)
theorem andersenKinetic_expansion (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n)
    (hV : 0 < V) : andersenKinetic m V Vdot qbar vbar =
      andersenKineticExpanded m V Vdot qbar vbar := by
  sorry
```

## MD-8.8-AndersenHamiltonianPrinted
```json
{
  "source_id": "MD-8.8-AndersenHamiltonianPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8",
  "printed_page": "380",
  "pdf_page": "401",
  "statement_latex": "Ĥ=Σᵢ|p̄ᵢ|²/(2mᵢV^{2/3})+Ū(q̄;V)+p_V²/(2μ_V)+PV, and ρ_NPT=√(β/(2πμ_V))∫exp(−βĤ)dp_V. (8.73).",
  "statement_verbatim": "380\n8\nExtended Variable Methods\nD mi\n\u00021\n3V\u00021=3 PV Nqi C V2=3PNqi\n\u0003\n;\nfrom which, we observe\nNpi D miV1=3Pqi:\n(8.72)\nThere is still the question of how to adjust the volume in simulation. The idea\nof Andersen was to view the volume V as a dynamical quantity on equal footing\nwith the coordinates of the system by viewing PV as the potential energy term and\nintroducing an artiﬁcial kinetic energy term of the form \u0006V PV2. The barostat mass \u0006V\nbecomes a free parameter, analogous to the thermal mass used in Nosé dynamics.\nAn extended Hamiltonian may then be written by introducing a momentum variable\npV conjugate to V:\nOH.Nq; Np; V; pV/ D\nN\nX\niD1\nkNpik2\n2miV2=3 C NU.NqI V/ C p2\nV\n2\u0006V\nC PV;\n(8.73)\nwhere we have written NU.NqI V/ D U.V1=3Nq/.\nIn the extended space, we then observe that\n\u0005NPT D\ns\nˇ\n2\u0014\u0006V\nZ\ne\u0002ˇ OH.Nq;Np;V;pV/dpV;\nfrom the deﬁnitions (8.71) and (8.72).\nThere are several ways to proceed. Andersen suggested to use a Monte-\nCarlo method to control the temperature during simulation. This approach has\nthe advantage of simplicity, but only allows the determination of conﬁgurational\naverages. If dynamical information is required (e.g. an autocorrelation function\nor a diffusion coefﬁcient), some sort of dynamics-based scheme is needed. The\nprogress in developing formulations and numerical methods can be charted in\n[11, 32, 128, 183, 199, 248, 252, 288, 373].\nDeterministic methods can be used based on Nosé-Hoover to control the\ntemperature. A problem with methods of this type that one sometimes encounters\n“ringing” or “breathing” depending on the tuning of various parameters.\nStochastic-dynamical thermostats greatly improve control of the convergence to\nequilibrium. We have already seen several methods of this type, speciﬁcally the\nLangevin dynamics method and the Nosé-Hoover-Langevinmethod. These schemes\nmay be applied in conjunction with the Andersen Hamiltonian OH. The extended\nsystem approach outlined here was developed in collaboration with R. Elber and\nM. Di Pierro; it is close in spirit to the method of Klein [199], but incorporates\nstochastic terms as in Nosé-Hoover-Langevin in the equations deﬁning the auxiliary\nvariables to ensure ergodicity.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 401,
      "printed_page": 380,
      "text": "380\n8\nExtended Variable Methods\nD mi\n\u00021\n3V\u00021=3 PV Nqi C V2=3PNqi\n\u0003\n;\nfrom which, we observe\nNpi D miV1=3Pqi:\n(8.72)\nThere is still the question of how to adjust the volume in simulation. The idea\nof Andersen was to view the volume V as a dynamical quantity on equal footing\nwith the coordinates of the system by viewing PV as the potential energy term and\nintroducing an artiﬁcial kinetic energy term of the form \u0006V PV2. The barostat mass \u0006V\nbecomes a free parameter, analogous to the thermal mass used in Nosé dynamics.\nAn extended Hamiltonian may then be written by introducing a momentum variable\npV conjugate to V:\nOH.Nq; Np; V; pV/ D\nN\nX\niD1\nkNpik2\n2miV2=3 C NU.NqI V/ C p2\nV\n2\u0006V\nC PV;\n(8.73)\nwhere we have written NU.NqI V/ D U.V1=3Nq/.\nIn the extended space, we then observe that\n\u0005NPT D\ns\nˇ\n2\u0014\u0006V\nZ\ne\u0002ˇ OH.Nq;Np;V;pV/dpV;\nfrom the deﬁnitions (8.71) and (8.72).\nThere are several ways to proceed. Andersen suggested to use a Monte-\nCarlo method to control the temperature during simulation. This approach has\nthe advantage of simplicity, but only allows the determination of conﬁgurational\naverages. If dynamical information is required (e.g. an autocorrelation function\nor a diffusion coefﬁcient), some sort of dynamics-based scheme is needed. The\nprogress in developing formulations and numerical methods can be charted in\n[11, 32, 128, 183, 199, 248, 252, 288, 373].\nDeterministic methods can be used based on Nosé-Hoover to control the\ntemperature. A problem with methods of this type that one sometimes encounters\n“ringing” or “breathing” depending on the tuning of various parameters.\nStochastic-dynamical thermostats greatly improve control of the convergence to\nequilibrium. We have already seen several methods of this type, speciﬁcally the\nLangevin dynamics method and the Nosé-Hoover-Langevinmethod. These schemes\nmay be applied in conjunction with the Andersen Hamiltonian OH. The extended\nsystem approach outlined here was developed in collaboration with R. Elber and\nM. Di Pierro; it is close in spirit to the method of Klein [199], but incorporates\nstochastic terms as in Nosé-Hoover-Langevin in the equations deﬁning the auxiliary\nvariables to ensure ergodicity.\n"
    }
  ],
  "numbered_equations": [
    "8.73"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "m,QV,V,β正为物理域；QV是活塞质量，pV取实数。仅高斯消元的点态权重式，不把它当成任意U下的归一概率或完整坐标Jacobian定理。"
  ],
  "issues": [
    "已目视核对原页PDF401：边缘公式未写此前ρ_NPT定义中的Z_NPT⁻¹；字面右端给未归一Boltzmann权。修正版独立加入正配分常数，需导师确认作者是否在此省略归一因子。"
  ],
  "statement_scope": "活塞Hamiltonian、原印/修正边缘权重和Gaussian积分目标。",
  "lean_decl": "MD.Ch08.andersenHamiltonian",
  "lean_declarations": [
    "MD.Ch08.andersenHamiltonian",
    "MD.Ch08.andersenMarginalPrinted",
    "MD.Ch08.andersenMarginal_corrected",
    "MD.Ch08.andersenGaussian_marginal"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def andersenHamiltonian (m : Vec n) (U : Vec n → ℝ) (QV P : ℝ)
    (z : (Phase n × ℝ) × ℝ) : ℝ :=
  (∑ i, z.1.1.2 i^2/(2*m i*Real.rpow z.1.2 (2/3 : ℝ)))+
    U (andersenPosition z.1.2 z.1.1.1)+z.2^2/(2*QV)+P*z.1.2
def andersenMarginalPrinted (m : Vec n) (U : Vec n → ℝ) (QV P β : ℝ)
    (z : Phase n × ℝ) : ℝ :=
  Real.sqrt (β/(2*Real.pi*QV))*∫ pV, Real.exp (-β*andersenHamiltonian m U QV P (z,pV))
def andersenMarginal_corrected (m : Vec n) (U : Vec n → ℝ) (QV P β Z : ℝ)
    (z : Phase n × ℝ) : ℝ := andersenMarginalPrinted m U QV P β z/Z
theorem andersenGaussian_marginal (m : Vec n) (U : Vec n → ℝ) (QV P β : ℝ)
    (hQV : 0 < QV) (hβ : 0 < β) (z : Phase n × ℝ) (hV : 0 < z.2) :
    andersenMarginalPrinted m U QV P β z =
      Real.exp (-β*((∑ i, z.1.2 i^2/(2*m i*Real.rpow z.2 (2/3 : ℝ)))+
        U (andersenPosition z.2 z.1.1)+P*z.2)) := by
  sorry
```

## MD-8.8.1-NHLPistonEquations
```json
{
  "source_id": "MD-8.8.1-NHLPistonEquations",
  "kind": "definition",
  "label": null,
  "section": "8.8.1",
  "printed_page": "381–382",
  "pdf_page": "402–403",
  "statement_latex": "q̇=M⁻¹p+ηq, ṗ=F−ηp−ξp, V̇=ηV; dξ=(h_T−γ_Tξ)dt+√(2k_BTγ_T/μ_T)dW_T, dη=(h_P−γ_Pη)dt+√(2k_BTγ_P/μ_P)dW_P, with h_T=(pᵀM⁻¹p−N_dk_BT)/μ_T and h_P=(VΠ−PV+k_BT)/μ_P. (8.75)–(8.79).",
  "statement_verbatim": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n381\n8.8.1\nEquations of Motion for the NHL Piston\nIn the framework of [199], rewriting the equations of motion for the physical\nvariables q and p, the dynamics takes the form\nPq D M\u00021p C \u000fq;\nPp D \u0003rU.q/ \u0003 \u000fp \u0003 \u0012p;\nPV D \u000fV;\nwith auxiliary variables \u000f and \u0012 governed by additional dynamical equations of\nmotion\nP\u0012 D hT\ndef\nD .pTM\u00021p \u0003 NdkBT/=\u0006T;\nP\u000f D hP\ndef\nD .V˘.q; p; V/ \u0003 PV C kBT/=\u0006P;\nwhere\n˘.q; p; V/\ndef\nD 1\nV\n\b\npTM\u00021p \u0003 q \u0002 rU.q/ \u0003 V @\n@V U.q/\n\t\n;\nis the expression for the pressure.\nNow let us examine the distribution conserved by the dynamics. First, we observe\n\u00051 D '1.pTM\u00021p=2 C U.q// \u0004 .V; \u0012; \u000f/\nis stationary for the Liouvillian operator for the vector ﬁeld .p; \u0003rU; 0; 0; 0/.\nThe function can be chosen as any smooth function that integrates out with\nrespect to V; \u0012; \u000f over Œ0; 1\t \u0004 R \u0004 R. We already know from our discussion of\nNosé-Hoover that Pp D \u0003\u0012p; P\u0012 D .pTM\u00021p \u0003 NdkBT/=\u0006T will have as stationary\nstates functions of the form\n\u00052 D exp.\u0003ˇŒpTM\u00021p C \u0006T\u00122=2\t/ 2.q; \u000f; V/:\nFinally the remaining terms Pq D \u000fq, Pp D \u0003\u000fp, PV D \u000fV, P\u000f D .V˘.q; p; V/ \u0003 PV C\nkBT/=\u0006P give rise to the Liouvillian\nL\u0004\u0005 D \u0003\u000frq \u0002.q\u0005/C\u000frp \u0002.p\u0005/\u0003\u000f @\n@V .V\u0005/\u0003 @\n@\u000fŒ\u0005.V˘.q; p; V/\u0003PV CkBT/=\u0006P\t:\n\n382\n8\nExtended Variable Methods\nIf \u0005 has the form \u0005 D exp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .q; p; V; \u0012/ then eliminate \u000f, reducing\nL\u0004\u0005 D 0 to\n\u0003rq \u0002 .q / C rp \u0002 .p / \u0003 @\n@V .V / C ˇ.V˘.q; p; V/ \u0003 PV C kBT/ D 0:\nThis results in\n\u0003 q \u0002 rq C p \u0002 rp \u0003 \u0003 V @ \n@V C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/ D 0:\n(8.74)\nA solution (the desired one) is given by\n / exp.\u0003ˇ.H C PV//;\nwhere substituting into (8.74) gives\nh\nˇq \u0002 rU.q/ \u0003 ˇp \u0002 M\u00021p \u0003 1 C ˇV @U\n@V\nCˇPV C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/\ni\n D 0;\nwhich is quickly checked to be true, and hence the dynamics preserves \u0005 D\nexp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .\nIt is difﬁcult to see how their could be other solutions , but we know from\nthe Nosé-Hoover case that this must be possible. We improve the robustness of\nthe method by introducing Ornstein-Uhlenbeck type stochastic processes in the two\nauxiliary variables \u0012 and \u000f, yielding the system\nPq D M\u00021p C \u000fq;\n(8.75)\nPp D F.q/ \u0003 \u000fp \u0003 \u0012p;\n(8.76)\nPV D \u000fV;\n(8.77)\nd\u0012 D ŒhT \u0003 \nT\u0012\t dt C\np\n2kBT\nT=\u0006TdWT;\n(8.78)\nd\u000f D ŒhP \u0003 \nP\u000f\t dt C\np\n2kBT\nP=\u0006PdWP;\n(8.79)\nwhere \nT; \nP \b 0 are two parameters governing the strength of the noise.\n8.8.2\nDiscretization of the NHL Piston\nObservations in Chap. 7 and our experience with the Nosé-Hoover-Langevinmethod\nlead us to propose splitting methods to separate the Ornstein-Uhlenbeck processes\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 402,
      "printed_page": 381,
      "text": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n381\n8.8.1\nEquations of Motion for the NHL Piston\nIn the framework of [199], rewriting the equations of motion for the physical\nvariables q and p, the dynamics takes the form\nPq D M\u00021p C \u000fq;\nPp D \u0003rU.q/ \u0003 \u000fp \u0003 \u0012p;\nPV D \u000fV;\nwith auxiliary variables \u000f and \u0012 governed by additional dynamical equations of\nmotion\nP\u0012 D hT\ndef\nD .pTM\u00021p \u0003 NdkBT/=\u0006T;\nP\u000f D hP\ndef\nD .V˘.q; p; V/ \u0003 PV C kBT/=\u0006P;\nwhere\n˘.q; p; V/\ndef\nD 1\nV\n\b\npTM\u00021p \u0003 q \u0002 rU.q/ \u0003 V @\n@V U.q/\n\t\n;\nis the expression for the pressure.\nNow let us examine the distribution conserved by the dynamics. First, we observe\n\u00051 D '1.pTM\u00021p=2 C U.q// \u0004 .V; \u0012; \u000f/\nis stationary for the Liouvillian operator for the vector ﬁeld .p; \u0003rU; 0; 0; 0/.\nThe function can be chosen as any smooth function that integrates out with\nrespect to V; \u0012; \u000f over Œ0; 1\t \u0004 R \u0004 R. We already know from our discussion of\nNosé-Hoover that Pp D \u0003\u0012p; P\u0012 D .pTM\u00021p \u0003 NdkBT/=\u0006T will have as stationary\nstates functions of the form\n\u00052 D exp.\u0003ˇŒpTM\u00021p C \u0006T\u00122=2\t/ 2.q; \u000f; V/:\nFinally the remaining terms Pq D \u000fq, Pp D \u0003\u000fp, PV D \u000fV, P\u000f D .V˘.q; p; V/ \u0003 PV C\nkBT/=\u0006P give rise to the Liouvillian\nL\u0004\u0005 D \u0003\u000frq \u0002.q\u0005/C\u000frp \u0002.p\u0005/\u0003\u000f @\n@V .V\u0005/\u0003 @\n@\u000fŒ\u0005.V˘.q; p; V/\u0003PV CkBT/=\u0006P\t:\n"
    },
    {
      "pdf_page": 403,
      "printed_page": 382,
      "text": "382\n8\nExtended Variable Methods\nIf \u0005 has the form \u0005 D exp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .q; p; V; \u0012/ then eliminate \u000f, reducing\nL\u0004\u0005 D 0 to\n\u0003rq \u0002 .q / C rp \u0002 .p / \u0003 @\n@V .V / C ˇ.V˘.q; p; V/ \u0003 PV C kBT/ D 0:\nThis results in\n\u0003 q \u0002 rq C p \u0002 rp \u0003 \u0003 V @ \n@V C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/ D 0:\n(8.74)\nA solution (the desired one) is given by\n / exp.\u0003ˇ.H C PV//;\nwhere substituting into (8.74) gives\nh\nˇq \u0002 rU.q/ \u0003 ˇp \u0002 M\u00021p \u0003 1 C ˇV @U\n@V\nCˇPV C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/\ni\n D 0;\nwhich is quickly checked to be true, and hence the dynamics preserves \u0005 D\nexp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .\nIt is difﬁcult to see how their could be other solutions , but we know from\nthe Nosé-Hoover case that this must be possible. We improve the robustness of\nthe method by introducing Ornstein-Uhlenbeck type stochastic processes in the two\nauxiliary variables \u0012 and \u000f, yielding the system\nPq D M\u00021p C \u000fq;\n(8.75)\nPp D F.q/ \u0003 \u000fp \u0003 \u0012p;\n(8.76)\nPV D \u000fV;\n(8.77)\nd\u0012 D ŒhT \u0003 \nT\u0012\t dt C\np\n2kBT\nT=\u0006TdWT;\n(8.78)\nd\u000f D ŒhP \u0003 \nP\u000f\t dt C\np\n2kBT\nP=\u0006PdWP;\n(8.79)\nwhere \nT; \nP \b 0 are two parameters governing the strength of the noise.\n8.8.2\nDiscretization of the NHL Piston\nObservations in Chap. 7 and our experience with the Nosé-Hoover-Langevinmethod\nlead us to propose splitting methods to separate the Ornstein-Uhlenbeck processes\n"
    }
  ],
  "numbered_equations": [
    "8.75",
    "8.76",
    "8.77",
    "8.78",
    "8.79"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "z.2=(V,ξ,η)，V>0、热浴/活塞质量正、独立二维Wiener明确；所有辅助变量除V均为实数。",
    "选择正体积域内的积分解类，不声明该类存在唯一或必然遍历；n=3N为物理情形。"
  ],
  "issues": [],
  "statement_scope": "实际压力、反馈、漂移扩散和正体积NHL活塞积分解规格。",
  "lean_decl": "MD.Ch08.PistonState",
  "lean_declarations": [
    "MD.Ch08.PistonState",
    "MD.Ch08.pistonPressure",
    "MD.Ch08.pistonDrift",
    "MD.Ch08.pistonNoise",
    "MD.Ch08.isNHLPistonSolution"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
abbrev PistonState (n : ℕ) := Phase n × Vec 3
def pistonPressure (invm : Vec n) (U : Vec n × ℝ → ℝ) (q p : Vec n) (V : ℝ) : ℝ :=
  (kineticTwice invm p-dot q (gradient (fun x ↦ U (x,V)) q)-
    V*deriv (fun v ↦ U (q,v)) V)/V
def pistonDrift (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (z : PistonState n) : PistonState n :=
  ((fun i ↦ invm i*z.1.2 i+z.2 2*z.1.1 i,
    fun i ↦ -gradient (fun q ↦ U (q,z.2 0)) z.1.1 i-(z.2 2+z.2 1)*z.1.2 i),
   ![z.2 2*z.2 0,(kineticTwice invm z.1.2-n*θ)/QT-γT*z.2 1,
     (z.2 0*pistonPressure invm U z.1.1 z.1.2 (z.2 0)-P*z.2 0+θ)/QP-γP*z.2 2])
def pistonNoise (θ QT QP γT γP : ℝ) (j : Fin 2) : PistonState n :=
  ((0,0),if j=0 then ![0,Real.sqrt (2*θ*γT/QT),0] else ![0,0,Real.sqrt (2*θ*γP/QP)])
def isNHLPistonSolution (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (μ : Measure Ω) (W : ℝ → Ω → Vec 2) (X : ℝ → Ω → PistonState n)
    (x0 : PistonState n) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < θ ∧ 0 < QT ∧ 0 < QP ∧ 0 ≤ γT ∧ 0 ≤ γP ∧
  ContDiff ℝ 2 U ∧ 0 < x0.2 0 ∧ (∀ t, 0 ≤ t → ∀ᵐ sample ∂μ, 0 < (X t sample).2 0) ∧
  additiveSDE μ 2 W X x0 (pistonDrift invm U θ P QT QP γT γP) (pistonNoise θ QT QP γT γP)
```

## MD-8.8.1-PistonHamiltonianSubfield
```json
{
  "source_id": "MD-8.8.1-PistonHamiltonianSubfield",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8.1",
  "printed_page": "381",
  "pdf_page": "402",
  "statement_latex": "ρ₁=φ₁(pᵀM⁻¹p/2+U(q))ψ(V,ξ,η) is stationary for the Hamiltonian part.",
  "statement_verbatim": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n381\n8.8.1\nEquations of Motion for the NHL Piston\nIn the framework of [199], rewriting the equations of motion for the physical\nvariables q and p, the dynamics takes the form\nPq D M\u00021p C \u000fq;\nPp D \u0003rU.q/ \u0003 \u000fp \u0003 \u0012p;\nPV D \u000fV;\nwith auxiliary variables \u000f and \u0012 governed by additional dynamical equations of\nmotion\nP\u0012 D hT\ndef\nD .pTM\u00021p \u0003 NdkBT/=\u0006T;\nP\u000f D hP\ndef\nD .V˘.q; p; V/ \u0003 PV C kBT/=\u0006P;\nwhere\n˘.q; p; V/\ndef\nD 1\nV\n\b\npTM\u00021p \u0003 q \u0002 rU.q/ \u0003 V @\n@V U.q/\n\t\n;\nis the expression for the pressure.\nNow let us examine the distribution conserved by the dynamics. First, we observe\n\u00051 D '1.pTM\u00021p=2 C U.q// \u0004 .V; \u0012; \u000f/\nis stationary for the Liouvillian operator for the vector ﬁeld .p; \u0003rU; 0; 0; 0/.\nThe function can be chosen as any smooth function that integrates out with\nrespect to V; \u0012; \u000f over Œ0; 1\t \u0004 R \u0004 R. We already know from our discussion of\nNosé-Hoover that Pp D \u0003\u0012p; P\u0012 D .pTM\u00021p \u0003 NdkBT/=\u0006T will have as stationary\nstates functions of the form\n\u00052 D exp.\u0003ˇŒpTM\u00021p C \u0006T\u00122=2\t/ 2.q; \u000f; V/:\nFinally the remaining terms Pq D \u000fq, Pp D \u0003\u000fp, PV D \u000fV, P\u000f D .V˘.q; p; V/ \u0003 PV C\nkBT/=\u0006P give rise to the Liouvillian\nL\u0004\u0005 D \u0003\u000frq \u0002.q\u0005/C\u000frp \u0002.p\u0005/\u0003\u000f @\n@V .V\u0005/\u0003 @\n@\u000fŒ\u0005.V˘.q; p; V/\u0003PV CkBT/=\u0006P\t:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 402,
      "printed_page": 381,
      "text": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n381\n8.8.1\nEquations of Motion for the NHL Piston\nIn the framework of [199], rewriting the equations of motion for the physical\nvariables q and p, the dynamics takes the form\nPq D M\u00021p C \u000fq;\nPp D \u0003rU.q/ \u0003 \u000fp \u0003 \u0012p;\nPV D \u000fV;\nwith auxiliary variables \u000f and \u0012 governed by additional dynamical equations of\nmotion\nP\u0012 D hT\ndef\nD .pTM\u00021p \u0003 NdkBT/=\u0006T;\nP\u000f D hP\ndef\nD .V˘.q; p; V/ \u0003 PV C kBT/=\u0006P;\nwhere\n˘.q; p; V/\ndef\nD 1\nV\n\b\npTM\u00021p \u0003 q \u0002 rU.q/ \u0003 V @\n@V U.q/\n\t\n;\nis the expression for the pressure.\nNow let us examine the distribution conserved by the dynamics. First, we observe\n\u00051 D '1.pTM\u00021p=2 C U.q// \u0004 .V; \u0012; \u000f/\nis stationary for the Liouvillian operator for the vector ﬁeld .p; \u0003rU; 0; 0; 0/.\nThe function can be chosen as any smooth function that integrates out with\nrespect to V; \u0012; \u000f over Œ0; 1\t \u0004 R \u0004 R. We already know from our discussion of\nNosé-Hoover that Pp D \u0003\u0012p; P\u0012 D .pTM\u00021p \u0003 NdkBT/=\u0006T will have as stationary\nstates functions of the form\n\u00052 D exp.\u0003ˇŒpTM\u00021p C \u0006T\u00122=2\t/ 2.q; \u000f; V/:\nFinally the remaining terms Pq D \u000fq, Pp D \u0003\u000fp, PV D \u000fV, P\u000f D .V˘.q; p; V/ \u0003 PV C\nkBT/=\u0006P give rise to the Liouvillian\nL\u0004\u0005 D \u0003\u000frq \u0002.q\u0005/C\u000frp \u0002.p\u0005/\u0003\u000f @\n@V .V\u0005/\u0003 @\n@\u000fŒ\u0005.V˘.q; p; V/\u0003PV CkBT/=\u0006P\t:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "只陈述实际通量散度为零；φ,ψ是权重而非自动概率密度，归一、可积和全局保测流不在本条。"
  ],
  "issues": [],
  "statement_scope": "Hamiltonian子场和其光滑复合权的局部驻定式。",
  "lean_decl": "MD.Ch08.pistonHamiltonianPart",
  "lean_declarations": [
    "MD.Ch08.pistonHamiltonianPart",
    "MD.Ch08.pistonHamiltonianWeight_stationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pistonHamiltonianPart (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n :=
  ((fun i ↦ invm i*z.1.2 i,-gradient (fun q ↦ U (q,z.2 0)) z.1.1),0)
theorem pistonHamiltonianWeight_stationary (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (φ : ℝ → ℝ) (ψ : Vec 3 → ℝ) (hU : ContDiff ℝ 2 U)
    (hφ : ContDiff ℝ 1 φ) (hψ : ContDiff ℝ 1 ψ) (z : PistonState n) :
    textbookDivergence (fun x : PistonState n ↦
      (φ (kineticTwice invm x.1.2/2+U (x.1.1,x.2 0))*ψ x.2) •
        pistonHamiltonianPart invm U x) z=0 := by
  sorry
```
