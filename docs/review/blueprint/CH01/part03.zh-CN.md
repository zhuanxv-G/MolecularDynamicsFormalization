[上一部分](part02.zh-CN.md) / [目录](../../CH01_BLUEPRINT.zh-CN.md) / 下一部分：无

## 1. MD-1.6-PeriodicImages · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> periodic boundary conditions involve an extended potential energy of the form

$$
U^{\mathrm{pbc}}(\boldsymbol q)=\sum_{klm}\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{ij}(\boldsymbol q_i,\boldsymbol q_j+k\boldsymbol v_1+l\boldsymbol v_2+m\boldsymbol v_3),
$$


> where $`k,l,m`$ run over $`-1,0,1`$ (in case interactions are restricted to the simulation cell and its immediate neighboring copies), and $`\boldsymbol v_i^T=(L\boldsymbol e_i^T,L\boldsymbol e_i^T,\ldots,L\boldsymbol e_i^T)`$, $`i=1,2,3`$, where $`\boldsymbol e_i`$ is the $`i`$th Euclidean basis vector in $`\mathbb R^3`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def periodicImageEnergy {N : ℕ} (L : ℝ) (φ : Fin N → Fin N → twoBodyTerms)
    (q : Fin N → V3) :=
  ∑ k : Fin 3, ∑ l : Fin 3, ∑ m : Fin 3, ∑ i, ∑ j ∈ Finset.Ioi i,
    φ i j (q i) (q j + WithLp.toLp 2 ![L*((k.val:ℝ)-1),L*((l.val:ℝ)-1),L*((m.val:ℝ)-1)])
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.periodicImageEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U^{\mathrm{pbc}}(\boldsymbol q)=\sum_{klm}\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{ij}(\boldsymbol q_i,\boldsymbol q_j+k\boldsymbol v_1+l\boldsymbol v_2+m\boldsymbol v_3),`$ | MD.Ch01.periodicImageEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
MD.Ch01.periodicImageEnergy：对“将原页 v\_i 解释为其对应粒子三维块 L e\_i”的解释，签名 PASS。对任意自然数 N、实 L、所有二体项 φᵢⱼ 与三维配置 q，定义恰枚举27个位移和全部无序不同标签对 i<j，逐项计算 φᵢⱼ(qᵢ,qⱼ+L(k,l,m))。N=0 或1时空配对求和为0，忠实于印刷的 i<j；没有擅加 i=j 的自镜像，也没有擅加1/2。构造公式本身可推广到任意 L,q，物理盒长正且坐标位于盒内是书中背景，而非这一定义声称的额外定理。未解决之处是原页把 v\_i 定义为全配置重复块，和此处二体参数三维之间存在类型冲突；JSON 的“等价”说明只能给出一种修复解释，不能消除原书符号问题。因此总判 NEEDS\_HUMAN，而非声称已逐类型忠实形式化了原公式。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1947；MD.Ch01.periodicImageEnergy。

## 1. MD-1.6-MinimumImage · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> The minimum image convention states that, in computing the force, a given atom interacts only with the nearest replica of any other atom.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def minimumImage (L : ℝ) (q r image : V3) : Prop :=
  ∃ k : Fin 3 → ℤ, image = r + WithLp.toLp 2 (fun i => L*k i) ∧
    ∀ l : Fin 3 → ℤ, ‖q-image‖ ≤ ‖q-(r+WithLp.toLp 2 (fun i => L*l i))‖

def minimumImageForce {N : ℕ} (L : ℝ) (q : Fin N → V3)
    (image : Fin N → Fin N → V3) (pairForce : Fin N → Fin N → V3 → V3 → V3)
    (force : Fin N → V3) : Prop :=
  0 < L ∧ (∀ i j, i ≠ j → minimumImage L (q i) (q j) (image i j)) ∧
    ∀ i, force i = ∑ j ∈ Finset.univ.erase i, pairForce i j (q i) (image i j)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.minimumImage；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.minimumImage; MD.Ch01.minimumImageForce | 最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.minimumImage; MD.Ch01.minimumImageForce | 最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。 |

[EXTRA] [EXTRA] 19号：最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。

### 6. 审计结论

19号本地签名预审：最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.minimumImage：PASS。L∈ℝ，q,r,image∈V3；存在 k∈ℤ³ 使 image=r+Lk，且对所有 l∈ℤ³ 有 ‖q−image‖≤‖q−(r+Ll)‖。最小性使用≤，允许距离并列；关系自身不含 L>0，但下述完整模型补足。MD.Ch01.minimumImageForce：PASS。对 N 个标签的位置 q、每对标签的选中像 image、二体力回调 pairForce 以及总力 force，要求0<L；对 i≠j 要求对应最小像关系；对每个 i 总力恰为 j≠i 上 pairForce(i,j,qᵢ,imageᵢⱼ) 的和。因此“other”不包括自标签，“only”通过每个其他标签只出现一个选中复制体落实。并未错误断言距离最小者在数学上唯一，也不将并列的所有像一起相加。pairForce 是输入的二体力，原句未给它另一个解析表达式。[EXTRA] 与这两层定义一致。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1956；MD.Ch01.minimumImage。

## 1. MD-1.6-RhombicLattice · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> In 2D, the typical geometry observed at low temperature is defined by a rhombic lattice with sides of fixed length $`n_x,n_y`$ and the angle between them ($`\theta`$), see Fig. 1.17.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def rhombicLattice (a b θ : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}

def RhombicLatticeValidDomain (a b θ : ℝ) : Prop :=
  0 < a ∧ 0 < b ∧ Real.sin θ ≠ 0

def rhombicLatticeOnDomain (a b θ : ℝ) (_h : RhombicLatticeValidDomain a b θ) :
    Set (Position 2) := rhombicLattice a b θ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.rhombicLatticeOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 21号网站建议修复 | MD.Ch01.rhombicLatticeOnDomain | 一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。 |

[EXTRA] [EXTRA] 一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
MD.Ch01.rhombicLattice：FAIL（参数域/几何资格）。集合公式 x=k(a,0)+l(b cosθ,b sinθ)，k,l∈ℤ，方向、索引及二维实欧氏对象均正确；旋转/平移选定坐标本身不是问题。缺陷是 a,b,θ 无任何资格，不能保证两条边的长度为正或两个生成方向独立：行列式为 ab sinθ，可能为0。原文及图1.17描述的是二维格，而当前构造连秩0、秩1的退化集合也全部接收。[EXTRA] 为空，不能从“基向量”这个中文名称推入 Lean 中没有的线性无关性。作为一般整数生成集合的辅助定义它是合法的，但作为未加资格的二维 rhombic lattice 完整对应不足。没有把“低温典型”误审为必须额外证明的普遍低温定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1977；MD.Ch01.rhombicLatticeOnDomain。

## 1. MD-1.6-HexagonalLattice · unnumbered_claim · 印刷p.35 / PDFp.58

### 2. 原文陈述

> it can be viewed as a rhombic lattice with $`n_x=n_y`$ and $`\theta=120^\circ`$; it can also be viewed as a rhombic lattice with $`\theta=60^\circ`$

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hexagonal_lattice_two_bases (a : ℝ) :
    rhombicLattice a a (2*Real.pi/3) = rhombicLattice a a (Real.pi/3) := by
  ext x
  have hc : Real.cos (2*Real.pi/3) = -(1/2:ℝ) := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]
  have hs : Real.sin (2*Real.pi/3) = Real.sqrt 3/2 := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.sin_pi_sub, Real.sin_pi_div_three]
  constructor
  · rintro ⟨k,l,rfl⟩
    refine ⟨k-l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring
  · rintro ⟨k,l,rfl⟩
    refine ⟨k+l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hexagonal\_lattice\_two\_bases；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1985；MD.Ch01.hexagonal\_lattice\_two\_bases。

## 1. MD-1.6-UnitCell · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> The unit cell is a description of the arrangement of atoms within a box; unit cells may be stacked in each direction to describe an atomic lattice.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def unitCellLattice (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Set V3 :=
  {q | ∃ k : Fin 3 → ℤ, ∃ u ∈ motif,
    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}

/-- Half-open cell B([0,1)^3), with boundary representatives fixed by coordinates. -/
def unitCellBox (B : Matrix (Fin 3) (Fin 3) ℝ) : Set V3 :=
  B.toEuclideanLin '' {x : V3 | ∀ i, 0 ≤ x i ∧ x i < 1}

def UnitCellValidDomain (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Prop :=
  B.det ≠ 0 ∧ motif.Finite ∧ motif.Nonempty ∧ motif ⊆ unitCellBox B

def unitCellOnDomain (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3)
    (_h : UnitCellValidDomain B motif) : Set V3 := unitCellLattice B motif
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.unitCellOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 21号网站建议修复 | MD.Ch01.unitCellOnDomain | 一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。 |

[EXTRA] [EXTRA] 一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
MD.Ch01.unitCellLattice：FAIL（对象域/晶胞资格）。平移公式和存在量词准确编码了以三个生成向量重复 motif 的操作，但 B:Matrix (Fin 3) (Fin 3) ℝ 不是三维基的类型；B 可以奇异或为0。motif:Set V3 也未声明为盒内有限原子排列，甚至允许 motif=整个ℝ³。故定义输出不一定是三维离散原子晶格，不能仅靠 context\_notation 的自然语言声称已经落实原书的“within a box”和“each direction”。此构造可保留为平移并集函数；缺失的是作为原书 unit cell 的有效输入资格，而非要求每个晶胞只能有一个原子。[EXTRA] 为空，未提供这些资格。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2022；MD.Ch01.unitCellOnDomain。

## 1. MD-1.6-FCCStacking · definition · 印刷p.36 / PDFp.59

### 2. 原文陈述

> The fcc lattice corresponds to the common arrangement by which cannonballs are stacked into pyramidal structures; it can be viewed as a periodic stacking (ABCABC. . . ) of three hexagonally structured planar layers, as illustrated in Fig. 1.18.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def fccStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 3
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.fccStacking；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。 | [EXTRA] |

[EXTRA] 将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。

### 6. 审计结论

ABC三周期保留；旧库附带具体几何层高和偏移不是正文逐字公式，需要导师确认图示编码。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.fccStacking：PASS。x∈ℝ³，当且仅当存在任意整数 k，使 z=k√(2/3)，且平面坐标落在 triangularLayer(j/2,j√3/6)，j=k mod3。triangularLayer(u,v) 的点为 (p+r/2+u,r√3/2+v)，p,r∈ℤ，是单位最近邻间距的等边三角点阵。余数0,1,2分别给 A、B、C 三个不同平移类；其顺序每三层重复。设 s=(1/2,√3/6)，则3s=(3/2,√3/2)为底层格向量，所以 C 后回到 A 正合 ABC 堆积；层高√(2/3)与水平孔位偏移共同给单位接触距离。k 可负，正模数的整数余数仍遍历0,1,2，覆盖双向无限晶格。固定尺度、坐标与取向是[EXTRA]明确说明的图示具体实现，并非正文声称给出了这些数值公式。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2030；MD.Ch01.fccStacking。

## 1. MD-1.6-HCPStacking · definition · 印刷p.36 / PDFp.59

### 2. 原文陈述

> Also shown in Fig. 1.18 is the hcp lattice, which, on the other hand, alternates two distinct planar lattices.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hcpStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 2
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hcpStacking；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。 | [EXTRA] |

[EXTRA] 图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。

### 6. 审计结论

AB两周期保留；具体几何参数来源图示而非正文公式，需导师确认编码。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.hcpStacking：PASS。任意整数 k 给定高度 k√(2/3)，j=k mod2∈{0,1}，其平面层为 triangularLayer(j/2,j√3/6)。展开 triangularLayer，A 是零偏移的单位三角层，B 相对 A 偏移 (1/2,√3/6)，该偏移不在底层三角格中，故确为两种不同层；k+2 与 k 的平面位置一致而高度相差2√(2/3)，实现 ABAB。层高及孔位偏移给正确密堆积单位接触尺度。不存在误用三余数造成ABC的问题。[EXTRA]已说明单位化数值来自图示的具体密堆积编码，正文的两层交替信息得到完整保存。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2039；MD.Ch01.hcpStacking。

## 1. MD-1.6.1-MinimumGradientZero · unnumbered_claim · 印刷p.36–37 / PDFp.59–60

### 2. 原文陈述

> Regardless of the choice of boundary and/or the inclusion of non-pairwise potentials, the minimum of the potential energy occurs where

$$
\nabla U=0,
$$


> which gives in general a nonlinear system of $`N_c`$ equations in $`N_c`$ unknowns to be solved for the position vector $`\boldsymbol q^*`$ associated to mechanical equilibrium.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem minimumgradientzero :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0 := by
  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved

/-- 修正版，对应原文 MD-1.6.1-MinimumGradientZero，改动：显式标为无约束内点极小的必要条件，保留已证桥接；不扩展到约束边界。 -/
theorem minimumgradientzero_corrected :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0 := by
  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.minimumgradientzero；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\nabla U=0,`$ | MD.Ch01.minimumgradientzero，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。 | [EXTRA] |

