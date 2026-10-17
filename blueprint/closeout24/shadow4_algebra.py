"""Independent exact rational jet calculation; this is not a Lean proof of an ODE estimate."""
from common import *
import sympy as s
h,p=s.symbols('h p');u=s.symbols('u0:9');a,b,c,d=s.symbols('a b c d')
def trunc(f):return s.Poly(s.expand(f),h).terms() and s.expand(sum(v*h**k[0] for k,v in s.Poly(s.expand(f),h).terms() if k[0]<=6))
def dq(f):return s.expand(sum(s.diff(f,u[i])*u[i+1] for i in range(8)))
K=p*p/2+u[0]+h*h*(p*p*u[2]/12-u[1]**2/24)+h**4*(a*p**4*u[4]+b*p*p*u[1]*u[3]+c*p*p*u[2]**2+d*u[1]**2*u[2])
v=s.diff(K,p);force=-dq(K)
def D(f,q=False):return trunc((v if q else 0)+v*dq(f)+force*s.diff(f,p))
def expflow(q=False):
 f=0 if q else p;out=f
 for j in range(1,7):
  f=D(f,q and j==1);out+=trunc(h**j*f/s.factorial(j))
 return trunc(out)
qflow=expflow(True);pflow=expflow(False)
Q=h*p-h*h*u[1]/2
P=p-h*(u[1]+sum(u[j+1]*Q**j/s.factorial(j) for j in range(6)))/2
eq=[]
for err in [trunc(qflow-Q),trunc(pflow-P)]:
 for _,coef in s.Poly(err,h,p,*u).terms():eq.append(coef)
sol=s.solve(eq,[a,b,c,d]);assert sol=={a:-s.Rational(1,720),b:s.Rational(1,120),c:s.Rational(1,60),d:-s.Rational(1,240)},sol
assert trunc((qflow-Q).subs(sol))==0
assert trunc((pflow-P).subs(sol))==0
dump(OUT/'SHADOW4_ALGEBRA.json',dict(coefficients={str(k):str(v) for k,v in sol.items()},q_endpoint_jet_through_h6='equal',p_endpoint_jet_through_h6='equal',method='exact symbolic independent jet expansion of exp(h X_K) and kick-drift-kick',limitations='Finite jets verified by SymPy. Uniform O(h^7) real-flow estimate remains an unproved Lean statement.'))
print(sol,flush=True)
