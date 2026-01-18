"""Command-line interface entry point for pmatrix."""

import signal
import sys
import time

from .matrix import Matrix
from .terminal import cleanup, get_size, setup


def main() -> None:
	"""Run the matrix animation."""
	setup()

	width, height = get_size()
	matrix = Matrix(width, height)

	def signal_handler(sig, frame) -> None:
		"""Handle Ctrl+C gracefully."""
		cleanup()
		sys.exit(0)

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
			from .config import FRAME_DELAY

			elapsed = time.time() - start_time
			sleep_time = max(0, FRAME_DELAY - elapsed)
			time.sleep(sleep_time)
	except KeyboardInterrupt:
		cleanup()
		sys.exit(0)


if __name__ == "__main__":
	main()
