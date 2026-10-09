# 第1章MathCopilot批次索引

每个文件整段粘贴一个Task，先A后C，B取消；网站只由用户提交。本地交付代码版本c63b079；输入版本以批次MANIFEST.json的SHA256为准。

2026-10-09输入限制补充：BATCH01推荐用[精简提交说明](compact/BATCH01/README.md)，分a/b/c三个Task，每份指令853字节，只引用该子任务的材料MD与裁页PDF，两附件+指令合计均小于256000字节。原五条及冻结输入保持原样；三个返回文件逐条整合后才算原BATCH01覆盖完整。旧包与BATCH02–23仍保留；网站实际接收未验证。

网站读取工具故障补充：若报code-mode host closed its stdout，按上述说明将各子任务PASTE.txt全文复制到新Task输入框，只关联对应PDF；PASTE不是供上传的替代附件。若PDF仍读失败则不能完成原页审校，保留待审并反馈维护方。

| 批次 | source_id | 上传文件及页码 | 建议顺序 |
|---|---|---|---|
| BATCH01 | MD-1.5.3-Thm1.1, MD-1.2-EnergyConservation, MD-1.3-NewtonEulerLagrange, MD-1.4-LegendreHamiltonian, MD-1.5.1-FlowInverse | 见BATCH01.md包首清单；原文PDF 55, 42, 46, 47, 49 | 1 |
| BATCH02 | MD-1.1-Schrodinger, MD-1.1-NewtonModel, MD-1.1-HardSphere | 见BATCH02.md包首清单；原文PDF 28, 29, 30 | 2 |
| BATCH03 | MD-1.1.1-Multibody, MD-1.1.1-Morse, MD-1.1.1-MorseMinimum, MD-1.1.1-LengthBond, MD-1.1.1-Dispersion, MD-1.1.1-Buckingham, MD-1.1.1-LennardJones, MD-1.1.1-LJRepulsion | 见BATCH03.md包首清单；原文PDF 31, 31, 31, 32, 33, 33, 33, 33–34 | 3 |
| BATCH04 | MD-1.1.1-HeterogeneousLJ | 见BATCH04.md包首清单；原文PDF 34 | 4 |
| BATCH05 | MD-1.1.2-Coulomb, MD-1.1.2-Cutoff, MD-1.1.2-Yukawa, MD-1.1.2-AngleBond, MD-1.1.2-Dihedral, MD-1.1.2-GayBerne | 见BATCH05.md包首清单；原文PDF 35, 35, 35, 36, 36, 39–40 | 5 |
| BATCH06 | MD-1.2-NewtonCompact, MD-1.2-DegreesFreedom, MD-1.2-ConstraintDimension, MD-1.2-TotalEnergy, MD-1.2-PairCancellation, MD-1.2-MomentumConservation, MD-1.2-HarmonicSolution, MD-1.2-ScalarMechanical | 见BATCH06.md包首清单；原文PDF 41, 41, 41, 41, 42, 42, 42–43, 43 | 6 |
| BATCH07 | MD-1.2-ScalarQuadrature, MD-1.2-UniformLJSystem, MD-1.2-RadialLJForceLiteral, MD-1.2-LJCoordinateScaling, MD-1.2-LJTimeScaling | 见BATCH07.md包首清单；原文PDF 43, 44, 44, 44, 44–45 | 7 |
| BATCH08 | MD-1.3-Lagrangian, MD-1.3-GeneralizedCoordinates, MD-1.3-GeneralizedMassRegular | 见BATCH08.md包首清单；原文PDF 45, 46, 46 | 8 |
| BATCH09 | MD-1.4-ConvexLegendre, MD-1.4-HamiltonEquations, MD-1.4-HamiltonFixedMass, MD-1.4-HamiltonLagrangeEquivalence, MD-1.4-PhaseSpace | 见BATCH09.md包首清单；原文PDF 47, 47, 47, 48, 48 | 9 |
| BATCH10 | MD-1.5-LocalExistUnique, MD-1.5-EnergySurface, MD-1.5-EnergyBounds, MD-1.5-UniformLevelsCompact, MD-1.5-CompactContinuation, MD-1.5-Nonconfining | 见BATCH10.md包首清单；原文PDF 48, 48, 48, 49, 48–49, 49 | 10 |
| BATCH11 | MD-1.5.1-FlowMap, MD-1.5.1-FlowEnergy, MD-1.5.1-HarmonicPhaseFlow, MD-1.5.1-SpectralSolution, MD-1.5.1-BasisCoefficients, MD-1.5.1-MatrixExponentialSolution, MD-1.5.1-MatrixExpSeries, MD-1.5.1-RealSpectralSolution | 见BATCH11.md包首清单；原文PDF 49, 49, 50, 50, 50, 50, 50–51, 50 | 11 |
| BATCH12 | MD-1.5.2-FirstIntegral, MD-1.5.2-FirstIntegralCriterion, MD-1.5.2-PlanarGraphReduction, MD-1.5.2-PlanarQuadrature, MD-1.5.2-ScalarFirstIntegral, MD-1.5.2-KeplerEnergy, MD-1.5.2-KeplerConservedEnergy, MD-1.5.2-KeplerAngularMomentum | 见BATCH12.md包首清单；原文PDF 51, 51, 51, 51, 51, 52, 52, 52 | 12 |
| BATCH13 | MD-1.5.2-KeplerMomentum, MD-1.5.2-PolarCoordinates, MD-1.5.2-KeplerPolarLagrangian, MD-1.5.2-KeplerPolarODE, MD-1.5.2-PolarAngularIdentity, MD-1.5.2-KeplerRadialReduction, MD-1.5.2-KeplerRadialEnergy, MD-1.5.2-KeplerFullSolution | 见BATCH13.md包首清单；原文PDF 52, 52, 52, 52, 52, 52, 52–53, 53 | 13 |
| BATCH14 | MD-1.5.2-ActionAngleCoordinates, MD-1.5.2-ActionEnergy, MD-1.5.2-ActionODE, MD-1.5.2-ActionSolution, MD-1.5.2-HarmonicTorus, MD-1.5.2-TorusPeriod, MD-1.5.2-TorusDense, MD-1.5.2-LocalActionAngleReduction | 见BATCH14.md包首清单；原文PDF 53, 53, 53, 53, 53, 53, 53, 53 | 14 |
| BATCH15 | MD-1.5.3-Equilibrium, MD-1.5.3-ConstantEquilibrium, MD-1.5.3-EquilibriumLinearization, MD-1.5.3-Hyperbolic, MD-1.5.3-HartmanGrobmanLiteral, MD-1.5.3-LyapunovStability, MD-1.5.3-HyperbolicStabilityTransfer, MD-1.5.3-HamiltonEquilibrium | 见BATCH15.md包首清单；原文PDF 54, 54, 54, 54–55, 54–55, 55, 55, 55 | 15 |
| BATCH16 | MD-1.5.3-StrongLocalMinimum, MD-1.5.3-LinearizedHamiltonian, MD-1.5.3-PositiveHessianQuadratic, MD-1.5.3-PositiveHessianMinimum | 见BATCH16.md包首清单；原文PDF 55, 55, 56, 56 | 16 |
| BATCH17 | MD-1.6-UniformPairLattice, MD-1.6-UnorderedPairCount, MD-1.6-NearestNeighbor, MD-1.6-WalledChain, MD-1.6-PeriodicChain, MD-1.6-PeriodicBoundary, MD-1.6-PeriodicTranslationMomentum, MD-1.6-RegularLattice | 见BATCH17.md包首清单；原文PDF 56, 56, 56, 56, 56, 57, 57, 57 | 17 |
| BATCH18 | MD-1.6-RegularLatticeMinimizerLiteral, MD-1.6-PeriodicImages, MD-1.6-MinimumImage, MD-1.6-RhombicLattice, MD-1.6-HexagonalLattice, MD-1.6-UnitCell, MD-1.6-FCCStacking, MD-1.6-HCPStacking | 见BATCH18.md包首清单；原文PDF 57, 58, 58, 58, 58, 58, 59, 59 | 18 |
| BATCH19 | MD-1.6.1-MinimumGradientZero, MD-1.6.1-ForceLinearization, MD-1.6.1-MinimumHessianLiteral, MD-1.6.1-ImaginarySpectrum, MD-1.6.1-ComplexNormalMode, MD-1.6.1-RealNormalMode | 见BATCH19.md包首清单；原文PDF 59–60, 60, 60, 60, 60, 60 | 19 |
| BATCH20 | MD-1.7-PlanarTrimerModel, MD-1.7-CentralPairPotential, MD-1.7-CentralPairGradient, MD-1.7-CentralMomentum, MD-1.7-CentralAngularMomentum, MD-1.7-CenterOfMassMotion, MD-1.7-ConstantRotationLiteral, MD-1.7-IsoscelesCoordinates | 见BATCH20.md包首清单；原文PDF 61, 61, 61, 62, 62, 62, 62, 62 | 20 |
| BATCH21 | MD-1.7-IsoscelesEnergyReduction, MD-1.7-IsoscelesAccessibleRegion, MD-1.7-EquilateralTrimerMinimum, MD-1.7-TrimerEnergyLowerBound, MD-1.7-CollinearTrimer, MD-1.7-TrimerSaddle, MD-1.7-TrimerEscapeLiteral | 见BATCH21.md包首清单；原文PDF 62, 63, 61, 63, 63, 63–64, 63 | 21 |
| BATCH22 | MD-1.7.1-ChaosConditions, MD-1.7.1-TransitivityErgodicityLiteral, MD-1.7.1-AnisotropicOscillator | 见BATCH22.md包首清单；原文PDF 64–65, 65, 65 | 22 |
| BATCH23 | MD-1.7.2-FlowJacobianLiteral, MD-1.7.2-VariationalEquationLiteral, MD-1.7.2-NearbyTrajectoryLiteral, MD-1.7.2-SingularValues, MD-1.7.2-SingularEllipsoid, MD-1.7.2-LyapunovExponents, MD-1.7.2-PositiveLyapunovGrowth | 见BATCH23.md包首清单；原文PDF 67, 67–68, 68, 68, 68, 68, 68 | 23 |

