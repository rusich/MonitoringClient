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
        anchors.centerIn: parent
    }


    MemUsage {
        x: 159
        y: 62
        width: 177
        height: 105
    }

    CpuUsage {
        x: 22
        y: 62
        width: 131
        height: 105
    }

    FsUsage {
        x: 397
        y: 57
        width: 185
        height: 204

    }

}
