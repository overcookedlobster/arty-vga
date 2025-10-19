# Arty A7-100T VGA Project

Simple VGA controller for Arty A7-100T that alternates between red and green colors every second.

## Hardware Setup

- **Board**: Arty A7-100T
- **VGA PMOD**: Connect to JC (top 4 pins) and JD (top 4 pins) connectors
  - JC: R[0-3], G[0-3]
  - JD: B[0-3], HSYNC, VSYNC
- **Reset**: BTN0 (button on board)

## Pin Mapping

| Signal | Pin | PMOD Port |
|--------|-----|-----------|
| R[0]   | U12 | JC1       |
| R[1]   | V12 | JC2       |
| R[2]   | V10 | JC3       |
| R[3]   | V11 | JC4       |
| G[0]   | U14 | JC7       |
| G[1]   | V14 | JC8       |
| G[2]   | T13 | JC9       |
| G[3]   | U13 | JC10      |
| B[0]   | D4  | JD1       |
| B[1]   | D3  | JD2       |
| B[2]   | F4  | JD3       |
| B[3]   | F3  | JD4       |
| HSYNC  | E2  | JD7       |
| VSYNC  | D2  | JD8       |
| BTN0   | D9  | -         |

## Build and Program

```bash
make build
make program
```

## Validation

Use `ffplay` to validate the VGA output:

```bash
make view
# Or directly:
ffplay -f v4l2 -input_format mjpeg -video_size 640x480 -framerate 60 /dev/video3
```

## Features

- 640x480 @ 60Hz VGA output
- Alternates between red and green every second
- Reset with BTN0

## Requirements

- Vivado (tested with 2023.x)
- openFPGALoader
- ffplay (optional, for validation)
