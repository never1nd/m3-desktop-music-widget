# M3 Expressive Desktop Music Widget

Standalone **Material Design 3 Expressive** desktop music player widget built with **Quickshell** (Qt6 / QML) for Wayland compositors (**Niri, Hyprland, Sway, River**, etc.) — **architecture-independent (`x86_64` & `ARM64`)**.

## Features
- **Material Design 3 Expressive Design:** `28px` rounded card, flowing wavy audio scrubber, morphing XL solid squircle Play/Pause button, filled tonal transport controls (`-10s`, `Prev`, `Play/Pause`, `Next`, `+10s`), variable `Roboto Flex` typography & `Material Symbols Rounded` icons.
- **Universal MPRIS Support:** automatically attaches to any playing MPRIS media source (Pear Desktop / YouTube Music, Spotify, Firefox/Zen, mpv/Celluloid, VLC, Telegram/AyuGram, etc.).
- **Live Synced Karaoke Lyrics:** fetches time-synced LRC lyrics from [LRCLIB](https://lrclib.net) with automatic line scrolling and local caching (`~/.cache/m3-lyrics/`), powered by pure Python 3 stdlib (zero extra Python dependencies).
- **Wallpaper Layer Pinning:** runs on `wlr-layer-shell` `bottom` layer by default (pinned strictly behind your windows on every workspace) — or switchable to `top` / `overlay` in `config.json`.
- **Auto-Hide When Paused:** smoothly hides when music is paused/stopped (configurable via `autoHideWhenPaused`).
- **Live JSON Configuration & Dynamic Color Sync:** edit `config.json` without restarting, pick one of the 4 built-in presets (`presets/lavender.json`, `blue.json`, `forest-light.json`, `peach.json`), or point `colorsFile` to your `matugen` `colors.json` for automatic wallpaper-synced Material 3 colors!

---

## Requirements
- **Wayland compositor** supporting `wlr-layer-shell` (Niri, Hyprland, Sway, River, etc.)
- **Quickshell** (Qt 6)
- **Python 3** (standard library only, for LRCLIB lyrics fetching)
- Fonts: **Roboto Flex** (or any sans-serif) and **Material Symbols Rounded** (`ttf-material-symbols-variable`)

---

## Quick Start

### Run directly without installing
```bash
git clone https://github.com/never1nd/m3-desktop-music-widget.git
cd m3-desktop-music-widget
qs -p ./shell.qml
```

### Install locally
```bash
./install.sh
m3-music-widget
```

### Autostart in your compositor
- **Niri** (`~/.config/niri/config.kdl`):
  ```kdl
  spawn-at-startup "m3-music-widget"
  ```
- **Hyprland** (`~/.config/hypr/hyprland.conf`):
  ```ini
  exec-once = m3-music-widget
  ```
- **Sway** (`~/.config/sway/config`):
  ```
  exec m3-music-widget
  ```

---

## Configuration (`config.json`)

Every setting hot-reloads automatically when you save `config.json`!

| Key | Type | Default | Description |
|---|---|---:|---|
| `position` | string | `"top-right"` | Corner anchor: `"top-right"`, `"top-left"`, `"bottom-right"`, `"bottom-left"`, `"center"` |
| `margins` | object | `{top:52, right:40, bottom:40, left:40}` | Distance from screen edges in pixels |
| `width` | int | `880` | Widget width in pixels (automatically compacts to `<=480` when `showLyrics: false`) |
| `height` | int | `488` | Widget height in pixels |
| `radius` | int | `28` | Card corner radius in pixels |
| `opacity` | float | `0.90` | Card background opacity (`0.0` – `1.0`) |
| `layer` | string | `"bottom"` | Wayland layer: `"bottom"` (behind windows on wallpaper), `"top"` (above windows), `"overlay"` |
| `autoHideWhenPaused` | bool | `true` | Hide smoothly when paused/stopped (`false` keeps the widget visible) |
| `showLyrics` | bool | `true` | Show the right-hand synced lyrics column (`false` = compact single-column player) |
| `wave.wavelength` | float | `38.0` | Wavy scrubber crest length in pixels (larger = softer/wider waves) |
| `wave.amplitude` | float | `3.6` | Wavy scrubber height in pixels |
| `fonts.sans` | string | `"Roboto Flex"` | UI font family |
| `fonts.icons` | string | `"Material Symbols Rounded"` | Icon font family |
| `colorsFile` | string | `""` | Optional path to external Matugen/Quickshell `colors.json` (e.g. `"~/.config/quickshell/colors.json"`) |
| `theme` | object | Lavender dark | Built-in Material 3 color palette (used when `colorsFile` is empty) |

### Switching Color Presets
Copy the contents of any file in `presets/` (`lavender.json`, `blue.json`, `forest-light.json`, `peach.json`) into the `"theme"` block of `config.json`, or set `"colorsFile": "~/.config/quickshell/colors.json"` to follow your live `matugen` palette automatically.

---

## License
MIT
