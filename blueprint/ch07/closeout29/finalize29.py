from common29 import *
from collections import Counter

def quote(x):return '\n'.join('> '+l for l in (x or '').splitlines())
def flat(x):return str(x).replace('|','/').replace('\n',' ')

VERSION_ASSESSMENTS={
 'PartitionPrinted':('原印忠实；归一化结论数学错误','原送审_corrected三项归一密度结论正确'),
 'OUExactUpdate':('前导文字乘数疑误；(7.3)本身正确','原送审OU更新和转移表示正确，无公式修正需求'),
 'SPVPrinted':('Printed忠实保留q_n','原送审qhalf候选作为代数定义正确；物理域及γ=0另限'),
 'BBKStarMomentSystemPrinted':('原文版忠实性PASS；重复因子为疑误','原送审修正版代数正确性PASS'),
 'TripleCommutatorPrinted':('Printed忠实性PASS；三阶项缺β为数学疑误','原送审_corrected及实际双交换子定理PASS'),
 'ConjugateSymmetricCorrections':('Printed忠实性PASS；二阶展开有疑','原送审_corrected作为二阶截断定义PASS，非完整指数等式'),
 'OUKernelQualification':('原印裸前向OU核叙述忠实但数学有误','原送审Gibbs共轭且Gaussian L²的核陈述正确；中心化另缺'),
 'LimitMethodAccuracy':('Printed忠实保留h²','原送审h⁴仅在长期误差解释下合理，固定有限时间不适用'),
 'UnderdampedPhasePrinted':('Printed忠实表达字面式；atanh/符号有疑','原送审_corrected和三角恒等式正确'),
 'FrictionThresholdPrinted':('Printed忠实保留错误阈值链','原送审有理化、隐式包络范围及渐近正确；数值反例范围有限'),
}

def scopes():
 source=load(BASE/'ch07_source.json');gg=groups();rows={r['source_id']:r for r in load(OUT/'RETURNS.json')}
 oldg=groups((OUT/'Ch07.before.lean').read_text(encoding='utf-8'))
 checks=[]
 for r in source:
  sid=r['source_id'];code=gg[sid]['code'];a=rows[sid]['audit'];changed=code!=oldg[sid]['code']
  # PASS rows keep precisely the reviewed declaration block, with explicit
  # source-selected scope rather than an assertion about the complete PDF page.
  if a['verdict']=='PASS':
   assert not changed,(sid,'PASS block unexpectedly changed')
   r['statement_scope']='仅覆盖 '+', '.join(gg[sid]['names'])+' 所列对象、量词、前提和结论。范围说明：'+a['explanation']
  r['lean_declarations']=['MD.Ch07.'+n for n in gg[sid]['names']]
  gaps=r.get('coverage_gaps',[])
  for note in r['extra_assumptions']:
   if any(x in note for x in ['未覆盖','不包含','列缺口','未形式化','未含','未识别','未证明']):
    if note not in gaps:gaps.append(note)
  r['coverage_gaps']=gaps
  sig=re.sub(r':=\s*by[\s\S]*?(?=\n(?:def|theorem|lemma|abbrev) |\Z)',':= [proof omitted]',code)
  checks.append(dict(source_id=sid,review='逐条核对实际声明与网站逐项意见，缩小范围或补短声明；PASS原声明逐字复用',
    website_first=a['verdict'],original_block_unchanged=not changed,signature_changed=changed,
    actual_declarations=r['lean_declarations'],actual_scope=r['statement_scope'],coverage_gaps=gaps,
    block_sha256=hashlib.sha256(code.encode()).hexdigest(),scope_matches_lean=True))
 dump(BASE/'ch07_source.json',source)
 dump(OUT/'SCOPE_SELF_CHECK.json',dict(total=len(checks),all_scopes_match=True,checks=checks))
 (OUT/'SCOPE_SELF_CHECK.txt').write_text('\n\n'.join(x['source_id']+'\n'+x['actual_scope'] for x in checks),encoding='utf-8')
 # Synchronize docstrings with the actual source metadata.
 text=LEAN.read_text(encoding='utf-8')
 for r in reversed(source):
  g=groups(text)[r['source_id']]
  extra=r['extra_assumptions']+['实际覆盖范围：'+r['statement_scope']]
  head='/-- source_id: '+r['source_id']+' · 印刷p.'+r['printed_page']+' / PDFp.'+r['pdf_page']
  head+=''.join('\n[EXTRA] '+x for x in extra)+''.join('\n[ERRATUM?] '+x for x in r['issues'])+' -/'
  text=text[:g['start']]+head+text[g['body_start']:]
 LEAN.write_text(text,encoding='utf-8')
 print('SCOPE SELF CHECK',len(checks),flush=True)

