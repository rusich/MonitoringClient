import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../functions.js" as JS

Item {

    id: item1
    width: 100
    height: 100
    property variant host
    property alias image: image
    signal clicked()
    property color shadowColor: host.triggersCount>0?"red":"black"
    MouseArea {
        id: ma
        enabled: true
        anchors.fill: parent
        hoverEnabled: true
        onClicked:  item1.clicked()//{
//            var page =  Qt.createComponent("qrc:/pages/Server.qml");
//            if(page.status === Component.Ready)
//                stackView.push(page,{"host": host});
       // }

        onEntered: {
            cursorShape = Qt.PointingHandCursor;
            effect.color = "grey";
        }
        onExited:  {
            effect.color = shadowColor;
        }
    }


    Image {
        id: image
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        visible: false
    }
    DropShadow {
        id: effect
        anchors.fill: image
        radius: 14
        samples: 17
        horizontalOffset: 0
        verticalOffset: 0
        color: shadowColor
        source: image
    }

    Text {
        id: hostname
        color: "#4797e6"
        font.bold: true
        font.pixelSize: 14
        text: host.name
        anchors.bottom: ip.top
        anchors.horizontalCenter: ip.horizontalCenter
    }
    Text {
        id: ip
        color: "white"
        font.pixelSize: 10
        text: host.ip
        anchors.bottom: updown.top
        anchors.horizontalCenter: effect.horizontalCenter
    }

    UpDown {
        id: updown
        anchors.bottom: effect.top
        anchors.bottomMargin: -30
        anchors.horizontalCenter: effect.horizontalCenter
        anchors.horizontalCenterOffset: 10
        fontSize: 12
        visible: host?true:false
        isUp: host["icmpping"].lastvalue === "1"
    }

    Rectangle {
        x:  image.x + image.width - width/2
        y:  image.y
        width: 25
        height: width
        color: "red"
        border.color: "white"
        border.width: 1
        radius: width*0.5
        Text {
            anchors.centerIn: parent
            color: "white"
            font.bold: true
            text: host.triggersCount
        }
        visible: host? host.triggersCount>0? true: false: false
    }
    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered:  {
           if(typeof host !=="undefined")
               host = hosts[host.host];
        }
    }
}
