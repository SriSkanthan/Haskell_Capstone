-- Types.hs
-- Defines core algebraic data types for the Marine Litter Accumulation Model

module Types where

-- | Represents an environmental event affecting litter in an estuary.
--   Each constructor carries a Double representing the amount (in kg) of litter
--   added or removed.
data Event
  = RiverInput  Double   -- ^ Litter carried in by river inflow
  | OceanInput  Double   -- ^ Litter carried in by ocean tides
  | HumanInput  Double   -- ^ Litter deposited by coastal human activity
  | Cleanup     Double   -- ^ Litter removed by cleanup operations
  | Degradation Double   -- ^ Litter reduced by natural degradation
  deriving (Show, Eq)

-- | Represents the current state of litter in the estuarine region.
data LitterState = LitterState
  { totalLitter    :: Double   -- ^ Total litter accumulated (kg)
  , eventCount     :: Int      -- ^ Number of events processed
  , totalAdded     :: Double   -- ^ Cumulative litter added
  , totalRemoved   :: Double   -- ^ Cumulative litter removed
  } deriving (Show, Eq)

-- | Creates an initial (empty) litter state.
initialState :: LitterState
initialState = LitterState
  { totalLitter  = 0.0
  , eventCount   = 0
  , totalAdded   = 0.0
  , totalRemoved = 0.0
  }
