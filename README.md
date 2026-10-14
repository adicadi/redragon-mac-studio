# Redragon Studio for macOS (K530 Draconic 60%)

A lightweight, native macOS companion application and menu bar utility built specifically for the **Redragon K530 / K530 Pro Draconic** 60% mechanical keyboard (`BT5.0 KB`).

---

## Features

### 1. ⌘ Mac Layout Optimizer & Key Remapper
- **One-Click Command / Option Swap**: Automatically swaps `Left Alt` ⇄ `Left Win` exclusively for the Redragon keyboard without touching your built-in MacBook keyboard.
- **Mac Muscle Memory**: Positions `Command (⌘)` directly adjacent to Space for seamless `Cmd+C`, `Cmd+V`, `Cmd+Tab`, and `Cmd+Space`.
- **Caps Lock Behavior**: Option to transform `Caps Lock` into `Escape (Esc)` (essential for Vim / coding on 60% layouts) or `Control (⌃)`.
- **Right Modifier Swap**: Option to swap `Right Alt` ⇄ `Right Win`.
- **Persistence Across Reboots**: Includes a built-in user LaunchAgent toggle to ensure key mappings persist after reboots.

### 2. 💡 Interactive RGB Lighting Studio & Simulator
- **Live 60% Visualizer**: Real-time rendering of all 61 keys of the K530 Draconic with key labels, secondary legends, and dynamic glowing backlighting.
- **13 Animated Modes**: Emulates all onboard dynamic modes (*Neon Stream, Flowing Wave, Breathing, Reactive Ripple, Aurora Spectrum, Starry Raindrops, Radar Beam, Solid Static, DIY*).
- **8 Hardware Presets & Shortcut Guide**: Interactive selector that shows the exact hardware shortcut (`Fn2 + 8` for color, `Fn2 + 9` for mode).
- **DIY Custom Lighting Assistant**: Visual walkthrough for recording custom per-key color schemes directly onto the keyboard's internal flash memory (`Fn2 + \`).

### 3. 🗺️ 60% Layer Explorer
- **Layer 0 (Base)**: Standard ANSI typing.
- **Layer 1 (Fn1 Navigation)**: Arrow keys (`WASD`), Function keys (`F1–F12`), Navigation (`Home`, `End`, `PgUp`, `PgDn`, `Delete`), and Bluetooth device profiles (`BT1`, `BT2`, `BT3`).
- **Layer 2 (Fn2 Hardware)**: Lighting modes, brightness, speed, power toggle, battery gauge, and factory reset.

### 4. 🐉 Menu Bar Quick Access
- Sits in your macOS system menu bar with a quick status indicator.
- Fast toggle for Mac Layout mode directly from the top menu bar.
- Onboard battery level checking tip (`Fn2 + Esc`).

---

## Launching the App

You can launch the app directly using the launcher script:
```bash
/Users/adicadi/redragon-mac-studio/launch.sh
```

Or open the app bundle:
```bash
open "/Users/adicadi/redragon-mac-studio/Redragon Studio.app"
```

## Rebuilding

To recompile or modify:
```bash
cd /Users/adicadi/redragon-mac-studio
./build.sh
```

