"""Partition prepared records by printed subsection, without rewriting quotations."""
import ast
from pathlib import Path
folder=Path(__file__).resolve().parent
header='from ch04_data import add,copied,proposition,D,NS\n'
def partition(name,target,section,keys=()):
    path=folder/f'ch04_section{name}.py';text=path.read_text(encoding='utf-8')
    assert not (folder/f'ch04_section{target}.py').exists()
    adds=[n for n in ast.parse(text).body if isinstance(n,ast.Expr) and isinstance(n.value,ast.Call)
          and isinstance(n.value.func,ast.Name) and n.value.func.id=='add']
    picked=[n for n in adds if ast.literal_eval(n.value.args[1])==section]
    remaining=[n for n in adds if n not in picked]
    assert picked and remaining
    extract=lambda ns:'\n'.join(ast.get_source_segment(text,n) for n in ns)+'\n'
    tail=''
    if keys: tail='from blueprint_source import apply_saved_routes\nfrom ch04_data import RECORDS\napply_saved_routes(4,RECORDS,'+repr(list(keys))+')\n'
    (folder/f'ch04_section{target}.py').write_text('"""Prepared extra claims for subsection '+section+'."""\n'+header+extract(picked)+tail,encoding='utf-8')
    path.write_text('"""Prepared claims for their exact printed subsection."""\n'+header+extract(remaining),encoding='utf-8')
partition('433','432extra','4.3.2')
partition('4351','435extra','4.3.5',('SHAKEElimination',))
