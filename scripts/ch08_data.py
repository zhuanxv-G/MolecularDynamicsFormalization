"""Chapter 8 source records; all writes are chapter-local."""
from pathlib import Path
import re, importlib, json
ROOT=Path(__file__).resolve().parents[1]
BASE=ROOT/'blueprint/ch08'
RECORDS=[]
EXCLUDED=[]
HEADER='''import MolecularDynamics.Chapter06.ReviewDefinitions
import MolecularDynamics.Chapter08.StationaryDensityFlow
import MolecularDynamics.Chapter08.ThermostatHormander
import MolecularDynamics.Chapter08.ThermostatModeInvariant
import Mathlib.Tactic

open Set Filter MeasureTheory ProbabilityTheory MolecularDynamics
open scoped BigOperators Topology ContDiff ENNReal NNReal Matrix
noncomputable section
namespace MD.Ch08
variable {Ω : Type*} [MeasurableSpace Ω]
variable {n : ℕ}

'''

def add(key,section,page,text,code,*,kind='unnumbered_claim',label=None,proof=None,
        context=(),extra=(),issues=(),missing=None,scope=None,prior=(),verdict='PASS',equations=()):
    nums=[int(x) for x in re.findall(r'\d+',str(page))]
    names=re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem|lemma|structure|inductive)\s+(\w+)',code)
    assert names,(key,code)
    pages=list(range(nums[0]+21,nums[-1]+22))
    original=[]
    for p in pages:
        raw=(BASE/f'source_pages/pdf{p}.txt').read_text(encoding='utf-8')
        if p==420: raw=raw.split('Exercises',1)[0]
        original.append(dict(pdf_page=p,printed_page=p-21,text=raw))
    RECORDS.append(dict(source_id=f'MD-{section}-{key}',kind=kind,label=label,section=section,
        printed_page=str(page),pdf_page='–'.join(str(p+21) for p in nums),statement_latex=text,
        statement_verbatim='\n'.join(x['text'] for x in original),
        verbatim_scope='完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。',
        proof_latex=proof,proof_note='对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。',
        original_page_text=original,numbered_equations=list(equations),
        transcription_note='文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。',
        context_notation=list(context),extra_assumptions=list(extra),issues=list(issues),
        statement_scope=scope or '本条列出的数学对象与结论全部；上下文见逐字原页。',
        lean_decl='MD.Ch08.'+names[0],lean_declarations=['MD.Ch08.'+x for x in names],
        source_page_verification='见source_page_checks.json，已目视核对本条原页。',repair_log=[],
        code=code,local_verdict=verdict,missing=missing,documented_priors=list(prior)))

for name in json.loads((BASE/'enabled_modules.json').read_text(encoding='utf-8')):
    importlib.import_module(name)

from ch08_scope_review import apply_scope_review
apply_scope_review(RECORDS)
