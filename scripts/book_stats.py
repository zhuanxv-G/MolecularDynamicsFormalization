"""Recompute book-level counts without changing chapter sources (Python stdlib).

Run: python scripts/book_stats.py
Proof status comes from per-declaration axiom receipts, never a chapter total.
All counts, classifications and provenance are exported for independent checking.
"""
from __future__ import annotations

import collections
import csv
import hashlib
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'docs/review/book'
REASONS = {'缺大型理论': '缺大理论', '原书疑误不证': '原书疑误原文版不证', '时间盒止': '尝试次数用尽'}
DECL = re.compile(r'(?m)^[ \t]*(?:@\[[^\n]*?\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(def|abbrev|theorem|lemma|structure|inductive)\s+([\w\u0080-\uffff\'₀-₉]+)')


def read(path):
    return (ROOT / path).read_text(encoding='utf-8-sig')


def load(path):
    return json.loads(read(path))


def dump(path, obj):
    path = ROOT / path
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')


def sha(path):
    return hashlib.sha256((ROOT / path).read_bytes()).hexdigest()


def clean(code):
    """Blank nested Lean comments and strings, preserving offsets/newlines."""
    chars = list(code)
    i, depth, string = 0, 0, False
    while i < len(code):
        if depth:
            if code[i:i+2] == '/-':
                chars[i:i+2] = '  '; depth += 1; i += 2; continue
            if code[i:i+2] == '-/':
                chars[i:i+2] = '  '; depth -= 1; i += 2; continue
            if code[i] != '\n': chars[i] = ' '
            i += 1; continue
        if string:
            if code[i] == '\\':
                chars[i:i+2] = '  '; i += 2; continue
            if code[i] == '"': string = False
            if code[i] != '\n': chars[i] = ' '
            i += 1; continue
        if code[i:i+2] == '/-':
            chars[i:i+2] = '  '; depth = 1; i += 2; continue
        if code[i:i+2] == '--':
            end = code.find('\n', i)
            if end < 0: end = len(code)
            chars[i:end] = ' ' * (end-i); i = end; continue
        if code[i] == '"': string = True; chars[i] = ' '
        i += 1
    return ''.join(chars)


def declarations(code):
    blank = clean(code)
    matches = list(DECL.finditer(blank))
    marks = list(re.finditer(r'/-- source_id:\s*([^\s·]+)', code))
    result = []
    for i, m in enumerate(matches):
        end = matches[i+1].start() if i+1 < len(matches) else len(code)
        prev = [mark for mark in marks if mark.start() < m.start()]
        result.append(dict(name=m[2], kind=m[1], line=code[:m.start()].count('\n')+1,
                           source_id=prev[-1][1] if prev else None,
                           code=blank[m.start():end], raw=code[m.start():end]))
    return result


def metadata(ch, source):
    if ch == 1:
        path = 'blueprint/ch01/validation/CLOSEOUT21/DECLARATION_STATUS.json'
        return {f'MD.Ch01.{k}': v for k, v in load(path).items()}, path
    if ch <= 5:
        key = 'closeout24_declaration_statuses'
        return {d['name']: d for s in source for d in s[key]}, f'blueprint/ch{ch:02}/ch{ch:02}_source.json'
    path = {6: 'blueprint/ch06/closeout26/DECLARATIONS.json',
            7: 'blueprint/ch07/closeout30/DECLARATIONS.json',
            8: 'blueprint/ch08/closeout31/DECLARATIONS.json'}[ch]
    return {d['name']: d for d in load(path)}, path


def website_bucket(w):
    status = w.get('effective_status', '')
    if status.startswith('按网站审校意见修复'): return 'local_repairs'
    if status.startswith('本地核验通过'): return 'local_excerpt_verified'
    if status.startswith(('网站PASS', '网站复审PASS')): return 'website_pass'
    if any(x in status for x in ['待导师', 'NEEDS_HUMAN', '待人工']): return 'needs_human'
    raise ValueError(('Unclassified current website status', w['source_id'], status))


