-- Main.hs
-- Entry point for the Marine Litter Accumulation Dynamics simulation
-- Uses functional fold operations to model sequential environmental events.

module Main where

import Types
import Events
import Simulation

-- | A sample sequence of environmental events representing daily processes
--   in an estuarine region. These cover all five event types defined in Types.hs.
sampleEvents :: [Event]
sampleEvents =
  [ RiverInput  120.5   -- Day 1: River carries in 120.5 kg of litter
  , OceanInput  85.3    -- Day 2: Ocean tide brings in 85.3 kg
  , HumanInput  45.0    -- Day 3: Coastal human activity adds 45.0 kg
  , Cleanup     60.0    -- Day 4: Cleanup operation removes 60.0 kg
  , RiverInput  200.0   -- Day 5: Heavy rainfall, river input surges
  , Degradation 30.2    -- Day 6: Natural degradation reduces litter by 30.2 kg
  , OceanInput  110.7   -- Day 7: Storm-driven ocean tide adds 110.7 kg
  , Cleanup     150.0   -- Day 8: Large-scale cleanup removes 150.0 kg
  , HumanInput  22.5    -- Day 9: Weekend coastal activity adds litter
  , Degradation 18.0    -- Day 10: Ongoing natural degradation
  ]

main :: IO ()
main = do
  putStrLn "=================================================="
  putStrLn " Marine Litter Accumulation Dynamics Simulator"
  putStrLn " Modeled via Functional Fold Operations (Haskell)"
  putStrLn "=================================================="

  -- Run the verbose simulation (step-by-step output)
  finalState <- runSimulationVerbose sampleEvents

  -- Print the final report
  putStr (formatReport finalState)

  -- Cross-check: silent fold produces the same result
  let silentResult = runSimulation sampleEvents
  putStrLn $ "\n[Verification] Silent foldl result matches: "
             ++ show (totalLitter silentResult == totalLitter finalState)
