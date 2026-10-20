"""Generate chapter body page bounds from the supplied textbook PDF, not hand totals."""
import argparse
import hashlib
import re
from pathlib import Path

from book_stats import ROOT, dump


def run():
    import fitz
    parser = argparse.ArgumentParser(); parser.add_argument('--pdf', type=Path)
    args = parser.parse_args()
    pdf = args.pdf or next(ROOT.parent.glob('Leimkuhler2015b*.pdf'))
    doc = fitz.open(pdf); toc = doc.get_toc(); chapters = {}
    for idx, (level, title, page) in enumerate(toc):
        m = re.match(r'^([1-8]) ', title)
        if level != 1 or not m: continue
        ch = int(m[1]); exercises = next(x[2] for x in toc[idx+1:] if x[1] == 'Exercises')
        before = doc[exercises-1].get_text().split('Exercises', 1)[0]
        meaningful = [s for s in before.strip().splitlines() if not re.match(r'^\d+$', s.strip()) and len(s.strip()) > 25]
        end = exercises if len(meaningful) > 2 else exercises-1
        numbers = [int(x) for x in re.findall(r'^\d+$', doc[page-1].get_text(), re.M)]
        printed = numbers[-1]
        chapters[str(ch)] = dict(printed_pages=f'{printed}–{printed+end-page}', pdf_pages=f'{page}–{end}',
                                 chapter_start_pdf=page, exercises_start_pdf=exercises, last_page_body_prefix_only=end == exercises)
    assert len(chapters) == 8
    dump('docs/review/book/BOOK_PAGE_RANGES.json', dict(source_pdf=pdf.name,
         sha256=hashlib.sha256(pdf.read_bytes()).hexdigest(),
         method='PDF书签章首/Exercises位置；混合页仅取Exercises之前正文，印刷章首由章首页页码读取。', chapters=chapters))


if __name__ == '__main__': run()
