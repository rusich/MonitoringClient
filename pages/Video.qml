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


    Image {
        id: bg
        anchors.fill: parent

    }
    HostShortcut {
        id: sdf
        x: 38
        y: 67
        height: 70
        width: 70
        image.source: "qrc:/images/uvc.png"
        host: hosts["cam-aorl1"]
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }
    HostShortcut {
        id: sdf1
        x: 194
        y: 74
        host: hosts["cam-aorl2"]
        image.source: "qrc:/images/uvc.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf2
        x: 326
        y: 74
        host: hosts["cam-aorl3"]
        image.source: "qrc:/images/uvc.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf3
        x: 455
        y: 79
        host: hosts["cam-aorl4"]
        image.source: "qrc:/images/uvc.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }


    HostShortcut {
        id: sdf4
        x: 50
        y: 192
        host: hosts["cam-bprm1"]
        image.source: "qrc:/images/uvc.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    Image {
        id: bg1
        x: -3
        y: 3
        anchors.rightMargin: -13
        anchors.bottomMargin: -30
        anchors.leftMargin: 13
        anchors.topMargin: 30
        anchors.fill: parent
    }

    HostShortcut {
        id: sdf5
        x: 194
        y: 192
        host: hosts["cam-bprm2"]
        image.source: "qrc:/images/uvc.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf6
        x: 335
        y: 205
        host: hosts["cam-bprm3"]
        image.source: "qrc:/images/uvc.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf7
        x: 449
        y: 205
        host: hosts["cam-bprm4"]
        image.source: "qrc:/images/uvc.png"
        //        onClicked: JS.nextPage("qrc:/pages/Server.qml", {"host": host })
    }

    HostShortcut {
        id: sdf11
        x: 500
        y: 334
        host: hosts["cam-dprm1"]
        image.source: "qrc:/images/uvc.png"
    }

    HostShortcut {
        id: sdf10
        x: 386
        y: 334
        host: hosts["cam-dprm2"]
        image.source: "qrc:/images/uvc.png"
    }

    HostShortcut {
        id: sdf9
        x: 216
        y: 334
        host: hosts["cam-dprm3"]
        image.source: "qrc:/images/uvc.png"
    }

    HostShortcut {
        id: sdf8
        x: 62
        y: 327
        host: hosts["cam-dprm4"]
        image.source: "qrc:/images/uvc.png"
    }

    HostShortcut {
        id: sdf12
        x: 65
        y: 457
        host: hosts["cam-dprm5"]
        image.source: "qrc:/images/uvc.png"
    }

    HostShortcut {
        id: sdf13
        x: 216
        y: 464
        host: hosts["cam-kdp1"]
        image.source: "qrc:/images/uvc-dome.png"
    }

    HostShortcut {
        id: sdf14
        x: 386
        y: 464
        host: hosts["cam-kdp2"]
        image.source: "qrc:/images/uvc-dome.png"
    }

    HostShortcut {
        id: sdf15
        x: 500
        y: 464
        host: hosts["sw1-aorl"]
        image.source: "qrc:/images/ts-poe.png"
    }

    HostShortcut {
        id: sdf16
        x: 576
        y: 69
        host: hosts["sw1-bprm"]
        image.source: "qrc:/images/ts-poe.png"
    }

    HostShortcut {
        id: sdf17
        x: 705
        y: 74
        host: hosts["sw1-dprm"]
        image.source: "qrc:/images/ts-poe.png"
    }

    HostShortcut {
        id: sdf18
        x: 585
        y: 200
        host: hosts["sw2-kdp"]
        image.source: "qrc:/images/ts-poe.png"
    }

    HostShortcut {
        id: sdf19
        x: 699
        y: 200
        host: hosts["WLAN-AP-AORL"]
        image.source: "qrc:/images/powerbeam.png"
    }

    HostShortcut {
        id: sdf20
        x: 636
        y: 329
        host: hosts["WLAN-AP-BPRM"]
        image.source: "qrc:/images/powerbeam.png"
        smooth: true
    }

    HostShortcut {
        id: sdf21
        x: 750
        y: 329
        host: hosts["WLAN-AP-DPRM"]
        image.source: "qrc:/images/powerbeam.png"
    }

    HostShortcut {
        id: sdf22
        x: 636
        y: 459
        host: hosts["WLAN-ST-AORL"]
        image.source: "qrc:/images/powerbeam.png"
    }

    HostShortcut {
        id: sdf23
        x: 750
        y: 459
        host: hosts["WLAN-ST-BPRM"]
        image.source: "qrc:/images/powerbeam.png"
    }

    HostShortcut {
        id: sdf24
        x: 869
        y: 67
        host: hosts["WLAN-ST-DPRM"]
        image.source: "qrc:/images/powerbeam.png"
    }
}
