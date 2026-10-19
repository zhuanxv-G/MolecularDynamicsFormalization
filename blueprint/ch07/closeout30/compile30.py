from register30 import *
import re, time

def main():
    text=(ROOT/'Blueprint/Ch07.lean').read_text(encoding='utf-8')
    names=re.findall(r'(?m)^(?:def|abbrev|theorem|lemma|structure)\s+(\w+)',text)
    assert len(names)==len(set(names))
    content=text+'\n'+'\n'.join('#print axioms MD.Ch07.'+n for n in names)+'\n'
    attempt=len(list((OUT/'compiled').glob('FINAL_COMPILE*.json')))+1
    label='FINAL_COMPILE-r'+str(attempt)
    probe=OUT/(label+'.lean');probe.write_text(content,encoding='utf-8')
    # The official compiler's LSP frontend elaborates the complete saved file
    # and supplies diagnostics for every #print axioms command.
    import lsp29
    lsp29.OUT=OUT
    (OUT/'compiled').mkdir(exist_ok=True)
    compiler=lsp29.LeanCompiler()
    try: receipt=compiler.check(content,label,probe)
    finally: compiler.close()
    receipt.update(declarations=names,probe=probe.relative_to(ROOT).as_posix())
    dump(OUT/(label+'.json'),receipt)
    assert receipt['exit_code']==0
    (OUT/'FINAL_COMPILE.log').write_bytes((OUT/'compiled'/(label+'.log')).read_bytes())
    receipt.update(log_sha256=sha(OUT/'FINAL_COMPILE.log'))
    dump(OUT/'FINAL_COMPILE.json',receipt)
    (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch07\n\n'+'\n'.join('#print axioms MD.Ch07.'+n for n in names)+'\n',encoding='utf-8')
    print('Single file and',len(names),'axiom outputs PASS',flush=True)

if __name__=='__main__':main()
