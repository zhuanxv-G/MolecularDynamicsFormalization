from common26 import *
from local_stage import stage
def main():
 result=load(OUT/'DELIVERY_VALIDATION.json');assert result['status']=='PASS'
 assert load(OUT/'full/CHECK_REPORT.json')['machine_check_status']=='passed'
 summary=load(BASE/'WEBSITE_SUMMARY.json');assert summary['full_check_status']=='passed'
 state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';text=state.read_text(encoding='utf-8');text=text[text.index('# 26号：'):]
 text=text.replace('当前进度：8项修复的单文件与324个声明公理检查全部通过；唯一一次完整check运行中。最新网站直接PASS203条，22个需人工条目中的正确版本分别登记；提交push尚未完成。','当前进度：26号本地及文档总验收PASS；随本终态提交push后停止，不再送网站，不进入第7章。',1)
 header='''# 第6章最终收口完成，等待用户新指令

26号验收：60条复审已核验输入绑定（25 PASS / 8 FAIL / 27 NEEDS_HUMAN）；8项按网站建议处理，修复中0。逐项单文件编译、全部324声明的#print axioms及一次完整check通过。正式库298个Lean文件0 sorry、0 axiom；正式库和第1–5章冻结字节一致。

最新网站直接PASS203条；复审27个NEEDS_HUMAN组中22组的正确版本另行保留PASS。原网站FAIL和suggested_fix原文、逐条diff摘要完整保存；八项当前修改状态为“按网站审校意见修复，本地核验通过（未再送网站）”。未再送网站，未生成新EAUDIT包，旧包保留。

CH06_ERRATA、CH06_BLUEPRINT、CH06_SUMMARY_FOR_MENTOR已更新：32项合并原书疑误/论证或范围待核问题，另1项解释记录；123定义、110已证、91未证。未证原因21项原书疑误不证、52项缺大型理论或必要衔接、18项时间盒止；两条新增L²短陈述按许可保留待证。

证据：blueprint/ch06/closeout26/DELIVERY_VALIDATION.json、FINAL_COMPILE.json/.log、full/CHECK_REPORT.json。原页PDF265/273/276/279本轮目视核过，转录纠正与原书疑误分别记录。

本终态和日志随交付提交推送后停止，Git实际提交与origin一致性由终验命令确认。导师裁定及91项完整证明尚未完成；八项本地修改不作再次网站审校。heartbeat保留ACTIVE/15分钟/原target/去重，26号第5节完成后停发；自动额度恢复续接未端到端实测。

---

'''
 state.write_text(header+text,encoding='utf-8')
 p=ROOT/'AGENTS.md';a=p.read_text(encoding='utf-8');a=a.replace('当前进度：8项修复的单文件与324个声明公理检查全部通过；唯一一次完整check运行中。文档正在按最新分版结论生成，提交push尚未完成。','当前进度：26号总验收PASS；本终态随交付提交push后停止，等待用户新指令；不再送网站、不进入第7章。',1);p.write_text(a,encoding='utf-8')
 resume=ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md';old=resume.read_text(encoding='utf-8')
 resume.write_text('# 26号已完成：第6章最终收口，等待用户新指令\n\n先核对CURRENT_STATE顶部、26号验收及Git实际推送状态。本轮8项按意见处理、324声明公理及一次完整check已通过，三份文档齐全。随终态提交push后停止；不再送网站、不生成新EAUDIT包、不进入第7章。没有用户新指令不继续证明。\n\n---\n\n'+old,encoding='utf-8')
 with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:f.write('''
## 2026-10-18 26号第6章最终收口验收
60条复审输入绑定通过（25 PASS/8 FAIL/27 NEEDS_HUMAN）；8项按建议处理、逐项单文件和324声明公理检查通过，一次完整check通过。网站原FAIL/suggested_fix/diff摘要保留，当前修改未再送网站、未生成新包。
三份第1章格式文档齐；最新网站直接PASS203，22个需人工组正确版本另列PASS；32项合并疑误/范围问题及1解释记录。123定义/110已证/91未证，未证原因21/52/18分别记录。
正式库298文件0 sorry/0 axiom；正式库、第1–5章及旧EAUDIT材料冻结字节一致。验收DELIVERY_VALIDATION.json为PASS；本终态随交付提交push后停止，导师裁定和91项完整证明未完成，不进入第7章。
''')
 run=load(OUT/'LEAN_SERVER_RUNNING.json');run['status']='completed_worker_stopped';dump(OUT/'LEAN_SERVER_RUNNING.json',run)
 progress=BASE/'PROGRESS.md';p=progress.read_text(encoding='utf-8');p=p.replace('# 第6章最终收口：本地核验完成','# 第6章最终收口完成，等待用户新指令',1);progress.write_text(p,encoding='utf-8')
 paths=['AGENTS.md','Blueprint/Ch06.lean','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md']
 paths += [f'docs/review/CH06_{n}.zh-CN.md' for n in ['BLUEPRINT','ERRATA','SUMMARY_FOR_MENTOR']]
 paths += [f'blueprint/ch06/{n}' for n in ['CheckAxioms.lean','PROGRESS.md','ch06_source.json','local_audit.json','proof_attempts.json','website_audit.json','WEBSITE_SUMMARY.json']]
 paths += [p.relative_to(ROOT).as_posix() for p in (BASE/'mathcopilot_results/eaudit').glob('EAUDIT*_result.json')]
 paths += [p.relative_to(ROOT).as_posix() for p in OUT.rglob('*') if p.is_file() and '__pycache__' not in p.parts and p.name not in ['ActiveCheck.lean','lean-server-stderr.log']]
 stage(paths)
 import subprocess
 actual=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
 assert set(actual)<=set(paths),set(actual)-set(paths)
 assert not any(p.startswith(('MolecularDynamics/','blueprint/ch01/','blueprint/ch02/','blueprint/ch03/','blueprint/ch04/','blueprint/ch05/')) for p in actual)
 print('STAGED owned deliverables',len(actual),flush=True)
if __name__=='__main__':main()
