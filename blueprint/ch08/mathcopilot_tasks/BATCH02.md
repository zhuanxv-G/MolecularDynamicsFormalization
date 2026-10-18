# BATCH02 第8章原文与陈述审校

## MD-8.1.2-NHReversal
```json
{
  "source_id": "MD-8.1.2-NHReversal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.1.2",
  "printed_page": "333",
  "pdf_page": "354",
  "statement_latex": "Nosé-Hoover is time-reversible: changing the sign of p and ξ is equivalent to reversing time.",
  "statement_verbatim": "8.1\nDynamics-Based Thermostat Techniques\n333\nLet a further dynamical variable s be deﬁned by\nds\ndt D \u0012:\nThe extended Nosé-Hoover system then has a conserved quantity (see Exercise 2):\nINH.q; p; \u0012; s/ D H.q; p/ C \u0006\u00122\n2\nC Ndˇ\u00021 ln s:\n(8.8)\nThis integral can be used to monitor the performance of numerical methods.\n8.1.2\nNumerical Methods for Extended System Thermostats\nWe next describe some numerical procedures (based on the concept of splitting\nintroduced in Chaps. 2 and 3) which are appropriate for thermostats based on the\nincorporation of auxiliary variables.\nNosé-Hoover dynamics is not a Hamiltonian system, despite the presence of the\nmentioned ﬁrst integral. It is, however, time-reversible: changing the sign of p and\n\u0012 simultaneously in the equations of motion is equivalent to reversing the arrow of\ntime t ! \u0003t. For this reason, time-reversible numerical methods are often proposed\nfor Nosé-Hoover. A typical integrator is described below.\nTo simplify the notation and to use a format that might more closely match what\nwould be implemented in software, we write the algorithm for a single timestep of\nthe method in which positions, momenta and auxiliary variables are updated in situ.\nNosé-Hoover Timestep Map\nq :D q C .h=2/M\u00021p\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\n\u0012 :D \u0012 C h\u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\nq :D q C .h=2/M\u00021p\nHere we have solved successively, the ﬁrst, second and third equations, sequen-\ntially, and then in reverse order to make a symmetric (and second order) integrator.\nThe auxiliary function involved c.t; \u0012/ D 1\u0002e\u0002t\u0012\n\u0012\nis easily evaluated from a few terms\nof its Maclaurin series expansion\nc.t; \u0012/ D t \u0003 t2\u0012=2 C : : :\nIt is easy to verify that this method is time-reversible. If we write the timestep map\nas .q; p; \u0012/ 7! Gh.q; p; \u0012/, then we may check that\nR ı Gh ı R D G \u00021\nh ;\nR.q; p; \u0012/ D .q; \u0003p; \u0003\u0012/:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 354,
      "printed_page": 333,
      "text": "8.1\nDynamics-Based Thermostat Techniques\n333\nLet a further dynamical variable s be deﬁned by\nds\ndt D \u0012:\nThe extended Nosé-Hoover system then has a conserved quantity (see Exercise 2):\nINH.q; p; \u0012; s/ D H.q; p/ C \u0006\u00122\n2\nC Ndˇ\u00021 ln s:\n(8.8)\nThis integral can be used to monitor the performance of numerical methods.\n8.1.2\nNumerical Methods for Extended System Thermostats\nWe next describe some numerical procedures (based on the concept of splitting\nintroduced in Chaps. 2 and 3) which are appropriate for thermostats based on the\nincorporation of auxiliary variables.\nNosé-Hoover dynamics is not a Hamiltonian system, despite the presence of the\nmentioned ﬁrst integral. It is, however, time-reversible: changing the sign of p and\n\u0012 simultaneously in the equations of motion is equivalent to reversing the arrow of\ntime t ! \u0003t. For this reason, time-reversible numerical methods are often proposed\nfor Nosé-Hoover. A typical integrator is described below.\nTo simplify the notation and to use a format that might more closely match what\nwould be implemented in software, we write the algorithm for a single timestep of\nthe method in which positions, momenta and auxiliary variables are updated in situ.\nNosé-Hoover Timestep Map\nq :D q C .h=2/M\u00021p\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\n\u0012 :D \u0012 C h\u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\nq :D q C .h=2/M\u00021p\nHere we have solved successively, the ﬁrst, second and third equations, sequen-\ntially, and then in reverse order to make a symmetric (and second order) integrator.\nThe auxiliary function involved c.t; \u0012/ D 1\u0002e\u0002t\u0012\n\u0012\nis easily evaluated from a few terms\nof its Maclaurin series expansion\nc.t; \u0012/ D t \u0003 t2\u0012=2 C : : :\nIt is easy to verify that this method is time-reversible. If we write the timestep map\nas .q; p; \u0012/ 7! Gh.q; p; \u0012/, then we may check that\nR ı Gh ı R D G \u00021\nh ;\nR.q; p; \u0012/ D .q; \u0003p; \u0003\u0012/:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [],
  "issues": [],
  "statement_scope": "反演为对合及向量场反演等式；不另称一般ODE流的全局反演定理。",
  "lean_decl": "MD.Ch08.nhReversal",
  "lean_declarations": [
    "MD.Ch08.nhReversal",
    "MD.Ch08.nhReversal_involutive",
    "MD.Ch08.nhReversal_field"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nhReversal (z : Phase n × ℝ) : Phase n × ℝ := ((z.1.1, -z.1.2), -z.2)
theorem nhReversal_involutive : Function.Involutive (nhReversal (n:=n)) := by
  intro z; ext <;> simp [nhReversal]
theorem nhReversal_field (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) :
  nhField invm U β Q (nhReversal z) =
    ((fun i ↦ -(nhField invm U β Q z).1.1 i, (nhField invm U β Q z).1.2), (nhField invm U β Q z).2) := by
  ext <;> simp [nhField, nhReversal, kineticTwice] <;> ring
```