def field(block, prefix):
    return next((line.split('：', 1)[-1].strip() for line in block.splitlines()
                 if line.startswith('- ' + prefix)), '')


def errata(ch, sources):
    path = f'docs/review/CH{ch:02}_ERRATA.zh-CN.md'
    text = read(path)
    marks = list(re.finditer(r'^## (\d+)\. (.+)$', text, re.M))
    byid = {s['source_id']: s for s in sources}
    result = []
    for i, m in enumerate(marks):
        block = text[m.end():marks[i+1].start() if i+1 < len(marks) else len(text)]
        ids = list(dict.fromkeys(re.findall(r'MD-\d[\w.\-]*', m[2])))
        pages = [byid[sid] for sid in ids if sid in byid]
        issue = field(block, '问题所在')
        explicit = field(block, '类别')
        context = ('解释记录' in m[2] or explicit in ['域或覆盖说明', '原证明核查'])
        # Chapter 7 explicitly retracts any assertion that the printed sufficient bound is false.
        if ch == 7 and m[1] == '24': context = True
        if ch == 1 and m[1] == '20': context = True  # already-passed isosceles submodel context
        category = '论证或适用范围待核'
        if re.search(r'缺|遗漏|漏|非零|正性|初态|可积|归一|资格|前提', issue): category = '缺前提或适用范围'
        if re.search(r'不能.*(?:推出|保证)|不保证|过强|只[能给]|一般不能|只能', issue): category = '结论过强'
        if re.search(r'指代|同名|维数|类型前后|C².*C∞|记号|取值点|共轭|坐标', issue): category = '记号或指代矛盾'
        if re.search(r'反号|符号|负号|正号|笔误|系数|根号|印.*缺|印.*漏|缺.*常数|缺.*1/2', issue): category = '印刷或公式符号疑误'
        if context: category = explicit or '解释或范围记录'
        result.append(dict(chapter=ch, section=int(m[1]), heading=m[2], source_ids=ids,
                           printed_page='; '.join(dict.fromkeys(str(p['printed_page']) for p in pages)),
                           pdf_page='; '.join(dict.fromkeys(str(p['pdf_page']) for p in pages)),
                           type=category, record_class='context_or_proof_review' if context else 'potential_book_issue',
                           issue=issue, suggestion=field(block, '修正版 Lean 名称') or field(block, '导师选项'),
                           status='解释/范围核查，非已确认书误' if context else '工作疑误，待导师裁定',
                           path=path, anchor=f'{m[1]}-{m[2]}', source_sha256=sha(path)))
    return result


THEORIES = [
    ('Hartman–Grobman与局部动力系统', r'hartman|grobman|hyperbolicstabilitytransfer|拓扑共轭|双曲系统'),
    ('Liouville–Arnold与环面稠密性', r'torus|\btori\b|actionangle|kronecker|可积系统|作用角|环面'),
    ('Hörmander与随机平滑', r'hormander|hörmander|hypoellipt|sinBracket.*(?:rank|span)|张成|随机平滑'),
    ('遍历性、混合与长期收敛', r'ergod|mixing|timeaverage|longtime|irreducib|minorization|lyapunov|harris|MD.Ch06.theorem6[12]|遍历|混合|长期|小集'),
    ('几何测度与微正则测度', r'coarea|hausdorff|microraw|microinvariant|microaverage|ambientlower|curveimage|measureduality|曲面测度|零测'),
    ('凸分析、矩阵估计与势能几何', r'legendre|hessian|ellipsoid|compact|coerciv|energy_bounds|equilateral|confining|凸|正定|紧集|二阶必要'),
    ('谱理论、偏微分方程与函数空间', r'spectral|spectrum|eigen|resolvent|pde|fokker|liouville|adjoint|fredholm|sobolev|l2|density|oukernel|dirichlet|算子|谱|函数空间|密度|偏微分'),
    ('随机极限与时间尺度', r'overdamped|smoluchowski|kramers|frictionlimit|momentumredraw|redrawmomentum|重标度|时间尺度'),
    ('局部驻定散度与概率权重', r'stationary|thermostatcriterion|divergence|驻定|散度抵消|权重指数'),
    ('Gaussian矩与有限维概率计算', r'gaussian|covariance|bbkstar|configtemperature|规范平均|协方差'),
    ('SDE、随机积分与随机过程', r'sde|wiener|brownian|ito|itô|straton|stoch|langevin|ounoise|oulaw|ouprocess|oumean|oucov|prony|markov|random|随机|布朗|噪声'),
    ('反向误差、形式展开与修正测度', r'modified|shadow|bch|commutat|perturb|correction|backward|truncat|exponential|processor|交换子|修正|截断|反向误差|摄动|渐近'),
    ('几何约束、辛结构与刚体', r'constraint|symplectic|manifold|rattle|shake|rigid|rotation|angular|poisson|bracket|formsumwedge|oneform|pullback|gram|cotangent|spin|projection|约束|辛|流形|刚体|角动量'),
    ('ODE、微积分与数值误差衔接', r'flow|\bode\b|deriv|taylor|order|consisten|error|converg|integral|smooth|verlet|midpoint|explicitrk|newmark|frictionthreshold|stability|oscillator|bathreduction|微分|导数|误差|光滑|积分|收敛'),
    ('模型专门计算及其他衔接', r'.'),
]


