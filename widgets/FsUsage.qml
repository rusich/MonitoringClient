import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtCharts 1.0
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

        caption: "ДИСКОВЫЕ НАКОПИТЕЛИ"
        ChartView {
            id: chart
            anchors.fill: parent
            antialiasing: true
            theme: ChartView.ChartThemeDark
            backgroundColor: "red"

            PieSeries {
                id: pieSeries
                PieSlice { label: "Volkswagen"; value: 13.5 }
                PieSlice { label: "Volvo"; value: 6.8 }
            }
        }

//        Component.onCompleted: {
//             You can also manipulate slices dynamically, like append a slice or set a slice exploded
//            othersSlice = pieSeries.append("Others", 52.0);
//            pieSeries.find("Volkswagen").exploded = true;
//        }
    }
}
