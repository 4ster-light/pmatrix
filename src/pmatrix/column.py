import random

from .config import DROP_PROBABILITY
from .drop import Drop


class Column:
	"""Manages a single column with a falling drop."""

	def __init__(self, height: int) -> None:
		self.height = height
		self.drop: Drop | None = None

	def update(self) -> None:
		"""Update the column state, moving existing drops or creating new ones"""
		if self.drop is not None:
			self.drop.update()

			if not self.drop.is_active(self.height):
				self.drop = None
		elif random.randint(0, DROP_PROBABILITY - 1) == 0:
			self.drop = Drop.create()

	def character_at(self, row: int) -> tuple[str, float] | None:
		"""Get the character and intensity at a specific row"""
		if self.drop is None:
			return None

		char = self.drop.character_at(row)
		if char is None:
			return None

		intensity = self.drop.intensity_at(row)
		return (char, intensity)
