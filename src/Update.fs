module Update

open System
open Init
open Types

let private updateCell (cell: Cell) : Cell =
    if cell.Intensity > 0 then
        { cell with // Decrease intensity
            Intensity = max 1 (cell.Intensity - 1) }
    else
        cell

let private createRainDrop (length: int) (rng: Random) : Column =
    let charIndices = [| for _ in 1..length -> rng.Next(0, chars.Length) |]

    // Create a list of cells with decreasing intensity
    [ for i in 0 .. length - 1 ->
          { CharIndex = charIndices.[i]
            Intensity = 5 - i } ]

let private updateColumn (height: int) (rng: Random) (col: Column) : Column =
    let isActive = col |> List.exists (fun c -> c.Intensity > 0)
    let shouldStart = not isActive && rng.Next(0, 20) = 0 // 5% chance to start a new drop
    let rainLength = rng.Next(6, 17) // Random length between 6 and 16

    // Shift the column down by one position
    let shiftedColumn: Column =
        List.truncate (max 0 (height - if shouldStart then rainLength else 1)) col

    // If a new drop should start, create it
    let newCells =
        if shouldStart then
            createRainDrop rainLength rng
        else
            [ { CharIndex = 0; Intensity = 0 } ]

    // Combine new cells with shifted column, updating intensities
    newCells @ (shiftedColumn |> List.map updateCell)

let updateMatrix (height: int) (rng: Random) (matrix: Matrix) : Matrix =
    matrix |> List.map (updateColumn height rng)

let adjustMatrixSize (width: int) (height: int) (rng: Random) (matrix: Matrix) : Matrix =
    let currentWidth = matrix.Length

    let newExtraColumns: Matrix =
        if width > currentWidth then
            // If terminal was wider than the matrix, add new columns
            List.init (width - currentWidth) (fun _ -> initColumn height rng)
        else
            []

    // If terminal was narrower than the matrix, truncate the existing columns
    let adjustedMatrix: Matrix = matrix @ newExtraColumns |> List.truncate width

    adjustedMatrix
    |> List.map (fun col ->
        // If terminal was shorter than the matrix, truncate the existing columns
        let truncatedColumn: Column = col |> List.truncate height

        // If terminal was taller than the matrix, add padding to the bottom
        let padding: Column =
            List.replicate (max 0 (height - List.length truncatedColumn)) { CharIndex = 0; Intensity = 0 }

        // Combine the truncated column with the padding
        truncatedColumn @ padding)
