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

## Running

Execute without installing using `uvx`:

```bash
uvx git+https://github.com/4ster-light/pmatrix
```

## Installation

### Nix (recommended)

Run PMatrix without installing it:

```bash
nix run github:4ster-light/pmatrix --
```

If you want to enter a shell with the package available:

```bash
nix shell github:4ster-light/pmatrix -c bash
```

To install it into your Nix profile:

```bash
nix profile install github:4ster-light/pmatrix
```

If you want to pin a specific release, reference the tag explicitly:

```bash
nix run github:4ster-light/pmatrix/v1.0.1 --
```

### Python [(uv)](https://docs.astral.sh/uv)

If you prefer Python tooling, install directly from GitHub:

```bash
uv tool install git+https://github.com/4ster-light/pmatrix@v1.0.1
```

Or with pip:

```bash
pip install git+https://github.com/4ster-light/pmatrix@v1.0.1
```

### From source with Nix

Clone the repository and enter the development shell:

```bash
git clone https://github.com/4ster-light/pmatrix
cd pmatrix
nix develop
```

Then run the app:

```bash
nix run . --
```

### From source with uv

Clone the repository and install locally:

```bash
git clone https://github.com/4ster-light/pmatrix
cd pmatrix
uv tool install .
```

## Usage

Run the program:

```bash
pmatrix
```

The program will display the Matrix digital rain effect in your terminal. Resize
the terminal window to see the display adjust dynamically. Press Ctrl+C to exit.

## Requirements

- Python 3.10 or later
- A terminal that supports ANSI escape codes (most modern terminals)
- Linux, macOS, or compatible terminal

## Release

The latest release is [v1.0.1](https://github.com/4ster-light/pmatrix/releases/tag/v1.0.1).

## License

MIT
