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
	}
}
