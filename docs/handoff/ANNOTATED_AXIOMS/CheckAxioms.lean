import Blueprint.Ch02
import Blueprint.Ch04
import Blueprint.Ch05
import Lean
#print axioms MD.Ch02.textbookWedgeOneForms_apply
#print axioms MD.Ch04.rigidSystemState
#print axioms MD.Ch05.domainL2

open Lean Elab Command in
run_cmd do
  let wanted : Array Name := #[`MD.Ch02.momentumKickDerivative, `MD.Ch02.momentumKick_hasFDerivAt]
  let mut found := 0
  for (n, _) in (← getEnv).constants.toList do
    let user := privateToUserName n
    if wanted.contains user then
      elabCommand (← `(command| #print axioms $(mkIdent n)))
      let axs ← collectAxioms n
      logInfo m!"PRIVATE_AX {user.toString}|{n.toString}|{String.intercalate "," (axs.toList.map Name.toString)}"
      found := found+1
  unless found == wanted.size do throwError "Missing private audit targets"
