"""Chapter 7 records; chapter-local writes only, no prior chapter generators."""
from pathlib import Path
import re
ROOT=Path(__file__).resolve().parents[1]
BASE=ROOT/'blueprint/ch07'
RECORDS=[]
EXCLUDED=[]
HEADER='''import MolecularDynamics.Chapter06.ReviewDefinitions
import MolecularDynamics.Chapter07.FormalOperatorFunctionalCalculus
import MolecularDynamics.Chapter07.InvariantDistributionSwap
import Mathlib.Tactic

open Set Filter MeasureTheory ProbabilityTheory MolecularDynamics
open scoped BigOperators Topology ContDiff ENNReal NNReal
noncomputable section
namespace MD.Ch07
variable {Ω : Type*} [MeasurableSpace Ω]
variable {n : ℕ}

'''

def add(key,section,page,text,code,*,kind='unnumbered_claim',label=None,proof=None,
        context=(),extra=(),issues=(),missing=None,scope=None,prior=(),verdict='PASS'):
    nums=[int(x) for x in re.findall(r'\d+',str(page))]
    names=re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem|lemma|structure)\s+(\w+)',code)
    assert names,(key,code)
    RECORDS.append(dict(source_id=f'MD-{section}-{key}',kind=kind,label=label,section=section,
        printed_page=str(page),pdf_page='–'.join(str(p+21) for p in nums),statement_latex=text,
        proof_latex=proof,proof_note='原书未给独立完整证明。' if proof is None else '按所列原页转录原书证明。',
        context_notation=list(context),extra_assumptions=list(extra),issues=list(issues),
        statement_scope=scope or '本条逐字引用的全部数学对象与公式；未纳入的上下文另列。',
        lean_decl='MD.Ch07.'+names[0],lean_declarations=['MD.Ch07.'+x for x in names],
        source_page_verification='见source_page_checks.json；必须已目视核对本条原页。',
        repair_log=[],code=code,local_verdict=verdict,missing=missing,documented_priors=list(prior)))

# Section modules append records in source order. No imported earlier-chapter generator.

import ch07_section71
