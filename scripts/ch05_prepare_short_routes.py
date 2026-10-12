"""Move unverified elementary drafts into bounded compiler routes, once."""
import ast,importlib,json
from ch05_data import ROOT,RECORDS
mods=['51b','521','521b','521extra']
path=ROOT/'scripts/ch05_elementary_candidates.json'
if path.exists():
    print('Elementary draft routes already separated.');raise SystemExit()
for mod in mods:importlib.import_module('ch05_section'+mod)
proofs={r['source_id'].split('-')[-1]:r['code'].split(':= by\n  ',1)[1]
    for r in RECORDS if r['code'].startswith('theorem ') and ':= by\n  ' in r['code'] and
    'sorry' not in r['code'] and not r['priors']}
path.write_text(json.dumps(proofs,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
for mod in mods:
    file=ROOT/f'scripts/ch05_section{mod}.py';text=file.read_text(encoding='utf-8');tree=ast.parse(text)
    edits=[]
    for node in ast.walk(tree):
        if isinstance(node,ast.Call) and isinstance(node.func,ast.Name) and node.func.id=='add' and len(node.args)>=6:
            key=ast.literal_eval(node.args[0])
            if key not in proofs:continue
            old=ast.get_source_segment(text,node.args[5])
            assert ':= by\n  ' in old and old.endswith("'''")
            new=old.split(':= by\n  ',1)[0]+":= by\n  sorry'''"
            edits.append((old,new))
    for old,new in edits:
        assert text.count(old)==1;text=text.replace(old,new)
    file.write_text(text,encoding='utf-8')
print('Separated elementary route drafts:',list(proofs))
