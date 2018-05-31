import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../functions.js" as JS

Item {
    id: item1
    width: 200
    height: 100
    property bool isWindows: host.vm_memory_size_free? true: false
    //Оперативная память
    property double totalRam: JS.roundPlus(
                                  host.vm_memory_size_total.lastvalue
                                  /1024/1024/1024,1)
    property double availRam: JS.roundPlus(
                                  isWindows?
                                  host.vm_memory_size_free.lastvalue/1024/1024/1024:
                                  host.vm_memory_size_available.lastvalue/1024/1024/1024
                                      ,1)
    property double usedRam: JS.roundPlus(totalRam-availRam,1)
    property double ramUsageP: Math.round(usedRam/totalRam*100)

    //Своп
    property double totalSwap: JS.roundPlus(
                                  host.system_swap_size_total.lastvalue
                                  /1024/1024/1024,1)
    property double availSwap: JS.roundPlus(
                                  host.system_swap_size_free.lastvalue
                                  /1024/1024/1024,1)
    property double usedSwap: JS.roundPlus(totalSwap-availSwap,1)
    property double swapUsageP: Math.round(usedSwap/totalSwap*100)


    WidgetTemplate {
        id: widgetTemplate
        anchors.fill: parent
        lastUpdatedInfo: isWindows?host.vm_memory_size_free.lastclock:
                                   host.vm_memory_size_available.lastclock

        caption: "ИСПОЛЬЗОВАНИЕ ПАМЯТИ"

        HorizontalProgressBar {
            id: ram
            y: 54
            anchors.rightMargin: 11
            anchors.right: parent.right
            anchors.leftMargin: 57
            anchors.left: parent.left
            anchors.verticalCenter: ramLbl.verticalCenter
            value: ramUsageP
            color: ramUsageP<normalMetricTop?
                                   normalMetricColor: ramUsageP<warningMetricTop?
                                       warningMetricColor:criticalMetricColor
        }

        HorizontalProgressBar {
            id: swap
            y: 104
            anchors.right: parent.right
            anchors.rightMargin: 11
            anchors.left: parent.left
            anchors.leftMargin: 57
            anchors.verticalCenter: swapLbl.verticalCenter
            value: swapUsageP
            color: swapUsageP<normalMetricTop?
                                   normalMetricColor: swapUsageP<warningMetricTop?
                                       warningMetricColor:criticalMetricColor
        }

        Label {
            id: ramLbl
            text: qsTr("RAM:")
            font.pointSize: 8
            anchors.left: parent.left
            anchors.leftMargin: 11
            anchors.top: parent.top
            anchors.topMargin: 35
        }

        Label {
            id: swapLbl
            text: qsTr("SWAP:")
            font.bold: false
            font.pointSize: 8
            anchors.left: parent.left
            anchors.leftMargin: 11
            anchors.top: parent.top
            anchors.topMargin: 62
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
