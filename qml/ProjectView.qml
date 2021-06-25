import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12

import "utils.js" as Utils

ColumnLayout {
    spacing: 2
    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true
        border {
            width: 1
            color: "gray"
        }

        PlayView {
            id: playerView
            anchors.fill: parent
        }

    }

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 90
        border {
            width: 1
            color: "gray"
        }

        Rectangle {
            id: controlPanel
            anchors {
                fill: parent
                margins: 12
            }
            TextField {
                id: clipNameInput
                width: Math.max(parent.width * 0.5, 200)
                height: 30
                anchors {
                    top: parent.top
                    left: parent.left
                }

                placeholderText: qsTr("Name of Clip")
                onTextChanged: {
                    _.updateClipping();
                }
            }

            KButton {
                id: startButton
                width: 60
                height: _.buttonHeight
                anchors {
                    left: parent.left
                    bottom: parent.bottom
                }
                enabled: !_.isStarted
                text: qsTr("Start")
                backgroundColor: "lightgray"
                textColor: "black"
                onPressed: {
                    if (_.isLoaded) {
                        _.isStarted = true
                        _.startTime = playerView.getCurrentTime();
                        _.updateDescription()
                    }
                }
            }

            KButton {
                id: endButton
                width: 60
                height: _.buttonHeight
                anchors {
                    left: startButton.right
                    leftMargin: 6
                    bottom: parent.bottom
                }
                enabled: _.isStarted && !_.isEnded
                text: qsTr("End")
                backgroundColor: "lightgray"
                textColor: "black"
                onPressed: {
                    if (_.isLoaded) {
                        _.endTime = playerView.getCurrentTime();
                        _.isEnded = true
                        _.updateClipping()
                        _.updateDescription()
                    }
                }
            }

            KButton {
                id: resetButton
                width: 60
                height: _.buttonHeight
                anchors {
                    left: endButton.right
                    leftMargin: 6
                    bottom: parent.bottom
                }
                text: qsTr("Reset")
                enabled: _.isStarted
                backgroundColor: "lightgray"
                textColor: "black"
                onPressed: {
                    _.reset()
                }
            }

            Text {
                id: clipDescription
                anchors{
                    left: resetButton.right
                    right: addClipButton.left
                    leftMargin: 20
                    rightMargin: 20
                    bottom: parent.bottom
                }
                text: _.description
            }

            KButton {
                id: addClipButton
                width: 100
                height: _.buttonHeight
                anchors {
                    right: parent.right
                    bottom: parent.bottom
                }
                text: qsTr("Add Clip")
                backgroundColor: "green"
                enabled: _.isReadyClipping

                onPressed: {
                    _.reset()
                    //TODO add cliping
                    dataModel.clipsListModel += 1
                }
            }
        }
    }

    QtObject {
        id: _
        readonly property real buttonHeight : 26

        property bool isStarted : false
        property bool isEnded : false

        property bool isReadyClipping : false

        property bool isLoaded : false

        property int startTime : -1
        property int endTime : -1

        property string description : ""

        function updateClipping() {
            if (clipNameInput.text &&
                    clipNameInput.text.length > 0 &&
                    startTime > 0 &&
                    endTime > 0 &&
                    endTime > startTime) {
                isReadyClipping = true;
            } else {
                isReadyClipping = false;
            }
        }

        function updateDescription() {
            var descriptionStr = "";
            if (startTime < 0) {
                descriptionStr = "";
            } else {
                descriptionStr = Utils.timeStringFromMilliSeconds(startTime) + " - "
            }

            if (endTime > 0 && endTime > startTime) {
                descriptionStr += Utils.timeStringFromMilliSeconds(endTime)
            }
            description = descriptionStr;
        }

        function reset() {
            _.isStarted = false
            _.isEnded = false
            _.startTime = -1
            _.endTime = -1
            description = "";
            clipNameInput.text = "";
        }
    }

    function openVideo(fileUrl, isAutoPlay) {
        if (playerView.playbackState === MediaPlayer.PlayingState) {
            playerView.stop();
        }        
        playerView.source = fileUrl
        playerView.play()
        _.reset()
        _.isLoaded = true
    }
}