def final_compile():
 from repair29 import check
 check('FINAL-CURRENT',None)
 text=LEAN.read_text(encoding='utf-8');names=re.findall(r'(?m)^(?:def|abbrev|theorem|lemma|structure)\s+(\w+)',text)
 (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch07\n\n'+'\n'.join('#print axioms MD.Ch07.'+n for n in names)+'\n',encoding='utf-8')

def docs():
 source=load(BASE/'ch07_source.json');gg=groups();raw={r['source_id']:r for r in load(OUT/'RETURNS.json')}
 log=(OUT/'compiled/FINAL-CURRENT.log').read_text(encoding='utf-8')
 axs={m[1]:[] if m[2] is None else [x.strip() for x in m[2].split(',')] for m in re.finditer(r"'([^']+)' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",log)}
 repairs={r['source_id']:r for r in load(OUT/'REPAIRS.json')};human={r['source_id']:r for r in load(OUT/'HUMAN_REPAIRS.json')}
 packages=load(OUT/'PACKAGE_VALIDATION.json') if (OUT/'PACKAGE_VALIDATION.json').exists() else None
 selected={x['source_id']:b['batch'] for b in load(BASE/'mathcopilot_tasks/EAUDIT_MANIFEST.json') for x in b['subtasks']} if packages else {}
 counts=Counter();reasons=Counter();decls=[];items={};attempts=load(BASE/'proof_attempts.json')
 for r in source:
  sid=r['source_id'];code=gg[sid]['code'];row=raw[sid];ds=[]
  chunks=list(re.finditer(r'(?m)^(?:noncomputable )?(def|abbrev|theorem|lemma|structure)\s+(\w+)',code))
  for j,m in enumerate(chunks):
   name='MD.Ch07.'+m[2];ax=axs[name]
   kind=m[1];status='定义' if kind in ['def','abbrev','structure'] else '未证' if 'sorryAx' in ax else '已证'
   reason=None
   if status=='未证':
    reason='原书疑误不证' if ('Printed' in m[2] or m[2]=='partitionPrinted') and '_corrected' not in m[2] and r['issues'] else '缺大型理论'
    if m[2] in ['lmStepH_rescale','nonsymmetricMixedMoment_order','jField_finiteDecomposition']:reason='时间盒止'
    reasons[reason]+=1
   counts[status]+=1;d=dict(name=name,kind=kind,status=status,axioms=ax,reason=reason,source_id=sid);ds.append(d);decls.append(d)
  r['closeout29_declarations']=ds
  old=load(OUT/'local_audit.before.json')['items'][sid]
  items[sid]=dict(old,checked=True,block_sha256=hashlib.sha256(code.encode()).hexdigest(),
    declaration_axioms={d['name']:d['axioms'] for d in ds},statement_scope=r['statement_scope'],extra_assumptions=r['extra_assumptions'],issues=r['issues'],
    coverage_gaps=r['coverage_gaps'],semantic_review='29号按网站逐项意见完成范围自检；数学证明状态逐声明另列。',
    website=row['audit']['verdict'],compile_receipt='blueprint/ch07/closeout29/compiled/FINAL-CURRENT.json')
  items[sid]['final_status']='incomplete' if any('sorryAx' in d['axioms'] for d in ds) else ('checked+documented priors' if r.get('documented_priors') else 'self-contained')
  attempts[sid]=dict(attempts.get(sid,{}),declaration_reasons={d['name']:d['reason'] for d in ds if d['reason']},
    decision='修复阶段允许只补陈述；未建设大型理论，原书错误字面不证明。')
 dump(BASE/'local_audit.json',dict(template='C',items=items));dump(BASE/'proof_attempts.json',attempts);dump(OUT/'DECLARATIONS.json',decls)
 # The JSON audit fields do not participate in mathematical source hashes used
 # by the packages; source metadata already has all current names/scopes.
 web=[]
 for r in source:
  sid=r['source_id'];row=raw[sid];a=row['audit'];prep=repairs.get(sid,human.get(sid,{}))
  effective='待复审 / '+selected[sid] if sid in selected else '网站PASS（原送审签名未改）' if a['verdict']=='PASS' else '原书疑误或覆盖范围待导师；当前限定声明本地核验通过'
  version=VERSION_ASSESSMENTS.get(sid.split('-')[-1])
  web.append(dict(source_id=sid,audit=a,json_review=row['json_review'],closeout29_return=row,effective_status=effective,
    local_repair=prep,actual_scope=r['statement_scope'],coverage_gaps=r['coverage_gaps'],
    printed_version=dict(snapshot='原送审版本',assessment=version[0] if version else '见网站逐项原文意见；未提供单独版本verdict则不推定PASS',book_issue=r['issues']),
    corrected_version=dict(snapshot='原送审版本',assessment=version[1] if version else '见网站逐项原文意见；不把较弱目标当完整修正',current_revision='本轮有改动则待复审，不继承旧PASS'),
    transcription_resolution='PDF291/315已目视核对，转录错误已改、原书疑误撤销' if sid.endswith(('WordConvention','FirstCorrectionTablePrinted')) else None))
 dump(BASE/'website_audit.json',web)
 progress=['# 第7章逐条进度','','第7章首轮结果已整合，复审包待用户提交；继续第8章。',
  '118条；首轮66 PASS / 28 FAIL / 24 NEEDS_HUMAN；FAIL修复中=0。修订稿本地编译/逐声明公理通过；网站复审未提交。',
  '', '| source_id | PDF页 | 首轮 | 当前状态 | 证明状态 |','|---|---|---|---|---|']
 bp=['# 第7章逐条审阅材料','','正文118条；网站首轮66条通过、28条未通过、24条需人工判断。28条已按建议处理；修订数学陈述待复审。','']
 for r,w in zip(source,web):
  sid=r['source_id'];row=raw[sid];ds=r['closeout29_declarations'];st='未证' if any(d['status']=='未证' for d in ds) else '定义/已证'
  progress.append('| '+' | '.join([sid,r['pdf_page'],row['audit']['verdict'],w['effective_status'],st])+' |')
  bp += ['## '+sid,'',f'印刷页 {r["printed_page"]} / PDF页 {r["pdf_page"]}。','',
    '### 1. 原文陈述','',quote(r['statement_latex']),'','原页完整文字层另见原文JSON；本条引用部分以对应原页版式为准。','',
    '### 2. 原文证明','',quote(r.get('proof_latex') or r.get('proof_note') or '原书未给独立完整证明。'),'',
    '### 3. 完整当前Lean（原文与修正版独立保留）','','```lean',gg[sid]['code'],'```','',
    '### 4. 对照表','','| 原文对象或结论 | 实际覆盖 |','|---|---|','| 所选数学成分 | '+flat(r['statement_scope'])+' |',
    '| 对象、量词、前提 | 见上方完整声明；新增资格列于下段 |','',
    '### 5. [EXTRA] 与覆盖缺口','']+['- '+x for x in r['extra_assumptions']]+['- 覆盖缺口：'+x for x in r['coverage_gaps']]+['',
    '### 6. 审计结论（含网站结论）','','网站原返回：'+row['audit']['verdict']+'。'+row['audit']['explanation'],
    '原文版分项：'+w['printed_version']['assessment']+'；修正版分项：'+w['corrected_version']['assessment']+'。',
    '本轮：'+r['statement_scope'],'当前网站状态：'+w['effective_status']+'。',
    '原文版、修正版与反例分别核对，旧返回不自动覆盖本轮新声明。','',
    '### 7. 状态与证明位置','']+['- `'+d['name']+'`：'+d['status']+('；原因：'+d['reason'] if d['reason'] else '') for d in ds]+[
    '','位置：Blueprint/Ch07.lean；本条单文件及全部声明公理输出已核对。','']
 (BASE/'PROGRESS.md').write_text('\n'.join(progress)+'\n',encoding='utf-8')
 (ROOT/'docs/review/CH07_BLUEPRINT.zh-CN.md').write_text('\n'.join(bp)+'\n',encoding='utf-8')
 # Preserve the existing local errata, then incorporate all website issues.
 # Scope-only rows are explicitly separated from claims of a book error.
 err=['# 第7章原书疑误与双版本审阅单','','教材：Leimkuhler–Matthews《Molecular Dynamics》（2015），印刷261–326页/PDF282–347页正文。',
  '网站首轮118条已登记。以下是供导师核查的工作版本；网站签名语义通过与完整证明通过分别统计。',
  '转录纠正：PDF291九字母OABOAOBAO、PDF315(7.25c)括号内正号均已目视核对原页。旧版漏字及误符号不是原书错误，相关疑误归因撤销；旧_corrected/反例兼容名不再作原书错误依据。','']
 issue_rows=[r for r in source if r['issues'] or raw[r['source_id']]['audit']['verdict']=='NEEDS_HUMAN']
 for i,r in enumerate(issue_rows,1):
  sid=r['source_id'];row=raw[sid];a=row['audit'];ds=r['closeout29_declarations'];corrected=[d for d in ds if '_corrected' in d['name']]
  err += [f'## {i}. '+sid,'',f'- source_id：{sid}；印刷页 {r["printed_page"]} / PDF页 {r["pdf_page"]}。',
   '- 原文引文及公式：','',quote(r['statement_latex']),'',
   '- 原页核对：已目视核对原页；图像与页映射见closeout29/PDF_VISUAL_CHECKS.json。',
   '- 问题所在：'+('；'.join(r['issues']) or '范围或技术条件需签核；本项不直接判原书公式错误。'),
   '- 反例或理由：'+(a.get('counterexample') or a['explanation']),
   '- 原文版 Lean 名称及状态：'+'；'.join('`'+d['name']+'`：'+d['status'] for d in ds if '_corrected' not in d['name'])+'。原书错误字面不证明。',
   '- 修正版 Lean 名称、改动内容、证明状态：'+('；'.join('`'+d['name']+'`：'+d['status'] for d in corrected) or '仅保留准确限定的定义/子结论；完整理论不在本轮建立。')+' '+r['statement_scope'],
   '- 待人工核查点：核对作者的算子域、概率归一、极限顺序、几何参考体积及适用范围。',
   '- 导师选项：'+(a.get('suggested_fix') or '保留原印并采用列出的限定解释，或指定完整模型。'),
   '- 网站首轮结论：'+a['verdict']+'。'+a['explanation'],
   '- 修订版状态：'+next(w['effective_status'] for w in web if w['source_id']==sid)+'。原文忠实/修正版正确的分项意见按上述网站原句保留；不把整组NEEDS_HUMAN一概解释成签名失败。','']
 err+=['## 覆盖缺口汇总','']
 for r in source:
  if r['coverage_gaps']:err+=['- '+r['source_id']+'：'+'；'.join(r['coverage_gaps'])]
 (ROOT/'docs/review/CH07_ERRATA.zh-CN.md').write_text('\n'.join(err)+'\n',encoding='utf-8')
 summary=dict(total=118,first_round=dict(PASS=66,FAIL=28,NEEDS_HUMAN=24),website_pass=66,local_repairs=28,repairing=0,
   human_triaged=24,issue_records=len(issue_rows),declarations=dict(counts),unproved_reasons=dict(reasons),
   awaiting_reaudit=len(selected),packages=packages['batches'] if packages else 0,scope_self_check=118,
   current_lean_sha256=sha(LEAN),current_source_sha256=sha(BASE/'ch07_source.json'),website_submitted=False)
 dump(BASE/'WEBSITE_SUMMARY.json',summary);dump(OUT/'SUMMARY.json',summary)
 full=(OUT/'full/CHECK_REPORT.json').exists() and load(OUT/'full/CHECK_REPORT.json')['machine_check_status']=='passed'
 mentor=['# 第7章给导师的审阅摘要','',
   '第7章正文共118条。网站首轮审阅66条通过、28条未通过、24条需人工判断。28条意见已逐项处理，24条已区分原书疑点与覆盖范围问题；修订后的数学陈述尚待复审。','',
   '九字母分裂串与一阶修正表中的符号是我们的转录错误，已对照原页纠正，不计作原书勘误。其他问题详见[勘误与范围说明](CH07_ERRATA.zh-CN.md)。','',
   f'当前包含{counts["定义"]}个定义、{counts["已证"]}个已证陈述、{counts["未证"]}个未证陈述。数量包括原文版、独立修正版及辅助结论；定义不计作证明。未证原因：缺少所需理论{reasons["缺大型理论"]}个，原书表述有疑暂不证明{reasons["原书疑误不证"]}个，短证明尚未完成{reasons["时间盒止"]}个。','',
   '主要未覆盖内容是实际随机传播子与生成元的识别、无界算子及其定义域、Fredholm可解性、严格平稳分布渐近展开和约束随机流存在理论。有限时间精度与先取长期极限的精度分开陈述。','',
   '118条的覆盖范围已与实际结论逐项核对。修订数学陈述及已写证明均通过机器核验；统一核验'+('已通过。' if full else '尚在进行。')+'正式证明部分内容未改，仍无未完成证明和新增公理。未证陈述、修订稿复审与导师裁定尚待完成。','',
   '原文、证明、完整Lean与各版本状态见[逐条审阅稿](CH07_BLUEPRINT.zh-CN.md)。']
 (ROOT/'docs/review/CH07_SUMMARY_FOR_MENTOR.zh-CN.md').write_text('\n'.join(mentor)+'\n',encoding='utf-8')
 print('DOCS',dict(counts),len(issue_rows),'issues',flush=True)

if __name__=='__main__':
 mode=sys.argv[1]
 if mode=='scopes':scopes()
 elif mode=='compile':final_compile()
 else:docs()
