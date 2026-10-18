from common26 import *
import difflib

# Only statements actually described as correct/PASS by the website are promoted.
# A correct predicate for an unrealizable/unspecified limiting regime stays separate.
PASS26={
'BathTaylor':['bathBoltzmannPrinted_corrected','bathBoltzmannPrinted_counterexample'],
'CanonicalCDFPrinted':['canonicalCDFPrinted_corrected'],
'FiniteDomainPrinted':['finiteDomainPrinted_corrected'],
'Proposition61':['proposition61','proposition61_corrected'],
'PartitionInversePrinted':['partitionInversePrinted_corrected'],
'RiemannTags':['riemannTags','riemannTags_corrected'],
'Proposition62':['proposition62','proposition62_corrected','proposition62Expansion_corrected','proposition62Printed_counterexample'],
'SelfStratonovichIntegral':['selfStratonovichIntegral','selfStratonovichIntegral_corrected'],
'ScalarItoFormula':['scalarItoFormula'],
'DiffusiveTaylorPrinted':['diffusiveTaylorPrinted_corrected'],
'TimeItoFormula':['timeItoFormula','timeItoFormula_corrected'],
'BathReductionPrinted':['bathReductionPrinted_corrected'],
'FPPolynomialAdjoint':['fpPolynomialAdjoint','fpPolynomialAdjoint_corrected'],
'CylinderForwardPrinted':['cylinderForwardPrinted_corrected','cylinderForwardPeriodic_corrected'],
'BrownianSymmetry':['brownianSymmetry','brownianSymmetry_corrected'],
'BrownianRealEigenvalue':['brownianRealEigenvalue','brownianRealEigenvalue_corrected'],
'BrownianClosedSelfAdjoint':['brownianClosedSelfAdjoint','brownianClosedSelfAdjoint_corrected'],
'BrownianCompactResolvent':['brownianCompactResolvent','brownianCompactResolvent_corrected'],
'BrownianDiscreteSpectrum':['brownianDiscreteSpectrum','brownianDiscreteSpectrum_eigenvalue'],
'HamiltonianPowerMomentumLaplacian':['hamiltonianPowerMomentumLaplacian','laplacianBoundCorrect'],
'LangevinHormander':['langevinHormander'],
'LangevinTransitionDensity':['langevinTransitionDensity'],
'Theorem61':['theorem61','theorem61_corrected'],
'Theorem62':['theorem62','theorem62_corrected'],
'WeightedH1Norm':['weightedH1Norm'],
'KernelEvolution':['kernelEvolutionRaw25','kernelEvolution'],
'KernelAverage':['kernelAverage'],
'SmoothTestL2Printed':['smoothTestL2Printed_corrected'],
}
NOTES={
'BathTaylor':'修正版只是全局恒定熵导数（仿射熵）特例，未给一般热浴近似误差界。',
'FiniteDomainPrinted':'修正版只给紧域构型权重可积；正体积、正配分函数、动量积分与归一化没有随之成立。',
'DeterministicStrobePrinted':'Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。',
'VectorSDE':'strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。',
'MemoryKernelDeltaMeaning':'两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。',
'BathForceWeakLimitMeaning':'两个定义分别表达力路径及积分力路径的收敛资格；没有断言实现条件存在，也没有初态、频谱标度、σ及紧性定理，网站未认证实际热浴极限。',
'BrownianSymmetry':'两份相同签名只覆盖周期核心的形式配对对称；不覆盖原域与伴随域相等。',
'BrownianClosedSelfAdjoint':'限定版正质量、β>0、C∞单位周期势、闭Gibbs复L²实现已获PASS；原C₀²措辞与闭实现的解释仍待导师。',
'BrownianCompactResolvent':'只给实际(1−L)⁻¹紧性，离散谱由相邻独立条目承接；不把原域解释自动视为已认证。',
'BrownianDiscreteSpectrum':'合并主声明与eigenvalue补充声明覆盖可数实孤立谱及每谱点为特征值；正质量、β>0、C∞单位周期势和闭Gibbs复L²域均为限定；有限重数等强化未单列。',
'MinorizationCorrectedImplication':'仅覆盖加强条件下充分方向；还独立要求所有点、所有正时刻对每个非空开集有正概率，以及Markov合成、参考测度全支撑，不覆盖原tantamount的必要方向。',
'HamiltonianPowerMomentumLaplacian':'精确等式与修正版上界2l(l−1)+Ncl获PASS；随包原上界l(l+Nc−1)保留疑误，三者分别登记。',
'LangevinHormander':'原页已给噪声、漂移及第一层括号的线性独立论证。本条只给秩条件；正时刻密度另列，原Assumption1(ii)含零时刻端点仍有疑。',
'LangevinTransitionDensity':'网站PASS的是正时刻联合连续密度限定版；原[0,∞)连续密度端点需勘误。',
'LangevinGeometricErgodicity':'权界是对所有(q,p)逐点成立；Hamiltonian权比较采用充分正平移后的Hamiltonian，原展示式及归一约定见原文。',
}

def main():
 src=load(BASE/'ch06_source.json');before=json.dumps(src,ensure_ascii=False,indent=2)+'\n'
 rr={r['source_id']:r for r in load(OUT/'RETURNS.json')};notes=[]
 for s in src:
  sid=s['source_id'];key=sid.split('-')[-1];r=rr.get(sid)
  if not r:continue
  if r['audit']['verdict']!='FAIL':
   cj=r['json_review'].get('corrected_json')
   if cj:
    changed={}
    for f in ['kind','label','statement_latex','proof_latex','proof_note','proof_discussion_latex','printed_page','pdf_page','extra_assumptions','statement_scope','coverage_gaps','context_notation']:
     if f in cj and s.get(f)!=cj[f]:changed[f]=dict(before=s.get(f),after=cj[f]);s[f]=cj[f]
    s['closeout26_json_changes']=changed
  if key in NOTES:
   note=NOTES[key]
   if note not in s.setdefault('closeout26_notes',[]):s['closeout26_notes'].append(note)
   if '[EXTRA] 26号复审范围：'+note not in s.setdefault('extra_assumptions',[]):s['extra_assumptions'].append('[EXTRA] 26号复审范围：'+note)
   if key in ['DeterministicStrobePrinted','VectorSDE','MemoryKernelDeltaMeaning','BathForceWeakLimitMeaning']:
    s['statement_scope']=note
    s.setdefault('coverage_gaps',[])
    if note not in s['coverage_gaps']:s['coverage_gaps'].append(note)
   notes.append(dict(source_id=sid,note=note))
 dump(BASE/'ch06_source.json',src)
 (OUT/'METADATA_TRIAGE.diff').write_text(''.join(difflib.unified_diff(before.splitlines(True),(json.dumps(src,ensure_ascii=False,indent=2)+'\n').splitlines(True),fromfile='source metadata before',tofile='source metadata after')),encoding='utf-8')
 dump(OUT/'TRIAGE_NOTES.json',notes)
 dump(OUT/'VERSION_PASS_MAP.json',PASS26)
 print('Metadata and version-specific triage recorded',len(notes),flush=True)
if __name__=='__main__':main()
