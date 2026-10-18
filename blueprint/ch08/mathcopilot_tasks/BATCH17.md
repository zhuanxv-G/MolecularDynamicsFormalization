# BATCH17 第8章原文与陈述审校

## MD-8.9.3-PairwiseCanonicalWeight
```json
{
  "source_id": "MD-8.9.3-PairwiseCanonicalWeight",
  "kind": "definition",
  "label": null,
  "section": "8.9.3",
  "printed_page": "394",
  "pdf_page": "415",
  "statement_latex": "ρ̂β=Ẑ⁻¹exp(−βH(q,p))exp(−βQξ²/2), on accessible fixed-momentum space. (8.110).",
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
    "8.110"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "ν是需指定的动量叶参考测度；正有限配分积分和概率资格显式列出。",
    "这里只定义权重及归一目标，不把任意支持在动量叶上的测度称为PNH不变测度。完整不变性和归一存在理论列缺口。"
  ],
  "issues": [],
  "statement_scope": "动量约束下扩展Gibbs权、配分积分和概率密度资格。",
  "lean_decl": "MD.Ch08.pairwiseWeight",
  "lean_declarations": [
    "MD.Ch08.pairwiseWeight",
    "MD.Ch08.pairwiseCanonicalDensity",
    "MD.Ch08.pairwiseCanonicalQualification"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pairwiseWeight {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  Real.exp (-β*particleHamiltonian m U z.1)*Real.exp (-β*Q*z.2^2/2)
def pairwiseCanonicalDensity {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  pairwiseWeight m U β Q z/(∫ x, pairwiseWeight m U β Q x ∂ν)
def pairwiseCanonicalQualification {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ 0 < Q ∧ ν {z | totalMomentum z.1.2 ≠ π}=0 ∧
  Integrable (pairwiseWeight m U β Q) ν ∧ (0 < ∫ z, pairwiseWeight m U β Q z ∂ν) ∧
  probabilityDensity ν (pairwiseCanonicalDensity ν m U β Q)
```

## MD-8.9.4-PairwiseNHLSDE
```json
{
  "source_id": "MD-8.9.4-PairwiseNHLSDE",
  "kind": "definition",
  "label": null,
  "section": "8.9.4",
  "printed_page": "395",
  "pdf_page": "416",
  "statement_latex": "PNHL adds dξ=(G−γ̂ξ)dt+σ̂dW, σ̂²=2γ̂θ/Q, to PNH. W is standard Wiener. (8.111),(8.112).",
  "statement_verbatim": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n395\nThe pairwise-NHL (PNHL) system takes the form\ndqi D m\u00021\ni pidt;\ndpi D FC\ni .q/dt C \u0012 QF\nD\ni dt;\nd\u0012 D G.q; p/dt \u0003 Q\n\u0012dt C Q\u0007dW;\n(8.111)\nwhere all notation is as for PNH and the coefﬁcients Q\n and Q\u0007 are chosen to preserve\nthe target temperature\nQ\u00072 D 2 Q\nkBT=\u0006;\n(8.112)\nand W D W.t/ is a standard Wiener process.\nSplitting methods for the pairwise-NHL (PNHL) system (including those given\nhere) are taken up in [228]. The PNHL system can be divided into ﬁve parts such\nthat each piece can be solved exactly, in the sense of distributions:\nd\n2\n4\nqi\npi\n\u0012\n3\n5 D\n2\n4\nm\u00021\ni pi\n0\n0\n3\n5 dt\n„\nƒ‚\n…\nA\nC\n2\n4\n0\nFC\ni\n0\n3\n5 dt\n„ ƒ‚ …\nB\nC\n2\n64\n0\nC\u0012 QF\nD\ni\n0\n3\n75 dt\n„\nƒ‚\n…\nC\nC\n2\n4\n0\n0\nG\n3\n5 dt\n„ ƒ‚ …\nD\nC\n2\n4\n0\n0\n\u0003 Q\n\u0012dt C Q\u0007dW\n3\n5\n„\nƒ‚\n…\nO\n:\n(8.113)\nNote that the operators corresponding to parts A and B are exactly the same as\ndeﬁned in (8.95) and (8.96), respectively. The operators corresponding to the other\nterms in the vector ﬁeld are\nLC D \u0012\nX\ni\nQF\nD\ni .q; p/ \u0002 rpi;\nLD D G.q; p/ @\n@\u0012 ;\nLO D \u0003 Q\n\u0012 @\n@\u0012 C Q\u00072\n2\n@2\n@\u00122 :\nNote that the generator LO now only affect the auxiliary variable (as in NHL). The\ngenerator for the PNHL system is then deﬁned by\nLPNHL D LA C LB C LC C LD C LO:\n(8.114)\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 416,
      "printed_page": 395,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n395\nThe pairwise-NHL (PNHL) system takes the form\ndqi D m\u00021\ni pidt;\ndpi D FC\ni .q/dt C \u0012 QF\nD\ni dt;\nd\u0012 D G.q; p/dt \u0003 Q\n\u0012dt C Q\u0007dW;\n(8.111)\nwhere all notation is as for PNH and the coefﬁcients Q\n and Q\u0007 are chosen to preserve\nthe target temperature\nQ\u00072 D 2 Q\nkBT=\u0006;\n(8.112)\nand W D W.t/ is a standard Wiener process.\nSplitting methods for the pairwise-NHL (PNHL) system (including those given\nhere) are taken up in [228]. The PNHL system can be divided into ﬁve parts such\nthat each piece can be solved exactly, in the sense of distributions:\nd\n2\n4\nqi\npi\n\u0012\n3\n5 D\n2\n4\nm\u00021\ni pi\n0\n0\n3\n5 dt\n„\nƒ‚\n…\nA\nC\n2\n4\n0\nFC\ni\n0\n3\n5 dt\n„ ƒ‚ …\nB\nC\n2\n64\n0\nC\u0012 QF\nD\ni\n0\n3\n75 dt\n„\nƒ‚\n…\nC\nC\n2\n4\n0\n0\nG\n3\n5 dt\n„ ƒ‚ …\nD\nC\n2\n4\n0\n0\n\u0003 Q\n\u0012dt C Q\u0007dW\n3\n5\n„\nƒ‚\n…\nO\n:\n(8.113)\nNote that the operators corresponding to parts A and B are exactly the same as\ndeﬁned in (8.95) and (8.96), respectively. The operators corresponding to the other\nterms in the vector ﬁeld are\nLC D \u0012\nX\ni\nQF\nD\ni .q; p/ \u0002 rpi;\nLD D G.q; p/ @\n@\u0012 ;\nLO D \u0003 Q\n\u0012 @\n@\u0012 C Q\u00072\n2\n@2\n@\u00122 :\nNote that the generator LO now only affect the auxiliary variable (as in NHL). The\ngenerator for the PNHL system is then deﬁned by\nLPNHL D LA C LB C LC C LD C LO:\n(8.114)\n"
    }
  ],
  "numbered_equations": [
    "8.111",
    "8.112"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "实际一维标准Wiener由通用积分解规格明示；扩散仅作用ξ。",
    "未证明该非碰撞解类存在、唯一、保测或遍历；“改善遍历性”是动机不是已证结论。"
  ],
  "issues": [],
  "statement_scope": "带正质量资格、涨落耗散关系及真实独立标准Wiener的PNHL积分解规格。",
  "lean_decl": "MD.Ch08.pnhlDrift",
  "lean_declarations": [
    "MD.Ch08.pnhlDrift",
    "MD.Ch08.pnhlNoise",
    "MD.Ch08.isPNHLSolution"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pnhlDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  ((pnhDrift m α rc θ Q wD z).1,pairwiseFeedback m θ Q wD z.1.1 z.1.2-γ*z.2)
def pnhlNoise {N d : ℕ} (σ : ℝ) (_ : Fin 1) : PNHLState N d := ((0,0),σ)
def isPNHLSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → PNHLState N d)
    (x0 : PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧ 0 ≤ γ ∧
  σ^2=2*γ*θ/Q ∧ (∀ r, 0 ≤ wD r) ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1.1 i j) ∧
  additiveSDE P 1 W X x0 (pnhlDrift m α rc θ Q γ wD) (pnhlNoise σ)
```