[EXTRA] 可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。

### 6. 审计结论

约束边界极小一般不能推出全梯度为零；原上下文若含边界须区分可行方向。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
MD.Ch01.minimumgradientzero：在[EXTRA]明示的无约束内点解释下，数学签名 PASS。n∈ℕ，U:EuclideanSpace ℝ (Fin n)→ℝ，q 属于同一空间；DifferentiableAt ℝ U q 与全空间 IsLocalMin U q 足以推出 gradient U q=0。它给必要条件，没有将驻点偷换为充分极小条件；n 维梯度等于0等价于 n 个分量方程，不需另断言这些方程对每个 U 都非线性。MD.Ch01.minimumgradientzero\_corrected：PASS，为同一个正确的无约束内点必要条件；其“修正”是解释范围的更正而非新签名。原书“Regardless of boundary”若包括受约束边界极小则过强，现有 Lean 也未覆盖这种解释。[EXTRA]已诚实披露可微、内点及边界限制，但不能据此认定原书无条件原句成立。故源文及总 verdict 保持 NEEDS\_HUMAN。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2048；MD.Ch01.minimumgradientzero。

## 1. MD-1.6.1-ForceLinearization · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> At the equilibrium point, we can linearize the system of differential equations by computing the Hessian matrix, then we find

$$
\nabla U(\boldsymbol q)\approx U''(\boldsymbol q^*)(\boldsymbol q-\boldsymbol q^*).
$$


> Then, letting $`\delta\boldsymbol q=\boldsymbol q-\boldsymbol q^*`$, $`\delta\boldsymbol p`$ represent small deviations from the equilibrium point at $`(\boldsymbol q,\boldsymbol p)=(\boldsymbol q^*,0)`$, we have

