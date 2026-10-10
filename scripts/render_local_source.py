"""Render only new original pages; verification requires actual visual inspection."""
import argparse,json,hashlib
from pathlib import Path
import fitz
from local_blueprint import ROOT,RANGES
a=argparse.ArgumentParser();a.add_argument('chapter',type=int);a.add_argument('first',type=int);a.add_argument('last',type=int);a.add_argument('--record-visual-check',action='store_true');x=a.parse_args()
assert x.chapter in RANGES
lo,hi,p0,p1=RANGES[x.chapter];assert p0<=x.first<=x.last<=p1
base=ROOT/f'blueprint/ch{x.chapter:02}';folder=base/'source_pages';folder.mkdir(parents=True,exist_ok=True)
pdf=next(ROOT.parent.glob('Leimkuhler2015b*.pdf'));doc=fitz.open(pdf)
for n in range(x.first,x.last+1):
    out=folder/f'p{n}.png'
    if not out.exists():doc[n-1].get_pixmap(matrix=fitz.Matrix(1.1,1.1)).save(out)
    (folder/f'p{n}.txt').write_text(doc[n-1].get_text(sort=True),encoding='utf-8')
if x.record_visual_check:
    path=base/'source_page_checks.json';state=json.loads(path.read_text(encoding='utf-8')) if path.exists() else {}
    state.update(source_pdf=pdf.name,source_pdf_sha256=hashlib.sha256(pdf.read_bytes()).hexdigest(),printed_to_pdf_offset=p0-lo,
        visually_checked_pdf_pages=sorted(set(state.get('visually_checked_pdf_pages',[]))|set(range(x.first,x.last+1))),
        method='Original PDF pages rendered to PNG and visually inspected; text extraction is auxiliary only.',
        body_printed_range=[lo,hi],body_pdf_range=[p0,p1])
    path.write_text(json.dumps(state,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print('Rendered',x.first,x.last,'; visual verification recorded:',x.record_visual_check)
