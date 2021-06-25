import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
    color: "transparent"
    ColumnLayout {
        anchors {
            fill: parent
            topMargin: 6
            bottomMargin: 6
            leftMargin: 4
            rightMargin: 6
        }
        spacing: 0

        TabBar {
            id: bar
            background: Rectangle {
                color: "transparent"
            }
            KTabButton {
                text: "New Project"
                width: 120
                selected: bar.currentIndex === 0
            }

            KTabButton {
                text: "Clips"
                width: 120
                selected: bar.currentIndex === 1
            }
        }

        StackLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            currentIndex: bar.currentIndex
            ProjectView {
                id: projectTab
            }

            ClipsView {
                id: clipsTab
            }
        }
    }

    function setVideoSource(fileUrl) {
        projectTab.openVideo(fileUrl, bar.currentIndex === 0)
    }
}
