"""Generate the chapter-1-style review package from current source and compiler evidence."""
from common import *
from collections import Counter,defaultdict
from errata_apply import candidates

DECL=re.compile(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(theorem|lemma|def|abbrev)\s+(\w+)')
LOCAL_EXCERPTS={4:{'MD-4.2.1-FastVerlet','MD-4.3.5.1-ConstrainedComposition'},
 5:{'MD-5.2.2-DivergenceCoordinates','MD-5.2.2-LiouvilleProduct'}}
MERGES={2:[['VariationalPrinted','HamiltonVariationalPrinted','HamiltonSymplectic'],
 ['GlobalGroupPrinted','SymplecticInverse','Adjoint'],['TIForce','TIOrder','TIPotential']],
 3:[['BCHHamiltonianMatching','LeadingShadowHamiltonian'],['VerletModifiedHamiltonian','VerletModifiedMatching'],
 ['FlowReversal','FlowReversalIdentity','ReversedTrajectoryPrinted','ReversedTrajectory'],
 ['DifferentLogsCommute','ModifiedEven'],
 ['Thm3.1','TruncatedConservation','EnergyTelescoping','UniformTruncatedLipschitz','PhysicalEnergyDrift'],
 ['PartitionedAffine','PartitionedAffinePrinted','RKAffine'],
 ['FreeHardSphereHamiltonian','HardCorePotential']],
 4:[['SymplecticEulerBoundaryPrinted','VerletBoundaryPrinted','VerletStability','SymplecticEulerStability','SymplecticEulerUnitRoots'],
 ['ActualMidpointRelation','PrintedImplicitRelation'],['PrintedModifiedFrequency','ImplicitModulus'],
 ['ResonanceEigenPrinted','ResonanceTaylor'],['ResonanceGrowth','ResonanceLinearRate'],
 ['FrozenGramPrinted','FrozenNewtonConstraint'],
 ['PositionEulerForceConvention','GramProjectedEuler','ProjectedEulerRelation','ConstrainedOrders'],
 ['ComponentPrinted','ComponentSweep'],['AxisFlowFormal','ExactPlanarRotation'],['PrincipalAxisField','SecondAxisPrinted','ThirdAxisPrinted'],
 ['DLMMassOnly','DLMPrinted','DLMPrintedSystem','DLMPrintedSystemStructure','DLMStructureFormal']],
 5:[['DomainL2','L2Complete','L2Norm'],['HarmonicPartition','HarmonicQuadraturePrinted'],
 ['ShellWeakPrinted','ShellWeakLimitCorrected'],['TwoOscillatorTori','TwoOscillatorEnergyDecomposition'],
 ['CorrelationTimePrinted','CorrelationTimeAE'],
 ['MixingCorrelation','MixingCorrelationPrinted'],['BackwardEulerLimit','EulerInvariant'],
 ['ForwardComponentsPrinted','ForwardNormDivergence'],['SymplecticEulerEllipse','SymplecticEulerShadow']]}

def chunks(code):
 ms=list(DECL.finditer(code));return [dict(kind=m.group(1),name=m.group(2),
  code=code[m.start():ms[i+1].start() if i+1<len(ms) else len(code)].strip()) for i,m in enumerate(ms)]
def q(s):return '\n'.join('> '+l for l in str(s).splitlines())
def flat(s):return str(s).replace('|','\\|').replace('\n',' ')
def human(v):
 if isinstance(v,str):return v
 if isinstance(v,list):return '；'.join(human(x) for x in v)
 if isinstance(v,dict):return '；'.join(str(k)+'：'+human(x) for k,x in v.items())
 return str(v)
def source_issues(w):
 j=w.get('closeout24_return',{}).get('json_review',{})
 return human(j.get('issues',[]))
def item_audit(w):return w.get('closeout24_return',{}).get('audit',w.get('audit',{}))
def audit_log(ch):
 dest=OUT/f'ch{ch:02}'
 rs=[]
 for p in dest.glob('*.json'):
  try:r=load(p)
  except Exception:continue
  if isinstance(r,dict) and r.get('exit_code')==0 and r.get('input_sha256')==sha(lean(ch)):
   log=p.with_suffix('.log')
   if log.exists() and sha(log)==r.get('log_sha256'):rs.append((p.stat().st_mtime,log,r))
 assert rs,'No passing compiler receipt for current chapter'
 return max(rs,key=lambda x:x[0])[1]

def finalise(ch):
 b=base(ch);dest=OUT/f'ch{ch:02}';gg=groups(ch)
 source=load(b/f'ch{ch:02}_source.json');src={s['source_id']:s for s in source}
 web=load(b/'website_audit.json');ww={w['source_id']:w for w in web}
 local=load(b/'local_audit.json');oldlocal=load(dest/'local_audit.before.json')
 corrections=load(dest/'CORRECTIONS.json');cc={c['source_id']:c for c in corrections}
 assert set(cc)=={c['source_id'] for c in candidates(ch)},'errata records missing'
 reps=load(dest/'REPAIRS.json');assert len(reps)=={2:4,3:10,4:7,5:6}[ch] and all(r['exit_code']==0 for r in reps)
 if (dest/'LOCAL_ADJUSTMENTS.json').exists():
  adjustments=load(dest/'LOCAL_ADJUSTMENTS.json')
  for r in reps:
   r['local_adjustment_file']=(dest/'LOCAL_ADJUSTMENTS.json').relative_to(ROOT).as_posix()
   r['local_adjustment_note']='本文件保留首次编译诊断后的最小变更diff；主diff与本记录合读，最终证明状态以通过收据为准。'
   ww[r['source_id']]['local_repair24']=r
  dump(dest/'REPAIRS.json',reps)
 log=audit_log(ch);logtext=log.read_text(encoding='utf-8-sig')
 full=load(dest/'full/CHECK_REPORT.json')
 assert full['machine_check_status']=='passed','full check not passed'
 if ch==2:
  assert next(x['sha256'] for x in full['inputs'] if x['relative_path'].lower()=='blueprint/ch02.lean')==sha(lean(ch))
 else:
  assert load(dest/'CHECK_INPUT.json')['current_lean_sha256']==sha(lean(ch))
 ax={}
 for m in re.finditer(r"'([^']+)' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",logtext):
  name=m.group(1).split(f'MD.Ch{ch:02}.')[-1];ax[name]=[a.strip() for a in (m.group(2) or '').split(',') if a.strip()]
 all_names=[n for g in gg.values() for n in g['names']]
 assert len(all_names)==len(set(all_names)), 'duplicate declaration names'
 assert set(all_names)<=set(ax),(ch,set(all_names)-set(ax))
 if ch in LOCAL_EXCERPTS:
  excerpts=load(dest/'LOCAL_EXCERPT_CHECKS.json')
  for sid,e in excerpts.items():
   e['current_group']=gg[sid]['code'];e['current_lean_sha256']=sha(lean(ch))
   if sid=='MD-4.2.1-FastVerlet':
    assert 'sorryAx' not in ax['fastVerlet_kick_drift_kick']
    e['proof_verified']=True;e['axioms']=ax['fastVerlet_kick_drift_kick'];e['axiom_log']=log.relative_to(ROOT).as_posix()
  dump(dest/'LOCAL_EXCERPT_CHECKS.json',excerpts)
 # The original source-version website verdicts stay intact. New corrections are never called website PASS.
 decls=[];counts=Counter();reasons=Counter()
 attempts=load(b/'proof_attempts.json') if (b/'proof_attempts.json').exists() else {'items':{}}
 for s in source:
  sid=s['source_id'];g=gg[sid];row=[];c=cc.get(sid,{});original=set(c.get('original_names',[]))
  prior=oldlocal['items'].get(sid,{})
  for d in chunks(g['code']):
   n=d['name'];a=ax[n];unproved='sorryAx' in a
   status='未证' if unproved else ('定义' if d['kind'] in ['def','abbrev'] else '已证')
   reason=None
   if status=='未证':
    if n in original and (('Printed' in n or 'Literal' in n or 'printed' in n) or sid in cc):reason='原书疑误不证'
    elif n in c.get('corrected_names',[]) and 'first\n  | rfl' in d['code']:reason='时间盒止'
    elif any(x.get('result')=='FAIL' for x in attempts.get('items',{}).get(sid,[])) and len([x for x in attempts['items'][sid] if x.get('result')=='FAIL'])>=3:reason='时间盒止'
    else:reason='缺大型理论'
    reasons[reason]+=1
   counts[status]+=1
   row.append(dict(name=f'MD.Ch{ch:02}.{n}',kind=d['kind'],status=status,axioms=a,
    unproved_reason=reason,direct_placeholder=bool(re.search(r'\bsorry\b',d['code'])),
    source_id=sid,corrected=n in c.get('corrected_names',[]) or '_corrected' in n))
  decls.extend(row)
  if c:
   corrected_chunks=[p for p in chunks(g['code']) if p['name'] in c.get('corrected_names',[])]
   if corrected_chunks and all(p['kind'] in ['def','abbrev'] for p in corrected_chunks):
    c['proof_routes']=['定义对象已完成；无定理证明义务，不虚构证明尝试。']
   elif any('first\n  | rfl' in p['code'] for p in corrected_chunks):
    c['bridge_lookup']='先核对既有无占位桥接；未找到可直接使用的完整证明。'
    c['proof_routes']=['直接反身性rfl','现有假设assumption','仅基础化简simp only；未解决者明确保留未证']
   elif corrected_chunks and c.get('added'):
    c['proof_routes']=['复用既有完整证明或直接给出短证明；逐声明依赖检查决定已证/未证，不把定义算定理。']
   s['closeout24_erratum']=c
   if s.get('statement_scope')=='本条所引原句及展示公式；单个记号归入context_notation。':
    s['statement_scope']='保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。'
  w=ww[sid]
  if sid in LOCAL_EXCERPTS.get(ch,set()):
   w['effective_status']='本地核验通过（网站因摘录缺失未判）'
   w['local_excerpt24']=load(dest/'LOCAL_EXCERPT_CHECKS.json')[sid]
   s['closeout24_local_excerpt']=w['local_excerpt24']
  elif sid in cc and w.get('effective_status')!='按网站审校意见修复，本地核验通过（未再送网站）':
   w['effective_status']='原书疑误/资格待导师；原文与修正版并列'
  w['closeout24_versions']=dict(
   submitted_signature=dict(website_verdict=item_audit(w).get('verdict'),
    declarations=item_audit(w).get('lean_decl'),explanation=item_audit(w).get('explanation'),
    scope='原返回审查的既有声明，可能为忠实原文、限定解释或早已存在的修正版；不能把其PASS扩展到原书疑误或本轮新版本。'),
   original=dict(declarations=c.get('original_names',[d['name'] for d in row if not d['corrected']]),
    source_json_verdict=w.get('closeout24_return',{}).get('json_review',{}).get('status'),
    website_verdict=item_audit(w).get('verdict'),verdict_scope='原返回整体判定，不拆造逐声明网站判定',
    proof_statuses=[d for d in row if not d['corrected']]),
   corrected=dict(declarations=[d['name'] for d in row if d['corrected']],
    website_verdict=None,website_status='新增或修改版本未再送网站',proof_statuses=[d for d in row if d['corrected']]),
   book_issue=dict(recorded=sid in cc,note=c.get('note'),website_status='原书疑误/资格待人工' if sid in cc else None,mentor_status='待导师裁定' if sid in cc else '无新增原书疑误'),
   counterexample=dict(text=item_audit(w).get('counterexample'),website_verdict=None,
    website_status='仅返回正文讨论，未单列独立判定',
    local_declarations=[d for d in row if 'counterexample' in d['name'].lower()]))
  s['all_current_lean_declarations']=[d['name'] for d in row]
  s['closeout24_declaration_statuses']=row
  la=local['items'].setdefault(sid,{})
  la['closeout24_previous_local_review']=prior
  la['checked']=True;la['axioms']=sorted({a for d in row for a in d['axioms']})
  la['final_status']='incomplete' if any(d['status']=='未证' for d in row) else ('self-contained' if not la.get('documented_priors') else 'checked+documented priors')
  la['direct_placeholder']=any(d['direct_placeholder'] for d in row)
  la['proof_status']='incomplete' if any(d['status']=='未证' for d in row) else ('definition' if all(d['status']=='定义' for d in row) else 'proved')
  la['closeout24_declarations']=row;la['axiom_log']=log.relative_to(ROOT).as_posix()
  la['block_sha256']=hashlib.sha256(g['code'].encode()).hexdigest()
  la['signature_sha256']=hashlib.sha256('\n\n'.join(re.split(r'\s*:=\s*by\b',p['code'],maxsplit=1)[0] for p in chunks(g['code'])).encode()).hexdigest()
  la['website_audit']=w['effective_status']
  if sid in cc:
   history=attempts.setdefault('items',{}).setdefault(sid,[])
   history[:]=[x for x in history if x.get('stage')!='CLOSEOUT24_CORRECTED']
   history.append(dict(stage='CLOSEOUT24_CORRECTED',
    routes=c['proof_routes'],evidence=log.relative_to(ROOT).as_posix(),declarations=[d for d in row if d['corrected']],
    result='依当前逐声明公理结果分别记已证或未证；原有疑误字面版不证明'))
 dump(b/'website_audit.json',web);dump(b/'local_audit.json',local);dump(b/'proof_attempts.json',attempts)
 dump(dest/'CORRECTIONS.json',corrections)
 dump(b/f'ch{ch:02}_source.json',source);dump(dest/'DECLARATIONS.json',decls)
 ids=[c['source_id'] for c in candidates(ch)];issue_groups=[];assigned=set()
 for keys in MERGES.get(ch,[]):
  members=[sid for sid in ids if sid.split('-')[-1] in keys]
  if members:issue_groups.append(members);assigned.update(members)
 issue_groups += [[sid] for sid in ids if sid not in assigned]
 issue_groups.sort(key=lambda members:min(list(src).index(sid) for sid in members))
 err=[]
 err+= [f'# 第{ch}章原书疑误与双版本审阅单','',
  '教材：B. Leimkuhler 与 C. Matthews，Molecular Dynamics: With Deterministic and Stochastic Numerical Methods，Springer，2015。',
  '页码采用原PDF从1起算的物理页。以下为工作勘误及资格补充，尚未经导师或作者裁定。定义、原有正确的数学子句和原书字面疑误分别保留；编译通过不表示未证命题已经成立。',
  '原文引文沿用已逐页核对的来源记录；本轮网站返回保留其原有版本及判定。原有声明可能已经是限定解释或修正版，须按网站正文确定PASS的对象；本轮新增或修改版本均未再次送网站。',
  f'共{len(issue_groups)}项问题，涉及{len(ids)}个source_id。同一问题的多条来源已合并；各来源原文、版本和网站判定仍分别列出。','']
 issue_manifest=[]
 for i,members in enumerate(issue_groups,1):
  err += [f'## {i}. '+ ' / '.join(members),'',f'- source_id：'+ '；'.join(members)+'。']
  for sid in members:
   s=src[sid];w=ww[sid];a=item_audit(w);c=cc[sid]
   err += ['',f'### {sid}', '',f'- 印刷页 / PDF页：{s["printed_page"]} / {s["pdf_page"]}。',
    '- 原文引文（逐字）：','',q(s['statement_latex']),'',
    '- 问题所在：'+(a.get('explanation') or '原有待导师问题；见下列资格与选项。')+' 网站原文审校另记：'+source_issues(w),
    '- 反例或理由：'+human(a.get('counterexample') or source_issues(w) or '未单列反例；问题在原文省略资格、术语、证明步骤或覆盖范围。请结合原句及下列修正核查。'),
    '- 原文版 Lean 名称及状态（含该来源原已存在的限定解释/修正版，具体角色依原返回正文）：'+ '；'.join(f'`MD.Ch{ch:02}.{n}`（'+next((d['status'] for d in decls if d['name']==f'MD.Ch{ch:02}.{n}'),'见同组')+'）' for n in c['original_names'])+'。原书有疑的字面断言不证明；原有正确数学子句或定义不作撤回。',
    '- 修正版 Lean 名称、改动内容、证明状态：'+c['note']+'；'+('；'.join(f'`MD.Ch{ch:02}.{n}`（'+next((d['status'] for d in decls if d['name']==f'MD.Ch{ch:02}.{n}'),'见同组')+'）' for n in c['corrected_names']) or '本条仅独立登记原书维数解释；一般环境零测修正版见同组 lowerDimensionNull_ambient。')+'。',
    '- 待人工核查点：请核对原句上下文是否已给所缺资格，确认反例的对象与量词；逐项核对“'+c['note']+'”。',
    '- 导师选项：'+(a.get('suggested_fix') or '保留原文并注明范围 / 接受独立限定修正版。')+' 默认仅采用本文并列的限定修正版，原书解释仍待确认。',
    '- 网站复审结论：原文转录栏状态='+str(w.get('closeout24_return',{}).get('json_review',{}).get('status',w.get('json_review',{}).get('status','既有返回')))+'；原文版、旧限定解释或既有修正版的所交签名整体 verdict='+str(a.get('verdict','未单列'))+'；该判定的声明为 '+flat(a.get('lean_decl',w.get('audit',{}).get('lean_decl','见原返回')))+'。原书疑误/资格：待人工，不能因所交限定或修正版PASS而撤回问题；本轮新增或修改 `_corrected`：未再送网站，无网站 verdict；既有修正版按本行所指声明及各自source_id保留原判定。反例：'+('返回正文已讨论，未单列独立 verdict。' if a.get('counterexample') else '未单列网站 verdict。')+' 网站语义审校与本地证明状态分别记录。','']
  issue_manifest.append(dict(number=i,source_ids=members))
 (ROOT/f'docs/review/CH{ch:02}_ERRATA.zh-CN.md').write_text('\n'.join(err)+'\n',encoding='utf-8')
 dump(dest/'ERRATA_INDEX.json',issue_manifest)
 oldweb=load(dest/'website_audit.before.json');oldpass=sum('网站PASS' in w['effective_status'] for w in oldweb)
 rc=Counter(r['audit']['verdict'] for r in load(dest/'RETURNS.json'))
 summary=dict(chapter=ch,total=len(source),website_pass=oldpass+rc['PASS'],historical_pass=oldpass,
  closeout24_returns=dict(rc),local_repairs=len(reps),repairing=0,awaiting_reaudit=0,
  local_excerpt_verified=len(LOCAL_EXCERPTS.get(ch,set())),errata=len(issue_groups),errata_source_ids=len(ids),
  awaiting_mentor=len(ids),declarations=dict(counts),unproved_reasons=dict(reasons),
  current_lean_sha256=sha(lean(ch)),axiom_log=log.relative_to(ROOT).as_posix(),
  full_check=f'blueprint/closeout24/ch{ch:02}/full/CHECK_REPORT.json',
  website_scope_note='网站PASS数字对应收到返回的审校版本；新增声明及本轮修改未再次送网站。')
 dump(b/'WEBSITE_SUMMARY.json',summary);dump(dest/'SUMMARY.json',summary)
 mentor=[f'# 第{ch}章给导师的审阅摘要','',
  f'本章正文共整理{len(source)}条。网站复审结果已全部登记，{len(reps)}条未通过意见已按建议修复，并通过本地编译及逐声明检查；修复后未再次送网站。原书疑误仍待导师裁定。','',
  '| 项目 | 数量 |','|---|---:|',f'| 网站PASS（含此前已通过版本） | {summary["website_pass"]} |',
  f'| 本轮网站PASS / FAIL / 待人工 | {rc["PASS"]} / {rc["FAIL"]} / {rc["NEEDS_HUMAN"]} |',
  f'| 按网站意见修复并本地核验 | {len(reps)} |',f'| 合并后的原书疑误或资格问题 | {len(issue_groups)} |',
  f'| 定义 / 已证声明 / 未证声明 | {counts["定义"]} / {counts["已证"]} / {counts["未证"]} |','',
  '声明数包括同条中的辅助结论、原文版和修正版；定义单独统计。网站PASS表示对所交版本的语义审校通过，不代表该声明已经证明，新增修正版也不沿用原版本的通过判定。','',
  '未证声明按原因分为：'+ '；'.join(f'{k}{reasons[k]}条' for k in ['缺大型理论','原书疑误不证','时间盒止'])+'。大型理论包括所需的ODE/Taylor误差、几何结构或测度极限等桥接；时间盒止表示现有短证明路线未能解决。','',
  f'原文、问题、反例或理由、两个版本及待裁定选项见[第{ch}章勘误清单](CH{ch:02}_ERRATA.zh-CN.md)；逐条完整Lean及原文证明见[完整审阅稿](CH{ch:02}_BLUEPRINT.zh-CN.md)。','',
  '已验证：网站返回与输入的对应关系、单文件编译、逐声明依赖检查及本章一次完整工程检查。正式库保持无未完成证明、无新增公理，内容未改。尚未验证：未证声明的数学证明、新增与修改版本的网站复审，以及导师对勘误选项的认可。']
 (ROOT/f'docs/review/CH{ch:02}_SUMMARY_FOR_MENTOR.zh-CN.md').write_text('\n'.join(mentor)+'\n',encoding='utf-8')
 bp=[f'# 第{ch}章 Lean Blueprint 本地审阅材料','',
  f'{len(source)}条；网站PASS {summary["website_pass"]}，本地按意见修复{len(reps)}条（未再送网站），合并勘误{len(issue_groups)}项。',
  f'统计与证明状态见[导师摘要](CH{ch:02}_SUMMARY_FOR_MENTOR.zh-CN.md)，原书问题见[勘误清单](CH{ch:02}_ERRATA.zh-CN.md)。网站原返回与本地修复结论分开保留；完整检查证据：{summary["full_check"]}。','']
 for s in source:
  sid=s['source_id'];g=gg[sid];c=cc.get(sid,{});w=ww[sid];la=local['items'][sid]
  ds=[d for d in decls if d['source_id']==sid];parts=chunks(g['code']);corrected=set(c.get('corrected_names',[]))|{p['name'] for p in parts if '_corrected' in p['name']}
  bp += [f'## 1. {sid} · {s.get("label") or s["kind"]} · 印刷p.{s["printed_page"]} / PDFp.{s["pdf_page"]}','',
   '### 2. 原文陈述','']
  if sid=='MD-5.2.2-LieCoordinates':bp += ['本条等式为从原页内积公式提炼的坐标辅助表达，并非原页独立展示式；完整原文时间PDE见MD-5.2.2-LiouvilleProductCoordinates。','']
  bp += [q(s['statement_latex']),'','### 3. 原文证明','']
  if s.get('proof_latex'):bp += [q(s['proof_latex'])]
  else:bp += ['原书无独立完整证明。']
  if s.get('proof_discussion_latex'):bp += [q(s['proof_discussion_latex'])]
  if s.get('proof_note'):bp += [s['proof_note']]
  bp += ['','### 4. 完整当前Lean（原文与修正版独立列出）','',
   '原文版、既有数学解释及同组辅助声明：','','```lean','\n\n'.join(p['code'] for p in parts if p['name'] not in corrected),'```','']
  if corrected:bp += ['独立修正版：','','```lean','\n\n'.join(p['code'] for p in parts if p['name'] in corrected),'```','']
  bp += ['### 5. 对照表','','| 原文成分 | Lean对应 | 说明 |','|---|---|---|',
   '| 当前覆盖范围 | '+flat(s.get('statement_scope','见原文'))+' | 仅承诺明确列出的数学内容 |',
   '| 对象、量词、假设和定义/结论 | '+ '；'.join('`'+d['name']+'`' for d in ds)+' | 完整代码见第4段；两个版本独立列出 |']
  for x in s.get('extra_assumptions',[]):bp += ['| 技术资格或版本解释 | '+flat(x)+' | [EXTRA] |']
  for x in s.get('coverage_gaps',[]):bp += ['| 尚未覆盖的结论 | '+flat(x)+' | 覆盖缺口，未声称已证明 |']
  bp += ['','[EXTRA] '+('；'.join(s.get('extra_assumptions',[])) or '无新增技术资格。'),'',
   '### 6. 审计结论','',
   ('本轮修复：'+w['local_repair24']['diff_summary'] if 'local_repair24' in w else '本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。'),
   '', '网站：'+w['effective_status']+'。',
   '网站原返回（对应其审校版本）：'+str(item_audit(w).get('verdict','未单列'))+'；'+(item_audit(w).get('explanation') or '详见保留的原返回。'),
   '', '### 7. 状态与证明位置','',
   la['final_status']+'；'+ '；'.join('`'+d['name']+'`：'+d['status']+('（'+d['unproved_reason']+'）' if d['unproved_reason'] else '') for d in ds)+'。',
   f'位置：[Blueprint/Ch{ch:02}.lean](../../Blueprint/Ch{ch:02}.lean#L{g["line"]})；逐声明核验：{log.relative_to(ROOT).as_posix()}。','']
 (ROOT/f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md').write_text('\n'.join(bp)+'\n',encoding='utf-8')
 progress=[f'# 第{ch}章24号最终收口记录','',
  f'{len(source)}条；网站PASS {summary["website_pass"]} / 本地按意见修复{len(reps)} / 原书疑误相关{len(ids)}条（合并{len(issue_groups)}项） / 摘录问题本地核验{summary["local_excerpt_verified"]} / 修复中0。',
  f'本轮返回：PASS {rc["PASS"]} / FAIL {rc["FAIL"]} / NEEDS_HUMAN {rc["NEEDS_HUMAN"]}。所有原始判定保留；未再送网站，不生成新EAUDIT包。签名PASS与原书疑误可以重叠，不把上述数字作互斥分类。',
  f'当前完整审阅稿、勘误及摘要：docs/review/CH{ch:02}_{{BLUEPRINT,ERRATA,SUMMARY_FOR_MENTOR}}.zh-CN.md。',
  f'单文件与逐声明检查：{log.relative_to(ROOT).as_posix()}；完整check：{summary["full_check"]}。','',
  '| source_id | 原文审校 | 网站/本轮处理状态 | 本地证明状态 | 复审批次 |','|---|---|---|---|---|']
 for s in source:
  sid=s['source_id'];w=ww[sid]
  progress.append('| '+ ' | '.join([sid,str(s.get('review_status','')),flat(w['effective_status']),local['items'][sid]['final_status'],str(w.get('closeout24_binding',{}).get('batch','既有返回'))])+' |')
 (b/'PROGRESS.md').write_text('\n'.join(progress)+'\n',encoding='utf-8')
 short=ROOT/f'docs/review/CH{ch:02}_REVIEW_SHORT.zh-CN.md'
 if short.exists():
  ss=short.read_text(encoding='utf-8-sig');prefix=f'> 已过时，以 [CH{ch:02}_SUMMARY_FOR_MENTOR.zh-CN.md](CH{ch:02}_SUMMARY_FOR_MENTOR.zh-CN.md) 为准。\n\n'
  if not ss.startswith(prefix):short.write_text(prefix+ss,encoding='utf-8')
 print(json.dumps(summary,ensure_ascii=False,indent=2))
if __name__=='__main__':finalise(int(sys.argv[1]))
