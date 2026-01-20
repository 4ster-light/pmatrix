import random
from dataclasses import dataclass

from .config import CHARS, MAX_DROP_LENGTH, MIN_DROP_LENGTH


@dataclass
class Drop:
	position: int
	length: int
	characters: list[str]
	speed: int

	@classmethod
	def create(cls) -> "Drop":
		length = random.randint(MIN_DROP_LENGTH, MAX_DROP_LENGTH)
		speed = random.randint(1, 2)
		characters = [random.choice(CHARS) for _ in range(length)]
		return cls(position=0, length=length, characters=characters, speed=speed)

	def update(self) -> None:
		self.position += self.speed

	def is_active(self, height: int) -> bool:
		return self.position < height + self.length

	def char_at(self, row: int) -> str | None:
		relative_pos = row - self.position
		if not (-self.length <= relative_pos < 0):
			return None
		index = relative_pos + self.length
		return self.characters[index]

	def intensity_at(self, row: int) -> float:
		relative_pos = row - self.position
		if not (-self.length <= relative_pos < 0):
			return 0.0
		index = relative_pos + self.length
		return (index + 1) / self.length
