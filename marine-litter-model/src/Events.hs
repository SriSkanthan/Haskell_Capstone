-- Events.hs
-- Functions to process individual environmental events using pattern matching

module Events where

import Types

-- | Applies a single Event to the current LitterState and returns the updated state.
--   This is the core state-transition function used in the fold operation.
applyEvent :: LitterState -> Event -> LitterState
applyEvent state event =
  case event of
    RiverInput  amt -> addLitter  state amt
    OceanInput  amt -> addLitter  state amt
    HumanInput  amt -> addLitter  state amt
    Cleanup     amt -> removeLitter state amt
    Degradation amt -> removeLitter state amt

-- | Internal helper: adds litter to the state.
addLitter :: LitterState -> Double -> LitterState
addLitter st amt = st
  { totalLitter  = totalLitter st + amt
  , eventCount   = eventCount  st + 1
  , totalAdded   = totalAdded  st + amt
  }

-- | Internal helper: removes litter from the state, floored at 0.
removeLitter :: LitterState -> Double -> LitterState
removeLitter st amt = st
  { totalLitter  = max 0.0 (totalLitter st - amt)
  , eventCount   = eventCount   st + 1
  , totalRemoved = totalRemoved st + amt
  }

-- | Produces a human-readable description of an event.
describeEvent :: Event -> String
describeEvent (RiverInput  a) = "River Input:   +" ++ show a ++ " kg"
describeEvent (OceanInput  a) = "Ocean Input:   +" ++ show a ++ " kg"
describeEvent (HumanInput  a) = "Human Input:   +" ++ show a ++ " kg"
describeEvent (Cleanup     a) = "Cleanup:       -" ++ show a ++ " kg"
describeEvent (Degradation a) = "Degradation:   -" ++ show a ++ " kg"
