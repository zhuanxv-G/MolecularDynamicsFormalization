# BATCH04 第8章原文与陈述审校

## MD-8.2.1-Proposition81
```json
{
  "source_id": "MD-8.2.1-Proposition81",
  "kind": "proposition",
  "label": "Proposition 8.1",
  "section": "8.2.1",
  "printed_page": "338–339",
  "pdf_page": "359–360",
  "statement_latex": "Two thermostats preserving a(ξ)ρ_β and b(η)ρ_β can be added and preserve a(ξ)b(η)ρ_β.",
  "statement_verbatim": "338\n8\nExtended Variable Methods\nThis is a slightly generalized form of the technique suggested by Bulgac and\nKusnezov [58].\nAssuming \u0005 goes to zero sufﬁciently rapidly at inﬁnity, we have\nZ\nrz \u0002 G.z/\u0005d! D \u0003\nZ\n.rz\u0005/ \u0002 G.z/d! D ˇ\nZ\nrzH \u0002 G.z/\u0005d!;\nusing integration by parts, therefore, since ˇ\u00021 D kBT,\nT D k\u00021\nB\nhrzH \u0002 Gi\nhr \u0002 Gi ;\nwhich gives formulas for temperature in terms of phase space averages (compare\nChap. 6, Proposition 6.1).\nSuppose we let K be a scalar valued function of position, and set\nG.z/ D\n\u0002 rqK.q/\n0\n\u0003\nthen we arrive at\ng.z/ D \u0006\u00021ŒrqU \u0003 kBTrq\t \u0002 rqK.q/:\nThis is an example of a “conﬁgurational thermostat” [193, 211, 319].\nA useful fact about thermostats is the following:\nProposition 8.1 (Thermostats are Additive) Suppose we are given two ther-\nmostats,\nPz D JrH C ˚1.\u0002; z/;\nP\u0002 D g1.\u0002; z/;\nwith stationary density O\u00051.\u0002/\u0005ˇ, and another\nPz D JrH C ˚2.\u0003; z/;\nP\u0003 D g2.\u0003; z/;\nwith stationary density O\u00052.\u0003/\u0005ˇ, then\nPz D JrH C ˚1.\u0002; z/ C ˚2.\u0003; z/;\nP\u0002 D g1.\u0002; z/;\nP\u0003 D g2.\u0003; z/\nis another thermostat and has stationary density Q\u0005 D O\u00051.\u0002/ O\u00052.\u0003/\u0005ˇ.\n\n8.2\nMore General Deterministic Thermostats\n339\nThe proof is an immediate consequence of the linearity of the divergence\noperator, since the Liouville operator is constructed from this.\n8.2.2\nNosé-Hoover Chains\nLet us employ the additivity property to derive “Nosé-Hoover Chains” [251], a\npopular deterministic thermostat designed to give a more thorough sampling of the\nphase space than the standard Nosé-Hoover method.\nThe equations of Nosé-Hoover Chains may be written [251]\nPq D M\u00021p;\n(8.16)\nPp D \u0003rU.q/ \u0003 \u00121p;\n(8.17)\n\u00061 P\u00121 D pTM\u00021p \u0003 NdkBT \u0003 \u00061\u00122\u00121;\n(8.18)\n\u00062 P\u00122 D \u00061\u00122\n1 \u0003 kBT \u0003 \u00062\u00122\u00123;\n(8.19)\n\u00063 P\u00123 D \u00062\u00122\n2 \u0003 kBT \u0003 \u00063\u00123\u00124;\n(8.20)\n:::\n\u0006k P\u0012k D \u0006k\u00021\u00122\nk\u00021 \u0003 kBT:\n(8.21)\nBy creating a more substantial bath of oscillators, each of which is forced to have\nthe target kinetic energy, the physical system may more closely approximate the\ncanonical distribution.\nTo see that this is a thermostat, note the equations (8.16)–(8.21) can be split into\nthe following pieces:\n2\n66666666664\nPq\nPp\n\u00061 P\u00121\n\u00062 P\u00122\n:::\n\u0006k\u00021 P\u0012k\u00021\n\u0006k P\u0012k\n3\n77777777775\nD\n2\n66666666664\nM\u00021p\n\u0003rU.q/ \u0003 \u00121p\npTM\u00021p \u0003 NdkBT\n0\n:::\n0\n0\n3\n77777777775\nC\n2\n66666666664\n0\n0\n\u0003\u00061\u00121\u00122\n\u00061\u00122\n1 \u0003 kBT\n:::\n0\n0\n3\n77777777775\nC \u0002 \u0002 \u0002 C\n2\n66666666664\n0\n0\n0\n0\n:::\n\u0003\u0006k\u00021\u0012k\u00021\u0012k\n\u0006k\u00021\u00122\nk\u00021 \u0003 kBT\n3\n77777777775\n:\nThe ﬁrst piece of the system corresponds to Nosé-Hoover, which we already know\npreserves \u0005ˇ exp.\u0003ˇ\u00061\u00122\n1=2/. By examination, the distribution exp.\u0003ˇ\u00061\u00122\n1=2/\nexp.\u0003ˇ\u00062\u00122\n2=2/ is preserved by the second piece, the next piece preserves\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": "The proof is an immediate consequence of the linearity of the divergence\noperator, since the Liouville operator is constructed from this.",
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 359,
      "printed_page": 338,
      "text": "338\n8\nExtended Variable Methods\nThis is a slightly generalized form of the technique suggested by Bulgac and\nKusnezov [58].\nAssuming \u0005 goes to zero sufﬁciently rapidly at inﬁnity, we have\nZ\nrz \u0002 G.z/\u0005d! D \u0003\nZ\n.rz\u0005/ \u0002 G.z/d! D ˇ\nZ\nrzH \u0002 G.z/\u0005d!;\nusing integration by parts, therefore, since ˇ\u00021 D kBT,\nT D k\u00021\nB\nhrzH \u0002 Gi\nhr \u0002 Gi ;\nwhich gives formulas for temperature in terms of phase space averages (compare\nChap. 6, Proposition 6.1).\nSuppose we let K be a scalar valued function of position, and set\nG.z/ D\n\u0002 rqK.q/\n0\n\u0003\nthen we arrive at\ng.z/ D \u0006\u00021ŒrqU \u0003 kBTrq\t \u0002 rqK.q/:\nThis is an example of a “conﬁgurational thermostat” [193, 211, 319].\nA useful fact about thermostats is the following:\nProposition 8.1 (Thermostats are Additive) Suppose we are given two ther-\nmostats,\nPz D JrH C ˚1.\u0002; z/;\nP\u0002 D g1.\u0002; z/;\nwith stationary density O\u00051.\u0002/\u0005ˇ, and another\nPz D JrH C ˚2.\u0003; z/;\nP\u0003 D g2.\u0003; z/;\nwith stationary density O\u00052.\u0003/\u0005ˇ, then\nPz D JrH C ˚1.\u0002; z/ C ˚2.\u0003; z/;\nP\u0002 D g1.\u0002; z/;\nP\u0003 D g2.\u0003; z/\nis another thermostat and has stationary density Q\u0005 D O\u00051.\u0002/ O\u00052.\u0003/\u0005ˇ.\n"
    },
    {
      "pdf_page": 360,
      "printed_page": 339,
      "text": "8.2\nMore General Deterministic Thermostats\n339\nThe proof is an immediate consequence of the linearity of the divergence\noperator, since the Liouville operator is constructed from this.\n8.2.2\nNosé-Hoover Chains\nLet us employ the additivity property to derive “Nosé-Hoover Chains” [251], a\npopular deterministic thermostat designed to give a more thorough sampling of the\nphase space than the standard Nosé-Hoover method.\nThe equations of Nosé-Hoover Chains may be written [251]\nPq D M\u00021p;\n(8.16)\nPp D \u0003rU.q/ \u0003 \u00121p;\n(8.17)\n\u00061 P\u00121 D pTM\u00021p \u0003 NdkBT \u0003 \u00061\u00122\u00121;\n(8.18)\n\u00062 P\u00122 D \u00061\u00122\n1 \u0003 kBT \u0003 \u00062\u00122\u00123;\n(8.19)\n\u00063 P\u00123 D \u00062\u00122\n2 \u0003 kBT \u0003 \u00063\u00123\u00124;\n(8.20)\n:::\n\u0006k P\u0012k D \u0006k\u00021\u00122\nk\u00021 \u0003 kBT:\n(8.21)\nBy creating a more substantial bath of oscillators, each of which is forced to have\nthe target kinetic energy, the physical system may more closely approximate the\ncanonical distribution.\nTo see that this is a thermostat, note the equations (8.16)–(8.21) can be split into\nthe following pieces:\n2\n66666666664\nPq\nPp\n\u00061 P\u00121\n\u00062 P\u00122\n:::\n\u0006k\u00021 P\u0012k\u00021\n\u0006k P\u0012k\n3\n77777777775\nD\n2\n66666666664\nM\u00021p\n\u0003rU.q/ \u0003 \u00121p\npTM\u00021p \u0003 NdkBT\n0\n:::\n0\n0\n3\n77777777775\nC\n2\n66666666664\n0\n0\n\u0003\u00061\u00121\u00122\n\u00061\u00122\n1 \u0003 kBT\n:::\n0\n0\n3\n77777777775\nC \u0002 \u0002 \u0002 C\n2\n66666666664\n0\n0\n0\n0\n:::\n\u0003\u0006k\u00021\u0012k\u00021\u0012k\n\u0006k\u00021\u00122\nk\u00021 \u0003 kBT\n3\n77777777775\n:\nThe ﬁrst piece of the system corresponds to Nosé-Hoover, which we already know\npreserves \u0005ˇ exp.\u0003ˇ\u00061\u00122\n1=2/. By examination, the distribution exp.\u0003ˇ\u00061\u00122\n1=2/\nexp.\u0003ˇ\u00062\u00122\n2=2/ is preserved by the second piece, the next piece preserves\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。"
  ],
  "issues": [],
  "statement_scope": "两个标量热浴的局部Liouville驻定相加命题；不含多维热浴或全局流保测性。",
  "lean_decl": "MD.Ch08.proposition81",
  "lean_declarations": [
    "MD.Ch08.proposition81"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": [
    "textbookThermostats_additive_proposition81"
  ]
}
```
```lean
theorem proposition81 {H : SymplecticCoordinates n → ℝ} (hH : ContDiff ℝ 2 H) (β c : ℝ)
    {φ₁ φ₂ : SymplecticCoordinates n × ℝ → SymplecticCoordinates n}
    {g₁ g₂ : SymplecticCoordinates n × ℝ → ℝ} {a b : ℝ → ℝ}
    (hφ₁ : ContDiff ℝ 1 φ₁) (hφ₂ : ContDiff ℝ 1 φ₂)
    (hg₁ : ContDiff ℝ 1 g₁) (hg₂ : ContDiff ℝ 1 g₂)
    (ha : ContDiff ℝ 1 a) (hb : ContDiff ℝ 1 b)
    (hs₁ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₁ g₁)
      (fun w ↦ a w.2 * textbookHamiltonianGibbsDensity H β c w.1))
    (hs₂ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₂ g₂)
      (fun w ↦ b w.2 * textbookHamiltonianGibbsDensity H β c w.1)) :
    textbookLiouvilleStationary
      (textbookCombinedThermostatField (textbookHamiltonianVectorField H) φ₁ φ₂ g₁ g₂)
      (textbookThermostatProductDensity (textbookHamiltonianGibbsDensity H β c) a b) := by
  exact textbookThermostats_additive_proposition81 hH β c hφ₁ hφ₂ hg₁ hg₂ ha hb hs₁ hs₂
```

