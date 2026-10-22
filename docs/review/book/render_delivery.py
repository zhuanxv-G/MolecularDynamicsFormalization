"""Build instruction-35 report/package and validate their links without rerunning Lean.

Requires check_md_math.py to pass first. Historical instruction-34 receipts stay intact.
"""
import hashlib
import json
import re
import subprocess
import zipfile
from collections import Counter
from pathlib import Path
from urllib.parse import unquote, urlparse

ROOT=Path(__file__).resolve().parents[3]
OUT=ROOT/'docs/review/book'
TAG='book-ch01-08-render'
REPO='https://github.com/zhuanxv-G/MolecularDynamicsFormalization'
NOTICE='本版本修复了 GitHub 上的公式渲染；数学内容与 book-ch01-08-summary 相同。'


def read_json(p): return json.loads(p.read_text(encoding='utf-8-sig'))
def save(p,x): p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')


def report():
    check=read_json(OUT/'BOOK_RENDER_CHECK.json');assert check['status']=='PASS'
    edits=read_json(OUT/'CH08_RENDER_EDITS.json')
    source=ROOT/'.git/render35/initial_counts.json'
    baseline=read_json(source if source.exists() else OUT/'BOOK_RENDER_BASELINE.json')
    save(OUT/'BOOK_RENDER_BASELINE.json',baseline)
    p=OUT/'BOOK_RENDER_FIX.zh-CN.md';old=p.read_text(encoding='utf-8')
    # Keep the symbol table written before chapter-8 editing began.
    top=old.split('## 验收状态')[0]
    lines=[top.rstrip(),'','## 验收状态','',
           '2026-10-22：8项自检全部通过；第8章 `[RENDER?]` 为0，剩余未解释内容差异为0。',
           '只修改公式分隔符、记号写法和必要排版；全部既有二、三级标题及代码块与基线逐字节一致。',
           'Git基线为 `de3b2539`；1,367个已跟踪Lean文件内容与该版本相同，并与接管时原字节快照一致。正式库298个文件为0 sorry、0 axiom声明。Lean源码未变，本轮未重跑完整构建，沿用既有编译证据。','',
           '## 重新计数与各章修改数量','',
           '旧显示分隔符合计1,390对，旧行内分隔符1对。CH01表格为75个受影响行、95段公式；“75处”是行数，不能当作公式段数。',
           '1,295段旧显示公式改为独立公式，95段表格公式改为行内公式；第5章另有1段原有跨行行内公式改为独立公式，因此现有独立公式共1,296段。','',
           '|文件|旧显示公式|其中跨行|表格受影响行|转换后独立公式|转换后行内公式总数|','|---|---:|---:|---:|---:|---:|']
    for row in baseline:
        c=check['counts'][row['file']]
        lines.append(f'|{Path(row["file"]).stem}|{row["display"]}|{row["multiline"]}|{row["table"]}|{c["after_display"]}|{c["after_inline"]}|')
    lines+=['','行内公式总数包含原有公式；完整初始计数见 [BOOK_RENDER_BASELINE.json](BOOK_RENDER_BASELINE.json)。','',
            '|第8章文件|新增行内公式|人工改写差异片段|涉及章节条目|','|---|---:|---:|---:|']
    for kind in ['BLUEPRINT','ERRATA']:
        file=f'docs/review/CH08_{kind}.zh-CN.md';xs=[x for x in edits if x['file']==file]
        lines.append(f'|CH08_{kind}|{check["counts"][file]["after_inline"]}|{len(xs)}|{len({x["entry"] for x in xs})}|')
    lines+=['','人工片段按Git逐行差异分组计数，不把重复引文误算成独立数学结论。',
            '第8章正文103条全部逐条对照英文摘要与PDF原页；PDF350–420（印刷329–399，420页仅核对Exercises之前正文）已查看。ERRATA31节及末尾范围汇总中的重复公式同文同步，原印版与修正版始终分开。','',
            '## 自检8项','',
            '|项目|结果|','|---|---|',
            '|1 代码块外旧数学分隔符|0|','|2 每行美元符成对、显示分隔符独占行|通过|',
            '|3 每个独立公式主体只有一行|通过|','|4 表格公式无裸竖线|通过|',
            '|5 行内公式边缘无空白|通过|','|6 既有二、三级标题与Git基线相同|通过|',
            '|7 全部代码块与Git基线逐字节相同|通过|','|8 全文去分隔符/空白比较及人工记号差异复核|通过；未解释差异0|','',
            '完整机器结果见 [BOOK_RENDER_CHECK.json](BOOK_RENDER_CHECK.json)。第1–7章及其他文档的比较只容许分隔符、引用符、空白、竖线写法、文字下划线转义和公式编号排版。第8章另要求精确前后记录匹配，且独立记号规范化比对相等；不会整章跳过检查。',
            '规范化比对用于发现转写差异，不是数学定理验证，也不能单凭它确认上下标位置；上下标及原书疑误由逐条原页核对约束。','',
            '## 必要排版修复','',
            '- 第1章表格里的公式编号保持可见，用普通公式文字编号代替行内不支持的编号命令；范数的表格竖线改为单个命令，消除Markdown转义层。',
            '- 第4、6章一个公式块内的多个编号改为文字编号，编号和各条公式次序不变。',
            '- 第5章两处伴随符号与后续变量之间补命令间空格；另把原有五行行内公式合并为独立公式。',
            '- 第8章原写 `Γhat` 按同条噪声对象写作帽号Γ；`p½` 依PDF411页表示半步动量，采用下标 `p_{1/2}`；原印符号疑误、遗漏因子和原有范围限定均不修订。',
            '- 6,125段公式经KaTeX 0.16.22解析，错误0；这是附加语法检查，GitHub页面目视抽查另行记录。','',
            '## 第8章人工改写条目与原页','',
            '全部339个精确前后差异片段（含原行号、条目和SHA256）见 [CH08_RENDER_EDITS.json](CH08_RENDER_EDITS.json)，供逐项人工抽查。下表列出涉及条目及各自页码。','',
            '|文件|条目|PDF页|差异片段|','|---|---|---|---:|']
    for file in sorted({x['file'] for x in edits}):
        source=subprocess.check_output(['git','show','de3b2539:'+file],cwd=ROOT).decode('utf-8').replace('\r\n','\n')
        for entry in dict.fromkeys(x['entry'] for x in edits if x['file']==file):
            block=source.split('## '+entry+'\n',1)[-1].split('\n## ',1)[0]
            page=re.search(r'PDF页?\s*([\d–—\-]+)',block)
            count=sum(x['file']==file and x['entry']==entry for x in edits)
            lines.append(f'|{Path(file).name.split(".")[0]}|{entry}|{page[1] if page else "见同条页码"}|{count}|')
    lines+=['','## 剩余待确认','',
            '渲染转写的 `[RENDER?]`：0。没有以猜测补入新公式。原书疑误的数学裁定与尚未完成的证明维持原状态，不因排版修复而视为通过。',
            '尚需用户在GitHub抽查阅读效果，然后交师兄。自动额度恢复接续尚未端到端实测。','',
            '## 交付','',
            f'固定标签：[本修复版本]({REPO}/tree/{TAG})。旧 `book-ch01-08-summary` 和 `book-ch01-08-closeout` 标签保持原对象不变。',
            '导航页、导师汇总、疑误索引等book辅助页与根README的审阅链接改指修复标签，避免从新导航跳回旧公式；离线包同名覆盖 `deliverables/book-ch01-08-docs.zip`，只含book汇总材料及8章SUMMARY/ERRATA，不含BLUEPRINT、Lean、Python脚本或缓存。','']
    p.write_text('\n'.join(lines),encoding='utf-8')


