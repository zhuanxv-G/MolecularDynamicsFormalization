# EAUDIT04 第8章修改后陈述复审

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
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。",
  "context_notation": [],
  "extra_assumptions": [
    "只陈述实际通量散度为零；φ,ψ是权重而非自动概率密度，归一、可积和全局保测流不在本条。",
    "已目视核对原页PDF402：文字子场印为(p,−∇U,0,0,0)，一般质量应为(M⁻¹p,−∇U,0,0,0)或另限单位质量。旧pistonHamiltonianPart及其驻定目标属于合理修正，新增Printed与_corrected明确区分。"
  ],
  "issues": [
    "保留原页文字；在issues显式标[ERRATUM?]：原印p应为M⁻¹p（或注明单位质量约定）。给现有Hamiltonian子场标为合理修正，不将其与原印向量场混同。",
    "已目视核对原页PDF402：文字子场印为(p,−∇U,0,0,0)，一般质量应为(M⁻¹p,−∇U,0,0,0)或另限单位质量。旧pistonHamiltonianPart及其驻定目标属于合理修正，新增Printed与_corrected明确区分。"
  ],
  "statement_scope": "原印p子场、M⁻¹p修正子场及修正子场光滑复合权的局部驻定目标；不把修正场说成逐字原印场。",
  "lean_decl": "MD.Ch08.pistonHamiltonianPart",
  "lean_declarations": [
    "MD.Ch08.pistonHamiltonianPart",
    "MD.Ch08.pistonHamiltonianWeight_stationary",
    "MD.Ch08.pistonHamiltonianPartPrinted",
    "MD.Ch08.pistonHamiltonianPart_corrected"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 31,
      "stage": "json_review",
      "status": "NEEDS_HUMAN",
      "issue_codes": [
        "ERRATUM_REQUIRES_HUMAN",
        "STALE_TRANSCRIPTION_NOTE"
      ],
      "change": "合并经原页和现有签名核对的元数据更正；原页全文未改。"
    },
    {
      "instruction": 31,
      "stage": "human_triage",
      "change": "已目视核对原页PDF402：文字子场印为(p,−∇U,0,0,0)，一般质量应为(M⁻¹p,−∇U,0,0,0)或另限单位质量。旧pistonHamiltonianPart及其驻定目标属于合理修正，新增Printed与_corrected明确区分。",
      "suggested_fix": "保留原页文字；在issues显式标[ERRATUM?]：原印p应为M⁻¹p（或注明单位质量约定）。给现有Hamiltonian子场标为合理修正，不将其与原印向量场混同。"
    }
  ],
  "documented_priors": [],
  "coverage_gaps": []
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

/-- 原印Hamiltonian子场：第一分量为p，忠实保留其一般质量疑误。 -/
def pistonHamiltonianPartPrinted (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n :=
  ((z.1.2,-gradient (fun q ↦ U (q,z.2 0)) z.1.1),0)

/-- 修正版第一分量为M⁻¹p；现有驻定目标已采用此场。 -/
def pistonHamiltonianPart_corrected (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n := pistonHamiltonianPart invm U z
```