$$
\frac{\mathrm d\delta\boldsymbol q}{\mathrm dt}=\boldsymbol M^{-1}\delta\boldsymbol p,\qquad\frac{\mathrm d\delta\boldsymbol p}{\mathrm dt}=-U''(\boldsymbol q^*)\delta\boldsymbol q.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem force_linearization {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hU : ContDiffAt ℝ 2 U qstar)
    (heq : gradient U qstar = 0) :
    HasFDerivAt (fun z : PhaseSpace n => (matrixAction M⁻¹ z.2, -gradient U z.1))
      (((Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹).comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n))).prod
        ((-fderiv ℝ (gradient U) qstar).comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n))))
      (qstar,0) ∧
    (fun q => gradient U q - fderiv ℝ (gradient U) qstar (q-qstar)) =o[𝓝 qstar]
      (fun q => q-qstar) := by
  let B := Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹
  have hg := (gradient_contDiffAt_of_potential_contDiffAt_two hU).differentiableAt (by norm_num)
  constructor
  · change HasFDerivAt (fun z : PhaseSpace n => (B z.2, -gradient U z.1)) _ (qstar,0)
    have hn : HasFDerivAt (fun q => -gradient U q) (-fderiv ℝ (gradient U) qstar) qstar :=
      hg.hasFDerivAt.neg
    have h₂ := hn.comp (qstar,0)
      ((ContinuousLinearMap.fst ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    have h₁ := B.hasFDerivAt.comp (qstar,0)
      ((ContinuousLinearMap.snd ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    exact h₁.prodMk h₂
  · have h := hasFDerivAt_iff_isLittleO.mp hg.hasFDerivAt
    simpa only [heq, sub_zero] using h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.force\_linearization；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\nabla U(\boldsymbol q)\approx U''(\boldsymbol q^*)(\boldsymbol q-\boldsymbol q^*).`$；$`\frac{\mathrm d\delta\boldsymbol q}{\mathrm dt}=\boldsymbol M^{-1}\delta\boldsymbol p,\qquad\frac{\mathrm d\delta\boldsymbol p}{\mathrm dt}=-U''(\boldsymbol q^*)\delta\boldsymbol q.`$ | MD.Ch01.force\_linearization，完整展开陈述见上一行及第4段 | 一致 |
| 一般质量Hamilton向量场的块导数 | (M⁻¹∘snd).prod ((-D∇U)∘fst)的HasFDerivAt | 一致 |
| 梯度线性化误差 | ∇U(q)-D∇U(q*)(q-q*) =o[𝓝 q*] (q-q*) | 一致 |
| 原文未显式量化的技术资格 | 真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。 | [EXTRA] |

[EXTRA] 真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。

### 6. 审计结论

一般质量矩阵、真实块Frechet导数及完整小o梯度线性化全部保留，未假设结论。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.force\_linearization：PASS。对任意有限维 n、常实方阵 M、实势 U、qstar，ContDiffAt ℝ 2 U qstar 保证梯度可微，heq 要求平衡梯度为0。相空间为位置×动量的两个相同维欧氏空间，matrixAction 是矩阵的真实线性作用。所列导数将任意(δq,δp)送到(M⁻¹δp,−D(gradient U)(qstar)δq)，完整保留两条线性化运动方程，后者的 D gradient 即 Hessian。第二结论为 gradient U(q)−D(gradient U)(qstar)(q−qstar)=o(‖q−qstar‖)，因此保留原文的平衡点梯度近似且没有把非线性系统和线性系统宣称为全局精确相同。M 不要求正定或可逆，是对取定线性系数 Matrix.inv M 的数学推广；原机械质量矩阵取正定可逆时正好回到正文。该推广与[EXTRA]已披露的一般常 M 一致，不会使这个导数/小o结论失真；不能据此反称奇异 M 是合法机械质量矩阵。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2063；MD.Ch01.force\_linearization。

## 1. MD-1.6.1-MinimumHessianLiteral · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> At the minimum of the potential energy, $`U''`$ is a positive definite symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem minimumhessianliteral :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v) := by
  sorry

/-- 修正版，对应原文 MD-1.6.1-MinimumHessianLiteral，改动：正定改为半正定；仍保留Hessian对称性及所有非零方向。 -/
theorem minimumhessianliteral_corrected :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 ≤ inner ℝ v (fderiv ℝ (gradient U) q v) := by
  sorry

theorem minimumhessianliteral_counterexample :
    IsLocalMin (fun x : ℝ => x^4) 0 ∧ deriv (deriv (fun x : ℝ => x^4)) 0 = 0 := by
  constructor
  · change ∀ᶠ x in 𝓝 (0 : ℝ), (0 : ℝ)^4 ≤ x^4
    exact Filter.Eventually.of_forall (fun x => by norm_num only [zero_pow]; positivity)
  · have hd : deriv (fun x : ℝ => x^4) = fun x => 4*x^3 := by
      funext x
      convert ((hasDerivAt_id x).pow 4).deriv using 1 <;> simp
    rw [hd]
    simpa using (((hasDerivAt_id (0 : ℝ)).pow 3).const_mul 4).deriv
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.minimumhessianliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |

[EXTRA] 

### 6. 审计结论

局部极小只能推出Hessian半正定，严格极小也不能保证非退化。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
MD.Ch01.minimumhessianliteral：字面忠实性 PASS，但原书数学疑误 NEEDS\_HUMAN。对任意 n、U:Position n→ℝ、q，以全局 ContDiff ℝ 2 U 和 IsLocalMin U q 为前提；合取结论确实完整包括 Hessian 的所有 u,v 对称性，以及对所有非零 v 的正定性，没有把正定偷换成半正定。该正定结论在原书资格下不成立，依任务不把忠实版或 sorry 本身判成实现 FAIL。MD.Ch01.minimumhessianliteral\_corrected：PASS。相同 C²、全空间局部极小前提下 Hessian 对称且二次型非负，是正确必要条件；仍逐一覆盖所有非零方向，零方向亦自动为0。MD.Ch01.minimumhessianliteral\_counterexample：PASS。U(x)=x⁴ 在0有局部极小且二阶导数为0，足以反驳正定；该函数实际甚至是严格全局极小，因而增加“严格极小”也救不了字面版。标量例经一维欧氏空间的标准识别对应 n=1。总判 NEEDS\_HUMAN；未因修正版含 sorry 否定其签名。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2090；MD.Ch01.minimumhessianliteral。

## 1. MD-1.6.1-ImaginarySpectrum · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> The eigenvalues of the matrix

$$
\boldsymbol A:=\begin{bmatrix}0&\boldsymbol M^{-1}\\-U''(\boldsymbol q^*)&0\end{bmatrix}
$$


> are therefore all purely imaginary ($`\pm i\Omega`$, $`\Omega^2\in\mathbb R^+`$).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem imaginary_spectrum :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    let A := fun z : PhaseSpace n => (M⁻¹.toEuclideanLin z.2, -K.toEuclideanLin z.1)
    ∀ (a b : ℝ) (x y : PhaseSpace n), (x ≠ 0 ∨ y ≠ 0) →
      A x = a • x - b • y → A y = b • x + a • y →
      a = 0 ∧ 0 < b^2 ∧ A x = -b • y ∧ A (-y) = -b • x := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.imaginary\_spectrum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol A:=\begin{bmatrix}0&\boldsymbol M^{-1}\cr -U''(\boldsymbol q^*)&0\end{bmatrix}`$ | MD.Ch01.imaginary\_spectrum，完整展开陈述见上一行及第4段 | 一致 |
| 全部特征值±iΩ与Ω²>0 | 任意非零实虚特征对推出a=0、0<b²及A x=-b•y、A(-y)=-b•x | 一致；全部三个结论保留 |
| 原文未显式量化的技术资格 | M和Hessian K正定；复谱实虚向量编码。 | [EXTRA] |

[EXTRA] M和Hessian K正定；复谱实虚向量编码。

### 6. 审计结论

补齐实部零、非零频率平方正及共轭实虚特征对给出的±ib配对；一般SPD M,K保留。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2120；MD.Ch01.imaginary\_spectrum。

## 1. MD-1.6.1-ComplexNormalMode · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> Associated to each eigenvalue pair we have a pair of complex conjugate eigenvectors $`\boldsymbol\xi,\overline{\boldsymbol\xi}`$ and also a pair of solutions which can be written in the complex form

$$
\boldsymbol z(t)=ae^{i\Omega t}\boldsymbol\xi+be^{-i\Omega t}\overline{\boldsymbol\xi},
$$


> ($`a,b`$ complex coefficients),

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem complexnormalmode :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (η : Fin n → ℂ) (Ω : ℝ),
    η ≠ 0 → (A.map (algebraMap ℝ ℂ)).mulVec η = (Complex.I * Ω) • η →
    (fun i => star (η i)) ≠ 0 ∧
    (A.map (algebraMap ℝ ℂ)).mulVec (fun i => star (η i)) =
      (-Complex.I * Ω) • (fun i => star (η i)) ∧
    ∀ a b : ℂ, ∀ t : ℝ,
      HasDerivAt (fun s : ℝ =>
        a • (Complex.exp (Complex.I*Ω*s) • η) +
          b • (Complex.exp (-Complex.I*Ω*s) • (fun i => star (η i))))
        ((A.map (algebraMap ℝ ℂ)).mulVec
          (a • (Complex.exp (Complex.I*Ω*t) • η) +
            b • (Complex.exp (-Complex.I*Ω*t) • (fun i => star (η i))))) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.complexnormalmode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol z(t)=ae^{i\Omega t}\boldsymbol\xi+be^{-i\Omega t}\overline{\boldsymbol\xi},`$ | MD.Ch01.complexnormalmode，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.complexnormalmode | 增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.complexnormalmode | 增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。 |

[EXTRA] [EXTRA] 19号：增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。

### 6. 审计结论

19号本地签名预审：增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.complexnormalmode：PASS。n∈ℕ，A 是实 n×n 矩阵，η∈ℂⁿ 非零，Ω∈ℝ；前提 A\_Cη=(iΩ)η，A\_C 是 A 的逐项实到复嵌入。结论先确认 conjugate η 非零，再确认 A\_C conjugate η=(−iΩ)conjugate η，实性正是此推论所需；最后对任意 a,b∈ℂ 和任意 t∈ℝ，给出 z(t)=a exp(iΩt)η+b exp(−iΩt)conjugate η 的真实导数为 A\_C z(t)。该表述完整覆盖共轭特征对及其复线性组合解，未以零向量充当特征向量，也未把 a,b 限制为实。Ω=0 时共轭解可退化/重合，签名没有多声称其线性独立，故仍正确。A 泛化为任何实矩阵而非限定机械块矩阵，是由同一特征方程导出解公式的有效推广。[EXTRA] 中非零及共轭特征方程均真实出现在声明里。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2132；MD.Ch01.complexnormalmode。

## 1. MD-1.6.1-RealNormalMode · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> or recast in real form as ($`\alpha,\beta`$ real coefficients):

$$
\boldsymbol z(t)=\alpha[\sin(\Omega t)\operatorname{Re}(\boldsymbol\xi)+\cos(\Omega t)\operatorname{Im}(\boldsymbol\xi)]+\beta[\cos(\Omega t)\operatorname{Re}(\boldsymbol\xi)-\sin(\Omega t)\operatorname{Im}(\boldsymbol\xi)].
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem realnormalmode :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (A : E →L[ℝ] E) (Ω α β : ℝ) (u v : E)
    (hu : A u = -Ω • v) (hv : A v = Ω • u) (t : ℝ),
    HasDerivAt (realNormalMode Ω α β u v)
      (A (realNormalMode Ω α β u v t)) t := by
  exact @MolecularDynamics.hasDerivAt_realNormalMode
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.realnormalmode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol z(t)=\alpha[\sin(\Omega t)\operatorname{Re}(\boldsymbol\xi)+\cos(\Omega t)\operatorname{Im}(\boldsymbol\xi)]+\beta[\cos(\Omega t)\operatorname{Re}(\boldsymbol\xi)-\sin(\Omega t)\operatorname{Im}(\boldsymbol\xi)].`$ | MD.Ch01.realnormalmode，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
MD.Ch01.realnormalmode：就所陈述的实解公式而言 PASS。对任意实赋范向量空间 E、A:E→L[ℝ]E、Ω,α,β∈ℝ、u,v∈E，只需 Au=−Ωv 和 Av=Ωu，即对所有实 t 得 z′(t)=Az(t)。展开 MolecularDynamics.realNormalMode，z 恰为 α(sin(Ωt)u+cos(Ωt)v)+β(cos(Ωt)u−sin(Ωt)v)，与原式相同；取 u=Re ξ、v=Im ξ 时 hu,hv 正是实矩阵 +iΩ 特征方程的实虚部。不需要额外的非零/独立条件来使这一解公式成立，泛化到赋范空间也合理。需要区分的是：前一条 a,b 为任意复数的 z 不一定为实，不能全部直接“改写”为此 α,β 为实的式子。当前声明没有给出系数约束或取实部的桥接，因此不能把它的 PASS 扩展为已证明原书无条件的复实全族等价。原文若意指真实物理解则正确，但省略了适用范围；依“原书疑误/歧义保留”要求，总判 NEEDS\_HUMAN，非把正确的 ODE 声明判成 FAIL。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2151；MD.Ch01.realnormalmode。

## 1. MD-1.7-PlanarTrimerModel · Example 1.8 (Planar Lennard-Jones Trimer) · 印刷p.38 / PDFp.61

### 2. 原文陈述

> One of the simplest illustrations of the chaotic nature of molecular systems is given by the Lennard-Jones model consisting of just three atoms with motion restricted to the plane. The energy is

$$
E=K+U=\frac{\|\dot{\boldsymbol q}_1\|^2}{2}+\frac{\|\dot{\boldsymbol q}_2\|^2}{2}+\frac{\|\dot{\boldsymbol q}_3\|^2}{2}+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_1-\boldsymbol q_2\|)+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_2-\boldsymbol q_3\|)+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_1-\boldsymbol q_3\|),
$$


> with the interatomic interaction given by $`\hat\varphi_{\mathrm{LJ}}(r)=4[r^{-12}-r^{-6}]`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def planarTrimerEnergy (q v : Fin 3 → Position 2) : ℝ :=
  (∑ i, ‖v i‖^2/2) + lennardJonesPotential 1 1 ‖q 0-q 1‖ +
    lennardJonesPotential 1 1 ‖q 1-q 2‖ + lennardJonesPotential 1 1 ‖q 0-q 2‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.planarTrimerEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`E=K+U=\frac{\Vert \dot{\boldsymbol q}_1\Vert ^2}{2}+\frac{\Vert \dot{\boldsymbol q}_2\Vert ^2}{2}+\frac{\Vert \dot{\boldsymbol q}_3\Vert ^2}{2}+\hat\varphi_{\mathrm{LJ}}(\Vert \boldsymbol q_1-\boldsymbol q_2\Vert )+\hat\varphi_{\mathrm{LJ}}(\Vert \boldsymbol q_2-\boldsymbol q_3\Vert )+\hat\varphi_{\mathrm{LJ}}(\Vert \boldsymbol q_1-\boldsymbol q_3\Vert ),`$ | MD.Ch01.planarTrimerEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
平面单位质量三粒子；Fin 3逐项动能及01、12、02三对势均一致。Position 2确为二维欧氏空间；ε=σ=1给出4(r⁻¹²−r⁻⁶)。碰撞点的Lean总函数值仅为延拓，不能解释为物理势。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2167；MD.Ch01.planarTrimerEnergy。

## 1. MD-1.7-CentralPairPotential · definition · 印刷p.38 / PDFp.61

### 2. 原文陈述

> In general, when the total potential is a sum of distance potentials

$$
U=\frac12\sum_{i\ne j}U_{ij},
$$


> where $`U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=\varphi_{ij}(\|\boldsymbol q_i-\boldsymbol q_j\|)`$, we say that the system has central forces.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def centralPairEnergy {N : ℕ} (φ : Fin N → Fin N → ℝ → ℝ) (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.univ.erase i, φ i j (pairDistance (q i) (q j)))/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centralPairEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U=\frac12\sum_{i\ne j}U_{ij},`$ | MD.Ch01.centralPairEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
Fin N、三维位置和任意径向φ；erase i恰排除自相互作用，有序双和除以2与原式一致。该定义本身无需可微性或φ对称性；若要把φ解释为同一无序对的势，需采用context\_notation的对称约定。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2175；MD.Ch01.centralPairEnergy。

## 1. MD-1.7-CentralPairGradient · unnumbered_claim · 印刷p.38 / PDFp.61

### 2. 原文陈述

> In this case,

$$
\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem centralpairgradient :
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x => φ ‖x-r‖) q = -gradient (fun y => φ ‖q-y‖) r := by
  intro φ q r hqr hφ
  have hn : ‖q-r‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr hqr)
  have h₁ := (((hasFDerivAt_id q).sub_const r).norm_sq).sqrt (pow_ne_zero 2 hn)
  have h₂ := (((hasFDerivAt_const q r).sub (hasFDerivAt_id r)).norm_sq).sqrt (pow_ne_zero 2 hn)
  simp only [Real.sqrt_sq_eq_abs, abs_norm] at h₁ h₂
  have g₁ := hφ.hasDerivAt.comp_hasFDerivAt q h₁
  have g₂ := hφ.hasDerivAt.comp_hasFDerivAt r h₂
  apply ext_inner_right ℝ
  intro v
  simp only [Function.comp_def, id_eq, Pi.sub_apply] at g₁ g₂
  rw [inner_gradient_left, inner_neg_left, inner_gradient_left, g₁.fderiv, g₂.fderiv]
  simp [ContinuousLinearMap.comp_apply, innerSL_apply_apply, inner_neg_right]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centralpairgradient；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),`$ | MD.Ch01.centralpairgradient，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 势在非碰撞距离可微；partial为欧氏梯度。 | [EXTRA] |

[EXTRA] 势在非碰撞距离可微；partial为欧氏梯度。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
全称φ、q、r；q≠r及φ在距离处可微是合法微分资格。两侧均为同一二体势分别对两个位置的欧氏梯度，负号、取值点和结论完整。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2182；MD.Ch01.centralpairgradient。

## 1. MD-1.7-CentralMomentum · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> and so, for central forces,

$$
\sum_{i=1}^N m_i\ddot{\boldsymbol q}_i=0,
$$


> which expresses the constancy of the momentum.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem central_momentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, (∑ i, ∑ j, F t i j) = 0) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i • v a i) = ∑ i, m i • v b i := by
  exact @momentum_conservation
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.central\_momentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\sum_{i=1}^N m_i\ddot{\boldsymbol q}_i=0,`$ | MD.Ch01.central\_momentum，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。 | [EXTRA] |

[EXTRA] 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。

### 6. 审计结论

审查后去掉旧桥接中净力零前提，由真实逐对作用反对称推出净力零和全向量/每坐标动量守恒，保留全部结论。

网站：网站PASS（EAUDIT复审）。
任意N、质量、速度、逐对力和开放预连通时间域；逐对力反对称与每个动量的真实导数推出净力为零、总动量真实零导数及任意两时刻相等。结论没有被用作假设。以p=mv编码Newton动量，未另设q不影响这一动量层面的陈述。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2203；MD.Ch01.central\_momentum。

## 1. MD-1.7-CentralAngularMomentum · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> Moreover, viewing the $`\boldsymbol q_i`$ as vectors in $`\mathbb R^3`$ (with 0 as their third component),

$$
\boldsymbol q_i\times\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\boldsymbol q_j\times\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),
$$


> which implies

$$
\frac{\mathrm d}{\mathrm dt}\sum_{i=1}^N\boldsymbol q_i\times(m_i\dot{\boldsymbol q}_i)=0,
$$


> and tells us that the total angular momentum is also conserved.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem centralangularmomentum_derivative :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    ∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t := by
  intro N m q v F I _ hq hp hanti hcenter
  have hsub (u v w : V3) : cross3 (u-v) w = cross3 u w-cross3 v w := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have hneg (u w : V3) : cross3 u (-w) = -cross3 u w := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have ht (t : ℝ) (h : t ∈ I) (i j : Fin N) :
      cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i) := by
    have hc := hcenter t h i j
    rw [hsub] at hc
    rw [hanti t h j i,hneg,neg_neg]
    exact sub_eq_zero.mp hc
  have hcross (u w : ℝ → V3) (du dw : V3) (t : ℝ)
      (hu : HasDerivAt u du t) (hw : HasDerivAt w dw t) :
      HasDerivAt (fun s => cross3 (u s) (w s)) (cross3 du (w t)+cross3 (u t) dw) t := by
    have huc (k : Fin 3) : HasDerivAt (fun s => u s k) (du k) t :=
      (PiLp.proj (p := 2) (β := fun _ : Fin 3 => ℝ) k).hasFDerivAt.comp_hasDerivAt t hu
    have hwc (k : Fin 3) : HasDerivAt (fun s => w s k) (dw k) t :=
      (PiLp.proj (p := 2) (β := fun _ : Fin 3 => ℝ) k).hasFDerivAt.comp_hasDerivAt t hw
    have hc (k : Fin 3) : HasDerivAt (fun s => cross3 (u s) (w s) k)
        ((cross3 du (w t)+cross3 (u t) dw) k) t := by
      fin_cases k
      · convert! ((huc 1).mul (hwc 2)).sub ((huc 2).mul (hwc 1)) using 1 <;> simp [cross3] <;> ring
      · convert! ((huc 2).mul (hwc 0)).sub ((huc 0).mul (hwc 2)) using 1 <;> simp [cross3] <;> ring
      · convert! ((huc 0).mul (hwc 1)).sub ((huc 1).mul (hwc 0)) using 1 <;> simp [cross3] <;> ring
    let b : Fin 3 → V3 := fun k => WithLp.toLp 2 (Pi.single k 1)
    have hre (z : V3) : (∑ k, z k • b k) = z := by
      ext k; fin_cases k <;> simp [b,Fin.sum_univ_three]
    have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun k _ => (hc k).smul_const (b k))
    simpa only [hre] using hh
  have hself (a : ℝ) (u : V3) : cross3 u (a • u) = 0 := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have hsum (u : V3) (f : Fin N → V3) : cross3 u (∑ j,f j) = ∑ j,cross3 u (f j) := by
    ext k; fin_cases k <;> simp [cross3,Finset.mul_sum,Finset.sum_sub_distrib]
  refine ⟨ht,?_⟩
  intro t h
  have hz : (∑ i, ∑ j,cross3 (q t i) (F t i j)) = 0 := by
    apply paircancellation N (fun i j => cross3 (q t i) (F t i j))
    · intro i
      ext k
      have he := congrArg (fun u : V3 => u k) (ht t h i i)
      simp only [PiLp.neg_apply] at he
      change (cross3 (q t i) (F t i i)) k = 0
      linarith
    · exact ht t h
  have hd (i : Fin N) : HasDerivAt (fun s => cross3 (q s i) (m i • v s i))
      (∑ j,cross3 (q t i) (F t i j)) t := by
    simpa only [hself,zero_add,hsum] using hcross (fun s => q s i) (fun s => m i • v s i)
      (v t i) (∑ j,F t i j) t (hq t h i) (hp t h i)
  have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => hd i)
  rwa [hz] at hh

theorem centralangularmomentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, cross3 (q a i) (m i • v a i)) =
      ∑ i, cross3 (q b i) (m i • v b i) := by
  intro N m q v F I hI hc hq hp ha hf
  obtain ⟨ht,hd⟩ := centralangularmomentum_derivative N m q v F I hI hq hp ha hf
  refine ⟨ht,hd,?_⟩
  intro a ha b hb
  exact hI.is_const_of_deriv_eq_zero hc
    (fun t ht => (hd t ht).differentiableAt.differentiableWithinAt)
    (fun t ht => (hd t ht).deriv) ha hb
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centralangularmomentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol q_i\times\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\boldsymbol q_j\times\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),`$；$`\frac{\mathrm d}{\mathrm dt}\sum_{i=1}^N\boldsymbol q_i\times(m_i\dot{\boldsymbol q}_i)=0,`$ | MD.Ch01.centralangularmomentum，完整展开陈述见上一行及第4段 | 一致 |
| 逐对力矩相消 | ∀t i j,cross3(qᵢ,Fᵢⱼ)=-cross3(qⱼ,Fⱼᵢ) | 一致 |
| 角动量守恒 | HasDerivAt (∑i,cross3(qᵢ,mᵢ•vᵢ)) 0 | 一致 |
| 原文未显式量化的技术资格 | 真实位置和动量导数；反对称内力和沿位移方向中心力。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.centralangularmomentum\_derivative; MD.Ch01.centralangularmomentum | 保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.centralangularmomentum\_derivative; MD.Ch01.centralangularmomentum | 保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。 |

