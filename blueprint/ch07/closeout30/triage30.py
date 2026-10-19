from register30 import *
import difflib

FAIL_ID='MD-7.12-ConstrainedHOSplitting'
FAIL_SCOPE='H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。'
FAIL_GAP='未建立随机初值代入后的条件积分解、几乎处处约束保持及完整条件转移核识别；未构造分段解存在唯一性、Oc半群律或约束Gaussian不变性。'
HO_ISSUE='原印λdt若理解为普通有限变差反作用，无法抵消约束法向Wiener噪声；保留原文，采用可含随机部分的reactionImpulse作为限定解释，待导师确认。'

# These are version-level signature assessments, not completed proofs. The
# raw NEEDS_HUMAN verdict and its complete wording always remain in the ledger.
PASS30={
 'SPVPrinted':['spvPrinted_corrected'],
 'SymmetricRHS':['symmetricRHS','symmetricRHS_odd','symmetricRHS_zeroMean'],
 'OUKernelQualification':['ouKernelPrinted_corrected','ouKernelCentered_corrected'],
 'FirstReciprocalCorrection':['firstReciprocalCorrection','momentumAverage','momentumAveragePrinted_corrected','momentumAveragePrinted','firstReciprocalCorrection_pde','conjugatedPhaseH','jointGibbsQualification'],
 'ColoredNoiseAndExtension':['coloredNoise','coloredNoise_covariance','lmExtendedStep','lmExtendedKernel','lmExtendedChain','lmExtendedChain_markov'],
 'LimitMethodAccuracy':['lmTransientErrorBound','limitAccuracyPrinted_corrected','limitAccuracy_rescale','limitAccuracyInfiniteTime_corrected'],
 'ConstrainedLangevin':['constraintJacobian','constraintReaction','hiddenConstraint','cotangentConstraint','constrainedLangevin_corrected'],
 'SpectralRadiusStability':['characteristicUnitDisk','spectralRadiusStability','hyperbolicStability','multipleX_spectral_hyperbolic'],
}
NOTES={
 'SPVPrinted':'修正版仅作为对称分裂的候选定义获认可；物理使用须引用spvQualification，γ=0延拓未覆盖。原印取力点仍待导师。',
 'SpectralQualification':'网站仅认可已披露的点谱/几何单重定义；corrected仍是较弱候选Prop，未获完整紧预解式谱定理的PASS，不计为修正版定理通过。',
 'SymmetricRHS':'所列函数、奇性及零积分签名PASS；零均值只是必要兼容条件，函数空间、算子域与核/余核资格仍待确认。',
 'OUKernelQualification':'密度共轭与Gaussian L²域的两个修正版签名PASS；裸前向OU核原印疑误待导师。',
 'FirstReciprocalCorrection':'所列限定签名PASS；联合权平均与条件平均分别登记。本项目Hρ=0，故H(ρf)=ρHf，撤销把该Hamiltonian乘积等式本身判错的解释；疑点在后续M归一化与算子解释。',
 'ColoredNoiseAndExtension':'fresh独立性下Markov集合积分式签名PASS；删去过时的同名缺口。协方差为额外推论，位置非Markov仍需限定。',
 'LimitMethodAccuracy':'限定定义和长期极限连接签名PASS；h⁴仅在先取长期极限的解释下适用，不表示固定有限时间四阶或真实LM误差界已证。',
 'ConstrainedLangevin':'单位质量线性约束投影修正版签名PASS；原印有限变差乘子模型不声称一般存在。',
 'ConstrainedCanonicalErgodicity':'四个参考与遍历目标定义的限定范围获认可；没有完整受约束SDE遍历定理，几何参考体积和连通/不可约资格仍待导师。',
 'SpectralRadiusStability':'四条闭单位圆谱声明签名PASS；不可把≤边界等同Gaussian噪声下有限二阶矩平稳性，η=0另留缺口。',
}

def main():
    src=load(BASE/'ch07_source.json');rr={r['source_id']:r for r in load(OUT/'RETURNS.json')}
    text=(ROOT/'Blueprint/Ch07.lean').read_text(encoding='utf-8');gg=groups(text)
    for s in src:
        sid=s['source_id'];key=sid.split('-')[-1]
        if sid==FAIL_ID:
            s['statement_scope']=FAIL_SCOPE
            s['extra_assumptions']=[x for x in s['extra_assumptions'] if '29号覆盖限定' not in x and '两次O用乘积' not in x]
            s['extra_assumptions'] += ['30号修复：P为概率及W为向量Wiener独立于约束集非空性；H的初值可测与O的样本/初值联合可测。',FAIL_SCOPE]
            s['coverage_gaps']=[FAIL_GAP]
            if HO_ISSUE not in s['issues']:s['issues'].append(HO_ISSUE)
            s['lean_declarations']=['MD.Ch07.'+n for n in gg[sid]['names']]
            if not any(x.get('instruction')==30 for x in s['repair_log']):
                s['repair_log'].append(dict(instruction=30,website_verdict='FAIL',suggested_fix=rr[sid]['audit']['suggested_fix'],actual_scope=FAIL_SCOPE,coverage_gaps=[FAIL_GAP],signature_changed=True))
        if key=='ColoredNoiseAndExtension':
            s['extra_assumptions']=[x for x in s['extra_assumptions'] if 'Markov定理未覆盖' not in x and '扩展Markov核与半群律仍是覆盖缺口' not in x]
            s['coverage_gaps']=[x for x in s['coverage_gaps'] if 'Markov定理未覆盖' not in x]
            issue='有色噪声不能单独推出位置过程无例外地非Markov；特定势与初态下位置序列可以仍为Markov。'
            if issue not in s['issues']:s['issues'].append(issue)
        if key=='SymmetricRHS':
            issue='零均值只验证必要兼容条件；完整Fredholm可解性需要明确函数空间、算子域、核/余核与闭值域资格。'
            if issue not in s['issues']:s['issues'].append(issue)
        if sid in rr and rr[sid]['audit']['verdict']=='NEEDS_HUMAN':
            s['website_reaudit_note30']=NOTES[key]
    dump(BASE/'ch07_source.json',src)
    before=(OUT/'Ch07.before.lean').read_text(encoding='utf-8')
    diff=''.join(difflib.unified_diff(groups(before)[FAIL_ID]['code'].splitlines(True),gg[FAIL_ID]['code'].splitlines(True),fromfile='website-submitted',tofile='locally-repaired'))
    (OUT/'ConstrainedHOSplitting.diff').write_text(diff,encoding='utf-8')
    dump(OUT/'REPAIR.json',dict(source_id=FAIL_ID,original_audit=rr[FAIL_ID]['audit'],suggested_fix=rr[FAIL_ID]['audit']['suggested_fix'],diff=diff,diff_summary='补概率/Wiener及H/O联合可测资格、非负步长与合规初值；输出改为P.prod P上随机变量；新增可测性、HasLaw和概率律短证明。随机初值条件解与约束保持继续明确列缺口。',coverage_gaps=[FAIL_GAP],status='待重新编译核验'))
    dump(OUT/'VERSION_PASS_MAP.json',PASS30);dump(OUT/'TRIAGE_NOTES.json',NOTES)
    print('TRIAGED 10 human items and one repair; raw reports unchanged',flush=True)

if __name__=='__main__':main()
