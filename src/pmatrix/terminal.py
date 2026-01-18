"""Terminal utility functions for managing terminal state and rendering."""

import sys
from shutil import get_terminal_size

from .config import (
	CLEAR_SCREEN,
	HIDE_CURSOR,
	RESET,
	SHOW_CURSOR,
)


def setup() -> None:
	"""Initialize terminal for matrix rendering."""
	sys.stdout.write(CLEAR_SCREEN)
	sys.stdout.write(HIDE_CURSOR)
	sys.stdout.flush()


def cleanup() -> None:
	"""Restore terminal to normal state."""
	sys.stdout.write(SHOW_CURSOR)
	sys.stdout.write(RESET)
	sys.stdout.flush()


def get_size() -> tuple[int, int]:
	"""Get current terminal dimensions.

	Returns:
		A tuple of (width, height) in characters.
	"""
	term_size = get_terminal_size(fallback=(80, 24))
	return (term_size.columns, term_size.lines)


def clear_and_home() -> str:
	"""Return escape sequence to clear screen and move cursor home."""
	return "\x1b[H"
