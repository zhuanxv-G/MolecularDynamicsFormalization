"""Check instruction 35 against its immutable Git baseline (de3b2539).

No rewriting occurs. Outputs a machine-readable receipt and all residual diffs.
Usage: python docs/review/book/check_md_math.py
"""
import argparse
import difflib
import hashlib
import json
import re
import subprocess
import unicodedata
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
BASE = 'de3b2539'
OUT = ROOT/'docs/review/book'
FENCE = re.compile(rb'(?ms)^[ \t]*(`{3,}|~{3,})[^\n]*\n.*?^[ \t]*\1[^\n]*(?:\n|$)')


def git(*args):
    return subprocess.check_output(['git', *args], cwd=ROOT)


def outside(raw, ignore_inline=True):
    # Keep original line numbers; omit inline code and link destinations too.
    raw = FENCE.sub(lambda m: b'\n'*m[0].count(b'\n'), raw)
    text = raw.decode('utf-8-sig')
    return re.sub(r'`+[^`\n]*`+|\]\([^\n)]*\)', '', text) if ignore_inline else text


def canonical(text):
    # Visible equation numbers: tag -> ordinary text is necessary GitHub layout.
    text=re.sub(r'\\quad\\text\{\(([^{}]+)\)\}',r'\\tag{\1}',text)
    text = re.sub(r'(?m)^\s*> ?', '', text)
    text = re.sub(r'\\[\[\]()]|\$|`', '', text)
    text = text.replace('\\_', '_').replace('\\*','*')
    # Vertical bars are only spelling changes explicitly authorized by rule 2.5.
    for a,b in [('\\lVert','\\|'),('\\rVert','\\|'),('\\Vert','\\|'),('\\lvert','|'),('\\rvert','|'),('\\vert','|')]:
        text=text.replace(a,b)
    text=re.sub(r'\\{2,}\|',lambda m:'\\|',text)
    return re.sub(r'\s+', '', text)


def chapter8_spelling(text):
    """Diagnostic only: compare Unicode and LaTeX spelling, never approve an edit.

    Sub/superscript braces are removed here; exact reviewed before/after pairs
    remain mandatory, so this diagnostic cannot hide a changed script position.
    """
    text=re.sub(r'(?m)^\s*> ?', '',text)
    text=re.sub(r'\\[\[\]()]|\$|`','',text).replace('\\_','_').replace('\\*','*')
    names=dict(beta='β',gamma='γ',tau='τ',sigma='σ',theta='θ',mu='μ',xi='ξ',rho='ρ',varphi='φ',phi='φ',
               Phi='Φ',Psi='Ψ',psi='ψ',Gamma='Γ',Delta='Δ',delta='δ',nabla='∇',partial='∂',Pi='Π',
               pi='π',eta='η',zeta='ζ',nu='ν',alpha='α',omega='ω',Sigma='Σ',Omega='Ω',Lambda='Λ',
               int='∫',sum='Σ',cdot='·',times='×',circ='∘',dagger='†',ne='≠',le='≤',ge='≥',to='→',infty='∞',
               forall='∀',approx='≈',propto='∝',sim='∼',bigcup='⋃',setminus='\\',mid='|',leftarrow='←',
               lVert='‖',rVert='‖',langle='⟨',rangle='⟩',ldots='...',cdots='...',sqrt='√',**{'lambda':'λ','in':'∈'})
    text=re.sub(r'\\([A-Za-z]+)',lambda m:names.get(m[1],m[0]),text)
    text=re.sub(r'\\(?:operatorname|mathrm|mathsf|mathbb|text|mathrel)\{([^{}]*)\}',r'\1',text)
    text=re.sub(r'\\(?:mathsf|mathbb)\s+([A-Za-z])',r'\1',text)
    # Braceless mathbb in R^m.
    text=text.replace('\\mathbb R','R').replace('\\mathbbR','R')
    for command,accent in [('tilde','\u0303'),('hat','\u0302'),('bar','\u0304'),('dot','\u0307')]:
        for _ in range(3):
            text=re.sub(r'\\'+command+r'\s*\{([^{}]*)\}',lambda m:m[1]+accent,text)
            text=re.sub(r'\\'+command+r'\s*([A-Za-zΑ-ω])',lambda m:m[1]+accent,text)
    text=text.replace('\\ln','ln').replace('\\log','log').replace('\\exp','exp').replace('\\min','min').replace('\\det','det').replace('\\sinh','sinh').replace('\\cosh','cosh')
    text=re.sub(r'\\[,;! ]','',text)
    text=text.replace('\\lvert','|').replace('\\rvert','|').replace('\\vert','|')
    text=text.replace('‖','||').replace('〈','⟨').replace('〉','⟩').replace('∑','Σ').replace('−','-').replace('′',"'").replace('″',"''").replace('⋯','...').replace('…','...')
    text=unicodedata.normalize('NFKD',text).replace('⁄','/').replace('ᐟ','/').replace('−','-')
    text=text.replace('sqrt','√').replace('Γhat','Γ\u0302')
    text=re.sub(r'(?<!\.)\.\.(?!\.)','...',text)
    text=text.replace('\\{','').replace('\\}','').replace('\\|','||')
    # Parentheses versus braces under a radical are a spelling change only here.
    return re.sub(r'[{}()\[\]_^\s]','',text)


