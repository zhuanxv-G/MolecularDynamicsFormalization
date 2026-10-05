# Theorem 6.1：实际光滑周期定义域与 Brownian 算子

沿用已核对原印刷250–251/PDF271–272、实际有限unit torus及其同一归一化Gibbs概率测度。势能U光滑且整数格点周期；定义域包含所有C∞整数周期实函数的实际Hilbert嵌入，并非有限Fourier截断。质量保留任意对角质量；β≠0仅用于Dirichlet/对称，β>0且各质量正用于非正二次型。

真实坐标Frechet partial的加法及数乘推出原微分表达式的线性；其光滑/周期保持性给全光滑周期空间的线性endomorphism。实际Gibbs L²嵌入是真LinearMap，单射由前批已证明的fullsupport推出。range是实际Hilbert子空间，LinearEquiv.ofInjective给唯一光滑lift，然后composition构造domain→实际L²线性算子；证明对每个lift与原generator image完全一致。真实Dirichlet等式、全domain pair对称与非正、常数零模式和常数1实际范数1均完整推导。

本批不声称定义域稠密、算子有界或无界的定理、闭性、自伴闭包、compact resolvent、离散谱、Poincare/gap或真实semigroup期待收敛。C∞ core只作为原C²目标的必要依赖；Theorem6.1整体仍未完成。负责人教材语义待签核。

api01固定API退出0。local01先前8public退出0；local02加嵌入/domain后rw不匹配Subtype carrier projection和RingHom.id；local03用真实AE equality和congrArg/trans组合后仅加法show的g未显式转成函数而HAdd失败。local04将g显式转为函数，全候选退出0空日志，零警告。失败日志保留，不当验收成功。统一full-check01正在进行，正式Lean输入冻结。

full-check01 passed：9066 jobs/1259公理声明/149exact输入；10checks退出0，全部input/rawlog SHA256匹配，22public逐名仅基础三公理，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人semanticpending。
