import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"
import jbQuick.Charts 1.0

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
        x: 342
        y: 62
        width: 174
        height: 105

        disks: ["C:", "D:"]
    }


}
