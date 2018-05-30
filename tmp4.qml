import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 600
    height: 400

    property alias textArea: textArea

    title: qsTr("Server Test")

    RowLayout {
        id: topBtns
        x: 116
        y: 5

        Button {
            id: btn_connect
            text: "CONNECT"
            Layout.preferredHeight: 48
            Layout.preferredWidth: 133
            spacing: 0
            Material.background: btn_connect.enabled ? !backend.currentStatus ? "#78C37F" : "#87DB8D" : "gray"
            onClicked: {

                textArea.append(addMsg("Connecting to server..."));
                backend.connectClicked();
                this.enabled = false;
            }
        }

        Button {
            id: btn_disconnect
            enabled: !btn_connect.enabled
            text: "DISCONNECT"
            Layout.preferredWidth: 133
            Material.background: enabled ? this.down ? "#DB7A74" : "#FF7E79" : "gray"
            onClicked: {
                textArea.append(addMsg("Disconnecting from server..."));
                backend.disconnectClicked();
                btn_connect.enabled = true;
            }
        }

        Text {
            id: status
            text: backend.currentStatus ? "CONNECTED" : "DISCONNECTED"
            font.weight: Font.Bold
        }
    }

    RowLayout {
        id: bottomSB
        x: 59
        y: 340
        width: 514
        height: 48

        TextField {
            id: textField
            width: 400
            color: "#fce94f"
            text: qsTr("Text Field")
            Layout.fillWidth: true
            selectByMouse: true
        }

        Button {
            id: btn_send
            enabled: !btn_connect.enabled
            text: "Send"
            Material.background: enabled ? this.down ? "#6FA3D2" : "#7DB7E9" : "gray"
            onClicked: {
                textArea.append(addMsg("Sending message..."));
                backend.sendClicked(textField.text);
            }
        }

    }
    ScrollView {
        id: scrollView
        anchors.top: topBtns.bottom
        anchors.right: parent.right
        anchors.bottom: bottomSB.top
        anchors.left: parent.left
        anchors.topMargin: 0

        TextArea {
            id: textArea
            clip: true
            font.pointSize: 8
            anchors.fill: parent
            wrapMode: Text.WrapAnywhere
            leftPadding: 6
            rightPadding: 6
            topPadding: 10
            bottomPadding: 10
//            background: null
        }
    }

    Component.onCompleted: {
        textArea.text = addMsg("Application started\n- - - - - -", false);
    }

    function addMsg(someText)
    {
        return "[" + currentTime() + "] " + someText;
    }

    function currentTime()
    {
        var now = new Date();
        var nowString = ("0" + now.getHours()).slice(-2) + ":"
                + ("0" + now.getMinutes()).slice(-2) + ":"
                + ("0" + now.getSeconds()).slice(-2);
        return nowString;
    }
}
