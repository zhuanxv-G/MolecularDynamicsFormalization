"""Build a short prompt and source-preserving attachments for one frozen batch.

This exports review excerpts, not a standalone Lean module. Existing batches,
source JSON and Lean declarations are not changed.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path

from pypdf import PdfReader, PdfWriter
from ch01_full_tools import declarations

ROOT = Path(__file__).resolve().parents[1]
TASKS = ROOT / 'blueprint/ch01/mathcopilot_tasks'
COMMAND = re.compile(
    r'(?m)^(?:(?:noncomputable|private|protected|unsafe|partial) +)*'
    r'(?:def|abbrev|structure|class|theorem|lemma|instance|namespace|end|'
    r'open|variable|local|set_option|attribute|notation|scoped|#\w+)\b'
)
DEFINITION = re.compile(
    r'(?m)^(?:(?:noncomputable|private|protected) +)*'
    r'(?:def|abbrev|structure|class) +([\w.\u2080-\u2089]+)'
)


def sha(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def uncomment(text: str) -> str:
    # Dependency names inside explanatory comments must not pull in unrelated code.
    text = re.sub(r'/\-[\s\S]*?\-/', '', text)
    return re.sub(r'--[^\n]*', '', text)


def definitions(paths: list[str]) -> dict:
    result = {}
    for relative in paths:
        text = (ROOT / relative).read_text(encoding='utf-8-sig')
        for match in DEFINITION.finditer(text):
            next_command = COMMAND.search(text, match.end())
            end = next_command.start() if next_command else len(text)
            code = text[match.start():end].rstrip()
            # A following declaration's doc comment belongs to that declaration.
            while code.endswith('-/'):
                opening = code.rfind('/-')
                if opening < 0:
                    break
                code = code[:opening].rstrip()
            namespace_matches = list(re.finditer(r'(?m)^namespace ([\w.]+)', text[:match.start()]))
            namespace = namespace_matches[-1].group(1) if namespace_matches else ''
            name = match.group(1)
            item = dict(name=name, namespace=namespace, code=code, path=relative,
                        line=text[:match.start()].count('\n') + 1)
            result.setdefault(name, []).append(item)
    return result


def referenced(text: str, index: dict) -> set[str]:
    tokens = set(re.findall(r'[\w\u2080-\u2089]+(?:\.[\w\u2080-\u2089]+)*', uncomment(text)))
    return {token for token in tokens if token in index}


def build(batch_name: str, part: str | None = None) -> None:
    batches = json.loads((TASKS / 'MANIFEST.json').read_text(encoding='utf-8-sig'))
    batch = next(b for b in batches if b['batch'] == batch_name)
    for path, digest in batch['files'].items():
        if sha(ROOT / path) != digest:
            raise ValueError('Frozen input changed: ' + path)
    if sha(TASKS / (batch_name + '.md')) != batch['task_sha256']:
        raise ValueError('Frozen batch changed')
    pdf = next(ROOT.parent.glob('Leimkuhler2015b*.pdf'))
    if sha(pdf) != batch['source_pdf_sha256']:
        raise ValueError('Source PDF changed')

    source = {s['source_id']: s for s in json.loads(
        (ROOT / 'blueprint/ch01/ch01_source.json').read_text(encoding='utf-8-sig'))}
    items = [source[sid] for sid in batch['source_ids']]
    if part is not None:
        if batch_name != 'BATCH01':
            raise ValueError('Named subparts currently apply to BATCH01 only')
        selection = {'a': slice(0, 1), 'b': slice(1, 3), 'c': slice(3, 5)}
        items = items[selection[part]]
    export_name = batch_name + (part or '')
    ds = declarations()
    index = definitions(['Blueprint/Ch01.lean', *(
        p for p in batch['files'] if p.startswith('MolecularDynamics/'))])
    index.update(definitions(['.lake/packages/mathlib/Mathlib/Analysis/ODE/Basic.lean']))
    selected = {}
    pending = referenced('\n'.join(ds[s['source_id']]['statement'] for s in items), index)
    while pending:
        name = sorted(pending)[0]
        pending.remove(name)
        if name in selected:
            continue
        choices = index[name]
        if len(choices) != 1:
            raise ValueError('Ambiguous definition; review explicitly: ' + name)
        selected[name] = choices[0]
        pending.update(referenced(choices[0]['code'], index) - selected.keys())

    # Include primary pages, the preceding setup, and original-page references
    # in notation/assumption context. Numbers in equations do not become pages.
    pages = set()
    primary = set()
    for s in items:
        numbers = [int(n) for n in re.findall(r'\d+', s['pdf_page'])]
        primary.update(range(numbers[0], numbers[-1] + 1))
        context = json.dumps([s.get('context_notation'), s.get('extra_assumptions')], ensure_ascii=False)
        for match in re.finditer(r'PDF\s*(?:p\.?\s*)?(\d+)(?:[–—\-](\d+))?', context):
            lo = int(match.group(1))
            hi = int(match.group(2) or lo)
            pages.update(range(lo, hi + 1))
    for page in primary:
        pages.update((page - 1, page))
    pages = sorted(p for p in pages if 24 <= p <= 68)
    destination = TASKS / 'compact' / batch_name
    if part is not None:
        destination = destination / part
    destination.mkdir(parents=True, exist_ok=True)
    materials_name = export_name + '_MATERIALS.md'
    pages_name = export_name + '_PAGES.pdf'
    mapping = [{'attachment_page': i + 1, 'original_pdf_page': p, 'printed_page': p - 23}
               for i, p in enumerate(pages)]
    prompt = (
        f'请对附件 {materials_name} 中的 {len(items)} 条做独立审校，原页见 {pages_name}；'
        '原PDF/印刷页与附件页的映射在材料开头。\n'
        'A：逐字核对原文陈述、证明和上下文，原书疑误保留并指出。\n'
        'C：核对Lean实际定义、对象、量词、假设及全部结论，评估[EXTRA]；'
        '签名语义与是否sorry分开判断。只读，不改文件或补证明。材料不足写NEEDS_HUMAN，勿猜。\n'
        '仅返回一个JSON数组，每条字段：source_id，'
        'json_review{status,issue_codes,corrected_json,issues,evidence}，'
        'audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。'
        'status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。'
        'corrected_json有修订时给完整条目；无修订、反例或修复建议填null。证据标原PDF页及具体依据。'
        '无围栏或额外文字。\n'
    )
    (destination / 'PROMPT.txt').write_text(prompt, encoding='utf-8')

    lean_text = (ROOT / 'Blueprint/Ch01.lean').read_text(encoding='utf-8-sig')
    materials = [f'# {export_name} 精简审校材料', '',
        '本批只做原文审校A与只读语义审计C；模板B取消。Lean4.34.0 / Mathlib v4.34.0。',
        '以下原文JSON、Lean签名及依赖定义从冻结输入逐字截取；没有改写定义或假设。',
        '这是供审阅的摘录，不是独立Lean工程；未提供定理证明体，不能据此审计证明或公理。',
        '标准Mathlib运算/微积分符号按该固定版本解释，关键ODE定义另附。',
        '', '## PDF页码映射', '', '| 附件页 | 原PDF页 | 印刷页 |', '|---|---|---|']
    materials += [f"| {m['attachment_page']} | {m['original_pdf_page']} | {m['printed_page']} |"
                  for m in mapping]
    materials += ['', '## 审校规则', '',
        'A：逐条打开原页，核对statement_latex、proof_latex、proof_discussion_latex、页码和context_notation。'
        '不得把转述当原文，不静默修正原书，不补造原文证明；null表示无独立完整证明。'
        'corrected_json需保留完整条目及source_id；证据指出原PDF页和具体短语/公式。',
        'C：以A核对后的原文比对实际定义展开、对象/域、量词、假设和全部结论；'
        '逐条判断[EXTRA]是否合理、[ERRATUM?]是否需导师判断。'
        '禁止以True、P→P、结论作假设、替换对象通过审计。'
        'sorry与签名语义分开判断；只读，不修改工程或写证明；给出具体理由、反例和建议。'
        '所需上下文/定义缺失时标NEEDS_HUMAN并列缺项，不能按名称猜测或跳过。',
        '本材料未附本地PASS结果，不得假定本地结论正确。',
        '', '## 本批完整原文条目与Lean签名', '']
    excerpts = []
    for s in items:
        sid = s['source_id']
        marker = re.search(r'/-- source_id:\s*' + re.escape(sid) + r'[\s\S]*?-/', lean_text)
        if marker is None:
            raise ValueError('Missing source comment: ' + sid)
        signature = ds[sid]['statement']
        assert signature in lean_text
        materials += ['### ' + sid, '', '```json', json.dumps(s, ensure_ascii=False, indent=2),
                      '```', '', '声明全名：`' + ds[sid]['name'] + '`；原位置：Blueprint/Ch01.lean。',
                      '', '```lean', marker.group(0), signature, '```', '']
        excerpts.append(dict(source_id=sid, lean_decl=ds[sid]['name'],
                             source_entry_sha256=hashlib.sha256(json.dumps(
                                 s, ensure_ascii=False, sort_keys=True).encode()).hexdigest(),
                             signature_sha256=ds[sid]['signature_sha256']))
    materials += ['## 实际依赖定义（逐字摘录）', '',
        '原Blueprint处于namespace MD.Ch01，open Set MolecularDynamics MeasureTheory '
        'MolecularDynamics.Chapter01Review Filter；open scoped ContDiff InnerProductSpace '
        'BigOperators Topology Matrix.Norms.L2Operator。n表示配置坐标数N_c；三维原子模型中N_c=3N。',
        '每段的namespace和文件路径仅说明原上下文，定义体保持原样。', '']
    for name, d in sorted(selected.items()):
        assert d['code'] in (ROOT / d['path']).read_text(encoding='utf-8-sig')
        materials += ['### ' + (d['namespace'] + '.' if d['namespace'] else '') + name, '',
                      f"原文件：{d['path']}:{d['line']}。", '']
        if name == 'IsIntegralCurveOn':
            materials += ['原上下文：`open Set`，`variable {E : Type*} '
                          '[NormedAddCommGroup E] [NormedSpace ℝ E]`。', '']
        materials += ['```lean', d['code'], '```', '']
    materials += ['## 返回格式', '', '仅输出一个JSON数组；每个source_id恰好一次。', '', '```json',
        '[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN",'
        '"issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},'
        '"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN",'
        '"explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]', '```', '']
    (destination / materials_name).write_text('\n'.join(materials), encoding='utf-8')

    reader = PdfReader(pdf)
    writer = PdfWriter()
    writer.add_metadata({'/Title': export_name + ' original textbook pages',
                         '/Subject': 'Original PDF pages: ' + ', '.join(map(str, pages))})
    for page in pages:
        exported_page = writer.add_page(reader.pages[page - 1])
        exported_page.compress_content_streams(level=9)
    writer.compress_identical_objects()
    writer.write(destination / pages_name)
    exported = PdfReader(destination / pages_name)
    for offset, page in enumerate(pages):
        original = reader.pages[page - 1]
        copy = exported.pages[offset]
        assert original.extract_text() == copy.extract_text(), ('PDF text differs', page)
        assert original.get_contents().get_data() == copy.get_contents().get_data(), ('PDF content differs', page)
        assert list(original.mediabox) == list(copy.mediabox), ('Page dimensions differ', page)
    sizes = {p.name: p.stat().st_size for p in destination.iterdir()
             if p.name in ('PROMPT.txt', materials_name, pages_name)}
    if sizes['PROMPT.txt'] > 2000 or sizes[materials_name] > 100000 or sum(sizes.values()) >= 256000:
        raise ValueError('Compact text exceeds conservative local budget')
    report = dict(batch=batch_name, subtask=export_name, git_commit=subprocess.check_output(
        ['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
        frozen_task_sha256=batch['task_sha256'], frozen_source_files=batch['files'],
        source_pdf_sha256=batch['source_pdf_sha256'], source_ids=[s['source_id'] for s in items],
        excerpts=excerpts, definitions=[dict(d, code_sha256=hashlib.sha256(d['code'].encode()).hexdigest())
                                     for d in selected.values()],
        page_mapping=mapping, files={name: dict(bytes=size, sha256=sha(destination/name))
                                   for name, size in sizes.items()},
        validation={'frozen_input_hashes': 'PASS', 'verbatim_source_and_signature': 'PASS',
                    'verbatim_definition_excerpts': 'PASS', 'pdf_text_content_and_dimensions': 'PASS',
                    'website_acceptance': 'NOT_TESTED'})
    (destination / 'MANIFEST.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    (destination / 'README.md').write_text(
        f'# {export_name} 精简提交\n\n'
        f'1. 新建一个Task，上传`{materials_name}`和`{pages_name}`。\n'
        '2. 仅复制`PROMPT.txt`全文到输入框。附件需在当前Task中可读取/引用。\n'
        '3. 结果原样保存到blueprint/ch01/mathcopilot_results/，命名`' + export_name + '_result.json`，或发给Codex。\n\n'
        '本批材料已含这几条完整JSON、Lean签名、注释及实际依赖定义；书页已裁出并附原页码映射。\n'
        '本地检查通过；网站256KB限制如何计算及实际接收尚未验证。\n\n'
        '| 文件 | 字节 |\n|---|---|\n' + ''.join(f'| {n} | {v} |\n' for n,v in sizes.items()),
        encoding='utf-8')
    print(json.dumps({'batch': export_name, 'sizes': sizes, 'definitions': sorted(selected),
                      'pages': pages, 'validation': report['validation']}, ensure_ascii=False))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--batch', default='BATCH01')
    parser.add_argument('--part', choices=['a', 'b', 'c'], default='a')
    args = parser.parse_args()
    build(args.batch, args.part)
