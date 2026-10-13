"""Chapter 5 records. Draft scripts are activated only on its chapter branch."""
import csv,re
from blueprint_source import ChapterData
_c=ChapterData(5)
ROOT,BASE,RECORDS,EXCLUDED=_c.ROOT,_c.BASE,_c.RECORDS,_c.EXCLUDED
OLD_ROWS=list(csv.DictReader((ROOT/'docs/review/CH05_CLAIMS.csv').open(encoding='utf-8-sig')))
D='MolecularDynamics/Chapter05/ReviewDefinitions.lean'
NS='MolecularDynamics.Chapter05Review.'
names=set(re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev) (\w+)',(ROOT/D).read_text(encoding='utf-8')))
def qualify(code,generic=False):
    decl=re.search(r'\b(?:def|theorem)\s+(\w+)',code);start=decl.end()
    chosen=names-{'E'} if generic else names
    return code[:start]+re.sub(r'(?<![\w.])(?:'+'|'.join(sorted(chosen,key=len,reverse=True))+r')\b',lambda m:NS+m.group(),code[start:])
def copied(relative,name,newname=None,prove=True):
    return qualify(_c.copied(relative,name,newname,prove),generic='/Chapter03/' in relative)
def proposition(name,newname=None,proof='sorry'):return qualify(_c.proposition(name,newname,proof))
def add(*args,**kwargs):
    args=list(args);args[5]=re.sub(r'(?<![«\w])ω(?![»\w])','«ω»',args[5])
    return _c.add(*args,**kwargs)
import ch05_section51
import ch05_section51b
import ch05_section521
import ch05_section521b
import ch05_section521extra
import ch05_section522
import ch05_section522coords
import ch05_section522b
import ch05_section523
import ch05_section531
import ch05_section531b
import ch05_section532
import ch05_section532b
import ch05_section532c
import ch05_section532d
import ch05_section533
import ch05_section533b
import ch05_section54
import ch05_section541
import ch05_section541b
import ch05_section541c
import ch05_section541d
import ch05_section55
import ch05_section55b
import ch05_section56
import ch05_section56b
import ch05_section56c
import ch05_section56d
import ch05_section56e
from blueprint_source import apply_saved_routes
from ch05_short_candidates import proofs as short_candidates
apply_saved_routes(5,RECORDS,[key for key in short_candidates if any(r['source_id'].endswith('-'+key) for r in RECORDS)])
