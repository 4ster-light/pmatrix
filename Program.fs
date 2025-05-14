open System

let FRAME_DELAY = 33 // Milliseconds per frame (≈ 30 FPS)
let DROP_PROBABILITY = 40 // Higher number is less frequent drops (40 for ~2.5% chance)
let CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&".ToCharArray()

type Cell = char option // None for empty, Some char for visible
type Column = Cell list
type Matrix = Column list

/// Initialize a column with all cells empty
let initColumn (height: int) : Column = List.replicate height None

/// Update a column to simulate falling rain with random characters per drop
let updateColumn (height: int) (rng: Random) (col: Column) : Column =
    let isActive = col |> List.exists Option.isSome
    let shouldStart = not isActive && rng.Next(0, DROP_PROBABILITY) = 0

    if shouldStart then
        let dropLength = rng.Next(6, 17) // Random drop length between 6 and 16
        let drop = List.init dropLength (fun _ -> Some CHARS[rng.Next(CHARS.Length)]) // Random char per cell
        drop @ List.replicate (height - dropLength) None
    else
        None :: col |> List.truncate height // Shift down

/// Initialize the matrix based on terminal width and height
let initMatrix (width: int) (height: int) : Matrix =
    List.init width (fun _ -> initColumn height)

/// Render the matrix to the terminal
let renderMatrix (matrix: Matrix) (width: int) (height: int) : unit =
    Console.SetCursorPosition(0, 0)

    // Set color to green for the entire frame
    Console.ForegroundColor <- ConsoleColor.Green
    Console.BackgroundColor <- ConsoleColor.Black

    [ for row in 0 .. height - 1 do
          yield
              [ for col in 0 .. width - 1 do
                    let cell =
                        if col < matrix.Length && row < matrix[col].Length then
                            matrix[col][row]
                        else
                            None

                    yield
                        match cell with
                        | Some c -> c
                        | None -> ' ' ]
              |> Array.ofList
              |> String ]
    |> String.concat "\n"
    |> Console.Write

    // Reset color after rendering
    Console.ResetColor()
    Console.Out.Flush()

/// Update the entire matrix
let updateMatrix (height: int) (rng: Random) (matrix: Matrix) : Matrix =
    matrix |> List.map (updateColumn height rng)

/// Adjust matrix size for terminal resize
let adjustMatrix (width: int) (height: int) (matrix: Matrix) : Matrix =
    let newMatrix: Matrix =
        if width > matrix.Length then
            matrix @ List.init (width - matrix.Length) (fun _ -> initColumn height)
        else
            matrix |> List.truncate width

    newMatrix
    |> List.map (fun col ->
        if col.Length < height then
            col @ List.replicate (height - col.Length) None
        else
            col |> List.truncate height)

let getTerminalDimensions () =
    try
        let width = Console.WindowWidth
        let height = Console.WindowHeight
        if width > 0 && height > 0 then width, height else 80, 24
    with _ ->
        80, 24

let rec mainLoop (matrix: Matrix) (lastWidth: int) (lastHeight: int) (rng: Random) : Async<unit> =
    async {
        let startTime = DateTime.Now
        let width, height = getTerminalDimensions ()

        let adjustedMatrix =
            if width <> lastWidth || height <> lastHeight then
                adjustMatrix width height matrix
            else
                matrix

        let updatedMatrix = updateMatrix height rng adjustedMatrix
        renderMatrix updatedMatrix width height

        let elapsedMs = (DateTime.Now - startTime).TotalMilliseconds |> int
        let sleepMs = max 0 (FRAME_DELAY - elapsedMs)

        do! Async.Sleep sleepMs
        return! mainLoop updatedMatrix width height rng
    }

[<EntryPoint>]
let main _ =
    Console.CursorVisible <- false
    Console.Clear()

    let rng = Random()
    let width, height = getTerminalDimensions ()
    let initialMatrix = initMatrix width height

    mainLoop initialMatrix width height rng |> Async.RunSynchronously

    0
