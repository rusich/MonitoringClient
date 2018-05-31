import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

Item {
    property color bgColor: "#25252E"
    property color bgHoverColor: "#24302E"
    property color borderColor: "white"
    property int borderWidth: 0
    property color borderHoverColor: "purple"
    property int borderHoverWidth: 0
    property string caption: "Widget"
    property bool showHeaderLine: true
    property color headerLineColor: "grey"

    width: 100
    height: 100


    RectangularGlow {
        id: effect
        anchors.fill: bg
        glowRadius: 8
        spread: 0.2
        color: "black"
        opacity: 0.5
        cornerRadius: bg.radius + glowRadius
    }

    Rectangle  {
        id: bg
        anchors.fill: parent
        color: parent.bgColor
        radius: 4
        border.color: parent.borderColor
        border.width: parent.borderWidth
    }

    MouseArea {
        id: ma
        enabled: true
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            console.log(JSON.stringify(host.system_cpu_util_idle));
        }
        onEntered: {
            bg.color = parent.bgHoverColor;
            bg.border.color = parent.borderHoverColor;
            bg.border.width = parent.borderHoverWidth;
        }
        onExited:  {
            bg.color = parent.bgColor;
            bg.border.color = parent.borderColor;
            bg.border.width = parent.borderWidth;
        }

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
}
