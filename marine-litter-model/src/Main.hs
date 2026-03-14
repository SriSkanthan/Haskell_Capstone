-- Main.hs
-- Entry point for the Waste Accumulation Dynamics simulation
-- Models biodegradable and non-biodegradable waste using functional fold operations.

module Main where

import Types
import Events
import Simulation

-- | A sample sequence of waste events representing typical daily waste generation
--   and removal activities. Uses the four event types:
--     BiodegradableWastes    - food, paper, organic material added
--     NonBiodegradableWastes - plastics, glass, metals added
--     Cleanup                - removal by organised cleanup operations
--     Degradation            - removal by natural biodegradation
sampleEvents :: [Event]
sampleEvents =
  [ BiodegradableWastes    80.0    -- Day 1 : Food & organic waste deposited (80 kg)
  , NonBiodegradableWastes 120.5   -- Day 2 : Plastic bottles and bags dumped (120.5 kg)
  , BiodegradableWastes    55.0    -- Day 3 : Paper and cardboard waste added (55 kg)
  , Degradation            30.0    -- Day 4 : Natural biodegradation reduces waste (30 kg)
  , NonBiodegradableWastes 95.0    -- Day 5 : Glass and metal debris added (95 kg)
  , Cleanup                60.0    -- Day 6 : Cleanup drive removes waste (60 kg)
  , BiodegradableWastes    40.0    -- Day 7 : Weekend organic waste surge (40 kg)
  , NonBiodegradableWastes 70.0    -- Day 8 : Industrial plastic waste deposited (70 kg)
  , Degradation            25.0    -- Day 9 : Continued natural degradation (25 kg)
  , Cleanup                110.0   -- Day 10: Large-scale cleanup operation (110 kg)
  ]

main :: IO ()
main = do
  putStrLn "=================================================="
  putStrLn " Waste Accumulation Dynamics Simulator"
  putStrLn " Biodegradable vs Non-Biodegradable Waste"
  putStrLn " Modelled via Functional Fold Operations (Haskell)"
  putStrLn "==================================================\n"

  -- Run the verbose simulation (step-by-step output)
  finalState <- runSimulationVerbose sampleEvents

  -- Print the final report
  putStr (formatReport finalState)

  -- Cross-check: silent fold produces the same result
  let silentResult = runSimulation sampleEvents
  putStrLn $ "\n[Verification] Silent foldl result matches: "
             ++ show (totalLitter silentResult == totalLitter finalState)
