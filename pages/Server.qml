import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"

Page {
    property variant host
    anchors.fill: parent

    title: host.name

    Label {
        text: host.ip
        anchors.verticalCenterOffset: -205
        anchors.horizontalCenterOffset: 5
        anchors.centerIn: parent
    }


    MemUsage {
        x: 274
        y: 188
        width: 196
        height: 91
    }

    CpuUsage {
        x: 42
        y: 61
        width: 220
        height: 137
    }

    FsUsage {
        x: 274
        y: 61
        width: 196
        height: 101

    }


}
