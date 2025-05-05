module Update

open System
open Init
open Types

let updateCell (cell: Cell) =
    if cell.Intensity > 0 then
        { cell with
            Intensity = max 1 (cell.Intensity - 1) }
    else
        cell

let createRainDrop length (rng: Random) =
    let charIndices = [| for _ in 1..length -> rng.Next(0, chars.Length) |]

    [ for i in 0 .. length - 1 ->
          { CharIndex = charIndices.[i]
            Intensity = 5 - i } ]

let updateColumn height (rng: Random) (col: Column) =
    let isActive = col |> List.exists (fun c -> c.Intensity > 0)
    let shouldStart = not isActive && rng.Next(0, 20) = 0 // 5% chance to start a new drop
    let rainLength = rng.Next(6, 11) // Random length between 6 and 10

    let shifted =
        List.truncate (max 0 (height - if shouldStart then rainLength else 1)) col

    let newCells =
        if shouldStart then
            createRainDrop rainLength rng
        else
            [ { CharIndex = 0; Intensity = 0 } ]

    // Combine new cells with shifted column, updating intensities
    newCells @ (shifted |> List.map updateCell)

let updateMatrix height rng (matrix: Matrix) =
    matrix |> List.map (updateColumn height rng)

let adjustMatrixSize width height rng (matrix: Matrix) =
    let currentWidth = matrix.Length

    let newCols =
        if width > currentWidth then
            List.init (width - currentWidth) (fun _ -> initColumn height rng)
        else
            []

    let adjusted = matrix @ newCols |> List.truncate width

    adjusted
    |> List.map (fun col ->
        let truncated = col |> List.truncate height

        let padding =
            List.replicate (max 0 (height - List.length truncated)) { CharIndex = 0; Intensity = 0 }

        truncated @ padding)
