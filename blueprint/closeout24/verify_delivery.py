from common import *
from finalize_chapter import chunks,q,LOCAL_EXCERPTS
from errata_apply import candidates
from collections import Counter
import subprocess,tomllib

def verify():
 frozen=load(OUT/'FROZEN_BASELINE.json')
 bad=[p for p,h in frozen.items() if not (ROOT/p).is_file() or sha(ROOT/p)!=h]
 assert not bad,('frozen files changed',bad)
 page=load(OUT/'ch05/LOCAL_PAGE202_VERIFICATION.json')
 assert sha(ROOT/page['image'])==page['image_sha256']
 instruction=(OUT/'USER_INSTRUCTION.zh-CN.md').read_text(encoding='utf-8-sig').strip()
 for path in [ROOT/'AGENTS.md',ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md']:
  assert instruction in path.read_text(encoding='utf-8-sig')
 summaries=[];return_counts=Counter();repairs=[];raw_files=[];input_evidence={}
 for ch in range(2,6):
  dest=OUT/f'ch{ch:02}';b=base(ch);s=load(dest/'SUMMARY.json');summaries.append(s)
  report=load(dest/'full/CHECK_REPORT.json')
  assert report['machine_check_status']=='passed' and report['exit_code']==0
  for check in report['checks']:
   assert check['exit_code']==0
   if check.get('raw_log'):
    assert sha(dest/'full'/check['raw_log'])==check['raw_log_sha256']
  assert s['repairing']==0 and s['current_lean_sha256']==sha(lean(ch))
  if ch==2:assert next(x['sha256'] for x in report['inputs'] if x['relative_path'].lower()=='blueprint/ch02.lean')==sha(lean(ch))
  else:assert load(dest/'CHECK_INPUT.json')['current_lean_sha256']==sha(lean(ch))
  reg=load(dest/'RETURN_REGISTRATION.json');return_counts.update(reg['counts'])
  for binding in reg['bindings']:
   assert sha(ROOT/binding['path'])==binding['sha256'];raw_files.append(binding['path'])
   assert all(x['expected']==x['actual'] for x in binding['input_hashes'].values())
   for rel,check in binding['input_hashes'].items():
    inp=ROOT/rel if '/' in rel else b/'mathcopilot_tasks'/binding['batch']/rel
    if sha(inp)!=check['expected']:
     assert rel in [f'Blueprint/Ch{ch:02}.lean',f'blueprint/ch{ch:02}/ch{ch:02}_source.json']
     original=dest/(Path(rel).stem+'.before'+Path(rel).suffix)
     assert sha(original)==check['expected'],(rel,'original snapshot mismatch')
     input_evidence[rel]=dict(original_sha256=check['expected'],original_snapshot=original.relative_to(ROOT).as_posix(),current_sha256=sha(inp),status='原返回绑定修复前输入；当前修复版另由编译及完整check核验。')
    else:
     input_evidence[str(inp.relative_to(ROOT)).replace('\\','/')]=dict(original_sha256=check['expected'],status='原任务输入未改变')
  rs=load(dest/'REPAIRS.json');repairs.extend(rs)
  ww={w['source_id']:w for w in load(b/'website_audit.json')}
  for r in rs:
   assert r['exit_code']==0
   assert ww[r['source_id']]['effective_status']=='按网站审校意见修复，本地核验通过（未再送网站）'
   assert ww[r['source_id']]['closeout24_return']['audit']['verdict']=='FAIL'
   assert r['suggested_fix']==ww[r['source_id']]['closeout24_return']['audit']['suggested_fix']
  old_candidates=load(dest/'ERRATA_CANDIDATES.json')
  assert sum(bool(c['old']) for c in old_candidates)=={2:18,3:20,4:27,5:15}[ch]
  cc=load(dest/'CORRECTIONS.json');assert {c['source_id'] for c in cc}=={c['source_id'] for c in candidates(ch)}
  for r in load(dest/'RETURNS.json'):
   if r['audit']['verdict']=='NEEDS_HUMAN' and r['source_id'] not in LOCAL_EXCERPTS.get(ch,set()):
    assert r['source_id'] in {c['source_id'] for c in cc}
  idx=load(dest/'ERRATA_INDEX.json');assert set(sum((x['source_ids'] for x in idx),[]))=={c['source_id'] for c in cc}
  for sid in LOCAL_EXCERPTS.get(ch,set()):
   assert ww[sid]['effective_status']=='本地核验通过（网站因摘录缺失未判）'
   assert sid not in {c['source_id'] for c in cc}
  src=load(b/f'ch{ch:02}_source.json');gg=groups(ch)
  blueprint=(ROOT/f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md').read_text(encoding='utf-8')
  errata=(ROOT/f'docs/review/CH{ch:02}_ERRATA.zh-CN.md').read_text(encoding='utf-8')
  mentor=(ROOT/f'docs/review/CH{ch:02}_SUMMARY_FOR_MENTOR.zh-CN.md').read_text(encoding='utf-8')
  assert len(src)==len(gg)==s['total']=={2:160,3:149,4:179,5:183}[ch]
  for x in src:
   assert x['lean_decl'] in {f'MD.Ch{ch:02}.'+n for g in gg.values() for n in g['names']}
   sid=x['source_id'];assert q(x['statement_latex']) in blueprint,sid
   assert f'## 1. {sid} ' in blueprint,sid
   for d in chunks(gg[sid]['code']):assert d['code'] in blueprint,(sid,d['name'])
   if sid in {c['source_id'] for c in cc}:assert q(x['statement_latex']) in errata,sid
  for n in range(2,8):assert blueprint.count(f'### {n}. ')==len(src),(ch,n)
  assert not re.search(r'sorryAx|checked\+documented priors|字节预算|历史绑定哈希|等待用户指令|第6章暂停',mentor)
  declared=load(dest/'DECLARATIONS.json')
  assert Counter(d['status'] for d in declared)==s['declarations']
  assert Counter(d['unproved_reason'] for d in declared if d['unproved_reason'])==s['unproved_reasons']
  assert sum(s['unproved_reasons'].values())==s['declarations'].get('未证',0)
 assert sum(return_counts.values())==380 and dict(return_counts)==dict(PASS=302,FAIL=27,NEEDS_HUMAN=51)
 assert len(repairs)==27 and len({r['source_id'] for r in repairs})==27
 formal=list((ROOT/'MolecularDynamics').rglob('*.lean'))
 shortcuts=[]
 for p in formal:
  for m in re.finditer(r'\b(sorry|admit|axiom|unsafe)\b',p.read_text(encoding='utf-8-sig')):shortcuts.append((str(p),m.group(0)))
 assert not shortcuts,shortcuts
 config=tomllib.loads(Path(r'C:\Users\ustc\.codex\automations\lean-2\automation.toml').read_text(encoding='utf-8-sig'))
 assert config['status']=='ACTIVE' and config['rrule']=='FREQ=MINUTELY;INTERVAL=15'
 assert config['target_thread_id']=='01a10bc0-bc8d-7043-8df9-21a6b0bde09a'
 assert config['prompt'].startswith('按24号继续第2–5章收口。')
 assert 'resume_state.json' in config['prompt'] and '30分钟' in config['prompt'] and '连续3次' in config['prompt']
 assert '第24号全文第6节全部完成' in config['prompt']
 result=dict(status='PASS',frozen_files_verified=len(frozen),formal_lean_files=len(formal),
  formal_sorry=0,formal_axiom=0,returns=dict(return_counts),raw_return_files=len(raw_files),
  fail_repairs=27,repairing=0,chapters=summaries,original_input_evidence=input_evidence,
  blueprint_entries=sum(s['total'] for s in summaries),errata=sum(s['errata'] for s in summaries),
  checks=['原始返回与输入绑定','27条FAIL原文/建议/逐项编译收据保留','当前全声明公理记录',
   '每章完整check及日志哈希','冻结源码字节一致','全篇逐字引文与完整当前Lean覆盖','七段结构',
   '旧待导师及新原书疑误全部登记并按问题合并','四条摘录问题独立登记','导师摘要术语与统计',
   'heartbeat ACTIVE/15分钟/原target/去重与24号停止条件'],
  limitations=['编译与公理检查不证明含占位的声明','修正版未再次送网站','勘误未获导师裁定'],
  publication='此收据验证提交前交付内容；push结果由最终Git命令单独确认。')
 dump(OUT/'DELIVERY_VALIDATION.json',result)
 print(json.dumps(result,ensure_ascii=False,indent=2))
if __name__=='__main__':verify()