## MD-8.1.2-NHTimestep
```json
{
  "source_id": "MD-8.1.2-NHTimestep",
  "kind": "definition",
  "label": null,
  "section": "8.1.2",
  "printed_page": "333",
  "pdf_page": "354",
  "statement_latex": "Nosé-Hoover Timestep Map: drift(h/2), damped force(h/2), ξ-update(h), damped force(h/2), drift(h/2). c(t,ξ)=(1-e^{-tξ})/ξ=t-t²ξ/2+⋯.",
  "statement_verbatim": "8.1\nDynamics-Based Thermostat Techniques\n333\nLet a further dynamical variable s be deﬁned by\nds\ndt D \u0012:\nThe extended Nosé-Hoover system then has a conserved quantity (see Exercise 2):\nINH.q; p; \u0012; s/ D H.q; p/ C \u0006\u00122\n2\nC Ndˇ\u00021 ln s:\n(8.8)\nThis integral can be used to monitor the performance of numerical methods.\n8.1.2\nNumerical Methods for Extended System Thermostats\nWe next describe some numerical procedures (based on the concept of splitting\nintroduced in Chaps. 2 and 3) which are appropriate for thermostats based on the\nincorporation of auxiliary variables.\nNosé-Hoover dynamics is not a Hamiltonian system, despite the presence of the\nmentioned ﬁrst integral. It is, however, time-reversible: changing the sign of p and\n\u0012 simultaneously in the equations of motion is equivalent to reversing the arrow of\ntime t ! \u0003t. For this reason, time-reversible numerical methods are often proposed\nfor Nosé-Hoover. A typical integrator is described below.\nTo simplify the notation and to use a format that might more closely match what\nwould be implemented in software, we write the algorithm for a single timestep of\nthe method in which positions, momenta and auxiliary variables are updated in situ.\nNosé-Hoover Timestep Map\nq :D q C .h=2/M\u00021p\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\n\u0012 :D \u0012 C h\u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\nq :D q C .h=2/M\u00021p\nHere we have solved successively, the ﬁrst, second and third equations, sequen-\ntially, and then in reverse order to make a symmetric (and second order) integrator.\nThe auxiliary function involved c.t; \u0012/ D 1\u0002e\u0002t\u0012\n\u0012\nis easily evaluated from a few terms\nof its Maclaurin series expansion\nc.t; \u0012/ D t \u0003 t2\u0012=2 C : : :\nIt is easy to verify that this method is time-reversible. If we write the timestep map\nas .q; p; \u0012/ 7! Gh.q; p; \u0012/, then we may check that\nR ı Gh ı R D G \u00021\nh ;\nR.q; p; \u0012/ D .q; \u0003p; \u0003\u0012/:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 354,
      "printed_page": 333,
      "text": "8.1\nDynamics-Based Thermostat Techniques\n333\nLet a further dynamical variable s be deﬁned by\nds\ndt D \u0012:\nThe extended Nosé-Hoover system then has a conserved quantity (see Exercise 2):\nINH.q; p; \u0012; s/ D H.q; p/ C \u0006\u00122\n2\nC Ndˇ\u00021 ln s:\n(8.8)\nThis integral can be used to monitor the performance of numerical methods.\n8.1.2\nNumerical Methods for Extended System Thermostats\nWe next describe some numerical procedures (based on the concept of splitting\nintroduced in Chaps. 2 and 3) which are appropriate for thermostats based on the\nincorporation of auxiliary variables.\nNosé-Hoover dynamics is not a Hamiltonian system, despite the presence of the\nmentioned ﬁrst integral. It is, however, time-reversible: changing the sign of p and\n\u0012 simultaneously in the equations of motion is equivalent to reversing the arrow of\ntime t ! \u0003t. For this reason, time-reversible numerical methods are often proposed\nfor Nosé-Hoover. A typical integrator is described below.\nTo simplify the notation and to use a format that might more closely match what\nwould be implemented in software, we write the algorithm for a single timestep of\nthe method in which positions, momenta and auxiliary variables are updated in situ.\nNosé-Hoover Timestep Map\nq :D q C .h=2/M\u00021p\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\n\u0012 :D \u0012 C h\u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\nq :D q C .h=2/M\u00021p\nHere we have solved successively, the ﬁrst, second and third equations, sequen-\ntially, and then in reverse order to make a symmetric (and second order) integrator.\nThe auxiliary function involved c.t; \u0012/ D 1\u0002e\u0002t\u0012\n\u0012\nis easily evaluated from a few terms\nof its Maclaurin series expansion\nc.t; \u0012/ D t \u0003 t2\u0012=2 C : : :\nIt is easy to verify that this method is time-reversible. If we write the timestep map\nas .q; p; \u0012/ 7! Gh.q; p; \u0012/, then we may check that\nR ı Gh ı R D G \u00021\nh ;\nR.q; p; \u0012/ D .q; \u0003p; \u0003\u0012/:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "c在ξ=0处取连续延拓t；系数Taylor级数与二阶全局误差未由单步定义证明。"
  ],
  "issues": [],
  "statement_scope": "五段单步算法与c的可去奇点延拓；Taylor展开及二阶收敛列覆盖缺口。",
  "lean_decl": "MD.Ch08.dampedCoefficient",
  "lean_declarations": [
    "MD.Ch08.dampedCoefficient",
    "MD.Ch08.nhDrift",
    "MD.Ch08.nhKick",
    "MD.Ch08.nhFeedback",
    "MD.Ch08.nhStep",
    "MD.Ch08.dampedCoefficient_zero"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def dampedCoefficient (t ξ : ℝ) : ℝ := if ξ = 0 then t else (1-Real.exp (-t*ξ))/ξ
def nhDrift (invm : Vec n) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.1.1 i + h*invm i*z.1.2 i, z.1.2), z.2)
def nhKick (U : Vec n → ℝ) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ Real.exp (-h*z.2)*z.1.2 i - dampedCoefficient h z.2*gradient U z.1.1 i), z.2)
def nhFeedback (invm : Vec n) (β Q h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, z.2 + h/Q*(kineticTwice invm z.1.2 - (n : ℝ)/β))
def nhStep (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  nhDrift invm (h/2) ∘ nhKick U (h/2) ∘ nhFeedback invm β Q h ∘ nhKick U (h/2) ∘ nhDrift invm (h/2)
theorem dampedCoefficient_zero (t : ℝ) : dampedCoefficient t 0 = t := by simp [dampedCoefficient]
```