## MD-8.2.2-NHChains
```json
{
  "source_id": "MD-8.2.2-NHChains",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.2.2",
  "printed_page": "339–340",
  "pdf_page": "360–361",
  "statement_latex": "The Nosé–Hoover chain (8.16)–(8.21) preserves ρ_β exp(-βΣμ_iξ_i²/2).",
  "statement_verbatim": "8.2\nMore General Deterministic Thermostats\n339\nThe proof is an immediate consequence of the linearity of the divergence\noperator, since the Liouville operator is constructed from this.\n8.2.2\nNosé-Hoover Chains\nLet us employ the additivity property to derive “Nosé-Hoover Chains” [251], a\npopular deterministic thermostat designed to give a more thorough sampling of the\nphase space than the standard Nosé-Hoover method.\nThe equations of Nosé-Hoover Chains may be written [251]\nPq D M\u00021p;\n(8.16)\nPp D \u0003rU.q/ \u0003 \u00121p;\n(8.17)\n\u00061 P\u00121 D pTM\u00021p \u0003 NdkBT \u0003 \u00061\u00122\u00121;\n(8.18)\n\u00062 P\u00122 D \u00061\u00122\n1 \u0003 kBT \u0003 \u00062\u00122\u00123;\n(8.19)\n\u00063 P\u00123 D \u00062\u00122\n2 \u0003 kBT \u0003 \u00063\u00123\u00124;\n(8.20)\n:::\n\u0006k P\u0012k D \u0006k\u00021\u00122\nk\u00021 \u0003 kBT:\n(8.21)\nBy creating a more substantial bath of oscillators, each of which is forced to have\nthe target kinetic energy, the physical system may more closely approximate the\ncanonical distribution.\nTo see that this is a thermostat, note the equations (8.16)–(8.21) can be split into\nthe following pieces:\n2\n66666666664\nPq\nPp\n\u00061 P\u00121\n\u00062 P\u00122\n:::\n\u0006k\u00021 P\u0012k\u00021\n\u0006k P\u0012k\n3\n77777777775\nD\n2\n66666666664\nM\u00021p\n\u0003rU.q/ \u0003 \u00121p\npTM\u00021p \u0003 NdkBT\n0\n:::\n0\n0\n3\n77777777775\nC\n2\n66666666664\n0\n0\n\u0003\u00061\u00121\u00122\n\u00061\u00122\n1 \u0003 kBT\n:::\n0\n0\n3\n77777777775\nC \u0002 \u0002 \u0002 C\n2\n66666666664\n0\n0\n0\n0\n:::\n\u0003\u0006k\u00021\u0012k\u00021\u0012k\n\u0006k\u00021\u00122\nk\u00021 \u0003 kBT\n3\n77777777775\n:\nThe ﬁrst piece of the system corresponds to Nosé-Hoover, which we already know\npreserves \u0005ˇ exp.\u0003ˇ\u00061\u00122\n1=2/. By examination, the distribution exp.\u0003ˇ\u00061\u00122\n1=2/\nexp.\u0003ˇ\u00062\u00122\n2=2/ is preserved by the second piece, the next piece preserves\n\n340\n8\nExtended Variable Methods\nexp.\u0003ˇ\u00062\u00122\n2=2/ exp.\u0003ˇ\u00063\u00122\n3=2/ and so on. Thus the full system preserves the\ncombined distribution\nQ\u0005 D \u0005ˇ exp\n \n\u0003ˇ\nk\nX\niD1\n\u0006i\u00122\ni =2\n!\n:\nOf course this is only a demonstration that the dynamics is compatible with Q\u0005; there\nmay be other invariant distributions.\nNumerical treatment of the Nosé-Hoover Chain system can be performed by\nsplitting, just as in Newtonian and Langevin dynamics. Various related methods\nand comparisons may be found in [65, 192, 230, 253].\n8.2.3\nLack of Ergodicity of Deterministic Thermostats\nDeterministic methods like the ones in the previous subsection are sometimes used\nfor sampling calculations, however, our and others’ experience is that these methods\nare not always ergodic.\nIn the case of Nosé-Hoover, this problem was known to both of the inventors\nand has been observed by many authors (see e.g. [251] and [180]). More recently,\nit has been studied analytically [218]. Some confusion arises from the fact that the\npractical ergodic properties (and other properties) in Nosé-Hoover simulations are\nsensitive to the particular system under study and the values of parameters. For\nexample it is known that in the case of simple liquids and gases, Nosé-Hoover does\n(at least under some conditions) enable reliable calculation of thermodynamical\nquantities [77], whereas in other systems results are poor and cannot be rectiﬁed\nby adjustment of parameters. In general, the control of temperature requires that\nthe thermostat couples tightly to the physical variables, which generally calls for a\nsmall thermal mass, but this may be at odds with efﬁciency reduction (it may lead\nto a need to use smaller timesteps to resolve the motion of the auxiliary variable).\nErgodicity is less well known as a potential problem for methods involving\nthermostatting chains. Figure 8.1 shows a projection of a torus in phase space\nfound numerically for a chain-thermostatted harmonic oscillator. As the number of\nauxiliary chain variables increases, we observe that the tori become increasingly thin\nbut wind in a complicated way through the phase space. Even for initial conditions\ntrapped within one of the tori, crude sampling may be possible, provided that the\ntorus itself is of sufﬁcient size, but the presence of such tori will impose a ﬁnite\naccuracy limit on the averages that can be obtained.\nThe reliable use of deterministic thermostats is system dependent—it is essential\nthat there be mechanisms within the underlying physical dynamics model that\npromote energetic exchange among the degrees of freedom.\nNumerical methods for Nosé-Hoover chains are easily constructed by splitting\nof the equations of motion.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 360,
      "printed_page": 339,
      "text": "8.2\nMore General Deterministic Thermostats\n339\nThe proof is an immediate consequence of the linearity of the divergence\noperator, since the Liouville operator is constructed from this.\n8.2.2\nNosé-Hoover Chains\nLet us employ the additivity property to derive “Nosé-Hoover Chains” [251], a\npopular deterministic thermostat designed to give a more thorough sampling of the\nphase space than the standard Nosé-Hoover method.\nThe equations of Nosé-Hoover Chains may be written [251]\nPq D M\u00021p;\n(8.16)\nPp D \u0003rU.q/ \u0003 \u00121p;\n(8.17)\n\u00061 P\u00121 D pTM\u00021p \u0003 NdkBT \u0003 \u00061\u00122\u00121;\n(8.18)\n\u00062 P\u00122 D \u00061\u00122\n1 \u0003 kBT \u0003 \u00062\u00122\u00123;\n(8.19)\n\u00063 P\u00123 D \u00062\u00122\n2 \u0003 kBT \u0003 \u00063\u00123\u00124;\n(8.20)\n:::\n\u0006k P\u0012k D \u0006k\u00021\u00122\nk\u00021 \u0003 kBT:\n(8.21)\nBy creating a more substantial bath of oscillators, each of which is forced to have\nthe target kinetic energy, the physical system may more closely approximate the\ncanonical distribution.\nTo see that this is a thermostat, note the equations (8.16)–(8.21) can be split into\nthe following pieces:\n2\n66666666664\nPq\nPp\n\u00061 P\u00121\n\u00062 P\u00122\n:::\n\u0006k\u00021 P\u0012k\u00021\n\u0006k P\u0012k\n3\n77777777775\nD\n2\n66666666664\nM\u00021p\n\u0003rU.q/ \u0003 \u00121p\npTM\u00021p \u0003 NdkBT\n0\n:::\n0\n0\n3\n77777777775\nC\n2\n66666666664\n0\n0\n\u0003\u00061\u00121\u00122\n\u00061\u00122\n1 \u0003 kBT\n:::\n0\n0\n3\n77777777775\nC \u0002 \u0002 \u0002 C\n2\n66666666664\n0\n0\n0\n0\n:::\n\u0003\u0006k\u00021\u0012k\u00021\u0012k\n\u0006k\u00021\u00122\nk\u00021 \u0003 kBT\n3\n77777777775\n:\nThe ﬁrst piece of the system corresponds to Nosé-Hoover, which we already know\npreserves \u0005ˇ exp.\u0003ˇ\u00061\u00122\n1=2/. By examination, the distribution exp.\u0003ˇ\u00061\u00122\n1=2/\nexp.\u0003ˇ\u00062\u00122\n2=2/ is preserved by the second piece, the next piece preserves\n"
    },
    {
      "pdf_page": 361,
      "printed_page": 340,
      "text": "340\n8\nExtended Variable Methods\nexp.\u0003ˇ\u00062\u00122\n2=2/ exp.\u0003ˇ\u00063\u00122\n3=2/ and so on. Thus the full system preserves the\ncombined distribution\nQ\u0005 D \u0005ˇ exp\n \n\u0003ˇ\nk\nX\niD1\n\u0006i\u00122\ni =2\n!\n:\nOf course this is only a demonstration that the dynamics is compatible with Q\u0005; there\nmay be other invariant distributions.\nNumerical treatment of the Nosé-Hoover Chain system can be performed by\nsplitting, just as in Newtonian and Langevin dynamics. Various related methods\nand comparisons may be found in [65, 192, 230, 253].\n8.2.3\nLack of Ergodicity of Deterministic Thermostats\nDeterministic methods like the ones in the previous subsection are sometimes used\nfor sampling calculations, however, our and others’ experience is that these methods\nare not always ergodic.\nIn the case of Nosé-Hoover, this problem was known to both of the inventors\nand has been observed by many authors (see e.g. [251] and [180]). More recently,\nit has been studied analytically [218]. Some confusion arises from the fact that the\npractical ergodic properties (and other properties) in Nosé-Hoover simulations are\nsensitive to the particular system under study and the values of parameters. For\nexample it is known that in the case of simple liquids and gases, Nosé-Hoover does\n(at least under some conditions) enable reliable calculation of thermodynamical\nquantities [77], whereas in other systems results are poor and cannot be rectiﬁed\nby adjustment of parameters. In general, the control of temperature requires that\nthe thermostat couples tightly to the physical variables, which generally calls for a\nsmall thermal mass, but this may be at odds with efﬁciency reduction (it may lead\nto a need to use smaller timesteps to resolve the motion of the auxiliary variable).\nErgodicity is less well known as a potential problem for methods involving\nthermostatting chains. Figure 8.1 shows a projection of a torus in phase space\nfound numerically for a chain-thermostatted harmonic oscillator. As the number of\nauxiliary chain variables increases, we observe that the tori become increasingly thin\nbut wind in a complicated way through the phase space. Even for initial conditions\ntrapped within one of the tori, crude sampling may be possible, provided that the\ntorus itself is of sufﬁcient size, but the presence of such tori will impose a ﬁnite\naccuracy limit on the averages that can be obtained.\nThe reliable use of deterministic thermostats is system dependent—it is essential\nthat there be mechanisms within the underlying physical dynamics model that\npromote energetic exchange among the degrees of freedom.\nNumerical methods for Nosé-Hoover chains are easily constructed by splitting\nof the equations of motion.\n"
    }
  ],
  "numbered_equations": [
    "8.16",
    "8.17",
    "8.18",
    "8.19",
    "8.20",
    "8.21"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "链长k>0，各热质量Q_j>0、β>0，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。"
  ],
  "issues": [],
  "statement_scope": "任意正链长的完整NH链场及Gaussian权局部驻定目标；不含遍历性。",
  "lean_decl": "MD.Ch08.nhChainField",
  "lean_declarations": [
    "MD.Ch08.nhChainField",
    "MD.Ch08.nhChain_stationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nhChainField (k : ℕ) (invm : Vec n) (U : Vec n → ℝ) (β : ℝ)
    (Q : Fin k → ℝ) (z : Phase n × (Fin k → ℝ)) : Phase n × (Fin k → ℝ) :=
  ((fun i ↦ invm i*z.1.2 i,
    fun i ↦ -gradient U z.1.1 i - (if hk : 0 < k then z.2 ⟨0,hk⟩ else 0)*z.1.2 i),
   fun j ↦ (if hj : j.val = 0 then (kineticTwice invm z.1.2-(n : ℝ)/β)/Q j
     else (Q ⟨j.val-1,by omega⟩ * z.2 ⟨j.val-1,by omega⟩ ^2 - 1/β)/Q j) -
     (if hj : j.val+1 < k then z.2 j * z.2 ⟨j.val+1,hj⟩ else 0))
theorem nhChain_stationary (k : ℕ) (hk : 0 < k) (invm : Vec n) (U : Vec n → ℝ)
    (β : ℝ) (Q : Fin k → ℝ) (hβ : 0 < β) (hQ : ∀ j, 0 < Q j)
    (hm : ∀ i, 0 < invm i) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (nhChainField k invm U β Q)
      (fun z ↦ Real.exp (-β*(kineticTwice invm z.1.2/2+U z.1.1+(∑ j, Q j*z.2 j^2)/2))) := by
  sorry
```

