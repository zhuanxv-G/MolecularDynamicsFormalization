"""The literal supp condition and the distinct Gaussian approximation family."""
from ch05_data import add,copied,proposition,D,NS
code=proposition('diracApproximation_statement').replace('(∀ ε > 0,','(∀ ε > 0,Continuous (r ε)) →\n  (∀ ε > 0,',1)
add('DiracApproximation','5.3.1',189,[37],r'''This concept of the delta function (that appears in the integral) may be motivated by introducing a sequence of continuous functions $d_\varepsilon$ having the properties (i) $\int d_\varepsilon d\omega=1$, (ii) $\operatorname{supp}(d_\varepsilon)\to0$, as $\varepsilon\to0$. Then the action of the delta function can be seen as the limit of the actions of the functions $d_\varepsilon$.''',code,extra=['[EXTRA]实际连续概率密度（原句未写非负，补非负或需统一L¹界）；supp→0解释为闭支持最终在任意零点邻域中，本谓词对非零点支撑的包含和其闭包收缩等价。保留集合supp，不误写函数sup；正ε单侧极限。'],missing='待紧支持近似恒等族、连续测试函数局部界和积分估计短桥；不建设广义函数理论。')
add('GaussianDelta','5.3.1',189,[38],r'''Alternatively, one may use a sequence of smooth functions $\{d_\varepsilon\}$, such as, in one dimension,
\[d_\varepsilon=\frac1{\sqrt{2\pi\varepsilon}}\exp\left(-\frac{z^2}{2\varepsilon}\right).\]''',copied(D,'gaussianDelta'),kind='definition',context=['Gaussian替代族的真实函数，ε>0下有概率解释；其支撑是整个ℝ，未声称它满足上一条紧支撑收缩条件。'])
add('DiracEvaluates','5.3.1',189,[36],r'''$\langle\delta,\phi\rangle=\int\delta(z)\phi(z)d\omega=\phi(0)$.''',f'''theorem diracEvaluates : ∀ n (φ : {NS}schwartzSpace n),
  (∫ z,φ z ∂({NS}diracMeasure n))={NS}diracAction φ := by
  sorry''',context=['形式积分以真实Dirac测度实现；不是给δ(z)定义普通Lebesgue函数。'])
add('GaussianDeltaProbability','5.3.1',189,[38],r'''Alternatively, one may use a sequence of smooth functions $\{d_\varepsilon\}$, such as, in one dimension,
\[d_\varepsilon=\frac1{\sqrt{2\pi\varepsilon}}\exp\left(-\frac{z^2}{2\varepsilon}\right).\]''',f'''theorem gaussianDeltaProbability : ∀ ε : ℝ,0 < ε →
  (∀ x : ℝ,0 ≤ {NS}gaussianDelta ε x) ∧ Integrable ({NS}gaussianDelta ε) volume ∧
  (∫ x,{NS}gaussianDelta ε x)=1 := by
  sorry''',extra=['[EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。'],missing='待现有Gaussian积分和归一化常数短桥。')
add('GaussianDeltaWeak','5.3.1',189,[38],r'''Alternatively, one may use a sequence of smooth functions $\{d_\varepsilon\}$, such as, in one dimension, $d_\varepsilon=(2\pi\varepsilon)^{-1/2}\exp(-z^2/(2\varepsilon))$.''',f'''theorem gaussianDeltaWeak : ∀ φ : ℝ → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun ε : ℝ => ∫ x,φ x*{NS}gaussianDelta ε x) (𝓝[>] 0) (𝓝 (φ 0)) := by
  sorry''',extra=['[EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。'],missing='待Gaussian缩放换元、支配收敛与平方根尺度趋零的桥接；不是建立新分布理论。')