## MD-8.1.2-NHTimestepReversible
```json
{
  "source_id": "MD-8.1.2-NHTimestepReversible",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.1.2",
  "printed_page": "333",
  "pdf_page": "354",
  "statement_latex": "R∘G_h∘R=G_h^{-1}, R(q,p,ξ)=(q,-p,-ξ).",
  "statement_verbatim": "8.1\nDynamics-Based Thermostat Techniques\n333\nLet a further dynamical variable s be deﬁned by\nds\ndt D \u0012:\nThe extended Nosé-Hoover system then has a conserved quantity (see Exercise 2):\nINH.q; p; \u0012; s/ D H.q; p/ C \u0006\u00122\n2\nC Ndˇ\u00021 ln s:\n(8.8)\nThis integral can be used to monitor the performance of numerical methods.\n8.1.2\nNumerical Methods for Extended System Thermostats\nWe next describe some numerical procedures (based on the concept of splitting\nintroduced in Chaps. 2 and 3) which are appropriate for thermostats based on the\nincorporation of auxiliary variables.\nNosé-Hoover dynamics is not a Hamiltonian system, despite the presence of the\nmentioned ﬁrst integral. It is, however, time-reversible: changing the sign of p and\n\u0012 simultaneously in the equations of motion is equivalent to reversing the arrow of\ntime t ! \u0003t. For this reason, time-reversible numerical methods are often proposed\nfor Nosé-Hoover. A typical integrator is described below.\nTo simplify the notation and to use a format that might more closely match what\nwould be implemented in software, we write the algorithm for a single timestep of\nthe method in which positions, momenta and auxiliary variables are updated in situ.\nNosé-Hoover Timestep Map\nq :D q C .h=2/M\u00021p\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\n\u0012 :D \u0012 C h\u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\nq :D q C .h=2/M\u00021p\nHere we have solved successively, the ﬁrst, second and third equations, sequen-\ntially, and then in reverse order to make a symmetric (and second order) integrator.\nThe auxiliary function involved c.t; \u0012/ D 1\u0002e\u0002t\u0012\n\u0012\nis easily evaluated from a few terms\nof its Maclaurin series expansion\nc.t; \u0012/ D t \u0003 t2\u0012=2 C : : :\nIt is easy to verify that this method is time-reversible. If we write the timestep map\nas .q; p; \u0012/ 7! Gh.q; p; \u0012/, then we may check that\nR ı Gh ı R D G \u00021\nh ;\nR.q; p; \u0012/ D .q; \u0003p; \u0003\u0012/:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 354,
      "printed_page": 333,
      "text": "8.1\nDynamics-Based Thermostat Techniques\n333\nLet a further dynamical variable s be deﬁned by\nds\ndt D \u0012:\nThe extended Nosé-Hoover system then has a conserved quantity (see Exercise 2):\nINH.q; p; \u0012; s/ D H.q; p/ C \u0006\u00122\n2\nC Ndˇ\u00021 ln s:\n(8.8)\nThis integral can be used to monitor the performance of numerical methods.\n8.1.2\nNumerical Methods for Extended System Thermostats\nWe next describe some numerical procedures (based on the concept of splitting\nintroduced in Chaps. 2 and 3) which are appropriate for thermostats based on the\nincorporation of auxiliary variables.\nNosé-Hoover dynamics is not a Hamiltonian system, despite the presence of the\nmentioned ﬁrst integral. It is, however, time-reversible: changing the sign of p and\n\u0012 simultaneously in the equations of motion is equivalent to reversing the arrow of\ntime t ! \u0003t. For this reason, time-reversible numerical methods are often proposed\nfor Nosé-Hoover. A typical integrator is described below.\nTo simplify the notation and to use a format that might more closely match what\nwould be implemented in software, we write the algorithm for a single timestep of\nthe method in which positions, momenta and auxiliary variables are updated in situ.\nNosé-Hoover Timestep Map\nq :D q C .h=2/M\u00021p\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\n\u0012 :D \u0012 C h\u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\nq :D q C .h=2/M\u00021p\nHere we have solved successively, the ﬁrst, second and third equations, sequen-\ntially, and then in reverse order to make a symmetric (and second order) integrator.\nThe auxiliary function involved c.t; \u0012/ D 1\u0002e\u0002t\u0012\n\u0012\nis easily evaluated from a few terms\nof its Maclaurin series expansion\nc.t; \u0012/ D t \u0003 t2\u0012=2 C : : :\nIt is easy to verify that this method is time-reversible. If we write the timestep map\nas .q; p; \u0012/ 7! Gh.q; p; \u0012/, then we may check that\nR ı Gh ı R D G \u00021\nh ;\nR.q; p; \u0012/ D .q; \u0003p; \u0003\u0012/:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "逆映射以负步长映射及LeftInverse表达；不假设算法可逆作为结论的前提。"
  ],
  "issues": [],
  "statement_scope": "五段单步的反演等式及负步长左逆两个目标；未建立误差阶数。",
  "lean_decl": "MD.Ch08.nhStep_reversible",
  "lean_declarations": [
    "MD.Ch08.nhStep_reversible",
    "MD.Ch08.nhStep_inverse"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem nhStep_reversible (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    nhReversal ∘ nhStep invm U β Q h ∘ nhReversal = nhStep invm U β Q (-h) := by
  sorry
theorem nhStep_inverse (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    Function.LeftInverse (nhStep invm U β Q (-h)) (nhStep invm U β Q h) := by
  sorry
```

