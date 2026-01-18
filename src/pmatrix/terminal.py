import sys
from shutil import get_terminal_size

from .config import (
	CLEAR_SCREEN,
	HIDE_CURSOR,
	RESET,
	SHOW_CURSOR,
)


def setup() -> None:
	sys.stdout.write(CLEAR_SCREEN)
	sys.stdout.write(HIDE_CURSOR)
	sys.stdout.flush()


def cleanup() -> None:
	sys.stdout.write(SHOW_CURSOR)
	sys.stdout.write(RESET)
	sys.stdout.flush()


def get_size() -> tuple[int, int]:
	term_size = get_terminal_size(fallback=(80, 24))
	return (term_size.columns, term_size.lines)


def clear_and_home() -> str:
	return "\x1b[H"
