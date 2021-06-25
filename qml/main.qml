import QtQuick 2.12
import QtQuick.Window 2.12

import QtQuick.Layouts 1.12

Window {
    width: 780
    height: 560
    visible: true
    title: qsTr("VideoEdition")
    color: "#ddd"

    property var dataModel : dataModel_
    RowLayout {
        anchors.fill: parent
        spacing: 2
        LeftDrawer {
            Layout.preferredWidth: Math.max(parent.width * 0.25 , 200)
            Layout.fillHeight: true

            onSelectedFile: {
                mainView.setVideoSource(fileUrl)
            }
        }

        MainView {
            id: mainView
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    DataModel {
        id: dataModel_
    }
}