[EXTRA] 真实位置和动量导数；反对称内力和沿位移方向中心力。；[EXTRA] 19号：保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。

### 6. 审计结论

19号本地签名预审：保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。

网站：网站PASS（EAUDIT复审）。
已核对derivative和主定理两声明：位置导数为v，动量导数为逐对力和，力反对称且位移叉力为零；cross3三个分量是标准叉积。逐对力矩抵消、角动量真实零导数及任意a,b∈I守恒俱全。[EXTRA]19号要求已落实为主定理的IsPreconnected I与两时刻相等；derivative辅助版不要求连通是合理的。三维结果包含原文平面嵌入。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2277；MD.Ch01.centralangularmomentum。

## 1. MD-1.7-CenterOfMassMotion · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> This means that the system will translate and rotate at a constant rate in time.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem centerofmassmotion :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (I : Set ℝ) (a : ℝ), IsOpen I → IsPreconnected I → a ∈ I →
    (∀ i, 0 < m i) → 0 < ∑ i, m i →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) →
    ∀ t ∈ I,
      (∑ i, m i)⁻¹ • (∑ i, m i • q t i) =
        (∑ i, m i)⁻¹ • (∑ i, m i • q a i) +
          (t-a) • ((∑ i, m i)⁻¹ • (∑ i, m i • v a i)) := by
  intro N m q v I a ho hi ha hm hM hq hp
  let P := ∑ i, m i • v a i
  have hPc (t : ℝ) (ht : t ∈ I) : (∑ i, m i • v t i) = P :=
    ho.is_const_of_deriv_eq_zero hi
      (fun s hs => (hp s hs).differentiableAt.differentiableWithinAt)
      (fun s hs => (hp s hs).deriv) ht ha
  have hQ (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => ∑ i, m i • q s i) P t := by
    have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => (hq t ht i).const_smul (m i))
    rwa [hPc t ht] at hh
  have hR (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => (∑ i, m i • q s i)-s • P) 0 t := by
    simpa only [one_smul, sub_self, id_eq] using (hQ t ht).fun_sub ((hasDerivAt_id t).smul_const P)
  intro t ht
  have hc := ho.is_const_of_deriv_eq_zero hi
    (fun s hs => (hR s hs).differentiableAt.differentiableWithinAt)
    (fun s hs => (hR s hs).deriv) ht ha
  have he : (∑ i, m i • q t i) = (∑ i, m i • q a i)+(t-a) • P := by
    calc
      _ = ((∑ i, m i • q a i)-a • P)+t • P := (sub_eq_iff_eq_add).mp hc
      _ = _ := by simp [sub_smul, sub_eq_add_neg, add_smul, neg_smul, add_assoc, add_comm, add_left_comm]
  have hh := congrArg (fun u => (∑ i,m i)⁻¹ • u) he
  simpa [P, smul_add, smul_smul, mul_comm] using hh
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centerofmassmotion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。 | [EXTRA] |

