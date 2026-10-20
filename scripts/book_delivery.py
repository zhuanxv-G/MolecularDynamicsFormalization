"""Check frozen inputs, fixed-version links and the lightweight offline archive.

Before commit: python scripts/book_delivery.py --build
After tagging: python scripts/book_delivery.py --ref book-ch01-08-summary
The latter writes a publication receipt under .git/book34, never edits the tag.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import zipfile
from pathlib import Path, PurePosixPath
from urllib.parse import unquote, urlparse

from book_stats import ROOT, OUT, load, read, dump, clean
from book_report import TAG, REPO

ZIP = ROOT.parent / 'deliverables/book-ch01-08-docs.zip'
FORBIDDEN = r'heartbeat|EAUDIT|批次|任务包|哈希|\bR[1-9]\b|Codex|提示词编号|sorryAx|checked\+documented|字节预算'


def git(*args, raw=False):
    data = subprocess.check_output(['git', *args], cwd=ROOT)
    return data if raw else data.decode('utf-8').strip()


def tracked(ref):
    return git('ls-tree', '-r', '--name-only', ref).splitlines()


def frozen():
    assert git('branch', '--show-current') == 'main'
    baseline = 'f4ea1f7b'
    files = tracked(baseline)
    lean = [p for p in files if p.endswith('.lean')]
    protected_docs = [p for p in files if re.fullmatch(r'docs/review/CH0[1-8]_(BLUEPRINT|ERRATA|SUMMARY_FOR_MENTOR)\.zh-CN\.md', p)]
    # Git tests content equality against the requested revision. On Windows the checkout
    # contains pre-existing mixed line endings; raw bytes are independently checked below.
    git('diff', '--exit-code', baseline, '--', '*.lean', *protected_docs)
    raw_baseline_path = ROOT/'.git/closeout33/frozen.json'
    raw_byte_checks = dict(available=False)
    if raw_baseline_path.exists():
        previous = json.loads(raw_baseline_path.read_text(encoding='utf-8-sig'))
        protected = {p: h for p, h in previous.items() if p.endswith('.lean') or p in protected_docs}
        changed = [p for p, h in protected.items() if hashlib.sha256((ROOT/p).read_bytes()).hexdigest() != h]
        assert not changed, ('raw bytes changed', changed)
        assert set(lean + protected_docs) <= set(protected), 'incomplete raw-byte baseline'
        raw_byte_checks = dict(available=True, baseline='33号合并后工作区原字节快照（34号开始HEAD=f4ea1f7b）',
                               files=len(protected), changed=0,
                               note='Git对象与原工作区的既有CRLF差异不算本次变动；同时要求Git内容差异0及原工作区原字节差异0。')
    residual_path = ROOT/'.git/closeout33/residuals.json'
    residual_checks = dict(available=False)
    if residual_path.exists():
        residuals = json.loads(residual_path.read_text(encoding='utf-8-sig'))
        changed = [p for p, h in residuals.items() if not (ROOT/p).exists() or hashlib.sha256((ROOT/p).read_bytes()).hexdigest() != h]
        assert not changed, ('preexisting residual files changed', changed)
        residual_checks = dict(available=True, files=len(residuals), changed=0)
    formal = sorted((ROOT/'MolecularDynamics').rglob('*.lean'))
    sorry = sum(len(re.findall(r'\bsorry\b', clean(p.read_text(encoding='utf-8-sig')))) for p in formal)
    axioms = sum(len(re.findall(r'(?m)^\s*(?:(?:private|protected)\s+)*axiom\s', clean(p.read_text(encoding='utf-8-sig')))) for p in formal)
    assert sorry == axioms == 0
    oldreadme = git('show', baseline+':README.md', raw=True)
    newreadme = (ROOT/'README.md').read_bytes()
    assert newreadme.startswith(oldreadme), 'root README must only append'
    assert newreadme[len(oldreadme):].decode('utf-8').count('## 全书审阅入口') == 1
    # Revalidate the previously successful full-check report; never rerun unchanged proofs.
    oldreport = ROOT/'.git/closeout33/full-resume1/CHECK_REPORT.json'
    evidence = dict(prior_full_check='33号MERGE_33_VALIDATION.zh-CN.md；数学文件未变')
    if oldreport.exists():
        report = json.loads(oldreport.read_text(encoding='utf-8-sig'))
        evidence.update(report_sha256=hashlib.sha256(oldreport.read_bytes()).hexdigest(),
                        status=report.get('machine_check_status', report.get('status')))
        assert evidence['report_sha256'] == '60d07888988307ab7f06dd4da240ed8c77593f492ce883a3fd925ad7adc3a9ac'
    return dict(baseline=baseline, tracked_lean_files=len(lean), changed_lean_content=0,
                chapter_review_documents=len(protected_docs), changed_chapter_documents=0,
                original_checkout_bytes=raw_byte_checks, preexisting_residual_bytes=residual_checks, formal_library_files=len(formal),
                formal_sorry=sorry, formal_new_axiom_declarations=axioms,
                full_check_reused=evidence, full_check_rerun=False)


def anchor(heading):
    heading = re.sub(r'\[([^\]]+)\]\([^)]+\)', r'\1', heading)
    heading = heading.strip().lower().replace('`', '')
    return re.sub(r'[^\w\- ]', '', heading).replace(' ', '-')


def links(ref):
    if ref:
        files = set(tracked(ref))
    else:
        files = set(tracked('HEAD')) | {p.relative_to(ROOT).as_posix() for p in OUT.iterdir() if p.is_file()}
        files |= {'scripts/book_stats.py', 'scripts/book_report.py', 'scripts/book_delivery.py'}
    bad, checked, gh_checked = [], 0, 0
    # Validate every new book Markdown, while deliberately not rewriting legacy chapter docs.
    for p in sorted(OUT.glob('*.md')):
        text = p.read_text(encoding='utf-8-sig')
        for m in re.finditer(r'\[[^\]]*\]\(([^)]+)\)', text):
            url = m[1].strip('<>'); parsed = urlparse(url); checked += 1
            target = None
            if parsed.scheme in ['http', 'https']:
                if url.rstrip('/') == REPO: continue
                prefix = '/zhuanxv-G/MolecularDynamicsFormalization/'
                if parsed.netloc != 'github.com' or not parsed.path.startswith(prefix):
                    bad.append(dict(file=p.name, url=url, reason='unexpected external target')); continue
                parts = unquote(parsed.path[len(prefix):]).split('/')
                kind, version = parts[:2]
                if version not in [TAG, 'book-ch01-08-closeout']:
                    bad.append(dict(file=p.name, url=url, reason='not fixed allowed tag')); continue
                if kind == 'tree' and len(parts) == 2:
                    if version != TAG or ref: git('rev-parse', '--verify', version)
                    continue
                target = '/'.join(parts[2:]); gh_checked += 1
                target_files = files if version == TAG else set(tracked(version))
            else:
                # Resolve relative paths lexically within the repository.
                relative = PurePosixPath(p.relative_to(ROOT).as_posix()).parent / unquote(parsed.path)
                parts = []
                for part in relative.parts:
                    if part == '..':
                        if parts: parts.pop()
                    elif part != '.': parts.append(part)
                target = '/'.join(parts); target_files = files
            if target not in target_files:
                bad.append(dict(file=p.name, url=url, reason='file absent in target tree')); continue
            fragment = unquote(parsed.fragment)
            if fragment.startswith('L') and target.endswith('.lean'):
                line = int(fragment[1:]); count = len(read(target).splitlines())
                if not 1 <= line <= count: bad.append(dict(file=p.name, url=url, reason='line out of range'))
            elif fragment and target.endswith('.md'):
                headings = {anchor(h) for h in re.findall(r'^#{1,6}\s+(.+)$', read(target), re.M)}
                if fragment not in headings: bad.append(dict(file=p.name, url=url, reason='heading anchor absent'))
    assert not bad, json.dumps(bad[:20], ensure_ascii=False, indent=2)
    return dict(reference=ref or 'prospective summary tag file set; post-tag check required',
                checked_links=checked, github_file_links=gh_checked, broken_links=len(bad), broken=bad,
                heading_anchors_checked=True, lean_line_numbers_checked=True)


def package_mapping():
    paths = {f'book/{p.name}': p for p in OUT.iterdir() if p.is_file()}
    assert not any(p.suffix in ['.lean', '.py', '.pdf'] or 'BLUEPRINT' in p.name for p in paths.values())
    for ch in range(1, 9):
        for kind in ['SUMMARY_FOR_MENTOR', 'ERRATA']:
            name = f'CH{ch:02}_{kind}.zh-CN.md'; paths[name] = ROOT/'docs/review'/name
    return dict(sorted(paths.items()))


def archive(build):
    expected = package_mapping()
    if build:
        ZIP.parent.mkdir(parents=True, exist_ok=True)
        with zipfile.ZipFile(ZIP, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as z:
            for name, path in expected.items(): z.writestr(name, path.read_bytes())
    assert ZIP.exists()
    with zipfile.ZipFile(ZIP) as z:
        assert set(z.namelist()) == set(expected) and z.testzip() is None
        assert all(z.read(name) == p.read_bytes() for name, p in expected.items())
    return dict(path=str(ZIP), files=len(expected), bytes=ZIP.stat().st_size,
                sha256=hashlib.sha256(ZIP.read_bytes()).hexdigest(), crc_passed=True, payload_bytes_equal=True)


def run():
    parser = argparse.ArgumentParser(); parser.add_argument('--build', action='store_true'); parser.add_argument('--ref')
    args = parser.parse_args()
    stats = load('docs/review/book/BOOK_STATS.json')
    assert all(stats['self_checks'].values())
    for p, h in stats['source_sha256'].items(): assert hashlib.sha256((ROOT/p).read_bytes()).hexdigest() == h, p
    text = read('docs/review/book/BOOK_SUMMARY_FOR_MENTOR.zh-CN.md')
    forbidden = re.findall(FORBIDDEN, text, re.I); assert not forbidden, forbidden
    proof = frozen()
    if args.build:
        # Create the receipt before checking its own path and before packing it.
        receipt = dict(statistics_self_checks=stats['self_checks'], frozen=proof,
                       mentor_forbidden_term_matches=0, layout=load('.git/book34/LAYOUT.json'),
                       link_check=dict(broken_links=0, final_tag=TAG, post_tag_command=f'python scripts/book_delivery.py --ref {TAG}'),
                       offline_package=dict(name=ZIP.name, policy='book/全书汇总 + 8章SUMMARY_FOR_MENTOR与ERRATA；不含BLUEPRINT/.lean/过期短稿',
                                            final_checksum='保存于工程外最终验证收据，避免归档自包含校验值循环'),
                       not_verified=['导师疑误裁定', '623项未证声明的数学证明', '自动额度恢复接续端到端行为'],
                       note='最终标签内路径与远端在提交后再次检查，结果保存.git/book34/FINAL_VERIFICATION.json。')
        dump('docs/review/book/BOOK_VALIDATION.json', receipt)
        link_report = links(None); receipt['link_check'].update(link_report)
        dump('docs/review/book/BOOK_VALIDATION.json', receipt)
        zip_report = archive(True)
        result = dict(status='PASS', links=link_report, frozen=proof, archive=zip_report, mentor_forbidden_term_matches=0)
        dump('.git/book34/PREPUBLICATION.json', result)
    else:
        assert args.ref == TAG, '--ref must name the summary tag'
        result = dict(status='PASS', tag_commit=git('rev-parse', args.ref+'^{}'),
                      links=links(args.ref), frozen=proof, archive=archive(False), mentor_forbidden_term_matches=0)
        result['tag_is_on_main'] = subprocess.run(['git', 'merge-base', '--is-ancestor', args.ref, 'main'], cwd=ROOT).returncode == 0
        assert result['tag_is_on_main']
        dump('.git/book34/FINAL_VERIFICATION.json', result)
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    run()
