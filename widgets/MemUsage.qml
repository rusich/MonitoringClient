import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../functions.js" as JS

Item {

    id: item1
    width: 200
    height: 200

    property bool isWindows: host["vm.memory.size[free]"]? true: false
    //Оперативная память
    property double totalRam: JS.roundPlus(
                                  host["vm.memory.size[total]"].lastvalue
                                  /1024/1024/1024,1)
    property double availRam: JS.roundPlus(
                                  isWindows?
                                  host["vm.memory.size[free]"].lastvalue/1024/1024/1024:
                                  host["vm.memory.size[available]"].lastvalue/1024/1024/1024
                                      ,1)
    property double usedRam: JS.roundPlus(totalRam-availRam,1)
    property double ramUsageP: Math.round(usedRam/totalRam*100)

    //Своп
    property double totalSwap: JS.roundPlus(
                                  host["system.swap.size[,total]"].lastvalue
                                  /1024/1024/1024,1)
    property double availSwap: JS.roundPlus(
                                  host["system.swap.size[,free]"].lastvalue
                                  /1024/1024/1024,1)
    property double usedSwap: JS.roundPlus(totalSwap-availSwap,1)
    property double swapUsageP: Math.round(usedSwap/totalSwap*100)

    property alias hilightTriggers: widgetTemplate.hilightTriggers
    hilightTriggers: []

    WidgetTemplate {
        id: widgetTemplate
        anchors.fill: parent
        lastUpdatedInfo: isWindows?host["vm.memory.size[free]"].lastclock:
                                   host["vm.memory.size[available]"].lastclock

        caption: "Память"
        implicitWidth: 50

        Label {
            id: ramLbl
            text: qsTr("RAM:")
            font.pointSize: 8
            anchors.left: parent.left
            anchors.leftMargin: 11
            anchors.verticalCenter: ram.verticalCenter
        }
        HorizontalProgressBar {
            id: ram
            y: 54
            anchors.rightMargin: 11
            anchors.right: parent.right
            anchors.leftMargin: 57
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 33
            value: ramUsageP
            color: ramUsageP<normalMetricTop?
                                   normalMetricColor: ramUsageP<warningMetricTop?
                                       warningMetricColor:criticalMetricColor
//            height: parent.height /4
            height: 20
        }
        Label {
            id: swapLbl
            text: qsTr("SWAP:")
            font.bold: false
            font.pointSize: 8
            anchors.left: parent.left
            anchors.leftMargin: 11
            anchors.verticalCenter: swap.verticalCenter
        }
        HorizontalProgressBar {
            id: swap
            y: 104
            anchors.right: parent.right
            anchors.rightMargin: 11
            anchors.left: parent.left
            anchors.leftMargin: 57
            anchors.top: ram.bottom
            anchors.topMargin: 10
            value: swapUsageP
            color: swapUsageP<normalMetricTop?
                                   normalMetricColor: swapUsageP<warningMetricTop?
                                       warningMetricColor:criticalMetricColor
//            height: parent.height / 4
            height: 20
        }

        Label {
            id: rul
            text: ramUsageP?usedRam +"GB/"+totalRam+"GB "+ramUsageP+"%":""
            font.pointSize: 7.5
            anchors.verticalCenter: ram.verticalCenter
            anchors.horizontalCenter:  ram.horizontalCenter
            layer.enabled: true
            layer.effect:    DropShadow {
                color: "black"
                radius: 2
                samples: 4
                spread: 0.6
            }
        }

        Label {
            id: sul
            text: totalSwap?usedSwap +"GB/"+totalSwap+"GB "+swapUsageP+"%":""
            font.pointSize: 7.5
            anchors.verticalCenter: swap.verticalCenter
            anchors.horizontalCenter:  swap.horizontalCenter
            layer.enabled: true
            layer.effect:    DropShadow {
                color: "black"
                radius: 2
                samples: 4
                spread: 0.6
            }
        }

    }
}
