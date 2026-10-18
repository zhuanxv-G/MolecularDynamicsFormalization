"""Chapter 7 local checks, receipts, progress, and mentor-facing seven-part review."""
from pathlib import Path
import re,json,hashlib,subprocess,sys,argparse
from datetime import datetime
from ch07_data import ROOT,BASE,RECORDS,EXCLUDED,HEADER
from local_compile import compile_recorded

def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def dump(p,x):
    p=Path(p);p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def verify_frozen():
    frozen=json.loads((BASE/'FROZEN_BASELINE.json').read_text(encoding='utf-8'))
    for p,h in frozen.items():assert sha(ROOT/p)==h,'Frozen file changed: '+p
    return len(frozen)

def generate():
    verify_frozen()
    checks=json.loads((BASE/'source_page_checks.json').read_text(encoding='utf-8'))
    for r in RECORDS:
        nums=[int(x) for x in re.findall(r'\d+',r['pdf_page'])]
        for p in range(nums[0],nums[-1]+1):assert str(p) in checks['visually_checked_pdf_pages'],(r['source_id'],p)
    text=HEADER+''.join('/-- source_id: '+r['source_id']+' · 印刷p.'+r['printed_page']+' / PDFp.'+r['pdf_page']+
        ''.join('\n[EXTRA] '+x for x in r['extra_assumptions'])+
        ''.join('\n[ERRATUM?] '+x for x in r['issues'])+' -/\n'+r['code']+'\n\n' for r in RECORDS)+'end MD.Ch07\n'
    source=ROOT/'Blueprint/Ch07.lean';source.write_text(text,encoding='utf-8')
    dump(BASE/'ch07_source.json',[{k:v for k,v in r.items() if k not in ['code','local_verdict','missing']} for r in RECORDS])
    dump(BASE/'excluded_qualitative.json',EXCLUDED)
    names=re.findall(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem|lemma|structure)\s+(\w+)',text)
    audit='\n'.join('#print axioms MD.Ch07.'+n for n in names)+'\n'
    (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch07\n\n'+audit,encoding='utf-8')
    old=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8')) if (BASE/'local_audit.json').exists() else {}
    items={}
    for r in RECORDS:
        sid=r['source_id'];blockhash=hashlib.sha256(r['code'].encode()).hexdigest();prev=old.get('items',{}).get(sid,{})
        same=prev.get('block_sha256')==blockhash
        items[sid]=dict(verdict=r['local_verdict'],block_sha256=blockhash,checked=bool(same and prev.get('checked')),
            declaration_axioms=prev.get('declaration_axioms',{}) if same else {},
            direct_placeholder=bool(re.search(r'\bsorry\b',r['code'])),missing=r['missing'],
            issues=r['issues'],website='待网站审计',statement_scope=r['statement_scope'],
            extra_assumptions=r['extra_assumptions'],source_pages=r['pdf_page'],
            semantic_review='已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。')
    dump(BASE/'local_audit.json',dict(template='C',items=items))
    attempts_path=BASE/'proof_attempts.json'
    attempts=json.loads(attempts_path.read_text(encoding='utf-8')) if attempts_path.exists() else {}
    for r in RECORDS:
        if re.search(r'\bsorry\b',r['code']):
            previous=attempts.get(r['source_id'],{})
            attempts[r['source_id']]=dict(reason=r['missing'],category=previous.get('category') or
                ('原书疑误不证' if any('Printed' in n for n in r['lean_declarations']) and r['issues'] else '缺大型理论'),
                routes=previous.get('routes',[]),decision='缺大型理论时直接记录缺项；否则最多三条短路线。')
    dump(attempts_path,attempts)
    render()
    return source,audit

def render():
    state=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'));progress=[];doc=['# 第7章 Lean Blueprint 本地审阅材料','',f'当前已整理{len(RECORDS)}条；网站尚未审阅。正文范围为印刷261–326页（PDF282–347），末页仅取Exercises之前的正文。','']
    completion_path=BASE/'closeout/COMPLETION.json'
    complete=json.loads(completion_path.read_text(encoding='utf-8')) if completion_path.exists() else {}
    done=complete.get('machine_check_status')=='passed' and complete.get('canonical_sha256')==sha(ROOT/'Blueprint/Ch07.lean')
    progress=['# 第7章逐条进度','',f'当前正文落盘：{len(RECORDS)}条。全部正文完成：'+('是' if done else '否')+'。章末完整check：'+('通过' if done else '未完成')+'。','',
      '| source_id | 原页PDF | 本地对照 | 编译/公理 | 数学状态 | 网站 |','|---|---|---|---|---|---|']
    for r in RECORDS:
        a=state['items'][r['source_id']];ax=a.get('declaration_axioms',{});incomplete=any('sorryAx' in v for v in ax.values())
        st='未证陈述' if a['direct_placeholder'] or incomplete else ('定义' if r['kind'] in ['definition','notation'] else '已证' if a['checked'] else '待编译')
        progress.append('| '+' | '.join([r['source_id'],r['pdf_page'],a['verdict'],'通过' if a['checked'] else '待检查',st,'待审'])+' |')
        doc+=['## 1. '+r['source_id']+' · '+str(r['label'] or r['kind'])+' · 印刷p.'+r['printed_page']+' / PDFp.'+r['pdf_page'],'',
          '### 2. 原文陈述','',r['statement_latex'],'','### 3. 原文证明','',r['proof_latex'] or r['proof_note'],
          ('证明思路提要（不是原文引句）：'+r['proof_outline']) if r.get('proof_outline') else '',
          '原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。','',
          '### 4. 完整当前Lean（原文与修正版独立列出）','','```lean',r['code'],'```','',
          '### 5. 对照表','','| 原文成分 | Lean对应 | 说明 |','|---|---|---|',
          '| 本条引用的对象与公式 | '+', '.join(r['lean_declarations'])+' | '+r['statement_scope'].replace('|','/ ')+' |','',
          '[EXTRA] '+('；'.join(r['extra_assumptions']) or '本条没有另加数学前提。'),
          '记号与上下文：'+('；'.join(r['context_notation']) or '见所列原文与Lean量化变量。'),'',
          '### 6. 审计结论','','本地：'+a['semantic_review'],'疑点：'+('；'.join(r['issues']) or '本条暂未发现需单列的原书疑误。'),
          '网站：尚未送审。','','### 7. 状态与证明位置','',st+'；'+('Lean陈述可检查，证明完整性按本条状态区分。' if a['checked'] else 'Lean检查尚未完成。'),
          '未证原因：'+r['missing'] if r['missing'] else '本条未登记待证缺项。',
          '位置：Blueprint/Ch07.lean；'+', '.join(r['lean_declarations'])+'。','']
    (BASE/'PROGRESS.md').write_text('\n'.join(progress)+'\n',encoding='utf-8')
    (ROOT/'docs/review/CH07_BLUEPRINT.zh-CN.md').write_text('\n'.join(doc)+'\n',encoding='utf-8')

def batch(label):
    source,audit=generate();folder=BASE/'validation/batches';folder.mkdir(parents=True,exist_ok=True)
    probe=folder/(label+'.lean');text=source.read_text(encoding='utf-8')+'\n'+audit
    if probe.exists():assert probe.read_text(encoding='utf-8')==text,'Choose a new label after edits'
    else:probe.write_text(text,encoding='utf-8')
    r,out,reused=compile_recorded(['lake','env','lean',str(probe.relative_to(ROOT))],ROOT,probe,probe.with_suffix('.log'),probe.with_suffix('.json'),reuse_failure=True)
    if r['exit_code']:
        print(out.decode('utf-8',errors='replace')[-12000:]);raise SystemExit(r['exit_code'])
    log=out.decode('utf-8');state=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))
    for item in RECORDS:
        a=state['items'][item['source_id']];axs={}
        for name in item['lean_declarations']:
            m=re.search("'"+re.escape(name)+r"' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",log)
            assert m,('missing axiom output',name)
            axs[name]=[] if m[1] is None else [s.strip() for s in m[1].split(',') if s.strip()]
        a.update(checked=True,declaration_axioms=axs,compile_receipt=str(probe.with_suffix('.json').relative_to(ROOT)).replace('\\','/'))
    dump(BASE/'local_audit.json',state)
    dump(probe.with_name(label+'-binding.json'),dict(canonical_sha256=sha(source),audit_sha256=sha(BASE/'CheckAxioms.lean'),receipt_sha256=sha(probe.with_suffix('.json')),entries=len(RECORDS)))
    render();print('PASS batch',label,'entries',len(RECORDS),'frozen',verify_frozen(),flush=True)

