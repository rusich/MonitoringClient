import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"

Page {
    property variant host
    width: 1010
    height: 630
    anchors.fill: parent

    title: host.name


    MemUsage {
        x: 590
        y: 14
        width: 193
        height: 105
    }

    CpuUsage {
        x: 428
        y: 14
        width: 153
        height: 105
    }

    FsUsage {
        x: 792
        y: 14
        width: 200
        height: 105

    }

    Graph {
        x: 19
        y: 228
        width: 480
        height: 390
        graphid: hostConfigs[host.host].graphs[0].graphid
        period: hostConfigs[host.host].graphs[0].period
        visible: hostConfigs[host.host].graphs[0]? true: false
    }

    Problems {
        x: 428
        y: 128
        width: 564
        height: 90

    }

    CommonInfo {
        x: 19
        y: 14
        width: 400
        height: 204

    }

    Graph {
        x: 512
        y: 228
        width: 480
        height: 186

        graphid: hostConfigs[host.host].graphs[1].graphid
        period: hostConfigs[host.host].graphs[1].period
        visible: hostConfigs[host.host].graphs[1]? true: false
    }

    Graph {
        x: 512
        y: 425
        width: 480
        height: 193
        visible: hostConfigs[host.host].graphs[2]? true: false
        period: hostConfigs[host.host].graphs[2].period
        graphid: hostConfigs[host.host].graphs[2].graphid
    }

}
