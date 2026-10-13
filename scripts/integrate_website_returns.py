"""Bind website returns under the user's 2026-10-13 rules; never edit Lean/source.

Raw files and prior receipts remain immutable. Re-running reuses recorded binding
evidence, so later repairs cannot silently rebind old PASS to a new signature.
"""
import copy
import hashlib
import json
import re
import subprocess
from collections import Counter
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BUNDLES = ROOT.parent / 'mathcopilot_bundles'
QUESTIONS = {
    'MD-1.4-ConvexLegendre': 'Legendre变换采用扩展实数，还是在实值版本显式增加有限性条件？选项：EReal推广 / 实值加有界性。',
    'MD-1.5.2-TorusDense': '原句的稠密性限定为全整数无共振，还是改述为相应子环面上的稠密性？选项：全维加无共振 / 子环面版本。',
    'MD-1.5.2-LocalActionAngleReduction': '是否采用紧、连通、非空正则共同水平集上的作用角结论？选项：批准明确资格 / 保留字面疑误待定。',
    'MD-1.5.3-HartmanGrobmanLiteral': '原书光滑共轭应勘误为局部同胚，还是保留并补充光滑线性化条件？选项：同胚勘误 / 光滑加条件。',
    'MD-1.7-TrimerEscapeLiteral': '原文逃逸指每个粒子逃逸还是系统直径无界？选项：逐粒子原句登记错误 / 另立系统分离命题待审。',
    'MD-1.7.1-TransitivityErgodicityLiteral': '如何裁定拓扑传递与遍历性的字面等价？选项：仅保留疑误 / 另立满支撑测度下的单向结果。',
    'MD-1.7.2-VariationalEquationLiteral': '是否另立标准变分矩阵W(t)=DF_t(ζ)的勘误版本？选项：批准另立 / 保留字面疑误。',
    'MD-1.7.2-NearbyTrajectoryLiteral': '是否把导数取值点另行勘误为DF_t(ζ)？选项：批准另立 / 保留字面疑误。',
    'MD-2.2.1-Admissible': '闭区间容许曲线采用C²还是C∞，并用哪种延拓解释？选项：C²区间资格 / C∞存在光滑延拓。',
    'MD-2.4.5-ConjugateLimits': 'equivalent stability properties是否包含一般稳定性的双向等价？选项：完整稳定性 / 仅共同极限例子。',
    'MD-3.1-ShadowEllipses': 'slightly要求形状扰动还是还要求主轴转角趋零？选项：形状扰动 / 非圆分支转角趋零。',
    'MD-3.2-FiniteLieTaylor': '原等号采用Taylor jet渐近解释还是仅形式系数解释？选项：Taylor jet / 形式系数另立余项定理。',
    'MD-3.2-FlowCoordinates': '实际流与形式exp采用何种连接？选项：逐初值Taylor jet / 形式拉回逐系数关系。',
    'MD-3.4-AnalyticDefect': '原文允许哪些方法类及解析邻域，有限阶与指数结论的范围如何确定？选项：导师指定方法和范围 / 保留未定。',
    'MD-3.7.3-PairForceDecoupling': '文字与公式不一致时哪个势是kick势？选项：按文字另立勘误 / 按公式另立勘误。',
}


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def dump(p, value):
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')


def read(p):
    return json.loads(p.read_text(encoding='utf-8-sig'))


def git(*args):
    return subprocess.check_output(['git', *args], cwd=ROOT, text=True, encoding='utf-8').strip()


def display(w):
    b = w['binding']
    if not b['bound']:
        return '待网站审计（' + '; '.join(b['reasons']) + '）'
    if w.get('repair', {}).get('status') == 'awaiting_reaudit':
        return '待复审 / ' + w['repair']['eaudit']
    v = w['audit']['verdict']
    return ('网站PASS' if v == 'PASS' else v) + '（绑定版本 ' + b['version'] + '）'


