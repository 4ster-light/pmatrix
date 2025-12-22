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
