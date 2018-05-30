import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    property alias bgcolor: bg.color
    property string caption
    width: 100
    height: 100
    Rectangle  {
        id: bg
        property color bgcolor: "#052433"
        anchors.fill: parent
        color: bgcolor
        radius: 4
        border.color: "#ebebeb"
        border.width: 1
        //        border.color: "white"
//        border.width: 0.6
    }

    MouseArea {
        id: ma
        enabled: true
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            console.log(JSON.stringify(host.system_cpu_util_idle));
        }
        onEntered: {
            bg.color = "red"
        }
        onExited:  {
            bg.color = bg.bgcolor
        }

    }

    Label {
        id: label
        text: parent.caption
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
    }
}
