import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "../functions.js" as JS

Item {
    id: item1
    width: 200
    height: width*1.1
    property bool isWindows: host.system_cpu_util_all_system_avg1? true: false
    property int cpuloadp: isWindows?
                               Math.round(host.system_cpu_util_all_system_avg1.lastvalue):
                               Math.round(100-host.system_cpu_util_idle.lastvalue)
    WidgetTemplate {
        id: widgetTemplate
        anchors.rightMargin: 0
        anchors.bottomMargin:0
        anchors.fill: parent
        lastUpdatedInfo: isWindows?host.system_cpu_util_all_system_avg1.lastclock:
                             host.system_cpu_util_idle.lastclock

        caption: "ЗАГРУЗКА ЦП"
        RoundPorgressBar {
            id: rpg
            anchors.topMargin: 32
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            size: parent.width * 0.8
            colorCircle: cpuusLabel.color
            inPercent: cpuloadp
            lineWidth: 5

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
                text: "avg1: "+ JS.roundPlus(host.system_cpu_load_percpu_avg1.lastvalue,2) +"%"
                font.bold: true
                font.pointSize: 7
            }

            Label {
                id: avg5
                color: "#92b5fa"
                text:"avg5: "+ JS.roundPlus( host.system_cpu_load_percpu_avg5.lastvalue,2)+"%"
                font.pointSize: 7
                font.bold: true
            }

            Label {
                id: avg15
                color: "#92b5fa"
                text:"avg15: "+ JS.roundPlus( host.system_cpu_load_percpu_avg15.lastvalue,2)+"%"
                font.pointSize: 7
                font.bold: true
            }
        }



    }


}
