# 🎬 FMatrix

An alternative to the famous cmatrix program, implemented in F# using .NET.

## 📜 Overview

This program creates a digital rain effect, similar to the iconic Matrix movie
visuals, with falling characters in the terminal. It is written in F# and runs
as a .NET console application.

## 🛠 Usage

Ensure you have the .NET SDK installed (compatible with .NET 9.0). Clone the
repository and navigate to the project directory. Build and run the project
using:

```bash
dotnet run
```

To build a release binary:

```bash
dotnet build -c Release
```

The program will display the Matrix digital rain effect in your terminal. You
can resize the terminal window to adjust the display dynamically.

## 📋 Requirements

- .NET SDK 9.0 or later.
- A terminal that supports ANSI escape codes (e.g., most Linux terminals).

> [!IMPORTANT]
> This program has been tested only on Linux. It should work on other platforms
> with ANSI-compatible terminals (e.g., Windows Terminal, macOS Terminal), but
> compatibility is not guaranteed.

The program does not yet implement the full functionality of cmatrix (e.g.,
customizable colors or character sets).

## 📄 License

BSD 3-Clause License

## 💝 Sponsor

If you like this project, consider supporting me by buying me a coffee.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/B0B41HVJUR)
