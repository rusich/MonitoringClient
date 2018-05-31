import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"

Page {
    property variant host
    anchors.fill: parent

    title: host.name

    Label {
        text: host.ip
        anchors.centerIn: parent
    }

    WidgetTemplate {
        x: 289
        y: 58
        width: 205
        height: 132
    }

    CpuUsage {
        x: 51
        y: 39
        width: 386
        height: 175
    }

}
