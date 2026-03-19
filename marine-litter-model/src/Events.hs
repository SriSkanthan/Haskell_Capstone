-- Events.hs
-- Functions to process individual waste events using pattern matching

module Events where

import Types

-- | Applies a single Event to the current LitterState and returns the updated state.
--   This is the core state-transition function used in the fold operation.
applyEvent :: LitterState -> Event -> LitterState
applyEvent state event =  
  case event of
    BiodegradableWastes    amt -> addBioWaste    state amt
    NonBiodegradableWastes amt -> addNonBioWaste state amt
    Cleanup                amt -> removeLitter   state amt
    Degradation            amt -> removeLitter   state amt

-- | Internal helper: adds biodegradable waste to the state.
addBioWaste :: LitterState -> Double -> LitterState
addBioWaste st amt = st
  { bioWaste    = bioWaste    st + amt
  , totalLitter = totalLitter st + amt
  , eventCount  = eventCount  st + 1
  , totalAdded  = totalAdded  st + amt
  }

-- | Internal helper: adds non-biodegradable waste to the state.
addNonBioWaste :: LitterState -> Double -> LitterState
addNonBioWaste st amt = st
  { nonBioWaste = nonBioWaste st + amt
  , totalLitter = totalLitter st + amt
  , eventCount  = eventCount  st + 1
  , totalAdded  = totalAdded  st + amt
  }

-- | Internal helper: removes waste (used by both Cleanup and Degradation),
--   floored at 0. Proportionally reduces bio and non-bio waste.
removeLitter :: LitterState -> Double -> LitterState
removeLitter st amt =
  let total   = totalLitter st
      removed = min amt total
      -- Reduce bio/non-bio proportionally (avoid division by zero)
      bioFraction    = if total > 0 then bioWaste   st / total else 0.5
      nonBioFraction = if total > 0 then nonBioWaste st / total else 0.5
      bioDelta    = removed * bioFraction
      nonBioDelta = removed * nonBioFraction
  in st
    { bioWaste     = max 0.0 (bioWaste    st - bioDelta)
    , nonBioWaste  = max 0.0 (nonBioWaste st - nonBioDelta)
    , totalLitter  = max 0.0 (totalLitter st - removed)
    , eventCount   = eventCount   st + 1
    , totalRemoved = totalRemoved st + removed
    }

-- | Produces a human-readable description of an event.
describeEvent :: Event -> String
describeEvent (BiodegradableWastes    a) = "Biodegradable Waste Added    : +" ++ show a ++ " kg"
describeEvent (NonBiodegradableWastes a) = "Non-Biodegradable Waste Added: +" ++ show a ++ " kg"
describeEvent (Cleanup                a) = "Cleanup (removed)            : -" ++ show a ++ " kg"
describeEvent (Degradation            a) = "Degradation (natural)        : -" ++ show a ++ " kg"
