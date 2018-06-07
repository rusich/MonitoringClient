import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../functions.js" as JS

Item {

    id: item1
    width: 400
    height: 150

    WidgetTemplate {
        id: widgetTemplate
        anchors.rightMargin: 0
        anchors.bottomMargin:0
        anchors.fill: parent
        caption: "Общая информация"
        hilightTriggers: hostConfigs[host.host].hilightTriggers.commonTriggers
        lastUpdatedInfo: host["icmpping"].lastclock

        UpDown {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            fontSize: 30
            visible: host?true:false
            isUp: host["icmpping"].lastvalue === "1"
        }

        Label {
            id: hostLbl
            y: 36
            text: "Хост:"
            anchors.left: image.right
            anchors.leftMargin: 6
            font.pointSize:8
        }

        Label {
            id: hostVal
            color: "#4797e6"
            text: host.host
            font.bold: true
            anchors.left: hostLbl.right
            anchors.leftMargin: 5
            anchors.bottom: hostLbl.bottom
            anchors.bottomMargin: -2
            font.family: "Times New Roman"
            font.pointSize: 13
        }
        Label {
            id: uptimeLbl
            text: "В работе:"
            anchors.left: hostVal.right
            anchors.bottom: hostLbl.bottom
            anchors.leftMargin: 6
            font.pointSize:8
        }
        Label {
            id: uptime
            color: normalMetricColor
            text: JS.uptime(host["system.uptime"].lastvalue)
            wrapMode: Text.WordWrap
            anchors.right: parent.right
            anchors.rightMargin: 13
            font.bold: true
            anchors.left: uptimeLbl.right
            anchors.leftMargin: 3
            anchors.bottom: uptimeLbl.bottom
            anchors.bottomMargin: -2
            font.family: "Times New Roman"
            font.pointSize: 11
        }

        Image {
            id: image
            x: 0
            y: 0
            width: 86
            height: 82
            anchors.top: parent.top
            anchors.topMargin: 31
            anchors.left: parent.left
            anchors.leftMargin: 8
            source: "qrc:/images/server_icon.png"
        }
        Label {
            id: osLbl
            text: "ОС:"
            anchors.top: hostLbl.bottom
            anchors.topMargin: 10
            anchors.left: image.right
            anchors.leftMargin: 6
            font.pointSize:8
        }

        Label {
            id: os
            text: host["system.uname"].lastvalue
            wrapMode: Text.WordWrap
            anchors.right: parent.right
            anchors.rightMargin: 13
            anchors.verticalCenterOffset: 0
            font.bold: true
            anchors.left: hostLbl.right
            anchors.leftMargin: -3
            anchors.verticalCenter: osLbl.verticalCenter
            font.family: "Times New Roman"
            font.pointSize: 8
        }

        Label {
            id: ipLbl
            text: "IP-адрес:"
            anchors.top: osLbl.bottom
            anchors.topMargin: 10
            anchors.left: image.right
            anchors.leftMargin: 6
            font.pointSize:8
        }

        Label {
            id: ip
            text: host["ip"]
            color: "#4797e6"
            font.bold: true
            wrapMode: Text.WordWrap
            anchors.verticalCenterOffset: 0
            anchors.left: ipLbl.right
            anchors.leftMargin: 3
            anchors.bottom: ipLbl.bottom
            anchors.bottomMargin: -2
            font.family: "Times New Roman"
            font.pointSize: 11
        }

        Label {
            id: pingLbl
            text: "Пинг:"
            anchors.left: ip.right
            anchors.leftMargin: 5
            anchors.bottom: ipLbl.bottom
            font.pointSize:8
        }

        Label {
            id: ping
            text: JS.roundPlus(host["icmppingsec"].lastvalue*1000,2) + "мс."
            wrapMode: Text.WordWrap
            anchors.right: parent.right
            anchors.rightMargin: 13
            anchors.verticalCenterOffset: 0
            font.bold: true
            anchors.left: pingLbl.right
            anchors.leftMargin: 3
            anchors.bottom: pingLbl.bottom
            anchors.bottomMargin: -2
            font.family: "Times New Roman"
            font.pointSize: 11
        }


        Label {
            id: localtimeLbl
            text: "Локальное время:"
            anchors.top: ipLbl.bottom
            anchors.topMargin: 10
            anchors.left: image.right
            anchors.leftMargin: 6
            font.pointSize:8
        }

        Label {
            id: localtime
            text: host["system.localtime[local]"]?
                    host["system.localtime[local]"].lastvalue :
                    JS.tsToDT(host["system.localtime"].lastvalue)
//            color: "#4797e6"
            color: normalMetricColor
            font.bold: true
            wrapMode: Text.WordWrap
            anchors.verticalCenterOffset: 0
            anchors.left: localtimeLbl.right
            anchors.leftMargin: 3
            anchors.bottom: localtimeLbl.bottom
            anchors.right: parent.right
            anchors.rightMargin: 11
            font.family: "Times New Roman"
            font.pointSize: 8
        }
        Label {
            id: procLbl
            text: "Количество процессов:"
            anchors.top: localtimeLbl.bottom
            anchors.topMargin: 10
            anchors.left: image.right
            anchors.leftMargin: 6
            font.pointSize:8
        }

        Label {
            id: proc
            text: host["proc.num[]"].lastvalue
            font.bold: true
            wrapMode: Text.WordWrap
            anchors.verticalCenterOffset: 0
            anchors.left: procLbl.right
            anchors.leftMargin: 3
            anchors.bottom: procLbl.bottom
            anchors.bottomMargin: -2
            anchors.right: parent.right
            anchors.rightMargin: 11
            font.family: "Times New Roman"
            font.pointSize: 12
        }

    }


}
