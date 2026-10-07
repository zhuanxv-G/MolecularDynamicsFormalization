import MolecularDynamics.Chapter06.BrownianSmoothDensity
import Mathlib.Analysis.InnerProductSpace.LinearPMap
open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap
#check LinearPMap.mk
#check LinearPMap.IsFormalAdjoint.le_adjoint
#check LinearPMap.adjoint_isClosed
#check LinearPMap.adjoint_isFormalAdjoint
#check LinearPMap.IsClosed.isClosable
#check LinearPMap.IsClosable.leIsClosable
#check LinearPMap.le_closure
#check LinearPMap.IsClosable.closure_isClosed
#check LinearPMap.IsClosable.graph_closure_eq_closure_graph
#check LinearPMap.closureHasCore
#check LinearPMap.IsClosable.existsUnique
#check LinearPMap.IsClosable.closure_mono
