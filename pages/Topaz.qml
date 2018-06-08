import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"
import "../functions.js" as JS

Page {

    width: 1010
    height: 637
    anchors.fill: parent
    property alias bgImage: bg.source

    HostShortcut {
        id: sdf
        x: 67
        y: 198
        image.source: "qrc:/images/server_icon.png"
        host: hosts["rli1"]
        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }
    Image {
        id: bg
        anchors.fill: parent

    }

    HostShortcut {
        id: sdf1
        x: 223
        y: 205
        host: hosts["rli2"]
        image.source: "qrc:/images/server_icon.png"
        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf2
        x: 379
        y: 199
        host: hosts["topaz-arm-d1"]
        image.source: "qrc:/images/server_icon.png"
//        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf3
        x: 572
        y: 198
        host: hosts["topaz-arm-d2"]
        image.source: "qrc:/images/server_icon.png"
//        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }


    HostShortcut {
        id: sdf4
        x: 79
        y: 389
        host: hosts["topaz-switch1"]
        image.source: "qrc:/images/server_icon.png"
//        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf5
        x: 233
        y: 396
        host: hosts["topaz-switch2"]
        image.source: "qrc:/images/server_icon.png"
//        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    Image {
        id: bg1
        x: -3
        y: 3
        anchors.fill: parent
    }
}
