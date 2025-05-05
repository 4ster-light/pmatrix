module Program

open System
open System.Diagnostics
open Init
open Render
open Update
open Types

let getTerminalDimensions () =
    try
        let width = Console.WindowWidth
        let height = Console.WindowHeight - 1

        if width > 0 && height > 0 then width, height else 80, 24
    with _ ->
        80, 24

let rec mainLoop matrix lastWidth lastHeight rng =
    async {
        let stopwatch = Stopwatch.StartNew()
        let width, height = getTerminalDimensions ()

        let newMatrix: Matrix =
            if width <> lastWidth || height <> lastHeight then
                adjustMatrixSize width height rng matrix
            else
                matrix

        let updated: Matrix = updateMatrix height rng newMatrix

        renderMatrix updated

        let elapsedMs = stopwatch.ElapsedMilliseconds
        let sleepMs = max 0 (33 - int elapsedMs) // Target 33ms per frame (~30 FPS)

        do! Async.Sleep sleepMs
        return! mainLoop updated width height rng
    }

[<EntryPoint>]
let main _ =
    Console.CursorVisible <- false
    Console.Clear()

    let rng = Random()
    let width, height = getTerminalDimensions ()
    let initialMatrix = initMatrix width height rng

    Async.RunSynchronously(mainLoop initialMatrix width height rng)
    0
