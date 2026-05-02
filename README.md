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

Execute without installing using `nix run` or `uvx`:

```bash
nix run github:4ster-light/pmatrix
```

```bash
uvx git+https://github.com/4ster-light/pmatrix
```

## Installation

### Using Nix (recommended)

Install directly from GitHub:

```bash
nix profile install github:4ster-light/pmatrix
```

Or add the flake to your system config if you use NixOS.

### Using UV

Install directly from GitHub:

```bash
uv tool install git+https://github.com/4ster-light/pmatrix
```

### Using pip

Install directly from GitHub:

```bash
pip install git+https://github.com/4ster-light/pmatrix
```

### From source

#### Nix

```bash
git clone https://github.com/4ster-light/pmatrix
cd pmatrix
nix build
```

The executable will be found at `./result/bin/pmatrix`, move it to a directory
in _PATH_ like `/usr/bin` and you'll be able to access it from anywhere in your
system.

#### UV

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
