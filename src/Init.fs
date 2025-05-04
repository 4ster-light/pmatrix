module Init

open System
open Types

let initCell (rng: Random) =
    { CharIndex = rng.Next(0, chars.Length)
      Intensity = 0 }

let initColumn height (rng: Random) =
    List.init height (fun _ -> initCell rng)

let initMatrix width height (rng: Random) =
    List.init width (fun _ -> initColumn height rng)
