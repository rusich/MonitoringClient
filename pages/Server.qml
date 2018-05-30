import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"

Page {
    anchors.fill: parent

    title: qsTr("Server")

    Label {
        text: hosts.server.ip
        anchors.centerIn: parent
    }

    CpuUsage {
        x: 77
        y: 58
        width: 182
        height: 184
        host: hosts.server
    }

    CpuUsage {
        x: 324
        y: 58
        width: 117
        height: 119
        host: hosts.darkstar
    }
}