## MD-8.3-ArrheniusRate
```json
{
  "source_id": "MD-8.3-ArrheniusRate",
  "kind": "definition",
  "label": null,
  "section": "8.3",
  "printed_page": "342",
  "pdf_page": "363",
  "statement_latex": "k ∼ A e^{-ΔE/(k_BT)}.",
  "statement_verbatim": "342\n8\nExtended Variable Methods\notherwise there is little clear advantage and a potentially signiﬁcant price to be\npaid, since HMC methods only work by rejecting steps. For reading on Hybrid\nMonte Carlo methods, the reader should consult [110, 188] and other references\nmentioned in Appendix C.\n•\nKinetic Monte-Carlo (KMC) methods are a broad family of multiscale sampling\nmethods which use a local sampling mechanism to explore basins while invoking\nan Arrenhius law to estimate the rates or timescales for transitions between\nbasins (we can think of basins as neighborhoods of potential energy minima).\nThe Arrenhius law relates the rate constant k associated to a particular state-\nto-state transition to the exponential of the of the “activation energy” which is\ndeﬁned as the difference \u0010E between the energy at a local minimum and that at\nthe energy barrier between the states\nk \u0005 Ae\u0002\u0010E=kBT\nIn a KMC method, it is typically assumed that various possible state-to-state\ntransitions from a given state are well modelled by the Arrenhius law and then\nmolecular dynamics is used to calculate the prefactor A and energy difference \u0010E\nin order to understand the timescales and relative probabilities of different rare\nevents. A Markov state model can be developed to help understand the global\ndynamics and simplify the model as a whole. For references on many interesting\napproaches to this important topic, the reader is referred to [36, 42, 137, 149, 391].\n•\nAndersen Thermostat. Of particular interest is the simple and useful Andersen\nthermostat [11]. This method works by selecting atoms at random and randomly\nperturbing their momenta in a way consistent with prescribed thermodynamic\nconditions. It has been rigorously proven to sample the canonical distribution\n[114].\n8.4\nErgodic Stochastic-Dynamic Thermostats\nIn this section, we consider the combination of stochastic perturbation with a\ndeterministic thermostat. Methods constructed in this way can be ergodic for\nthe canonical distribution while also providing ﬂexibility in way equilibrium is\nachieved. We distinguish in (6.16) between multiplicative noise, where B D B.z/\nvaries with z and additive noise, where B is constant. In our treatment of this topic\nwe will only consider additive noise. The presence of multiplicative noise may\ncomplicate discretization. As we shall see, the reliance on additive noise improves\nthe performance of discretization schemes.\nTo give this some speciﬁcity for molecular dynamics, we write the stochastic\ndynamical model as\ndq D M\u00021pdt;\n(8.22)\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 363,
      "printed_page": 342,
      "text": "342\n8\nExtended Variable Methods\notherwise there is little clear advantage and a potentially signiﬁcant price to be\npaid, since HMC methods only work by rejecting steps. For reading on Hybrid\nMonte Carlo methods, the reader should consult [110, 188] and other references\nmentioned in Appendix C.\n•\nKinetic Monte-Carlo (KMC) methods are a broad family of multiscale sampling\nmethods which use a local sampling mechanism to explore basins while invoking\nan Arrenhius law to estimate the rates or timescales for transitions between\nbasins (we can think of basins as neighborhoods of potential energy minima).\nThe Arrenhius law relates the rate constant k associated to a particular state-\nto-state transition to the exponential of the of the “activation energy” which is\ndeﬁned as the difference \u0010E between the energy at a local minimum and that at\nthe energy barrier between the states\nk \u0005 Ae\u0002\u0010E=kBT\nIn a KMC method, it is typically assumed that various possible state-to-state\ntransitions from a given state are well modelled by the Arrenhius law and then\nmolecular dynamics is used to calculate the prefactor A and energy difference \u0010E\nin order to understand the timescales and relative probabilities of different rare\nevents. A Markov state model can be developed to help understand the global\ndynamics and simplify the model as a whole. For references on many interesting\napproaches to this important topic, the reader is referred to [36, 42, 137, 149, 391].\n•\nAndersen Thermostat. Of particular interest is the simple and useful Andersen\nthermostat [11]. This method works by selecting atoms at random and randomly\nperturbing their momenta in a way consistent with prescribed thermodynamic\nconditions. It has been rigorously proven to sample the canonical distribution\n[114].\n8.4\nErgodic Stochastic-Dynamic Thermostats\nIn this section, we consider the combination of stochastic perturbation with a\ndeterministic thermostat. Methods constructed in this way can be ergodic for\nthe canonical distribution while also providing ﬂexibility in way equilibrium is\nachieved. We distinguish in (6.16) between multiplicative noise, where B D B.z/\nvaries with z and additive noise, where B is constant. In our treatment of this topic\nwe will only consider additive noise. The presence of multiplicative noise may\ncomplicate discretization. As we shall see, the reliance on additive noise improves\nthe performance of discretization schemes.\nTo give this some speciﬁcity for molecular dynamics, we write the stochastic\ndynamical model as\ndq D M\u00021pdt;\n(8.22)\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "A≥0,k_B>0,T>0为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。"
  ],
  "issues": [],
  "statement_scope": "Arrhenius指数速率公式定义及A≥0时非负性；不含亚稳跃迁率渐近定理或温度单调性。",
  "lean_decl": "MD.Ch08.arrheniusRate",
  "lean_declarations": [
    "MD.Ch08.arrheniusRate",
    "MD.Ch08.arrheniusRate_nonneg"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def arrheniusRate (A ΔE kB T : ℝ) : ℝ := A*Real.exp (-ΔE/(kB*T))
theorem arrheniusRate_nonneg (A ΔE kB T : ℝ) (hA : 0 ≤ A) :
    0 ≤ arrheniusRate A ΔE kB T := mul_nonneg hA (Real.exp_pos _).le
```

