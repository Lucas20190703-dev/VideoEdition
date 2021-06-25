import QtQuick 2.0
import QtQuick.Controls 2.12
import QtMultimedia 5.12

Rectangle {
    id: control
    property alias source : video.source
    property alias volume : video.volume

    color: "black"

    MouseArea {
        anchors.fill: parent
        onPressed: {
            if (playControl.opacity === 1.0) {
                playControl.opacity = 0.0

            } else {
                playControl.opacity = 1.0

            }
        }
    }

    Video {
        id: video
        anchors.fill: parent
        flushMode: VideoOutput.LastFrame
        clip: true
        onDurationChanged: {
            playControl.endTime = duration
        }

        onPositionChanged: {
            playControl.currentTime = position
        }

    }

    PlayerControlPanel {
        id: playControl
        width: parent.width
        height: _.controlHeight
        anchors.bottom: parent.bottom
        z: 1
        isPlaying : video.playbackState === MediaPlayer.PlayingState

        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }

        onPause: {
            video.pause()
        }

        onPlay: {
            video.play()
        }

        onStop: {
            video.stop()
        }

    }

    Timer {
        id: controlHideTimer
        running: false
        interval: 10000
        repeat: false
        onTriggered: {
            playControl.opacity = 0            
        }
    }

    function play() {
        video.play()
        playControl.isPlaying = true
    }

    function stop() {
        video.stop()
        playControl.isPlaying = false
    }

    function pause() {
        video.pause()
        playControl.isPlaying = false
    }

    function getCurrentTime() {
        return video.position
    }

    QtObject {
        id: _
        property bool showControl : true

        readonly property real controlHeight : 80
        readonly property real topControlHeight : 50
    }
}
