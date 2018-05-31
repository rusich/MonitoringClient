import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../functions.js" as JS

import jbQuick.Charts 1.0
Item {
    id: item1
    width: 200
    height: width*1.1
    property bool isWindows: host.system_cpu_util_all_system_avg1? true: false
    property int cpuloadp: isWindows?
                               Math.round(host.system_cpu_util_all_system_avg1.lastvalue):
                               Math.round(100-host.system_cpu_util_idle.lastvalue)
    property variant disks: []
    WidgetTemplate {
        id: widgetTemplate
        anchors.rightMargin: 0
        anchors.bottomMargin:0
        anchors.fill: parent
        lastUpdatedInfo: host["vfs_fs_size_"+disks[0]+ "_used"].lastclock

        caption: "ФАЙЛОВЫЕ СИСТЕМЫ"


        Column {
            anchors.fill: parent
            anchors.topMargin: 33
            anchors.leftMargin: 11
            anchors.rightMargin: 11
            anchors.bottomMargin: 5
            spacing: 10

            Repeater {
                model: disks.length
                HorizontalProgressBar {

                    id: curDisk
                    property real fsUsed:  JS.roundPlus(host["vfs_fs_size_"+disks[index]+
                                               "_used"].lastvalue/1024/1024/1024,1)
                    property real fsTotal: JS.roundPlus(host["vfs_fs_size_"+disks[index]+
                                               "_total"].lastvalue/1024/1024/1024,1)
                    property real fsUsedP: JS.roundPlus(fsUsed/fsTotal*100,1)
                    anchors.left: parent.left
                    anchors.right: parent.right

                    value: fsUsedP

                    color: value<80? "#2161c6": criticalMetricColor
                    Label {
                        text: fsTotal?disks[index] + " - " + Math.round(fsUsed)+"GB/"+
                                       Math.round(fsTotal)+"GB "+fsUsedP+"%":""
                        font.pointSize: 7.5
                        anchors.verticalCenter: curDisk.verticalCenter
                        anchors.horizontalCenter:  curDisk.horizontalCenter
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
        }
    }
}
