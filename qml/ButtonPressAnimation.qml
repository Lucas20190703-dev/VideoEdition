import QtQuick 2.0

Item {
    id: control
    property var target

    NumberAnimation {
        id: enterAnim
        target: control.target
        property: "scale"
        from: 1.0
        to : 0.97
        duration: 100
        easing.type: Easing.InOutQuad
    }

    NumberAnimation {
        id: exitAnim
        target: control.target
        property: "scale"
        from: 0.97
        to : 1.0
        duration: 100
        easing.type: Easing.InOutQuad
    }

    function enter() {
        enterAnim.start();
    }

    function exit() {
        exitAnim.start();
    }
}

