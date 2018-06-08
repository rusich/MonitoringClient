import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "../functions.js" as JS

Item {
    property color bgColor: widgetBgColor
    property color borderColor: "white"
    property int borderWidth: 0
    property string caption
    property bool showHeaderLine: true
    property color headerLineColor: "grey"
    property int lastUpdatedInfo
    property variant  hilightTriggers: []
    property bool hilightWidget: false

    width: 100
    height: 100

    RectangularGlow {
        id: effect
        anchors.fill: bg
        glowRadius: 10
        spread: 0.1
        color: hilightWidget?"#ff0000":"black"
        opacity: hilightWidget?1:0.5
        cornerRadius: bg.radius + glowRadius
    }


    Rectangle  {
        id: bg
        anchors.fill: parent
        color: parent.bgColor
        radius: 2
        border.color: hilightWidget?"#ff0000":parent.borderColor
        border.width: hilightWidget?"1": parent.borderWidth
    }


    Label {
        id: captionLabel
        text: parent.caption
        font.pointSize: 9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
    }

    Rectangle {
        id: headerLine
        visible: parent.showHeaderLine
        width: parent.width*0.93
        height: 1
        anchors.top: captionLabel.bottom
        anchors.topMargin: 5
        color: headerLineColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Label {
        id: clockSymbol
        anchors.right: updateDateTime.left
//        anchors.verticalCenter: updateDateTime.verticalCenter
        anchors.top: updateDateTime.top
        anchors.topMargin: -7
        anchors.rightMargin: 3
        text: qsTr("⌚")
        font.pointSize: 12
        color: updateDateTime.color
        visible: lastUpdatedInfo? true : false
    }

    Label {
        id: updateDateTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 5
        text:  JS.tsToDT(lastUpdatedInfo)
        font.pointSize: 7
        color: "grey"
        visible: lastUpdatedInfo? true : false
    }

    function hlWdt(hostname) {
        if(typeof host === "undefined")
            return;
        if(hostname===host.host){
            if(host.triggersCount>0)
            {
                for(var i=0; i < host.triggersCount; i++){
                    var triggerid = host.triggers[i].triggerid;
                    if(typeof hilightTriggers === "undefined")
                        continue;
                    if(hilightTriggers.length>0) {
                        for(var j=0; j < hilightTriggers.length; j++) {
                            if(hilightTriggers[j] === triggerid) {
                                hilightWidget = true;
                                return;
                            }
                        }

                    hilightWidget = false;
                    }
                }
            }
            else {
                    hilightWidget = false;
            }
        }
    }

    Connections {
        target: backend?backend:null
        onHostUpdated: hlWdt(hostname)
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

    Component.onCompleted: hlWdt(host.host)
}
