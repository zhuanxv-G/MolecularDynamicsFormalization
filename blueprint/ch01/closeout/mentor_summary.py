"""A concise mentor handout plus a measured two-page-limit rendering receipt."""
import sys,re,json,html,collections
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT/'scripts'))
from integrate_website_returns import read,dump,sha
BASE=ROOT/'blueprint/ch01';OUT=BASE/'validation/CLOSEOUT19'

def generate():
    report=read(OUT/'full/CHECK_REPORT.json');assert report['machine_check_status']=='passed'
    c=read(OUT/'DECLARATION_COUNTS.json');er=read(OUT/'ERRATA_RECORDS.json');a=read(BASE/'local_audit.json')['items'];groups=collections.Counter(x['final_status'] for x in a.values())
    corrected=collections.Counter(v for e in er for v in e['proof_status'].values())
    text='''# 第1章收口：导师审阅摘要

教材：Leimkuhler–Matthews，Molecular Dynamics，2015，第1章印刷p.1–45正文（习题排除）。本交付是完整的原文、Lean陈述、勘误对照和待审材料；仍含明确登记的未证明结论，不表示全章所有定理已经证明。

- 条目总数：141个source_id；网站既有/附件绑定PASS 48，当前待复审93，网站FAIL修复中0。20项导师疑误属于待复审的子集，不重复计数。
- Lean共194个命名声明：79项定义、69项已证定理、46项sorry。sorry分类：原书疑误原文版不证13；缺大型理论或必要桥接30；时间盒止3。含sorryAx的声明及整组一律incomplete。
- 逐条整组状态：self-contained 71；checked+documented priors 38；incomplete 32。整组含辅助声明，所以该计数与194项逐声明计数用途不同。
- 双版本覆盖20项疑误关联条目，共23个修正版声明：14项已证或定义完成，9项保留sorry。原有9项Literal定理签名逐token不变、继续sorry。新增字面版、修正版及反例独立命名；已证修正版不依赖sorryAx。Lean反例包括x⁴极小但二阶导为零、零势下非规则配置同样最小。

请重点核查：LJ力符号；任意凸函数共轭的扩展实数值域；环面无共振与作用角的紧正则共同水平集资格；Hartman–Grobman的同胚/光滑区别；Hessian半正定；角动量与角速度区别；三体逐粒子逃逸/系统分离；拓扑传递与测度遍历；变分矩阵导数取值点。Yukawa量纲、机械质量正定背景、相空间文字和等腰子模型也已登记。默认选项只是工作版本，未替导师裁定。

完整勘误单：[CH01_ERRATA.zh-CN.md](CH01_ERRATA.zh-CN.md)，每项含原句、印刷/PDF页、理由或反例、原文/修正版名称、证明状态、核查点及选项，可单独发第三方。

验证已通过：固定Lean 4.34.0 / Mathlib修订5ed2965256430c3649e86755f9576b54eca72435的单文件编译、194项公理核对及一次完整check；原文引用保持，现行93份包/20批的哈希、声明覆盖、裁页像素和字节预算通过，最大252937字节。正式库及第2–5章源码/源JSON冻结核验通过，正式库0 sorry。

尚未验证：当前93条的网站新复审、20项导师裁定、46项占位证明；heartbeat配置已读回，自动额度恢复接续未实测。

提交入口：[EAUDIT_INDEX.md](../../blueprint/ch01/mathcopilot_tasks/EAUDIT_INDEX.md)。完整验收记录：[DELIVERY_VALIDATION.json](../../blueprint/ch01/validation/CLOSEOUT19/DELIVERY_VALIDATION.json)。第6章停在批27 WIP，不进入第7章；提交推送后等待用户送审。
'''
    assert len(text)<2400
    path=ROOT/'docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md';path.write_text(text,encoding='utf-8')
    from reportlab.pdfbase import pdfmetrics
    from reportlab.pdfbase.ttfonts import TTFont
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.pagesizes import A4
    from reportlab.platypus import SimpleDocTemplate,Paragraph,Spacer
    # The local Windows font embeds actual glyphs; the render is a layout receipt.
    pdfmetrics.registerFont(TTFont('MentorCJK','C:/Windows/Fonts/simsun.ttc'))
    body=ParagraphStyle('body',fontName='MentorCJK',fontSize=10,leading=15,spaceAfter=7,wordWrap='CJK')
    title=ParagraphStyle('title',parent=body,fontSize=17,leading=24,spaceAfter=15)
    pdf=OUT/'mentor_summary_layout.pdf';story=[]
    for block in text.strip().split('\n\n'):
        st=title if block.startswith('# ') else body
        block=re.sub(r'\[([^\]]+)\]\([^)]+\)',r'\1',block.removeprefix('# '))
        story.append(Paragraph(html.escape(block).replace('\n','<br/>'),st))
    SimpleDocTemplate(str(pdf),pagesize=A4,leftMargin=42,rightMargin=42,topMargin=38,bottomMargin=38).build(story)
    import fitz
    doc=fitz.open(pdf);assert len(doc)<=2,len(doc)
    for i,page in enumerate(doc):page.get_pixmap(matrix=fitz.Matrix(1.4,1.4)).save(OUT/f'mentor_summary_page{i+1}.png')
    dump(OUT/'MENTOR_SUMMARY_LAYOUT.json',dict(markdown=path.relative_to(ROOT).as_posix(),markdown_sha256=sha(path),pdf_sha256=sha(pdf),pages=len(doc),character_count=len(text),font='Embedded SimSun',visual_check='pending'))
    print('Mentor summary',len(text),'characters,',len(doc),'page(s)')

if __name__=='__main__':generate()
