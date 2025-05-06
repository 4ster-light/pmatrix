module Init

open System
open Types

// All create empty instances respectively, just for the initial iteration and initialisation of the matrix

let initCell (rng: Random) : Cell =
    { CharIndex = rng.Next(0, chars.Length) // Randomly select a character
      Intensity = 0 } // Initialize intensity to 0 (not active because first frame)

let initColumn (height: int) (rng: Random) : Column =
    List.init height (fun _ -> initCell rng)

let initMatrix (width: int) (height: int) (rng: Random) : Matrix =
    List.init width (fun _ -> initColumn height rng)