## 每批共同上传文件

`blueprint/ch01/ch01_source.json`、`Blueprint/Ch01.lean`及以下实际依赖文件；各批PDF页码见上表与包首。

```text
MolecularDynamics/BasicDefinitions.lean
MolecularDynamics/Chapter01/BasisMatrix.lean
MolecularDynamics/Chapter01/ComplexSpectralFlow.lean
MolecularDynamics/Chapter01/Continuation.lean
MolecularDynamics/Chapter01/EnergyConservation.lean
MolecularDynamics/Chapter01/EnergyGlobalExistence.lean
MolecularDynamics/Chapter01/Equilibrium.lean
MolecularDynamics/Chapter01/EquilibriumLinearization.lean
MolecularDynamics/Chapter01/EuclideanStability.lean
MolecularDynamics/Chapter01/FirstIntegralGraph.lean
MolecularDynamics/Chapter01/FirstIntegralQuadrature.lean
MolecularDynamics/Chapter01/FirstIntegrals.lean
MolecularDynamics/Chapter01/FutureFlow.lean
MolecularDynamics/Chapter01/GeneralizedCoordinates.lean
MolecularDynamics/Chapter01/GlobalContinuation.lean
MolecularDynamics/Chapter01/GlobalFlow.lean
MolecularDynamics/Chapter01/Hamiltonian.lean
MolecularDynamics/Chapter01/HamiltonianHessian.lean
MolecularDynamics/Chapter01/HarmonicActionAngle.lean
MolecularDynamics/Chapter01/HarmonicOscillator.lean
MolecularDynamics/Chapter01/HarmonicTorus.lean
MolecularDynamics/Chapter01/Kepler.lean
MolecularDynamics/Chapter01/KeplerCartesianBridge.lean
MolecularDynamics/Chapter01/KeplerPolarDynamics.lean
MolecularDynamics/Chapter01/KeplerQuadrature.lean
MolecularDynamics/Chapter01/KeplerReconstruction.lean
MolecularDynamics/Chapter01/Lagrangian.lean
MolecularDynamics/Chapter01/LatticePairPotential.lean
MolecularDynamics/Chapter01/LatticeVibrations.lean
MolecularDynamics/Chapter01/LegendreTransform.lean
MolecularDynamics/Chapter01/LinearFlow.lean
MolecularDynamics/Chapter01/LinearizedHamiltonian.lean
MolecularDynamics/Chapter01/LocalExistence.lean
MolecularDynamics/Chapter01/LocalTrajectories.lean
MolecularDynamics/Chapter01/MatrixFlow.lean
MolecularDynamics/Chapter01/MechanicalConfinement.lean
MolecularDynamics/Chapter01/MechanicalContinuation.lean
MolecularDynamics/Chapter01/MomentumBounds.lean
MolecularDynamics/Chapter01/MomentumConservation.lean
MolecularDynamics/Chapter01/NBody.lean
MolecularDynamics/Chapter01/NormalModes.lean
MolecularDynamics/Chapter01/ODEEndpoint.lean
MolecularDynamics/Chapter01/ParticleCoordinates.lean
MolecularDynamics/Chapter01/PhaseMetric.lean
MolecularDynamics/Chapter01/PlanarAngularMomentum.lean
MolecularDynamics/Chapter01/PolarCoordinateMap.lean
MolecularDynamics/Chapter01/PolarCoordinates.lean
MolecularDynamics/Chapter01/PotentialBarriers.lean
MolecularDynamics/Chapter01/PotentialRegularity.lean
MolecularDynamics/Chapter01/RealRecoveryFlow.lean
MolecularDynamics/Chapter01/RealSpectralFlow.lean
MolecularDynamics/Chapter01/ReviewDefinitions.lean
MolecularDynamics/Chapter01/ReviewProofs.lean
MolecularDynamics/Chapter01/ScalarIntegrability.lean
MolecularDynamics/Chapter01/ScalarLocalIVP.lean
MolecularDynamics/Chapter01/ScalarTurning.lean
MolecularDynamics/Chapter01/SeparableQuadrature.lean
MolecularDynamics/Chapter01/Stability.lean
MolecularDynamics/Chapter01/Statements.lean
MolecularDynamics/Chapter01/TimeReversal.lean
MolecularDynamics/Chapter01/TorusDensity.lean
MolecularDynamics/Chapter01/TorusPeriod.lean
MolecularDynamics/Chapter01/VariationalEquation.lean
MolecularDynamics/Notation.lean
```
