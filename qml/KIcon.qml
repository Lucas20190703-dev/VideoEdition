import QtQuick 2.12
import QtGraphicalEffects 1.12


Item {
    id: control
    property alias source: icon.source
    property color tint: "#ffffff"
    Image {
        id: icon
        anchors.fill: parent
        antialiasing: true
        smooth: true
        fillMode: Image.PreserveAspectFit
    }
    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: control.tint
    }
}
