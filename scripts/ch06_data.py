"""Chapter 6 local obligations; never import or restore parked proof checkpoints."""
import csv,re
from blueprint_source import ChapterData
_c=ChapterData(6)
ROOT,BASE,RECORDS,EXCLUDED=_c.ROOT,_c.BASE,_c.RECORDS,_c.EXCLUDED
OLD_ROWS=list(csv.DictReader((ROOT/'docs/review/CH06_CLAIMS.csv').open(encoding='utf-8-sig')))
D='MolecularDynamics/Chapter06/ReviewDefinitions.lean'
NS='MolecularDynamics.Chapter06Review.'
names=set(re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev) (\w+)',(ROOT/D).read_text(encoding='utf-8')))
names.add('kernelGenerator')
def qualify(code):
    decl=re.search(r'\b(?:def|theorem)\s+(\w+)',code);start=decl.end()
    bound=set(re.findall(r'(?:[([{]|∃|∀)\s*(\w+)\s*:',code[start:]))
    globals_=names-bound
    return code[:start]+re.sub(r'(?<![\w.])(?:'+'|'.join(sorted(globals_,key=len,reverse=True))+r')\b',lambda m:NS+m.group(),code[start:])
def copied(relative,name,newname=None,prove=True):return qualify(_c.copied(relative,name,newname,prove))
def proposition(name,newname=None,proof='sorry'):return qualify(_c.proposition(name,newname,proof))
def probability_copy(relative,name,newname=None,prove=True):
    code=re.sub(r'\bω\b','sample',copied(relative,name,newname,prove))
    return re.sub(r'\b(def|theorem) (\w+)',r'\1 \2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}',code,count=1)
def add(*args,**kwargs):
    kwargs['issues']=[x if isinstance(x,dict) else dict(code='ERRATUM?',detail=x) for x in kwargs.get('issues',())]
    return _c.add(*args,**kwargs)
import ch06_section611
import ch06_section612b
import ch06_section613
import ch06_section614
import ch06_section615
import ch06_section615b
import ch06_section621
import ch06_section621b
import ch06_section621c
import ch06_section622
import ch06_section622b
import ch06_section622c
import ch06_section63
import ch06_section632
import ch06_section633
import ch06_section633b
import ch06_section633c
from blueprint_source import apply_saved_routes
from ch06_short_candidates import proofs as short_candidates
apply_saved_routes(6,RECORDS,[key for key in short_candidates if any(r['source_id'].endswith('-'+key) for r in RECORDS)])

