"""Save the verified partial chapter-8 checkpoint requested by instruction 29.

Does not commit, push, change the heartbeat, or start chapter-7 work.
"""
from ch08_pipeline import *

assert len(RECORDS) == 50
state = json.loads((BASE/'local_audit.json').read_text(encoding='utf-8'))
assert all(x['checked'] for x in state['items'].values())
binding = BASE/'validation/batches/s86a-r3-binding.json'
assert json.loads(binding.read_text(encoding='utf-8'))['canonical_sha256'] == sha(ROOT/'Blueprint/Ch08.lean')
receipt = BASE/'validation/batches/s86a-r3.json'
assert json.loads(receipt.read_text(encoding='utf-8'))['exit_code'] == 0
frozen_count = verify_frozen(full=True)

attempts_path = BASE/'proof_attempts.json'
attempts = json.loads(attempts_path.read_text(encoding='utf-8'))
attempts['MD-8.6-IsokineticProjector'].update(
    category='时间盒止',
    reason='有限和投影复合的短证明尚未展开；按29号要求在当前批次可编译处暂停，不是缺大型理论。',
    decision='保留sorry；29号恢复第8章后可在最多三条短路线内继续。')
dump(attempts_path, attempts)

message = ('第8章按29号暂停：50条已落盘，当前批次s86a-r3单文件编译及逐声明#print axioms通过。'
           '进度到§8.6.1的首批，§8.6尚未完成；sorry和覆盖缺口已保留。'
           '小节检查复用输入哈希一致的正式库证据，未作第8章章末完整check。')
next_step = ('由29号聊天先完成第7章首轮结果整合、修复及复审包；其后从§8.6剩余内容继续28号。'
             '本聊天停止写共享目录；保留29号规则及heartbeat。')
for name in ['AGENTS.md', 'docs/handoff/CURRENT_STATE.zh-CN.md']:
    p = ROOT/name
    s = p.read_text(encoding='utf-8')
    assert s.startswith('# 29号：')
    start = s.index('## 28号运行检查点')
    end = s.index('## 历史规则与状态', start)
    s = s[:start]+'## 28号运行检查点\n\n'+message+'\n'+next_step+'\n\n'+s[end:]
    p.write_text(s, encoding='utf-8')
(ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md').write_text(
    '# 第29号优先、第28号后续接续\n\n'
    '先读AGENTS、CURRENT_STATE顶部、WORK_LOG最新和相关PROGRESS；先git status，复用已通过证据。\n'
    +message+'\n'+next_step+'\n'
    '29号完成第7章复审包并提交后，第7章重新冻结；再继续第8章至28号完成标准，章末停止。\n',
    encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a', encoding='utf-8') as f:
    f.write('\n## 2026-10-18 第28号按29号暂停交接\n\n'+message+'\n'+next_step+'\n'
            '已逐字复核15974个冻结文件；第8章生成文档路径现为CH08。'
            '先前误写CH07文档的恢复由29号处理，本次不提交第7章文件。\n')
(BASE/'LOCAL_PIPELINE.md').write_text('# 第8章本地五步流程\n\n'+message+'\n'+next_step+'\n', encoding='utf-8')
dump(BASE/'PAUSE29_CHECKPOINT.json', dict(
    status='paused_for_user_instruction_29', chapter_complete=False, entries=50,
    compiled_and_axioms_checked=True, canonical_sha256=sha(ROOT/'Blueprint/Ch08.lean'),
    receipt=str(receipt.relative_to(ROOT)), receipt_sha256=sha(receipt),
    binding=str(binding.relative_to(ROOT)), frozen_files_fully_rehashed=frozen_count,
    section_check='blueprint/ch08/validation/section86a/CHECK_REPORT.json',
    chapter_final_check_complete=False, website_packages_generated=False,
    remaining='§8.6剩余内容、§8.7–8.10、编号公式全集核对、章末文档和任务包、章末完整check',
    unvalidated_helpers=['scripts/ch08_finish.py', 'scripts/ch08_package.py', 'scripts/ch08_dependency_index.py'],
    next_owner='29号聊天', next_step=next_step,
    cautions=[
        '50条通过编译不表示全部证明完成；以local_audit中的sorryAx为准。',
        '第8章目前没有生成网站任务包，PACKAGE_VALIDATION未完成。',
        '附录PDF423起不在范围；Exercises从PDF420起，420只取Exercises前正文。',
        '生成器只启用enabled_modules所列模块；收尾和打包脚本尚未验证，不可直接当完成依据。',
        'Windows物理blueprint目录与Lean模块Blueprint大小写不同；提交应核对Blueprint/Ch08.lean已入索引。',
        '第7章文档误写已修正生成路径；29号聊天负责恢复CH07文档。']))
print('PAUSE29 CHECKPOINT SAVED', len(RECORDS), 'frozen', frozen_count, flush=True)