## MD-8.1.2.1-NoseHamiltoniansPrinted
```json
{
  "source_id": "MD-8.1.2.1-NoseHamiltoniansPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.1.2.1",
  "printed_page": "334",
  "pdf_page": "355",
  "statement_latex": "H_N= p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+(N_d+1)k_BT ln s; H_NP=s[H_N-E_N]=s[p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+N_d k_BT ln s-E_N].",
  "statement_verbatim": "334\n8\nExtended Variable Methods\n8.1.2.1\nNosé-Poincaré Dynamics: A Symplectic Approach\nAs we have seen in earlier chapters, there is a strong foundation for using symplectic\nintegrators, for example the existence of perturbative backward error expansions\nwhich are relatively easily calculated, it is desirable to work within this class. On\nthe other hand, as we have mentioned, Nosé-Hoover dynamics is not a Hamiltonian\nsystem. The Nosé-Poincaré method resolves this issue by providing a Hamiltonian-\nbased extension of the physical system whose projected trajectories are actually\nequivalent to Nosé-Hoover trajectories, in the absence of numerical errors. This\nextended Hamiltonian system can then be discretized using a symplectic method.\nNosé’s original proposal involved using the dynamics of the Hamiltonian\nHN D 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C .Nd C 1/kBT ln s\nto deﬁne an extension which can be used for canonical sampling. The dynamics\nfor constant Nosé extended energy, when reduced to the .q; p D Qp=s/ plane will\npreserve the canonical measure \u0005ˇ. However, the scaling of kinetic energy induces\na time transformation, which is inconvenient for molecular modelling purposes. The\nNosé-Poincaré method introduces an explicit unraveling of the time transformation.\nOne works with the modiﬁed Nosé-Poincaré (NP) Hamiltonian [41, 102]:\nHNP D sŒHN \u0003 EN\t D s\n\u0002 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C NdkBT ln s \u0003 EN\n\u0003\n;\n(8.9)\nwhere EN is a constant equal to the initial Nosé energy of the system. Trajectories of\nthis system unfold on a timescale which is in some sense commensurate with that of\nHamiltonian dynamics. The NP Hamiltonian system can be treated with symplectic\nintegrators, conferring a possible stability advantage. Symplectic integrators for this\nsystem are compared in [41].\nThe equations of motion associated to (8.9) are\nd\ndtq D M\u00021Qp=s;\n(8.10)\nd\ndt Qp D sF;\n(8.11)\nd\ndts D sps=\u0006;\n(8.12)\nd\ndtps D QpTM\u00021Qp\ns2\n\u0003 NdkBT \u0003 \u0016HN;\n(8.13)\nwhere \u0016HN D HN \u0003 H0\nN (H0\nN represents the value of the Nosé Hamiltonian at the\ninitial point).\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 355,
      "printed_page": 334,
      "text": "334\n8\nExtended Variable Methods\n8.1.2.1\nNosé-Poincaré Dynamics: A Symplectic Approach\nAs we have seen in earlier chapters, there is a strong foundation for using symplectic\nintegrators, for example the existence of perturbative backward error expansions\nwhich are relatively easily calculated, it is desirable to work within this class. On\nthe other hand, as we have mentioned, Nosé-Hoover dynamics is not a Hamiltonian\nsystem. The Nosé-Poincaré method resolves this issue by providing a Hamiltonian-\nbased extension of the physical system whose projected trajectories are actually\nequivalent to Nosé-Hoover trajectories, in the absence of numerical errors. This\nextended Hamiltonian system can then be discretized using a symplectic method.\nNosé’s original proposal involved using the dynamics of the Hamiltonian\nHN D 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C .Nd C 1/kBT ln s\nto deﬁne an extension which can be used for canonical sampling. The dynamics\nfor constant Nosé extended energy, when reduced to the .q; p D Qp=s/ plane will\npreserve the canonical measure \u0005ˇ. However, the scaling of kinetic energy induces\na time transformation, which is inconvenient for molecular modelling purposes. The\nNosé-Poincaré method introduces an explicit unraveling of the time transformation.\nOne works with the modiﬁed Nosé-Poincaré (NP) Hamiltonian [41, 102]:\nHNP D sŒHN \u0003 EN\t D s\n\u0002 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C NdkBT ln s \u0003 EN\n\u0003\n;\n(8.9)\nwhere EN is a constant equal to the initial Nosé energy of the system. Trajectories of\nthis system unfold on a timescale which is in some sense commensurate with that of\nHamiltonian dynamics. The NP Hamiltonian system can be treated with symplectic\nintegrators, conferring a possible stability advantage. Symplectic integrators for this\nsystem are compared in [41].\nThe equations of motion associated to (8.9) are\nd\ndtq D M\u00021Qp=s;\n(8.10)\nd\ndt Qp D sF;\n(8.11)\nd\ndts D sps=\u0006;\n(8.12)\nd\ndtps D QpTM\u00021Qp\ns2\n\u0003 NdkBT \u0003 \u0016HN;\n(8.13)\nwhere \u0016HN D HN \u0003 H0\nN (H0\nN represents the value of the Nosé Hamiltonian at the\ninitial point).\n"
    }
  ],
  "numbered_equations": [
    "8.9"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "物理定义域s>0、β,Q及质量正；总函数在此域外不作物理解释。"
  ],
  "issues": [
    "已目视核对原页PDF355：H_N先用(N_d+1)，(8.9)展开却用N_d；同名H_N等号不一致。工作修正显式减去β⁻¹ln s。"
  ],
  "statement_scope": "两个原印Hamiltonian定义、所印等式目标及减去对数差项后的代数修正。",
  "lean_decl": "MD.Ch08.noseHamiltonian",
  "lean_declarations": [
    "MD.Ch08.noseHamiltonian",
    "MD.Ch08.npHamiltonian",
    "MD.Ch08.nosePoincarePrinted",
    "MD.Ch08.nosePoincare_corrected"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def noseHamiltonian (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (q p : Vec n) (s π : ℝ) : ℝ :=
  kineticTwice invm p / (2*s^2) + π^2/(2*Q) + U q + ((n : ℝ)+1)/β*Real.log s
def npHamiltonian (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (q p : Vec n) (s π : ℝ) : ℝ :=
  s*(kineticTwice invm p/(2*s^2) + π^2/(2*Q) + U q + (n : ℝ)/β*Real.log s - EN)
theorem nosePoincarePrinted (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (hp : thermostatParameters invm β Q) (q p : Vec n) (s π : ℝ) (hs : 0 < s) :
    npHamiltonian invm U β Q EN q p s π = s*(noseHamiltonian invm U β Q q p s π-EN) := by
  sorry
theorem nosePoincare_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (q p : Vec n) (s π : ℝ) :
    npHamiltonian invm U β Q EN q p s π = s*(noseHamiltonian invm U β Q q p s π-Real.log s/β-EN) := by
  unfold npHamiltonian noseHamiltonian
  ring
```

