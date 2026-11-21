#!/usr/bin/env bash
set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DST="$HOME/.config/quickshell/m3-music-widget"
BIN="$HOME/.local/bin/m3-music-widget"

mkdir -p "$DST" "$HOME/.local/bin"
cp -a "$SRC/." "$DST/"
rm -rf "$DST/.git"
chmod +x "$DST/scripts/m3-lyrics-fetch"

cat > "$BIN" <<EOF
#!/usr/bin/env bash
exec qs -p "$DST/shell.qml" "\$@"
EOF
chmod +x "$BIN"

echo "Installed to: $DST"
echo "Run with:     $BIN"
echo "Configure:    $DST/config.json"
