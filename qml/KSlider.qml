import QtQuick 2.12
import QtQuick.Controls 2.12


Slider {
    id: control
    property real handleWidth: 12
    property real handleHeight : 12
    property real backgroundHeight: 4
    property color handleColor : "steelblue"
    property color backgroundColor : "#96a0aa"
    property color chunkColor : "steelblue"

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        width: control.availableWidth - control.handleWidth
        height: backgroundHeight
        anchors.centerIn: parent
        radius: backgroundHeight / 2
        color: control.backgroundColor
        opacity: control.enabled? 1.0 : 0.3

        Rectangle {
           width: control.visualPosition * parent.width
           height: parent.height
           color: control.chunkColor
           radius: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: handleWidth
        implicitHeight: handleHeight
        radius: handleWidth / 2
        color: control.handleColor
        opacity: 1.0
    }
}
