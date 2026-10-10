# BATCH08 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.3.2-VerletMaps
```json
{
  "source_id": "MD-3.3.2-VerletMaps",
  "kind": "definition",
  "label": "(3.3)",
  "section": "3.3.2",
  "printed_page": "107",
  "pdf_page": "129",
  "statement_latex": "Recall the position and velocity Verlet methods:\n\\[\\begin{array}{ll}\\text{Position Verlet:}&\\text{Velocity Verlet:}\\\\\n\\widehat Q:=q+(h/2)M^{-1}p,&\\widehat P:=p-(h/2)\\nabla U(q),\\\\\nP:=p-h\\nabla U(\\widehat Q),&Q:=q+hM^{-1}\\widehat P,\\\\\nQ:=\\widehat Q+(h/2)M^{-1}P.&P:=\\widehat P-(h/2)\\nabla U(Q).\\end{array}\\tag{3.3}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "第一分量为position/drift-kick-drift；第二分量velocity/kick-drift-kick。真实F=−grad U。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.verletMaps",
  "reusable_proofs": [],
  "extra_assumptions": [
    "固定对角质量M，保持第1章对象；无非对角质量一般化。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def verletMaps {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    (SymplecticCoordinates n → SymplecticCoordinates n) ×
      (SymplecticCoordinates n → SymplecticCoordinates n) :=
  (positionVerlet m (textbookPotentialForce U) h,
    coordinateVerlet m (textbookPotentialForce U) h)
```

### MD-3.3.2-VerletHamiltonianParts
```json
{
  "source_id": "MD-3.3.2-VerletHamiltonianParts",
  "kind": "definition",
  "label": null,
  "section": "3.3.2",
  "printed_page": "107",
  "pdf_page": "129",
  "statement_latex": "We can think of the velocity Verlet method as being defined by a splitting into three parts:\n\\[H(q,p)=H_1+H_2+H_3,\\qquad H_1=\\frac12U(q),\\qquad H_2=\\frac12p^TM^{-1}p,\\qquad H_3=\\frac12U(q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "T=½pᵀM⁻¹p；三部分按U/2,T,U/2顺序，不交换。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.verletHamiltonianParts",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def verletHamiltonianParts {n : ℕ} (T U : SymplecticCoordinates n → ℝ) : Fin 3 → SymplecticCoordinates n → ℝ :=
  ![(fun z => U z/2), T, (fun z => U z/2)]
```

### MD-3.3.2-VerletStructure
```json
{
  "source_id": "MD-3.3.2-VerletStructure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.2",
  "printed_page": "107",
  "pdf_page": "129",
  "statement_latex": "This is a sequence of two types of operations: it consists of a “kick” exhibited by a jump in the momentum, linear “drift” with the resulting momentum, followed by a final kick. The symmetry of the method is one of its important features. Switching the order of the operations, i.e. drift-kick-drift, gives the position Verlet method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文对称关系结合第2章辛kick/drift性质；位置及速度Verlet实际映射见同页(3.3)。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.verletStructure",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.verletVariants_proved"
  ],
  "extra_assumptions": [
    "U全域C²以保障真实梯度kick为辛映射；原文光滑Hamiltonian假设显式化。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem verletStructure :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), ContDiff ℝ 2 U →
    (∀ h, IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) ∧
      IsTextbookSymplecticMap (positionVerlet m (textbookPotentialForce U) h)) ∧
    (∀ h z, coordinateVerlet m (textbookPotentialForce U) (-h)
      (coordinateVerlet m (textbookPotentialForce U) h z)=z) ∧
    (∀ h z, positionVerlet m (textbookPotentialForce U) (-h)
      (positionVerlet m (textbookPotentialForce U) h z)=z)
```

### MD-3.3.2-VerletModifiedHamiltonian
```json
{
  "source_id": "MD-3.3.2-VerletModifiedHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "3.3.2",
  "printed_page": "107",
  "pdf_page": "129",
  "statement_latex": "In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH Lemma gives\n\\[\\begin{aligned}\\widetilde H_h={}&T+U+\\frac{h^2}{12}\\left(\\{T,\\{T,U\\}\\}-\\frac12\\{U,\\{U,T\\}\\}\\right)\\\\\n&+\\frac{h^4}{120}\\left(-\\frac16\\{T,\\{T,\\{T,\\{T,U\\}\\}\\}\\}+\\frac13\\{U,\\{T,\\{T,\\{T,U\\}\\}\\}\\}-\\frac14\\{U,\\{U,\\{T,\\{T,U\\}\\}\\}\\}+\\{T,\\{T,\\{U,\\{U,T\\}\\}\\}\\}\\right)+O(h^6).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "只定义到h⁴的印刷有限函数；h²/h⁴系数实际匹配另条；一般T,U暂未假定机械T。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.verletModifiedH",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def verletModifiedH {n : ℕ} (T U : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  T z+U z+h^2/12*(textbookPoissonBracket T (textbookPoissonBracket T U) z-
    textbookPoissonBracket U (textbookPoissonBracket U T) z/2)+h^4/120*(
      -textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/6+
      textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/3-
      textbookPoissonBracket U (textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T U))) z/4+
      textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket U (textbookPoissonBracket U T))) z)
```

