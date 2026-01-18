import sys

from .column import Column
from .config import BRIGHT_GREEN, GREEN, RESET
from .terminal import clear_and_home


class Matrix:
	"""Manages the matrix animation state and rendering"""

	def __init__(self, width: int, height: int) -> None:
		"""Initialize the matrix"""
		self.width = width
		self.height = height
		self.columns = [Column(height) for _ in range(width)]

	def update(self) -> None:
		"""Update all columns to advance animation"""
		for column in self.columns:
			column.update()

	def resize(self, width: int, height: int) -> None:
		"""Resize the matrix to new dimensions"""
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
		"""Render the current frame to stdout"""
		output = [clear_and_home()]

		for row in range(self.height):
			for col in range(self.width):
				result = self.columns[col].character_at(row)
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
