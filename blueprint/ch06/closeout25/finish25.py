from common25 import *
from progress25 import main as progress
from local_stage import stage

def main():
 result=load(OUT/'DELIVERY_VALIDATION.json');assert result['status']=='PASS'
 report=load(OUT/'full/CHECK_REPORT.json');assert report['machine_check_status']=='passed'
 state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';text=state.read_text(encoding='utf-8')
 marker='# 25号：第6章网站首轮审校结果整合'
 text=text[text.index(marker):]
 header='''# 第6章首轮结果已整合，复审包待用户提交

25号完成：249条首轮返回已登记（179 PASS / 25 FAIL / 45 NEEDS_HUMAN）；25条FAIL按建议处理，修复中0；45条待人工项已分流。逐项单文件编译、最终321个声明的公理检查和一次完整check均通过。

CH06_BLUEPRINT、CH06_ERRATA、CH06_SUMMARY_FOR_MENTOR已更新；34项合并疑误/范围解释。123个定义、109个已证陈述、89个未证陈述分别记录；未证陈述没有当作已证明。

复审材料：blueprint/ch06/mathcopilot_tasks/EAUDIT01–20，共20包、60条，含1条下游最小接口适配；每包a/b/c各含MANIFEST.json、PASTE.txt、PAGES.pdf。索引为EAUDIT_INDEX.md。本轮未提交网站，不等待网站。

验收：blueprint/ch06/closeout25/DELIVERY_VALIDATION.json；最终单文件/公理证据FINAL_COMPILE.json、FINAL_COMPILE.log；完整check为full/CHECK_REPORT.json。正式库0 sorry/0 axiom；正式库与第1–5章冻结文件字节一致。

下一步：停止，复审包待用户合并提交。修改版复审、未证结论证明和导师裁定仍未完成，等待用户新指令；不进入第7章。heartbeat保留ACTIVE/15分钟/原target/去重，25号第6节完成后停止接续发送。

---

'''
 state.write_text(header+text,encoding='utf-8')
 log=ROOT/'docs/handoff/WORK_LOG.zh-CN.md'
 entry='''
## 2026-10-18 25号第6章首轮整合最终验收
249条返回哈希绑定通过（179 PASS/25 FAIL/45 NEEDS_HUMAN）；25条FAIL修复中0，45条已分流。OU根号范围与分部积分正号确认是转录错误，撤销错误原书疑误归因；PDF268的1/2已核回。
逐项单文件、公理检查及最终321声明检查通过，一次完整check通过。正式库0 sorry/0 axiom，正式库与第1–5章冻结文件字节一致；仅一处下游调用补U β γ，保留失败日志与最小差异。
三份第1章格式文档齐，34项合并疑误/范围解释；123定义/109已证/89未证。20个EAUDIT包、60条，全部哈希/定义摘录/页映射/附件预算通过；未提交网站，待用户合并提交。
本检查点随交付提交push。完成后停止，不进入第7章；修改版网站复审、未证陈述证明和导师裁定不冒称完成。
'''
 if '## 2026-10-18 25号第6章首轮整合最终验收' not in log.read_text(encoding='utf-8'):
  with log.open('a',encoding='utf-8') as f:f.write(entry)
 resume=ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md'
 old=resume.read_text(encoding='utf-8')
 if not old.startswith('# 25号已完成'):
  resume.write_text('# 25号已完成：停止等待用户提交第6章复审包\n\n先读CURRENT_STATE顶部和25号指令。20包/60条已生成；本轮不向网站提交，不进入第7章。除非用户给新指令，不继续证明或处理后续章节。\n\n---\n\n'+old,encoding='utf-8')
 running=load(OUT/'LEAN_SERVER_RUNNING.json');running['status']='completed_worker_stopped';dump(OUT/'LEAN_SERVER_RUNNING.json',running)
 progress()
 # Explicitly stage owned deliverables, leaving pre-existing unrelated work alone.
 paths=['AGENTS.md','Blueprint/Ch06.lean','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md']
 paths += [f'docs/review/CH06_{n}.zh-CN.md' for n in ['BLUEPRINT','ERRATA','SUMMARY_FOR_MENTOR','REVIEW_SHORT'] if (ROOT/f'docs/review/CH06_{n}.zh-CN.md').exists()]
 paths += [f'blueprint/ch06/{n}' for n in ['CheckAxioms.lean','PROGRESS.md','ch06_source.json','local_audit.json','proof_attempts.json','website_audit.json','WEBSITE_SUMMARY.json']]
 paths += [p.relative_to(ROOT).as_posix() for p in (BASE/'mathcopilot_results').glob('BATCH*_result.json')]
 paths += [p.relative_to(ROOT).as_posix() for p in (BASE/'mathcopilot_tasks').glob('EAUDIT*')]
 excluded={'ActiveCheck.lean','DRY_ALL_REPAIRS.lean','lean-server-stderr.log'}
 paths += [p.relative_to(ROOT).as_posix() for p in OUT.rglob('*') if p.is_file() and '__pycache__' not in p.parts and p.name not in excluded and not re.fullmatch(r'pdf259-raster-[\d.]+\.pdf',p.name)]
 stage(paths)
 print('STAGED owned deliverables',len(paths),flush=True)

if __name__=='__main__':main()
