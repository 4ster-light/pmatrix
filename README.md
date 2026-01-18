# PMatrix

A Matrix digital rain effect terminal application, written in Python.

## Overview

This program creates a digital rain effect, similar to the iconic Matrix movie
visuals, with falling characters in the terminal. Written in modern Python with
improved features including variable drop speeds, intensity-based coloring, and
optimized rendering.

## Features

- **Dynamic drop speeds**: Each drop falls at a random speed for more variety
- **Intensity-based coloring**: Leading characters are brighter green
- **Smooth animations**: Optimized rendering at ~30 FPS
- **Terminal resize support**: Automatically adjusts to window size changes
- **Graceful shutdown**: Handles Ctrl+C cleanly
- **No external dependencies**: Uses Python standard library only

## Installation

### Using UV (recommended)

Install directly from GitHub:

```bash
uv tool install git+https://github.com/anomalyco/smatrix
```

Then run:

```bash
smatrix
```

### Using pip

Clone the repository and install:

```bash
git clone https://github.com/anomalyco/smatrix
cd smatrix
pip install .
```

Then run:

```bash
smatrix
```

### From source with UV

Clone the repository:

```bash
git clone https://github.com/anomalyco/smatrix
cd smatrix
uv run smatrix
```

## Usage

Run the program:

```bash
smatrix
```

The program will display the Matrix digital rain effect in your terminal. Resize
the terminal window to see the display adjust dynamically. Press Ctrl+C to exit.

## Requirements

- Python 3.10 or later
- A terminal that supports ANSI escape codes (most modern terminals)
- Linux, macOS, or compatible terminal

## License

MIT
