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
