import QtQuick 2.12

Rectangle {
    id: control
    color: "transparent"

    implicitWidth: 40
    implicitHeight: 40

    property alias source : icon.source
    property color tint : "#ffffff"

    property bool active : true
    property bool animatable : true

    property alias padding : icon.anchors.margins

    signal clicked

    QtObject {
        id: _
        readonly property real iconNormalScale : 1.0
        readonly property real iconLargeScale : 1.1
        readonly property real iconSmallScale : 0.9
    }

    KIcon {
        id: icon
        anchors.fill: parent
        anchors.margins: 5
        tint: control.active? control.tint : Qt.darker(control.tint, 1.2)
        opacity: control.enabled? 1.0 : 0.3

        Behavior on scale {
            NumberAnimation {
                duration: 100
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: control.active
        hoverEnabled: true

        onPressed: {
            icon.scale = _.iconSmallScale
        }

        onClicked: {
            if (containsMouse) {
                control.clicked()
            }
        }

        onReleased: {
            icon.scale = _.iconNormalScale
        }
    }
}
