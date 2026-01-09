enum Config {
	static let frameDelay: UInt32 = 33_000  // Microseconds (≈30 FPS)
	static let dropProbability = 40
	static let minDropLength = 6
	static let maxDropLength = 17
	static let chars: [Character] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&*+-=<>")

	// ANSI color codes
	static let green = "\u{001B}[32m"
	static let brightGreen = "\u{001B}[92m"
	static let reset = "\u{001B}[0m"
	static let clearScreen = "\u{001B}[2J"
	static let hideCursor = "\u{001B}[?25l"
	static let showCursor = "\u{001B}[?25h"
}