## MD-8.1.2.1-NPEquations
```json
{
  "source_id": "MD-8.1.2.1-NPEquations",
  "kind": "definition",
  "label": null,
  "section": "8.1.2.1",
  "printed_page": "334",
  "pdf_page": "355",
  "statement_latex": "q̇=M⁻¹p̃/s, p̃̇=sF, ṡ=sp_s/μ, ṗ_s=p̃ᵀM⁻¹p̃/s²-N_d k_BT-ΔH_N.",
  "statement_verbatim": "334\n8\nExtended Variable Methods\n8.1.2.1\nNosé-Poincaré Dynamics: A Symplectic Approach\nAs we have seen in earlier chapters, there is a strong foundation for using symplectic\nintegrators, for example the existence of perturbative backward error expansions\nwhich are relatively easily calculated, it is desirable to work within this class. On\nthe other hand, as we have mentioned, Nosé-Hoover dynamics is not a Hamiltonian\nsystem. The Nosé-Poincaré method resolves this issue by providing a Hamiltonian-\nbased extension of the physical system whose projected trajectories are actually\nequivalent to Nosé-Hoover trajectories, in the absence of numerical errors. This\nextended Hamiltonian system can then be discretized using a symplectic method.\nNosé’s original proposal involved using the dynamics of the Hamiltonian\nHN D 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C .Nd C 1/kBT ln s\nto deﬁne an extension which can be used for canonical sampling. The dynamics\nfor constant Nosé extended energy, when reduced to the .q; p D Qp=s/ plane will\npreserve the canonical measure \u0005ˇ. However, the scaling of kinetic energy induces\na time transformation, which is inconvenient for molecular modelling purposes. The\nNosé-Poincaré method introduces an explicit unraveling of the time transformation.\nOne works with the modiﬁed Nosé-Poincaré (NP) Hamiltonian [41, 102]:\nHNP D sŒHN \u0003 EN\t D s\n\u0002 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C NdkBT ln s \u0003 EN\n\u0003\n;\n(8.9)\nwhere EN is a constant equal to the initial Nosé energy of the system. Trajectories of\nthis system unfold on a timescale which is in some sense commensurate with that of\nHamiltonian dynamics. The NP Hamiltonian system can be treated with symplectic\nintegrators, conferring a possible stability advantage. Symplectic integrators for this\nsystem are compared in [41].\nThe equations of motion associated to (8.9) are\nd\ndtq D M\u00021Qp=s;\n(8.10)\nd\ndt Qp D sF;\n(8.11)\nd\ndts D sps=\u0006;\n(8.12)\nd\ndtps D QpTM\u00021Qp\ns2\n\u0003 NdkBT \u0003 \u0016HN;\n(8.13)\nwhere \u0016HN D HN \u0003 H0\nN (H0\nN represents the value of the Nosé Hamiltonian at the\ninitial point).\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 355,
      "printed_page": 334,
      "text": "334\n8\nExtended Variable Methods\n8.1.2.1\nNosé-Poincaré Dynamics: A Symplectic Approach\nAs we have seen in earlier chapters, there is a strong foundation for using symplectic\nintegrators, for example the existence of perturbative backward error expansions\nwhich are relatively easily calculated, it is desirable to work within this class. On\nthe other hand, as we have mentioned, Nosé-Hoover dynamics is not a Hamiltonian\nsystem. The Nosé-Poincaré method resolves this issue by providing a Hamiltonian-\nbased extension of the physical system whose projected trajectories are actually\nequivalent to Nosé-Hoover trajectories, in the absence of numerical errors. This\nextended Hamiltonian system can then be discretized using a symplectic method.\nNosé’s original proposal involved using the dynamics of the Hamiltonian\nHN D 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C .Nd C 1/kBT ln s\nto deﬁne an extension which can be used for canonical sampling. The dynamics\nfor constant Nosé extended energy, when reduced to the .q; p D Qp=s/ plane will\npreserve the canonical measure \u0005ˇ. However, the scaling of kinetic energy induces\na time transformation, which is inconvenient for molecular modelling purposes. The\nNosé-Poincaré method introduces an explicit unraveling of the time transformation.\nOne works with the modiﬁed Nosé-Poincaré (NP) Hamiltonian [41, 102]:\nHNP D sŒHN \u0003 EN\t D s\n\u0002 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C NdkBT ln s \u0003 EN\n\u0003\n;\n(8.9)\nwhere EN is a constant equal to the initial Nosé energy of the system. Trajectories of\nthis system unfold on a timescale which is in some sense commensurate with that of\nHamiltonian dynamics. The NP Hamiltonian system can be treated with symplectic\nintegrators, conferring a possible stability advantage. Symplectic integrators for this\nsystem are compared in [41].\nThe equations of motion associated to (8.9) are\nd\ndtq D M\u00021Qp=s;\n(8.10)\nd\ndt Qp D sF;\n(8.11)\nd\ndts D sps=\u0006;\n(8.12)\nd\ndtps D QpTM\u00021Qp\ns2\n\u0003 NdkBT \u0003 \u0016HN;\n(8.13)\nwhere \u0016HN D HN \u0003 H0\nN (H0\nN represents the value of the Nosé Hamiltonian at the\ninitial point).\n"
    }
  ],
  "numbered_equations": [
    "8.10",
    "8.11",
    "8.12",
    "8.13"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "ΔH采用(8.9)展开内的N_d版本；β,Q>0及s>0为有效域；尚未桥接实际Hamiltonian梯度。"
  ],
  "issues": [],
  "statement_scope": "四个NP漂移分量的实际定义；从Hamiltonian求导得到这些分量未证。",
  "lean_decl": "MD.Ch08.npField",
  "lean_declarations": [
    "MD.Ch08.npField"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def npField (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : Phase n × (ℝ × ℝ) :=
  let s := z.2.1
  let π := z.2.2
  let delta := kineticTwice invm z.1.2/(2*s^2) + π^2/(2*Q) + U z.1.1 + (n : ℝ)/β*Real.log s - EN
  ((fun i ↦ invm i*z.1.2 i/s, fun i ↦ -s*gradient U z.1.1 i),
   (s*π/Q, kineticTwice invm z.1.2/s^2-(n : ℝ)/β-delta))
```

