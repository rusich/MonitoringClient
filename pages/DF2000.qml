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
        x: 119
        y: 103
        image.source: "qrc:/images/server_icon.png"
        host: hosts["df2000-adu"]
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }
    Image {
        id: bg
        anchors.fill: parent

    }

    HostShortcut {
        id: sdf1
        x: 275
        y: 110
        host: hosts["df2000-dsl1-aorl"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf2
        x: 431
        y: 104
        host: hosts["df2000-dsl1-bprm"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf3
        x: 557
        y: 103
        host: hosts["df2000-dsl1-kdp"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }


    HostShortcut {
        id: sdf4
        x: 131
        y: 258
        host: hosts["df2000-dsl2-bprm"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    Image {
        id: bg1
        x: -3
        y: 3
        anchors.fill: parent
    }

    HostShortcut {
        id: sdf5
        x: 285
        y: 265
        host: hosts["df2000-dsl2-kdp"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf6
        x: 455
        y: 265
        host: hosts["df2000-dsl3-bprm"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf7
        x: 569
        y: 265
        host: hosts["df2000-indicator1"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf11
        x: 569
        y: 440
        host: hosts["df2000-indicator2"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf10
        x: 455
        y: 440
        host: hosts["df2000-microevm"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf9
        x: 285
        y: 440
        host: hosts["df2000-moxa-aorl"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf8
        x: 131
        y: 433
        host: hosts["df2000-moxa-kdp"]
        image.source: "qrc:/images/server_icon.png"
    }



}
