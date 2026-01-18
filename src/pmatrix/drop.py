import random
from dataclasses import dataclass

from .config import CHARS, MAX_DROP_LENGTH, MIN_DROP_LENGTH


@dataclass
class Drop:
	"""Represents a single falling drop of characters"""

	position: int
	length: int
	characters: list[str]
	speed: int

	@classmethod
	def create(cls) -> "Drop":
		"""Create a new drop with random parameters"""
		length = random.randint(MIN_DROP_LENGTH, MAX_DROP_LENGTH)
		speed = random.randint(1, 2)
		characters = [random.choice(CHARS) for _ in range(length)]
		return cls(position=0, length=length, characters=characters, speed=speed)

	def update(self) -> None:
		"""Move the drop down by its speed"""
		self.position += self.speed

	def is_active(self, height: int) -> bool:
		"""Check if the drop is still visible in the terminal"""
		return self.position < height + self.length

	def character_at(self, row: int) -> str | None:
		"""Get the character at a specific row, if present in this drop"""
		relative_pos = row - self.position
		if not (-self.length <= relative_pos < 0):
			return None
		index = relative_pos + self.length
		return self.characters[index]

	def intensity_at(self, row: int) -> float:
		"""Get the intensity (brightness) at a specific row"""
		relative_pos = row - self.position
		if not (-self.length <= relative_pos < 0):
			return 0.0
		index = relative_pos + self.length
		return (index + 1) / self.length
