module Main (main) where

import Control.Concurrent (threadDelay)
import Control.Monad.State
import Init
import Render
import System.Console.ANSI
import qualified System.Console.Terminal.Size as TS
import System.Random
import Types
import Update

getTerminalDimensions :: IO (Int, Int)
getTerminalDimensions = do
  maybeSize <- TS.size
  pure $ case maybeSize of
    Just (TS.Window rows cols) -> (cols, rows - 1)
    Nothing -> (80, 24) -- Default size if unavailable

mainLoop :: Matrix -> StdGen -> IO ()
mainLoop matrix gen = do
  (w, h) <- getTerminalDimensions
  let (adjusted, gen1) = runState (adjustMatrixSize w h matrix) gen
  let (updated, gen2) = runState (updateMatrix h adjusted) gen1

  renderMatrix $ map (map updateCell) updated
  threadDelay 50000
  mainLoop updated gen2

main :: IO ()
main = do
  hideCursor
  clearScreen
  (w, h) <- getTerminalDimensions
  gen <- getStdGen
  let (initial, gen') = runState (initMatrix w h) gen
  mainLoop initial gen'