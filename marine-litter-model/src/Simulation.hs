-- Simulation.hs
-- Core simulation engine using fold operations to process event sequences

module Simulation where

import Types
import Events

-- | Runs the simulation by folding over a list of events starting from the
--   initial state. Uses 'foldl' to apply each event sequentially.
runSimulation :: [Event] -> LitterState
runSimulation events = foldl applyEvent initialState events

-- | Runs the simulation AND prints step-by-step progress to stdout.
runSimulationVerbose :: [Event] -> IO LitterState
runSimulationVerbose events = do
  putStrLn "\n========================================="
  putStrLn "  Waste Accumulation Simulation"
  putStrLn "  (Biodegradable vs Non-Biodegradable)"
  putStrLn "=========================================\n"
  putStrLn "Processing events:\n"
  finalState <- processVerbose initialState 1 events
  return finalState

-- | Recursive helper that processes events one at a time, printing each step.
processVerbose :: LitterState -> Int -> [Event] -> IO LitterState
processVerbose state _ [] = return state
processVerbose state stepNum (e:es) = do
  let newState = applyEvent state e
  putStrLn $ "  Step " ++ show stepNum ++ ": " ++ describeEvent e
  putStrLn $ "    Biodegradable    : " ++ show (bioWaste    newState) ++ " kg"
  putStrLn $ "    Non-Biodegradable: " ++ show (nonBioWaste newState) ++ " kg"
  putStrLn $ "    Total waste      : " ++ show (totalLitter newState) ++ " kg\n"
  processVerbose newState (stepNum + 1) es

-- | Formats the final simulation summary report.
formatReport :: LitterState -> String
formatReport ls = unlines
  [ "\n========================================="
  , "  Simulation Summary Report"
  , "========================================="
  , "  Events processed             : " ++ show (eventCount  ls)
  , "  Total added                  : " ++ show (totalAdded  ls) ++ " kg"
  , "  Total removed                : " ++ show (totalRemoved ls) ++ " kg"
  , "  Biodegradable remaining      : " ++ show (bioWaste    ls) ++ " kg"
  , "  Non-Biodegradable remaining  : " ++ show (nonBioWaste ls) ++ " kg"
  , "  Net accumulation             : " ++ show (totalLitter ls) ++ " kg"
  , "========================================="
  ]