def links(ref=None):
    files=set(subprocess.check_output(['git','ls-tree','-r','--name-only',ref or 'HEAD'],cwd=ROOT).decode().splitlines())
    if not ref: files|={p.relative_to(ROOT).as_posix() for p in OUT.iterdir() if p.is_file()}
    bad=[];count=0;trees={TAG:files}
    for p in [ROOT/'README.md',*OUT.glob('*.md')]:
        for url in re.findall(r'\[[^\]]*\]\(([^)]+)\)',p.read_text(encoding='utf-8')):
            count+=1;u=urlparse(url);target=None
            if u.scheme:
                if url.rstrip('/')==REPO:continue
                if not url.startswith(REPO+'/'):continue
                parts=unquote(u.path).split('/')[3:]
                if parts[0] not in ['blob','tree']:continue
                version=parts[1]
                if len(parts)==2:continue
                target='/'.join(parts[2:])
                if version not in trees:trees[version]=set(subprocess.check_output(['git','ls-tree','-r','--name-only',version],cwd=ROOT).decode().splitlines())
                ff=trees[version]
            else:
                if not u.path:continue
                target=(p.parent/unquote(u.path)).resolve().relative_to(ROOT.resolve()).as_posix();ff=files
            if target not in ff:bad.append([str(p.relative_to(ROOT)),url])
    assert not bad,bad
    return dict(checked=count,broken=bad,reference=ref or 'prospective render tag')


def archive():
    paths={f'book/{p.name}':p for p in OUT.iterdir() if p.is_file() and p.suffix not in ['.py','.pdf','.lean']}
    for ch in range(1,9):
        for kind in ['SUMMARY_FOR_MENTOR','ERRATA']:
            name=f'CH{ch:02}_{kind}.zh-CN.md';paths[name]=ROOT/'docs/review'/name
    p=ROOT.parent/'deliverables/book-ch01-08-docs.zip';p.parent.mkdir(exist_ok=True)
    with zipfile.ZipFile(p,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for name,file in sorted(paths.items()):z.writestr(name,file.read_bytes())
    with zipfile.ZipFile(p) as z:
        assert z.testzip() is None and set(z.namelist())==set(paths)
        assert all(z.read(n)==f.read_bytes() for n,f in paths.items())
    return dict(path=str(p),files=len(paths),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest(),crc_passed=True,contents_equal=True)


if __name__=='__main__':
    import argparse
    parser=argparse.ArgumentParser();parser.add_argument('--report',action='store_true');parser.add_argument('--ref');a=parser.parse_args()
    if a.report:report()
    result=dict(links=links(a.ref),archive=archive())
    save(ROOT/'.git/render35/DELIVERY.json',result)
    print(json.dumps(result,ensure_ascii=False,indent=2))
