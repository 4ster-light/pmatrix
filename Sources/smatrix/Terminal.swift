#if os(Linux)
	import Glibc
#else
	import Darwin
#endif

enum Terminal {
	static var size: (width: Int, height: Int) {
		var w = winsize()
		guard ioctl(STDOUT_FILENO, UInt(TIOCGWINSZ), &w) == 0,
			w.ws_col > 0,
			w.ws_row > 0
		else {
			return (80, 24)
		}
		return (Int(w.ws_col), Int(w.ws_row))
	}

	static func setup() {
		print(Config.clearScreen, terminator: "")
		print(Config.hideCursor, terminator: "")
	}

	static func cleanup() {
		print(Config.showCursor, terminator: "")
		print(Config.reset, terminator: "")
	}
}