## MD-8.9.4-PairwiseNHLGenerator
```json
{
  "source_id": "MD-8.9.4-PairwiseNHLGenerator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.9.4",
  "printed_page": "395",
  "pdf_page": "416",
  "statement_latex": "PNHL splits A,B,C,D,O, with C:ξF̃ᴰ, D:G∂ξ, O:−γ̂ξ∂ξ+σ̂²∂ξ²/2. LPNHL=LA+LB+LC+LD+LO. (8.113),(8.114).",
  "statement_verbatim": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n395\nThe pairwise-NHL (PNHL) system takes the form\ndqi D m\u00021\ni pidt;\ndpi D FC\ni .q/dt C \u0012 QF\nD\ni dt;\nd\u0012 D G.q; p/dt \u0003 Q\n\u0012dt C Q\u0007dW;\n(8.111)\nwhere all notation is as for PNH and the coefﬁcients Q\n and Q\u0007 are chosen to preserve\nthe target temperature\nQ\u00072 D 2 Q\nkBT=\u0006;\n(8.112)\nand W D W.t/ is a standard Wiener process.\nSplitting methods for the pairwise-NHL (PNHL) system (including those given\nhere) are taken up in [228]. The PNHL system can be divided into ﬁve parts such\nthat each piece can be solved exactly, in the sense of distributions:\nd\n2\n4\nqi\npi\n\u0012\n3\n5 D\n2\n4\nm\u00021\ni pi\n0\n0\n3\n5 dt\n„\nƒ‚\n…\nA\nC\n2\n4\n0\nFC\ni\n0\n3\n5 dt\n„ ƒ‚ …\nB\nC\n2\n64\n0\nC\u0012 QF\nD\ni\n0\n3\n75 dt\n„\nƒ‚\n…\nC\nC\n2\n4\n0\n0\nG\n3\n5 dt\n„ ƒ‚ …\nD\nC\n2\n4\n0\n0\n\u0003 Q\n\u0012dt C Q\u0007dW\n3\n5\n„\nƒ‚\n…\nO\n:\n(8.113)\nNote that the operators corresponding to parts A and B are exactly the same as\ndeﬁned in (8.95) and (8.96), respectively. The operators corresponding to the other\nterms in the vector ﬁeld are\nLC D \u0012\nX\ni\nQF\nD\ni .q; p/ \u0002 rpi;\nLD D G.q; p/ @\n@\u0012 ;\nLO D \u0003 Q\n\u0012 @\n@\u0012 C Q\u00072\n2\n@2\n@\u00122 :\nNote that the generator LO now only affect the auxiliary variable (as in NHL). The\ngenerator for the PNHL system is then deﬁned by\nLPNHL D LA C LB C LC C LD C LO:\n(8.114)\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 416,
      "printed_page": 395,
      "text": "8.9\nMomentum-Conserving Thermostats and the Dissipative Particle. . .\n395\nThe pairwise-NHL (PNHL) system takes the form\ndqi D m\u00021\ni pidt;\ndpi D FC\ni .q/dt C \u0012 QF\nD\ni dt;\nd\u0012 D G.q; p/dt \u0003 Q\n\u0012dt C Q\u0007dW;\n(8.111)\nwhere all notation is as for PNH and the coefﬁcients Q\n and Q\u0007 are chosen to preserve\nthe target temperature\nQ\u00072 D 2 Q\nkBT=\u0006;\n(8.112)\nand W D W.t/ is a standard Wiener process.\nSplitting methods for the pairwise-NHL (PNHL) system (including those given\nhere) are taken up in [228]. The PNHL system can be divided into ﬁve parts such\nthat each piece can be solved exactly, in the sense of distributions:\nd\n2\n4\nqi\npi\n\u0012\n3\n5 D\n2\n4\nm\u00021\ni pi\n0\n0\n3\n5 dt\n„\nƒ‚\n…\nA\nC\n2\n4\n0\nFC\ni\n0\n3\n5 dt\n„ ƒ‚ …\nB\nC\n2\n64\n0\nC\u0012 QF\nD\ni\n0\n3\n75 dt\n„\nƒ‚\n…\nC\nC\n2\n4\n0\n0\nG\n3\n5 dt\n„ ƒ‚ …\nD\nC\n2\n4\n0\n0\n\u0003 Q\n\u0012dt C Q\u0007dW\n3\n5\n„\nƒ‚\n…\nO\n:\n(8.113)\nNote that the operators corresponding to parts A and B are exactly the same as\ndeﬁned in (8.95) and (8.96), respectively. The operators corresponding to the other\nterms in the vector ﬁeld are\nLC D \u0012\nX\ni\nQF\nD\ni .q; p/ \u0002 rpi;\nLD D G.q; p/ @\n@\u0012 ;\nLO D \u0003 Q\n\u0012 @\n@\u0012 C Q\u00072\n2\n@2\n@\u00122 :\nNote that the generator LO now only affect the auxiliary variable (as in NHL). The\ngenerator for the PNHL system is then deﬁned by\nLPNHL D LA C LB C LC C LD C LO:\n(8.114)\n"
    }
  ],
  "numbered_equations": [
    "8.113",
    "8.114"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "驻定式只为非碰撞、离开截断界面的局部光滑目标；全局保测需边界、半群等理论。",
    "没有以漂移分解恒等式替代驻定或遍历性证明；两者分别列状态。"
  ],
  "issues": [],
  "statement_scope": "五子场、形式生成元、漂移分解；扩展权的局部驻定目标。",
  "lean_decl": "MD.Ch08.pnhlA",
  "lean_declarations": [
    "MD.Ch08.pnhlA",
    "MD.Ch08.pnhlB",
    "MD.Ch08.pnhlC",
    "MD.Ch08.pnhlD",
    "MD.Ch08.pnhlO",
    "MD.Ch08.pnhlGenerator",
    "MD.Ch08.pnhlDrift_split",
    "MD.Ch08.pairwiseWeight_localStationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pnhlA {N d : ℕ} (m : Fin N → ℝ) (z : PNHLState N d) : PNHLState N d := (dpdA m z.1,0)
def pnhlB {N d : ℕ} (α rc : ℝ) (z : PNHLState N d) : PNHLState N d := (dpdB α rc z.1,0)
def pnhlC {N d : ℕ} (m : Fin N → ℝ) (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((0,z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),0)
def pnhlD {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d := ((0,0),pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlO {N d : ℕ} (γ : ℝ) (z : PNHLState N d) : PNHLState N d := ((0,0),-γ*z.2)
def pnhlGenerator {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (f : PNHLState N d → ℝ) (z : PNHLState N d) : ℝ :=
  firstOrder8 (pnhlA m) f z+firstOrder8 (pnhlB α rc) f z+firstOrder8 (pnhlC m wD) f z+
    firstOrder8 (pnhlD m θ Q wD) f z+additiveGenerator (pnhlO γ) (pnhlNoise σ 0) f z
theorem pnhlDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : pnhlDrift m α rc θ Q γ wD z=
      pnhlA m z+pnhlB α rc z+pnhlC m wD z+pnhlD m θ Q wD z+pnhlO γ z := by
  ext <;> simp [pnhlDrift,pnhDrift,pnhlA,pnhlB,pnhlC,pnhlD,pnhlO,dpdA,dpdB,sub_eq_add_neg]
theorem pairwiseWeight_localStationary {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ)
    (hm : ∀ i, 0 < m i) (hrc : 0 < rc) (hθ : 0 < θ) (hQ : 0 < Q)
    (hγ : 0 ≤ γ) (hσ : σ^2=2*γ*θ/Q) (z : PNHLState N d)
    (hq : ∀ i j, i ≠ j → 0 < pairDistance z.1.1 i j)
    (hcut : ∀ i j, i ≠ j → pairDistance z.1.1 i j ≠ rc) :
    -textbookDivergence (fun x ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q x •
      pnhlDrift m α rc θ Q γ (fun r ↦ (dpdWeightR rc r)^2) x) z+
      σ^2/2*deriv (deriv (fun s ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q (z.1,s))) z.2=0 := by
  sorry
```

