"""Website repair of section 2.2.1 after original PDF82-84 visual inspection."""
from website_repair_batch import prepare, verify, commit_section
from eaudit_review_tasks import declarations

def run():
    ds=declarations(2)
    sid='MD-2.2.1-FirstVariation'
    first=ds[sid]['statement']+'''
    ∧ (∃ C > 0, ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∀ t ∈ Icc a b,
      |L (q t + ε • η t) (deriv q t + ε • deriv η t) - L (q t) (deriv q t) -
        ε * ((fderiv ℝ (fun x ↦ L x (deriv q t)) (q t)) (η t) +
          (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t))| ≤ C * |ε|^2) := by
  sorry'''
    stationary=ds['MD-2.2.1-StationaryAction']['block']+'''

theorem stationarySmoothAction_iff_first_variation {n : ℕ}
    (L : Q n → Q n → ℝ) (q : ℝ → Q n) (a b : ℝ)
    (_hab : a < b) (_hL : ContDiff ℝ 2 (Function.uncurry L)) (_hq : ContDiff ℝ 2 q) :
    stationarySmoothAction L a b q ↔
      ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
      (∫ t in a..b, (fderiv ℝ (fun x ↦ L x (deriv q t)) (q t)) (η t) +
        (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) = 0 := by
  sorry

theorem stationarySmoothAction_hamilton {n : ℕ}
    (L : Q n → Q n → ℝ) (q : ℝ → Q n) (a b : ℝ)
    (_hab : a < b) (_hL : ContDiff ℝ 2 (Function.uncurry L)) (_hq : ContDiff ℝ 2 q)
    (_hnatural : ∀ t ∈ Ioo a b,
      HasDerivAt (fun s ↦ fderiv ℝ (L (q s)) (deriv q s))
        (fderiv ℝ (fun x ↦ L x (deriv q t)) (q t)) t) :
    stationarySmoothAction L a b q := by
  sorry'''
    edits={sid:{'code':first,'category':'B','note':'保留原三个结论，并补同一个真实点态Taylor余项的紧时间窗统一C|ε|²控制；没有把余项界当作前提，未新增证明。'},
      'MD-2.2.1-StationaryAction':{'code':stationary,'category':'B','note':'保留驻值定义，同一source_id补完整积分I=0等价式及自然Euler–Lagrange运动推出驻值的Hamilton原理；C²及a<b是充分资格。新结论只登记sorry陈述，证明留到网站PASS后。'}}
    human={'MD-2.2.1-Admissible':'原页先说C²后又说C∞，曲线类采用哪种区间光滑资格？选项：C²区间／C∞可延拓类；现有全线代表资格保持，待裁定。',
      'MD-2.2.1-StationaryNotMin':'脚注的极小/极大/鞍点及第二变分采用哪种曲线空间与拓扑？选项：导师指定C∞空间和范数后补全部分类／明确拆分脚注与既有EulerLagrange条目；原页未给拓扑，保留现状，不自行选一致范数。'}
    prepare(2,'EAUDIT03','2.2.1',edits,pages=[82,83,84],source_only=['MD-2.2.1-EulerLagrange','MD-2.2.1-VariationalDerivativePrinted'],human=human)
    verify(2,'EAUDIT03');commit_section(2,'2.2.1',['EAUDIT03'])

if __name__=='__main__':run()
