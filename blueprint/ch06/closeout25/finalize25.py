from common25 import *
from collections import Counter
from ch06_errata import SPECS
from packages25 import EXPLICIT

DECL=re.compile(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(theorem|lemma|def|abbrev)\s+(\w+)')
def chunks(code):
 ms=list(DECL.finditer(code));return [dict(kind=m[1],name=m[2],code=code[m.start():ms[i+1].start() if i+1<len(ms) else len(code)].strip()) for i,m in enumerate(ms)]
def human(x):
 if isinstance(x,str):return x
 if isinstance(x,list):return '；'.join(human(t) for t in x)
 if isinstance(x,dict):return '；'.join(str(k)+'：'+human(t) for k,t in x.items())
 return str(x)
def quote(s):return '\n'.join('> '+x for x in str(s).splitlines())
def flat(s):return str(s).replace('|','\\|').replace('\n',' ')
def main():
 rows=load(OUT/'RETURNS.json');rr={r['source_id']:r for r in rows};gg=groups()
 full_report=OUT/'full/CHECK_REPORT.json'
 full_pass=full_report.exists() and load(full_report).get('machine_check_status')=='passed'
 web=load(BASE/'website_audit.json');ww={w['source_id']:w for w in web}
 source=load(BASE/'ch06_source.json');src={s['source_id']:s for s in source}
 reps=load(OUT/'REPAIRS.json');assert len(reps)==25 and all(r['exit_code']==0 for r in reps)
 triage=load(OUT/'HUMAN_REPAIRS.json');hh={r['source_id']:r for r in triage['items']}
 assert triage['receipt']['exit_code']==0
 # Bind the final official single-file compiler elaboration and every axiom output;
 # the complete check separately performs the native build and fresh source checks.
 receipt=load(OUT/'FINAL_COMPILE.json');assert receipt['canonical_sha256']==sha(LEAN) and receipt['exit_code']==0
 log=(OUT/'FINAL_COMPILE.log').read_text(encoding='utf-8-sig');assert sha(OUT/'FINAL_COMPILE.log')==receipt['log_sha256']
 axioms={}
 for m in re.finditer(r"'([^']+)' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",log):
  axioms[m[1].split('MD.Ch06.')[-1]]=[x.strip() for x in (m[2] or '').split(',') if x.strip()]
 assert {n for g in gg.values() for n in g['names']}<=set(axioms)
 previous=load(OUT/'proof_attempts.before.json');local=load(BASE/'local_audit.json');decls=[];counts=Counter();reasons=Counter()
 # Source issues and implementation transcription mistakes must never be conflated.
 errkeys=set(SPECS)-{'OULawPrinted','FPDiffusionPrinted','WeakItoAlias'}
 errkeys|={'Proposition61','RiemannTags','SelfStratonovichIntegral','BrownianSymmetry','BrownianRealEigenvalue','BrownianClosedSelfAdjoint','BrownianCompactResolvent','ComplexInitialDensity'}
 repairs={r['source_id']:r for r in reps}
 selected=set(load(OUT/'REAUDIT_SELECTION.json')['source_ids'])
 for s in source:
  sid=s['source_id'];r=rr[sid];w=ww[sid];key=sid.split('-')[-1]
  corrected=r.get('json_review',{}).get('corrected_json')
  if corrected:
   fields=['statement_latex','proof_latex','proof_note','proof_discussion_latex','printed_page','pdf_page']
   if 'closeout25_source_changes' not in s:
    s['closeout25_source_changes']={k:dict(before=s.get(k),after=corrected[k]) for k in fields if k in corrected and s.get(k)!=corrected[k]}
   for k in fields:
    if k in corrected:s[k]=corrected[k]
   for issue in corrected.get('issues',[]):
    if issue not in s.setdefault('issues',[]):s['issues'].append(issue)
  note=repairs.get(sid,hh.get(sid,{})).get('note')
  if sid in repairs:
   s.setdefault('superseded_extra_assumptions25',s.get('extra_assumptions',[]))
   s['extra_assumptions']=['[EXTRA] 25号：'+note]
  if note and '[EXTRA] 25号：'+note not in s.setdefault('extra_assumptions',[]):s['extra_assumptions'].append('[EXTRA] 25号：'+note)
  if key in ['OULawPrinted','FPDiffusionPrinted']:
   s['issues']=[x for x in s.get('issues',[]) if not (isinstance(x,dict) and x.get('code')=='ERRATUM?')]
   s['source_transcription_correction25']=dict(original_pdf_visual_verified=True,book_erratum=False,note=note)
   for entry in s.get('repair_log',[]):
    if entry.get('action')=='directive22_printed_corrected_pair':entry['superseded_by25']='此前原书疑误归因错误；历史记录保留，原页本身正确。'
   w['pdf_recheck25']=s['source_transcription_correction25']
  if key=='WeightedH1Norm':s['printed_page']='256–257';s['pdf_page']='277–278'
  ds=[]
  for d in chunks(gg[sid]['code']):
   n=d['name'];ax=axioms[n];old=previous['items'].get(sid,{}).get('declarations',{}).get('MD.Ch06.'+n,{})
   status='未证' if 'sorryAx' in ax else '定义' if d['kind'] in ['def','abbrev'] else '已证'
   reason=None
   if status=='未证':
    if ('Printed' in n or 'Literal' in n) and '_corrected' not in n and key in errkeys:reason='原书疑误不证'
    elif old.get('classification')=='时间盒止':reason='时间盒止'
    else:reason='缺大型理论'
    reasons[reason]+=1
   counts[status]+=1
   ds.append(dict(name='MD.Ch06.'+n,kind=d['kind'],status=status,axioms=ax,classification=reason,direct_placeholder=bool(re.search(r'\bsorry\b',d['code'])),source_id=sid))
  decls+=ds
  s['closeout25_declarations']=ds
  w['versions25']=dict(submitted=dict(verdict=r['audit']['verdict'],declarations=r['audit']['lean_decl'],scope='首轮所交签名；不扩展到后来修改版本'),
    original=dict(lean_declarations=[d for d in ds if '_corrected' not in d['name']],website_statement=r['audit']['explanation']),
    corrected=dict(lean_declarations=[d for d in ds if '_corrected' in d['name']],website_verdict=None,website_text=[t for t in re.split(r'(?<=[。；])',r['audit']['explanation']) if '修正版' in t or '_corrected' in t],status='新增/修改版本待复审；既有版本的明确评价见原返回正文'),
    counterexample=dict(text=r['audit'].get('counterexample'),declarations=[d for d in ds if 'counterexample' in d['name']],website_verdict=None),
    book_issue=dict(recorded=key in errkeys,status='待导师裁定' if key in errkeys else '不是本轮新增原书疑误'))
  w['human_triage25']=hh.get(sid)
  w['effective_status']='按网站意见处理、本地检查通过；待复审' if sid in selected else '原书疑误待导师裁定，保留首轮分别评价' if r['audit']['verdict']=='NEEDS_HUMAN' else '网站PASS（首轮未改版本）'
  a=local['items'].setdefault(sid,{})
  a.update(checked=True,compiled=True,compile_evidence='blueprint/ch06/closeout25/FINAL_COMPILE.json',declaration_axioms={d['name']:d['axioms'] for d in ds},axioms=sorted({a for d in ds for a in d['axioms']}),direct_placeholder=any(d['direct_placeholder'] for d in ds),final_status='incomplete' if any(d['status']=='未证' for d in ds) else 'self-contained',closeout25_declarations=ds)
 # Every current source group is represented and every declaration is axiom checked.
 grouped={d['name'].split('.')[-1] for d in decls}
 helper_code=LEAN.read_text(encoding='utf-8').split('/-- source_id:',1)[0]
 helper_chunks=[d for d in chunks(helper_code) if d['name'] not in grouped]
 for d in helper_chunks:
  ax=axioms[d['name']];status='未证' if 'sorryAx' in ax else '定义' if d['kind'] in ['def','abbrev'] else '已证'
  counts[status]+=1
  decls.append(dict(name='MD.Ch06.'+d['name'],kind=d['kind'],status=status,axioms=ax,classification=None,source_id=None,direct_placeholder=False))
 dump(BASE/'ch06_source.json',source);dump(BASE/'website_audit.json',web);dump(BASE/'local_audit.json',local);dump(OUT/'DECLARATIONS.json',decls)
 attempts=load(BASE/'proof_attempts.json');attempts['closeout25']=dict(declarations=decls,counts=counts,unproved_reasons=reasons,evidence='blueprint/ch06/closeout25/FINAL_COMPILE.log');dump(BASE/'proof_attempts.json',attempts)
 # Merge multiple source_ids for the same issue, while preserving each quotation and its actual verdict.
 MERGES=[['BrownianNonpositive','BrownianNegativeDefinitePrinted','BrownianRealEigenvalue'],['BrownianSymmetry','BrownianClosedSelfAdjoint','BrownianCompactResolvent'],['Theorem61','Theorem61TimeAveragePrinted'],['BathForcePrinted','BathReductionPrinted'],['MinorizationPrinted','MinorizationCorrectedImplication'],['PeriodicPotentialBound','PeriodicConfiningPrinted'],['HamiltonianPowerMomentumLaplacian','LaplacianBoundPrinted','LyapunovYoungBounds'],['Proposition64Printed','ForwardKernelGibbs']]
 ids=[s['source_id'] for s in source if s['source_id'].split('-')[-1] in errkeys];issue_groups=[];assigned=set()
 for keys in MERGES:
  members=[s['source_id'] for s in source if s['source_id'].split('-')[-1] in keys]
  if members:issue_groups.append(members);assigned.update(members)
 issue_groups += [[sid] for sid in ids if sid not in assigned];issue_groups.sort(key=lambda a:min(list(src).index(sid) for sid in a))
 err=['# 第6章原书疑误与双版本审阅单','','教材：Leimkuhler–Matthews，Molecular Dynamics，Springer 2015，第6章正文。页码采用PDF物理页。工作勘误和范围解释尚待导师裁定。',
  '网站首轮对忠实原文、限定/修正版及原书数学问题的评价分别保留。网站PASS是所交签名的语义判断，不表示未证声明已有证明；本轮修改版本待复审。',
  'OU根号范围（PDF256）和两次分部积分正号（PDF263）已目视核对为转录错误，已撤销原书疑误归因；WeakItoAlias的非可积默认零是项目辅助定义问题，也不计原书勘误。',f'共{len(issue_groups)}项合并问题。','']
 issue_index=[];byname={d['name'].split('.')[-1]:d for d in decls}
 for i,members in enumerate(issue_groups,1):
  err += [f'## {i}. '+' / '.join(members),'', '- source_id：'+'；'.join(members)+'。']
  for sid in members:
   s=src[sid];r=rr[sid];a=r['audit'];key=sid.split('-')[-1];note=repairs.get(sid,hh.get(sid,{})).get('note') or (SPECS[key][1]+' '+SPECS[key][2] if key in SPECS else a['explanation'])
   ds=s['closeout25_declarations'];corrected=[d for d in ds if '_corrected' in d['name']]
   issue_note=SPECS[key][1] if key in SPECS else note
   change_note=(SPECS[key][2]+' '+(note if sid in repairs else '')) if key in SPECS else note
   for name in EXPLICIT.get(key,[]):
    if name.endswith('_corrected') and name in byname and byname[name] not in corrected:corrected.append(byname[name])
   if not corrected and key in SPECS and SPECS[key][0]:
    target=next((x for x in source if x['source_id'].split('-')[-1]==SPECS[key][0]),None)
    if target:corrected=target['closeout25_declarations']
   err += ['', '### '+sid,'',f'- 印刷页 / PDF页：{s["printed_page"]} / {s["pdf_page"]}。', '- 原文引文（逐字）：','',quote(s['statement_latex']),'',
    '- 问题所在：'+issue_note, '- 反例或理由：'+human(a.get('counterexample') or a['explanation']),
    '- 原文版 Lean 名称及状态：'+'；'.join('`'+d['name']+'`（'+d['status']+'）' for d in ds if '_corrected' not in d['name'])+'。原书有疑的字面断言不证明；原有正确子句或定义保留。',
    '- 修正版 Lean 名称、改动内容、证明状态：'+change_note+'；'+('；'.join('`'+d['name']+'`（'+d['status']+'）' for d in corrected) if corrected else '本条是正确限定子句/资格定义；不把原文字面错误计成已证，相关完整修正版见同组。'),
    '- 待人工核查点：核对原文上下文、范围及反例；确认上述资格、坐标/闭域或概率解释是否符合作者意图。',
    '- 导师选项：'+(a.get('suggested_fix') or '接受本条限定解释 / 保留原文疑误待定。'),
    '- 网站审校结论：所交声明 `'+str(a['lean_decl'])+'` 的整体 verdict='+a['verdict']+'；原文栏='+r['json_review']['status']+'。'+a['explanation']+' 本轮修改版：待复审；反例：'+('网站正文已讨论，未单列verdict。' if a.get('counterexample') else '无单列网站verdict。'),'']
  issue_index.append(dict(number=i,source_ids=members))
 (ROOT/'docs/review/CH06_ERRATA.zh-CN.md').write_text('\n'.join(err).rstrip()+'\n',encoding='utf-8');dump(OUT/'ERRATA_INDEX.json',issue_index)
 summary=dict(total=249,website_pass=179,first_round=dict(PASS=179,FAIL=25,NEEDS_HUMAN=45),local_repairs=25,repairing=0,errata=len(issue_groups),errata_source_ids=len(set(s for g in issue_groups for s in g)),declarations=counts,unproved_reasons=reasons,current_lean_sha256=sha(LEAN),native_receipt='blueprint/ch06/closeout25/FINAL_COMPILE.json',full_check='blueprint/ch06/closeout25/full/CHECK_REPORT.json',awaiting_reaudit=len(load(OUT/'REAUDIT_SELECTION.json')['source_ids']))
 dump(BASE/'WEBSITE_SUMMARY.json',summary);dump(OUT/'SUMMARY.json',summary)
 mentor=['# 第6章给导师的审阅摘要','',
  '第6章正文共249条。网站首轮审阅中，179条通过、25条未通过、45条需人工判断。25条未通过意见已按建议修改，修订后的形式化陈述已通过机器核验；其数学含义尚待复审。',
  '',f'合并后共有{len(issue_groups)}项原书疑误或范围解释，见[勘误清单](CH06_ERRATA.zh-CN.md)。OU方差根号及Fokker–Planck分部积分符号是转录错误，已对原页改正，不计原书勘误。定义摘录不全导致的待人工项也不计原书错误。','',
  f'当前有{counts["定义"]}个定义、{counts["已证"]}个已证陈述、{counts["未证"]}个未证陈述。数量包括同一条下的原文版、修正版、反例和辅助结论；定义不计作证明。网站通过的是所交数学陈述，与完整证明是否完成分别统计。','',
  f'未证原因：缺少所需理论{reasons["缺大型理论"]}个；因原书表述有疑暂不证明{reasons["原书疑误不证"]}个；短证明尝试尚未完成{reasons["时间盒止"]}个。所缺理论主要是一般随机积分公式、随机微分方程与生成元、遍历和闭算子谱理论。原书有疑的字面断言保留供核查，独立修正版另列。','',
  '已核对上述原页两处符号及249条审阅意见，修订稿的形式化陈述和已写证明均通过机器核验。现有全部证明的统一核验'+('已通过。' if full_pass else '尚在进行。')+'正式证明部分内容未改，仍无未完成证明和新增公理。尚待完成：修订稿复审、未证陈述的完整证明，以及导师对勘误和范围解释的裁定。','',
  '逐条原文、原证明、完整Lean及各版本状态见[完整审阅稿](CH06_BLUEPRINT.zh-CN.md)。']
 (ROOT/'docs/review/CH06_SUMMARY_FOR_MENTOR.zh-CN.md').write_text('\n'.join(mentor)+'\n',encoding='utf-8')
 bp=['# 第6章 Lean Blueprint 本地审阅材料','',f'249条；网站首轮179 PASS / 25 FAIL / 45 NEEDS_HUMAN。25条意见已修，修复中0；修改版待复审。{len(issue_groups)}项合并疑误或范围解释。','统计见[导师摘要](CH06_SUMMARY_FOR_MENTOR.zh-CN.md)；原书问题见[勘误清单](CH06_ERRATA.zh-CN.md)。','']
 for s in source:
  sid=s['source_id'];r=rr[sid];w=ww[sid];ds=s['closeout25_declarations'];key=sid.split('-')[-1]
  bp += ['## '+sid,'',f'印刷p.{s["printed_page"]} / PDFp.{s["pdf_page"]}；§{s["section"]}。','', '### 1. 原文陈述','',quote(s['statement_latex']),'', '### 2. 原文证明','',quote(s.get('proof_latex') or s.get('proof_discussion_latex') or s.get('proof_note') or '原书未给独立完整证明。'),'', '### 3. 完整当前Lean（原文版与修正版独立列出）','', '```lean',gg[sid]['code'],'```','']
  for name in EXPLICIT.get(key,[]):
   if name in byname and name.endswith('_corrected'):
    other=next(g for g in gg.values() if name in g['names']);chunk=next(d for d in chunks(other['code']) if d['name']==name)
    bp += ['同问题的独立修正版（位于另一source_id）：','```lean',chunk['code'],'```','']
  bp += ['### 4. 对照表','', '| 原文对象或结论 | 当前Lean与范围 |','|---|---|', '| 原文所选陈述 | '+flat(s.get('statement_scope','见完整签名；原文疑误与限定范围分别保留'))+' |', '| 对象/域/量词/前提 | 完整当前Lean及依赖定义；新增资格见[EXTRA] |','| 网站首轮 | '+flat(r['audit']['verdict']+'：'+r['audit']['explanation'])+' |','', '### 5. [EXTRA] 与覆盖缺口','']
  bp += ['- '+human(x) for x in s.get('extra_assumptions',[])] or ['无新增技术前提。']
  bp += ['- 覆盖缺口：'+human(x) for x in s.get('coverage_gaps',[])]
  bp += ['', '### 6. 审计结论（含网站结论）','', '网站原返回：'+r['audit']['verdict']+'。'+r['audit']['explanation'],
   '本轮处理：'+(repairs.get(sid,hh.get(sid,{})).get('note') or '保留原审阅版本结论；本轮未改签名。'),
   '本地单文件及逐声明依赖检查通过；含未完成证明依赖的声明仍标未证。原书疑误及修正版分别见勘误，当前修改版未获网站复审结论。','', '### 7. 状态与证明位置','',
   '| 声明 | 状态 | 未证原因 |','|---|---|---|']
  bp += ['| `'+d['name']+'` | '+d['status']+' | '+(d['classification'] or '—')+' |' for d in ds]
  bp += ['',f'位置：`Blueprint/Ch06.lean:{gg[sid]["line"]}`；验证：`blueprint/ch06/closeout25/FINAL_COMPILE.log`。','']
 bp += ['## 公共辅助资格定义','', '以下共同定义由相应条目引用，计入定义数；定义本身不表示存在性或公式已经证明。','']
 for d in helper_chunks:bp += ['```lean',d['code'],'```','']
 (ROOT/'docs/review/CH06_BLUEPRINT.zh-CN.md').write_text('\n'.join(bp)+'\n',encoding='utf-8')
 short=ROOT/'docs/review/CH06_REVIEW_SHORT.zh-CN.md'
 if short.exists() and not short.read_text(encoding='utf-8').startswith('> 已过时'):short.write_text('> 已过时，以 [SUMMARY_FOR_MENTOR](CH06_SUMMARY_FOR_MENTOR.zh-CN.md) 为准。\n\n'+short.read_text(encoding='utf-8'),encoding='utf-8')
 print('DOCUMENTS',dict(counts),dict(reasons),'errata',len(issue_groups))
if __name__=='__main__':main()
