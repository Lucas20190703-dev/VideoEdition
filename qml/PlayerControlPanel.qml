import QtQuick 2.12
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.12

Rectangle {
    id: control
    color: "transparent"

    property int currentTime : 0  //in millisec
    property int endTime : 0
    property bool isPlaying : false
    property bool loaded: false

    property bool hasNext: false
    property bool hasPrev: false

    signal play
    signal pause
    signal stop
    signal loopsChanged(var loops)
    signal next
    signal prev

    signal forward
    signal rewind


    Rectangle {
        id: background
        anchors.fill: parent
        radius: 4
        gradient : Gradient {
            GradientStop { position: 0.0; color: "#00000000" }
            GradientStop { position: 0.1; color: "#25000000" }
            GradientStop { position: 0.5; color: "#40000000" }
            GradientStop { position: 0.6; color: "#45000000" }
            GradientStop { position: 0.8; color: "#50000000" }
            GradientStop { position: 1.0; color: "#60000000" }
        }
    }

    DropShadow {
        anchors.fill: control
        horizontalOffset: 2
        verticalOffset: 2
        radius: 4.0
        samples: 17
        color: "#40000000"
        spread: 0.0
        source: background
        enabled: control.enabled
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5
        RowLayout {
            id: sliderRect
            Layout.fillWidth: true
            Layout.preferredHeight: elapsedTime.height
            spacing: 2
            Text {
                id: elapsedTime
                Layout.alignment: Qt.AlignVCenter
                text: _.timeString(currentTime)
                color: "white"
            }

            KSlider {
                id: timeSlider
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter

                from: 0
                to : Math.floor(endTime / 1000)
                stepSize: 1
                value: Math.floor(currentTime / 1000)
            }

            Text {
                id: totalTime
                Layout.alignment: Qt.AlignVCenter
                text: _.timeString(endTime)
                color: "white"
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 20

            KIconButton {
                id: playButton
                Layout.fillHeight: true
                Layout.preferredWidth: height
                source: isPlaying? "qrc:/resources/pause.png" : "qrc:/resources/play.png"
                padding: 15
                onClicked: {
                    isPlaying = !isPlaying
                    if (isPlaying) control.play()
                    else control.pause()
                }
            }

            RowLayout {
                Layout.fillHeight: true
                spacing: 3
                KIconButton {
                    id: prevButton
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
                    source: "qrc:/resources/backward.png"
                    padding: 18
                    onClicked: {
                        control.rewind()
                    }
                }

                KIconButton {
                    id: stopButton
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
                    source: "qrc:/resources/stop.png"
                    padding: 18
                    onClicked: {
                        control.stop()
                        isPlaying = false
                    }
                }

                KIconButton {
                    id: forwardButton
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
                    source: "qrc:/resources/forward.png"
                    padding: 18
                    onClicked: {
                        control.forward()
                    }
                }
            }
        }
    }



    QtObject{
        id: _
        function timeString(t) {
            let secs = Math.round(t / 1000)

            var h = Math.floor(secs / 3600)
            var m = Math.floor((secs - h * 3600) / 60)
            var s = secs - h * 3600 - m * 60
            var str = ""
            if (h < 10) str += '0' + h
            else str += h

            str += ":"
            if (m < 10) str += '0' + m
            else str += m

            str += ":"
            if (s < 10) str += '0' + s
            else str += s
            return str
        }
    }
}