def binding(ch, path, data, manifest):
    lean = f'Blueprint/Ch{ch:02}.lean'
    batch = data.get('batch') if isinstance(data, dict) else path.stem.split('_')[0]
    mp = ROOT / f'blueprint/ch{ch:02}/mathcopilot_tasks/MANIFEST.json'
    bp = mp.parent / (batch + '.md')
    cutoff = git('log', '-1', '--format=%H', '--', path.relative_to(ROOT).as_posix()) or git('rev-parse', 'HEAD')
    generation = git('log', '-1', '--format=%H', cutoff, '--', mp.relative_to(ROOT).as_posix())
    inputs = {'BATCH.md': sha(bp), lean: sha(ROOT / lean)}
    expected = data.get('input_sha256') if isinstance(data, dict) else None
    reasons = []
    checks = {}
    history = []
    if expected:
        dep = f'Ch{ch:02}_deps.txt'
        bundle_manifest = read(BUNDLES / 'BUNDLE_MANIFEST.json')
        actual_dep = sha(BUNDLES / dep)
        checks['bundle_manifest'] = actual_dep == bundle_manifest['files'][f'mathcopilot_bundles/{dep}']
        inputs[dep] = actual_dep
        required = {'BATCH.md', lean, dep}
        aliases = {batch + '.md': 'BATCH.md', f'mathcopilot_bundles/{dep}': dep}
        normalized = {aliases.get(k, k): v for k, v in expected.items()}
        for key in required | set(normalized):
            checks[key] = normalized.get(key) == inputs.get(key) and key in inputs
            if not checks[key]:
                reasons.append(key + ' SHA256不匹配或未提供')
        if not checks['bundle_manifest']:
            reasons.append('依赖合集与BUNDLE_MANIFEST不符')
        version = inputs[lean]
        rule = 'a'
    else:
        m = next(x for x in manifest if x['batch'] == batch)
        field = 'full_batch_sha256' if 'full_batch_sha256' in m else 'task_sha256'
        checks['full_batch_sha256'] = inputs['BATCH.md'] == m[field]
        if not checks['full_batch_sha256']:
            reasons.append('BATCH与MANIFEST完整批次哈希不符')
        history = git('log', '--format=%H', f'{generation}..{cutoff}', '--', lean).splitlines()
        checks['lean_unchanged'] = not history
        checks['generation_blob_matches'] = hashlib.sha256(subprocess.check_output(
            ['git', 'show', f'{generation}:{lean}'], cwd=ROOT)).hexdigest() == inputs[lean]
        if history or not checks['generation_blob_matches']:
            reasons.append('Blueprint在任务包生成至返回登记期间有修改')
        checks['manifest_hash_field'] = field
        version = generation[:12]
        rule = 'b'
    return dict(bound=not reasons, rule=rule, version=version, generation_commit=generation,
                registration_commit=cutoff, input_sha256=inputs, checks=checks,
                lean_modification_commits=history, reasons=reasons)


