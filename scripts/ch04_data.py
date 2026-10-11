"""Chapter 4 records; append one visually verified batch at a time."""
import csv,re
from blueprint_source import ChapterData
_c=ChapterData(4)
ROOT,BASE,RECORDS,EXCLUDED=_c.ROOT,_c.BASE,_c.RECORDS,_c.EXCLUDED
OLD_ROWS=list(csv.DictReader((ROOT/'docs/review/CH04_CLAIMS.csv').open(encoding='utf-8-sig')))
D='MolecularDynamics/Chapter04/ReviewDefinitions.lean'
NS='MolecularDynamics.Chapter04Review.'
names=set(re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev) (\w+)',(ROOT/D).read_text(encoding='utf-8')))
def qualify(code):
    split=re.search(r'\b(?:def|theorem)\s+(\w+)',code)
    start=split.end()
    return code[:start]+re.sub(r'(?<![\w.])(?:'+ '|'.join(sorted(names,key=len,reverse=True))+r')\b',lambda m:NS+m.group(),code[start:])
def copied(relative,name,newname=None,prove=True):return qualify(_c.copied(relative,name,newname,prove))
def proposition(name,newname=None,proof='sorry'):return qualify(_c.proposition(name,newname,proof))
add=_c.add
import ch04_section4
import ch04_section4b
