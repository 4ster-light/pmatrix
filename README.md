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
uv tool install git+https://github.com/4ster-light/pmatrix
```

Then run:

```bash
pmatrix
```

### Using pip

Clone the repository and install:

```bash
pip install git+https://github.com/4ster-light/pmatrix
```

Then run:

```bash
pmatrix
```

### From source with UV

Clone the repository:

```bash
git clone https://github.com/4ster-light/pmatrix
cd pmatrix
uv tool install .
```

## Requirements

- Python 3.10 or later
- A terminal that supports ANSI escape codes (most modern terminals)
- Linux, macOS, or compatible terminal

## License

MIT
