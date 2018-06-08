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


    Image {
        id: bg
        anchors.fill: parent

    }
    HostShortcut {
        id: sdf
        x: 25
        y: 37
        image.source: "qrc:/images/server_icon.png"
        host: hosts["cam-aorl1"]
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }
    HostShortcut {
        id: sdf1
        x: 181
        y: 44
        host: hosts["cam-aorl2"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf2
        x: 313
        y: 44
        host: hosts["cam-aorl3"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf3
        x: 442
        y: 49
        host: hosts["cam-aorl4"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }


    HostShortcut {
        id: sdf4
        x: 37
        y: 162
        host: hosts["cam-bprm1"]
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
        x: 181
        y: 162
        host: hosts["cam-bprm2"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf6
        x: 322
        y: 175
        host: hosts["cam-bprm3"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf7
        x: 436
        y: 175
        host: hosts["cam-bprm4"]
        image.source: "qrc:/images/server_icon.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf11
        x: 487
        y: 304
        host: hosts["cam-dprm1"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf10
        x: 373
        y: 304
        host: hosts["cam-dprm2"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf9
        x: 203
        y: 304
        host: hosts["cam-dprm3"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf8
        x: 49
        y: 297
        host: hosts["cam-dprm4"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf12
        x: 49
        y: 427
        host: hosts["cam-dprm5"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf13
        x: 203
        y: 434
        host: hosts["cam-kdp1"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf14
        x: 373
        y: 434
        host: hosts["cam-kdp2"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf15
        x: 487
        y: 434
        host: hosts["sw1-aorl"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf16
        x: 563
        y: 39
        host: hosts["sw1-bprm"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf17
        x: 692
        y: 44
        host: hosts["sw1-dprm"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf18
        x: 572
        y: 170
        host: hosts["sw2-kdp"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf19
        x: 686
        y: 170
        host: hosts["WLAN-AP-AORL"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf20
        x: 623
        y: 299
        host: hosts["WLAN-AP-BPRM"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf21
        x: 737
        y: 299
        host: hosts["WLAN-AP-DPRM"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf22
        x: 623
        y: 429
        host: hosts["WLAN-ST-AORL"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf23
        x: 737
        y: 429
        host: hosts["WLAN-ST-BPRM"]
        image.source: "qrc:/images/server_icon.png"
    }

    HostShortcut {
        id: sdf24
        x: 856
        y: 37
        host: hosts["WLAN-ST-DPRM"]
        image.source: "qrc:/images/server_icon.png"
    }
}
