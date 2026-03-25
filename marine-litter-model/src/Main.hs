-- Main.hs
-- Entry point for the Waste Accumulation Dynamics simulation
-- Models biodegradable and non-biodegradable waste using functional fold operations.

module Main where

import Types
import Events
import Simulation
import System.IO (hPutStrLn, stderr)
import System.Exit (exitFailure)

-- | Parses a single CSV row (skipping the header) into a list of Events.
--   Each row has the format:
--     Date,BiodegradableWastes,NonBiodegradableWastes,Cleanup,Degradation
--   and produces 4 events in that order.
parseRow :: String -> Either String [Event]
parseRow line =
  case splitOn ',' line of
    (_date : bio : nonBio : clean : degrad : _) ->
      case (readMaybe bio, readMaybe nonBio, readMaybe clean, readMaybe degrad) of
        (Just b, Just n, Just c, Just d) ->
          Right [ BiodegradableWastes    b
                , NonBiodegradableWastes n
                , Cleanup                c
                , Degradation            d
                ]
        _ -> Left $ "Could not parse numbers in row: " ++ line
    _ -> Left $ "Unexpected number of columns in row: " ++ line

-- | Splits a String on a delimiter character.
splitOn :: Char -> String -> [String]
splitOn delim str = go str []
  where
    go []     acc = [reverse acc]
    go (c:cs) acc
      | c == delim = reverse acc : go cs []
      | otherwise  = go cs (c : acc)

-- | A minimal readMaybe for Double (avoids importing Text.Read on older GHCs).
readMaybe :: String -> Maybe Double
readMaybe s =
  case reads s of
    [(v, "")] -> Just v
    [(v, ws)] | all (== ' ') ws -> Just v
    _         -> Nothing

-- | Loads events from a CSV file, returning either an error message or
--   the flat list of Events.
loadEvents :: FilePath -> IO (Either String [Event])
loadEvents path = do
  contents <- readFile path
  let rows   = drop 1 (lines contents)       -- drop the header line
      nonEmpty = filter (not . null) rows     -- drop blank lines
      parsed = map parseRow nonEmpty
      errors = [e | Left e <- parsed]
      events = concatMap (\(Right es) -> es) (filter isRight parsed)
  if null errors
    then return (Right events)
    else return (Left (unlines errors))
  where
    isRight (Right _) = True
    isRight _         = False

main :: IO ()
main = do
  putStrLn "=================================================="
  putStrLn " Waste Accumulation Dynamics Simulator"
  putStrLn " Biodegradable vs Non-Biodegradable Waste"
  putStrLn " Modelled via Functional Fold Operations (Haskell)"
  putStrLn "==================================================\n"

  let dataFile = "data/sample_events.txt"
  putStrLn $ "Loading events from: " ++ dataFile ++ "\n"

  result <- loadEvents dataFile
  case result of
    Left err -> do
      hPutStrLn stderr $ "Error parsing data file:\n" ++ err
      exitFailure
    Right events -> do
      putStrLn $ "Loaded " ++ show (length events `div` 4)
                 ++ " daily records (" ++ show (length events) ++ " events total).\n"

      -- Run the verbose simulation (step-by-step output)
      finalState <- runSimulationVerbose events

      -- Print the final report
      putStr (formatReport finalState)

      -- Cross-check: silent fold produces the same result
      let silentResult = runSimulation events
      putStrLn $ "\n[Verification] Silent foldl result matches: "
                 ++ show (totalLitter silentResult == totalLitter finalState)