## MD-8.1.2.1-NPtoNH
```json
{
  "source_id": "MD-8.1.2.1-NPtoNH",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.1.2.1",
  "printed_page": "335",
  "pdf_page": "356",
  "statement_latex": "p=p̃/s, ξ=p_s/μ; ṡ=sξ, ξ̇=μ⁻¹(pᵀM⁻¹p-N_d k_BT-ΔH_N). The perturbation vanishes along the exact solution.",
  "statement_verbatim": "8.1\nDynamics-Based Thermostat Techniques\n335\nThe relation between (8.10)–(8.13) and (8.2)–(8.4) becomes evident through the\nsubstitution p D Qp=s and \u0012 D ps=\u0006. Then (8.10)–(8.11) are seen to be the same\nas the corresponding equations in the Nosé-Hoover method, and the ﬁnal pair of\nequations become\nd\ndts D s\u0012;\nd\ndt\u0012 D 1\n\u0006\n\u0004\npTM\u00021p \u0003 NdkBT \u0003 \u0016HN\n\u0005\n:\nThe only difference between the last equation and (8.4) lies in the perturbation\n\u0006\u00021\u0016HN, which is zero along the exact solution. Under discretization, however,\nwe do not expect \u0016HN to vanish, so trajectories obtained from Nosé-Poincaré and\nNosé-Hoover will differ considerably over long time simulations.\nA beneﬁt of respecting the symplectic structure lies in the prospect of using\nbackward error analysis to analyze the behavior of the method. As shown in [40] it\nis possible to work out the terms of the perturbative expansion of the Nosé-Poincaré\nHamiltonian, i.e. to calculate the expansion\nQHh D HNP C h2HŒ2\t C O.h4/\nfor a second order, symmetric, symplectic numerical method. Then one may\ndetermine the effective distribution associated to the symplectic discretization\nmethod by “integrating out” the microcanonical density with respect to the auxiliary\nvariable and its conjugate momentum. One obtains in this way\nQ\u0005 .q; p/ D \u0005ˇ.q; p/\u0018.q; p; h/ C O\n\u0004\nh4\u0005\n:\nAn explicit formula for \u0018 is given in [40] for several symplectic methods. During\nsimulation, one may calculate the factor \u0018 and use this quantity to adjust averages.\nFor example, if we wish to calculate the average of a function g.q; p/, we may\nperform the calculation using \u0003 steps of the Nosé-Poincaré method with the given\nsymplectic, time-reversible, second order integrator, calculate gn and \u0018n at each\ntimestep, and approximate the canonical average from\nhgi D\n1\n\u0003 C 1\n\u0003\nX\nnD0\ngn\u0018\u00021\nn\nC O.h4/:\nFor further details, refer to [40]. Technically, a similar calculation can be carried out\nfor the Nosé-Hoover formulation, but the calculations are more involved.\nA good symplectic integrator for Nosé-Poincaré has been given by Nosé [287].\nFor further discussion and numerical experiments using this idea, see [94] (which\nalso considers stochastic methods).\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 356,
      "printed_page": 335,
      "text": "8.1\nDynamics-Based Thermostat Techniques\n335\nThe relation between (8.10)–(8.13) and (8.2)–(8.4) becomes evident through the\nsubstitution p D Qp=s and \u0012 D ps=\u0006. Then (8.10)–(8.11) are seen to be the same\nas the corresponding equations in the Nosé-Hoover method, and the ﬁnal pair of\nequations become\nd\ndts D s\u0012;\nd\ndt\u0012 D 1\n\u0006\n\u0004\npTM\u00021p \u0003 NdkBT \u0003 \u0016HN\n\u0005\n:\nThe only difference between the last equation and (8.4) lies in the perturbation\n\u0006\u00021\u0016HN, which is zero along the exact solution. Under discretization, however,\nwe do not expect \u0016HN to vanish, so trajectories obtained from Nosé-Poincaré and\nNosé-Hoover will differ considerably over long time simulations.\nA beneﬁt of respecting the symplectic structure lies in the prospect of using\nbackward error analysis to analyze the behavior of the method. As shown in [40] it\nis possible to work out the terms of the perturbative expansion of the Nosé-Poincaré\nHamiltonian, i.e. to calculate the expansion\nQHh D HNP C h2HŒ2\t C O.h4/\nfor a second order, symmetric, symplectic numerical method. Then one may\ndetermine the effective distribution associated to the symplectic discretization\nmethod by “integrating out” the microcanonical density with respect to the auxiliary\nvariable and its conjugate momentum. One obtains in this way\nQ\u0005 .q; p/ D \u0005ˇ.q; p/\u0018.q; p; h/ C O\n\u0004\nh4\u0005\n:\nAn explicit formula for \u0018 is given in [40] for several symplectic methods. During\nsimulation, one may calculate the factor \u0018 and use this quantity to adjust averages.\nFor example, if we wish to calculate the average of a function g.q; p/, we may\nperform the calculation using \u0003 steps of the Nosé-Poincaré method with the given\nsymplectic, time-reversible, second order integrator, calculate gn and \u0018n at each\ntimestep, and approximate the canonical average from\nhgi D\n1\n\u0003 C 1\n\u0003\nX\nnD0\ngn\u0018\u00021\nn\nC O.h4/:\nFor further details, refer to [40]. Technically, a similar calculation can be carried out\nfor the Nosé-Hoover formulation, but the calculations are more involved.\nA good symplectic integrator for Nosé-Poincaré has been given by Nosé [287].\nFor further discussion and numerical experiments using this idea, see [94] (which\nalso considers stochastic methods).\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "明确零能量面及s>0；零能量守恒本身未假作普遍结论。"
  ],
  "issues": [],
  "statement_scope": "给定零能量NP解投影为NH解；NP零能量初值传播和非零能量修正列缺口。",
  "lean_decl": "MD.Ch08.npProjection",
  "lean_declarations": [
    "MD.Ch08.npProjection",
    "MD.Ch08.npProjection_equations"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def npProjection (z : Phase n × (ℝ × ℝ)) (Q : ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ z.1.2 i/z.2.1), z.2.2/Q)
theorem npProjection_equations (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (hp : thermostatParameters invm β Q) (z : ℝ → Phase n × (ℝ × ℝ))
    (hz : ∀ t, HasDerivAt z (npField invm U β Q EN (z t)) t)
    (hs : ∀ t, 0 < (z t).2.1)
    (henergy : ∀ t, npHamiltonian invm U β Q EN (z t).1.1 (z t).1.2 (z t).2.1 (z t).2.2 = 0) :
    isNHSolution invm U β Q (fun t ↦ npProjection (z t) Q) := by
  sorry
```
