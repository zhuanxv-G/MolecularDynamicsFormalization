"""Complete attributed-declaration axioms and their definition excerpts."""
import re,subprocess
from datetime import datetime
from integrate_website_returns import ROOT,read,dump,sha
from eaudit_review_tasks import declarations,declaration_names,render_document
from build_mathcopilot_compact import definitions,referenced
from local_compile import compile_recorded
from website_repair_delivery import refresh
from local_stage import stage

def run():
    folder=ROOT/'docs/handoff/ANNOTATED_AXIOMS';folder.mkdir(exist_ok=True)
    missing={};hashes={}
    for ch in (2,3,4,5):
        text=(ROOT/f'Blueprint/Ch{ch:02}.lean').read_text(encoding='utf-8-sig')
        printed=set(re.findall(r'#print axioms MD\.Ch\d+\.(\w+)',text))
        missing[ch]=[n for n in declaration_names(text) if n not in printed]
        hashes[ch]=sha(ROOT/f'Blueprint/Ch{ch:02}.lean')
    assert missing=={2:['textbookWedgeOneForms_apply','momentumKickDerivative','momentumKick_hasFDerivAt'],3:[],4:['rigidSystemState'],5:['domainL2']},missing
    source=folder/'CheckAxioms.lean'
    source.write_text('import Blueprint.Ch02\nimport Blueprint.Ch04\nimport Blueprint.Ch05\nimport Lean\n'+
      ''.join(f'#print axioms MD.Ch{ch:02}.{n}\n' for ch,ns in missing.items() for n in ns if not n.startswith('momentumKick'))+'''
open Lean Elab Command in
run_cmd do
  let wanted : Array Name := #[`MD.Ch02.momentumKickDerivative, `MD.Ch02.momentumKick_hasFDerivAt]
  let mut found := 0
  for (n, _) in (← getEnv).constants.toList do
    let user := privateToUserName n
    if wanted.contains user then
      elabCommand (← `(command| #print axioms $(mkIdent n)))
      let axs ← collectAxioms n
      logInfo m!"PRIVATE_AX {user.toString}|{n.toString}|{String.intercalate "," (axs.toList.map Name.toString)}"
      found := found+1
  unless found == wanted.size do throwError "Missing private audit targets"
''',encoding='utf-8')
    receipt,output,_=compile_recorded(['lake','env','lean',source.relative_to(ROOT).as_posix()],ROOT,source,folder/'axioms.log',folder/'COMPILE.json')
    assert receipt['exit_code']==0,output.decode('utf-8',errors='replace')
    parsed={}
    for ch,ns in missing.items():
        for n in ns:
            name=f'MD.Ch{ch:02}.{n}'
            if n.startswith('momentumKick'):
                m=re.search(r'PRIVATE_AX '+re.escape(name)+r'\|([^|\n]+)\|([^\n]*)',output.decode('utf-8'));assert m,name
                parsed[name]=[x.strip() for x in m.group(2).split(',') if x.strip()];continue
            m=re.search("'"+re.escape(name)+r"' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",output.decode('utf-8'));assert m,name
            parsed[name]=[x.strip() for x in (m.group(1) or '').split(',') if x.strip()]
    dump(folder/'VERIFICATION.json',dict(time=datetime.now().isoformat(),unchanged_chapter_lean_sha256=hashes,
      axioms=parsed,compile_receipt_sha256=sha(folder/'COMPILE.json'),reason='Attributed declarations were compiled previously, but omitted from old regex-generated axiom/name inventories; no chapter Lean source or proof changed.'))
    owned=[folder.relative_to(ROOT).as_posix()];all_refreshed={}
    for ch in (2,4,5):
        base=ROOT/f'blueprint/ch{ch:02}';ds=declarations(ch);audit=read(base/'local_audit.json')
        for sid,d in ds.items():
            extras=[f'MD.Ch{ch:02}.{n}' for n in missing[ch] if n in declaration_names(d['block'])]
            if not extras:continue
            a=audit['items'][sid];a['axioms']=sorted(set(a['axioms'])|{x for n in extras for x in parsed[n]})
            a['axiom_supplement']=dict(log=(folder/'axioms.log').relative_to(ROOT).as_posix(),sha256=sha(folder/'axioms.log'),declarations=extras)
        dump(base/'local_audit.json',audit)
        acceptance=base/'validation/WEBSITE_REPAIR_CHAPTER_ACCEPTANCE.json';a=read(acceptance)
        a['axiom_decl_count']=sum(len(declaration_names(d['block'])) for d in ds.values())
        a['axiom_supplement']=(folder/'VERIFICATION.json').relative_to(ROOT).as_posix();dump(acceptance,a)
        # Find all transitive project-definition uses of the newly recognized
        # attributed type aliases. Existing unrelated packets remain immutable.
        paths={f'Blueprint/Ch{ch:02}.lean'};stack=list(paths)
        while stack:
            for imp in re.findall(r'(?m)^import ([\w.]+)',(ROOT/stack.pop()).read_text(encoding='utf-8-sig')):
                p=imp.replace('.','/')+'.lean'
                if p.startswith('MolecularDynamics/') and p not in paths:paths.add(p);stack.append(p)
        index=definitions(sorted(paths))
        for choices in list(index.values()):
            for d in choices:
                if d['namespace']:index.setdefault(d['namespace']+'.'+d['name'],[]).append(d)
        web=read(base/'website_audit.json');force=[]
        for w in web:
            if w.get('repair',{}).get('status')!='awaiting_reaudit':continue
            sid=w['source_id'];selected=set();pending=referenced(ds[sid]['block'],index)
            while pending:
                name=pending.pop()
                if name in selected:continue
                selected.add(name);choices=index[name]
                choices=[d for d in choices if d['path'].startswith('Blueprint/')] or choices
                for d in choices:pending.update(referenced(d['code'],index)-selected)
            aliases=[n for n in missing[ch] if n in declaration_names(ds[sid]['block']) or n in selected or f'MD.Ch{ch:02}.{n}' in selected]
            if aliases:force.append(sid)
        batches=refresh(ch,force_ids=force);all_refreshed[ch]=dict(source_ids=force,batches=batches)
        registry=read(base/'EAUDIT_REGISTRY.json')
        for e in batches:
            p=base/'validation'/e/'ACCEPTANCE.json';record=read(p);record['axiom_supplement']=(folder/'VERIFICATION.json').relative_to(ROOT).as_posix();dump(p,record)
            for i,item in enumerate(registry):
                if item['eaudit']==e:registry[i]=record
            owned.extend([f'blueprint/ch{ch:02}/validation/{e}',f'blueprint/ch{ch:02}/mathcopilot_tasks/{e}'])
        dump(base/'EAUDIT_REGISTRY.json',registry)
        (ROOT/f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md').write_text(render_document(ch),encoding='utf-8')
        owned.extend([f'blueprint/ch{ch:02}/{p}' for p in ['local_audit.json','EAUDIT_REGISTRY.json','website_audit.json','mathcopilot_tasks/EAUDIT_INDEX.md','validation/WEBSITE_REPAIR_CHAPTER_ACCEPTANCE.json']])
        owned.append(f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md')
    assert all(sha(ROOT/f'Blueprint/Ch{ch:02}.lean')==h for ch,h in hashes.items())
    dump(folder/'DELIVERY_REFRESH.json',all_refreshed)
    work=ROOT/'docs/handoff/WORK_LOG.zh-CN.md';work.write_text(work.read_text(encoding='utf-8')+f'\n## {datetime.now().date()} 属性/私有声明公理及依赖合集补充\n补验3处属性声明和2处private辅助声明的#print axioms，并补齐相关复审包的类型别名定义展开；各章Lean字节与既有证明未改。\n旧包和完整检查证据保留；仅受影响条目生成新包，网站及导师确认尚未进行，第6章暂停。\n',encoding='utf-8')
    owned.extend(['docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/REPAIR_QUEUE.md',
      'scripts/annotated_delivery_finish.py','scripts/build_mathcopilot_compact.py','scripts/eaudit_review_tasks.py',
      'scripts/website_repair_batch.py','scripts/website_repair_delivery.py','scripts/website_repair_finish.py','scripts/repair_ch04.py','scripts/repair_ch05.py'])
    stage(owned);subprocess.run(['git','commit','-m','repair audit delivery: include attributed declarations and complete project type aliases'],cwd=ROOT,check=True)
    p=subprocess.run(['git','push'],cwd=ROOT)
    if p.returncode:subprocess.run(['git','-c','http.sslBackend=openssl','push'],cwd=ROOT,check=True)
    print('ANNOTATED_DECLARATIONS_ACCEPTED',all_refreshed,flush=True)

if __name__=='__main__':run()
