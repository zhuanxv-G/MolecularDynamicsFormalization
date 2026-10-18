# BATCH12 第8章原文与陈述审校

## MD-8.7.1-CombinedPronyVariable
```json
{
  "source_id": "MD-8.7.1-CombinedPronyVariable",
  "kind": "definition",
  "label": null,
  "section": "8.7.1",
  "printed_page": "376",
  "pdf_page": "397",
  "statement_latex": "σᵢₖ=ηᵢₖ+Rᵢₖ yields dσᵢₖ=−σᵢₖdt/τₖ−cₖpᵢdt/τₖ+√(2k_BT cₖ)dWᵢₖ/τₖ. (8.68)–(8.70).",
  "statement_verbatim": "376\n8\nExtended Variable Methods\nTo calculate the random forces associated to the kth term of the expansion, we\nnote that these can be viewed as the solution of a linear SDE, speciﬁcally\ndRi;k D \u0003 1\n\u0002k\nRi;k.t/dt C 1\n\u0002k\np\n2kBTckdWi;k.t/\n(8.65)\nwhere Wi;k is a standard Wiener process. The random force is seen to be deﬁned as\nthe solution of an Ornstein-Uhlenbeck process induced by the Prony representation.\nIt is easily shown that Ri;k.t/ has zero mean and autocorrelation deﬁned by\nhRi;k.t C s/Ri;k.t/i D kBTck\n\u0002k\nexp\n\u0002\n\u0003 1\n\u0002k\ns\n\u0003\n;\ns \b 0\n(8.66)\nThe total random force is then obtained by summation\nRi D\nkmax\nX\nkD1\nRi;k:\n(8.67)\nObserve that both random and drag forces are incorporated via summation of the\ncomponents \u000fi;k and Ri;k deﬁned by linear equations, respectively the ODE (8.64)\nand SDE (8.65). It is therefore possible to replace these components by their sum\n\u0007i;k D \u000fi;k C Ri;k\nwhich may be evolved by a single SDE. The equations therefore become\ndqi D m\u00021\ni pidt;\n(8.68)\ndpi D Fidt C\nkmax\nX\nkD1\n\u0007i;kdt;\n(8.69)\nd\u0007i;k D \u0003 1\n\u0002k\n\u0007i;kdt \u0003 ck\n\u0002k\npidt C 1\n\u0002k\np\n2kBTckdWi;k:\n(8.70)\nThe relation between the Prony series representation and Langevin dynamics can be\nseen in an informal sense by multiplying the equation for \u0007i;k equation by \u0002k, and\nconsidering \u0002k ! 0, giving\n\u0007i;kdt D \u0003ckpidt C\np\n2kBTckdWi;k;\nwhich results in\ndpi D Fidt \u0003\n kmax\nX\nkD1\nck\n!\npidt C\np\n2kBT\n`\nX\nkD1\npckdWi;k:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 397,
      "printed_page": 376,
      "text": "376\n8\nExtended Variable Methods\nTo calculate the random forces associated to the kth term of the expansion, we\nnote that these can be viewed as the solution of a linear SDE, speciﬁcally\ndRi;k D \u0003 1\n\u0002k\nRi;k.t/dt C 1\n\u0002k\np\n2kBTckdWi;k.t/\n(8.65)\nwhere Wi;k is a standard Wiener process. The random force is seen to be deﬁned as\nthe solution of an Ornstein-Uhlenbeck process induced by the Prony representation.\nIt is easily shown that Ri;k.t/ has zero mean and autocorrelation deﬁned by\nhRi;k.t C s/Ri;k.t/i D kBTck\n\u0002k\nexp\n\u0002\n\u0003 1\n\u0002k\ns\n\u0003\n;\ns \b 0\n(8.66)\nThe total random force is then obtained by summation\nRi D\nkmax\nX\nkD1\nRi;k:\n(8.67)\nObserve that both random and drag forces are incorporated via summation of the\ncomponents \u000fi;k and Ri;k deﬁned by linear equations, respectively the ODE (8.64)\nand SDE (8.65). It is therefore possible to replace these components by their sum\n\u0007i;k D \u000fi;k C Ri;k\nwhich may be evolved by a single SDE. The equations therefore become\ndqi D m\u00021\ni pidt;\n(8.68)\ndpi D Fidt C\nkmax\nX\nkD1\n\u0007i;kdt;\n(8.69)\nd\u0007i;k D \u0003 1\n\u0002k\n\u0007i;kdt \u0003 ck\n\u0002k\npidt C 1\n\u0002k\np\n2kBTckdWi;k:\n(8.70)\nThe relation between the Prony series representation and Langevin dynamics can be\nseen in an informal sense by multiplying the equation for \u0007i;k equation by \u0002k, and\nconsidering \u0002k ! 0, giving\n\u0007i;kdt D \u0003ckpidt C\np\n2kBTckdWi;k;\nwhich results in\ndpi D Fidt \u0003\n kmax\nX\nkD1\nck\n!\npidt C\np\n2kBT\n`\nX\nkD1\npckdWi;k:\n"
    }
  ],
  "numbered_equations": [
    "8.68",
    "8.69",
    "8.70"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "额外变量取实数；正质量、c、τ、温度和独立标准向量Wiener写入解规格。e仅把有限噪声坐标编号为(k,i)。",
    "本条实际是加性扩展SDE和漂移合并恒等式；Markov半群构造、解存在唯一及与非Markov GLE分布等价列缺口。"
  ],
  "issues": [],
  "statement_scope": "有限维扩展SDE完整积分规格及σ=η+R的漂移恒等式。",
  "lean_decl": "MD.Ch08.GLEState",
  "lean_declarations": [
    "MD.Ch08.GLEState",
    "MD.Ch08.gleDrift",
    "MD.Ch08.gleNoise",
    "MD.Ch08.isExtendedGLESolution",
    "MD.Ch08.combinedProny_drift"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
abbrev GLEState (n K : ℕ) := Phase n × (Fin K → Vec n)
def gleDrift {K : ℕ} (invm : Vec n) (U : Vec n → ℝ) (c τ : Fin K → ℝ)
    (z : GLEState n K) : GLEState n K :=
  ((fun i ↦ invm i*z.1.2 i,-gradient U z.1.1+∑ k, z.2 k),
   fun k i ↦ -z.2 k i/τ k-c k/τ k*z.1.2 i)
def gleNoise {K : ℕ} (c τ : Fin K → ℝ) (θ : ℝ)
    (e : Fin (K*n) ≃ Fin K × Fin n) (j : Fin (K*n)) : GLEState n K :=
  ((0,0),fun k i ↦ if (k,i)=e j then Real.sqrt (2*θ*c k)/τ k else 0)
def isExtendedGLESolution {K : ℕ} (invm : Vec n) (U : Vec n → ℝ)
    (c τ : Fin K → ℝ) (θ : ℝ) (e : Fin (K*n) ≃ Fin K × Fin n)
    (P : Measure Ω) (W : ℝ → Ω → Vec (K*n))
    (X : ℝ → Ω → GLEState n K) (x0 : GLEState n K) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < θ ∧ pronyQualification c τ ∧ ContDiff ℝ 1 U ∧
  additiveSDE P (K*n) W X x0 (gleDrift invm U c τ) (gleNoise c τ θ e)
theorem combinedProny_drift (η R c τ p : ℝ) :
    (-η/τ-c/τ*p)+(-R/τ)=-(η+R)/τ-c/τ*p := by ring
```

## MD-8.7.1-PronyLangevinLimit
```json
{
  "source_id": "MD-8.7.1-PronyLangevinLimit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.7.1",
  "printed_page": "376–377",
  "pdf_page": "397–398",
  "statement_latex": "Formally τₖ→0 gives σᵢₖdt=−cₖpᵢdt+√(2k_BT cₖ)dWᵢₖ and Langevin friction γ̂=Σₖcₖ. Independent Gaussian variances add.",
  "statement_verbatim": "376\n8\nExtended Variable Methods\nTo calculate the random forces associated to the kth term of the expansion, we\nnote that these can be viewed as the solution of a linear SDE, speciﬁcally\ndRi;k D \u0003 1\n\u0002k\nRi;k.t/dt C 1\n\u0002k\np\n2kBTckdWi;k.t/\n(8.65)\nwhere Wi;k is a standard Wiener process. The random force is seen to be deﬁned as\nthe solution of an Ornstein-Uhlenbeck process induced by the Prony representation.\nIt is easily shown that Ri;k.t/ has zero mean and autocorrelation deﬁned by\nhRi;k.t C s/Ri;k.t/i D kBTck\n\u0002k\nexp\n\u0002\n\u0003 1\n\u0002k\ns\n\u0003\n;\ns \b 0\n(8.66)\nThe total random force is then obtained by summation\nRi D\nkmax\nX\nkD1\nRi;k:\n(8.67)\nObserve that both random and drag forces are incorporated via summation of the\ncomponents \u000fi;k and Ri;k deﬁned by linear equations, respectively the ODE (8.64)\nand SDE (8.65). It is therefore possible to replace these components by their sum\n\u0007i;k D \u000fi;k C Ri;k\nwhich may be evolved by a single SDE. The equations therefore become\ndqi D m\u00021\ni pidt;\n(8.68)\ndpi D Fidt C\nkmax\nX\nkD1\n\u0007i;kdt;\n(8.69)\nd\u0007i;k D \u0003 1\n\u0002k\n\u0007i;kdt \u0003 ck\n\u0002k\npidt C 1\n\u0002k\np\n2kBTckdWi;k:\n(8.70)\nThe relation between the Prony series representation and Langevin dynamics can be\nseen in an informal sense by multiplying the equation for \u0007i;k equation by \u0002k, and\nconsidering \u0002k ! 0, giving\n\u0007i;kdt D \u0003ckpidt C\np\n2kBTckdWi;k;\nwhich results in\ndpi D Fidt \u0003\n kmax\nX\nkD1\nck\n!\npidt C\np\n2kBT\n`\nX\nkD1\npckdWi;k:\n\n8.7\nGeneralized Langevin Dynamics\n377\nObserving that the sum of ` independent Guassian random variables of variance ck\nis a Gaussian random variable with variance P`\nkD1 ck, we see that this is in the form\nof Langevin dynamics\ndpi D Fidt \u0003 O\npidt C\np\n2kBT O\ndWi;k;\nwith\nO\n D\nNk\nX\nkD1\nck:\n(For the formal treatment of this limit refer to [293].)\nFor numerical integration, the system (8.68)–(8.70) can be handled via splitting.\nA natural family of methods based on Verlet is the following [19]:\nGeneralized Langevin Dynamics Method\npnC1=2 :D pn C h\n2F.qn/ C h\n2\nkmax\nX\nkD1\n\u0012 n;k;\nqnC1 :D qn C hM\u00021pnC1=2;\n\u0012 nC1;k :D \u000ek\u0012 n;k \u0003 .1 \u0003 \u000ek/ ckpnC1=2 C ˛k\np\n2kBTckZn\nk;\npnC1 :D pnC1=2 C h\n2F.qnC1/ C h\n2\nkmax\nX\nkD1\n\u0012 nC1;k;\nwhere \u0012 n;k is a Nc-dimensional vector, and the components of the Nc-dimensional\nvectors Zn;k are independent standard normal random variables.\nThe real-valued coefﬁcients \u000ek and ˛k which must satisfy, for consistency, the\nequations\n\u000ek D 1 \u0003 h\n\u0002k\nC O.h2/;\n˛k D\np\nh\n\u0002k\nC O.h/:\nAn argument is given in [19] that ˛k and \u000ek should be taken as\n\u000ek D exp.\u0003h=\u0002k/;\n˛k D\ns\n.1 \u0003 \u000ek/2\nh\n;\nsince, for this choice, the Langevin limit is preserved. Alternative methods are\npossible. For many comparisons and numerical experiments, refer to [19].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 397,
      "printed_page": 376,
      "text": "376\n8\nExtended Variable Methods\nTo calculate the random forces associated to the kth term of the expansion, we\nnote that these can be viewed as the solution of a linear SDE, speciﬁcally\ndRi;k D \u0003 1\n\u0002k\nRi;k.t/dt C 1\n\u0002k\np\n2kBTckdWi;k.t/\n(8.65)\nwhere Wi;k is a standard Wiener process. The random force is seen to be deﬁned as\nthe solution of an Ornstein-Uhlenbeck process induced by the Prony representation.\nIt is easily shown that Ri;k.t/ has zero mean and autocorrelation deﬁned by\nhRi;k.t C s/Ri;k.t/i D kBTck\n\u0002k\nexp\n\u0002\n\u0003 1\n\u0002k\ns\n\u0003\n;\ns \b 0\n(8.66)\nThe total random force is then obtained by summation\nRi D\nkmax\nX\nkD1\nRi;k:\n(8.67)\nObserve that both random and drag forces are incorporated via summation of the\ncomponents \u000fi;k and Ri;k deﬁned by linear equations, respectively the ODE (8.64)\nand SDE (8.65). It is therefore possible to replace these components by their sum\n\u0007i;k D \u000fi;k C Ri;k\nwhich may be evolved by a single SDE. The equations therefore become\ndqi D m\u00021\ni pidt;\n(8.68)\ndpi D Fidt C\nkmax\nX\nkD1\n\u0007i;kdt;\n(8.69)\nd\u0007i;k D \u0003 1\n\u0002k\n\u0007i;kdt \u0003 ck\n\u0002k\npidt C 1\n\u0002k\np\n2kBTckdWi;k:\n(8.70)\nThe relation between the Prony series representation and Langevin dynamics can be\nseen in an informal sense by multiplying the equation for \u0007i;k equation by \u0002k, and\nconsidering \u0002k ! 0, giving\n\u0007i;kdt D \u0003ckpidt C\np\n2kBTckdWi;k;\nwhich results in\ndpi D Fidt \u0003\n kmax\nX\nkD1\nck\n!\npidt C\np\n2kBT\n`\nX\nkD1\npckdWi;k:\n"
    },
    {
      "pdf_page": 398,
      "printed_page": 377,
      "text": "8.7\nGeneralized Langevin Dynamics\n377\nObserving that the sum of ` independent Guassian random variables of variance ck\nis a Gaussian random variable with variance P`\nkD1 ck, we see that this is in the form\nof Langevin dynamics\ndpi D Fidt \u0003 O\npidt C\np\n2kBT O\ndWi;k;\nwith\nO\n D\nNk\nX\nkD1\nck:\n(For the formal treatment of this limit refer to [293].)\nFor numerical integration, the system (8.68)–(8.70) can be handled via splitting.\nA natural family of methods based on Verlet is the following [19]:\nGeneralized Langevin Dynamics Method\npnC1=2 :D pn C h\n2F.qn/ C h\n2\nkmax\nX\nkD1\n\u0012 n;k;\nqnC1 :D qn C hM\u00021pnC1=2;\n\u0012 nC1;k :D \u000ek\u0012 n;k \u0003 .1 \u0003 \u000ek/ ckpnC1=2 C ˛k\np\n2kBTckZn\nk;\npnC1 :D pnC1=2 C h\n2F.qnC1/ C h\n2\nkmax\nX\nkD1\n\u0012 nC1;k;\nwhere \u0012 n;k is a Nc-dimensional vector, and the components of the Nc-dimensional\nvectors Zn;k are independent standard normal random variables.\nThe real-valued coefﬁcients \u000ek and ˛k which must satisfy, for consistency, the\nequations\n\u000ek D 1 \u0003 h\n\u0002k\nC O.h2/;\n˛k D\np\nh\n\u0002k\nC O.h/:\nAn argument is given in [19] that ˛k and \u000ek should be taken as\n\u000ek D exp.\u0003h=\u0002k/;\n˛k D\ns\n.1 \u0003 \u000ek/2\nh\n;\nsince, for this choice, the Langevin limit is preserved. Alternative methods are\npossible. For many comparisons and numerical experiments, refer to [19].\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "仅形式极限系数与真实有限个独立Gaussian线性组合；τ→0过程弱收敛、初始层、统一时间界不在本条声明，列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "有效摩擦定义、合并漂移和有限Gaussian求和分布，不是小记忆时间极限定理。",
  "lean_decl": "MD.Ch08.pronyEffectiveFriction",
  "lean_declarations": [
    "MD.Ch08.pronyEffectiveFriction",
    "MD.Ch08.pronyLimit_drift",
    "MD.Ch08.independentGaussian_varianceSum"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pronyEffectiveFriction {K : ℕ} (c : Fin K → ℝ) : ℝ := ∑ k, c k
theorem pronyLimit_drift {K : ℕ} (c : Fin K → ℝ) (F p : ℝ) :
    F-∑ k, c k*p=F-pronyEffectiveFriction c*p := by
  simp [pronyEffectiveFriction,Finset.sum_mul]
theorem independentGaussian_varianceSum {K : ℕ} (P : Measure Ω)
    (R : Ω → (Fin K → ℝ)) (c : Fin K → ℝ) (hc : ∀ k, 0 ≤ c k)
    (hR : HasLaw R (Measure.pi (fun _ : Fin K ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ ∑ k, Real.sqrt (c k)*R sample k)
      (gaussianReal 0 (Real.toNNReal (pronyEffectiveFriction c))) P := by
  sorry
```

## MD-8.7.1-GeneralizedLangevinIntegrator
```json
{
  "source_id": "MD-8.7.1-GeneralizedLangevinIntegrator",
  "kind": "definition",
  "label": null,
  "section": "8.7.1",
  "printed_page": "377",
  "pdf_page": "398",
  "statement_latex": "The four-step method updates p_half, q_new, σ_new,k=θₖσₖ−(1−θₖ)cₖp_half+αₖ√(2k_BT cₖ)Zₖ, then p_new with the new force and new σ.",
  "statement_verbatim": "8.7\nGeneralized Langevin Dynamics\n377\nObserving that the sum of ` independent Guassian random variables of variance ck\nis a Gaussian random variable with variance P`\nkD1 ck, we see that this is in the form\nof Langevin dynamics\ndpi D Fidt \u0003 O\npidt C\np\n2kBT O\ndWi;k;\nwith\nO\n D\nNk\nX\nkD1\nck:\n(For the formal treatment of this limit refer to [293].)\nFor numerical integration, the system (8.68)–(8.70) can be handled via splitting.\nA natural family of methods based on Verlet is the following [19]:\nGeneralized Langevin Dynamics Method\npnC1=2 :D pn C h\n2F.qn/ C h\n2\nkmax\nX\nkD1\n\u0012 n;k;\nqnC1 :D qn C hM\u00021pnC1=2;\n\u0012 nC1;k :D \u000ek\u0012 n;k \u0003 .1 \u0003 \u000ek/ ckpnC1=2 C ˛k\np\n2kBTckZn\nk;\npnC1 :D pnC1=2 C h\n2F.qnC1/ C h\n2\nkmax\nX\nkD1\n\u0012 nC1;k;\nwhere \u0012 n;k is a Nc-dimensional vector, and the components of the Nc-dimensional\nvectors Zn;k are independent standard normal random variables.\nThe real-valued coefﬁcients \u000ek and ˛k which must satisfy, for consistency, the\nequations\n\u000ek D 1 \u0003 h\n\u0002k\nC O.h2/;\n˛k D\np\nh\n\u0002k\nC O.h/:\nAn argument is given in [19] that ˛k and \u000ek should be taken as\n\u000ek D exp.\u0003h=\u0002k/;\n˛k D\ns\n.1 \u0003 \u000ek/2\nh\n;\nsince, for this choice, the Langevin limit is preserved. Alternative methods are\npossible. For many comparisons and numerical experiments, refer to [19].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 398,
      "printed_page": 377,
      "text": "8.7\nGeneralized Langevin Dynamics\n377\nObserving that the sum of ` independent Guassian random variables of variance ck\nis a Gaussian random variable with variance P`\nkD1 ck, we see that this is in the form\nof Langevin dynamics\ndpi D Fidt \u0003 O\npidt C\np\n2kBT O\ndWi;k;\nwith\nO\n D\nNk\nX\nkD1\nck:\n(For the formal treatment of this limit refer to [293].)\nFor numerical integration, the system (8.68)–(8.70) can be handled via splitting.\nA natural family of methods based on Verlet is the following [19]:\nGeneralized Langevin Dynamics Method\npnC1=2 :D pn C h\n2F.qn/ C h\n2\nkmax\nX\nkD1\n\u0012 n;k;\nqnC1 :D qn C hM\u00021pnC1=2;\n\u0012 nC1;k :D \u000ek\u0012 n;k \u0003 .1 \u0003 \u000ek/ ckpnC1=2 C ˛k\np\n2kBTckZn\nk;\npnC1 :D pnC1=2 C h\n2F.qnC1/ C h\n2\nkmax\nX\nkD1\n\u0012 nC1;k;\nwhere \u0012 n;k is a Nc-dimensional vector, and the components of the Nc-dimensional\nvectors Zn;k are independent standard normal random variables.\nThe real-valued coefﬁcients \u000ek and ˛k which must satisfy, for consistency, the\nequations\n\u000ek D 1 \u0003 h\n\u0002k\nC O.h2/;\n˛k D\np\nh\n\u0002k\nC O.h/:\nAn argument is given in [19] that ˛k and \u000ek should be taken as\n\u000ek D exp.\u0003h=\u0002k/;\n˛k D\ns\n.1 \u0003 \u000ek/2\nh\n;\nsince, for this choice, the Langevin limit is preserved. Alternative methods are\npossible. For many comparisons and numerical experiments, refer to [19].\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "h>0，正质量/c/τ/温度下作物理解读；跨步、模式与空间分量的完整独立正态资格另列gleNormalSequence。",
    "此处完整单步定义，不包含离散不变分布、全局弱阶或Langevin极限保持的定理。"
  ],
  "issues": [],
  "statement_scope": "四个实际更新及其全部噪声资格。",
  "lean_decl": "MD.Ch08.gleIntegrator",
  "lean_declarations": [
    "MD.Ch08.gleIntegrator",
    "MD.Ch08.gleNormalSequence"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def gleIntegrator {K : ℕ} (invm : Vec n) (U : Vec n → ℝ) (c decay noise : Fin K → ℝ)
    (θ h : ℝ) (Z : Fin K → Vec n) (z : GLEState n K) : GLEState n K :=
  let ph := z.1.2+(h/2) • (-gradient U z.1.1+∑ k, z.2 k)
  let qn := z.1.1+(h • fun i ↦ invm i*ph i)
  let sn := fun k i ↦ decay k*z.2 k i-(1-decay k)*c k*ph i+
    noise k*Real.sqrt (2*θ*c k)*Z k i
  ((qn,ph+(h/2) • (-gradient U qn+∑ k, sn k)),sn)
def gleNormalSequence {K : ℕ} (P : Measure Ω) (Z : ℕ → Ω → Fin K → Vec n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun Z P ∧ ∀ j,
    HasLaw (Z j) (Measure.pi (fun _ : Fin K ↦ Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) P
```

## MD-8.7.1-GLEConsistentCoefficients
```json
{
  "source_id": "MD-8.7.1-GLEConsistentCoefficients",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.7.1",
  "printed_page": "377",
  "pdf_page": "398",
  "statement_latex": "For consistency θₖ=1−h/τₖ+O(h²), αₖ=√h/τₖ+O(h). Choose θₖ=exp(−h/τₖ), αₖ=√((1−θₖ)²/h).",
  "statement_verbatim": "8.7\nGeneralized Langevin Dynamics\n377\nObserving that the sum of ` independent Guassian random variables of variance ck\nis a Gaussian random variable with variance P`\nkD1 ck, we see that this is in the form\nof Langevin dynamics\ndpi D Fidt \u0003 O\npidt C\np\n2kBT O\ndWi;k;\nwith\nO\n D\nNk\nX\nkD1\nck:\n(For the formal treatment of this limit refer to [293].)\nFor numerical integration, the system (8.68)–(8.70) can be handled via splitting.\nA natural family of methods based on Verlet is the following [19]:\nGeneralized Langevin Dynamics Method\npnC1=2 :D pn C h\n2F.qn/ C h\n2\nkmax\nX\nkD1\n\u0012 n;k;\nqnC1 :D qn C hM\u00021pnC1=2;\n\u0012 nC1;k :D \u000ek\u0012 n;k \u0003 .1 \u0003 \u000ek/ ckpnC1=2 C ˛k\np\n2kBTckZn\nk;\npnC1 :D pnC1=2 C h\n2F.qnC1/ C h\n2\nkmax\nX\nkD1\n\u0012 nC1;k;\nwhere \u0012 n;k is a Nc-dimensional vector, and the components of the Nc-dimensional\nvectors Zn;k are independent standard normal random variables.\nThe real-valued coefﬁcients \u000ek and ˛k which must satisfy, for consistency, the\nequations\n\u000ek D 1 \u0003 h\n\u0002k\nC O.h2/;\n˛k D\np\nh\n\u0002k\nC O.h/:\nAn argument is given in [19] that ˛k and \u000ek should be taken as\n\u000ek D exp.\u0003h=\u0002k/;\n˛k D\ns\n.1 \u0003 \u000ek/2\nh\n;\nsince, for this choice, the Langevin limit is preserved. Alternative methods are\npossible. For many comparisons and numerical experiments, refer to [19].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 398,
      "printed_page": 377,
      "text": "8.7\nGeneralized Langevin Dynamics\n377\nObserving that the sum of ` independent Guassian random variables of variance ck\nis a Gaussian random variable with variance P`\nkD1 ck, we see that this is in the form\nof Langevin dynamics\ndpi D Fidt \u0003 O\npidt C\np\n2kBT O\ndWi;k;\nwith\nO\n D\nNk\nX\nkD1\nck:\n(For the formal treatment of this limit refer to [293].)\nFor numerical integration, the system (8.68)–(8.70) can be handled via splitting.\nA natural family of methods based on Verlet is the following [19]:\nGeneralized Langevin Dynamics Method\npnC1=2 :D pn C h\n2F.qn/ C h\n2\nkmax\nX\nkD1\n\u0012 n;k;\nqnC1 :D qn C hM\u00021pnC1=2;\n\u0012 nC1;k :D \u000ek\u0012 n;k \u0003 .1 \u0003 \u000ek/ ckpnC1=2 C ˛k\np\n2kBTckZn\nk;\npnC1 :D pnC1=2 C h\n2F.qnC1/ C h\n2\nkmax\nX\nkD1\n\u0012 nC1;k;\nwhere \u0012 n;k is a Nc-dimensional vector, and the components of the Nc-dimensional\nvectors Zn;k are independent standard normal random variables.\nThe real-valued coefﬁcients \u000ek and ˛k which must satisfy, for consistency, the\nequations\n\u000ek D 1 \u0003 h\n\u0002k\nC O.h2/;\n˛k D\np\nh\n\u0002k\nC O.h/:\nAn argument is given in [19] that ˛k and \u000ek should be taken as\n\u000ek D exp.\u0003h=\u0002k/;\n˛k D\ns\n.1 \u0003 \u000ek/2\nh\n;\nsince, for this choice, the Langevin limit is preserved. Alternative methods are\npossible. For many comparisons and numerical experiments, refer to [19].\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "h从正侧趋0、τ固定正；小记忆极限另固定h>0，只陈述单步系数极限，未把它当成随机过程极限或长期采样结论。"
  ],
  "issues": [],
  "statement_scope": "两项一致性渐近和所选单步系数的τ→0极限。",
  "lean_decl": "MD.Ch08.gleDecay",
  "lean_declarations": [
    "MD.Ch08.gleDecay",
    "MD.Ch08.gleNoiseCoefficient",
    "MD.Ch08.gleCoefficientConsistency",
    "MD.Ch08.gleCoefficients_consistent",
    "MD.Ch08.gleCoefficient_smallMemory"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def gleDecay (τ h : ℝ) : ℝ := Real.exp (-h/τ)
def gleNoiseCoefficient (τ h : ℝ) : ℝ := Real.sqrt ((1-gleDecay τ h)^2/h)
def gleCoefficientConsistency (τ : ℝ) (decay noise : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ decay h-(1-h/τ)) (fun h ↦ h^2) ∧
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ noise h-Real.sqrt h/τ) (fun h ↦ h)
theorem gleCoefficients_consistent (τ : ℝ) (hτ : 0 < τ) :
    gleCoefficientConsistency τ (gleDecay τ) (gleNoiseCoefficient τ) := by
  sorry
theorem gleCoefficient_smallMemory (h : ℝ) (hh : 0 < h) :
    Tendsto (fun τ ↦ (gleDecay τ h,gleNoiseCoefficient τ h))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 ((0 : ℝ),1/Real.sqrt h)) := by
  sorry
```

## MD-8.8-NPTThermodynamics
```json
{
  "source_id": "MD-8.8-NPTThermodynamics",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8",
  "printed_page": "378",
  "pdf_page": "399",
  "statement_latex": "P=−(∂E/∂V)_{S,N}; the Maxwell cyclic relation gives (∂S/∂V)_{E,N}=P/T and (∂S/∂E)_{V,N}=1/T.",
  "statement_verbatim": "378\n8\nExtended Variable Methods\n8.8\nConstant Temperature and Pressure Molecular\nDynamics\nThe isobaric, isothermal or NPT ensemble models a system in contact with a heat\nbath (temperature T) and a “pressure reservoir” maintained at pressure P. The\npressure is deﬁned by the formula\nP D \u0003\n\u0002 @E\n@V\n\u0003\nS;N\nwhere E is the energy, V is volume, S is entropy. The notation Œ: : :\tx;y means that the\nindicated partial derivatives should be taken with respect to constant values of the\nindicated variables.\nAn isothermal-isobaric system exchanges energy with the bath in such a way\nas to maintain the constant temperature; at the same time the volume ﬂuctuates to\ncontrol the pressure. The state of the system can be expressed in terms of particle\npositions and momenta as well as the volume V, i.e. we think of the probability\ndensity as a function of q, p and V.\nLet N, V, E be the number of atoms, volume and energy, respectively, of the\nsystem of interest, and N2, V2, E2 be the corresponding quantities describing the\nbath system; we have NCN2 D QN, VCV2 D QV, ECE2 D QE all constant. We view\nthe entropy as a function of the other variables and expand in a Taylor series in both\nvolume and energy:\nS.N2; V2; E2/ D S. QN \u0003 N; QV \u0003 V; QE \u0003 E/ \u0007 S.N2; QV; QE/ \u0003 @S\n@EE \u0003 @S\n@VV:\nBear in mind that here E and V are small relative perturbations of the total energy\nand volume. The quantity @S\n@E is the reciprocal temperature.\nTo calculate @S\n@V we may use Maxwell’s thermodynamic relation [372]:\n\u0002@S\n@E\n\u0003\nV;N\n\u0002 @E\n@V\n\u0003\nS;N\n\u0002@V\n@S\n\u0003\nE;N\nD \u00031:\nSince\n\n @S\n@E\n\u000b\nV;N is T\u00021 and\n\n @E\n@V\n\u000b\nS;N is \u0003P, we obtain\n\u0002 @S\n@V\n\u0003\nE;N\nD\n1\n\n @V\n@S\n\u000b\nE;N\nD P=T:\nThis results in the formula\nS.N2; V2; E2/ \u0007 constant \u0003 E C PV\nT\n;\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 399,
      "printed_page": 378,
      "text": "378\n8\nExtended Variable Methods\n8.8\nConstant Temperature and Pressure Molecular\nDynamics\nThe isobaric, isothermal or NPT ensemble models a system in contact with a heat\nbath (temperature T) and a “pressure reservoir” maintained at pressure P. The\npressure is deﬁned by the formula\nP D \u0003\n\u0002 @E\n@V\n\u0003\nS;N\nwhere E is the energy, V is volume, S is entropy. The notation Œ: : :\tx;y means that the\nindicated partial derivatives should be taken with respect to constant values of the\nindicated variables.\nAn isothermal-isobaric system exchanges energy with the bath in such a way\nas to maintain the constant temperature; at the same time the volume ﬂuctuates to\ncontrol the pressure. The state of the system can be expressed in terms of particle\npositions and momenta as well as the volume V, i.e. we think of the probability\ndensity as a function of q, p and V.\nLet N, V, E be the number of atoms, volume and energy, respectively, of the\nsystem of interest, and N2, V2, E2 be the corresponding quantities describing the\nbath system; we have NCN2 D QN, VCV2 D QV, ECE2 D QE all constant. We view\nthe entropy as a function of the other variables and expand in a Taylor series in both\nvolume and energy:\nS.N2; V2; E2/ D S. QN \u0003 N; QV \u0003 V; QE \u0003 E/ \u0007 S.N2; QV; QE/ \u0003 @S\n@EE \u0003 @S\n@VV:\nBear in mind that here E and V are small relative perturbations of the total energy\nand volume. The quantity @S\n@E is the reciprocal temperature.\nTo calculate @S\n@V we may use Maxwell’s thermodynamic relation [372]:\n\u0002@S\n@E\n\u0003\nV;N\n\u0002 @E\n@V\n\u0003\nS;N\n\u0002@V\n@S\n\u0003\nE;N\nD \u00031:\nSince\n\n @S\n@E\n\u000b\nV;N is T\u00021 and\n\n @E\n@V\n\u000b\nS;N is \u0003P, we obtain\n\u0002 @S\n@V\n\u0003\nE;N\nD\n1\n\n @V\n@S\n\u000b\nE;N\nD P=T:\nThis results in the formula\nS.N2; V2; E2/ \u0007 constant \u0003 E C PV\nT\n;\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "E的熵、体积、粒子数参数固定顺序明示；Maxwell循环作为热力学可逆导数资格，并非从任意E无条件推出。"
  ],
  "issues": [],
  "statement_scope": "压力定义和给定非零温度/循环关系后的代数推论。",
  "lean_decl": "MD.Ch08.thermodynamicPressure",
  "lean_declarations": [
    "MD.Ch08.thermodynamicPressure",
    "MD.Ch08.maxwellCycle",
    "MD.Ch08.maxwellPressureRelation"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def thermodynamicPressure (E : ℝ → ℝ → ℝ → ℝ) (S V N : ℝ) : ℝ :=
  -deriv (fun v ↦ E S v N) V
def maxwellCycle (dSdE dEdV dVdS : ℝ) : Prop := dSdE*dEdV*dVdS = -1
theorem maxwellPressureRelation (T P dVdS : ℝ) (hT : T ≠ 0)
    (hcycle : maxwellCycle (1/T) (-P) dVdS) : dVdS⁻¹=P/T := by
  have hprod : P*dVdS=T := by
    dsimp [maxwellCycle] at hcycle
    field_simp [hT] at hcycle
    linarith
  have hz : dVdS ≠ 0 := by
    intro hz; rw [hz,mul_zero] at hprod; exact hT hprod.symm
  apply (eq_div_iff hT).2
  rw [← hprod]
  field_simp [hz]
```

## MD-8.8-NPTBathTaylor
```json
{
  "source_id": "MD-8.8-NPTBathTaylor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8",
  "printed_page": "378",
  "pdf_page": "399",
  "statement_latex": "S(N₂,V₂,E₂)=S(Ñ−N,Ṽ−V,Ẽ−E)≈S(N₂,Ṽ,Ẽ)−(E+PV)/T.",
  "statement_verbatim": "378\n8\nExtended Variable Methods\n8.8\nConstant Temperature and Pressure Molecular\nDynamics\nThe isobaric, isothermal or NPT ensemble models a system in contact with a heat\nbath (temperature T) and a “pressure reservoir” maintained at pressure P. The\npressure is deﬁned by the formula\nP D \u0003\n\u0002 @E\n@V\n\u0003\nS;N\nwhere E is the energy, V is volume, S is entropy. The notation Œ: : :\tx;y means that the\nindicated partial derivatives should be taken with respect to constant values of the\nindicated variables.\nAn isothermal-isobaric system exchanges energy with the bath in such a way\nas to maintain the constant temperature; at the same time the volume ﬂuctuates to\ncontrol the pressure. The state of the system can be expressed in terms of particle\npositions and momenta as well as the volume V, i.e. we think of the probability\ndensity as a function of q, p and V.\nLet N, V, E be the number of atoms, volume and energy, respectively, of the\nsystem of interest, and N2, V2, E2 be the corresponding quantities describing the\nbath system; we have NCN2 D QN, VCV2 D QV, ECE2 D QE all constant. We view\nthe entropy as a function of the other variables and expand in a Taylor series in both\nvolume and energy:\nS.N2; V2; E2/ D S. QN \u0003 N; QV \u0003 V; QE \u0003 E/ \u0007 S.N2; QV; QE/ \u0003 @S\n@EE \u0003 @S\n@VV:\nBear in mind that here E and V are small relative perturbations of the total energy\nand volume. The quantity @S\n@E is the reciprocal temperature.\nTo calculate @S\n@V we may use Maxwell’s thermodynamic relation [372]:\n\u0002@S\n@E\n\u0003\nV;N\n\u0002 @E\n@V\n\u0003\nS;N\n\u0002@V\n@S\n\u0003\nE;N\nD \u00031:\nSince\n\n @S\n@E\n\u000b\nV;N is T\u00021 and\n\n @E\n@V\n\u000b\nS;N is \u0003P, we obtain\n\u0002 @S\n@V\n\u0003\nE;N\nD\n1\n\n @V\n@S\n\u000b\nE;N\nD P=T:\nThis results in the formula\nS.N2; V2; E2/ \u0007 constant \u0003 E C PV\nT\n;\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 399,
      "printed_page": 378,
      "text": "378\n8\nExtended Variable Methods\n8.8\nConstant Temperature and Pressure Molecular\nDynamics\nThe isobaric, isothermal or NPT ensemble models a system in contact with a heat\nbath (temperature T) and a “pressure reservoir” maintained at pressure P. The\npressure is deﬁned by the formula\nP D \u0003\n\u0002 @E\n@V\n\u0003\nS;N\nwhere E is the energy, V is volume, S is entropy. The notation Œ: : :\tx;y means that the\nindicated partial derivatives should be taken with respect to constant values of the\nindicated variables.\nAn isothermal-isobaric system exchanges energy with the bath in such a way\nas to maintain the constant temperature; at the same time the volume ﬂuctuates to\ncontrol the pressure. The state of the system can be expressed in terms of particle\npositions and momenta as well as the volume V, i.e. we think of the probability\ndensity as a function of q, p and V.\nLet N, V, E be the number of atoms, volume and energy, respectively, of the\nsystem of interest, and N2, V2, E2 be the corresponding quantities describing the\nbath system; we have NCN2 D QN, VCV2 D QV, ECE2 D QE all constant. We view\nthe entropy as a function of the other variables and expand in a Taylor series in both\nvolume and energy:\nS.N2; V2; E2/ D S. QN \u0003 N; QV \u0003 V; QE \u0003 E/ \u0007 S.N2; QV; QE/ \u0003 @S\n@EE \u0003 @S\n@VV:\nBear in mind that here E and V are small relative perturbations of the total energy\nand volume. The quantity @S\n@E is the reciprocal temperature.\nTo calculate @S\n@V we may use Maxwell’s thermodynamic relation [372]:\n\u0002@S\n@E\n\u0003\nV;N\n\u0002 @E\n@V\n\u0003\nS;N\n\u0002@V\n@S\n\u0003\nE;N\nD \u00031:\nSince\n\n @S\n@E\n\u000b\nV;N is T\u00021 and\n\n @E\n@V\n\u000b\nS;N is \u0003P, we obtain\n\u0002 @S\n@V\n\u0003\nE;N\nD\n1\n\n @V\n@S\n\u000b\nE;N\nD P=T:\nThis results in the formula\nS.N2; V2; E2/ \u0007 constant \u0003 E C PV\nT\n;\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "固定粒子数参数，只对E,V的小扰动；显式Fréchet可微及热力学导数识别，不把原文≈当作精确等式。"
  ],
  "issues": [],
  "statement_scope": "线性熵近似与明确的一阶小o余项目标。",
  "lean_decl": "MD.Ch08.nptBathLinear",
  "lean_declarations": [
    "MD.Ch08.nptBathLinear",
    "MD.Ch08.nptEntropy_firstOrder"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nptBathLinear (S0 T P E V : ℝ) : ℝ := S0-(E+P*V)/T
theorem nptEntropy_firstOrder (S : ℝ × ℝ → ℝ) (E0 V0 T P : ℝ) (hT : 0 < T)
    (hS : DifferentiableAt ℝ S (E0,V0))
    (hderiv : ∀ v : ℝ × ℝ, fderiv ℝ S (E0,V0) v=v.1/T+(P/T)*v.2) :
    Asymptotics.IsLittleO (𝓝 (0 : ℝ × ℝ))
      (fun z ↦ S (E0-z.1,V0-z.2)-nptBathLinear (S (E0,V0)) T P z.1 z.2)
      (fun z : ℝ × ℝ ↦ ‖z‖) := by
  sorry
```
