"""Regenerate local evidence, progress and one-file A+C task batches."""
from pathlib import Path
import json,re,hashlib,csv,sys
from ch01_full_data import ROOT,BASE,RECORDS,EXCLUDED

def declarations():
    text=(ROOT/'Blueprint/Ch01.lean').read_text(encoding='utf-8-sig')
    marks=list(re.finditer(r'/-- source_id:\s*([^\s·]+)[\s\S]*?-/',text))
    out={}
    for i,m in enumerate(marks):
        stop=marks[i+1].start() if i+1<len(marks) else text.rfind('end MD.Ch01')
        raw=text[m.end():stop].strip()
        raw=re.split(r'/\- (?:BEGIN|END) FULL SECTION',raw)[0].strip()
        decl=re.search(r'\b(theorem|def)\s+(\w+)',raw)
        if not decl:raise ValueError(m.group(1))
        code=raw if decl.group(1)=='def' else re.split(r'\s:=\s*by\b',raw,maxsplit=1)[0].rstrip()
        name='MD.Ch01.'+decl.group(2)
        out[m.group(1)]={'name':name,'statement':code,'block':raw,
            'line':text[:m.end()].count('\n')+raw[:decl.start()].count('\n')+2,
            'signature_sha256':hashlib.sha256(code.encode()).hexdigest()}
    return out

