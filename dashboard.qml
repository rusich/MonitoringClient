import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import "qrc:/widgets"
import "qrc:/pages"

ApplicationWindow {
    id: window
    visible: true
    width: 1200
    height: 800
    title: qsTr("Мониторинг оборудования")

    //Константы
    property color normalMetricColor: "#59FA21"
    property color warningMetricColor: "yellow"
    property color criticalMetricColor: "#FF0300"
    property int normalMetricTop: 50
    property int warningMetricTop: 70

    header: ToolBar {
        contentHeight: toolButton.implicitHeight
        Material.primary: "#1B2033"
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


    StackView {
        id: stackView
        initialItem: Server { host: hosts.server }
        anchors.fill: parent
    }

    footer: ToolBar {
        contentHeight: toolButton2.implicitHeight
        Material.primary: "#1B2033"

        RowLayout {
            Layout.leftMargin: 10
            ToolButton {
                id: toolButton2
                contentItem: Text {
                    text: "⦿"
                    font.pixelSize: Qt.application.font.pixelSize * 2.6
                    color: backend.currentStatus? "red" : "green"
                    anchors.centerIn: parent
                }
                onClicked: {
                    if (backend.currentStatus) {
                        backend.disconnectClicked();
                    } else {
                        backend.connectClicked();
                    }
                }
            }

            Label {
                id: status
                text: backend.currentStatus ? "CONNECTED" : "DISCONNECTED"
                color: backend.currentStatus? "green" : "red"
                font.weight: Font.Bold
                //                anchors.verticalCenter: parent.verticalCenter
                //                anchors.left: parent.left
            }
        }


    }

    Label {
        id: label
        x: 162
        y: 631
        text: "⬉"
        font.family: "Verdana"
        fontSizeMode: Text.FixedSize
    }

    MessageDialog {
        id: errorDialog
        title: "Network error"
        onAccepted: {
        }
    }

    Connections {
        target: backend?backend:null
        onNetworkError:  {
            console.log(err);
            errorDialog.text =  err;
            errorDialog.open();
        }
    }

}
