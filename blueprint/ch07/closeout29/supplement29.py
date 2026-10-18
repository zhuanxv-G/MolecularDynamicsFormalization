from repair29 import *

def main(compiler=None):
 text=LEAN.read_text(encoding='utf-8');source=load(BASE/'ch07_source.json')
 if 'def lmExtendedChain ' in text:
  check('SUPPLEMENT-final-r2',compiler)
  return
 sid='MD-7.10-ColoredNoiseAndExtension';old=groups(text)[sid]['code']
 new=old+'''

def lmExtendedChain (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n) : ℕ → Ω → V n × V n
  | 0 => X0
  | k+1 => fun sample ↦ lmExtendedStep m U θ τ (R k sample)
      (lmExtendedChain m U θ τ R X0 k sample)

/-- 每次新噪声独立于初始状态及所有先前噪声；集合积分式给出扩展过程的Markov条件分布。 -/
theorem lmExtendedChain_markov (P : Measure Ω) (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (hτ : 0 < τ)
    (hR : vectorNormalSequence P R) (hX0 : Measurable X0)
    (hfresh : ∀ k, IndepFun (R k)
      (fun sample ↦ (X0 sample,fun j : Fin k ↦ R j sample)) P)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦ lmExtendedStep m U θ τ z.2 z.1)) :
    let X := lmExtendedChain m U θ τ R X0
    ∀ k (A : Set (V n × V n)) (hA : MeasurableSet A) (B : Set Ω),
    MeasurableSet[⨆ j : Fin (k+1), MeasurableSpace.comap (X j) inferInstance] B →
    P (B ∩ (X (k+1)) ⁻¹' A) =
      ∫⁻ sample in B, lmExtendedKernel m U θ τ hstep (X k sample) A ∂P := by
  sorry
'''
 r=next(r for r in source if r['source_id']==sid)
 r['statement_scope']='邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。'
 r['extra_assumptions'].append(r['statement_scope']);r['coverage_gaps']=['一般位置过程非Markov需额外非退化参数与初态；此处未作无条件断言。']
 text=replace_group(text,sid,new,r['extra_assumptions'],r['issues'])
 sid2='MD-7.12-ConstrainedHOSplitting';old2=groups(text)[sid2]['code']
 new2=old2.replace('  ∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P,\n    (X t sample).1=x0.1',
 '''  (∀ sample t, ∃ impulseCoeff : V l, reactionImpulse t sample=constraintReaction g x0.1 impulseCoeff) ∧
  (∀ t ∈ Icc 0 T, Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance]
      (reactionImpulse t)) ∧
  ∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P,
    (X t sample).1=x0.1''')
 new2+='''

def constrainedHMapQualification {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (H : ℝ → Phase n → Phase n) : Prop :=
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ Λ : ℝ → V l,
    constrainedHIntegralStep m U g (fun t ↦ H t x) Λ x T

def constrainedOMapQualification {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (O : ℝ → Ω → Phase n → Phase n) : Prop :=
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ reaction : ℝ → Ω → V n,
    constrainedOIntegralStep P m g γ θ W (fun t sample ↦ O t sample x) reaction x T

/-- 两次O使用乘积概率空间上的独立样本；H/O都须满足各自受约束解规格。 -/
def constrainedHOQualifiedComposition {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) :
    Ω × Ω → Phase n → Phase n :=
  fun sample x ↦ O (h/2) sample.2 (H h (O (h/2) sample.1 x))
'''
 r2=next(r for r in source if r['source_id']==sid2)
 r2['statement_scope']='H/O漂移与O扩散、各段约束保持的积分解规格、满足这些规格的H/O随机映射组合；两次O用乘积概率空间的独立样本。未构造这些解的存在性或一般非线性投影漂移理论。'
 r2['extra_assumptions'].append(r2['statement_scope'])
 text=replace_group(text,sid2,new2,r2['extra_assumptions'],r2['issues'])
 for sid3 in [sid,sid2]:
  r3=next(r for r in source if r['source_id']==sid3)
  r3['lean_declarations']=['MD.Ch07.'+n for n in groups(text)[sid3]['names']]
  r3['repair_log'].append(dict(instruction=29,supplement='补过程Markov条件分布或H/O解资格连接',signature_changed=True))
 # Rebuild only docstrings to restore full page labels and synchronize all scopes.
 for r in reversed(source):
  g=groups(text)[r['source_id']]
  head='/-- source_id: '+r['source_id']+' · 印刷p.'+r['printed_page']+' / PDFp.'+r['pdf_page']
  head+=''.join('\n[EXTRA] '+x for x in r['extra_assumptions'])+''.join('\n[ERRATUM?] '+x for x in r['issues'])+' -/'
  text=text[:g['start']]+head+text[g['body_start']:]
 LEAN.write_text(text,encoding='utf-8');dump(BASE/'ch07_source.json',source)
 dump(OUT/'SUPPLEMENT_REPAIRS.json',dict(source_ids=[sid,sid2],signature_changed=True))
 from lsp29 import LeanCompiler
 owned=compiler is None;c=compiler or LeanCompiler()
 try:check('SUPPLEMENT-final',c)
 finally:
  if owned:c.close()

if __name__=='__main__':main()
