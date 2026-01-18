import signal
import sys
import time

from .matrix import Matrix
from .terminal import cleanup, get_size, setup
from .config import FRAME_DELAY


def signal_handler(sig, frame) -> None:
	cleanup()
	sys.exit(0)


if __name__ == "__main__":
	setup()

	width, height = get_size()
	matrix = Matrix(width, height)

	signal.signal(signal.SIGINT, signal_handler)

	try:
		while True:
			start_time = time.time()

			# Check for terminal resize
			new_width, new_height = get_size()
			if new_width != width or new_height != height:
				width = new_width
				height = new_height
				matrix.resize(width, height)

			matrix.update()
			matrix.render()

			# Frame rate control (~30 FPS)

			elapsed = time.time() - start_time
			sleep_time = max(0, FRAME_DELAY - elapsed)
			time.sleep(sleep_time)
	except KeyboardInterrupt:
		cleanup()
		sys.exit(0)