[EXTRA] 质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
范围按context\_notation只审translation。质量正且总质量正、a∈开放预连通I、q′=v、总动量真实零导数，推出每个t∈I质心为初始质心加(t−a)乘初始质心速度，分母和各求和均正确。旋转断言另交第7条；这里不能将整句的旋转部分视为已证明。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2300；MD.Ch01.centerofmassmotion。

## 1. MD-1.7-ConstantRotationLiteral · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> This means that the system will translate and rotate at a constant rate in time.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem constantrotationliteral :
  ∀ (r θ : ℝ → ℝ) (ℓ : ℝ),
    (∀ t, 0 < r t ∧ (r t)^2*deriv θ t = ℓ) →
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  sorry

/-- 修正版，对应原文 MD-1.7-ConstantRotationLiteral，改动：a增加恒定正半径才推恒角速；默认b保留角动量守恒并明确θ′=ℓ/r²。 -/
theorem constantrotationliteral_corrected_a (R ℓ : ℝ) (θ : ℝ → ℝ)
    (hR : 0 < R) (h : ∀ t, R^2 * deriv θ t = ℓ) :
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  refine ⟨ℓ/R^2,fun t => ?_⟩
  apply (eq_div_iff (pow_ne_zero 2 hR.ne')).mpr
  simpa [mul_comm] using h t

/-- 修正版，对应原文 MD-1.7-ConstantRotationLiteral，改动：角速度随半径变化。 -/
theorem constantrotationliteral_corrected_b (r θ : ℝ → ℝ) (ℓ : ℝ)
    (h : ∀ t, 0 < r t ∧ (r t)^2 * deriv θ t = ℓ) :
    ∀ t, deriv θ t = ℓ/(r t)^2 := by
  intro t
  apply (eq_div_iff (pow_ne_zero 2 (h t).1.ne')).mpr
  simpa [mul_comm] using (h t).2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.constantrotationliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |

[EXTRA] 

### 6. 审计结论

守恒的是角动量，转动惯量或半径可变时角速度可变。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal完整编码“r²θ′=ℓ且r>0推出恒角速”，忠实于原书旋转断言，但数学上不成立。corrected\_a增加固定正半径后结论正确；corrected\_b只作除以正r²的代数推导，正确且更贴近应保留的守恒律。两修正版均未假设所求恒角速。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2336；MD.Ch01.constantrotationliteral。

## 1. MD-1.7-IsoscelesCoordinates · definition · 印刷p.39 / PDFp.62

### 2. 原文陈述

> Let us introduce new coordinates in the Lennard-Jones trimer as illustrated in Fig. 1.21, so that the center of mass is fixed at the origin: that is,

$$
\boldsymbol q_1=\begin{bmatrix}x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_2=\begin{bmatrix}-x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_3=\begin{bmatrix}0\\2y/3\\0\end{bmatrix},
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

/-- 修正版，对应原文 MD-1.7-IsoscelesCoordinates，改动：把三坐标公式作为主动选取的对称子模型，证明其质心为零；不把零总动量/角动量推出等腰。 -/
def isoscelesCoordinates_corrected (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

theorem isoscelesCoordinates_corrected_center (x y : ℝ) :
    (∑ i : Fin 3, isoscelesCoordinates_corrected x y i) = 0 := by
  ext k
  fin_cases k <;> simp [isoscelesCoordinates_corrected,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.isoscelesCoordinates；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol q_1=\begin{bmatrix}x\cr -y/3\cr 0\end{bmatrix},\qquad\boldsymbol q_2=\begin{bmatrix}-x\cr -y/3\cr 0\end{bmatrix},\qquad\boldsymbol q_3=\begin{bmatrix}0\cr 2y/3\cr 0\end{bmatrix},`$ | MD.Ch01.isoscelesCoordinates，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

零平动、零角动量不强迫任意三角形等腰；必须额外选择对称初态及证明对称性保持。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
三个向量分量、Fin 3次序及三维平面嵌入完全吻合。corrected定义数值上与原定义相同；corrected\_center的三坐标和为零，单位质量下即质心零。修正的是适用范围而非坐标公式。原段由动量约束导出等腰的暗示不成立，必须由人工保留勘误说明。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2362；MD.Ch01.isoscelesCoordinates。

## 1. MD-1.7-IsoscelesEnergyReduction · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> reducing the energy to

$$
E=\dot x^2+\frac{\dot y^2}{3}+2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x),
$$


> which describes the vibrational motion.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem isosceles_energy_reduction (x y v w : ℝ) (hx : 0 < x) :
    (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) +
      uniformLJEnergy 1 1 (isoscelesCoordinates x y) = isoscelesEnergy x y v w := by
  have h01 : isoscelesCoordinates x y 0-isoscelesCoordinates x y 1 =
      WithLp.toLp 2 ![2*x,0,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have h02 : isoscelesCoordinates x y 0-isoscelesCoordinates x y 2 =
      WithLp.toLp 2 ![x,-y,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have h12 : isoscelesCoordinates x y 1-isoscelesCoordinates x y 2 =
      WithLp.toLp 2 ![-x,-y,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have hsq (z : V3) : ‖z‖^2 = (z 0)^2+(z 1)^2+(z 2)^2 := by
    simpa only [Fin.sum_univ_three,Real.norm_eq_abs,sq_abs] using
      PiLp.norm_sq_eq_of_L2 (fun _ : Fin 3 => ℝ) z
  have hn (a b : ℝ) : ‖(WithLp.toLp 2 ![a,b,0] : V3)‖ = Real.sqrt (a^2+b^2) := by
    rw [norm_eq_sqrt_real_inner,real_inner_self_eq_norm_sq,hsq]
    simp
  have hK : (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) = v^2+w^2/3 := by
    simp only [Fin.sum_univ_three,hsq]
    simp [isoscelesCoordinates]
    ring
  have h0 : Finset.Ioi (0:Fin 3) = {1,2} := by decide
  have h1 : Finset.Ioi (1:Fin 3) = {2} := by decide
  have h2 : Finset.Ioi (2:Fin 3) = ∅ := by decide
  rw [hK]
  unfold uniformLJEnergy
  simp only [Fin.sum_univ_three,h0,h1,h2,Finset.sum_singleton,Finset.sum_empty]
  rw [Finset.sum_pair (show (1:Fin 3) ≠ 2 by decide)]
  simp [pairDistance,h01,h02,h12,hn,Real.sqrt_sq_eq_abs,abs_of_pos hx,abs_mul,
    isoscelesEnergy,isoscelesPotential]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.isosceles\_energy\_reduction；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`E=\dot x^2+\frac{\dot y^2}{3}+2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x),`$ | MD.Ch01.isosceles\_energy\_reduction，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。 | [EXTRA] |

[EXTRA] 单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
x>0使01距离为2x，另两距离为√(x²+y²)；速度坐标取(v,w)后动能为v²+w²/3。uniformLJEnergy用Ioi每对只计一次，等式不是前提。定义的总函数延拓在本x>0域不触及碰撞。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2378；MD.Ch01.isosceles\_energy\_reduction。

## 1. MD-1.7-IsoscelesAccessibleRegion · unnumbered_claim · 印刷p.40 / PDFp.63

### 2. 原文陈述

> kinetic energy is non-negative, we must have

$$
2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x)\le E.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem isoscelesaccessibleregion :
  ∀ x y v w E : ℝ, isoscelesEnergy x y v w = E → isoscelesPotential x y ≤ E := by
  exact MolecularDynamics.Chapter01Review.isoscelesEnergyBound_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.isoscelesaccessibleregion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x)\le E.`$ | MD.Ch01.isoscelesaccessibleregion，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
全称x,y,v,w,E，仅假设能量等于E；由v²+w²/3≥0推出isoscelesPotential≤E。势的两倍斜边项与底边项完整，无需额外动态或正性前提。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2415；MD.Ch01.isoscelesaccessibleregion。

## 1. MD-1.7-EquilateralTrimerMinimum · Example 1.8 (Planar Lennard-Jones Trimer) · 印刷p.38 / PDFp.61

### 2. 原文陈述

> The global minimum of this simple system must be radially symmetric. Placing the atoms at the vertices of an equilateral triangle, we have

$$
U=3\hat\varphi_{\mathrm{LJ}}(r),
$$


> where $`r`$ is the length of a side. This is minimized when $`r=2^{1/6}\approx1.1225`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem equilateraltrimerminimum :
  ∀ q : Fin 3 → V3, (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ uniformLJEnergy 1 1 q ∧
    (uniformLJEnergy 1 1 q = -3 ↔
      ∀ i j, i ≠ j → pairDistance (q i) (q j) = Real.rpow 2 (1/6)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.equilateraltrimerminimum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U=3\hat\varphi_{\mathrm{LJ}}(r),`$ | MD.Ch01.equilateraltrimerminimum，完整展开陈述见上一行及第4段 | 一致 |
| 全局极小值-3 | -3≤uniformLJEnergy 1 1 q | 一致 |
| 达到极小当且仅当三边等于2^(1/6) | 能量=-3 ↔ ∀i≠j,pairDistance…=Real.rpow 2 (1/6) | 一致 |
| 原文未显式量化的技术资格 | 单位LJ；非碰撞配置。 | [EXTRA] |

[EXTRA] 单位LJ；非碰撞配置。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（EAUDIT复审）。
对任意三维非碰撞三点，势≥−3且等号当且仅当全部非同标距离为2^(1/6)。这是原文全局最低势与等边构型的正确精确化；三维三个点仍共面。每对φ+1=(2/r⁶−1)²≥0，等号恰在r⁶=2；未把约1.1225当精确值，未因sorry扣分。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2423；MD.Ch01.equilateraltrimerminimum。

## 1. MD-1.7-TrimerEnergyLowerBound · unnumbered_claim · 印刷p.40 / PDFp.63

### 2. 原文陈述

> (When $`E\gt 0`$, the bodies eventually escape to infinity; $`E\lt -3`$ is not attainable.)

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem trimerenergylowerbound :
  ∀ (q v : Fin 3 → V3), (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ (∑ i, ‖v i‖^2/2) + uniformLJEnergy 1 1 q := by
  exact MolecularDynamics.Chapter01Review.trimerLowerBound_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.trimerenergylowerbound；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
任意非碰撞三粒子配置和任意速度，结论是动能加三对势≥−3；动能非负及每对势≥−1给出。与原文E<−3不可达一致；E>0部分按范围交第14条处理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2434；MD.Ch01.trimerenergylowerbound。

## 1. MD-1.7-CollinearTrimer · definition · 印刷p.40 / PDFp.63

### 2. 原文陈述

> Arranging the three atoms in a collinear configuration ($`y=0`$) the potential energy becomes $`\hat U=\hat U(x)=2\hat\varphi_{\mathrm{LJ}}(x)+\hat\varphi_{\mathrm{LJ}}(2x)`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def collinearTrimer (x : ℝ) :=
  2*lennardJonesPotential 1 1 x + lennardJonesPotential 1 1 (2*x)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.collinearTrimer；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2443；MD.Ch01.collinearTrimer。

## 1. MD-1.7-TrimerSaddle · unnumbered_claim · 印刷p.40–41 / PDFp.63–64

### 2. 原文陈述

> Minimizing the potential in the collinear configuration allows us to determine the saddle point $`(x^*,0)`$. Near this point, $`U`$ decreases if we move in the $`\pm y`$ direction and increases if we move in the $`\pm x`$ direction.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem trimersaddle :
  ∃ x > 0, (∀ y > 0, collinearTrimer x ≤ collinearTrimer y) ∧
    ∃ δ > 0, (∀ u : ℝ, 0 < |u-x| → |u-x| < δ →
      isoscelesPotential x 0 < isoscelesPotential u 0) ∧
    ∀ y : ℝ, 0 < |y| → |y| < δ → isoscelesPotential x y < isoscelesPotential x 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.trimersaddle；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。 | [EXTRA] |

[EXTRA] x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（EAUDIT复审）。
存在正x为全部正共线参数的全局极小，且存在同一个正δ，横向任何足够小非零位移严格增势、纵向任何足够小非零位移严格减势，量词及严格性符合原文。δ可缩至小于x排除u=0。令A=2+2⁻¹²，B=2+2⁻⁶，则共线势=4(Ax⁻¹²−Bx⁻⁶)，唯一极小满足x⁶=2A/B<2；故φ′(x)<0，纵向二阶项φ′(x)y²/x为负，横向二阶项为正。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2450；MD.Ch01.trimersaddle。

## 1. MD-1.7-TrimerEscapeLiteral · unnumbered_claim · 印刷p.40 / PDFp.63

### 2. 原文陈述

> (When $`E\gt 0`$, the bodies eventually escape to infinity; $`E\lt -3`$ is not attainable.)

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem trimerescapeliteral :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∀ i : Fin 3, Tendsto (fun t => ‖q t i‖) atTop atTop := by
  sorry

/-- 修正版，对应原文 MD-1.7-TrimerEscapeLiteral，改动：把every body逐粒子逃逸改为至少一对粒子分离的候选陈述；全部动力学、正能量、零质心/角动量资格保留。 -/
theorem trimerescapeliteral_corrected :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∃ i j : Fin 3, i ≠ j ∧ Tendsto (fun t => dist (q t i) (q t j)) atTop atTop := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.trimerescapeliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |

[EXTRA] 

### 6. 审计结论

总能量正并不直接推出每个粒子相对固定原点趋于无穷；系统分离与逐粒子逃逸不同。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=NEEDS\_HUMAN（待独立散射论证）。
literal保留逐粒子范数趋∞的字面解释；签名具真实Newton导数、单位LJ力、全时非碰撞、正能量、零质心/动量/角动量及等腰约束，无循环前提，但逐粒子结论过强。corrected保留全部资格并改为存在固定一对距离趋∞，改动方向合理；此候选的强极限结论尚需独立散射论证，不能由能量非负或现有反例直接认证。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2461；MD.Ch01.trimerescapeliteral。

## 1. MD-1.7.1-ChaosConditions · definition · 印刷p.41–42 / PDFp.64–65

### 2. 原文陈述

> Typical definitions of a “chaotic dynamical system” [103] require at least the following conditions to be satisfied on the phase space $`D`$:
> • The solutions depend sensitively on the initial data taken from $`D`$;
> • The flow is topologically transitive in $`D`$.
> The second condition states that given arbitrarily small neighborhoods $`D_1`$ and $`D_2`$ of two different points in $`D`$ then it is possible to find a trajectory that goes from some point of $`D_1`$ to some point of $`D_2`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def chaosConditions {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  sensitiveDependence F D ∧ topologicalTransitivity F D
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.chaosConditions；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。 | [EXTRA] |
| 原文未显式量化的技术资格 | topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。 | [EXTRA] |

[EXTRA] 敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。；topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。

### 6. 审计结论

两必要性质及transitivity邻域关系保留；敏感依赖正文随后“given pair rapidly grows”不是标准存在扰动量词，需导师确认数学化选择。

网站：网站PASS（EAUDIT复审）。
chaosConditions准确为敏感依赖和拓扑传递的合取。敏感依赖依次量化∃ε>0、∀x∈D、∀δ>0、∃y∈D、∃t≥0，近邻及分离不等号正确；ε>0已自动排除y=x。传递用环境开集与D交等价于相对开集形式，起终点都在D。作为两个条件的谓词可用于任意F,D；解释为混沌真实系统时还须外部限定F为流、D不变。原文说at least，不能把本谓词称为混沌的充分必要定义；已有注释明确这只是选定的严格化。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2491；MD.Ch01.chaosConditions。

## 1. MD-1.7.1-TransitivityErgodicityLiteral · unnumbered_claim · 印刷p.42 / PDFp.65

### 2. 原文陈述

> We will see later that this concept, which is essentially equivalent to ergodicity, is a crucial component of molecular theories.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem transitivityergodicityliteral :
  ∀ (n : ℕ) (f : Position n → Position n)
    (F : ℝ → Position n → Position n) (μ : Measure (Position n)),
    isFlowOf f F → Continuous (Function.uncurry F) →
    (∀ t, MeasurePreserving (F t) μ μ) →
    (topologicalTransitivity F univ ↔ flowErgodic F μ) := by
  sorry

/-- 修正版，对应原文 MD-1.7.1-TransitivityErgodicityLiteral，改动：改为有限、满支撑不变测度下的遍历性⇒拓扑传递单向结论。 -/
theorem transitivityergodicityliteral_corrected {n : ℕ}
    (f : Position n → Position n) (F : ℝ → Position n → Position n)
    (μ : Measure (Position n)) [IsFiniteMeasure μ]
    (hf : ContDiff ℝ 1 f) (hflow : isFlowOf f F) (hcont : Continuous (Function.uncurry F))
    (hfull : ∀ U : Set (Position n), IsOpen U → U.Nonempty → μ U ≠ 0)
    (he : flowErgodic F μ) : topologicalTransitivity F univ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.transitivityergodicityliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。 | [EXTRA] |

[EXTRA] 为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。

### 6. 审计结论

拓扑传递依赖拓扑，遍历性依赖选定不变测度；一般不能直接等价。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal在连续真实流和不变测度下断言拓扑传递↔测度遍历，忠实表达原句但普遍错误。corrected限制有限满支撑测度，仅断言遍历⇒拓扑传递，方向与条件正确；flowErgodic已含全部时间的测度保持。hf:C¹确保ODE唯一性，由isFlowOf得到群性质，故不缺流合成资格；连续性使开集时间饱和为开可测，有限测度复现可保证正向时间的传递。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2498；MD.Ch01.transitivityergodicityliteral。

## 1. MD-1.7.1-AnisotropicOscillator · Example 1.9 (Anisotropic Oscillator) · 印刷p.42 / PDFp.65

### 2. 原文陈述

> Consider the system with energy

$$
E(x,y,\dot x,\dot y)=\frac12(\dot x^2+\dot y^2)+\frac{\kappa(c_3)}2(r-l(c_3))^2,\qquad r=\sqrt{x^2+y^2},\tag{1.9}
$$


> where

$$
c_3=\cos(3\theta)
$$


> is defined in terms of the angular coordinate of the position $`(x,y)`$ with respect to the $`(1,0)`$-direction,

$$
\cos\theta=c=\frac xr,\qquad c_3=4c^3-3c,
$$


> and we have defined

$$
\kappa(c_3)=\kappa_0(1-\tfrac12\epsilon c_3),\qquad l(c_3)=l_0(1+\tfrac12\epsilon c_3).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.anisotropicEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`E(x,y,\dot x,\dot y)=\frac12(\dot x^2+\dot y^2)+\frac{\kappa(c_3)}2(r-l(c_3))^2,\qquad r=\sqrt{x^2+y^2},\quad\text{(1.9)}`$；$`c_3=\cos(3\theta)`$；$`\cos\theta=c=\frac xr,\qquad c_3=4c^3-3c,`$；$`\kappa(c_3)=\kappa_0(1-\tfrac12\epsilon c_3),\qquad l(c_3)=l_0(1+\tfrac12\epsilon c_3).`$ | MD.Ch01.anisotropicEnergy，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 定义在r=0用Lean总函数延拓，物理域r>0。 | [EXTRA] |

[EXTRA] 定义在r=0用Lean总函数延拓，物理域r>0。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PDF字形确认κ及κ₀。anisotropicAngular以x/√(x²+y²)代入4c³−3c，与cos3θ一致；参数分别κ₀(1−εc₃/2)、l₀(1+εc₃/2)，势的κ/2及平方和动能全部正确。r>0物理域与r=0总函数延拓已注明，未把数值实验参数或轨迹观察误作全称定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2519；MD.Ch01.anisotropicEnergy。

## 1. MD-1.7.2-FlowJacobianLiteral · definition · 印刷p.44 / PDFp.67

### 2. 原文陈述

> Let a dynamical system $`\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z)`$ be given in $`\mathbb R^m`$ with flow map $`F_t:\mathbb R^m\to\mathbb R^m`$ which we assume to be continuously differentiable. Let $`\boldsymbol z(t,\boldsymbol\xi)`$ represent the solution of initial value problem

$$
\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi.
$$


> We then compute the $`m\times m`$ Jacobian matrix of $`F_t(\boldsymbol z(t,\boldsymbol\xi))`$:

$$
\boldsymbol W(t)=F_t'(\boldsymbol z(t,\boldsymbol\xi))=\frac{\partial F_t}{\partial\boldsymbol z}(\boldsymbol z(t,\boldsymbol\xi)).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)

/-- 修正版，对应原文 MD-1.7.2-FlowJacobianLiteral，改动：DF_t取值点从F_t(ξ)改为初值ξ。 -/
def variationalMatrixLiteral_corrected {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) ξ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.variationalMatrixLiteral；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi.`$；$`\boldsymbol W(t)=F_t'(\boldsymbol z(t,\boldsymbol\xi))=\frac{\partial F_t}{\partial\boldsymbol z}(\boldsymbol z(t,\boldsymbol\xi)).`$ | MD.Ch01.variationalMatrixLiteral，完整展开陈述见上一行及第4段 | 一致 |
| W的取值点为z(t,ξ)=Ftξ | fderiv ℝ (F t) (F t ξ) | [ERRATUM?] 字面保留，未换为ξ |

[EXTRA] 

### 6. 审计结论

对初值求导的Jacobian应在初值取值；把演化后位置再次代入是复合了不同取值点。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal确为fderiv(F t)在F t ξ处的取值，忠实保留PDF的z(t,ξ)取值点；导数作为连续线性算子与欧氏Jacobian矩阵等价。corrected改为在ξ处取值是标准初值变分矩阵。两者为定义，可对任意F作总函数定义；真实流和C¹资格用于后续理论。作为原文变分理论基础有取值点疑误，保留人工裁定。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2527；MD.Ch01.variationalMatrixLiteral。

## 1. MD-1.7.2-VariationalEquationLiteral · unnumbered_claim · 印刷p.44–45 / PDFp.67–68

### 2. 原文陈述

> Differentiating $`\boldsymbol W(t)`$ with respect to $`t`$ and using the differential equation and the chain rule, we have

$$
\frac{\mathrm d}{\mathrm dt}\boldsymbol W(t)=\boldsymbol f'(\boldsymbol z(t,\boldsymbol\xi))\boldsymbol W(t).\tag{1.10}
$$


> The system of Eq. (1.10) is referred to as the system of variational equations corresponding to the dynamical system $`\mathrm d\boldsymbol z/\mathrm dt=\boldsymbol f(\boldsymbol z)`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem variationalequationliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral F ξ t)) t := by
  sorry

/-- 修正版，对应原文 MD-1.7.2-VariationalEquationLiteral，改动：采用W(t)=DF_t(ξ)，保留C¹向量场及真实流资格。 -/
theorem variationalequationliteral_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral_corrected F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral_corrected F ξ t)) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.variationalequationliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`\frac{\mathrm d}{\mathrm dt}\boldsymbol W(t)=\boldsymbol f'(\boldsymbol z(t,\boldsymbol\xi))\boldsymbol W(t).\quad\text{(1.10)}`$ | MD.Ch01.variationalequationliteral，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |

[EXTRA] 

### 6. 审计结论

原W的取值点多复合一次F\_t，时间微分产生额外链式项，不满足标准变分方程。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal完整保留C¹向量场、每个F\_t为C¹、真实流初值和时间ODE，以及全部ξ,t上的算子导数；右端复合顺序Df(F\_tξ)∘W正确，但原文字面W使方程失效。corrected使用DF\_t(ξ)后为正确标准变分方程。C¹向量场和全局真实解以唯一性及局部参数依赖给出所需时间可微性，无需额外假设F联合C²；sorry不构成签名失败。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2538；MD.Ch01.variationalequationliteral。

## 1. MD-1.7.2-NearbyTrajectoryLiteral · unnumbered_claim · 印刷p.45 / PDFp.68

### 2. 原文陈述

> If we have two solutions started from nearby initial conditions $`\boldsymbol\xi,\hat{\boldsymbol\xi}`$, then their difference is approximated by the solution of the variational equations

$$
\boldsymbol z(t,\hat{\boldsymbol\xi})-\boldsymbol z(t,\boldsymbol\xi)\approx\boldsymbol W(t)(\hat{\boldsymbol\xi}-\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem nearby_trajectory_literal :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  sorry

/-- 修正版，对应原文 MD-1.7.2-NearbyTrajectoryLiteral，改动：线性化在初值ξ处取DF_t，固定t的余项为o(扰动)。 -/
theorem nearby_trajectory_literal_corrected :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral_corrected F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  intro n F hF t ξ
  exact ((hF t).differentiable (by norm_num) ξ).hasFDerivAt.isLittleO
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.nearby\_trajectory\_literal；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`\boldsymbol z(t,\hat{\boldsymbol\xi})-\boldsymbol z(t,\boldsymbol\xi)\approx\boldsymbol W(t)(\hat{\boldsymbol\xi}-\boldsymbol\xi).`$ | MD.Ch01.nearby\_trajectory\_literal，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | ≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。 | [EXTRA] |

[EXTRA] ≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。

### 6. 审计结论

错误取值点的导数通常与真实DF\_t(ξ)不同，差额线性项不是小o。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
固定t、ξ时以x→ξ的Fréchet小o严格化≈，扰动、基点、线性算子作用顺序均忠实。literal沿用错误取值点，不能成立。corrected改用DF\_t(ξ)后正是HasFDerivAt的小o结论；只需每个F\_t可微，故未要求真实流是合法推广，不是缺失的必要前提。未声称此结论关于t一致或对长时间有效。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2557；MD.Ch01.nearby\_trajectory\_literal。

## 1. MD-1.7.2-SingularValues · definition · 印刷p.45 / PDFp.68

### 2. 原文陈述

> The square roots of the eigenvalues of $`\boldsymbol A^T\boldsymbol A`$, also called the singular values of $`\boldsymbol A`$, then give the axes of the image ellipsoid.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def singularValues {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ) : Prop :=
  (∀ i, 0 ≤ σ i) ∧ Antitone σ ∧
  ∃ O : Matrix (Fin n) (Fin n) ℝ,
    O.transpose*O=1 ∧ O.transpose*(A.transpose*A)*O=Matrix.diagonal (fun i => (σ i)^2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.singularValues；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 用存在正交特征基刻画谱关系；不是以要证明的椭球图像结论为假设。 | [EXTRA] |

[EXTRA] 用存在正交特征基刻画谱关系；不是以要证明的椭球图像结论为假设。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2575；MD.Ch01.singularValues。

## 1. MD-1.7.2-SingularEllipsoid · unnumbered_claim · 印刷p.45 / PDFp.68

### 2. 原文陈述

> We may view a regular linear mapping $`\boldsymbol v\mapsto\boldsymbol A\boldsymbol v`$, where $`\boldsymbol A\in\mathbb R^{m\times m}`$, as a mapping of an $`m-1`$-dimensional sphere (embedded in the $`m`$-dimensional Euclidean space) to an ellipsoid in the same space (Fig. 1.26). The square roots of the eigenvalues of $`\boldsymbol A^T\boldsymbol A`$, also called the singular values of $`\boldsymbol A`$, then give the axes of the image ellipsoid.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem singularellipsoid :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ), IsUnit A →
    singularValues A σ →
    ∃ O : Matrix (Fin n) (Fin n) ℝ, O.transpose*O=1 ∧
      (A.toEuclideanLin '' {v : Position n | ‖v‖=1}) =
        {x : Position n | ∑ i, ((O.transpose.toEuclideanLin x) i / σ i)^2 = 1} := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.singularellipsoid；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | regular=可逆；单位球面，正交主轴O及半轴σ；平移/半径可按线性缩放恢复。 | [EXTRA] |

[EXTRA] regular=可逆；单位球面，正交主轴O及半轴σ；平移/半径可按线性缩放恢复。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2584；MD.Ch01.singularellipsoid。

## 1. MD-1.7.2-LyapunovExponents · definition · 印刷p.45 / PDFp.68

### 2. 原文陈述

> The Lyapunov exponents $`\lambda_1,\lambda_2,\ldots,\lambda_m`$ are defined by

$$
\lambda_i=\limsup_{t\to\infty}\frac1t\log\sigma_i(\boldsymbol W),
$$


> where $`\sigma_i`$ represents the ith singular value of the given matrix (to maintain continuity, these should be ordered in some way, say largest to smallest).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def lyapunovExponent (σ : ℝ → ℝ) : EReal :=
  Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lyapunovExponent；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\lambda_i=\limsup_{t\to\infty}\frac1t\log\sigma_i(\boldsymbol W),`$ | MD.Ch01.lyapunovExponent，完整展开陈述见上一行及第4段 | 一致 |
| limsup与有序奇异值 | Filter.limsup ((Real.log (σ t)/t : ℝ) : EReal) atTop；σ为singularValues关系的第i分量 | 一致 |
| 原文未显式量化的技术资格 | 扩展实数EReal允许±∞，原文未保证极限有限；σ(t)>0在可逆流Jacobian背景，避免log0。 | [EXTRA] |

[EXTRA] 扩展实数EReal允许±∞，原文未保证极限有限；σ(t)>0在可逆流Jacobian背景，避免log0。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2596；MD.Ch01.lyapunovExponent。

## 1. MD-1.7.2-PositiveLyapunovGrowth · unnumbered_claim · 印刷p.45 / PDFp.68

### 2. 原文陈述

> The presence of a positive Lyapunov exponent implies exponential growth of perturbations, which, as we have seen, is one of the hallmarks of chaos.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem positivelyapunovgrowth :
  ∀ σ : ℝ → ℝ, (∀ t > 0, 0 < σ t) → 0 < lyapunovExponent σ →
    ∃ c > 0, ∀ T : ℝ, ∃ t > T, Real.exp (c*t) < σ t := by
  intro σ hσ hpos
  obtain ⟨c,hc,hclim⟩ := EReal.exists_between_coe_real hpos
  refine ⟨c,EReal.coe_pos.mp hc,?_⟩
  intro T
  change (c : EReal) < Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop at hclim
  have hf := Filter.frequently_lt_of_lt_limsup (h := hclim)
  obtain ⟨t,htc,htt⟩ := (hf.and_eventually (eventually_gt_atTop (max T 0))).exists
  have ht : 0 < t := lt_of_le_of_lt (le_max_right T 0) htt
  refine ⟨t,lt_of_le_of_lt (le_max_left T 0) htt,?_⟩
  have hl : c < Real.log (σ t)/t := EReal.coe_lt_coe_iff.mp htc
  have he : c*t < Real.log (σ t) := (lt_div_iff₀ ht).mp hl
  exact (Real.exp_lt_exp.mpr he).trans_eq (Real.exp_log (hσ t ht))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.positivelyapunovgrowth；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 正limsup蕴涵指数放大 | ∃c>0,∀T,∃t>T,Real.exp(c*t)<σ t | 一致；任意晚子列，不增强为全部晚时刻 |
| 原文未显式量化的技术资格 | 依据limsup只能得到任意晚时间仍有指数放大，即无穷时间子列；不添加所有足够大t统一增长。 | [EXTRA] |

[EXTRA] 依据limsup只能得到任意晚时间仍有指数放大，即无穷时间子列；不添加所有足够大t统一增长。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2603；MD.Ch01.positivelyapunovgrowth。

