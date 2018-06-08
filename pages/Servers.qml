import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "qrc:/widgets"
import "qrc:/pages"
import "../functions.js" as JS

Page {

    width: 1010
    height: 637
    anchors.fill: parent
    property alias bgImage: bg.source

    Image {
        id: bg
        anchors.fill: parent
        source: "qrc:/images/servers-bg.png"
    }

    HostShortcut {
        id: srv_01
        x: 70
        y: 110
        width: 140
        height: 140
        image.source: "qrc:/images/hyper-v-server.png"
        host: hosts["srv-01"]
        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host ,"image": image.source})
    }

    RowLayout {
        x: 340
        y: 120
        spacing: 25
        HostShortcut {
            id: ug
            host: hosts["ug"]
            image.source: "qrc:/images/usergate-server.png"
            onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host ,"image": image.source})
        }

        HostShortcut {
            id: wsus
            host: hosts["wsus"]
            image.source: "qrc:/images/wsus-server.png"
            onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host ,"image": image.source})
        }

        HostShortcut {
            id: drweb
            host: hosts["drweb"]
            image.source: "qrc:/images/drweb-server.png"
            onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host ,"image": image.source})
        }

        HostShortcut {
            id: vers15
            host: hosts["vers15"]
            image.source: "qrc:/images/vers15-server.png"
            onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host ,"image": image.source})
        }

        HostShortcut {
            id: gw
            host: hosts["gw"]
            image.source: "qrc:/images/gateway-server.png"
            onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host ,"image": image.source})
        }

    }

    RowLayout {
        x: 60
        y: 480
        spacing: 45
        HostShortcut {
            id: nvr
            host: hosts["nvr"]
            image.source: "qrc:/images/nvr-server.png"
            onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host ,"image": image.source})
        }


        HostShortcut {
            id: srv_vil_02
            host: hosts["srv-vil-02"]
            image.source: "qrc:/images/backup-server.png"
            onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host ,"image": image.source})
        }
    }
}
