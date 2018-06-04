import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"

Page {
    property variant host
    width: 1000
    height: 800
    anchors.fill: parent

    title: host.name


    MemUsage {
        x: 391
        y: 17
        width: 200
        height: 100
    }

    CpuUsage {
        x: 19
        y: 17
        width: 137
        height: 100
    }

    FsUsage {
        x: 173
        y: 17
        width: 200
        height: 100

    }

    Graph {
        x: 173
        y: 133
        width: 418
        height: 240
    }

    Problems {
        x: 19
        y: 133
        width: 137
        height: 240

    }


}
