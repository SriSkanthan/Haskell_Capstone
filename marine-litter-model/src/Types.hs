-- Types.hs
-- Defines core algebraic data types for the Waste Accumulation Model

module Types where

-- | Represents a waste or removal event affecting the environment.
--   Waste can be biodegradable or non-biodegradable; removal is by
--   cleanup operations or natural degradation (both carry an amount in kg).
data Event
  = BiodegradableWastes    Double   -- ^ Biodegradable waste added (food, paper, organic)
  | NonBiodegradableWastes Double   -- ^ Non-biodegradable waste added (plastics, glass, metals)
  | Cleanup                Double   -- ^ Waste removed by cleanup operations
  | Degradation            Double   -- ^ Waste reduced by natural biodegradation
  deriving (Show, Eq)

-- | Represents the current state of waste in the modelled environment.
data LitterState = LitterState
  { bioWaste      :: Double   -- ^ Current biodegradable waste (kg)
  , nonBioWaste   :: Double   -- ^ Current non-biodegradable waste (kg)
  , totalLitter   :: Double   -- ^ Total waste accumulated (bio + non-bio, kg)
  , eventCount    :: Int      -- ^ Number of events processed
  , totalAdded    :: Double   -- ^ Cumulative waste added (all categories)
  , totalRemoved  :: Double   -- ^ Cumulative waste removed (all categories)
  } deriving (Show, Eq)

-- | Creates an initial (empty) waste state.
initialState :: LitterState
initialState = LitterState
  { bioWaste     = 0.0
  , nonBioWaste  = 0.0
  , totalLitter  = 0.0
  , eventCount   = 0
  , totalAdded   = 0.0
  , totalRemoved = 0.0
  }
