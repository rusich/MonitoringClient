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
        host: hosts["server"]
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
        host: hosts["darkstar"]
        image.source: "qrc:/images/server_icon.png"
        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf2
        x: 379
        y: 199
        host: hosts["macbook"]
        image.source: "qrc:/images/server_icon.png"
        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }
}
