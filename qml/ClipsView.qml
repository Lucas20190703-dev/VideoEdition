import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {
    color: "transparent"
    border {
        color : "gray"
        width : 1
    }

    ListView {
        id: listview
        anchors.fill: parent
        clip: true
        focus: true
        model : dataModel.clipsListModel
        delegate: clipDelegate
    }

    Component {
        id: clipDelegate
        Rectangle {
            id: delegateItem
            width : listview.width
            height : 100
            color: "transparent"
            property int dimensionId : -1
            Rectangle {
                anchors {
                    fill: parent
                    leftMargin: 5
                    rightMargin: 5
                    topMargin: 5
                }
                border {
                    width: 1
                    color: "lightgray"
                }

                RowLayout {
                    anchors {
                        fill: parent
                        margins: 5
                    }
                    spacing: 10
                    Rectangle {
                        color: "lightgray"
                        Layout.fillHeight: true
                        Layout.preferredWidth: height * 1.2
                    }

                    Row {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 10
                        Repeater {
                            model: dimentionListModel
                            Rectangle {
                                height: parent.height * 0.3
                                width : height * model.width / model.height
                                anchors.verticalCenter: parent.verticalCenter
                                color : "lightgray"
                                border {
                                    width : delegateItem.dimensionId === index ? 2 : 0
                                    color : "green"
                                }

                                Text {
                                    anchors.fill : parent
                                    text: `${model.width}x${model.height}`
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        delegateItem.dimensionId = index
                                    }
                                }
                            }
                        }
                    }

                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.preferredWidth: 60
                        Layout.margins: 10
                        KButton {
                            Layout.fillHeight: true
                            Layout.preferredWidth: 60
                            backgroundColor: "green"
                            textColor: "white"
                            text: qsTr("Preview")
                        }
                        KButton {
                            Layout.fillHeight: true
                            Layout.preferredWidth: 60
                            backgroundColor: "green"
                            textColor: "white"
                            text: qsTr("Export")
                        }
                    }
                }
            }
        }
    }


    ListModel {
        id: dimentionListModel
        ListElement { width : 1; height: 1}
        ListElement { width : 3; height: 4}
        ListElement { width : 9; height: 6}
        ListElement { width : 16; height: 9}
    }

    QtObject {
        id: _

    }
}
