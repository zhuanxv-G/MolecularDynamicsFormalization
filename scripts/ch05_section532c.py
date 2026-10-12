"""All shell conclusions, including general patches and raw-measure invariance."""
from ch05_data import add,copied,proposition,D,NS
add('NormalInverseTaylor','5.3.2',192,[48],r'''$\Delta E=H(z+n\xi)-H(z)=\nabla H\cdot n\xi+O(\Delta E^2)$, and $n=\nabla H/\|\nabla H\|$, we have $\xi=\Delta E/\|\nabla H\|+O(\Delta E^2)$.''',f'''theorem normalInverseTaylor : ∀ n (H : {NS}E n → ℝ) z,
  ContDiff ℝ 2 H → {NS}grad H z ≠ 0 → ∃ C > 0,∃ δ > 0,
  ∀ e : ℝ,|e| < δ → ∃ ξ : ℝ,
    H (z+ξ • {NS}normalField H z)=H z+e ∧
    |ξ-e/‖{NS}grad H z‖| ≤ C*e^2 ∧
    |H (z+ξ • {NS}normalField H z)-H z-‖{NS}grad H z‖*ξ| ≤ C*e^2 := by
  sorry''',extra=['[EXTRA]实际C²和非零梯度，ξ由真实局部能量方程得到；保留反向ξ及以ΔE计的正向余项两个结论，不只证明O(ξ²)。'],missing='所需法线二阶Taylor短桥已失败3条路线并停止；本条还缺实际C²局部逆与统一ΔE余项桥接，保留全部正反向结论，不以含sorryAx的依赖冒称已证。')
add('PatchShellVolume','5.3.2','192–193',[49],r'''The volume of this thickened shell is clearly $\Delta V=\int_M\xi d\sigma$, but since $\Delta E=H(z+n\xi)-H(z)=\nabla H\cdot n\xi+O(\Delta E^2)$, and $n=\nabla H/\|\nabla H\|$, we have $\xi=\Delta E/\|\nabla H\|+O(\Delta E^2)$, and $\Delta V=\int_M\frac{\Delta E}{\|\nabla H\|}d\sigma+O(\Delta E^2)$. Taking the ratio of $\Delta V$ to $\Delta E$ we find $\Delta V/\Delta E=\int_M\|\nabla H\|^{-1}d\sigma+O(\Delta E)$. The limit of this as $\Delta E\to0$ defines a quantity $\mu(M)=\int_M\|\nabla H\|^{-1}d\sigma$.''',f'''theorem patchShellVolume : ∀ n (H : {NS}E n → ℝ) c (M : Set ({NS}E n)),
  0 < n → ContDiff ℝ 2 H → {NS}regularEnergy H c →
  IsCompact M → MeasurableSet M → M ⊆ {NS}energySurface H c →
  ∃ C > 0,∃ δ > 0,∀ e ∈ Ioo 0 δ,
    |(volume {{x | ∃ z ∈ M,∃ s ∈ Ico (0 : ℝ) δ,
        x=z+s • {NS}normalField H z ∧ H x-H z ≤ e}}).toReal/e-
        (({NS}microRaw H c) M).toReal| ≤ C*e := by
  sorry''',extra=['[EXTRA]实际紧可测正则曲面片M及薄法线管；原“clearly”体积式实际还需法线管Jacobian=1+O(ξ)，不是一般曲面的精确体积等式；最终O(ΔE)误差保留。'],missing='缺一般曲面片法线管的几何Jacobian、面积/coarea及统一误差接口；不建设大型几何理论。')
add('WholeShellVolumeLimit','5.3.2','192–193',[49],r'''$\Delta V/\Delta E=\int_M\|\nabla H\|^{-1}d\sigma+O(\Delta E)$.''',proposition('shellVolumeLimit_statement'),extra=['[EXTRA]整个正则紧能量面的壳层极限特例，原任意紧曲面片及O(ΔE)结论另条保留，不用特例替换原全结论。'],missing='缺能量壳层coarea积分接口；不建设大型几何理论。')
add('MicroRawInvariant','5.3.2',193,[50],r'''As both volume and energy are invariant under the Hamiltonian flow, $\mu(M)$ must be invariant under the flow, thus $\mu(\mathcal F_t(M))=\mu(M)$.''',f'''theorem microRawInvariant : ∀ n (H : {NS}E n → ℝ) c (f : {NS}E n → {NS}E n) Φ,
  ContDiff ℝ 2 H → {NS}regularEnergy H c → {NS}flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) ({NS}microRaw H c) ({NS}microRaw H c) ∧
    ∀ M,MeasurableSet M → ({NS}microRaw H c) (Φ t '' M)=({NS}microRaw H c) M := by
  sorry''',extra=['[EXTRA]原正文调用的实际全流、体积与能量保持先验明确写出；需要推出的是曲面加权raw测度保持，未把该结论作前提。'],missing='缺由体积/能量保持到真实曲面加权测度的coarea桥；不建设大型几何理论。')
add('MicroInvariant','5.3.2',193,[50],r'''$\mu(\mathcal F_t(M))=\mu(M)$.''',proposition('microInvariant_statement'),extra=['[EXTRA]归一化measure版本另列；原始未归一化µ的不变及集合像等式由上一完整条目保留，不能只凭归一化定义编译称全部已证。'],missing='缺真实coarea及曲面测度保持接口；不建设大型理论。')
add('MicroPartition','5.3.2',193,[51],r'''The invariant measure of the whole level set $\Sigma_E$ is defined as the microcanonical partition function $Z_E=\mu(\Sigma_E)$.''',copied(D,'microPartition'),kind='definition',context=['raw测度本身受限于ΣE，univ总质量对应ΣE；ENNReal转实只有有限总质量时适用物理Z_E，概率归一化条件后续明确。'])
