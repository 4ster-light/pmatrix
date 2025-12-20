# SMatrix

A Matrix digital rain effect terminal application, implemented in Swift.

## Overview

This program creates a digital rain effect, similar to the iconic Matrix movie
visuals, with falling characters in the terminal. Written in modern Swift with
improved features including variable drop speeds, intensity-based coloring, and
optimized rendering.

## Features

- **Dynamic drop speeds**: Each drop falls at a random speed for more variety
- **Intensity-based coloring**: Leading characters are brighter green
- **Smooth animations**: Optimized rendering at ~30 FPS
- **Terminal resize support**: Automatically adjusts to window size changes
- **Graceful shutdown**: Handles Ctrl+C cleanly

## Usage

Ensure you have Swift installed. Clone the repository and navigate to the
project directory. Build and run:

```bash
swift run
```

To build an optimized release binary:

```bash
swift build -c release
./.build/release/smatrix
```

The program will display the Matrix digital rain effect in your terminal. Resize
the terminal window to see the display adjust dynamically. Press Ctrl+C to exit.

## Requirements

- Swift 5.0 or later
- A terminal that supports ANSI escape codes (most modern terminals)
- Linux or macOS

## License

MIT

## Sponsor

If you like this project, consider supporting me by buying me a coffee.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/B0B41HVJUR)
