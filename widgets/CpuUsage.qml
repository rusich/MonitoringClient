import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "../functions.js" as JS

Item {
    id: item1
    width: 200
    height: 200
    property bool isWindows: host["system.cpu.util[all,system,avg1]"]? true: false
    property int cpuloadp: isWindows?
                               Math.round(host["system.cpu.util[all,system,avg1]"].lastvalue):
                               Math.round(100-host["system.cpu.util[,idle]"].lastvalue)

    property alias hilightTriggers: widgetTemplate.hilightTriggers
    hilightTriggers: []

    WidgetTemplate {
        id: widgetTemplate
        anchors.rightMargin: 0
        anchors.bottomMargin:0
        anchors.fill: parent
        lastUpdatedInfo: isWindows?host["system.cpu.util[all,system,avg1]"].lastclock:
                             host["system.cpu.util[,idle]"].lastclock

        caption: "Загрузка ЦП"
        RoundPorgressBar {
            id: rpg
            size: parent.height
            anchors.topMargin: 32
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            colorCircle: cpuusLabel.color
            inPercent: cpuloadp
            lineWidth: 10

        }

        Label {
            id: cpuusLabel
            text: cpuloadp+"%"
            anchors.horizontalCenterOffset: 5
            anchors.horizontalCenter: rpg.horizontalCenter
            anchors.bottom: rpg.verticalCenter
            anchors.bottomMargin: -5
            color: cpuloadp<normalMetricTop?
                       normalMetricColor: cpuloadp<warningMetricTop?
                           warningMetricColor:criticalMetricColor
            font.bold: true
            font.pointSize: rpg.size/5
        }


        GridLayout {
            visible: false
            anchors.top: rpg.verticalCenter
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            columns: 2
            Label {
                id: avg1
                color: "#92b5fa"
                text: "avg1: "+ JS.roundPlus(host["system.cpu.load[percpu,avg1]"].lastvalue,2) +"%"
                font.bold: true
                font.pointSize: 7
            }

            Label {
                id: avg5
                color: "#92b5fa"
                text:"avg5: "+ JS.roundPlus(host["system.cpu.load[percpu,avg5]"].lastvalue,2)+"%"
                font.pointSize: 7
                font.bold: true
            }

            Label {
                id: avg15
                color: "#92b5fa"
                text:"avg15: "+ JS.roundPlus(host["system.cpu.load[percpu,avg15]"].lastvalue,2)+"%"
                font.pointSize: 7
                font.bold: true
            }
        }

    }
}
