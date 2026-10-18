# BATCH18 第8章原文与陈述审校

## MD-8.10-NHLTotalMomentumSign
```json
{
  "source_id": "MD-8.10-NHLTotalMomentumSign",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.10",
  "printed_page": "398",
  "pdf_page": "419",
  "statement_latex": "With central forces and an NHL thermostat, total momentum obeys Ṗ=−ξP, so each component keeps the sign of its initial value.",
  "statement_verbatim": "398\n8\nExtended Variable Methods\n0.05\n0.1\n0.2\n0.01%\n0.1%\n1%\n10%\n100%\n1000%\nStepsize\nRelative Error\nRelative Error\nKinetic Temperature\nDPD−VV\nDPD−S1\nDPD−Trotter\nPNHL−S\nPNHL−N\n2nd order line\n0.05\n0.1\n0.2\n1%\n10%\n100%\nStepsize\nConﬁgurational Temperature\n2nd order line\nFig. 8.9 Log-log plot of the relative error in kinetic temperature (left) and conﬁgurational tem-\nperature (right) against stepsize by using various numerical methods. The system was simulated\nfor 1,000 reduced time units but only a trajectory’s tail of time length 800 was used to calculate\nthe static quantity to make sure the system was well equilibrated. The stepsizes tested began at\nh D 0:05 and were increased incrementally by 15 % until all methods either were above 100 %\nrelative error or became unstable\nspace, the total momenta are sums of normally distributed random variables with\nmean zero and so the total momenta too, should have normal distributions with\nmean zero. Since Langevin dynamics does not respect the momentum constraint,\nthe normal distribution is obtained. By contrast, the momentum vector is preserved\nexactly using the PNHL method. The NHL scheme performs somewhat oddly. In the\nNosé-Hoover-Langevinmethod, the total momentum ﬂuctuates but remains positive\nor negative if respective initial conditions are positive or negative (see the exercises\nat the end of the chapter). This behavior does not however contradict its mentioned\nergodic properties (one needs to pay close attention to the assumptions being placed\non the system in the proof of the ergodicity).\nWe also brieﬂy compare DPD and PNHL methods. In Fig. 8.9 we show the\nkinetic and conﬁgurational temperature errors as functions of the stepsize. The\nresults show the advantage of using the PNHL in terms of providing a more accurate\nsampling for given stepsize; the result is especially important since the PNHL\nmethods are also more efﬁcient in practice. In Fig. 8.10 the velocity autocorrelation\nfunctions are contrasted for different values of the friction coefﬁcient. This graph\nshows that for small values of \n the DPD and PNHL methods perform similarly,\nwhereas at large friction the DPD decay of correlation is substantially more rapid\nthan that for PNHL. For some additional discussion on these points, see [228].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 419,
      "printed_page": 398,
      "text": "398\n8\nExtended Variable Methods\n0.05\n0.1\n0.2\n0.01%\n0.1%\n1%\n10%\n100%\n1000%\nStepsize\nRelative Error\nRelative Error\nKinetic Temperature\nDPD−VV\nDPD−S1\nDPD−Trotter\nPNHL−S\nPNHL−N\n2nd order line\n0.05\n0.1\n0.2\n1%\n10%\n100%\nStepsize\nConﬁgurational Temperature\n2nd order line\nFig. 8.9 Log-log plot of the relative error in kinetic temperature (left) and conﬁgurational tem-\nperature (right) against stepsize by using various numerical methods. The system was simulated\nfor 1,000 reduced time units but only a trajectory’s tail of time length 800 was used to calculate\nthe static quantity to make sure the system was well equilibrated. The stepsizes tested began at\nh D 0:05 and were increased incrementally by 15 % until all methods either were above 100 %\nrelative error or became unstable\nspace, the total momenta are sums of normally distributed random variables with\nmean zero and so the total momenta too, should have normal distributions with\nmean zero. Since Langevin dynamics does not respect the momentum constraint,\nthe normal distribution is obtained. By contrast, the momentum vector is preserved\nexactly using the PNHL method. The NHL scheme performs somewhat oddly. In the\nNosé-Hoover-Langevinmethod, the total momentum ﬂuctuates but remains positive\nor negative if respective initial conditions are positive or negative (see the exercises\nat the end of the chapter). This behavior does not however contradict its mentioned\nergodic properties (one needs to pay close attention to the assumptions being placed\non the system in the proof of the ergodicity).\nWe also brieﬂy compare DPD and PNHL methods. In Fig. 8.9 we show the\nkinetic and conﬁgurational temperature errors as functions of the stepsize. The\nresults show the advantage of using the PNHL in terms of providing a more accurate\nsampling for given stepsize; the result is especially important since the PNHL\nmethods are also more efﬁcient in practice. In Fig. 8.10 the velocity autocorrelation\nfunctions are contrasted for different values of the friction coefﬁcient. This graph\nshows that for small values of \n the DPD and PNHL methods perform similarly,\nwhereas at large friction the DPD decay of correlation is substantially more rapid\nthan that for PNHL. For some additional discussion on these points, see [228].\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "只对连续ξ及实际标量ODE声明解公式，正指数乘子的符号结论已证；从NHL粒子SDE推出总动量ODE仍需成对力抵消及积分方程桥接。",
    "欧氏空间正负动量不变与特殊初值下遍历性的讨论不扩展为任意系统的遍历性反例。"
  ],
  "issues": [],
  "statement_scope": "总动量标量ODE解目标、正指数因子及显式表达式的符号保持。",
  "lean_decl": "MD.Ch08.nhlMomentumFactor",
  "lean_declarations": [
    "MD.Ch08.nhlMomentumFactor",
    "MD.Ch08.nhlMomentumFactor_pos",
    "MD.Ch08.nhlMomentum_sign",
    "MD.Ch08.nhlTotalMomentum_odeSolution"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nhlMomentumFactor (ξ : ℝ → ℝ) (t : ℝ) : ℝ := Real.exp (-(∫ s in (0 : ℝ)..t, ξ s))
theorem nhlMomentumFactor_pos (ξ : ℝ → ℝ) (t : ℝ) : 0 < nhlMomentumFactor ξ t := Real.exp_pos _
theorem nhlMomentum_sign (ξ : ℝ → ℝ) (P0 : ℝ) (t : ℝ) :
    (0 < nhlMomentumFactor ξ t*P0 ↔ 0 < P0) ∧
    (nhlMomentumFactor ξ t*P0 < 0 ↔ P0 < 0) := by
  constructor
  · exact mul_pos_iff_of_pos_left (nhlMomentumFactor_pos ξ t)
  · constructor
    · intro h
      by_contra hp
      have hp' : 0 ≤ P0 := le_of_not_gt hp
      have hn := mul_nonneg (le_of_lt (nhlMomentumFactor_pos ξ t)) hp'
      linarith
    · intro h
      exact mul_neg_of_pos_of_neg (nhlMomentumFactor_pos ξ t) h
theorem nhlTotalMomentum_odeSolution (ξ P : ℝ → ℝ) (hξ : Continuous ξ)
    (hP : ∀ t, HasDerivAt P (-ξ t*P t) t) (t : ℝ) :
    P t=nhlMomentumFactor ξ t*P 0 := by
  sorry
```
