import Foundation

#if os(Linux)
	import Glibc
#else
	import Darwin
#endif

struct Config {
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

struct Drop {
	var position: Int
	var length: Int
	var characters: [Character]
	var speed: Int

	init(length: Int, speed: Int = 1) {
		self.position = 0
		self.length = length
		self.speed = speed
		self.characters = (0..<length).map { _ in Config.chars.randomElement()! }
	}

	mutating func update() {
		position += speed
	}

	func isActive(in height: Int) -> Bool {
		position < height + length
	}

	func characterAt(row: Int) -> Character? {
		let relativePos = row - position
		guard relativePos >= -length && relativePos < 0 else { return nil }
		let index = relativePos + length
		return characters[index]
	}

	func intensityAt(row: Int) -> Double {
		let relativePos = row - position
		guard relativePos >= -length && relativePos < 0 else { return 0 }
		let index = relativePos + length
		return Double(index + 1) / Double(length)
	}
}

class Column {
	var drop: Drop?
	var height: Int

	init(height: Int) {
		self.height = height
	}

	func update() {
		if var currentDrop = drop {
			currentDrop.update()

			if currentDrop.isActive(in: height) {
				drop = currentDrop
			} else {
				drop = nil
			}
		} else if Int.random(in: 0..<Config.dropProbability) == 0 {
			let length = Int.random(in: Config.minDropLength..<Config.maxDropLength)
			let speed = Int.random(in: 1...2)
			drop = Drop(length: length, speed: speed)
		}
	}

	func characterAt(row: Int) -> (Character, Double)? {
		guard let drop = drop else { return nil }
		guard let char = drop.characterAt(row: row) else { return nil }
		let intensity = drop.intensityAt(row: row)
		return (char, intensity)
	}
}

class Matrix {
	var columns: [Column]
	var width: Int
	var height: Int

	init(width: Int, height: Int) {
		self.width = width
		self.height = height
		self.columns = (0..<width).map { _ in Column(height: height) }
	}

	func update() {
		for column in columns {
			column.update()
		}
	}

	func resize(width: Int, height: Int) {
		guard width != self.width || height != self.height else { return }

		if width > self.width {
			columns.append(
				contentsOf: (0..<(width - self.width)).map { _ in Column(height: height) })
		} else if width < self.width {
			columns = Array(columns.prefix(width))
		}

		for column in columns {
			column.height = height
		}

		self.width = width
		self.height = height
	}

	func render() {
		var output = "\u{001B}[H"

		for row in 0..<height {
			for col in 0..<width {
				if let (char, intensity) = columns[col].characterAt(row: row) {
					let color = intensity > 0.7 ? Config.brightGreen : Config.green
					output += "\(color)\(char)"
				} else {
					output += " "
				}
			}
			if row < height - 1 {
				output += "\n"
			}
		}

		print(output, terminator: "")
		fflush(nil)  // Flush all buffers to ensure immediate output
	}
}

struct Terminal {
	static func getSize() -> (width: Int, height: Int) {
		#if os(Linux)
			var w = winsize()
			guard ioctl(STDOUT_FILENO, UInt(TIOCGWINSZ), &w) == 0 else {
				return (80, 24)
			}
			return (Int(w.ws_col), Int(w.ws_row))
		#else
			var w = winsize()
			guard ioctl(STDOUT_FILENO, TIOCGWINSZ, &w) == 0 else {
				return (80, 24)
			}
			return (Int(w.ws_col), Int(w.ws_row))
		#endif
	}

	static func setup() {
		print(Config.clearScreen, terminator: "")
		print(Config.hideCursor, terminator: "")
		fflush(nil)  // Flush all buffers to ensure immediate output
	}

	static func cleanup() {
		print(Config.showCursor, terminator: "")
		print(Config.reset, terminator: "")
		fflush(nil)  // Flush all buffers to ensure immediate output
	}
}

@main
struct SMatrix {
	static func main() {
		Terminal.setup()

		var (width, height) = Terminal.getSize()
		let matrix = Matrix(width: width, height: height)

		signal(SIGINT) { _ in
			Terminal.cleanup()
			exit(0)
		}

		while true {
			let startTime = Date()

			let (newWidth, newHeight) = Terminal.getSize()
			if newWidth != width || newHeight != height {
				width = newWidth
				height = newHeight
				matrix.resize(width: width, height: height)
			}

			matrix.update()
			matrix.render()

			let elapsed = Date().timeIntervalSince(startTime)
			let sleepTime = max(0, Double(Config.frameDelay) - elapsed * 1_000_000)
			usleep(UInt32(sleepTime))
		}
	}
}