## MD-8.4-AdditiveThermostatSDE
```json
{
  "source_id": "MD-8.4-AdditiveThermostatSDE",
  "kind": "definition",
  "label": null,
  "section": "8.4",
  "printed_page": "342–343",
  "pdf_page": "363–364",
  "statement_latex": "dq=M⁻¹pdt; dp=-∇Udt-Φ(ξ,z)-Γpdt+√(2k_BT)M^{1/2}Γ^{1/2}dW; dξ=gdt-Γ̂ξdt+√(2k_BT)M̂^{1/2}Γ̂^{1/2}dŴ. All Wiener coordinates are independent.",
  "statement_verbatim": "342\n8\nExtended Variable Methods\notherwise there is little clear advantage and a potentially signiﬁcant price to be\npaid, since HMC methods only work by rejecting steps. For reading on Hybrid\nMonte Carlo methods, the reader should consult [110, 188] and other references\nmentioned in Appendix C.\n•\nKinetic Monte-Carlo (KMC) methods are a broad family of multiscale sampling\nmethods which use a local sampling mechanism to explore basins while invoking\nan Arrenhius law to estimate the rates or timescales for transitions between\nbasins (we can think of basins as neighborhoods of potential energy minima).\nThe Arrenhius law relates the rate constant k associated to a particular state-\nto-state transition to the exponential of the of the “activation energy” which is\ndeﬁned as the difference \u0010E between the energy at a local minimum and that at\nthe energy barrier between the states\nk \u0005 Ae\u0002\u0010E=kBT\nIn a KMC method, it is typically assumed that various possible state-to-state\ntransitions from a given state are well modelled by the Arrenhius law and then\nmolecular dynamics is used to calculate the prefactor A and energy difference \u0010E\nin order to understand the timescales and relative probabilities of different rare\nevents. A Markov state model can be developed to help understand the global\ndynamics and simplify the model as a whole. For references on many interesting\napproaches to this important topic, the reader is referred to [36, 42, 137, 149, 391].\n•\nAndersen Thermostat. Of particular interest is the simple and useful Andersen\nthermostat [11]. This method works by selecting atoms at random and randomly\nperturbing their momenta in a way consistent with prescribed thermodynamic\nconditions. It has been rigorously proven to sample the canonical distribution\n[114].\n8.4\nErgodic Stochastic-Dynamic Thermostats\nIn this section, we consider the combination of stochastic perturbation with a\ndeterministic thermostat. Methods constructed in this way can be ergodic for\nthe canonical distribution while also providing ﬂexibility in way equilibrium is\nachieved. We distinguish in (6.16) between multiplicative noise, where B D B.z/\nvaries with z and additive noise, where B is constant. In our treatment of this topic\nwe will only consider additive noise. The presence of multiplicative noise may\ncomplicate discretization. As we shall see, the reliance on additive noise improves\nthe performance of discretization schemes.\nTo give this some speciﬁcity for molecular dynamics, we write the stochastic\ndynamical model as\ndq D M\u00021pdt;\n(8.22)\n\n8.4\nErgodic Stochastic-Dynamic Thermostats\n343\ndp D \u0003rU.q/dt \u0003 ˚.\u0002; z/ \u0003 \u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW;\n(8.23)\nd\u0002 D g.\u0002; q; p/dt \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW:\n(8.24)\nHere \u0010 ; O\u0010\nare symmetric, square matrices of appropriate dimension, W is a\nvector of Nc Wiener processes, and OW is a vector of m Wiener processes, all\nindependent of each other. We assume that the deterministic thermostat represented\nby the ˚ and g terms preserves the extended distribution O\u0005.\u0002/\u0005ˇ, where O\u0005.\u0002/ D\nexp\n\u0006\n\u0003ˇ\u0002T OM\n\u00021\u0002=2\n\u0007\n. The matrix OM is symmetric and positive deﬁnite; one could\ntake it to be diagonal.\nThe additivity property of thermostats mentioned above holds also for stochastic\nthermostats, since the Fokker-Planck equation is constructed from linear operations\non the vector ﬁelds involved, thus it is enough to require that the newly introduced\nterms satisfy appropriate ﬂuctuation-dissipation relationships so that they are\ncompatible with the extended Gibbs distribution of the deterministic part. That is,\nwe require\ndp D \u0003\u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW\nto preserve the distribution with density N\u0005 D exp\n\u0004\n\u0003ˇpTM\u00021p=2\n\u0005\n, and\nd\u0002 D \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW\nto preserve O\u0005. These two problems are essentially the same. Considering the former,\nthe stationary Fokker-Planck equation reads\nrp \u0002 .\u0010 p N\u0005/\n„\nƒ‚\n…\ndrift\nC ˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2r2\np N\u0005M1=2\u0010 1=2\u0007\n„\nƒ‚\n…\ndiffusion\nD 0:\nThe drift term here equates to\nTr.\u0010 / N\u0005 C .\u0003ˇ/pT\u0010 M\u00021p N\u0005:\nFor the diffusion term, we calculate\nr N\u0005 D \u0003ˇ N\u0005M\u00021p;\nthus\nr2 N\u0005 D N\u0005Œˇ2M\u00021ppTM\u00021 \u0003 ˇM\u00021\t;\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 363,
      "printed_page": 342,
      "text": "342\n8\nExtended Variable Methods\notherwise there is little clear advantage and a potentially signiﬁcant price to be\npaid, since HMC methods only work by rejecting steps. For reading on Hybrid\nMonte Carlo methods, the reader should consult [110, 188] and other references\nmentioned in Appendix C.\n•\nKinetic Monte-Carlo (KMC) methods are a broad family of multiscale sampling\nmethods which use a local sampling mechanism to explore basins while invoking\nan Arrenhius law to estimate the rates or timescales for transitions between\nbasins (we can think of basins as neighborhoods of potential energy minima).\nThe Arrenhius law relates the rate constant k associated to a particular state-\nto-state transition to the exponential of the of the “activation energy” which is\ndeﬁned as the difference \u0010E between the energy at a local minimum and that at\nthe energy barrier between the states\nk \u0005 Ae\u0002\u0010E=kBT\nIn a KMC method, it is typically assumed that various possible state-to-state\ntransitions from a given state are well modelled by the Arrenhius law and then\nmolecular dynamics is used to calculate the prefactor A and energy difference \u0010E\nin order to understand the timescales and relative probabilities of different rare\nevents. A Markov state model can be developed to help understand the global\ndynamics and simplify the model as a whole. For references on many interesting\napproaches to this important topic, the reader is referred to [36, 42, 137, 149, 391].\n•\nAndersen Thermostat. Of particular interest is the simple and useful Andersen\nthermostat [11]. This method works by selecting atoms at random and randomly\nperturbing their momenta in a way consistent with prescribed thermodynamic\nconditions. It has been rigorously proven to sample the canonical distribution\n[114].\n8.4\nErgodic Stochastic-Dynamic Thermostats\nIn this section, we consider the combination of stochastic perturbation with a\ndeterministic thermostat. Methods constructed in this way can be ergodic for\nthe canonical distribution while also providing ﬂexibility in way equilibrium is\nachieved. We distinguish in (6.16) between multiplicative noise, where B D B.z/\nvaries with z and additive noise, where B is constant. In our treatment of this topic\nwe will only consider additive noise. The presence of multiplicative noise may\ncomplicate discretization. As we shall see, the reliance on additive noise improves\nthe performance of discretization schemes.\nTo give this some speciﬁcity for molecular dynamics, we write the stochastic\ndynamical model as\ndq D M\u00021pdt;\n(8.22)\n"
    },
    {
      "pdf_page": 364,
      "printed_page": 343,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n343\ndp D \u0003rU.q/dt \u0003 ˚.\u0002; z/ \u0003 \u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW;\n(8.23)\nd\u0002 D g.\u0002; q; p/dt \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW:\n(8.24)\nHere \u0010 ; O\u0010\nare symmetric, square matrices of appropriate dimension, W is a\nvector of Nc Wiener processes, and OW is a vector of m Wiener processes, all\nindependent of each other. We assume that the deterministic thermostat represented\nby the ˚ and g terms preserves the extended distribution O\u0005.\u0002/\u0005ˇ, where O\u0005.\u0002/ D\nexp\n\u0006\n\u0003ˇ\u0002T OM\n\u00021\u0002=2\n\u0007\n. The matrix OM is symmetric and positive deﬁnite; one could\ntake it to be diagonal.\nThe additivity property of thermostats mentioned above holds also for stochastic\nthermostats, since the Fokker-Planck equation is constructed from linear operations\non the vector ﬁelds involved, thus it is enough to require that the newly introduced\nterms satisfy appropriate ﬂuctuation-dissipation relationships so that they are\ncompatible with the extended Gibbs distribution of the deterministic part. That is,\nwe require\ndp D \u0003\u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW\nto preserve the distribution with density N\u0005 D exp\n\u0004\n\u0003ˇpTM\u00021p=2\n\u0005\n, and\nd\u0002 D \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW\nto preserve O\u0005. These two problems are essentially the same. Considering the former,\nthe stationary Fokker-Planck equation reads\nrp \u0002 .\u0010 p N\u0005/\n„\nƒ‚\n…\ndrift\nC ˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2r2\np N\u0005M1=2\u0010 1=2\u0007\n„\nƒ‚\n…\ndiffusion\nD 0:\nThe drift term here equates to\nTr.\u0010 / N\u0005 C .\u0003ˇ/pT\u0010 M\u00021p N\u0005:\nFor the diffusion term, we calculate\nr N\u0005 D \u0003ˇ N\u0005M\u00021p;\nthus\nr2 N\u0005 D N\u0005Œˇ2M\u00021ppTM\u00021 \u0003 ˇM\u00021\t;\n"
    }
  ],
  "numbered_equations": [
    "8.22",
    "8.23",
    "8.24"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "加性噪声用独立Wiener路径增量的精确积分方程；漂移可积、路径连续且适应自然历史。完整矩阵噪声给因子B和涨落耗散资格，物理/热浴两组坐标共同独立。"
  ],
  "issues": [],
  "statement_scope": "一般漂移、常噪声SDE与协方差关系；未构造矩阵平方根。",
  "lean_decl": "MD.Ch08.independentWiener",
  "lean_declarations": [
    "MD.Ch08.independentWiener",
    "MD.Ch08.additiveSDE",
    "MD.Ch08.stochasticThermostatDrift",
    "MD.Ch08.fluctuationDissipation"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def independentWiener (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k) : Prop :=
  IsProbabilityMeasure P ∧ (∀ j, IsBrownianReal (fun t sample ↦ W t sample j) P) ∧
    iIndepFun (fun j sample ↦ fun t : ℝ ↦ W t sample j) P
def additiveSDE {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [MeasurableSpace E]
    (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k)
    (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : Fin k → E) : Prop :=
  independentWiener P k W ∧ (∀ᵐ sample ∂P, Continuous (fun t ↦ X t sample)) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ t : ℝ, 0 ≤ t →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 t) ∧
    ∀ᵐ sample ∂P, X t sample = x0 + (∫ s in 0..t, a (X s sample)) +
      ∑ j, (W t sample j-W 0 sample j) • B j
def stochasticThermostatDrift {k : ℕ} (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ : Matrix (Fin n) (Fin n) ℝ) (Γhat : Matrix (Fin k) (Fin k) ℝ)
    (z : Phase n × Vec k) : Phase n × Vec k :=
  ((fun i ↦ invm i*z.1.2 i, fun i ↦ -gradient U z.1.1 i-Φ z i-(Γ *ᵥ z.1.2) i),
   g z - Γhat *ᵥ z.2)
def fluctuationDissipation (M Γ B : Matrix (Fin n) (Fin n) ℝ) (β : ℝ) : Prop :=
  0 < β ∧ M.PosDef ∧ Γ.PosSemidef ∧ B*B.transpose = (2/β) • (Γ*M)
```