### MD-3.3.2-VerletModifiedMatching
```json
{
  "source_id": "MD-3.3.2-VerletModifiedMatching",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.2",
  "printed_page": "107",
  "pdf_page": "129",
  "statement_latex": "In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH Lemma gives",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整印刷h²,h⁴展开见同页VerletModifiedHamiltonian；本条不静默换成另一种Verlet或改h²系数。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "与速度/位置Verlet的组合次序共同核对h²,h⁴系数；原文Hamiltonian O(h⁶)与实际匹配阶也需裁定。"
    }
  ],
  "lean_decl": "MD.Ch03.verletModifiedMatching",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正对角质量、U全域C∞、紧初值B；完整印刷h⁴截断实际O(h⁶)端点匹配为额外严格化。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem verletModifiedMatching :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ⊤ U → IsCompact B →
    matchesHamiltonian (verletModifiedH (fun z => quadraticKinetic m (unpack z).2) (fun z => U (unpack z).1))
      (coordinateVerlet m (textbookPotentialForce U)) B 5
```

### MD-3.3.2-ModifiedEven
```json
{
  "source_id": "MD-3.3.2-ModifiedEven",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.2",
  "printed_page": "107–108",
  "pdf_page": "129–130",
  "statement_latex": "The extra power of $h$ in the leading perturbation reflects the fact that this method is 2nd order accurate, rather than first order, as Symplectic Euler. Note that only even order terms $(h^2,h^4,\\ldots)$ appear in the perturbative expansion; this is a consequence of the symmetry of the method.\nSetting $s=-t$, the left hand side of (3.4) collapses to the identity. Hence the surviving even-powered terms in the expansion on the right hand side of (3.5) must be zero. If the even order terms vanish, then the effect of composing linear operators symmetrically is to keep only odd order terms in the exponent, giving the symmetric BCH formula\n\\[\\exp(\\tfrac t2X)\\exp(tY)\\exp(\\tfrac t2X)=\\exp(t(X+Y)+t^3\\widehat Z_{[3]}+\\cdots).\\tag{3.6}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "formalLog奇次⇔除以形式变量h后的modifiedHamiltonian为偶次；原文证明中使用不同步长log交换的额外断言另列ERRATUM，结论不靠该假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.modifiedEven",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem modifiedEven :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), ∀ j : ℕ,
    PowerSeries.coeff (2*j) (formalLog (formalStrang A B))=0
```

### MD-3.3.2-Strang
```json
{
  "source_id": "MD-3.3.2-Strang",
  "kind": "definition",
  "label": null,
  "section": "3.3.2",
  "printed_page": "108",
  "pdf_page": "130",
  "statement_latex": "For Hamiltonians $X$ and $Y$, consider symmetrizing a composition of exponentials (a Strang splitting), such that\n\\[\\exp(\\tfrac t2X)\\exp(tY)\\exp(\\tfrac t2X)=\\exp(tZ_t)=\\exp(t(\\widehat Z_{[1]}+t^2\\widehat Z_{[2]}+t^3\\widehat Z_{[3]}+t^4\\widehat Z_{[4]}+\\cdots)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本定义为左端真实形式乘积；右端展开的索引可能有排印疑误（t²Z₂应结合后面t³Z₃及log定义审校），不假设log系数交换。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p.108/PDF130第一展开把Z_[2]配t²、Z_[3]配t³，而下一展开(3.5)按总指数幂2、3排列；保留原页不静默纠正索引。"
    }
  ],
  "lean_decl": "MD.Ch03.formalStrang",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def formalStrang {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1/2 : ℝ) • A) * textbookFormalOperatorExponential B *
    textbookFormalOperatorExponential ((1/2 : ℝ) • A)
```

### MD-3.3.2-DifferentLogsCommute
```json
{
  "source_id": "MD-3.3.2-DifferentLogsCommute",
  "kind": "unnumbered_claim",
  "label": "(3.4)–(3.5)",
  "section": "3.3.2",
  "printed_page": "108",
  "pdf_page": "130",
  "statement_latex": "Multiplying by the same expansion using a different time step $s$, we have\n\\[\\exp(\\tfrac s2X)\\exp(sY)\\exp(\\tfrac s2X)\\exp(\\tfrac t2X)\\exp(tY)\\exp(\\tfrac t2X)=\\exp(sZ_s)\\exp(tZ_t).\\tag{3.4}\\]\nBut we know that $Z_s$ commutes with $Z_t$, giving\n\\[\\begin{aligned}\\exp(sZ_s)\\exp(tZ_t)&=\\exp(sZ_s+tZ_t)\\\\\n&=\\exp((s+t)\\widehat Z_{[1]}+(s^2+t^2)\\widehat Z_{[2]}+(s^3+t^3)\\widehat Z_{[3]}+(s^4+t^4)\\widehat Z_{[4]}+\\cdots).\\end{aligned}\\tag{3.5}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "formalLog(Strang(sA,sB))=sZ_s；对非零s,t其交换等价；零步长形式log为0。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p.108/PDF130 “Z_s commutes with Z_t” 对一般非交换X,Y可疑；应由反步关系单独推导奇性。"
    }
  ],
  "lean_decl": "MD.Ch03.differentLogsCommute",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem differentLogsCommute :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R) (s t : ℝ),
    commutator (formalLog (formalStrang (s • A) (s • B))) (formalLog (formalStrang (t • A) (t • B)))=0
```

