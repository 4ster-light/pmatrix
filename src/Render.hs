module Render
  ( renderMatrix,
  )
where

import Control.Monad (forM_)
import Data.List (transpose)
import System.Console.ANSI
import System.IO (hFlush, stdout)
import Types

-- | Determine color based on cell intensity
fadeColor :: Int -> (ColorIntensity, Color)
fadeColor i
  | i == 5 = (Vivid, White) -- Bright head
  | i >= 3 = (Vivid, Green) -- Bright trail
  | i >= 1 = (Dull, Green) -- Dim trail
  | otherwise = (Dull, Black) -- Inactive

-- | Render matrix state to terminal
renderMatrix :: Matrix -> IO ()
renderMatrix matrix = do
  setCursorPosition 0 0
  forM_ (transpose matrix) $ \row -> do
    forM_ row $ \cell -> do
      let (colorIntensity, color) = fadeColor (intensity cell)
      setSGR [SetColor Foreground colorIntensity color]
      putChar $ if intensity cell > 0 then chars !! charIndex cell else ' '
    putChar '\n'
  hFlush stdout