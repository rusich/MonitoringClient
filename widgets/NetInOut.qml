import QtQuick 2.0
import "../functions.js" as JS
Item {
    width: 50
    height: 50
    property bool isUp: false
    property int fontSize: 30
    property color bgColor: "#302f2f"
    property color fgColor: "#4cb1ff"
    property string netSymbol: "➡"

    Text {
        id: send
        text: netSymbol
        font.pixelSize: fontSize
        color: bgColor
        rotation: -90
        font.bold: true
    }
    Text {
        id: receive
        text: netSymbol
        font.pixelSize: fontSize
        font.bold: true
        color: bgColor
        anchors.left: send.right
        anchors.bottom: send.bottom
        anchors.leftMargin: -10
        rotation: 90
    }

    Connections {
        target: backend?backend:null
        onNetIn: {
            receive.color = fgColor;
        }
        onNetOut: {
            send.color = fgColor;
        }
    }

    Timer {
        interval: 200; running: true; repeat: true
        onTriggered: {
            receive.color = bgColor;
        }
    }

    Timer {
        interval: 300; running: true; repeat: true
        onTriggered: {
            send.color = bgColor;
        }
    }
}
//▲▼
