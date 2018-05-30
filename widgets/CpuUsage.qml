import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    id: item1
    width: 200
    height: 200
    property variant host
    property int cpuloadp: Math.round(100-host.system_cpu_util_idle.lastvalue)
    WidgetTemplate {
        anchors.fill: parent
        caption: "Загрузка ЦП"
        RoundPorgressBar {
            anchors.horizontalCenter: cpuusLabel.horizontalCenter
            anchors.verticalCenter: cpuusLabel.verticalCenter
            size: parent.width * 0.7
            colorCircle: cpuusLabel.color
            inPercent: 100-host.system_cpu_util_idle.lastvalue
            lineWidth: 10
        }

        Label {
            id: cpuusLabel
            text: cpuloadp+"%"
            color: cpuloadp<normalMetricTop?
                       normalMetricColor: cpuloadp<warningMetricTop?
                           warningMetricColor:criticalMetricColor
            font.bold: true
            font.pointSize: 20
            anchors.verticalCenterOffset: 15
            anchors.centerIn: parent
        }
    }

}
