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


    property variant disks: hostConfigs[host["host"]].fs
    WidgetTemplate {
        id: widgetTemplate
        anchors.rightMargin: 0
        anchors.bottomMargin:0
        anchors.fill: parent
        lastUpdatedInfo: host["vfs.fs.size["+disks[0]+ ",used]"].lastclock
        hilightTriggers: hostConfigs[host.host].hilightTriggers.fsTriggers

        caption: "Файловые системы"

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
                    height: 20
                    property real fsUsed:  JS.roundPlus(host["vfs.fs.size["+disks[index]+
                                                             ",used]"].lastvalue/1024/1024/1024,1)
                    property real fsTotal: JS.roundPlus(host["vfs.fs.size["+disks[index]+
                                                             ",total]"].lastvalue/1024/1024/1024,1)
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
