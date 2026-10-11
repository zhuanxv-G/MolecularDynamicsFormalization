"""Exact table wording, shared by single-body and full N-body declarations."""
from ch04_data import RECORDS
SPIN_TEXT=next(r['statement_latex'] for r in RECORDS if r['source_id'].endswith('-PrintedSpinStep'))
KICK_TEXT=r'''“Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:
\[p^k:=p^k+\tfrac h2 F_k;\quad\pi^k:=\pi^k+\tfrac h2\tau_k.\]'''
TABLE_TEXT=r'''DLM Rigid Body Molecular Dynamics Step
1. '''+KICK_TEXT+r'''
2. “Drift”: step forward a whole step in positions
\[q^k:=q^k+hp^k.\]
3. '''+SPIN_TEXT+r'''
4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $F_k$ and torques $\tau_k$ evaluated at the current $q,\Theta$.'''
