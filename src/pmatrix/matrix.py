import sys

from .column import Column
from .config import BRIGHT_GREEN, GREEN, RESET, CLEAR_AND_HOME


class Matrix:
	def __init__(self, width: int, height: int) -> None:
		self.width = width
		self.height = height
		self.columns = [Column(height) for _ in range(width)]

	def update(self) -> None:
		for column in self.columns:
			column.update()

	def resize(self, width: int, height: int) -> None:
		if width == self.width and height == self.height:
			return

		# Adjust columns based on width change
		if width > self.width:
			self.columns.extend(Column(height) for _ in range(width - self.width))
		elif width < self.width:
			self.columns = self.columns[:width]

		# Update height for all columns
		for column in self.columns:
			column.height = height

		self.width = width
		self.height = height

	def render(self) -> None:
		output = [CLEAR_AND_HOME]

		for row in range(self.height):
			for col in range(self.width):
				result = self.columns[col].char_at(row)
				if result is not None:
					char, intensity = result
					color = BRIGHT_GREEN if intensity > 0.7 else GREEN
					output.append(f"{color}{char}")
				else:
					output.append(" ")

			if row < self.height - 1:
				output.append("\n")

		output.append(RESET)
		sys.stdout.write("".join(output))
		sys.stdout.flush()