## MD-8.4-OUStationarityPrinted
```json
{
  "source_id": "MD-8.4-OUStationarityPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.4",
  "printed_page": "343–344",
  "pdf_page": "364–365",
  "statement_latex": "The OU momentum process with drift -Γp and noise √(2k_BT) M^{1/2}Γ^{1/2} preserves exp(-βpᵀM⁻¹p/2). The displayed diffusion term is β⁻¹Tr(Γ^{1/2}M^{1/2}[βM⁻¹ppᵀM⁻¹-M⁻¹]M^{1/2}Γ^{1/2})ρ̄=-drift.",
  "statement_verbatim": "8.4\nErgodic Stochastic-Dynamic Thermostats\n343\ndp D \u0003rU.q/dt \u0003 ˚.\u0002; z/ \u0003 \u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW;\n(8.23)\nd\u0002 D g.\u0002; q; p/dt \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW:\n(8.24)\nHere \u0010 ; O\u0010\nare symmetric, square matrices of appropriate dimension, W is a\nvector of Nc Wiener processes, and OW is a vector of m Wiener processes, all\nindependent of each other. We assume that the deterministic thermostat represented\nby the ˚ and g terms preserves the extended distribution O\u0005.\u0002/\u0005ˇ, where O\u0005.\u0002/ D\nexp\n\u0006\n\u0003ˇ\u0002T OM\n\u00021\u0002=2\n\u0007\n. The matrix OM is symmetric and positive deﬁnite; one could\ntake it to be diagonal.\nThe additivity property of thermostats mentioned above holds also for stochastic\nthermostats, since the Fokker-Planck equation is constructed from linear operations\non the vector ﬁelds involved, thus it is enough to require that the newly introduced\nterms satisfy appropriate ﬂuctuation-dissipation relationships so that they are\ncompatible with the extended Gibbs distribution of the deterministic part. That is,\nwe require\ndp D \u0003\u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW\nto preserve the distribution with density N\u0005 D exp\n\u0004\n\u0003ˇpTM\u00021p=2\n\u0005\n, and\nd\u0002 D \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW\nto preserve O\u0005. These two problems are essentially the same. Considering the former,\nthe stationary Fokker-Planck equation reads\nrp \u0002 .\u0010 p N\u0005/\n„\nƒ‚\n…\ndrift\nC ˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2r2\np N\u0005M1=2\u0010 1=2\u0007\n„\nƒ‚\n…\ndiffusion\nD 0:\nThe drift term here equates to\nTr.\u0010 / N\u0005 C .\u0003ˇ/pT\u0010 M\u00021p N\u0005:\nFor the diffusion term, we calculate\nr N\u0005 D \u0003ˇ N\u0005M\u00021p;\nthus\nr2 N\u0005 D N\u0005Œˇ2M\u00021ppTM\u00021 \u0003 ˇM\u00021\t;\n\n344\n8\nExtended Variable Methods\nso the diffusion term is\nˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2ŒˇM\u00021ppTM\u00021 \u0003 M\u00021\tM1=2\u0010 1=2\u0007\nN\u0005 D \u0003drift;\nwhere we have used the cyclic property of the trace (and the symmetry of \u0010 ) to\nreduce the expression. The validity of the term involving \u0002 is easily veriﬁed by a\nsimilar argument.\nThus we know that the Gibbs distribution will be invariant. It remains to prove\nthat the SDE (8.22)–(8.24) is ergodic. Certainly this would be expected in the case\nwhere a full Langevin dynamics contribution is present (\u0010 positive deﬁnite), but as\nwe shall see next there are cases where noise only contacts the auxiliary degrees of\nfreedom but the system is nonetheless ergodic.\nWe state here a useful observation that allows to simplify the commutator\ncalculations in the case of an SDE of the following type:\ndz D F.z/dt C \u0012G.z/dt;\n(8.25)\nd\u0012 D g.z/dt \u0003 \n\u0012dt C \u0007dW;\n(8.26)\nwhere z 2 Rm, F; G W Rm ! Rm.\nProposition 8.2 If the Lie algebra generated by F and G in (8.25) spans Rm, then\nthe Hörmander condition holds for the system (8.25)–(8.26).\nProof First observe that the premise holds if and only if the Lie algebra of the\nvectors in RmC1 deﬁned by\nQF D\n\u0002 F\n0\n\u0003\n;\nQG D\n\u0002G\n0\n\u0003\n;\ntogether with emC1 spans RmC1. Thus the problem is to show that we can generate\nQF and QG from the vector ﬁelds that deﬁne (8.25)–(8.26), which are\nb0 D\n\u0002F C \u0012G\ng \u0003 \n\u0012\n\u0003\n;\nb1 D\n\u0002 0\n\u0007\n\u0003\n:\nComputing the commutator gives\nc D Œb0; b1\t D\n\u0002 \u0003\u0007G\n\u0007\n\u0003\n;\nhence\nQG D \u00031\n\u0007 Œc \u0003 \nb1\t :\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 364,
      "printed_page": 343,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n343\ndp D \u0003rU.q/dt \u0003 ˚.\u0002; z/ \u0003 \u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW;\n(8.23)\nd\u0002 D g.\u0002; q; p/dt \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW:\n(8.24)\nHere \u0010 ; O\u0010\nare symmetric, square matrices of appropriate dimension, W is a\nvector of Nc Wiener processes, and OW is a vector of m Wiener processes, all\nindependent of each other. We assume that the deterministic thermostat represented\nby the ˚ and g terms preserves the extended distribution O\u0005.\u0002/\u0005ˇ, where O\u0005.\u0002/ D\nexp\n\u0006\n\u0003ˇ\u0002T OM\n\u00021\u0002=2\n\u0007\n. The matrix OM is symmetric and positive deﬁnite; one could\ntake it to be diagonal.\nThe additivity property of thermostats mentioned above holds also for stochastic\nthermostats, since the Fokker-Planck equation is constructed from linear operations\non the vector ﬁelds involved, thus it is enough to require that the newly introduced\nterms satisfy appropriate ﬂuctuation-dissipation relationships so that they are\ncompatible with the extended Gibbs distribution of the deterministic part. That is,\nwe require\ndp D \u0003\u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW\nto preserve the distribution with density N\u0005 D exp\n\u0004\n\u0003ˇpTM\u00021p=2\n\u0005\n, and\nd\u0002 D \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW\nto preserve O\u0005. These two problems are essentially the same. Considering the former,\nthe stationary Fokker-Planck equation reads\nrp \u0002 .\u0010 p N\u0005/\n„\nƒ‚\n…\ndrift\nC ˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2r2\np N\u0005M1=2\u0010 1=2\u0007\n„\nƒ‚\n…\ndiffusion\nD 0:\nThe drift term here equates to\nTr.\u0010 / N\u0005 C .\u0003ˇ/pT\u0010 M\u00021p N\u0005:\nFor the diffusion term, we calculate\nr N\u0005 D \u0003ˇ N\u0005M\u00021p;\nthus\nr2 N\u0005 D N\u0005Œˇ2M\u00021ppTM\u00021 \u0003 ˇM\u00021\t;\n"
    },
    {
      "pdf_page": 365,
      "printed_page": 344,
      "text": "344\n8\nExtended Variable Methods\nso the diffusion term is\nˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2ŒˇM\u00021ppTM\u00021 \u0003 M\u00021\tM1=2\u0010 1=2\u0007\nN\u0005 D \u0003drift;\nwhere we have used the cyclic property of the trace (and the symmetry of \u0010 ) to\nreduce the expression. The validity of the term involving \u0002 is easily veriﬁed by a\nsimilar argument.\nThus we know that the Gibbs distribution will be invariant. It remains to prove\nthat the SDE (8.22)–(8.24) is ergodic. Certainly this would be expected in the case\nwhere a full Langevin dynamics contribution is present (\u0010 positive deﬁnite), but as\nwe shall see next there are cases where noise only contacts the auxiliary degrees of\nfreedom but the system is nonetheless ergodic.\nWe state here a useful observation that allows to simplify the commutator\ncalculations in the case of an SDE of the following type:\ndz D F.z/dt C \u0012G.z/dt;\n(8.25)\nd\u0012 D g.z/dt \u0003 \n\u0012dt C \u0007dW;\n(8.26)\nwhere z 2 Rm, F; G W Rm ! Rm.\nProposition 8.2 If the Lie algebra generated by F and G in (8.25) spans Rm, then\nthe Hörmander condition holds for the system (8.25)–(8.26).\nProof First observe that the premise holds if and only if the Lie algebra of the\nvectors in RmC1 deﬁned by\nQF D\n\u0002 F\n0\n\u0003\n;\nQG D\n\u0002G\n0\n\u0003\n;\ntogether with emC1 spans RmC1. Thus the problem is to show that we can generate\nQF and QG from the vector ﬁelds that deﬁne (8.25)–(8.26), which are\nb0 D\n\u0002F C \u0012G\ng \u0003 \n\u0012\n\u0003\n;\nb1 D\n\u0002 0\n\u0007\n\u0003\n:\nComputing the commutator gives\nc D Œb0; b1\t D\n\u0002 \u0003\u0007G\n\u0007\n\u0003\n;\nhence\nQG D \u00031\n\u0007 Œc \u0003 \nb1\t :\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "Printed保留显示抵消式的M=Γ=1,p=0标量特例；修正版为完整匹配协方差后的OU驻定式；不将转移分布存在性作为已证。"
  ],
  "issues": [
    "已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加ΓM=MΓ或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留β⁻¹，标量β=2,p=0已反例。"
  ],
  "statement_scope": "协方差匹配的完整OU局部驻定目标；所印扩散抵消的标量特例及数值反例。",
  "lean_decl": "MD.Ch08.ouFokkerPlanck",
  "lean_declarations": [
    "MD.Ch08.ouFokkerPlanck",
    "MD.Ch08.ouStationarity_corrected",
    "MD.Ch08.diffusionPrinted",
    "MD.Ch08.diffusionPrinted_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def ouFokkerPlanck (A C : Matrix (Fin n) (Fin n) ℝ) (ρ : Vec n → ℝ) (p : Vec n) : ℝ :=
  textbookDivergence (fun x ↦ ρ x • (A *ᵥ x)) p +
    (∑ i, ∑ j, C i j * fderiv ℝ (fun x ↦ gradient ρ x j) p (Pi.single i 1))/2
theorem ouStationarity_corrected (M Γ B : Matrix (Fin n) (Fin n) ℝ) (β : ℝ)
    (hf : fluctuationDissipation M Γ B β) :
    ∀ p, ouFokkerPlanck Γ (B*B.transpose)
      (fun x ↦ Real.exp (-β * dot x (M⁻¹ *ᵥ x)/2)) p = 0 := by
  sorry
theorem diffusionPrinted (β : ℝ) (hβ : 0 < β) : (1/β)*(-1) = -(1 : ℝ) := by
  sorry
theorem diffusionPrinted_counterexample : ¬ ((1/(2:ℝ))*(-1) = -(1:ℝ)) := by norm_num
```

