<div align="center">

# PMatrix

[![Python 3.11+](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Sponsor](https://img.shields.io/badge/Sponsor-GitHub%20Sponsors-EA4AAA?logo=githubsponsors)](https://github.com/sponsors/4ster-light)

**A Matrix digital rain effect terminal application, written in Python**

</div>

<br />

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

Execute without installing using `nix run`, `uvx`, or the container image:

```bash
nix run github:4ster-light/pmatrix
```

```bash
uvx git+https://github.com/4ster-light/pmatrix
```

```bash
docker run -it --rm ghcr.io/4ster-light/pmatrix
```

## Installation

### Using Nix (recommended)

```bash
nix profile add github:4ster-light/pmatrix
```

Or add the flake to your system config if you use NixOS.

### Using UV

```bash
uv tool install git+https://github.com/4ster-light/pmatrix
```

### Using pip

```bash
pip install git+https://github.com/4ster-light/pmatrix
```

### Podman/Docker

```bash
docker pull ghcr.io/4ster-light/pmatrix
```

#### Build from source

```bash
git clone https://github.com/4ster-light/pmatrix.git
cd pmatrix
nix build .#container
docker load < result
docker run -it --rm pmatrix
```

This will build the container image and run it interactively in your terminal
using the provided image in the nix flake.

> [!NOTE]
> The container OCI image is built using Nix, so you will need Nix installed to
> build it. You may load it with either Podman or Docker.

## Requirements

- Python 3.11 or later
- A terminal that supports ANSI escape codes (most modern terminals)
- Linux, macOS, or compatible terminal

## License

MIT
