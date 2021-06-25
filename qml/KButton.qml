import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: control
    opacity: enabled? 1 : 0.3
    antialiasing: true
    smooth: true

    property alias text : labelText.text
    property alias font : labelText.font
    property alias textColor: labelText.color

    property real horizontalPadding : 10
    property color backgroundColor : "#EFEFEF"
    property alias radius : background.radius
    property alias border : background.border

    property alias hoverEnabled : mouseArea.hoverEnabled

    property bool animationEnabled : true

    signal pressed()

    Rectangle {
        id: background
        anchors.fill: parent
        color: _.backgroundColorAlias

        radius: 3
        border{
            width: 0
            color: "transparent"
        }
        antialiasing: true
        smooth: true

        Text {
            id: labelText
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#fff"
            leftPadding: control.horizontalPadding
            rightPadding: control.horizontalPadding
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onPressed: {
                //control.pressed()
                if (animationEnabled) {
                    animator.enter()
                }
            }
            onClicked: {
                control.pressed()
            }

            onReleased: {
                if (animationEnabled) {
                    animator.exit()
                }
            }

            onHoveredChanged: {
                _.backgroundColorAlias = control.enabled && containsMouse? Qt.lighter(control.backgroundColor, 1.2) : control.backgroundColor
                labelText.color = control.enabled && containsMouse? Qt.lighter(control.textColor, 1.2) : control.textColor
            }
        }
    }

    DropShadow {
        anchors.fill: background
        horizontalOffset: 2
        verticalOffset: 2
        radius: 4.0
        samples: 17
        color: "#20000000"
        spread: 0.0
        source: background
        enabled: control.enabled
    }

    ButtonPressAnimation {
        id: animator
        target: control
    }

    onBackgroundColorChanged: {
        _.backgroundColorAlias = backgroundColor
    }

    Item {
        id: _
        property color backgroundColorAlias : backgroundColor
    }

}
