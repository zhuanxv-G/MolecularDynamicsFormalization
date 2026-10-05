# 下一真实转移半群依赖（路线，未验收定理）

新建LangevinTransitionSemigroup.lean，导入已接受LangevinTransitionKernel和固定Mathlib.Probability.Kernel.Composition.MeasureComp。

1. 对whole-history joint law取Measure.snd，用Measure.snd_map_prodMk₀(history AEm)(actual endpoint AEm)和Measure.snd_compProd得到future marginal=history-eval-comap kernel ∘ₘ history law。
2. 用Measure.bind_apply hs κ.aemeasurable、Kernel.comap_apply和lintegral_map' (κ.measurable_coe hs).aemeasurable history AEm，将右边识别为K_T ∘ₘ (P.map X(S))。Endpoint AEm可直接调用已接受_global_endpoint_aemeasurable。
3. K_S(x)=P.map X_x(S)来自_global_law；Kernel.comp_apply表示(K_T∘ₖK_S)x=(K_Sx).bind K_T。由上述future marginal得到K_(S+T)=K_T∘ₖK_S，注意NNReal sum coercion与real S+T。
4. K_0=id来自actual integral solution initial q/p恒等式，需查原solution的initial API；若global initial仅common AE，使用Measure.map_congr与map_const概率law。周期初始projection(representative x,x.p)=x已有代码。
5. 同样给periodic实际核证明semigroup；最终原C∞lattice-periodic U forceLip实际推出。不得把Chapman–Kolmogorov或transition密度当输入。

精确API：Measure.snd_compProd μ κ : (μ⊗ₘκ).snd=κ∘ₘμ；Kernel.comp_apply η κ x=(κ x).bind η；Measure.bind_apply hs κ.aemeasurable；lintegral_map' hf hg支持真实AEm history/endpoint。Filtration.natural需逐点StronglyMeasurable，现有模型仅AEm；完成化和exceptional版本处理单独证明，不能直接宣称adapted。completed filtration/密度/actual generator/Harris及CORE_SCOPE仍pending。
