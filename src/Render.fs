module Render

open System
open System.Text
open Types

let fadeColor intensity =
    match intensity with
    | i when i >= 3 -> Vivid, Green
    | i when i >= 1 -> Dull, Green
    | _ -> Dull, Black // Inactive

let renderMatrix (matrix: Matrix) =
    let sb = StringBuilder()
    Console.SetCursorPosition(0, 0)

    let transposed = matrix |> List.transpose

    for row in transposed do
        for cell in row do
            let colorIntensity, color = fadeColor cell.Intensity

            let ansiColor =
                match colorIntensity, color with
                | Vivid, Green -> 92
                | Dull, Green -> 32
                | Vivid, White -> 97
                | Dull, White -> 97
                | _, Black -> 30

            let char = if cell.Intensity > 0 then chars.[cell.CharIndex] else ' '
            sb.Append $"\x1B[{ansiColor}m{char}" |> ignore

        sb.AppendLine() |> ignore

    Console.Write(sb.ToString())
    Console.Out.Flush()