def sync():
    sources=json.loads((BASE/'ch01_source.json').read_text(encoding='utf-8-sig'))
    ds=declarations(); audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))
    pilot=json.loads((BASE/'audit.json').read_text(encoding='utf-8-sig'))['items']
    website={};wp=BASE/'website_audit.json'
    if wp.exists():
        wd=json.loads(wp.read_text(encoding='utf-8-sig'))
        if isinstance(wd,dict):wd=wd.get('items',wd)
        website={x['source_id']:x for x in wd} if isinstance(wd,list) else wd
    def web(sid):
        w=website.get(sid)
        return '待网站审计' if w is None else w.get('audit',w).get('verdict','NEEDS_HUMAN')
    for s in sources:
        s.setdefault('review_status','DRAFT')
        sid=s['source_id'];d=ds[sid]
        if sid not in audit['items']:
            a=pilot[sid]
            bad='Legendre' in sid
            audit['items'][sid]=dict(lean_decl=s['lean_decl'],verdict='NEEDS_HUMAN' if bad else 'PASS',
                explanation=('M=-1,U=p=0时目标v²/2无界；字面可逆前提不足；配置相关一般矩阵不能由固定对角库推出。' if bad else
                '按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。'),
                counterexample='n=1,M=-1,U=0,p=0' if bad else None,
                suggested_fix='导师裁定是否继承凸性/对称正定背景；当前不静默添加。' if bad else None,
                correspondence=a['correspondence'],documented_priors=s.get('reusable_proofs',[]),
                proof_attempts=0,proof_status='placeholder' if bad else 'existing_bridge',website_audit='待网站审计',
                checked=False,missing='一般配置相关正定矩阵Legendre理论；原文字面前提疑点。' if bad else None)
        a=audit['items'][sid]
        if a.get('signature_sha256') != d['signature_sha256']:
            a.update(checked=False,axioms=[],final_status='incomplete')
        a['signature_sha256']=d['signature_sha256']
        a['website_audit']=web(sid)
        a['direct_placeholder']='sorry' in d['block']
        if not a['direct_placeholder'] and a['proof_status']=='placeholder': a['proof_status']='local_proof'
        if not a['direct_placeholder']: a['missing']=None
    (BASE/'ch01_source.json').write_text(json.dumps(sources,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    (BASE/'local_audit.json').write_text(json.dumps(audit,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch01\n\n'+'\n'.join('#print axioms '+s['lean_decl'] for s in sources)+'\n',encoding='utf-8')
    mapped={oid:s['source_id'] for s in sources for oid in s.get('old_ids',[])}
    for ids,sid in [([55,56],'MD-1.2-EnergyConservation'),([72,73],'MD-1.3-NewtonEulerLagrange'),
                    ([80,81,82,83],'MD-1.4-LegendreHamiltonian'),([99,100],'MD-1.5.1-FlowInverse'),([145],'MD-1.5.3-Thm1.1')]:
        mapped.update({'CH01-'+str(i).zfill(3):sid for i in ids})
    mapping={'mapped':mapped,'excluded':EXCLUDED}
    (BASE/'old_mapping.json').write_text(json.dumps(mapping,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    taskdir=BASE/'mathcopilot_tasks';index=['# 第1章MathCopilot批次索引','','每个文件整段粘贴一个Task，先A后C，B取消；网站只由用户提交。输入版本以批次MANIFEST.json的SHA256为准。','','| 批次 | source_id | 上传文件及页码 | 建议顺序 |','|---|---|---|---|']
    if (taskdir/'compact/BATCH01/README.md').exists():
        index[3:3]=['BATCH01输入限制适配：优先按[精简提交说明](compact/BATCH01/README.md)分a/b/c三个Task提交。每Task只粘贴短PROMPT.txt并引用对应材料MD和裁页PDF；原五条保持完整，按source_id整合三个返回件；网站接收未验证。','']
    groups=[('BATCH01',[s for s in sources if s['source_id'] in pilot])]
    num=2
    for sec in dict.fromkeys(s['section'] for s in sources if s['source_id'] not in pilot):
        items=[s for s in sources if s['section']==sec and s['source_id'] not in pilot]
        for offset in range(0,len(items),8):groups.append((f'BATCH{num:02}',items[offset:offset+8]));num+=1
    # All local project imports reachable from Blueprint: this is an attachment inventory,
    # not a claim that imported propositions are proved.
    paths={'Blueprint/Ch01.lean'};stack=list(paths)
    while stack:
        path=stack.pop()
        for imp in re.findall(r'(?m)^import ([\w.]+)',(ROOT/path).read_text(encoding='utf-8-sig')):
            f=imp.replace('.','/')+'.lean'
            if f.startswith('MolecularDynamics/') and f not in paths: paths.add(f);stack.append(f)
    deps=sorted(paths-{'Blueprint/Ch01.lean'})
    manifest=[]
    for number,(batch,items) in enumerate(groups,1):
        if items:
            pages=set()
            for s in items:
                ns=[int(n) for n in re.findall(r'\d+',s['pdf_page'])]
                pages.update(range(ns[0],ns[-1]+1))
            pages=sorted(pages)
            prompt=[f'# {batch}：第1章原文审校A + 只读语义审计C','', '## 开始前 @引用 / 上传','',
                '1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：'+', '.join(map(str,pages))+'；上下文读取该节相邻页。',
                '2. `blueprint/ch01/ch01_source.json`（仅审本批source_id）及 `Blueprint/Ch01.lean`（包含全部辅助定义）。',
                '3. 依赖定义文件（核实真实定义，不能依据名称）：','', '```text',*deps,'```','',
                'Lean4.34.0 / Mathlib v4.34.0。完整输入哈希见MANIFEST.json；本地审计不能替代你的网站独立审计。','',
                '## 第一部分：模板A 原文审校','',
                '逐条打开PDF原页，逐字核对statement_latex、proof_latex、页码及上下文；不把CSV转述当原文。不得静默纠正原书。若问题仅为原书疑误，保留原文并标记ISSUE。不得伪造证明；proof_latex=null表示无独立完整证明。status仅APPROVED / CORRECTED / NEEDS_HUMAN；issue_codes、issues及evidence给出页码和具体原文依据。corrected_json为完整修正版条目，无需修订则null。','',
                '## 第二部分：模板C 只读语义审计','',
                '基于A审校后的原文，逐条核对真实Lean定义展开、对象/域/量词/前提/全部结论；判断[EXTRA]是否合理，不能接受True、P→P、结论作前提或偷换对象。证明是否sorry与签名语义判定分开；只读，不修文件不写证明。verdict仅PASS / FAIL / NEEDS_HUMAN；反例有则明确给出，建议修复须指出缺失或强化；原文错误不得静默改成真命题。','',
                '## 本批输入','']
            for s in items:
                prompt += ['### '+s['source_id'],'','```json',json.dumps(s,ensure_ascii=False,indent=2),'```','','```lean',ds[s['source_id']]['statement'],'```','']
            prompt += ['## 唯一输出','', '仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：',
                '```json','[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]','```']
            output='\n'.join(prompt)+'\n';(taskdir/(batch+'.md')).write_text(output,encoding='utf-8')
        files=['blueprint/ch01/ch01_source.json','Blueprint/Ch01.lean',*deps]
        size=(taskdir/(batch+'.md')).stat().st_size
        if size>=40000:raise ValueError((batch,size))
        manifest.append({'batch':batch,'source_ids':[s['source_id'] for s in items], 'bytes':size,
            'task_sha256':hashlib.sha256((taskdir/(batch+'.md')).read_bytes()).hexdigest(),
            'source_pdf_sha256':hashlib.sha256(next(ROOT.parent.glob('Leimkuhler2015b*.pdf')).read_bytes()).hexdigest(),
            'files':{p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest() for p in files}})
        index.append('| '+batch+' | '+', '.join(s['source_id'] for s in items)+' | 见'+batch+'.md包首清单；原文PDF '+', '.join(s['pdf_page'] for s in items)+' | '+str(number)+' |')
    (taskdir/'MANIFEST.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    index+=['','## 每批共同上传文件','', '`blueprint/ch01/ch01_source.json`、`Blueprint/Ch01.lean`及以下实际依赖文件；各批PDF页码见上表与包首。','','```text',*deps,'```']
    (taskdir/'INDEX.md').write_text('\n'.join(index)+'\n',encoding='utf-8')
    rows=list(csv.DictReader((ROOT/'docs/review/CH01_CLAIMS.csv').open(encoding='utf-8-sig')))
    progress=['# 第1章五步流程本地进度','','范围：印刷p.1–45正文，Exercises排除；正式库基线63fa09227e1d898e0cacae3c33241d3d6ecba816，heartbeat ACTIVE/15分钟原样。',
        '下一步：按CURRENT_STATE顶部接续；全章已覆盖，终检和推送完成后等待用户提交INDEX.md中的网站批次。',
        f'当前{len(sources)}条；本地PASS {sum(audit["items"][s["source_id"]]["verdict"]=="PASS" for s in sources)}；网站返回{len(website)}；任务包{len(groups)}批，每批≤8条、每文件<40KB。','',
        '## 逐条进度','','| source_id | JSON | Blueprint | 本地预审 | 网站审计 | 证明 |','|---|---|---|---|---|---|']
    for s in sources:
        a=audit['items'][s['source_id']]
        batch=next(b for b,its in groups if s in its)
        proof='sorry / '+(a.get('missing') or a.get('suggested_fix') or '待证明') if a['direct_placeholder'] else a['proof_status']
        if a['direct_placeholder'] and a.get('proof_failures'):proof+=f'（失败{a["proof_failures"]}次，时间盒已止）'
        progress.append('| '+' | '.join([s['source_id'],s['review_status']+'/原页已核','陈述已写；'+('已编译' if a['checked'] else '待本轮编译'),a['verdict'],web(s['source_id'])+' / '+batch,proof.replace('|','/')])+' |')
    progress+=['','## 旧清单完整映射','','| 旧id | 新source_id或排除理由 |','|---|---|']
    for r in rows:progress.append('| '+r['id']+' | '+mapped.get(r['id'],EXCLUDED.get(r['id'],'PENDING：所属节尚未处理'))+' |')
    progress+=['','## 导师判断与缺失理论','']
    for s in sources:
        a=audit['items'][s['source_id']]
        if a['verdict']!='PASS' or s.get('issues') or a.get('missing'):
            progress.append('- '+s['source_id']+'：'+a['explanation']+'；'+(a.get('missing') or a.get('suggested_fix') or '问题详见JSON issues。'))
    progress+=['','## 排除正文','', '- 印刷p.1–4为介绍、历史、规模、应用及图示，无独立数学定义/有论证结论，excluded_qualitative；p.17末尾跨p.18模拟参数经验段同类。',
        '- 数值图示、模型经验准确性与原文未给公式的模型分类不冒充定理；每个旧id均见上表。']
    exclusions=BASE/'excluded_passages.json'
    if exclusions.exists():
        for e in json.loads(exclusions.read_text(encoding='utf-8')):
            progress.append('- 印刷p.'+e['printed_page']+' / PDFp.'+e['pdf_page']+'：'+e['reason'])
    progress+=['','## 验证证据','', '- 全部45原页视觉核对索引：source_page_checks.json；逐次本地证明尝试：proof_attempts.json；完整check报告：validation/各节及最终目录。',
        '- 原页转录、本地语义判定、Lean检查及网站审计分别登记；原文仍DRAFT，网站尚未返回。']
    (BASE/'PROGRESS.md').write_text('\n'.join(progress)+'\n',encoding='utf-8')
    print('synced',len(sources),'entries',len(groups),'batches', 'max bytes',max(x['bytes'] for x in manifest))

def mark_checked(log):
    audit=json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))
    text=Path(log).read_text(encoding='utf-8-sig')
    for a in audit['items'].values():
        name=a['lean_decl']
        m=re.search(r"'"+re.escape(name)+r"' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",text)
        if not m:raise ValueError('missing axiom output '+name)
        axioms=[] if m.group(1) is None else [s.strip() for s in m.group(1).split(',') if s.strip()]
        a.update(checked=True,axioms=axioms,final_status='incomplete' if 'sorryAx' in axioms or a['verdict']!='PASS' else
                 ('checked+documented priors' if a['documented_priors'] else 'self-contained'),axiom_log=str(Path(log).relative_to(ROOT)))
    (BASE/'local_audit.json').write_text(json.dumps(audit,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')

if __name__=='__main__':
    if len(sys.argv)>1:mark_checked(ROOT/sys.argv[1])
    sync()