## MD-8.9.4-PNHLSplittingAlgorithms
```json
{
  "source_id": "MD-8.9.4-PNHLSplittingAlgorithms",
  "kind": "algorithm",
  "label": null,
  "section": "8.9.4",
  "printed_page": "396",
  "pdf_page": "417",
  "statement_latex": "PNHL-S: A½B½C½D½OD½C½B½A½; PNHL-N: A½B½C½D½OD½C½A½B½.",
  "statement_verbatim": "396\n8\nExtended Variable Methods\nWe could split this system in a number of ways. Each of these maps exp.tL?/\nmay be integrated in the weak sense. Two examples of integrators are the PNHL-S\nand PNHL-N schemes deﬁned in [228] as\neh OLPNHL-S D e\nh\n2 LAe\nh\n2 LBe\nh\n2 LCe\nh\n2 LDehLOe\nh\n2 LDe\nh\n2 LCe\nh\n2 LBe\nh\n2 LA;\nand\neh OLPNHL-N D e\nh\n2 LAe\nh\n2 LBe\nh\n2 LCe\nh\n2 LDehLOe\nh\n2 LDe\nh\n2 LCe\nh\n2 LAe\nh\n2 LB:\nTraditionally, and elsewhere in this book, we have found symmetric compositions\nto have superior performance. This is normally due to the fact that they deliver\neven order of accuracy. In the case of PNHL-S, the supposed advantage would be\ncompounded by the fact that, as in the Verlet and \u0002BAOAB\u0003 methods, the forces\nneed only be computed once per timestep. However, rather surprisingly, and for\nreasons that are as yet unclear, it turns out that the most advantageous technique\nfrom the point of view of accuracy with respect to the invariant measure has been\nobserved to be the nonsymmetric integration strategy PNHL-N. This method also\nshows, for a variety of observables, 2nd order approximation of averages. It also\nallows the use of a much larger integration timestep in practice—so large that it\nis still more efﬁcient for DPD-like simulations when the extra force calculation is\ntaken into account!\n8.10\nNumerical Experiments\nWe investigate a simple test system of 18 unit-mass particles in a 2D periodic 3 \u0004 3\nbox using the typical soft DPD potential given in (8.83), with a cutoff radius of 1.0\nand ˛ D 25. In our simulations the temperature was ﬁxed at T D 1.\nWe implement the Nosé-Hoover-Langevin and Langevin dynamics schemes,\nas well as the momentum-conserving PNHL thermostat, and plot the normalized\nmomentum distributions and time evolution of total momentum for the methods\nin Fig. 8.8. Additionally we compare against the method of Berendsen [32], which\nmodiﬁes Netwon’s equations of motion to incorporate a relaxation process for the\ntotal system temperature, representing the exchange of energy from the coupling\nof the external bath. If the instantaneous temperature at time t is T.t/, with target\ntemperature T, then using the Berendsen device we have\nPT.t/ D \nT.T \u0003 T.t//;\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 417,
      "printed_page": 396,
      "text": "396\n8\nExtended Variable Methods\nWe could split this system in a number of ways. Each of these maps exp.tL?/\nmay be integrated in the weak sense. Two examples of integrators are the PNHL-S\nand PNHL-N schemes deﬁned in [228] as\neh OLPNHL-S D e\nh\n2 LAe\nh\n2 LBe\nh\n2 LCe\nh\n2 LDehLOe\nh\n2 LDe\nh\n2 LCe\nh\n2 LBe\nh\n2 LA;\nand\neh OLPNHL-N D e\nh\n2 LAe\nh\n2 LBe\nh\n2 LCe\nh\n2 LDehLOe\nh\n2 LDe\nh\n2 LCe\nh\n2 LAe\nh\n2 LB:\nTraditionally, and elsewhere in this book, we have found symmetric compositions\nto have superior performance. This is normally due to the fact that they deliver\neven order of accuracy. In the case of PNHL-S, the supposed advantage would be\ncompounded by the fact that, as in the Verlet and \u0002BAOAB\u0003 methods, the forces\nneed only be computed once per timestep. However, rather surprisingly, and for\nreasons that are as yet unclear, it turns out that the most advantageous technique\nfrom the point of view of accuracy with respect to the invariant measure has been\nobserved to be the nonsymmetric integration strategy PNHL-N. This method also\nshows, for a variety of observables, 2nd order approximation of averages. It also\nallows the use of a much larger integration timestep in practice—so large that it\nis still more efﬁcient for DPD-like simulations when the extra force calculation is\ntaken into account!\n8.10\nNumerical Experiments\nWe investigate a simple test system of 18 unit-mass particles in a 2D periodic 3 \u0004 3\nbox using the typical soft DPD potential given in (8.83), with a cutoff radius of 1.0\nand ˛ D 25. In our simulations the temperature was ﬁxed at T D 1.\nWe implement the Nosé-Hoover-Langevin and Langevin dynamics schemes,\nas well as the momentum-conserving PNHL thermostat, and plot the normalized\nmomentum distributions and time evolution of total momentum for the methods\nin Fig. 8.8. Additionally we compare against the method of Berendsen [32], which\nmodiﬁes Netwon’s equations of motion to incorporate a relaxation process for the\ntotal system temperature, representing the exchange of energy from the coupling\nof the external bath. If the instantaneous temperature at time t is T.t/, with target\ntemperature T, then using the Berendsen device we have\nPT.t/ D \nT.T \u0003 T.t//;\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "O需θ,Q>0、γ,h≥0及R独立标准正态；A/B/D给实际子步。C仅给逐对精确更新，全C需有序逐对近似，未冒称精确全流。",
    "两组合保留原印因子顺序；不证明全方法弱阶、不变分布误差或非对称方法更优的经验结论。"
  ],
  "issues": [],
  "statement_scope": "A/B/D/O实际更新、单对C更新和S/N的原印外层组合；全C指数与误差理论列缺口。",
  "lean_decl": "MD.Ch08.pnhlAStep",
  "lean_declarations": [
    "MD.Ch08.pnhlAStep",
    "MD.Ch08.pnhlBStep",
    "MD.Ch08.pnhlDStep",
    "MD.Ch08.pnhlOStep",
    "MD.Ch08.pnhlPairCStep",
    "MD.Ch08.pnhlSComposition",
    "MD.Ch08.pnhlNComposition"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pnhlAStep {N d : ℕ} (m : Fin N → ℝ) (h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ z.1.1 i+(h/m i) • z.1.2 i),z.1.2),z.2)
def pnhlBStep {N d : ℕ} (α rc h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((z.1.1,z.1.2+h • dpdConservative α rc z.1.1),z.2)
def pnhlDStep {N d : ℕ} (m : Fin N → ℝ) (θ Q h : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (z.1,z.2+h*pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlOStep {N d : ℕ} (θ Q γ h R : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (z.1,Real.exp (-γ*h)*z.2+Real.sqrt (θ/Q*(1-Real.exp (-2*γ*h)))*R)
def pnhlPairCStep {N d : ℕ} (i j : Fin N) (m : Fin N → ℝ) (h : ℝ)
    (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  let mr := reducedMass8 (m i) (m j)
  let e := pairDirection z.1.1 i j
  let u := dot e (relativeVelocity m z.1.2 i j)
  let du := u*(Real.exp (-z.2*wD (pairDistance z.1.1 i j)*h/mr)-1)
  ((z.1.1,dpdPairMomentumStep i j e mr du z.1.2),z.2)
def pnhlSComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ B (h/2) ∘ A (h/2)
def pnhlNComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ A (h/2) ∘ B (h/2)
```

