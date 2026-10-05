# Proposition8.2与Theorem8.1真实Hörmander证明

- 254/PDF275、344--348/PDF365--369渲染目视。Definition6.1明示C∞且包含drift b0；actual recursive seed/bracket使用genuine fderiv，point span使用真实场值Submodule.span，非自由符号。
- 原Prop8.2用了状态相关系数。HormanderClosure.lean的actual smooth scalar finite-combination module有真实C∞证明；真实Leibniz/FD/加法法则证明括号闭包，所有module成员eval都在原actual iterated bracket point span。闭包并非输入，也没有扩大Hörmander点span。
- generic drift=(F+ξG,g-γξ)、noise=(0,σ)、lift=(V,0)。真实FD证明[b0,b1]=(-σG,σγ)、lift bracket identity；真实smooth系数恢复Gtilde=-(c-γb1)/σ、Ftilde=b0-ξGtilde-(g-γξ)b1/σ。actual iterated physical brackets的lift由归纳在module中，线性inl/comap给所有horizontal方向、非零noise给vertical方向。Prop8.2完整；σ≠0是原除法隐含必要条件，明示C∞全局F/G/g，在开放域限制有同一local derivatives。
- NHL physical G=-momentum scaling，Lemma8.1正G经真实neg_mem和实际End/fderiv符号桥接映入physical {F,-G}的smooth module，再eval回到true recursive brackets。已证Prop8.3给真实SPD/distinct谱与actual mode D点张成，未供应Hörmander结论。
- 真feedback=μ⁻¹(Σp_i²-Ncθ)，θ=k_B T、M=I、Nd=Nc；实际drift逐分量等于(p,-Aq-ξp,feedback-γξ)。Σp_i²是physical Euclidean squared norm，技术Pi范数没有冒充物理能量。actual D×R开及全部NHL fields C∞已证，D对应实际orthogonal eigenvector inner products。
- Theorem8.1对所有w=(q,p,ξ)且(q,p)∈D成立；一般σ非零及μθγ>0原σ=sqrt(2θγμ⁻¹)版本均完整，真实sqrt正性推出非零噪声。
- closure-local01/02与lift-local01--04/06实际函数/FD/zero/noncomputability/notation失败全部保留；closure-local03和lift-local05/07/最终08退出0零警告。验收记录脚本的literal braces错误已修复，未更改已接受Lean输入或重跑构建。
- 唯一full-check01/session51933：2026-10-05T08:17:51.9677569+08:00--2026-10-05T08:18:56.9377781+08:00退出0；9022jobs、零警告、731项审计声明仅基础三公理、105项输入稳定，固定版本/Scratch/扫描/公理全部通过，全部输入和原始日志SHA256实查一致。29public加实际iterated构造器2/递归器接受，公理恰为propext、Classical.choice、Quot.sound，无项目新增。
- Definition6.1/Prop8.2/Lemma8.1/Prop8.3/Theorem8.1正文链机器完整，负责人语义pending。未据Hörmander单独断言完整ergodicity/可达性/密度/SDE解存在；原346未编号零mode不变、其他正文与整个CORE_SCOPE仍pending。