def integrate(ch):
    base = ROOT / f'blueprint/ch{ch:02}'
    sources = read(base / f'ch{ch:02}_source.json')
    src = {s['source_id']: s for s in sources}
    oldpath = base / 'website_audit.json'
    old = {w['source_id']: w for w in read(oldpath)} if oldpath.exists() else {}
    manifest = read(base / 'mathcopilot_tasks/MANIFEST.json')
    folder = base / 'mathcopilot_results'
    paths = sorted((folder / 'reaudit' if ch == 2 else folder).glob('BATCH*_result.json'))
    receiptpath = folder / 'binding20261013/RECEIPT.json'
    previous = read(receiptpath) if receiptpath.exists() else None
    hashes = {p.relative_to(ROOT).as_posix(): sha(p) for p in paths}
    if previous:
        assert hashes == previous['raw_files'], 'New or changed return requires a new receipt directory'
    bindings = previous['bindings'] if previous else {}
    output = {}
    for path in paths:
        rel = path.relative_to(ROOT).as_posix()
        data = read(path)
        items = data['items'] if isinstance(data, dict) else data
        batch = data['batch'] if isinstance(data, dict) else path.stem.split('_')[0]
        assert {i['source_id'] for i in items} == set(next(m['source_ids'] for m in manifest if m['batch'] == batch))
        bound = bindings.setdefault(rel, binding(ch, path, data, manifest)) if not previous else bindings[rel]
        first = {i['source_id']: i for i in read(folder / path.name)} if ch == 2 else {}
        for item in items:
            sid = item['source_id']
            assert sid in src and sid not in output
            assert item['audit']['lean_decl'] == src[sid]['lean_decl']
            assert item['audit']['verdict'] in {'PASS', 'FAIL', 'NEEDS_HUMAN'}
            w = dict(source_id=sid, json_review=copy.deepcopy(first.get(sid, item)['json_review']),
                     audit=copy.deepcopy(item['audit']), returned_audit=copy.deepcopy(item['audit']),
                     binding=copy.deepcopy(bound), raw_path=rel, raw_sha256=hashes[rel],
                     audit_round='reaudit' if ch == 2 else 'first',
                     json_review_round='first', json_review_raw_path=(folder / path.name).relative_to(ROOT).as_posix() if ch == 2 else rel)
            if ch == 2:
                w['first_round_reference_audit'] = first[sid]['audit']
            if sid in old and old[sid].get('repair'):
                w['repair'] = old[sid]['repair']
            fix = w['audit'].get('suggested_fix') or ''
            w['needs_category'] = '原文数学判断' if sid in QUESTIONS or re.search('人工|裁定|批准', fix) else '材料缺失'
            w['effective_status'] = display(w)
            output[sid] = w
    # The five original pilot returns predate EAUDIT01 and cannot be rebound to it.
    if ch == 1:
        for item in read(folder / 'review.json'):
            sid = item['source_id']
            w = copy.deepcopy(old[sid])
            w['binding'] = dict(bound=False, rule=None, version=None,
                                reasons=['旧试点对应修复前输入，EAUDIT01尚无返回'])
            w['effective_status'] = display(w)
            w['needs_category'] = '材料缺失'
            output[sid] = w
    assert set(output) == set(src), 'Incomplete chapter returns'
    counts = Counter()
    needs = ['# 网站NEEDS_HUMAN分流', '', '原始返回和完整理由见website_audit.json；以下问题未替导师作数学选择。', '', '## (i) 材料缺失：补材料后复审', '']
    material = []
    human = []
    for w in output.values():
        if not w['binding']['bound'] or w.get('repair', {}).get('status') == 'awaiting_reaudit':
            counts['awaiting_reaudit'] += 1
        elif w['audit']['verdict'] == 'PASS':
            counts['website_pass'] += 1
        elif w['audit']['verdict'] == 'FAIL':
            counts['repairing'] += 1
        elif w['needs_category'] == '原文数学判断':
            counts['awaiting_mentor'] += 1
        else:
            counts['awaiting_reaudit'] += 1
        if w['audit']['verdict'] == 'NEEDS_HUMAN':
            fix = w['audit'].get('suggested_fix') or ''
            text = QUESTIONS.get(w['source_id'], fix.replace('\n', ' '))
            entry = '- ' + w['source_id'] + '：' + text
            (human if w['needs_category'] == '原文数学判断' else material).append(entry)
    needs += material + ['', '## (ii) 原文数学判断：供导师裁定', ''] + human
    dump(oldpath, list(output.values()))
    (base / 'NEEDS_HUMAN.md').write_text('\n'.join(needs) + '\n', encoding='utf-8')
    summary = {k: counts[k] for k in ('website_pass', 'repairing', 'awaiting_mentor', 'awaiting_reaudit')}
    summary.update(chapter=ch, total=len(output), bound=sum(w['binding']['bound'] for w in output.values()),
                   raw_audit_counts=dict(Counter(w['returned_audit']['verdict'] for w in output.values())),
                   json_review_policy='first round only' if ch == 2 else 'first round')
    dump(base / 'WEBSITE_SUMMARY.json', summary)
    if not previous:
        dump(receiptpath, dict(registered_at=datetime.now().isoformat(), raw_files=hashes, bindings=bindings,
                              source_sha256=sha(base / f'ch{ch:02}_source.json'), lean_sha256=sha(ROOT / f'Blueprint/Ch{ch:02}.lean'),
                              first_json_review_files={p.name: sha(folder / p.name) for p in paths} if ch == 2 else {}))
    progress = base / 'PROGRESS.md'
    lines = progress.read_text(encoding='utf-8-sig').splitlines()
    for i, line in enumerate(lines):
        if line.startswith('| MD-'):
            cells = line.split('|')
            w = output.get(cells[1].strip())
            if w and len(cells) == 8:
                cells[5] = ' ' + w['effective_status'] + ' '
                lines[i] = '|'.join(cells)
    marker = '网站整合汇总：'
    message = f'网站整合汇总：网站PASS {counts["website_pass"]} / 修复中 {counts["repairing"]} / 待导师 {counts["awaiting_mentor"]} / 待复审 {counts["awaiting_reaudit"]}。'
    lines = [x for x in lines if not x.startswith(marker)]
    lines.insert(6, message)
    progress.write_text('\n'.join(lines) + '\n', encoding='utf-8')
    print(f'Ch{ch:02}: {message} bound {summary["bound"]}/{len(output)}')
    return summary


if __name__ == '__main__':
    for chapter in (1, 3, 2):
        integrate(chapter)
