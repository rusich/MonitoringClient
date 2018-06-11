import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import "qrc:/widgets"
import "qrc:/pages"
import MonitoringClient.Settings 1.0

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

        Image {
            id: userPic
            source: "qrc:/images/user.png"
            anchors.right: fullName.left
            anchors.rightMargin: 5
            anchors.verticalCenter: fullName.verticalCenter
            width: 25
            height: width
            smooth: true
            visible: fullName.text.length>0? true: false

        }

        Label {
            id: fullName
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 14
            anchors.rightMargin: 10
            text: backend.authorizedUserName
            font.pixelSize: 15
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
            anchors.fill: parent
            ToolButton {
                id: toolButton2
                Layout.alignment: Qt.AlignLeft
                contentItem: Text {
                    text: "⦿"
                    anchors.centerIn: parent
                    font.pixelSize: Qt.application.font.pixelSize * 2.6
                    color: backend.currentStatus? "red" : "green"
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
                Layout.alignment: Qt.AlignLeft
                text: backend.currentStatus ? "Подключен к " + Settings.serverHostname
                                              + ":"+ Settings.serverPort
                                            : "Не в сети"
                color: backend.currentStatus? normalMetricColor: "red"
                font.weight: Font.Bold
                anchors.left: toolButton2.right
            }

            Text {
                id: curTime
                Layout.alignment: Qt.AlignRight
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: netIO.left
                anchors.rightMargin: 10
                color: "#c6c6c6"
                font.bold: true
                font.pixelSize: 20
                text: Qt.formatDateTime(new Date(), "dd/MM/yyyy hh:mm:ss")

                Timer {
                    interval: 1000; running: true; repeat: true
                    onTriggered: curTime.text = Qt.formatDateTime(new Date(),
                                                                  "dd/MM/yyyy hh:mm:ss")
                }
            }

            NetInOut {
                id: netIO
                Layout.alignment: Qt.AlignRight
                anchors.topMargin: 10
                anchors.top: parent.top
                anchors.right: settingsBtn.left
            }

            ToolButton {
                id: settingsBtn
                anchors.right: parent.right
                text: "⚙"
                font.pixelSize: 30
                onClicked: {
                    settingsDialog.open();
                }
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
            id: errorCaption
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
            anchors.top: errorCaption.bottom
            anchors.topMargin: 10
            wrapMode: Text.WordWrap
        }

        Button {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            text: "ОК"
            onClicked: errorDialog.close()
        }

        closePolicy: Popup.CloseOnEscape
    }

    Popup {
        id: settingsDialog
        x: parent.width/2-width/2
        y: parent.height/2-height/2
        width: 300
        height: 400
        modal: true
        focus: true
        Text {
            id: settingsCapiton
            font.bold: true
            color: "yellow"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Настройки"
        }

        GridLayout {
            columns: 2
            anchors.fill: parent
            anchors.margins: 10
            rowSpacing: 10
            columnSpacing: 10

            Label {
                text: "Сервер"
            }
            TextField {
                id: server
                text: Settings.serverHostname
                Layout.fillWidth: true
            }
            Label {
                text: "Порт"
            }
            TextField {
                id: port
                text: Settings.serverPort
                Layout.fillWidth: true
            }
            Label {
                text: "Пользователь"
            }
            TextField {
                id: username
                text: Settings.username
                Layout.fillWidth: true
            }
            Label {
                text: "Пароль"
            }
            TextField {
                id: password
                text: Settings.password
                echoMode: TextInput.Password
                Layout.fillWidth: true
            }
            Label {
                text: "Обновление (мс)"
            }
            TextField {
                id: updateinterval
                text: Settings.updateInterval
                Layout.fillWidth: true
            }

            Button {
                id: saveSettings
                text: "Сохранить"
                Material.background: "#12b712"
                Layout.fillWidth: true
                onClicked: {
                    Settings.serverHostname = server.text;
                    Settings.serverPort = port.text;
                    Settings.username = username.text;
                    Settings.password = password.text;
                    Settings.updateInterval = updateinterval.text;
                    settingsDialog.close();
                }
            }
            Button {
                id: cancelSaveSattings
                text: "Отмена"
                Layout.fillWidth: true
                onClicked: {
                    settingsDialog.close();
                }
            }

        }

        closePolicy: Popup.CloseOnEscape
    }

    Connections {
        target: backend?backend:null
        onError:  {
            console.log(err);
            errorDialog.errStr =  err;
            errorDialog.open();
        } 
        onStatusChanged: {
            if(!backend.currentStatus){
                while(stackView.depth>1)
                    stackView.pop();
            }

        }
    }

}
