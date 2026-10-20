"""Render a local layout proof of the mentor Markdown (not an additional deliverable)."""
import hashlib
import html
import json
import re

from book_stats import ROOT, OUT, dump


def run():
    import fitz
    from reportlab.pdfbase import pdfmetrics
    from reportlab.pdfbase.ttfonts import TTFont
    from reportlab.lib import colors
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.pagesizes import A4
    from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
    pdfmetrics.registerFont(TTFont('BookCJK', 'C:/Windows/Fonts/simsun.ttc'))
    body = ParagraphStyle('body', fontName='BookCJK', fontSize=10, leading=15, spaceAfter=6, wordWrap='CJK')
    title = ParagraphStyle('title', parent=body, fontSize=16, leading=22, spaceAfter=10, keepWithNext=True)
    head = ParagraphStyle('head', parent=body, fontSize=12, leading=18, spaceBefore=8, spaceAfter=6, keepWithNext=True)
    small = ParagraphStyle('small', parent=body, fontSize=8.2, leading=11, spaceAfter=0, wordWrap='CJK')
    text = (OUT/'BOOK_SUMMARY_FOR_MENTOR.zh-CN.md').read_text(encoding='utf-8')
    def stripped(s):
        s = re.sub(r'\[([^\]]+)\]\([^)]+\)', r'\1', s)
        s = s.replace('**', '').replace('`', '').replace('¹ᐟ²', '^(1/2)').replace('⁻¹', '^(-1)')
        return html.escape(s)
    story = []; lines = text.splitlines(); i = 0
    while i < len(lines):
        line = lines[i]
        if line.startswith('|'):
            tablelines = []
            while i < len(lines) and lines[i].startswith('|'):
                if not re.fullmatch(r'[|:\- ]+', lines[i]): tablelines.append(lines[i])
                i += 1
            data = [[Paragraph(stripped(c.strip()), small) for c in l.strip('|').split('|')] for l in tablelines]
            n = len(data[0]); width = A4[0]-84
            if n == 10: widths = [20, 108, 32, 42, 42, 42, 38, 38, 38, 51]
            elif n == 4: widths = [22, 56, 218, width-296]
            elif n == 5: widths = [25, 100, 100, 120, width-345]
            elif n == 3: widths = [width*.57, width*.16, width*.27]
            else: widths = [width*.75, width*.25]
            scale = width/sum(widths); widths = [w*scale for w in widths]
            table = Table(data, colWidths=widths, repeatRows=1, hAlign='LEFT')
            table.setStyle(TableStyle([('VALIGN',(0,0),(-1,-1),'TOP'),('BACKGROUND',(0,0),(-1,0),colors.HexColor('#edf1f5')),
                                       ('GRID',(0,0),(-1,-1),.3,colors.HexColor('#bbc4cc')),('LEFTPADDING',(0,0),(-1,-1),4),('RIGHTPADDING',(0,0),(-1,-1),4),
                                       ('TOPPADDING',(0,0),(-1,-1),4),('BOTTOMPADDING',(0,0),(-1,-1),4)]))
            story += [table, Spacer(1, 8)]; continue
        if line.strip():
            style = title if line.startswith('# ') else head if line.startswith('## ') else body
            story.append(Paragraph(stripped(re.sub(r'^#{1,2} ', '', line)), style))
        i += 1
    directory = ROOT/'.git/book34'; directory.mkdir(parents=True, exist_ok=True); pdf = directory/'mentor-layout.pdf'
    def footer(canvas, doc):
        canvas.setFont('BookCJK', 8); canvas.drawRightString(A4[0]-42, 24, str(doc.page))
    SimpleDocTemplate(str(pdf), pagesize=A4, leftMargin=42, rightMargin=42, topMargin=36, bottomMargin=38).build(story, onFirstPage=footer, onLaterPages=footer)
    doc = fitz.open(pdf)
    for i, page in enumerate(doc): page.get_pixmap(matrix=fitz.Matrix(1.15,1.15)).save(directory/f'mentor-page-{i+1}.png')
    assert 4 <= len(doc) <= 6, f'Expected 4–6 pages; got {len(doc)}'
    result = dict(markdown_sha256=hashlib.sha256(text.encode('utf-8')).hexdigest(), pages=len(doc),
                  page_format='A4, 10pt正文/15pt行距，表格8.2pt/11pt', font='SimSun',
                  pdf_is_layout_proof_only=True, visual_inspection='pending',
                  note='固定链接以可读标签排版；质量指数在排版样张以ASCII幂记号显示，交付Markdown保留原式。')
    dump('.git/book34/LAYOUT.json', result); print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__': run()
