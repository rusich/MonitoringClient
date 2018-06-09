import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"
import "../functions.js" as JS
import MonitoringClient.Settings 1.0

Page {
    property variant host
    width: 1010
    height: 637
    anchors.fill: parent

    title: host.name
    property alias image: commInfo.image

    MemUsage {
        x: 560
        y: 14
        width: 193
        height: 105
    }

    CpuUsage {
        x: 428
        y: 14
        width: 126
        height: 105
    }

    FsUsage {
        x: 759
        y: 14
        width: 233
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
        id: commInfo
        x: 19
        y: 14
        width: 400
        height: 204

    }

    Graph {
        x: 512
        y: 228
        width: 480
        height: 390

        graphid: hostConfigs[host.host].graphs[1].graphid
        period: hostConfigs[host.host].graphs[1].period
        visible: hostConfigs[host.host].graphs[1]? true: false
    }

    Component.onCompleted: {
        backend.getHost(host.host);
    }

    Timer {
        interval: Settings.updateInterval; running: true; repeat: true
        onTriggered: backend.getHost(host.host)
    }

    Connections {
        target: backend?backend:null
        onHostUpdated:  {
            if(host.host===hostname) {
                if(hosts[hostname].summary==="true") return;
                host = hosts[hostname];
            }
        }
    }
}
