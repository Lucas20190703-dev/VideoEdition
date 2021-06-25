import QtQuick 2.12
import QtQuick.Dialogs 1.2

Rectangle {
    color: "#ccc"
    implicitWidth: 200

    signal selectedFile(var fileUrl)


    Column {
        anchors {
            fill: parent
            topMargin: 50
            leftMargin: 20
            rightMargin: 20

        }
        spacing: 30

        Rectangle {
            id: projectName
            width: parent.width
            height: 40
            color: "transparent"
            border {
                width: 2
                color: "#111"
            }
            Text {
                anchors.centerIn: parent
                text: qsTr("New Project")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                    projectName.color = containsMouse? "#DDD" : "transparent"
                }
            }
        }

        Rectangle {
            id: addVideo
            width: parent.width
            height: 40
            color: "transparent"
            border {
                width: 2
                color: "#111"
            }
            Text {
                anchors.centerIn: parent
                text: qsTr("Add video")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                    addVideo.color = containsMouse? "#DDD" : "transparent"
                }
                onClicked: {
                    openFile.open();
                }
            }
        }

        Rectangle {
            id: destination
            width: parent.width
            height: 40
            color: "transparent"
            border {
                width: 2
                color: "#111"
            }
            Text {
                anchors.centerIn: parent
                text: qsTr("Desitniation folder")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                    destination.color = containsMouse? "#DDD" : "transparent"
                }
                onClicked: {
                    openFolder.open();
                }
            }
        }
    }

    FileDialog {
        id: openFolder
        title : "Please choose folder"
        folder: shortcuts.home
        selectFolder: true

        onAccepted: {
            console.log(JSON.stringify(folder))

        }

        onRejected: {

        }

        Component.onCompleted: visible = false
    }

    FileDialog {
        id: openFile
        title : "Please choose video file"
        folder: shortcuts.home
        selectMultiple: false
        nameFilters: ["Video Files (*.avi, *.mpg)", "All Files (*.*)"]
        onAccepted: {
            console.log(JSON.stringify(fileUrl))
            selectedFile(fileUrl);
        }

        Component.onCompleted: visible = false
    }

    QtObject {
        id: _

    }
}
