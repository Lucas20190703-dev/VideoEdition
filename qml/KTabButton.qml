import QtQuick 2.0
import QtQuick.Controls 2.12

TabButton {
    id: control
    property bool selected : false

    contentItem: Text {
        id: title
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: control.text
        font.pixelSize: selected? 13: 12
        font.bold: selected
        elide: Text.ElideRight
    }

    background: Rectangle {

        radius: 2
        color: "#ccc"

        Rectangle {
            width : parent.width
            height : parent.radius + 1
            anchors {
                bottom: parent.bottom
            }
            color: parent.color
        }
    }
}


