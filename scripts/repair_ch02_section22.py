"""Sections 2.2.2-2.2.4 website repairs; PDF85-93 visually checked."""
from website_repair_batch import prepare,verify,commit_section
from eaudit_review_tasks import declarations

def run(section):
    ds=declarations(2)
    if section=='2.2.2':
        edits={
          'MD-2.2.2-DiscreteStationaryPrinted':dict(category='A',note='保留原印0<k≤ν范围和端点疑误；改用HasFDerivAt表达经典零导数，防止不可微处fderiv总化为零；内部节点版本已有独立DiscreteVerlet条目，不裁定端点勘误。',code='''def printedDiscreteStationary {n : ℕ} (L : Q n → Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k ≤ ν →
    HasFDerivAt (fun x ↦ discreteAction L (replaceNode q k x) h ν) 0 (q k)'''),
          'MD-2.2.2-Stormer':dict(category='C',note='直接使用原文质量乘法形式M(qₙ₊₁−2qₙ+qₙ₋₁)=h²F(qₙ)，避免零质量下逆质量总化造成对象不等价；仅更改Blueprint本条。',code='''def bp_stormerRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (a b c : Q n) : Prop :=
  mass m (c - (2 : ℝ) • b + a) = h^2 • F b''')}
        human={'MD-2.2.2-DiscreteAction':'原页正文机械L写+U，而展示离散作用量写−U；选项：批准以展示式−U另立修订／保留两种原印并只登记一般L。此处不自行选择符号勘误，原一般定义保持。'}
        prepare(2,'EAUDIT04',section,edits,pages=[85,86,87],source_only=['MD-2.2.2-DiscreteDerivative'],human=human)
        verify(2,'EAUDIT04');commit_section(2,section,['EAUDIT04'])
    elif section=='2.2.3':
        code=ds['MD-2.2.3-Consistency']['block'].replace('  ∃ K ≥ 0,','  0 < p ∧ ∃ K ≥ 0,')
        edits={'MD-2.2.3-Consistency':dict(category='A',note='显式0<p；本条只登记正自然数阶，属于[EXTRA]整数阶限制；保持统一K、δ及严格0<h<δ，不静默扩大端点。',code=code)}
        human={'MD-2.2.3-DefectPrinted':'原印Q−q(t+h)三阶项符号与Taylor相减不符；选项：批准另立正残差修正版／保留原印作为疑误。原负/正号不自行裁定，当前字面陈述保持。'}
        prepare(2,'EAUDIT05',section,edits,pages=[88,89,90,91],source_only=['MD-2.2.3-ErrorBound','MD-2.2.3-VerletExpansion','MD-2.2.3-ExactExpansion','MD-2.2.3-VerletConsistency','MD-2.2.3-VerletStability'],human=human)
        verify(2,'EAUDIT05');commit_section(2,section,['EAUDIT05'])
    elif section=='2.2.4':
        code=ds['MD-2.2.4-FirstIntegral']['block'].replace('  ∀ z ∈ D,','  IsOpen D ∧ DifferentiableOn ℝ I D ∧ ∀ z ∈ D,')
        edits={'MD-2.2.4-FirstIntegral':dict(category='A',note='签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。',code=code)}
        human={'MD-2.2.4-IntegralErrorPrinted':'原印KB/(2L)比已给点误差推出的KB/L小一半；选项：批准另立去掉2的修正版／导师提供独立更强误差前提；保持原印和常数，不加倍K、不把积分误差当假设。'}
        prepare(2,'EAUDIT06',section,edits,pages=[92,93],source_only=['MD-2.2.4-IntegralPreserved','MD-2.2.4-IntegralLipschitz'],human=human)
        verify(2,'EAUDIT06');commit_section(2,section,['EAUDIT06'])
    else: raise ValueError(section)

if __name__=='__main__':
    import sys
    run(sys.argv[1])
