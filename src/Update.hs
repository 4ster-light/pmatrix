module Update
  ( updateMatrix,
    adjustMatrixSize,
    updateCell,
  )
where

import Control.Monad (replicateM)
import Control.Monad.State
import Init (initColumn)
import System.Random
import Types

-- | Update single cell intensity
updateCell :: Cell -> Cell
updateCell (Cell idx i)
  | i > 0 = Cell idx (max 1 (i - 1))
  | otherwise = Cell idx 0

-- | Create new rain drop with intensity gradient
createRainDrop :: Int -> Int -> Int -> [Cell]
createRainDrop h rainLength charIdx =
  take h $
    [Cell charIdx (max 1 (5 - i)) | i <- [0 .. rainLength - 1]]
      ++ repeat (Cell 0 0)

-- | Update column with possible new rain drop
updateColumn :: Int -> Column -> State StdGen Column
updateColumn h col = do
  let active = any ((> 0) . intensity) col
  shouldStart <- state $ randomR (0, 20 :: Int)
  newChar <- state $ randomR (0, length chars - 1)
  rainLength <- state $ randomR (5, 15)

  let newHead =
        if not active && shouldStart == 0
          then createRainDrop h rainLength newChar
          else [Cell 0 0]

  return $ take h (newHead ++ col)

-- | Update entire matrix state
updateMatrix :: Int -> Matrix -> State StdGen Matrix
updateMatrix h = mapM (updateColumn h)

-- | Adjust matrix dimensions to match terminal size
adjustMatrixSize :: Int -> Int -> Matrix -> State StdGen Matrix
adjustMatrixSize w h matrix = do
  let currentW = length matrix
  newCols <- replicateM (max 0 (w - currentW)) (initColumn h)

  let adjusted = take w $ matrix ++ newCols
  return $ map (adjustColumn h) adjusted

adjustColumn :: Int -> Column -> Column
adjustColumn h col = take h $ col ++ repeat (Cell 0 0)