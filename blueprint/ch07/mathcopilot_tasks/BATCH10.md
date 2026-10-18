# BATCH10 第7章原文与陈述审校

## MD-7.7.1-ExactABOPropagators
```json
{
  "source_id": "MD-7.7.1-ExactABOPropagators",
  "kind": "definition",
  "label": null,
  "section": "7.7.1",
  "printed_page": "285",
  "pdf_page": "306",
  "statement_latex": "\\[(e^{t\\mathcal L_A}\\phi)(q,p)=\\phi(q+tM^{-1}p,p),\\qquad\n(e^{t\\mathcal L_B}\\phi)(q,p)=\\phi(q,p-t\\nabla U(q)),\\]\n\\[(e^{t\\mathcal L_O}\\phi)(q,p)=\\int_{\\mathcal P}\\phi(q,e^{-\\gamma t}p+\\zeta M^{1/2}x)\\frac{e^{-|x|^2/2}}{(2\\pi)^{N_c/2}}dx,\\]\nwhere $\\zeta=[k_BT(1-e^{-2\\gamma t})]^{1/2}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "O用实际独立标准正态乘积测度；θ>0、γ≥0、t≥0、正质量时对应OU噪声。期望用于可积φ，未把不可积函数的默认积分当物理期望。",
    "半群律及实际SDE生成元识别需OU转移律与Markov理论，本条只定义固定时刻传播子。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.propagateA",
  "lean_declarations": [
    "MD.Ch07.propagateA",
    "MD.Ch07.propagateB",
    "MD.Ch07.propagateO"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def propagateA (m : V n) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ driftStep m t
def propagateB (U : V n → ℝ) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ kickStep U t
def propagateO (m : V n) (γ θ t : ℝ) (φ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∫ R, φ (ouStep m γ θ t R x) ∂Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)
```

## MD-7.7.1-OperatorOrderReversal
```json
{
  "source_id": "MD-7.7.1-OperatorOrderReversal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.1",
  "printed_page": "285",
  "pdf_page": "306",
  "statement_latex": "For example, for the method labelled by the string $[ABAO]$, we have\n\\[\\exp(h\\widehat{\\mathcal L}_{[ABAO]})=\\exp((h/2)\\mathcal L_A)\\exp(h\\mathcal L_B)\\exp((h/2)\\mathcal L_A)\\exp(h\\mathcal L_O),\\]\nwhere importantly note the apparent reversal of the sequence of products, known as the vertauschungssatz. We will find it more convenient to work with the adjoint of the perturbed generator, denoted $\\widehat{\\mathcal L}^\\dagger$, which we may compute as\n\\[\\exp(h\\widehat{\\mathcal L}_{[ABAO]}^\\dagger)=\\exp(h\\mathcal L_O^\\dagger)\\exp((h/2)\\mathcal L_A^\\dagger)\\exp(h\\mathcal L_B^\\dagger)\\exp((h/2)\\mathcal L_A^\\dagger).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "覆盖反向拉回组合恒等式和ABAO的全部四段期望传播式；其与前面随机abao映射期望相等仍需推前积分桥。",
    "伴随前向传播子的四段顺序记录在原文；独立定义实际密度伴随的函数空间和边界条件列为覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "确定性拉回顺序及ABAO后向传播定义；无界算符指数/伴随识别尚缺。",
  "lean_decl": "MD.Ch07.pullback_order",
  "lean_declarations": [
    "MD.Ch07.pullback_order",
    "MD.Ch07.abaoBackward"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem pullback_order {E F : Type*} (A B : E → E) (φ : E → F) :
    φ ∘ (B ∘ A) = (φ ∘ B) ∘ A := rfl
def abaoBackward (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (φ : Phase n → ℝ) :=
  propagateA m (h/2) (propagateB U h (propagateA m (h/2) (propagateO m γ θ h φ)))
```

## MD-7.7.1-StationaryModifiedPDE
```json
{
  "source_id": "MD-7.7.1-StationaryModifiedPDE",
  "kind": "definition",
  "label": null,
  "section": "7.7.1",
  "printed_page": "285–286",
  "pdf_page": "306–307",
  "statement_latex": "Under the propagation of the numerical scheme (or the discretized dynamics), the Fokker-Planck equation gives us that the evolution of a density of points $\\rho$ is given by\n\\[\\frac\\partial{\\partial t}\\rho(z,t)=\\widehat{\\mathcal L}^\\dagger\\rho,\\]\nwith the important case of its invariant distribution satisfying the partial differential equation\n\\[\\widehat{\\mathcal L}^\\dagger\\widehat\\rho=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "真实离散转移一般不嵌入连续Markov半群，修改方程仅为形式分析；不宣称任意离散SDE方法有上述真实Fokker–Planck演化。",
    "Markov半群资格、密度正性归一、无界生成元定义域及嵌入性尚缺；此处仅明确定义方程，不证明等价。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.formalDensityEvolution",
  "lean_declarations": [
    "MD.Ch07.formalDensityEvolution",
    "MD.Ch07.stationaryModifiedDensity"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def formalDensityEvolution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (L : E →L[ℝ] E) (ρ : ℝ → E) : Prop := ∀ t, HasDerivAt ρ (L (ρ t)) t
def stationaryModifiedDensity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ : E) : Prop := L ρ = 0
```

