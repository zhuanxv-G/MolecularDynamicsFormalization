"""Render the pilot review from source JSON, Lean declarations and audit records."""
from __future__ import annotations

import argparse
import hashlib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def sha256(text: str) -> str:
    return hashlib.sha256(text.encode('utf-8')).hexdigest()


def entry_hash(entry: dict) -> str:
    # Review status/log metadata must not invalidate an otherwise identical source.
    keys = ('source_id', 'kind', 'label', 'section', 'printed_page', 'pdf_page',
            'statement_latex', 'proof_latex', 'proof_note', 'proof_discussion_latex',
            'context_notation', 'statement_scope')
    return sha256(json.dumps({k: entry.get(k) for k in keys}, ensure_ascii=False, sort_keys=True))


def declarations(text: str) -> dict:
    """Extract only marked declarations; no proof text enters the statement field."""
    marks = list(re.finditer(r'/-- source_id:\s*([^\s·]+)[\s\S]*?-/', text))
    result = {}
    for i, mark in enumerate(marks):
        end = marks[i + 1].start() if i + 1 < len(marks) else text.rfind('end MD.Ch01')
        block = text[mark.end():end].strip()
        theorem = re.search(r'\btheorem\s+(\w+)[\s\S]*?\s:=', block)
        if not theorem:
            raise ValueError(f'Missing theorem after {mark.group(1)}')
        statement = theorem.group(0).rsplit(':=', 1)[0].rstrip()
        name = theorem.group(1)
        qualified = statement.replace('theorem ' + name, 'theorem MD.Ch01.' + name, 1)
        absolute_start = mark.end() + text[mark.end():end].index('theorem ' + name)
        result[mark.group(1)] = dict(
            name='MD.Ch01.' + name, statement=qualified,
            signature_sha256=sha256(statement), block=text[mark.start():end].strip(),
            line=text[:absolute_start].count('\n') + 1,
        )
    return result


def quote(text: str) -> str:
    return '\n'.join('> ' + line for line in text.splitlines())


def cell(text) -> str:
    return str(text).replace('|', '\\|').replace('\n', '<br>')


def render(source_path: Path, lean_path: Path, audit_path: Path) -> str:
    sources = json.loads(source_path.read_text(encoding='utf-8-sig'))
    lean = declarations(lean_path.read_text(encoding='utf-8-sig'))
    audit = json.loads(audit_path.read_text(encoding='utf-8-sig'))
    if {s['source_id'] for s in sources} != set(lean) or set(lean) != set(audit['items']):
        raise ValueError('Source, marked Lean declarations and audit IDs do not match')
    lines = ['| source_id | 标签 | 审计判定 | 最终状态 |', '|---|---|---|---|']
    for s in sources:
        a = audit['items'][s['source_id']]
        lines.append('| ' + ' | '.join(map(cell, [s['source_id'], s['label'] or '未编号结论',
                    a['verdict'], a.get('final_status', 'incomplete')])) + ' |')
    for s in sources:
        sid = s['source_id']
        a, d = audit['items'][sid], lean[sid]
        lines += ['', f"## {sid} · {s['label'] or '未编号结论'} · 印刷 p.{s['printed_page']} / PDF p.{s['pdf_page']}",
                  '', '### 1. 原文陈述', '', quote(s['statement_latex']),
                  '', '### 2. 原文证明', '']
        proof = s.get('proof_latex')
        if proof:
            if len(proof) > 1200:
                lines += ['<details>', '<summary>展开原文证明</summary>', '', quote(proof), '', '</details>']
            else:
                lines += [quote(proof)]
        else:
            lines += ['原书无完整证明，`proof_latex = null`。']
        if s.get('proof_note'):
            lines += ['', s['proof_note']]
        if s.get('proof_discussion_latex'):
            lines += ['', '原文证明思路（不计为完整证明）：', '', quote(s['proof_discussion_latex'])]
        lines += ['', '### 3. Lean 陈述', '', '```lean', d['statement'], '```',
                  '', '### 4. 对照表', '', '| 原文成分 | Lean 对应 | 备注（[EXTRA]/[ERRATUM?]/一致） |',
                  '|---|---|---|']
        for row in a['correspondence']:
            lines += ['| ' + ' | '.join(cell(row[k]) for k in ('source', 'lean', 'note')) + ' |']
        lines += ['', '### 5. 审计结论', '',
                  f"原文 JSON：{s['review_status']}；MathCopilot只读审计：{a['verdict']}；frozen={str(a['frozen']).lower()}。",
                  '', a['explanation']]
        for stage in ('json_review', 'blueprint_translation', 'semantic_review'):
            stage_data = a[stage]
            lines += ['', f"- {stage}：{stage_data['status']}；任务 `{stage_data['task']}`；返回件 " +
                      ('、'.join('`' + r + '`' for r in stage_data.get('results', [])) or '尚未收到') + '。']
        for issue in s.get('issues', []):
            lines += ['', f"- {issue['code']}：{issue['detail']}（{issue['status']}）。"]
        lines += ['', '### 6. 最终状态与证明位置', '',
                  f"最终状态：**{a.get('final_status', 'incomplete')}**。{a.get('final_status_note', '')}",
                  '', f"Blueprint声明/证明位置：`Blueprint/Ch01.lean:{d['line']}`。",
                  '', f"本地证明状态：{a.get('local_proof_status', 'not_checked')}。",
                  '', f"依赖公理：`{', '.join(a.get('axioms', [])) or '尚未检查'}`。",
                  '', f"直接风险：{a.get('direct_risk', '尚未检查')}。",
                  '', f"依赖闭包风险：{a.get('dependency_risk', '尚未检查')}。"]
        for p in a.get('proof_locations', []):
            lines += ['', f"- 复用证明：`{p['file']}:{p['line']}`，`{p['decl']}`。"]
        lines += ['', '当前签名SHA256：`' + d['signature_sha256'] + '`；原文条目SHA256：`' + entry_hash(s) + '`。']
    return '\n'.join(lines) + '\n'


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', type=Path, default=ROOT/'blueprint/ch01/ch01_source.json')
    parser.add_argument('--lean', type=Path, default=ROOT/'Blueprint/Ch01.lean')
    parser.add_argument('--audit', type=Path, default=ROOT/'blueprint/ch01/audit.json')
    parser.add_argument('--output', type=Path, default=ROOT/'docs/review/CH01_PILOT.zh-CN.md')
    args = parser.parse_args()
    result = render(args.source, args.lean, args.audit)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(result, encoding='utf-8')
    print(f'Rendered 5 pilot entries: {args.output}')


if __name__ == '__main__':
    main()