## MD-8.4-LiftedThermostat
```json
{
  "source_id": "MD-8.4-LiftedThermostat",
  "kind": "definition",
  "label": null,
  "section": "8.4",
  "printed_page": "344–345",
  "pdf_page": "365–366",
  "statement_latex": "dz=F(z)dt+ξG(z)dt, dξ=g(z)dt-γξdt+σdW. The lifted fields are b₀=(F+ξG,g-γξ), b₁=(0,σ).",
  "statement_verbatim": "344\n8\nExtended Variable Methods\nso the diffusion term is\nˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2ŒˇM\u00021ppTM\u00021 \u0003 M\u00021\tM1=2\u0010 1=2\u0007\nN\u0005 D \u0003drift;\nwhere we have used the cyclic property of the trace (and the symmetry of \u0010 ) to\nreduce the expression. The validity of the term involving \u0002 is easily veriﬁed by a\nsimilar argument.\nThus we know that the Gibbs distribution will be invariant. It remains to prove\nthat the SDE (8.22)–(8.24) is ergodic. Certainly this would be expected in the case\nwhere a full Langevin dynamics contribution is present (\u0010 positive deﬁnite), but as\nwe shall see next there are cases where noise only contacts the auxiliary degrees of\nfreedom but the system is nonetheless ergodic.\nWe state here a useful observation that allows to simplify the commutator\ncalculations in the case of an SDE of the following type:\ndz D F.z/dt C \u0012G.z/dt;\n(8.25)\nd\u0012 D g.z/dt \u0003 \n\u0012dt C \u0007dW;\n(8.26)\nwhere z 2 Rm, F; G W Rm ! Rm.\nProposition 8.2 If the Lie algebra generated by F and G in (8.25) spans Rm, then\nthe Hörmander condition holds for the system (8.25)–(8.26).\nProof First observe that the premise holds if and only if the Lie algebra of the\nvectors in RmC1 deﬁned by\nQF D\n\u0002 F\n0\n\u0003\n;\nQG D\n\u0002G\n0\n\u0003\n;\ntogether with emC1 spans RmC1. Thus the problem is to show that we can generate\nQF and QG from the vector ﬁelds that deﬁne (8.25)–(8.26), which are\nb0 D\n\u0002F C \u0012G\ng \u0003 \n\u0012\n\u0003\n;\nb1 D\n\u0002 0\n\u0007\n\u0003\n:\nComputing the commutator gives\nc D Œb0; b1\t D\n\u0002 \u0003\u0007G\n\u0007\n\u0003\n;\nhence\nQG D \u00031\n\u0007 Œc \u0003 \nb1\t :\n\n8.4\nErgodic Stochastic-Dynamic Thermostats\n345\nThis means that we have built one of our two vectors. The second follows as a linear\ncombination of the others:\nQF D b0 \u0003 \u0012 QG \u0003 .g \u0003 \n\u0012/\u0007\u00021b1:\nut\nThe fact that the Hörmander condition holds is, as we know from Chap. 6, only\npart of the story. However based on known results for Langevin dynamics, we\nconjecture that ergodicity will hold if (i) the Hörmander condition holds, (ii) U\nis sufﬁciently smooth, and (iii) the conﬁgurational phase space is compact, e.g.\nperiodic boundary conditions are employed. However we stress that each possible\nmethod will ultimately need to be carefully and systematically checked to verify the\nergodic properties.\n8.4.1\nNosé-Hoover-Langevin: An Ergodic Weakly Coupled\nThermostat\nThe Nosé-Hoover-Langevin (NHL) method is based on a simple idea: replace the\n“chain” in the Nosé-Hoover Chain, whose sole purpose is to maintain a Gaussian\ndistribution in the auxiliary variable, by a stochastic Langevin-type thermostat. The\nmethod was ﬁrst proposed in [323]. The proof of ergodicity (more precisely the\nconﬁrmation of the Hörmander condition), for a problem with harmonic internal\ninteractions, was given in [226] and we roughly follow the treatment from this paper.\nThe Nosé-Hoover-Langevin equations are\ndq D M\u00021pdt;\n(8.27)\ndp D \u0003rU.q/dt \u0003 \u0012pdt;\n(8.28)\nd\u0012 D \u0006\u00021ŒpTM\u00021p \u0003 NdkBT\tdt \u0003 \n\u0012dt C\np\n2kBT\n\u0006\u00021dW;\n(8.29)\nwhere .q; p/ 2 D with \u0012 2 R. Let us emphasize that the principal features of this\nthermostat: (1) it is essentially Nosé-Hoover plus a perturbation, (2) it incorporates\na single Wiener process, (3) it has two free parameters \n and \u0006.\nLet us ﬁrst demonstrate that the Nosé-Hoover-Langevin method, is, in fact, a\nthermostat. We observe that we have already shown that the Nosé-Hoover method\npreserves the extended canonical distribution \u0005ˇ exp.\u0003ˇ\u0006\u00122=2/. Therefore, by the\nadditivity property, all that is needed is to show that the additional part\nd\u0012 D \u0003\n\u0012dt C\np\n2kBT\n\u0006\u00021dW\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 365,
      "printed_page": 344,
      "text": "344\n8\nExtended Variable Methods\nso the diffusion term is\nˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2ŒˇM\u00021ppTM\u00021 \u0003 M\u00021\tM1=2\u0010 1=2\u0007\nN\u0005 D \u0003drift;\nwhere we have used the cyclic property of the trace (and the symmetry of \u0010 ) to\nreduce the expression. The validity of the term involving \u0002 is easily veriﬁed by a\nsimilar argument.\nThus we know that the Gibbs distribution will be invariant. It remains to prove\nthat the SDE (8.22)–(8.24) is ergodic. Certainly this would be expected in the case\nwhere a full Langevin dynamics contribution is present (\u0010 positive deﬁnite), but as\nwe shall see next there are cases where noise only contacts the auxiliary degrees of\nfreedom but the system is nonetheless ergodic.\nWe state here a useful observation that allows to simplify the commutator\ncalculations in the case of an SDE of the following type:\ndz D F.z/dt C \u0012G.z/dt;\n(8.25)\nd\u0012 D g.z/dt \u0003 \n\u0012dt C \u0007dW;\n(8.26)\nwhere z 2 Rm, F; G W Rm ! Rm.\nProposition 8.2 If the Lie algebra generated by F and G in (8.25) spans Rm, then\nthe Hörmander condition holds for the system (8.25)–(8.26).\nProof First observe that the premise holds if and only if the Lie algebra of the\nvectors in RmC1 deﬁned by\nQF D\n\u0002 F\n0\n\u0003\n;\nQG D\n\u0002G\n0\n\u0003\n;\ntogether with emC1 spans RmC1. Thus the problem is to show that we can generate\nQF and QG from the vector ﬁelds that deﬁne (8.25)–(8.26), which are\nb0 D\n\u0002F C \u0012G\ng \u0003 \n\u0012\n\u0003\n;\nb1 D\n\u0002 0\n\u0007\n\u0003\n:\nComputing the commutator gives\nc D Œb0; b1\t D\n\u0002 \u0003\u0007G\n\u0007\n\u0003\n;\nhence\nQG D \u00031\n\u0007 Œc \u0003 \nb1\t :\n"
    },
    {
      "pdf_page": 366,
      "printed_page": 345,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n345\nThis means that we have built one of our two vectors. The second follows as a linear\ncombination of the others:\nQF D b0 \u0003 \u0012 QG \u0003 .g \u0003 \n\u0012/\u0007\u00021b1:\nut\nThe fact that the Hörmander condition holds is, as we know from Chap. 6, only\npart of the story. However based on known results for Langevin dynamics, we\nconjecture that ergodicity will hold if (i) the Hörmander condition holds, (ii) U\nis sufﬁciently smooth, and (iii) the conﬁgurational phase space is compact, e.g.\nperiodic boundary conditions are employed. However we stress that each possible\nmethod will ultimately need to be carefully and systematically checked to verify the\nergodic properties.\n8.4.1\nNosé-Hoover-Langevin: An Ergodic Weakly Coupled\nThermostat\nThe Nosé-Hoover-Langevin (NHL) method is based on a simple idea: replace the\n“chain” in the Nosé-Hoover Chain, whose sole purpose is to maintain a Gaussian\ndistribution in the auxiliary variable, by a stochastic Langevin-type thermostat. The\nmethod was ﬁrst proposed in [323]. The proof of ergodicity (more precisely the\nconﬁrmation of the Hörmander condition), for a problem with harmonic internal\ninteractions, was given in [226] and we roughly follow the treatment from this paper.\nThe Nosé-Hoover-Langevin equations are\ndq D M\u00021pdt;\n(8.27)\ndp D \u0003rU.q/dt \u0003 \u0012pdt;\n(8.28)\nd\u0012 D \u0006\u00021ŒpTM\u00021p \u0003 NdkBT\tdt \u0003 \n\u0012dt C\np\n2kBT\n\u0006\u00021dW;\n(8.29)\nwhere .q; p/ 2 D with \u0012 2 R. Let us emphasize that the principal features of this\nthermostat: (1) it is essentially Nosé-Hoover plus a perturbation, (2) it incorporates\na single Wiener process, (3) it has two free parameters \n and \u0006.\nLet us ﬁrst demonstrate that the Nosé-Hoover-Langevin method, is, in fact, a\nthermostat. We observe that we have already shown that the Nosé-Hoover method\npreserves the extended canonical distribution \u0005ˇ exp.\u0003ˇ\u0006\u00122=2/. Therefore, by the\nadditivity property, all that is needed is to show that the additional part\nd\u0012 D \u0003\n\u0012dt C\np\n2kBT\n\u0006\u00021dW\n"
    }
  ],
  "numbered_equations": [
    "8.25",
    "8.26"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "真实Wiener、适应性和可积性由additiveSDE给出；σ≠0在Hörmander结论中单列。"
  ],
  "issues": [],
  "statement_scope": "一般单热浴提升场的实际加性Wiener积分解规格。",
  "lean_decl": "MD.Ch08.liftedThermostat",
  "lean_declarations": [
    "MD.Ch08.liftedThermostat"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def liftedThermostat (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec n × ℝ)
    (x0 : Vec n × ℝ) : Prop :=
  additiveSDE P 1 W X x0 (textbookThermostatDrift F G g γ)
    (fun _ ↦ (0, σ))
```
