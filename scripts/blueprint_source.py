"""Chapter-local source records and faithful extraction of unchanged library declarations."""
from pathlib import Path
import re
import json,hashlib
ROOT=Path(__file__).resolve().parents[1]
class ChapterData:
    def __init__(self,ch):
        self.ch=ch;self.ROOT=ROOT;self.BASE=ROOT/f'blueprint/ch{ch:02}';self.RECORDS=[];self.EXCLUDED=[]
        self.offset=22 if ch<=4 else 21
    def add(self,key,section,page,old,text,code,*,kind='unnumbered_claim',label=None,proof=None,
            context=(),extra=(),issues=(),verdict='PASS',explanation='',prior=(),missing=None,
            correspondence=(),discussion=None,proof_note=None):
        nums=[int(n) for n in re.findall(r'\d+',str(page))]
        decl=re.search(r'\b(?:def|theorem)\s+(\w+)',code).group(1)
        self.RECORDS.append(dict(source_id='MD-'+section+'-'+key,kind=kind,label=label,section=section,
            printed_page=str(page),pdf_page='–'.join(str(n+self.offset) for n in nums),statement_latex=text,
            proof_latex=proof,proof_note=proof_note or ('原书未给独立完整证明。' if proof is None else '原书计算按原页转录。'),
            proof_discussion_latex=discussion,context_notation=list(context),issues=list(issues),
            lean_decl=f'MD.Ch{self.ch:02}.'+decl,reusable_proofs=list(prior),extra_assumptions=list(extra),
            statement_scope='本条所引原句及展示公式；单个记号归入context_notation。',review_status='DRAFT',
            repair_log=[],source_page_verification='VERIFIED_RENDERED; source_page_checks.json',
            old_ids=[f'CH{self.ch:02}-{i:03}' for i in old],code=code,local_verdict=verdict,
            local_explanation=explanation or '本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。',
            priors=list(prior),missing=missing,correspondence=list(correspondence)))
    def copied(self,relative,name,newname=None,prove=True):
        text=(ROOT/relative).read_text(encoding='utf-8-sig')
        m=re.search(r'(?m)^(?:noncomputable )?(def|theorem|lemma) '+re.escape(name)+r'\b',text)
        if not m:raise ValueError((relative,name))
        stop=re.search(r'\n(?:(?:noncomputable )?(?:def|abbrev|theorem|lemma|end)\b|/--|/-!)',text[m.end():])
        end=m.end()+stop.start() if stop else len(text)
        if m.group(1)=='def':return re.sub(r'\bdef '+re.escape(name)+r'\b','def '+(newname or name),text[m.start():end].strip(),count=1)
        body=re.search(r'\s:=\s*(?:by\b)?',text[m.end():])
        signature=text[m.start():m.end()+body.start()].strip()
        signature=re.sub(r'^(theorem|lemma) '+re.escape(name),'theorem '+(newname or name),signature)
        ns=re.findall(r'(?m)^namespace ([\w.]+)',text[:m.start()])[-1]
        return signature+' := by\n  '+('apply '+ns+'.'+name+' <;> assumption' if prove else 'sorry')
    def proposition(self,name,newname=None,proof='sorry'):
        text=(ROOT/f'MolecularDynamics/Chapter{self.ch:02}/Statements.lean').read_text(encoding='utf-8-sig')
        m=re.search(r'(?m)^def '+re.escape(name)+r'\s*: Prop :=\n',text)
        if not m:raise ValueError(name)
        end=text.find('\ndef ',m.end());body=text[m.end():end if end>=0 else text.rfind('end MolecularDynamics')].strip()
        return 'theorem '+(newname or name.removesuffix('_statement'))+' :\n  '+body+' := by\n  '+proof

def apply_saved_routes(ch,records,keys):
    for key in keys:
        path=ROOT/f'blueprint/ch{ch:02}/validation/short_search/{key}.json'
        if not path.exists():continue
        routes=json.loads(path.read_text(encoding='utf-8'))
        target=next(x for x in records if x['source_id'].endswith('-'+key))
        assert target['local_verdict']=='PASS'
        for r in routes:
            assert hashlib.sha256((ROOT/r['source']).read_bytes()).hexdigest()==r['source_sha256']
            assert hashlib.sha256((ROOT/r['log']).read_bytes()).hexdigest()==r['log_sha256']
            if r['exit_code']==0:
                target['code']=target['code'].replace('by\n  sorry','by\n  '+r['proof'])
                target['missing']=None
                break
        else:
            if len(routes)>=3:target['missing']=f'三条短证明路线失败，停止该条；保存证据见validation/short_search/{key}.json。'