## MD-8.10-BerendsenRelaxation
```json
{
  "source_id": "MD-8.10-BerendsenRelaxation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.10",
  "printed_page": "396–397",
  "pdf_page": "417–418",
  "statement_latex": "Ṫ(t)=γ_T(Ttarget−T(t)), γ_T>0. After Verlet, p←√[1+γ_Th(N_d k_BT/‖p‖²−1)]p.",
  "statement_verbatim": "396\n8\nExtended Variable Methods\nWe could split this system in a number of ways. Each of these maps exp.tL?/\nmay be integrated in the weak sense. Two examples of integrators are the PNHL-S\nand PNHL-N schemes deﬁned in [228] as\neh OLPNHL-S D e\nh\n2 LAe\nh\n2 LBe\nh\n2 LCe\nh\n2 LDehLOe\nh\n2 LDe\nh\n2 LCe\nh\n2 LBe\nh\n2 LA;\nand\neh OLPNHL-N D e\nh\n2 LAe\nh\n2 LBe\nh\n2 LCe\nh\n2 LDehLOe\nh\n2 LDe\nh\n2 LCe\nh\n2 LAe\nh\n2 LB:\nTraditionally, and elsewhere in this book, we have found symmetric compositions\nto have superior performance. This is normally due to the fact that they deliver\neven order of accuracy. In the case of PNHL-S, the supposed advantage would be\ncompounded by the fact that, as in the Verlet and \u0002BAOAB\u0003 methods, the forces\nneed only be computed once per timestep. However, rather surprisingly, and for\nreasons that are as yet unclear, it turns out that the most advantageous technique\nfrom the point of view of accuracy with respect to the invariant measure has been\nobserved to be the nonsymmetric integration strategy PNHL-N. This method also\nshows, for a variety of observables, 2nd order approximation of averages. It also\nallows the use of a much larger integration timestep in practice—so large that it\nis still more efﬁcient for DPD-like simulations when the extra force calculation is\ntaken into account!\n8.10\nNumerical Experiments\nWe investigate a simple test system of 18 unit-mass particles in a 2D periodic 3 \u0004 3\nbox using the typical soft DPD potential given in (8.83), with a cutoff radius of 1.0\nand ˛ D 25. In our simulations the temperature was ﬁxed at T D 1.\nWe implement the Nosé-Hoover-Langevin and Langevin dynamics schemes,\nas well as the momentum-conserving PNHL thermostat, and plot the normalized\nmomentum distributions and time evolution of total momentum for the methods\nin Fig. 8.8. Additionally we compare against the method of Berendsen [32], which\nmodiﬁes Netwon’s equations of motion to incorporate a relaxation process for the\ntotal system temperature, representing the exchange of energy from the coupling\nof the external bath. If the instantaneous temperature at time t is T.t/, with target\ntemperature T, then using the Berendsen device we have\nPT.t/ D \nT.T \u0003 T.t//;\n\n8.10\nNumerical Experiments\n397\n-5\n5\n0\nMomentum\nDensity\nDPD/PNHL\n0\n1\n2\n3\n4\n5\n-0.004\n0\n.004\nTime  (x104)\nTime  (x104)\nTime  (x104)\nTime  (x104)\nTotal momentum \n-5\n5\n0\nMomentum\nLangevin\n-5\n5\n0\nMomentum\nNHL\nMomentum\nBerendsen\n0\n1\n2\n3\n4\n5\nTotal momentum\n-20\n-10\n0\n10\n20\nTotal momentum\n30\n0\n1\n2\n3\n4\n5\n0\n1\n2\n3\n4\n5\nTotal momentum\n−20\n−10\n0\n10\n−10\n0\n10\n20\n-5\n5\n0\nFig. 8.8 We compare the time evolution of the system’s total momentum in the x and y\ncomponents (top row, marked blue and red respectively), and momentum distributions (bottom\nrow) for various methods. In the lower row of ﬁgures, the dark, solid curve represents the exact\nnormal density, while the superimposed histograms are constructed from the simulation data.\nFrom left to right: the PNHL-N thermostat, Langevin dynamics, Nosé-Hoover-Langevin (NHL)\ndynamics and the Berensen device. The same initial conditions were used with small values of\ntotal momenta. The Berendsen device shows a rapid and systematic increase in the momenta, NHL\nand Langevin exhibit different behavior, obtaining large ﬂuctuating values, whereas the PNHL-\nN thermostat preserves the total momenta exactly. Standard DPD results are identical to those of\nPNHL in this respect\nfor some decay constant \nT > 0. The dynamics will not necessarily sample canoni-\ncally, but the method will ensure that the average temperature is well-controlled (and\nis hence sometimes useful for equilibration purposes). We implement the version of\nthe scheme given in [186], which completes a step of the velocity Verlet scheme\nfollowed by a scaling of the momenta:\np \ns\n1 C \nTh\n\bNdkBT\nkpk2 \u0003 1\n\t\np;\nfor the given timestep h.\nWe use parameters \n D 4:5, \u0006 D 1 and \nT D 1 for the integrators, with a\nsmall stepsize of h D 0:05 (making any qualitative sampling errors unlikely). We\nstarted the simulations with very small net momenta (`x D 0:0035, `y \u0007 \u00030:0019)\nand observed a dramatic increase in magnitude of both components when using\nthe simple (deterministic) Berendsen scheme. If the system is ergodic in Euclidean\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 417,
      "printed_page": 396,
      "text": "396\n8\nExtended Variable Methods\nWe could split this system in a number of ways. Each of these maps exp.tL?/\nmay be integrated in the weak sense. Two examples of integrators are the PNHL-S\nand PNHL-N schemes deﬁned in [228] as\neh OLPNHL-S D e\nh\n2 LAe\nh\n2 LBe\nh\n2 LCe\nh\n2 LDehLOe\nh\n2 LDe\nh\n2 LCe\nh\n2 LBe\nh\n2 LA;\nand\neh OLPNHL-N D e\nh\n2 LAe\nh\n2 LBe\nh\n2 LCe\nh\n2 LDehLOe\nh\n2 LDe\nh\n2 LCe\nh\n2 LAe\nh\n2 LB:\nTraditionally, and elsewhere in this book, we have found symmetric compositions\nto have superior performance. This is normally due to the fact that they deliver\neven order of accuracy. In the case of PNHL-S, the supposed advantage would be\ncompounded by the fact that, as in the Verlet and \u0002BAOAB\u0003 methods, the forces\nneed only be computed once per timestep. However, rather surprisingly, and for\nreasons that are as yet unclear, it turns out that the most advantageous technique\nfrom the point of view of accuracy with respect to the invariant measure has been\nobserved to be the nonsymmetric integration strategy PNHL-N. This method also\nshows, for a variety of observables, 2nd order approximation of averages. It also\nallows the use of a much larger integration timestep in practice—so large that it\nis still more efﬁcient for DPD-like simulations when the extra force calculation is\ntaken into account!\n8.10\nNumerical Experiments\nWe investigate a simple test system of 18 unit-mass particles in a 2D periodic 3 \u0004 3\nbox using the typical soft DPD potential given in (8.83), with a cutoff radius of 1.0\nand ˛ D 25. In our simulations the temperature was ﬁxed at T D 1.\nWe implement the Nosé-Hoover-Langevin and Langevin dynamics schemes,\nas well as the momentum-conserving PNHL thermostat, and plot the normalized\nmomentum distributions and time evolution of total momentum for the methods\nin Fig. 8.8. Additionally we compare against the method of Berendsen [32], which\nmodiﬁes Netwon’s equations of motion to incorporate a relaxation process for the\ntotal system temperature, representing the exchange of energy from the coupling\nof the external bath. If the instantaneous temperature at time t is T.t/, with target\ntemperature T, then using the Berendsen device we have\nPT.t/ D \nT.T \u0003 T.t//;\n"
    },
    {
      "pdf_page": 418,
      "printed_page": 397,
      "text": "8.10\nNumerical Experiments\n397\n-5\n5\n0\nMomentum\nDensity\nDPD/PNHL\n0\n1\n2\n3\n4\n5\n-0.004\n0\n.004\nTime  (x104)\nTime  (x104)\nTime  (x104)\nTime  (x104)\nTotal momentum \n-5\n5\n0\nMomentum\nLangevin\n-5\n5\n0\nMomentum\nNHL\nMomentum\nBerendsen\n0\n1\n2\n3\n4\n5\nTotal momentum\n-20\n-10\n0\n10\n20\nTotal momentum\n30\n0\n1\n2\n3\n4\n5\n0\n1\n2\n3\n4\n5\nTotal momentum\n−20\n−10\n0\n10\n−10\n0\n10\n20\n-5\n5\n0\nFig. 8.8 We compare the time evolution of the system’s total momentum in the x and y\ncomponents (top row, marked blue and red respectively), and momentum distributions (bottom\nrow) for various methods. In the lower row of ﬁgures, the dark, solid curve represents the exact\nnormal density, while the superimposed histograms are constructed from the simulation data.\nFrom left to right: the PNHL-N thermostat, Langevin dynamics, Nosé-Hoover-Langevin (NHL)\ndynamics and the Berensen device. The same initial conditions were used with small values of\ntotal momenta. The Berendsen device shows a rapid and systematic increase in the momenta, NHL\nand Langevin exhibit different behavior, obtaining large ﬂuctuating values, whereas the PNHL-\nN thermostat preserves the total momenta exactly. Standard DPD results are identical to those of\nPNHL in this respect\nfor some decay constant \nT > 0. The dynamics will not necessarily sample canoni-\ncally, but the method will ensure that the average temperature is well-controlled (and\nis hence sometimes useful for equilibration purposes). We implement the version of\nthe scheme given in [186], which completes a step of the velocity Verlet scheme\nfollowed by a scaling of the momenta:\np \ns\n1 C \nTh\n\bNdkBT\nkpk2 \u0003 1\n\t\np;\nfor the given timestep h.\nWe use parameters \n D 4:5, \u0006 D 1 and \nT D 1 for the integrators, with a\nsmall stepsize of h D 0:05 (making any qualitative sampling errors unlikely). We\nstarted the simulations with very small net momenta (`x D 0:0035, `y \u0007 \u00030:0019)\nand observed a dramatic increase in magnitude of both components when using\nthe simple (deterministic) Berendsen scheme. If the system is ergodic in Euclidean\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "取单位粒子质量的Euclidean动量平方和；有效域显式要求非零动量及非负根号，避免将总化sqrt/division当作物理方法。",
    "只证明所印温度ODE的显式解及动量缩放能量恒等式；不声称温度控制必然正则采样。完整Verlet耦合的统计行为未证。"
  ],
  "issues": [],
  "statement_scope": "Berendsen温度方程的显式解、动量缩放、有效域和单次能量恒等式。",
  "lean_decl": "MD.Ch08.berendsenTemperature",
  "lean_declarations": [
    "MD.Ch08.berendsenTemperature",
    "MD.Ch08.berendsenTemperature_derivative",
    "MD.Ch08.berendsenRadicand",
    "MD.Ch08.berendsenScale",
    "MD.Ch08.berendsenScaleQualification",
    "MD.Ch08.dot_smul_same",
    "MD.Ch08.berendsenScale_energy"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def berendsenTemperature (θ T0 γ t : ℝ) : ℝ := θ+(T0-θ)*Real.exp (-γ*t)
theorem berendsenTemperature_derivative (θ T0 γ t : ℝ) :
    HasDerivAt (berendsenTemperature θ T0 γ) (γ*(θ-berendsenTemperature θ T0 γ t)) t := by
  convert (hasDerivAt_const t θ).add (((hasDerivAt_id t).const_mul (-γ)).exp.const_mul (T0-θ)) using 1
  · ext x
    dsimp [berendsenTemperature]
  · dsimp [berendsenTemperature]
    ring
def berendsenRadicand (nd θ γ h E : ℝ) : ℝ := 1+γ*h*(nd*θ/E-1)
def berendsenScale {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Vec n :=
  Real.sqrt (berendsenRadicand n θ γ h (dot p p)) • p
def berendsenScaleQualification {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Prop :=
  0 < n ∧ 0 < θ ∧ 0 < γ ∧ 0 ≤ h ∧ 0 < dot p p ∧ 0 ≤ berendsenRadicand n θ γ h (dot p p)
theorem dot_smul_same {n : ℕ} (c : ℝ) (p : Vec n) : dot (c • p) (c • p)=c^2*dot p p := by
  simp only [dot,Pi.smul_apply,smul_eq_mul,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i hi
  ring
theorem berendsenScale_energy {n : ℕ} (θ γ h : ℝ) (p : Vec n)
    (hq : berendsenScaleQualification θ γ h p) :
    dot (berendsenScale θ γ h p) (berendsenScale θ γ h p)=
      (1-γ*h)*dot p p+γ*h*n*θ := by
  rw [berendsenScale,dot_smul_same,Real.sq_sqrt hq.2.2.2.2.2]
  dsimp [berendsenRadicand]
  field_simp [ne_of_gt hq.2.2.2.2.1]
  <;> ring
```

