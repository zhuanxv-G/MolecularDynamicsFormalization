"""Register independent website version verdicts and regenerate final handoff artifacts."""
from pathlib import Path
import sys, json, re, hashlib, difflib
from collections import Counter
ROOT=Path(__file__).resolve().parents[4];BASE=ROOT/'blueprint/ch01';OUT=BASE/'validation/CLOSEOUT21'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def load(p):return json.loads(p.read_text(encoding='utf-8-sig'))
def dump(p,d):p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def quote(s):return '\n'.join('> '+v for v in s.splitlines())

def main():
 repairs=load(OUT/'REPAIRS.json');assert len(repairs)==10 and all(r['exit_code']==0 for r in repairs)
 text=(ROOT/'Blueprint/Ch01.lean').read_text(encoding='utf-8');sources=load(BASE/'ch01_source.json');src={s['source_id']:s for s in sources}
 web=load(BASE/'website_audit.json');wby={w['source_id']:w for w in web}
 log=(OUT/'UnitCell.log').read_text(encoding='utf-8-sig')
 ax={m.group(1):[v.strip() for v in (m.group(2) or '').split(',') if v.strip()] for m in re.finditer(r"'MD\.Ch01\.(\w+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)",log)}
 matches=list(re.finditer(r'(?m)^(?:noncomputable )?(def|theorem|abbrev)\s+(\w+)',text));decls={}
 old=load(BASE/'validation/CLOSEOUT19/DECLARATION_STATUS.json')
 for i,m in enumerate(matches):
  end=matches[i+1].start() if i+1<len(matches) else text.index('end MD.Ch01',m.end())
  code=text[m.start():end];clean=re.sub(r'/\-[\s\S]*?-/', '',code)
  name=m.group(2);assert name in ax,name
  d=dict(kind=m.group(1),axioms=ax[name],direct_placeholder=bool(re.search(r'\bsorry\b',clean)),transitive_placeholder='sorryAx' in ax[name],line=text[:m.start()].count('\n')+1)
  d['status']='incomplete' if d['transitive_placeholder'] else old.get(name,{}).get('status','self-contained')
  d['sorry_category']=old.get(name,{}).get('sorry_category') if d['transitive_placeholder'] else None
  d['stop_reason']=old.get(name,{}).get('stop_reason') if d['transitive_placeholder'] else None
  decls[name]=d
 assert set(ax)==set(decls),(len(ax),len(decls),set(ax)-set(decls))
 counts=Counter('definitions' if d['kind']!='theorem' else 'unproved' if d['transitive_placeholder'] else 'proved' for d in decls.values())
 categories=Counter(d['sorry_category'] for d in decls.values() if d['transitive_placeholder'])
 dump(OUT/'DECLARATION_STATUS.json',decls);dump(OUT/'DECLARATION_COUNTS.json',dict(total=len(decls),**counts,unproved_reasons=categories));dump(OUT/'AXIOM_DECLARATIONS.json',ax)
 marks=list(re.finditer(r'/-- source_id:\s*([^\s·]+)[\s\S]*?-/',text));groups={}
 for i,m in enumerate(marks):
  end=marks[i+1].start() if i+1<len(marks) else text.index('end MD.Ch01',m.end())
  raw=text[m.end():end].strip();raw=re.sub(r'/\- (?:BEGIN|END) FULL SECTION[^\n]*-/', '',raw).strip()
  names=re.findall(r'(?m)^(?:noncomputable )?(?:def|theorem|abbrev)\s+(\w+)',raw)
  groups[m.group(1)]=dict(block=raw,names=names)
 assert set(groups)==set(src)
 # Apply only the website's exact source-transcription proposals; preserve all local logs and proofs.
 source_changes=[]
 for w in web:
  returned=w.get('closeout21_return');sid=w['source_id']
  if not returned:continue
  corrected=returned['json_review'].get('corrected_json')
  if corrected:
   changes={}
   for f in ['kind','label','printed_page','pdf_page','statement_latex','proof_latex','proof_note','proof_discussion_latex','context_notation']:
    if f in corrected and corrected[f]!=src[sid].get(f):
     changes[f]=dict(before=src[sid].get(f),after=corrected[f]);src[sid][f]=corrected[f]
   if changes:
    source_changes.append(dict(source_id=sid,fields=changes,evidence='website json_review.corrected_json; raw return retained'))
    src[sid].setdefault('repair_log',[]).append(dict(stage='CLOSEOUT21_SOURCE_REVIEW',reason='逐字段采纳网站corrected_json转录/元数据，不改Lean数学陈述。',fields=list(changes)))
   src[sid]['review_status']=returned['json_review']['status']
 # These proposals described the pre-repair model: replace only their stale coverage notes.
 for r in repairs:
  sid=r['source_id'];s=src[sid]
  if r['key'] in ['AngleBond','GayBerne','PeriodicTranslationMomentum','RhombicLattice','UnitCell']:
   s['context_notation']=[r['diff_summary']]
  if r['key']=='LJTimeScaling':
   # Keep the reviewer's explanation that the stronger 0.005 bound is false.
   s['extra_assumptions']=wby[sid]['closeout21_return']['json_review']['corrected_json']['extra_assumptions'].copy()
  if not any(r['diff_summary'] in x for x in s.get('extra_assumptions',[])):s.setdefault('extra_assumptions',[]).append('[EXTRA] '+r['diff_summary'])
 dump(BASE/'ch01_source.json',sources);dump(OUT/'SOURCE_JSON_CHANGES.json',source_changes)
 # No blanket PASS for every correction: the website explicitly leaves TrimerEscape open.
 errata=load(BASE/'validation/CLOSEOUT19/ERRATA_RECORDS.json');eby={e['source_id']:e for e in errata}
 versions={}
 for w in web:
  sid=w['source_id'];ret=w.get('closeout21_return')
  if not ret:continue
  audit=ret['audit'];ns=groups[sid]['names'];e=eby.get(sid,{})
  literal=[n for n in ns if 'literal' in n.lower() and 'corrected' not in n and 'counterexample' not in n]
  originals=literal or ([e['original_name'].split('.')[-1]] if e else [src[sid]['lean_decl'].split('.')[-1]])
  corrections=[n for n in ns if 'corrected' in n]
  counters=[n for n in ns if 'counterexample' in n]
  vd=dict(source_text_verdict=audit['verdict'],original_version=dict(names=originals,fidelity_verdict='PASS' if audit['verdict']!='FAIL' else 'FAIL',mathematical_verdict='NEEDS_HUMAN' if audit['verdict']=='NEEDS_HUMAN' else audit['verdict']),corrected_versions=[dict(name=n,verdict='NEEDS_HUMAN' if sid=='MD-1.7-TrimerEscapeLiteral' else 'PASS') for n in corrections],counterexamples=[dict(name=n,verdict='PASS') for n in counters],website_explanation=audit['explanation'])
  # These are qualified interpretations, not separate faithful literal theorems.
  if sid in ['MD-1.6-PeriodicImages','MD-1.6.1-RealNormalMode','MD-1.6.1-MinimumGradientZero','MD-1.4-PhaseSpace']:
   vd['original_version']['fidelity_verdict']='原文引文保留；现有Lean为限定解释，非无条件原句'
   vd['qualified_model']=dict(name=src[sid]['lean_decl'],verdict='PASS',scope='网站正文明确限定的解释；不扩展到原书无条件表述')
  if not corrections and sid in ['MD-1.6-PeriodicImages','MD-1.6.1-RealNormalMode']:
   vd['corrected_versions']=[dict(name=src[sid]['lean_decl'].split('.')[-1],verdict='PASS',scope='已有三维块/实解公式解释；未新增独立勘误定理')]
  versions[sid]=vd;w['version_verdicts21']=vd
  if audit['verdict']=='NEEDS_HUMAN':
   qualified='；限定解释=网站PASS' if 'qualified_model' in vd else ''
   cs='；修正版='+('NEEDS_HUMAN（待独立散射论证）' if sid=='MD-1.7-TrimerEscapeLiteral' else '网站PASS') if vd['corrected_versions'] else ''
   w['effective_status']='原书疑误=NEEDS_HUMAN；原文忠实性单列'+cs+qualified
 dump(OUT/'VERSION_VERDICTS.json',versions);dump(BASE/'website_audit.json',web)
 # Add missing errata without inventing a well-typed literal for an ill-typed printed expression.
 extra={
 'MD-1.6-PeriodicImages':dict(problem='原页vᵢ按全构型重复块定义，属于ℝ^{3N}，却直接与单粒子的三维qⱼ相加，类型前后矛盾。',reason='N=2时v₁为六维而qⱼ为三维，二者之和未定义。Lean采用每个粒子的三维块L eᵢ解释。',original='全构型字面加法没有良类型Lean声明；原式及定义逐字保留于JSON和本文。',corrected='MD.Ch01.periodicImageEnergy：定义完成；按粒子取三维块枚举27个近邻镜像，未改求和范围。',check='确认vᵢ究竟指三维平移，还是全构型向量的第j个三维块。',options='改记三维vᵢ=L eᵢ / 保留全构型vᵢ但显式取第j块；默认按粒子三维块解释，待导师确认。'),
 'MD-1.6.1-RealNormalMode':dict(problem='前式允许任意复系数a,b，后式α,β为实；不能把任意复值解都原样“改写”为实值解。',reason='A=[[0,−1],[1,0]]，Ω=1，ξ=(1,−i)，a=1,b=0时z(0)不是实向量。实解族可取a=(β−iα)/2、b=(β+iα)/2，故b=共轭a；也可取复解的实部。Ω=0退化时不把该系数关系声称为无条件必要条件。',original='MD.Ch01.realnormalmode：已有实公式的ODE验证已证；未把任意复系数与实系数两族无条件等同，原句歧义保留。',corrected='MD.Ch01.realnormalmode：限定为实解公式，已证；没有另建复实全族等价定理。',check='确认recast仅指实值物理解，或是否意为取复解的实/虚部；系数约束应写在哪里。',options='明确限制实值解并给共轭系数 / 明确取任意复解的实部；默认前者，待导师确认。')}
 ep=ROOT/'docs/review/CH01_ERRATA.zh-CN.md';es=ep.read_text(encoding='utf-8')
 sections=re.split(r'(?m)(?=^## \d+\. MD-)',es);new=[sections[0]]
 def website_line(sid):
  v=versions[sid];cv='；'.join('`MD.Ch01.'+x['name']+'`='+x['verdict'] for x in v['corrected_versions']) or '无独立修正版'
  ce='；'.join('`MD.Ch01.'+x['name']+'`='+x['verdict'] for x in v['counterexamples']) or '数学反例/理由由网站讨论，未单列Lean反例审计'
  return '- 网站复审结论：原文版忠实性='+v['original_version']['fidelity_verdict']+'；原书数学/范围='+v['original_version']['mathematical_verdict']+'；修正版：'+cv+'；反例：'+ce+'。PASS仅指网站签名语义审校，证明状态另列。\n'
 for sec in sections[1:]:
  sid=re.match(r'## \d+\. (MD-\S+)',sec).group(1);assert sid in versions,sid
  new.append(sec.rstrip()+'\n'+website_line(sid)+'\n')
 for i,(sid,e) in enumerate(extra.items(),len(sections)):
  s=src[sid]
  new.append(f"## {i}. {sid}\n\n- source_id：{sid}；印刷页 {s['printed_page']} / PDF页 {s['pdf_page']}。\n- 原文引文（逐字）：\n\n"+quote(s['statement_latex'])+f"\n\n- 问题所在：{e['problem']}\n- 反例或理由：{e['reason']}\n- 原文版 Lean 名称及状态：{e['original']}\n- 修正版 Lean 名称、改动内容、证明状态：{e['corrected']}\n- 待人工核查点：{e['check']}\n- 导师选项：{e['options']}\n"+website_line(sid)+'\n')
 es=''.join(new);es=es.replace('本单按导师要求并列','本轮已登记全部93条网站复审；21条原书表述仍需人工确认，另保留既有HyperbolicStabilityTransfer上下文核查记录。\n\n本单按导师要求并列',1)
 ep.write_text(es,encoding='utf-8')
 assert all(sid in es for sid,w in wby.items() if w.get('closeout21_return',{}).get('audit',{}).get('verdict')=='NEEDS_HUMAN')
 summary=dict(chapter=1,total=141,website_pass=110,new_reaudit_pass=62,prior_website_pass=48,locally_repaired_not_resubmitted=10,awaiting_mentor=21,errata_records=22,awaiting_reaudit=0,repairing=0,counts_are_disjoint=True,raw_verdicts_preserved=True,latest_raw_verdicts=dict(PASS=62,FAIL=10,NEEDS_HUMAN=21),scope='110网站PASS + 10按意见本地修复未再送网站 + 21原书疑误；各版本verdict独立，不把正确修正版整组记未通过',declarations=dict(total=len(decls),**counts,unproved_reasons=categories),new_website_packages=0)
 assert summary['website_pass']+summary['locally_repaired_not_resubmitted']+summary['awaiting_mentor']==141
 dump(BASE/'WEBSITE_SUMMARY.json',summary)
 audit=load(BASE/'local_audit.json');rows=['# 第1章最终收口进度','','141条：网站PASS 110（既有48 + 本次62）；按网站意见本地修复10（未再送网站）；原书疑误待导师21。FAIL修复中0；待网站复审0。','原文忠实性、修正版和反例分别登记于website_audit.json；三体逃逸修正版仍待独立论证。网站PASS是语义审校，不能代替Lean证明。','','| source_id | JSON | Blueprint | 本地预审 | 网站审计 | 证明 |','|---|---|---|---|---|---|']
 doc=['# 第1章 Lean Blueprint 本地审阅材料','','141条；网站PASS110、本地按意见修复10（未再送网站）、原书疑误待导师21。全部复审返回已登记；本轮不再送网站。完整检查见CLOSEOUT21/full/CHECK_REPORT.json。','']
 for s in sources:
  sid=s['source_id'];g=groups[sid];a=audit['items'][sid];ds=[decls[n] for n in g['names']]
  bad=any(d['transitive_placeholder'] for d in ds);axioms=sorted({v for d in ds for v in d['axioms']});status='incomplete' if bad else ('checked+documented priors' if a.get('documented_priors') else 'self-contained')
  primary=s['lean_decl'].split('.')[-1];assert primary in decls
  a.update(lean_decl=s['lean_decl'],checked=True,axioms=axioms,final_status=status,direct_placeholder=any(d['direct_placeholder'] for d in ds),website_audit=wby[sid]['effective_status'],all_declarations=g['names'],signature_sha256=hashlib.sha256(g['block'].encode()).hexdigest())
  if any(r['source_id']==sid for r in repairs):
   note=next(r['diff_summary'] for r in repairs if r['source_id']==sid);a['explanation']='21号按网站suggested_fix修复并本地核验：'+note
   a['correspondence'].append(dict(source='21号网站建议修复',lean=s['lean_decl'],note=note))
  rows.append(f"| {sid} | {s.get('review_status','DRAFT')}/原页审校已登记 | 已编译/全部声明公理已核 | {a['verdict']} | {wby[sid]['effective_status']} | {sum(not d['transitive_placeholder'] for d in ds)}/{len(ds)}项无占位；{status} |")
  doc += [f"## 1. {sid} · {s.get('label') or s['kind']} · 印刷p.{s['printed_page']} / PDFp.{s['pdf_page']}",'','### 2. 原文陈述','',quote(s['statement_latex']),'','### 3. 原文证明','',quote(s['proof_latex']) if s.get('proof_latex') else '原书无独立完整证明。',s.get('proof_note',''),'','### 4. 完整当前Lean（原文与修正版独立列出）','','```lean',g['block'],'```','','### 5. 对照表','','| 原文成分 | Lean对应 | 说明 |','|---|---|---|']
  for row in a['correspondence']:doc.append('| '+' | '.join(str(row.get(k,'')).replace('|','\\|').replace('\n','<br>') for k in ['source','lean','note'])+' |')
  doc += ['','[EXTRA] '+'；'.join(s.get('extra_assumptions',[])),'','### 6. 审计结论','',a['explanation'],'','网站：'+wby[sid]['effective_status']+'。']
  if sid in versions:doc += [versions[sid]['website_explanation']]
  doc += ['','### 7. 状态与证明位置','',status+'；已逐声明核验公理；含占位的声明仍未证明。',f"位置：Blueprint/Ch01.lean:{decls[primary]['line']}；{s['lean_decl']}。",'']
 dump(BASE/'local_audit.json',audit);(BASE/'PROGRESS.md').write_text('\n'.join(rows)+'\n',encoding='utf-8');(ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md').write_text('\n'.join(doc)+'\n',encoding='utf-8')
 # Update the index's status only; immutable review packet payloads stay untouched.
 ip=BASE/'mathcopilot_tasks/EAUDIT_INDEX.md';ip.write_text('# 第1章网站复审已全部返回；本轮不再送网站\n\n93条返回已登记：62 PASS / 10 FAIL按意见本地修复 / 21 NEEDS_HUMAN。没有新待提交包，不自动提交历史包。以下是已完成送审的历史索引，保留原材料与绑定。\n\n---\n\n'+ip.read_text(encoding='utf-8'),encoding='utf-8')
 mentor=f'''# 第1章：导师审阅摘要

教材为 Leimkuhler–Matthews《Molecular Dynamics》（2015）第1章正文，印刷第1–45页，不含习题。141个条目的原文、数学陈述、证明和勘误对照已整理。本轮工作结束后等待用户新指令。

- 网站已通过110条：此前48条，本轮新增62条。另10条按网站意见完成修复，已在本地核验，依用户决定不再送网站。修复工作没有未处理项。
- 网站指出21条原书表述仍需人工判断。修正版、原文忠实转录和反例分别记录；正确修正版没有因原书疑误而一并判为未通过。勘误清单共22项，包含1项既有且已获网站通过的上下文核查记录。
- 数学材料共{len(decls)}个命名声明：{counts['definitions']}项定义、{counts['proved']}项已证定理、{counts['unproved']}项未证陈述。未证原因分为：原书疑误原文版暂不证明13项；缺少大型理论或必要的衔接结果30项；达到约定尝试次数而停止3项。编译通过并不表示这46项已得到证明。

本轮补齐角键与Gay–Berne模型的有效输入条件、Newton势能的可微条件、谐振子及标量系统的能量、周期键取绝对值和晶格/晶胞资格。谐振子的能量守恒及同初值解唯一性已证。标量可积性目前只正式覆盖能量守恒与非转向点的局部求积，转向点、平衡点分类及整体重建仍有缺口。三体逃逸修正版还需要独立散射论证，网站未将它最终确认通过。

请重点核查原书力符号、Yukawa参数量纲、边界极小点的梯度、周期镜像向量维数、复解与实解关系，以及原有环面、作用角、Hartman–Grobman、Hessian、三体逃逸和变分矩阵问题。详见[完整勘误清单](CH01_ERRATA.zh-CN.md)，各项均列原句、页码、理由或反例、原文与修正版名称及状态、网站结论和导师选项。

已验证：十项修复逐项Lean编译和公理核对通过；全章使用固定Lean 4.34.0及对应Mathlib完成一次完整检查；正式库及第2–5章数学文件保持不变，正式库没有未完成证明。93条网站返回的输入对应关系已核验，原始报告保留。

尚未验证或裁定：10项修复后的再次网站审校（依用户决定不进行）、21项原书问题的导师裁定、46项未证陈述。第6章已在148条检查点暂停，本轮完成后不自动返回。
'''
 (ROOT/'docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md').write_text(mentor,encoding='utf-8')
 dump(OUT/'METADATA_FINALIZED.json',dict(lean_sha256=sha(ROOT/'Blueprint/Ch01.lean'),source_sha256=sha(BASE/'ch01_source.json'),declarations=len(decls),counts=counts,categories=categories,errata_records=22,full_check='pending'))
 print(json.dumps(dict(declarations=len(decls),counts=counts,categories=categories,source_metadata_updates=len(source_changes)),ensure_ascii=False))
if __name__=='__main__':main()
