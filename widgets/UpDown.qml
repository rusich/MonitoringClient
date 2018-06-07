import QtQuick 2.0

Item {
    width: 50
    height: 50
    property bool isUp: false
    property int fontSize: 20
    Text {
        id: triangle
        text: isUp?"▲ ":"▼ "
        font.pixelSize: fontSize
        color: isUp?"#59FA21":"#d15963"
    }
    Text {
        id: updown
        text: isUp?"Up":"Down"
        font.pixelSize: fontSize
        font.bold: true
        color: isUp?"#59FA21":"#d15963"
        anchors.left: triangle.right
        anchors.bottom: triangle.bottom
    }
}
//▲▼
