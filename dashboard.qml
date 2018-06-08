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
    width: 1010
    height: 740
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    title: qsTr("Мониторинг оборудования объектов")

    //Константы
    readonly property color normalMetricColor: "#59FA21"
    readonly property color warningMetricColor: "yellow"
    readonly property color criticalMetricColor: "#FF0300"
    readonly property int normalMetricTop: 50
    readonly property int warningMetricTop: 79
    readonly property color toolBarColor: "black"
    readonly property color widgetBgColor: "#323232"
    //⚙
    header: ToolBar {
        contentHeight: 40
        Material.primary: toolBarColor
        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "◄" : "⌂"
            font.pixelSize: 20
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
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
        initialItem: Groups { }
        anchors.fill: parent
    }


    footer: ToolBar {
        contentHeight: 55
        Material.primary: "black"


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



    Popup {
        property alias errStr: errText.text
        id: errorDialog
        x: parent.width/2-width/2
        y: parent.height/2-height/2
        width: 300
        height: 180
        modal: true
        focus: true
        Text {
            id: capiton
            font.bold: true
            color: "red"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "ОШИБКА"
        }

        Text {
            color: "white"
            id: errText
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: capiton.bottom
            anchors.topMargin: 10
            wrapMode: Text.WordWrap
        }

        Button {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            text: "ОК"
            onClicked: errorDialog.close()
        }

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }

    Connections {
        target: backend?backend:null
        onError:  {
            console.log(err);
            errorDialog.errStr =  err;
            errorDialog.open();
        }
    }

}