def theory(name, source, reason_text):
    # Names and explicit missing-result descriptions take precedence over broad chapter context.
    text = name + ' ' + reason_text
    for title, pattern in THEORIES:
        if re.search(pattern, text, re.I): return title


def run():
    OUT.mkdir(parents=True, exist_ok=True)
    rows, all_decls, all_errata, provenance, items, differences = [], [], [], {}, [], []
    page_ranges = load('docs/review/book/BOOK_PAGE_RANGES.json')
    for ch in range(1, 9):
        base = f'blueprint/ch{ch:02}'
        srcpath = f'{base}/ch{ch:02}_source.json'
        source, web, summary = load(srcpath), load(f'{base}/website_audit.json'), load(f'{base}/WEBSITE_SUMMARY.json')
        sources = {s['source_id']: s for s in source}
        progress = set(re.findall(r'^\|\s*(MD-[^ |]+)', read(f'{base}/PROGRESS.md'), re.M))
        assert set(sources) == {w['source_id'] for w in web} == progress, ('source coverage', ch)
        code = read(f'Blueprint/Ch{ch:02}.lean')
        ds = declarations(code)
        md, mdpath = metadata(ch, source)
        supplemental = OUT / 'BOOK_SUPPLEMENTAL_DECLARATIONS.json'
        if supplemental.exists():
            md.update({k: v for k, v in load(supplemental).items() if k.startswith(f'MD.Ch{ch:02}.')})
        assert {f'MD.Ch{ch:02}.{d["name"]}' for d in ds} == set(md), ('declaration coverage', ch)
        counts, reasons = collections.Counter(), collections.Counter()
        local = load(f'{base}/local_audit.json')['items']
        for d in ds:
            name = f'MD.Ch{ch:02}.{d["name"]}'
            m = md[name]
            unproved = 'sorryAx' in m['axioms']
            status = 'unproved' if unproved else 'definitions' if d['kind'] in ['def', 'abbrev', 'structure', 'inductive'] else 'proved'
            counts[status] += 1
            reason = m.get('unproved_reason') or m.get('reason') or m.get('classification') or m.get('sorry_category')
            if unproved:
                assert reason in REASONS, (name, reason)
                reasons[REASONS[reason]] += 1
            direct = bool(re.search(r'\bsorry\b', d['code']))
            assert direct == m['direct_placeholder'], ('direct placeholder', name)
            s = sources.get(d['source_id'], {})
            missing = local.get(d['source_id'], {}).get('missing')
            detail = str(m.get('stop_reason') or missing or '')
            r = dict(name=name, chapter=ch, source_id=d['source_id'], kind=d['kind'], status=status,
                     reason=REASONS.get(reason) if unproved else None, reason_evidence=detail,
                     theory=theory(name, s, detail) if unproved and reason == '缺大型理论' else None,
                     line=d['line'], direct_sorry=direct, axioms=m['axioms'], evidence=mdpath)
            all_decls.append(r)
        buckets = collections.Counter()
        for w in web:
            bucket = website_bucket(w)
            buckets[bucket] += 1
            items.append(dict(chapter=ch, source_id=w['source_id'], category=bucket,
                              current_status=w['effective_status'], raw_verdict=w.get('audit', {}).get('verdict'),
                              printed_page=sources[w['source_id']]['printed_page'], pdf_page=sources[w['source_id']]['pdf_page']))
        errs = errata(ch, source); all_errata += errs
        raw_sorry = len(re.findall(r'\bsorry\b', code))
        clean_sorry = len(re.findall(r'\bsorry\b', clean(code)))
        # Independent ripgrep word count, not a repeat of the Python regex count.
        rg = subprocess.run(['rg', '-o', '-w', 'sorry', f'Blueprint/Ch{ch:02}.lean'], cwd=ROOT, capture_output=True, text=True, encoding='utf-8')
        assert rg.returncode in [0, 1]
        grep_sorry = len(rg.stdout.splitlines())
        assert raw_sorry == grep_sorry and sum(d['direct_sorry'] for d in all_decls if d['chapter'] == ch) == clean_sorry
        assert sum(counts.values()) == len(ds) and sum(reasons.values()) == counts['unproved']
        assert sum(buckets.values()) == len(source)
        oldclaims = ROOT / f'docs/review/CH{ch:02}_CLAIMS.csv'
        claims_rows = len(list(csv.DictReader(oldclaims.open(encoding='utf-8-sig', newline='')))) if oldclaims.exists() else None
        def entry_range(key):
            numbers = [int(x) for s in source for x in re.findall(r'\d+', str(s[key]))]
            return f'{min(numbers)}–{max(numbers)}'
        record = dict(chapter=ch, **page_ranges['chapters'][str(ch)],
                      entry_printed_pages=entry_range('printed_page'), entry_pdf_pages=entry_range('pdf_page'), entries=len(source),
                      website_pass=buckets['website_pass'], local_repairs=buckets['local_repairs'],
                      needs_human=buckets['needs_human'], local_excerpt_verified=buckets['local_excerpt_verified'], fail=buckets['fail'],
                      errata_sections=len(errs), potential_book_issue_sections=sum(e['record_class'] == 'potential_book_issue' for e in errs),
                      context_or_proof_review_sections=sum(e['record_class'] != 'potential_book_issue' for e in errs),
                      named_declarations=len(ds), definitions=counts['definitions'], proved=counts['proved'], unproved=counts['unproved'],
                      unproved_reasons=dict(reasons), blueprint_lines=len(code.splitlines()), sorry=clean_sorry,
                      sorry_raw_grep=grep_sorry, legacy_claims_rows=claims_rows,
                      partition_equation=f'{buckets["website_pass"]}+{buckets["local_repairs"]}+{buckets["needs_human"]}+{buckets["local_excerpt_verified"]}={len(source)}',
                      self_checks_passed=True)
        rows.append(record)
        # Compare every old count, even when it agrees, rather than correcting only a chosen headline.
        comparisons = [('条目数', summary.get('total'), record['entries']), ('网站最终整条PASS', summary.get('website_pass'), record['website_pass']),
                       ('本地按意见修复', summary.get('locally_repaired_not_resubmitted', summary.get('local_repairs')), record['local_repairs']),
                       ('需人工', summary.get('awaiting_mentor', summary.get('original_text_human_items')), record['needs_human'])]
        olddecl = summary.get('declarations', {})
        for oldkey, newkey, alt in [('定义', 'definitions', 'definitions'), ('已证', 'proved', 'proved'), ('未证', 'unproved', 'unproved')]:
            comparisons.append((oldkey, olddecl.get(oldkey, olddecl.get(alt)), record[newkey]))
        old_named = olddecl.get('total') or sum(olddecl.get(k, 0) for k in ['定义', '已证', '未证'])
        comparisons.append(('命名声明', old_named, record['named_declarations']))
        old_errata = next((summary[k] for k in ['errata_records', 'errata_entries', 'errata_or_scope_records', 'issue_records', 'errata'] if k in summary), None)
        comparisons.append(('疑误单编号节总数', old_errata, record['errata_sections']))
        for k, old, new in comparisons:
            if old is not None:
                differences.append(dict(chapter=ch, field=k, old=old, recomputed=new, different=old != new))
        for path in [srcpath, f'{base}/website_audit.json', f'{base}/WEBSITE_SUMMARY.json', f'{base}/PROGRESS.md',
                     f'{base}/local_audit.json', f'{base}/proof_attempts.json', mdpath,
                     f'Blueprint/Ch{ch:02}.lean', f'docs/review/CH{ch:02}_ERRATA.zh-CN.md', f'docs/review/CH{ch:02}_SUMMARY_FOR_MENTOR.zh-CN.md']:
            provenance[path] = sha(path)
        if oldclaims.exists(): provenance[oldclaims.relative_to(ROOT).as_posix()] = sha(oldclaims.relative_to(ROOT))
    numeric = [k for k, v in rows[0].items() if isinstance(v, int) and not isinstance(v, bool) and k != 'chapter']
    numeric = [k for k in numeric if k not in ['legacy_claims_rows', 'chapter_start_pdf', 'exercises_start_pdf']]
    totals = {k: sum(row[k] for row in rows) for k in numeric}
    totals['unproved_reasons'] = {r: sum(row['unproved_reasons'].get(r, 0) for row in rows) for r in REASONS.values()}
    totals['partition_equation'] = '+'.join(str(totals[k]) for k in ['website_pass', 'local_repairs', 'needs_human', 'local_excerpt_verified']) + '=' + str(totals['entries'])
    result = dict(schema_version=1, scope='第1–8章正文，不含习题与附录', baseline='f4ea1f7b', chapters=rows, total=totals,
                  counting_notes=['website_pass按当前effective_status整条通过计；原书问题中获认可的修正版不提升整组。',
                                  'local_repairs仅计最终未再送审且本地核验通过者；更早修复后已获复审者归入最终状态。',
                                  'PASS+本地修复+需人工+摘录本地核对=条目数；摘录核对另列，不冒称网站通过或按意见改签名。',
                                  'FAIL=当前仍未处理的失败，历史FAIL返回保留于逐条数据，不抹成网站PASS。',
                                  '命名声明按公理依赖分为定义/已证/未证；含未证依赖的定义亦保守归入未证。',
                                  'sorry为代码中直接占位的词数；sorry_raw_grep含注释，二者另列；未证数包含传递依赖。',
                                  'errata_sections为编号二级节总数，包含范围/解释；potential_book_issue_sections排除明确说明记录，尚未经导师裁定。',
                                  '缺大理论沿用既有逐声明理由，也包含必要衔接；归组是规划索引，不表示Mathlib必定没有相关理论。'],
                  self_checks=dict(source_progress_website_ids_equal=True, declaration_coverage_equal=True,
                                   declaration_partition=True, unproved_reason_partition=True, website_partition=True, sorry_equals_ripgrep=True),
                  source_sha256={**provenance, **{p: sha(p) for p in ['docs/review/book/BOOK_PAGE_RANGES.json', 'docs/review/book/BOOK_SUPPLEMENTAL_DECLARATIONS.json']}})
    dump('docs/review/book/BOOK_STATS.json', result)
    dump('docs/review/book/BOOK_DECLARATIONS.json', all_decls)
    dump('docs/review/book/BOOK_ITEMS.json', items)
    dump('docs/review/book/BOOK_ERRATA_RECORDS.json', all_errata)
    fields = ['chapter', 'printed_pages', 'pdf_pages', 'entry_printed_pages', 'entry_pdf_pages', *numeric, 'legacy_claims_rows', *REASONS.values(), 'partition_equation']
    with (OUT/'BOOK_STATS.csv').open('w', encoding='utf-8-sig', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=fields, extrasaction='ignore'); writer.writeheader()
        for row in rows + [dict(chapter='全书', **totals)]: writer.writerow(dict(row, **row['unproved_reasons']))
    diff = ['# 全书统计口径与既有摘要对照', '', '本文件由 scripts/book_stats.py 生成；各章原摘要不修改。', '',
            '“条目”统一为正文来源编号，不等于命名声明或旧CLAIMS表行数。第2章160条按此口径仍是160条；旧摘要需更正的是通过数与人工数的交叠，而非强行改动条目总数。', '',
            '|章|字段|旧摘要/统计来源|本次重算|比较|', '|---|---|---:|---:|---|']
    for d in differences: diff.append(f'|{d["chapter"]}|{d["field"]}|{d["old"]}|{d["recomputed"]}|{"差异" if d["different"] else "一致"}|')
    diff += ['', '## 差异原因与边界', '',
             '第2–5章的旧网站通过数保留了历史/限定版本的PASS，同组又进入当前待导师清单。本次以每条effective_status的最终处置互斥计数；不将修正版获认可等同于整条无疑误。',
             '第4、5章各2条仅完成缺失摘录的本地核对，另列local_excerpt_verified，既不算网站PASS，也不算改签名修复。',
             '旧“需人工”有时来自ERRATA关联编号并集，有时来自网站当前条目，二者不同。分章差值均可在BOOK_ITEMS.json逐条重算。',
             '条目数、声明数和未证原因均从逐条/逐声明重算，不照抄各章总数。完整比较表同时展示一致项，避免误称第2章160条本身错误。', '',
             '第8章旧声明抽取模式未包括inductive，漏计算法阶段枚举MD.Ch08.SINStage。新统计计作1项定义，定义285→286、命名声明396→397；对未改全文追加只读#print axioms核验，不依赖任何公理。证明数与未证数不受影响。',
             '正文物理页界由教材章首/Exercises书签及原页前缀生成；第1章46页、第7章326页仍有正文讨论或图注，但原章数学条目分别止于45、325页。此处仅补页界说明，不宣称新增数学条目。', '',
             '## 原返回与当前互斥处置不同的条目', '',
             '以下逐条显示原始audit字段与最终effective_status不同的处置；历史返回不抹除，本次最终通过数以当前整条状态为准。不同阶段的原始字段不应当再次相加。', '',
             '|章|source_id|原audit判定|当前计数类|原因|', '|---|---|---|---|---|']
    for item in items:
        raw = item['raw_verdict']; category = item['category']
        if (raw == 'PASS') != (category == 'website_pass') or raw == 'FAIL':
            why = ('整条仍含原文疑误或资格问题，不把部分/历史PASS当作无疑整条' if category == 'needs_human' else
                   '原FAIL已按意见修复、本地核验，未再次送审；保留原报告' if category == 'local_repairs' else
                   '后来附件/复审认可写在当前状态中，旧audit字段保留' if category == 'website_pass' else '摘录本地核对单列')
            diff.append(f'|{item["chapter"]}|{item["source_id"]}|{raw}|{category}|{why}|')
    diff += ['',
             '## 未完成证明与直接占位', '', '|章|未证声明（含传递依赖）|代码sorry词数|原文件rg词数（含注释）|', '|---|---:|---:|---:|']
    for r in rows: diff.append(f'|{r["chapter"]}|{r["unproved"]}|{r["sorry"]}|{r["sorry_raw_grep"]}|')
    diff += ['', '两个sorry字段各按其明示范围核验；原文档中的解释性sorry不算代码占位。']
    (OUT/'BOOK_STATS_DIFF.md').write_text('\n'.join(diff)+'\n', encoding='utf-8')
    print(json.dumps(dict(total=totals, checks=result['self_checks']), ensure_ascii=False, indent=2))


if __name__ == '__main__':
    run()
