"""Configuration constants for pmatrix."""

FRAME_DELAY = 0.033  # Seconds (~30 FPS)
DROP_PROBABILITY = 40
MIN_DROP_LENGTH = 6
MAX_DROP_LENGTH = 17
CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&*+-=<>"

# ANSI color codes
GREEN = "\x1b[32m"
BRIGHT_GREEN = "\x1b[92m"
RESET = "\x1b[0m"
CLEAR_SCREEN = "\x1b[2J"
HIDE_CURSOR = "\x1b[?25l"
SHOW_CURSOR = "\x1b[?25h"
