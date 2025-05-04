module Types

type Color =
    | Green
    | White
    | Black

type ColorIntensity =
    | Vivid
    | Dull

type Cell = { CharIndex: int; Intensity: int }

type Column = Cell list
type Matrix = Column list

let chars =
    [| 'ｱ'
       'ｲ'
       'ｳ'
       'ｴ'
       'ｵ'
       'ｶ'
       'ｷ'
       'ｸ'
       'ｹ'
       'ｺ'
       'ｻ'
       'ｼ'
       'ｽ'
       'ｾ'
       'ｿ'
       'ﾀ'
       'ﾁ'
       'ﾂ'
       'ﾃ'
       'ﾄ'
       'ﾅ'
       'ﾆ'
       'ﾇ'
       'ﾈ'
       'ﾉ'
       'ﾊ'
       'ﾋ'
       'ﾌ'
       'ﾍ'
       'ﾎ'
       'ﾏ'
       'ﾐ'
       'ﾑ'
       'ﾒ'
       'ﾓ'
       'ﾔ'
       'ﾕ'
       'ﾖ'
       'ﾗ'
       'ﾘ'
       'ﾙ'
       'ﾚ'
       'ﾛ'
       'ﾜ'
       'ﾝ' |]
