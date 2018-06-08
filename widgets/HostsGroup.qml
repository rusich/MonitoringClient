import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../functions.js" as JS

Item {

    id: item1
    width: 220
    height: 180

    property alias caption: widgetTemplate.caption
    property alias groupimg: groupimg
    signal clicked()

//    visible: groups[caption]?true:false
    WidgetTemplate {
        id: widgetTemplate
        anchors.rightMargin: 0
        anchors.bottomMargin:0
        anchors.fill: parent
        hilightWidget: groups[caption].triggersCount>0?true:false
        MouseArea {
            id: ma
            enabled: true
            anchors.fill: parent
            hoverEnabled: true
            onClicked: item1.clicked()
            onEntered: {
               widgetTemplate.bgColor = "#3F3F3F";
                cursorShape = Qt.PointingHandCursor;
            }
            onExited:  {
               widgetTemplate.bgColor = widgetBgColor;
            }
        }

        Image {
            id: groupimg
            anchors.verticalCenter: parent.verticalCenter
            anchors.bottomMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height - 60
            width: parent.width - 40
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Rectangle {
            x:  groupimg.x + groupimg.width - width/2
            y:  groupimg.y
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
                text: groups[caption].triggersCount
            }
            visible: groups[caption]? groups[caption].triggersCount>0? true: false: false
        }



        Text {
            color: "white"
            text: "Устройств: " + groups[caption].hostsCount
            anchors.top: groupimg.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: parent.horizontalCenter

        }
    }
}