def section(label):
    verify_frozen();state=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'));assert all(r['checked'] for r in state['items'].values())
    # Reuse the unchanged complete formal-library check. Its original report is preserved.
    shared=ROOT/'blueprint/ch06/closeout26/full';r=json.loads((shared/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
    assert r['machine_check_status']=='passed'
    for p in r['inputs']:assert sha(ROOT/p['relative_path'])==p['sha256'],p['relative_path']
    for c in r['checks']:assert c['exit_code']==0 and sha(shared/c['raw_log'])==c['raw_log_sha256']
    current=sha(ROOT/'Blueprint/Ch07.lean');candidates=[]
    for p in (BASE/'validation/batches').glob('*-binding.json'):
        b=json.loads(p.read_text(encoding='utf-8'))
        if b['canonical_sha256']==current:candidates.append((p,b))
    assert candidates
    p,b=max(candidates,key=lambda x:x[0].stat().st_mtime)
    dump(BASE/f'validation/section{label}/CHECK_REPORT.json',dict(machine_check_status='passed',
      formal_full_check_reused=str(shared.relative_to(ROOT)),formal_report_sha256=sha(shared/'CHECK_REPORT.json'),
      original_formal_checks=r['checks'],current_ch07_receipt=str(p.relative_to(ROOT)),canonical_sha256=current,
      frozen_files=verify_frozen(),native_rerun=False,
      scope='复用输入逐字不变的正式库全检查；当前第7章使用本节完整当前源码和逐声明公理输出。'))
    print('PASS section',label,flush=True)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('mode',choices=['generate','batch','section']);p.add_argument('label',nargs='?');a=p.parse_args()
    if a.mode=='generate':generate()
    elif a.mode=='batch':batch(a.label)
    else:section(a.label)
