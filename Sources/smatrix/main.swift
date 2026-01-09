import Foundation

Terminal.setup()

var (width, height) = Terminal.size
let matrix = Matrix(width: width, height: height)

signal(SIGINT) { _ in
	Terminal.cleanup()
	exit(0)
}

while true {
	let startTime = Date()

	let (newWidth, newHeight) = Terminal.size
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
