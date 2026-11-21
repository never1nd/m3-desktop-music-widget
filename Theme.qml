pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string mode: "dark"
    property string fontSans: Config.fontSans
    property string fontIcons: Config.fontIcons

    property color primary: "#d0bdfd"
    property color fgPrimary: "#36275c"
    property color primaryContainer: "#594981"
    property color fgPrimaryContainer: "#f9f1ff"

    property color secondary: "#ccc2de"
    property color fgSecondary: "#332d43"
    property color secondaryContainer: "#4f485f"
    property color fgSecondaryContainer: "#eee3ff"

    property color tertiary: "#fdb0d4"
    property color fgTertiary: "#521d3b"
    property color tertiaryContainer: "#7a3f5e"
    property color fgTertiaryContainer: "#fff1f4"

    property color surface: "#141317"
    property color surfaceContainerLowest: "#0f0e11"
    property color surfaceContainerLow: "#1c1b1f"
    property color surfaceContainer: "#211f23"
    property color surfaceContainerHigh: "#2b292d"
    property color surfaceContainerHighest: "#363438"

    property color fgSurface: "#e6e1e6"
    property color fgSurfaceVariant: "#cac4d0"
    property color outline: "#948f9a"
    property color outlineVariant: "#49454f"

    function alpha(c, a) {
        return Qt.rgba(c.r, c.g, c.b, a)
    }

    function applyPalette(d) {
        if (!d) return
        if (d._mode || d.mode) mode = d._mode || d.mode
        if (d.primary) primary = d.primary
        if (d.on_primary) fgPrimary = d.on_primary
        if (d.primary_container) primaryContainer = d.primary_container
        if (d.on_primary_container) fgPrimaryContainer = d.on_primary_container
        if (d.secondary) secondary = d.secondary
        if (d.on_secondary) fgSecondary = d.on_secondary
        if (d.secondary_container) secondaryContainer = d.secondary_container
        if (d.on_secondary_container) fgSecondaryContainer = d.on_secondary_container
        if (d.tertiary) tertiary = d.tertiary
        if (d.on_tertiary) fgTertiary = d.on_tertiary
        if (d.tertiary_container) tertiaryContainer = d.tertiary_container
        if (d.on_tertiary_container) fgTertiaryContainer = d.on_tertiary_container
        if (d.surface) surface = d.surface
        if (d.surface_container_lowest) surfaceContainerLowest = d.surface_container_lowest
        if (d.surface_container_low) surfaceContainerLow = d.surface_container_low
        if (d.surface_container) surfaceContainer = d.surface_container
        if (d.surface_container_high) surfaceContainerHigh = d.surface_container_high
        if (d.surface_container_highest) surfaceContainerHighest = d.surface_container_highest
        if (d.on_surface) fgSurface = d.on_surface
        if (d.on_surface_variant) fgSurfaceVariant = d.on_surface_variant
        if (d.outline) outline = d.outline
        if (d.outline_variant) outlineVariant = d.outline_variant
    }

    Connections {
        target: Config
        function onInlineThemeChanged() {
            if (!Config.colorsFile || Config.colorsFile === "") {
                root.applyPalette(Config.inlineTheme)
            }
        }
    }

    FileView {
        id: extColors
        path: Config.colorsFile !== "" ? Config.colorsFile.replace(/^~/, Quickshell.env("HOME")) : ""
        watchChanges: Config.colorsFile !== ""
        onLoaded: {
            try { root.applyPalette(JSON.parse(text())) } catch (e) {}
        }
        onFileChanged: reload()
    }
}
