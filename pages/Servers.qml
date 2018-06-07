import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"
import "../functions.js" as JS

Page {

    width: 1010
    height: 630
    anchors.fill: parent
    property alias bgImage: bg.source

    HostShortcut {
        x: 241
        y: 122
        image.source: "qrc:/images/server_icon.png"
        host: hosts["server"]
        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host})
    }
    Image {
        id: bg
        anchors.fill: parent
    }

    HostShortcut {
        x: 408
        y: 122
        host: hosts["darkstar"]
        image.source: "qrc:/images/server_icon.png"
        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host})
    }

    HostShortcut {
        x: 578
        y: 122
        host: hosts["macbook"]
        image.source: "qrc:/images/server_icon.png"
        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host})
    }
}
