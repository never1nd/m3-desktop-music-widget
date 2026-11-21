pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: cfg

    property string position: "top-right"
    property int marginTop: 52
    property int marginRight: 40
    property int marginBottom: 40
    property int marginLeft: 40
    property int widgetWidth: 880
    property int widgetHeight: 488
    property int cardRadius: 28
    property real cardOpacity: 0.90
    property string layer: "bottom"
    property bool autoHideWhenPaused: false
    property bool showLyrics: true
    property real wavelength: 38.0
    property real waveAmp: 3.6
    property string fontSans: "Roboto Flex"
    property string fontIcons: "Material Symbols Rounded"
    property string colorsFile: ""
    property var inlineTheme: ({})

    function applyConfig(raw) {
        if (!raw || raw.trim() === "") return
        try {
            const d = JSON.parse(raw)
            if (d.position) position = d.position
            if (d.margins) {
                if (d.margins.top !== undefined) marginTop = d.margins.top
                if (d.margins.right !== undefined) marginRight = d.margins.right
                if (d.margins.bottom !== undefined) marginBottom = d.margins.bottom
                if (d.margins.left !== undefined) marginLeft = d.margins.left
            }
            if (d.width !== undefined) widgetWidth = d.width
            if (d.height !== undefined) widgetHeight = d.height
            if (d.radius !== undefined) cardRadius = d.radius
            if (d.opacity !== undefined) cardOpacity = d.opacity
            if (d.layer) layer = d.layer
            if (d.autoHideWhenPaused !== undefined) autoHideWhenPaused = !!d.autoHideWhenPaused
            if (d.showLyrics !== undefined) showLyrics = !!d.showLyrics
            if (d.wave) {
                if (d.wave.wavelength !== undefined) wavelength = d.wave.wavelength
                if (d.wave.amplitude !== undefined) waveAmp = d.wave.amplitude
            }
            if (d.fonts) {
                if (d.fonts.sans) fontSans = d.fonts.sans
                if (d.fonts.icons) fontIcons = d.fonts.icons
            }
            if (d.colorsFile !== undefined) colorsFile = d.colorsFile || ""
            if (d.theme) inlineTheme = d.theme
        } catch (e) {
            console.warn("Config.qml parse error:", e)
        }
    }

    FileView {
        id: cfgFile
        path: Quickshell.shellDir + "/config.json"
        watchChanges: true
        onLoaded: cfg.applyConfig(text())
        onFileChanged: reload()
    }
}
