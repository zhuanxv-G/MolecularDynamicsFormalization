"""Eight §3.4 proof components, original PDF137–138."""
from ch03_data import add,copied,proposition
B='MolecularDynamics/Chapter03/ModifiedHamiltonianBounds.lean'
E='MolecularDynamics/Chapter03/ModifiedEnergyDrift.lean'
L='MolecularDynamics/Chapter03/LiePoisson.lean'
add('TruncatedConservation','3.4',115,[75],r'''Since $\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have
\[\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))=\widetilde H_k(\boldsymbol z_n).\]''',
copied(L,'textbookHamiltonian_energy_const_on_Icc','truncatedConservation'),context=[r'K=H̃_k代入签名的H；本条对任意真实Hamiltonian曲线成立，不预设守恒结论。'],
extra=['沿γ对K的可微性与真实ODE在闭区间明示，包含端点；构造γ属于另项。'],prior=['MolecularDynamics.textbookHamiltonian_energy_const_on_Icc'])
add('EnergyTelescoping','3.4',115,[76],r'''Now
\[\begin{aligned}\widetilde H_k(\boldsymbol z_\nu)-\widetilde H_k(\boldsymbol z_0)&=\sum_{n=0}^{\nu-1}\widetilde H_k(\boldsymbol z_{n+1})-\widetilde H_k(\boldsymbol z_n)\\
&=\sum_{n=0}^{\nu-1}\widetilde H_k(\boldsymbol z_{n+1})-\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))\\
&=\sum_{n=0}^{\nu-1}\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n)-\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)).\end{aligned}\]''',
copied(E,'oneStep_energy_telescoping','energyTelescoping'),context=[r'第一行是任意K的真实迭代有限和恒等式；第二、三行由同页独立TruncatedConservation与FiniteMatchingConstruction代入，并非本条额外假设能量守恒。'],
explanation='本条有限和恒等式与前两项守恒/缺陷定义共同给出三行；只桥接真实望远镜求和，不伪称modifiedConstruction完成。',
prior=['MolecularDynamics.oneStep_energy_telescoping'])
add('UniformTruncatedLipschitz','3.4',115,[77],r'''Hence
\[|\widetilde H_k(\boldsymbol z_\nu)-\widetilde H_k(\boldsymbol z_0)|\le L\sum_{n=0}^{\nu-1}\|\boldsymbol\eta_n\|\le L\nu h^{k+1}.\]''',
copied(B,'exists_uniform_textbookTruncatedHamiltonian_lipschitz','uniformTruncatedLipschitz'),context=[r'此行所用实际H̃_k的统一L；原文先对H取L然后沿用到H̃_k，需要补本条严格辅助；整段漂移界见PhysicalEnergyDrift。'],
extra=['开放D、紧凸B⊆D及H和有限H_j在D C¹；0≤h≤1；L由有限系数导数界推出。'],
prior=['MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_lipschitz'])
add('TruncationRemainder','3.4',115,[78],r'''Next observe that
\[H=\widetilde H_k-h^rH_{(r)}-h^{r+1}H_{(r+1)}-\cdots-h^kH_{(k)}=\widetilde H_k+O(h^r).\]''',
copied(B,'exists_uniform_textbookTruncatedHamiltonian_remainder','truncationRemainder'),context=[r'固定r,k；实际有限式(3.11)，非无穷级数；绝对值即ℝ范数。'],
extra=['各有限系数在紧B连续；0≤h≤1；统一正C由紧性推出，未供应所需余项界。'],prior=['MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_remainder'])
add('PhysicalEnergyDrift','3.4',115,[79],r'''Therefore
\[|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le L\nu h^{k+1}+O(h^r),\]''',
copied(E,'textbook_energy_drift_le_actual_defects','physicalEnergyDrift'),context=[r'同页先得H̃_k有限和变化，再用起点和终点各一份H−H̃_k的余项；这条先以实际端点缺陷的和给界，νh^(k+1)替换见下一条。'],
extra=['开放D、紧凸B⊆D及有限C¹系数；给定真实截断ODE族γ及其留B、γ(h,z,0)=z，未假设γ的能量守恒或误差界。'],
prior=['MolecularDynamics.textbook_energy_drift_le_actual_defects'])
add('PolynomialEnergyRate','3.4',116,[80],r'''so that, as long as $\nu\le C_2h^{-k+r-1}$, we have
\[|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le O(h^r).\]''',
copied(E,'textbook_energy_drift_rate_of_flow_defect','polynomialEnergyRate'),context=[r'只桥接原书证明的“已有实际局部缺陷界后的条件推论”；整体构造/匹配为FiniteMatchingConstruction未完成，不能以此宣称Thm3.1完整已证。'],
extra=['[EXTRA]hdefect是假设明确给出的实际一步O(h^(k+1))端点界，源自原书“By construction”尚未形式化的先验；不是本条能量结论。','D/B及C¹、实际截断ODE留B、r≤k、A,T≥0、0<h≤1、数值轨道留B；长时间条件νhh^(k−r)≤T。'],
prior=['MolecularDynamics.textbook_energy_drift_rate_of_flow_defect','需另证FiniteMatchingConstruction；本条仅条件化先验推论'])
add('StepCountPower','3.4',116,[81],r'''so that, as long as $\nu\le C_2h^{-k+r-1}$, we have
\[|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le O(h^r).\]''',
copied(E,'energy_step_count_power_factor','stepCountPower'),context=[r'旧CH03-081是该证明用到的代数换写νh^(k+1)=(νhh^(k−r))h^r；原文没有单独展示等式，作为证明辅助单列。'],
extra=['自然数r≤k使k−r没有截断损失；不将此代数辅助冒充完整能量定理。'],prior=['MolecularDynamics.energy_step_count_power_factor'])
add('ArbitraryFiniteTruncation','3.4',116,[82],r'''If the differential equations are infinitely differentiable, we may take the truncation index $k$ as large as we like, but the constants appearing in the above theorem will depend on the truncation index in a complicated way.''',
proposition('modifiedConstruction_statement','arbitraryFiniteTruncation'),context=[r'同章原始近恒等辛Hamiltonian方法上下文；无限可微不意味着解析或指数误差；每个固定k有自己的δ,A。'],
extra=['smoothSymplecticData保持全部Hamiltonian/近恒等辛/compact条件；完整∀k匹配作为结论，没有把它当作前提。'],
missing='缺全阶Hamiltonian构造与实际截断匹配；C∞的任意固定阶不推出统一解析界。')

# Supply the two independent real constants explicitly; apply otherwise chooses
# the time-window constant T for the one-step defect coefficient A.
from ch03_data import RECORDS
rate=next(x for x in RECORDS if x['source_id']=='MD-3.4-PolynomialEnergyRate')
rate['code']=rate['code'].split(' := by')[0]+''' := by
  exact MolecularDynamics.textbook_energy_drift_rate_of_flow_defect
    H Hj r k hrk D B hD hB hconv hBD hH hHj G γ hγ₀ hγB hγ A T hA hT hdefect'''
