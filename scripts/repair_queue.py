"""Render the user-authorized website repair queue without rebinding old returns."""
import json
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
HANDOFF = ROOT / 'docs/handoff'

def read(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))

def render():
    estimates = {(r['chapter'], r['source_id']): r['estimated_category']
                 for r in read(HANDOFF / 'REPAIR_CLASSIFICATION_ESTIMATE.json')}
    decisions_path = HANDOFF / 'REPAIR_DECISIONS.json'
    decisions = read(decisions_path) if decisions_path.exists() else {}
    rows = []; totals = {}; unresolved = 0
    for ch in (2, 3, 4, 5):
        base = ROOT / f'blueprint/ch{ch:02}'
        sources = read(base / f'ch{ch:02}_source.json')
        web = {r['source_id']: r for r in read(base / 'website_audit.json')}
        counts = Counter()
        for source in sources:
            sid = source['source_id']; w = web[sid]; v = w['returned_audit']['verdict']
            r = w.get('repair', {}); decision = decisions.get(sid, {})
            category = decision.get('category', estimates.get((ch, sid), 'D' if v == 'NEEDS_HUMAN' else '—'))
            handling = decision.get('handling', {'A':'补前提/定义域并标[EXTRA]', 'B':'补全结论；跨条目才显式缩范围并追加repair_log', 'C':'核对对象与网站路线；需选择则待导师', 'D':'核对是否需数学判断；确认后仅登记NEEDS_HUMAN'}.get(category, '复用绑定快照证据'))
            if r.get('status') == 'awaiting_mentor' or (v == 'NEEDS_HUMAN' and w.get('needs_category') == '原文数学判断'):
                status = '待导师'; counts['awaiting_mentor'] += 1
            elif r.get('status') == 'awaiting_reaudit' or v == 'NEEDS_HUMAN':
                status = '已修待复审'; counts['awaiting_reaudit'] += 1
            elif v == 'PASS' and w['binding']['bound']:
                status = '网站PASS（绑定版本 ' + w['binding']['version'][:12] + '）'; counts['website_pass'] += 1
            else:
                status = '待分类/修复'; counts['repairing'] += 1; unresolved += 1
            if w['json_review']['status'] == 'CORRECTED' and not r.get('json_review_locally_verified'):
                status += '；原文CORRECTED待原页复核'; unresolved += 1
            if category != '—' and sid not in decisions:
                category += '（初筛，未确认）'
            safe = lambda text: str(text).replace('|', '/').replace('\n', ' ')
            rows.append('| ' + ' | '.join(map(safe, (ch,sid,v,category,handling,status,r.get('eaudit','—')))) + ' |')
        totals[ch] = counts
    text = '# 第2–5章网站审计修复队列\n\n'
    text += '当前任务：修复第2–5章网站审计问题；第6章暂停，不进入第7章。\n'
    text += '修复顺序：第2→3→4→5章，每章按节，每批≤8条；不写新证明。\n'
    text += '完成状态：' + ('第2–5章全部修复完成，等待用户提交EAUDIT复审包。' if unresolved == 0 else f'修复进行中（待处理项目/原文审校计数 {unresolved}）。') + '\n'
    text += 'A/B/C/D初筛仅是关键词估计；须逐条阅读网站理由后确认，初筛D不代表已转导师。网站PASS只覆盖其绑定快照。\n\n'
    for ch, c in totals.items():
        text += f'第{ch}章：网站PASS {c["website_pass"]} / 已修待复审 {c["awaiting_reaudit"]} / 待导师 {c["awaiting_mentor"]} / 修复中 {c["repairing"]}。\n'
    text += '\n| 章 | source_id | 网站判定 | 问题类别 | 处理方式 | 状态 | EAUDIT批次 |\n|---|---|---|---|---|---|---|\n'
    (HANDOFF/'REPAIR_QUEUE.md').write_text(text+'\n'.join(rows)+'\n',encoding='utf-8')
    state = HANDOFF/'CURRENT_STATE.zh-CN.md'; lines = state.read_text(encoding='utf-8').splitlines()
    active_end = next((i for i,x in enumerate(lines) if x.startswith('## 历史状态')),len(lines))
    active = lines[:active_end]; history = lines[active_end:]
    for ch, c in totals.items():
        row = f'第{ch}章：网站PASS {c["website_pass"]} / 已修待复审 {c["awaiting_reaudit"]} / 待导师 {c["awaiting_mentor"]} / 修复中 {c["repairing"]}。'
        active = [x for x in active if not x.startswith(f'第{ch}章：网站PASS ')]
        active.insert(5+ch-2,row)
    state.write_text('\n'.join(active+history)+'\n',encoding='utf-8')
    return totals

if __name__ == '__main__':
    print(render())