## MD-8.10-CanonicalTotalMomentumGaussian
```json
{
  "source_id": "MD-8.10-CanonicalTotalMomentumGaussian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.10",
  "printed_page": "397–398",
  "pdf_page": "418–419",
  "statement_latex": "In Euclidean canonical equilibrium, total momenta are sums of independent centered normal particle momenta and hence are centered normal.",
  "statement_verbatim": "8.10\nNumerical Experiments\n397\n-5\n5\n0\nMomentum\nDensity\nDPD/PNHL\n0\n1\n2\n3\n4\n5\n-0.004\n0\n.004\nTime  (x104)\nTime  (x104)\nTime  (x104)\nTime  (x104)\nTotal momentum \n-5\n5\n0\nMomentum\nLangevin\n-5\n5\n0\nMomentum\nNHL\nMomentum\nBerendsen\n0\n1\n2\n3\n4\n5\nTotal momentum\n-20\n-10\n0\n10\n20\nTotal momentum\n30\n0\n1\n2\n3\n4\n5\n0\n1\n2\n3\n4\n5\nTotal momentum\n−20\n−10\n0\n10\n−10\n0\n10\n20\n-5\n5\n0\nFig. 8.8 We compare the time evolution of the system’s total momentum in the x and y\ncomponents (top row, marked blue and red respectively), and momentum distributions (bottom\nrow) for various methods. In the lower row of ﬁgures, the dark, solid curve represents the exact\nnormal density, while the superimposed histograms are constructed from the simulation data.\nFrom left to right: the PNHL-N thermostat, Langevin dynamics, Nosé-Hoover-Langevin (NHL)\ndynamics and the Berensen device. The same initial conditions were used with small values of\ntotal momenta. The Berendsen device shows a rapid and systematic increase in the momenta, NHL\nand Langevin exhibit different behavior, obtaining large ﬂuctuating values, whereas the PNHL-\nN thermostat preserves the total momenta exactly. Standard DPD results are identical to those of\nPNHL in this respect\nfor some decay constant \nT > 0. The dynamics will not necessarily sample canoni-\ncally, but the method will ensure that the average temperature is well-controlled (and\nis hence sometimes useful for equilibration purposes). We implement the version of\nthe scheme given in [186], which completes a step of the velocity Verlet scheme\nfollowed by a scaling of the momenta:\np \ns\n1 C \nTh\n\bNdkBT\nkpk2 \u0003 1\n\t\np;\nfor the given timestep h.\nWe use parameters \n D 4:5, \u0006 D 1 and \nT D 1 for the integrators, with a\nsmall stepsize of h D 0:05 (making any qualitative sampling errors unlikely). We\nstarted the simulations with very small net momenta (`x D 0:0035, `y \u0007 \u00030:0019)\nand observed a dramatic increase in magnitude of both components when using\nthe simple (deterministic) Berendsen scheme. If the system is ergodic in Euclidean\n\n398\n8\nExtended Variable Methods\n0.05\n0.1\n0.2\n0.01%\n0.1%\n1%\n10%\n100%\n1000%\nStepsize\nRelative Error\nRelative Error\nKinetic Temperature\nDPD−VV\nDPD−S1\nDPD−Trotter\nPNHL−S\nPNHL−N\n2nd order line\n0.05\n0.1\n0.2\n1%\n10%\n100%\nStepsize\nConﬁgurational Temperature\n2nd order line\nFig. 8.9 Log-log plot of the relative error in kinetic temperature (left) and conﬁgurational tem-\nperature (right) against stepsize by using various numerical methods. The system was simulated\nfor 1,000 reduced time units but only a trajectory’s tail of time length 800 was used to calculate\nthe static quantity to make sure the system was well equilibrated. The stepsizes tested began at\nh D 0:05 and were increased incrementally by 15 % until all methods either were above 100 %\nrelative error or became unstable\nspace, the total momenta are sums of normally distributed random variables with\nmean zero and so the total momenta too, should have normal distributions with\nmean zero. Since Langevin dynamics does not respect the momentum constraint,\nthe normal distribution is obtained. By contrast, the momentum vector is preserved\nexactly using the PNHL method. The NHL scheme performs somewhat oddly. In the\nNosé-Hoover-Langevinmethod, the total momentum ﬂuctuates but remains positive\nor negative if respective initial conditions are positive or negative (see the exercises\nat the end of the chapter). This behavior does not however contradict its mentioned\nergodic properties (one needs to pay close attention to the assumptions being placed\non the system in the proof of the ergodicity).\nWe also brieﬂy compare DPD and PNHL methods. In Fig. 8.9 we show the\nkinetic and conﬁgurational temperature errors as functions of the stepsize. The\nresults show the advantage of using the PNHL in terms of providing a more accurate\nsampling for given stepsize; the result is especially important since the PNHL\nmethods are also more efﬁcient in practice. In Fig. 8.10 the velocity autocorrelation\nfunctions are contrasted for different values of the friction coefﬁcient. This graph\nshows that for small values of \n the DPD and PNHL methods perform similarly,\nwhereas at large friction the DPD decay of correlation is substantially more rapid\nthan that for PNHL. For some additional discussion on these points, see [228].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 418,
      "printed_page": 397,
      "text": "8.10\nNumerical Experiments\n397\n-5\n5\n0\nMomentum\nDensity\nDPD/PNHL\n0\n1\n2\n3\n4\n5\n-0.004\n0\n.004\nTime  (x104)\nTime  (x104)\nTime  (x104)\nTime  (x104)\nTotal momentum \n-5\n5\n0\nMomentum\nLangevin\n-5\n5\n0\nMomentum\nNHL\nMomentum\nBerendsen\n0\n1\n2\n3\n4\n5\nTotal momentum\n-20\n-10\n0\n10\n20\nTotal momentum\n30\n0\n1\n2\n3\n4\n5\n0\n1\n2\n3\n4\n5\nTotal momentum\n−20\n−10\n0\n10\n−10\n0\n10\n20\n-5\n5\n0\nFig. 8.8 We compare the time evolution of the system’s total momentum in the x and y\ncomponents (top row, marked blue and red respectively), and momentum distributions (bottom\nrow) for various methods. In the lower row of ﬁgures, the dark, solid curve represents the exact\nnormal density, while the superimposed histograms are constructed from the simulation data.\nFrom left to right: the PNHL-N thermostat, Langevin dynamics, Nosé-Hoover-Langevin (NHL)\ndynamics and the Berensen device. The same initial conditions were used with small values of\ntotal momenta. The Berendsen device shows a rapid and systematic increase in the momenta, NHL\nand Langevin exhibit different behavior, obtaining large ﬂuctuating values, whereas the PNHL-\nN thermostat preserves the total momenta exactly. Standard DPD results are identical to those of\nPNHL in this respect\nfor some decay constant \nT > 0. The dynamics will not necessarily sample canoni-\ncally, but the method will ensure that the average temperature is well-controlled (and\nis hence sometimes useful for equilibration purposes). We implement the version of\nthe scheme given in [186], which completes a step of the velocity Verlet scheme\nfollowed by a scaling of the momenta:\np \ns\n1 C \nTh\n\bNdkBT\nkpk2 \u0003 1\n\t\np;\nfor the given timestep h.\nWe use parameters \n D 4:5, \u0006 D 1 and \nT D 1 for the integrators, with a\nsmall stepsize of h D 0:05 (making any qualitative sampling errors unlikely). We\nstarted the simulations with very small net momenta (`x D 0:0035, `y \u0007 \u00030:0019)\nand observed a dramatic increase in magnitude of both components when using\nthe simple (deterministic) Berendsen scheme. If the system is ergodic in Euclidean\n"
    },
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
    "结论明确以各粒子坐标的独立正则Gaussian分布为前提；不从“系统遍历”直接推出有限时刻分布。",
    "原页比较直方图和轨迹属于经验试验，未转为普适数学断言。"
  ],
  "issues": [],
  "statement_scope": "实际独立Gaussian动量假设下的一坐标总动量分布；非采样收敛定理。",
  "lean_decl": "MD.Ch08.totalMomentum_gaussian",
  "lean_declarations": [
    "MD.Ch08.totalMomentum_gaussian"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem totalMomentum_gaussian {N d : ℕ} (P : Measure Ω) [IsProbabilityMeasure P]
    (p : Ω → ParticleConfig N d) (m : Fin N → ℝ) (θ : ℝ)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (a : Fin d)
    (hind : iIndepFun (fun i sample ↦ p sample i a) P)
    (hlaw : ∀ i, HasLaw (fun sample ↦ p sample i a)
      (gaussianReal 0 (Real.toNNReal (m i*θ))) P) :
    HasLaw (fun sample ↦ totalMomentum (p sample) a)
      (gaussianReal 0 (Real.toNNReal ((∑ i, m i)*θ))) P := by
  sorry
```
