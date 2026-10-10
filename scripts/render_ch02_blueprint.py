"""Render Chapter 2 from source, Blueprint, local and optional website audits."""
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
        end = marks[i + 1].start() if i + 1 < len(marks) else text.rfind('end MD.Ch02')
        block = text[mark.end():end].strip()
        theorem = re.search(r'\btheorem\s+(\w+)[\s\S]*?\s:=', block)
        if not theorem:
            raise ValueError(f'Missing theorem after {mark.group(1)}')
        statement = theorem.group(0).rsplit(':=', 1)[0].rstrip()
        name = theorem.group(1)
        qualified = statement.replace('theorem ' + name, 'theorem MD.Ch02.' + name, 1)
        absolute_start = mark.end() + text[mark.end():end].index('theorem ' + name)
        result[mark.group(1)] = dict(
            name='MD.Ch02.' + name, statement=qualified,
            signature_sha256=sha256(statement), block=text[mark.start():end].strip(),
            line=text[:absolute_start].count('\n') + 1,
        )
    return result


def quote(text: str) -> str:
    return '\n'.join('> ' + line for line in text.splitlines())


def cell(text) -> str:
    return str(text).replace('|', '\\|').replace('\n', '<br>')


def render(source_path: Path, lean_path: Path, audit_path: Path, website_path: Path | None=None) -> str:
    from ch02_pipeline import declarations as whole_declarations
    sources=json.loads(source_path.read_text(encoding='utf-8-sig'))
    ds=whole_declarations()
    audit=json.loads(audit_path.read_text(encoding='utf-8-sig'))['items']
    website_path=website_path or ROOT/'blueprint/ch02/website_audit.json'
    website={}
    if website_path.exists():
        data=json.loads(website_path.read_text(encoding='utf-8-sig'))
        if isinstance(data,dict):data=data.get('items',data)
        website={x['source_id']:x for x in data} if isinstance(data,list) else data
    def web(sid):
        a=website.get(sid)
        return '待网站审计' if a is None else a.get('audit',a).get('verdict','NEEDS_HUMAN')
    if {s['source_id'] for s in sources} != set(ds) or set(ds)!=set(audit):
        raise ValueError('Source/Blueprint/local audit ID mismatch')
    lines=['# 第2章 Lean Blueprint 本地审阅材料','',
        f'覆盖印刷p.53–94正文，习题除外。原文JSON审校状态见各条；本地模板C预审独立于网站审计。已整合网站返回{len(website)}条，其余待网站审计；未冻结。编译和公理检查验证当前Lean陈述/证明，原文忠实性由独立审校核验。','',
        '| source_id | 页码 印刷/PDF | 本地预审 | 网站审计 | 状态 |','|---|---|---|---|---|']
    for s in sources:
        a=audit[s['source_id']]
        lines.append('| '+' | '.join(map(cell,[s['source_id'],s['printed_page']+'/'+s['pdf_page'],a['verdict'],web(s['source_id']),a.get('final_status','incomplete')]))+' |')
    lines+=['','## 需要导师判断的问题','']
    for s in sources:
        a=audit[s['source_id']]
        if a['verdict']!='PASS' or any(i.get('status')=='NEEDS_HUMAN' or i.get('code')=='ERRATUM?' for i in s.get('issues',[])):
            lines.append('- '+s['source_id']+'：'+a['explanation'])
            lines.extend('  '+i['detail'] for i in s.get('issues',[]))
    for s in sources:
        sid=s['source_id'];a=audit[sid];d=ds[sid]
        lines+=['',f"## 1. {sid} · {s['label'] or s['kind']} · 印刷p.{s['printed_page']} / PDFp.{s['pdf_page']}",'',
            '### 2. 原文陈述','',quote(s['statement_latex']),'','### 3. 原文证明','']
        proof=s.get('proof_latex')
        if proof and len(proof)>1200:lines+=['<details>','<summary>展开逐字原文证明</summary>','',quote(proof),'','</details>']
        else:lines+=[quote(proof) if proof else '原书无独立完整证明（proof_latex=null）。']
        if s.get('proof_note'):lines+=['',s['proof_note']]
        if s.get('proof_discussion_latex'):lines+=['','原文证明思路：','',quote(s['proof_discussion_latex'])]
        lines+=['','### 4. Lean陈述','','```lean',d['statement'],'```','','### 5. 对照表','',
            '| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |','|---|---|---|']
        for row in a['correspondence']:lines.append('| '+' | '.join(cell(row[k]) for k in ('source','lean','note'))+' |')
        for extra in s.get('extra_assumptions',[]):
            lines.append('| 原文省略/技术资格 | '+cell(extra)+' | [EXTRA] |')
        for i in s.get('issues',[]):
            note='[ERRATUM?]' if i.get('code')=='ERRATUM?' else i.get('status',i.get('code','NEEDS_HUMAN'))
            lines.append('| 原页核对/疑点 | '+cell(i['detail'])+' | '+note+' |')
        lines+=['','### 6. 审计结论','',f"本地预审：**{a['verdict']}**。{a['explanation']}",'',
            '网站审计：**'+web(sid)+'**。原文JSON：'+s['review_status']+'；未冻结。']
        if sid in website:
            wa=website[sid].get('audit',website[sid])
            lines+=['',wa.get('explanation','')]
            if wa.get('counterexample'):lines+=['','网站反例：'+wa['counterexample']]
            if wa.get('suggested_fix'):lines+=['','网站建议：'+wa['suggested_fix']]
        if a.get('counterexample'):lines+=['','反例：'+a['counterexample']]
        if a.get('suggested_fix'):lines+=['','建议：'+a['suggested_fix']]
        lines+=['','### 7. 状态与证明位置','',
            '**'+a.get('final_status','incomplete')+'**；本地证明状态：'+a['proof_status']+'。',
            '',f"位置：[Blueprint/Ch02.lean:{d['line']}](<{(ROOT/'Blueprint/Ch02.lean').as_posix()}:{d['line']}>)（`{d['name']}`）。",'',
            'Lean编译/公理检查：'+('已验证' if a['checked'] else '本轮待验证')+'；公理：`'+(', '.join(a.get('axioms',[])) or ('无' if a['checked'] else '未检查'))+'`。','',
            '直接占位：'+('有sorry' if a['direct_placeholder'] else '无直接sorry')+'；传递占位：'+('存在（无直接sorry但公理含sorryAx）' if a.get('transitive_placeholder') else ('未检出；直接sorry的sorryAx已单列' if a['checked'] else '未验证'))+'。']
        if a.get('missing'):lines+=['','缺失/继续路线：'+a['missing']]
        if a.get('proof_attempts'):lines+=['',f"本地独立尝试{a['proof_attempts']}次，失败{a.get('proof_failures',0)}次；证据：blueprint/ch02/proof_attempts.json。"]
        if a.get('documented_priors'):lines+=['','已登记前置证明/定义：'+ '; '.join(a['documented_priors'])+'。']
        lines+=['','签名SHA256：`'+d['signature_sha256']+'`；原文SHA256：`'+entry_hash(s)+'`。']
    return '\n'.join(lines)+'\n'


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--source',type=Path,default=ROOT/'blueprint/ch02/ch02_source.json')
    parser.add_argument('--lean',type=Path,default=ROOT/'Blueprint/Ch02.lean')
    parser.add_argument('--audit',type=Path,default=ROOT/'blueprint/ch02/local_audit.json')
    parser.add_argument('--website',type=Path,default=ROOT/'blueprint/ch02/website_audit.json')
    parser.add_argument('--output',type=Path,default=ROOT/'docs/review/CH02_BLUEPRINT.zh-CN.md')
    a=parser.parse_args()
    a.output.write_text(render(a.source,a.lean,a.audit,a.website),encoding='utf-8')
    print('Rendered',len(json.loads(a.source.read_text(encoding='utf-8-sig'))),'entries:',a.output)

if __name__=='__main__':main()
