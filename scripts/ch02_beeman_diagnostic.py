"""Reproducible source diagnostic, explicitly not a formal counterexample proof."""
import math,json
from pathlib import Path
import sympy as s
from ch02_data import BASE
h=s.symbols('h');qn=1+h*h/6*(-4+s.cos(h));pn=h/6*(-2*qn-5+s.cos(h))
numeric=[]
for n in [40,80,160,320]:
    step=1/n;prev=1.;q=math.cos(step);p=-math.sin(step)
    for k in range(1,n):
        qnext=q+step*p+(step*step/6)*(-4*q+prev)
        pnext=p+(step/6)*(-2*qnext-5*q+prev)
        prev,q,p=q,qnext,pnext
    numeric.append(dict(n=n,error=math.hypot(q-math.cos(1),p+math.sin(1))))
for k in range(1,len(numeric)):numeric[k]['halving_ratio']=numeric[k-1]['error']/numeric[k]['error']
out=dict(model='m=1,F(q)=-q; q(t)=cos(t),p(t)=-sin(t); exact two starting values',
    position_local_defect=str(s.series(qn-s.cos(h),h,0,6)),
    momentum_local_defect=str(s.series(pn+s.sin(h),h,0,6)),
    global_error_at_t1=numeric,result='NEEDS_HUMAN',
    verified='Sympy Taylor and floating point diagnostic only; no Lean counterexample or asymptotic lower-bound proof.')
(BASE/'validation/beeman-order-diagnostic.json').write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,ensure_ascii=False,indent=2))