def main():
    (ROOT/'.git/render35').mkdir(exist_ok=True)
    parser=argparse.ArgumentParser(); parser.add_argument('--receipt',default=str(OUT/'BOOK_RENDER_CHECK.json'))
    args=parser.parse_args()
    basefiles=git('ls-tree','-r','--name-only',BASE).decode().splitlines()
    checks={str(n):[] for n in range(1,9)}; changes=[]; residual=[]; counts={}
    manual_path=OUT/'CH08_RENDER_EDITS.json'
    manual=json.loads(manual_path.read_text(encoding='utf-8')) if manual_path.exists() else []
    assert all(hashlib.sha256(x['before'].encode()).hexdigest()==x['before_sha256'] and
               hashlib.sha256(x['after'].encode()).hexdigest()==x['after_sha256'] for x in manual), 'manual receipt hash mismatch'
    approvals={(x['file'],x['before'],x['after']) for x in manual}
    for p in sorted((ROOT/'docs/review').rglob('*.md')):
        rel=p.relative_to(ROOT).as_posix(); raw=p.read_bytes(); text=outside(raw)
        display=False; body=[]
        for n,line in enumerate(outside(raw,False).splitlines(),1):
            if re.search(r'\\[\[\]()]',line): checks['1'].append([rel,n,line])
        for n,line in enumerate(text.splitlines(),1):
            dollars=re.findall(r'(?<!\\)\$',line)
            if len(dollars)%2: checks['2'].append([rel,n,'odd dollar count'])
            if '$$' in line and line!='$$': checks['2'].append([rel,n,'display delimiter not alone'])
            if line=='$$':
                if display and (len(body)!=1 or not body[0].strip()): checks['3'].append([rel,n,'display body must occupy exactly one line'])
                if not display: body=[]
                display=not display;continue
            if display: body.append(line)
            if line.lstrip().startswith('|'):
                for m in re.finditer(r'\$([^$]+)\$',line):
                    if '|' in m[1]: checks['4'].append([rel,n,'pipe in table math'])
            if not display:
                for m in re.finditer(r'(?<!\$)\$([^$]*)\$(?!\$)',line):
                    if not m[1] or m[1]!=m[1].strip(): checks['5'].append([rel,n,'whitespace inside inline math'])
        if display: checks['3'].append([rel,'unclosed display'])
        if rel not in basefiles: continue
        old=git('show',BASE+':'+rel); before=outside(old)
        oldheads=re.findall(rb'^#{2,3} .*',old,re.M); newheads=re.findall(rb'^#{2,3} .*',raw,re.M)
        if [h.rstrip(b'\r') for h in oldheads]!=[h.rstrip(b'\r') for h in newheads]: checks['6'].append(rel)
        if FENCE.findall(old)!=FENCE.findall(raw) or [m[0] for m in FENCE.finditer(old)]!=[m[0] for m in FENCE.finditer(raw)]:
            checks['7'].append(rel)
        if old==raw: continue
        changes.append(rel)
        counts[rel]=dict(before_display=len(re.findall(r'\\\[',before)),before_inline=len(re.findall(r'\\\(',before)),
                         after_display=text.splitlines().count('$$')//2,after_inline=len(re.findall(r'(?<!\$)\$[^$\n]+\$(?!\$)',text)))
        before=outside(old,False); after=outside(raw,False)
        if rel.startswith('docs/review/book/'):
            before=before.replace('/blob/book-ch01-08-summary/','/blob/book-ch01-08-render/').replace('/tree/book-ch01-08-summary/','/tree/book-ch01-08-render/')
        if canonical(before)==canonical(after): continue
        # Examine every residual line diff. Manual chapter-8 formula edits are exact,
        # human-authored before/after pairs, not a wildcard chapter exemption.
        a=before.splitlines(); b=after.splitlines()
        for tag,i,j,k,l in difflib.SequenceMatcher(None,a,b,autojunk=False).get_opcodes():
            if tag=='equal': continue
            aa='\n'.join(a[i:j]);bb='\n'.join(b[k:l])
            if canonical(aa)==canonical(bb):continue
            if (rel,aa,bb) in approvals and chapter8_spelling(aa)==chapter8_spelling(bb):continue
            # Navigation changes are separately constrained to tag spelling and the exact notice.
            if rel in ['docs/review/book/README.zh-CN.md','docs/review/book/BOOK_SUMMARY_FOR_MENTOR.zh-CN.md']:
                notice='本版本修复了 GitHub 上的公式渲染；数学内容与 book-ch01-08-summary 相同。'
                nav='公式修复数量、符号表和待确认项见 [公式修复报告](BOOK_RENDER_FIX.zh-CN.md)。'
                if canonical(aa.replace('book-ch01-08-summary','book-ch01-08-render'))==canonical(bb.replace(notice,'').replace(nav,'')):continue
            residual.append(dict(file=rel,before_line=i+1,after_line=k+1,before=aa,after=bb))
    checks['8']=residual
    # Recheck frozen raw checkout bytes as well as Git content against the named commit.
    lean=[p for p in basefiles if p.endswith('.lean')]
    changed_lean=git('diff','--name-only',BASE,'--','*.lean').decode().splitlines()
    snap=ROOT/'.git/render35/lean_bytes.json'
    raw_changed=[]
    if snap.exists():
        raw_changed=[p for p,h in json.loads(snap.read_text()).items() if hashlib.sha256((ROOT/p).read_bytes()).hexdigest()!=h]
    # Reuse the project's Lean comment/string scanner, avoiding comment false positives.
    import sys
    sys.path.insert(0,str(ROOT/'scripts'))
    from book_stats import clean
    formal=list((ROOT/'MolecularDynamics').rglob('*.lean'))
    sorry=sum(len(re.findall(r'\bsorry\b',clean(p.read_text(encoding='utf-8-sig')))) for p in formal)
    axioms=sum(len(re.findall(r'(?m)^\s*(?:(?:private|protected)\s+)*axiom\s',clean(p.read_text(encoding='utf-8-sig')))) for p in formal)
    receipt=dict(baseline=BASE,checks={k:dict(pass_=not v,failures=v) for k,v in checks.items()},changed_markdown=changes,
                 counts=counts,lean=dict(files=len(lean),git_content_changed=changed_lean,raw_bytes_changed=raw_changed,
                 raw_snapshot_available=snap.exists(),formal_files=len(formal),sorry=sorry,axiom=axioms),
                 manual_edits=len(manual),remaining_differences=len(residual))
    receipt['status']='PASS' if all(not v for v in checks.values()) and not changed_lean and not raw_changed and sorry==axioms==0 else 'FAIL'
    Path(args.receipt).write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    (ROOT/'.git/render35/residual_differences.json').write_text(json.dumps(residual,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(dict(status=receipt['status'],checks={k:len(v) for k,v in checks.items()},lean=receipt['lean'],manual_edits=len(manual)),ensure_ascii=False,indent=2))
    raise SystemExit(receipt['status']!='PASS')


if __name__=='__main__': main()