## MD-7.7.1-TwoOperatorBCH
```json
{
  "source_id": "MD-7.7.1-TwoOperatorBCH",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.1",
  "printed_page": "286",
  "pdf_page": "307",
  "statement_latex": "Recall that for linear operators $X$ and $Y$, we can write the composition of their exponentials as\n\\[\\exp(hX)\\exp(hY)=\\exp(hZ),\\]\nwhere we have the expansion\n\\[Z=X+Y+\\frac h2[X,Y]+\\frac{h^2}{12}([X,[X,Y]]+[Y,[Y,X]])+O(h^3).\\]\nThe notation $[X,Y]\\stackrel{\\rm def}=XY-YX$ represents the commutator of the operators $X$ and $Y$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "任意实代数中的非交换形式幂级数；不要求无界算符指数收敛。本条完整记录所印0–2阶。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.comm",
  "lean_declarations": [
    "MD.Ch07.comm",
    "MD.Ch07.twoStage",
    "MD.Ch07.twoOperatorBCH"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def comm {R : Type*} [Ring R] (X Y : R) : R := X*Y-Y*X
def twoStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential X * MolecularDynamics.textbookFormalOperatorExponential Y
theorem twoOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (twoStage X Y)) = X+Y ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (twoStage X Y)) = (1/2 : ℝ) • comm X Y ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (twoStage X Y)) =
      (1/12 : ℝ) • (comm X (comm X Y)+comm Y (comm Y X)) := by
  sorry
```

## MD-7.7.1-TaylorRemainder
```json
{
  "source_id": "MD-7.7.1-TaylorRemainder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.1",
  "printed_page": "286–287",
  "pdf_page": "307–308",
  "statement_latex": "We can make use of Taylor’s theorem to write the identity\n\\[P_h=P_0+h\\left.\\frac{dP_t}{dt}\\right|_{t=0}+\\cdots+\\frac{h^n}{n!}\\left.\\frac{d^nP_t}{dt^n}\\right|_{t=0}\n+\\frac{h^{n+1}}{n!}\\int_0^1(1-\\lambda)^n\\left.\\frac{d^{n+1}P_t}{dt^{n+1}}\\right|_{t=\\lambda h}d\\lambda,\\]\nfor some finite truncation index $n\\in\\{1,2,3,\\ldots\\}$. Hence for observables of sufficient smoothness with compact support, this remainder term will remain bounded (see [223]).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "只覆盖作用于单个可观测量和点后的标量C^(n+1) Taylor恒等式及局部余项界；把ABO无界算符组合在紧支撑光滑测试函数上归约到这些假设仍是覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.taylorRemainder",
  "lean_declarations": [
    "MD.Ch07.taylorRemainder",
    "MD.Ch07.taylorRemainder_bound"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem taylorRemainder (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) (h : ℝ) :
    F h = (∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0) +
      h^(k+1)/(Nat.factorial k : ℝ)*∫ t in (0 : ℝ)..1, (1-t)^k*iteratedDeriv (k+1) F (t*h) := by
  sorry
theorem taylorRemainder_bound (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ F h-∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0)
      (fun h ↦ h^(k+1)) := by
  sorry
```

## MD-7.7.2-ThreeOperatorBCH
```json
{
  "source_id": "MD-7.7.2-ThreeOperatorBCH",
  "kind": "unnumbered_claim",
  "label": "(7.18)",
  "section": "7.7.2",
  "printed_page": "287",
  "pdf_page": "308",
  "statement_latex": "\\[\\exp(hS)=\\exp(hZ)\\exp(hY)\\exp(hX).\\tag{7.18}\\]\n\\[S=X+Y+Z+\\frac h2([Z,Y]+[Z,X]+[Y,X])+\\frac{h^2}{4}[Z,Y,X]\n+\\frac{h^2}{12}([Y,Y,X]+[X,X,Y]+[Z,Z,Y]+[Z,Z,X]+[Y+X,Y+X,Z])+\\cdots\\]\nwhere the notation $[A,B,C]$ is notation for $[A,[B,C]]$.",
  "proof_latex": "Apply the two-operator BCH formula first to exp(hY)exp(hX), and then to exp(hZ)exp(h(Y+X+...)); combine equal powers of h.",
  "proof_note": "按所列原页转录原书证明。",
  "context_notation": [],
  "extra_assumptions": [
    "完整记录最终0–2阶系数；中间未合并式作为原文推导说明，不另假装是完整精确算符相等。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.threeStage",
  "lean_declarations": [
    "MD.Ch07.threeStage",
    "MD.Ch07.threeOperatorBCH"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def threeStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential Z *
    MolecularDynamics.textbookFormalOperatorExponential Y * MolecularDynamics.textbookFormalOperatorExponential X
theorem threeOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (threeStage X Y Z)) = X+Y+Z ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/2 : ℝ) • (comm Z Y+comm Z X+comm Y X) ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/4 : ℝ) • comm Z (comm Y X)+(1/12 : ℝ) •
        (comm Y (comm Y X)+comm X (comm X Y)+comm Z (comm Z Y)+
          comm Z (comm Z X)+comm (Y+X) (comm (Y+X) Z)) := by
  sorry
```
