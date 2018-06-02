import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"

Page {
    property variant host
    anchors.fill: parent

    title: host.name

    Label {
        width: 62
        height: 22
        text: host.ip
        anchors.verticalCenterOffset: 198
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent
    }


    MemUsage {
        x: 139
        y: 7
        width: 196
        height: 101
    }

    CpuUsage {
        x: 10
        y: 7
        width: 123
        height: 101
    }

    FsUsage {
        x: 341
        y: 7
        width: 196
        height: 101

    }

    Graph {
        x: 10
        y: 114
        width: 527
        height: 290
    }

}
