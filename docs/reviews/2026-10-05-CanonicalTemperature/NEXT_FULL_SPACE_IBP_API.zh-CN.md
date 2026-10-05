# 下一批：原Prop6.1 full-space IBP与density cutoff极限（未实现/验证）

本批CanonicalTemperature18public机器验收后继续，不能称原温度比值已完成。Print222/PDF243实际原页及证明缺口见REVIEW。

固定API已读取：
- import Mathlib.Analysis.Calculus.BumpFunction.FiniteDimension 包含finiteDim HasContDiffBump；ContDiffBump(0:SymplecticCoordinates Nc)=rIn1/rOut2，contDiff、one_of_mem_closedBall、mem_Icc、hasCompactSupport。
- HasCompactSupport.fderiv ℝ、HasCompactSupport.exists_bound_of_continuous (hG.continuous_fderiv...) 给基函数fderiv全域C界。
- Homeomorph.smulOfNeZero c hc是真正c•x缩放，HasCompactSupport.comp_homeomorph给缩放基函数compact；因此η_R(z)=η(R^-1•z) actual derivative norm≤C/R，η_R每fixed z最终exact1。
- 已接受textbookCompactPhaseField_integral_divergence_eq_zero给compact C1 η_RF积分0。Divergence_density给η_R divF + dη_R(F)，C/R*norm F支配误差，F L1及divF L1→DCT证明全域divF积分0。不要额外要求每partial全域L1。
- smoothTransition原实际derivative在outside[0,1]局部常数为0，导数cont与紧支→global derivative bound。对真实Fn=χ_RρG，本批已推导Fn L1；cutoff flux divergence公式的error乘actual weighted LieG H可积+derivative bound→divFn L1，C1 Fn真实。
- 应用上述full-space div积分0到Fn，χ_R divFlux DCT→divFlux；1/R误差global bound支配integral趋0，得原ρG全域div积分0，无原ρG L1假设。
- 本批derived actual divFlux integrable及weighted divergence真实恒等式，integral_sub/const_mul→∫(divG)ρ=β∫(LieG H)ρ；canonical Z>0归一化，再原Av divG正及β=(kBT)^-1/β>0得原温度比值。

原第三条uniform weighted bound解释负责人pending；若仅逐点有限不够作同证明前提，不冒称无条件原命题或假定IBP结论。后续完整Prop6.1和Theorem6.2 actual generator/density/Harris、全CORE_SCOPE未完成。
