import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Stack")

//    MonitoringData {
//        id: backend
//        onStatusChanged: {
//            serverTestPage.textArea.append(serverTestPage.addMsg(newStatus));
//            if (currentStatus !== true)
//            {
//                btn_connect.enabled = true;
//            }
//        }
//        onNetworkError: {
//            textArea.append(addMsg("Error! " + err));
//            if (currentStatus !== true)
//            {
//                backend.disconnectClicked();
//            }
//            btn_connect.enabled = true;
//        }
//    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: 100
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1")
                width: parent.width
                onClicked: {
                    stackView.push("Page1.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2")
                width: parent.width
                onClicked: {
                    stackView.push("Page2.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                id: serverTestPage
                text: qsTr("Server Test")
                width: parent.width
                onClicked: {
                    stackView.push("ServerTest.qml")
                    drawer.close()
                }
            }

        }
    }

    StackView {
        id: stackView
        initialItem: "Home.qml"
        anchors.fill: parent

    }
}
