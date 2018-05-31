import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2
import "qrc:/widgets"

Page {
    width: 600
    height: 400
    property alias button: button

    title: qsTr("Page 1")
    CpuUsage {}

    Label {
        id: ttt
        text: hosts.server.vfs_fs_size_media_pfree.lastvalue +
              hosts.server.vfs_fs_size_media_pfree.units

        anchors.centerIn: parent
    }

    Button {
        id: button
        x: 118
        y: 81
        text: qsTr("Button")
        Material.background: "#FF0000"
        onClicked: {
              console.log(JSON.stringify(hosts.server));
              console.log(JSON.stringify(hosts.server.vfs_fs_size_media_pfree));
        }
    }

    DelayButton {
        id: delayButton
        x: 293
        y: 81
        text: qsTr("Delay Button")
        autoExclusive: false
        checked: false
        opacity: 1
        visible: true
    }

    RadioButton {
        id: radioButton
        x: 50
        y: 197
        text: qsTr("Radio Button")
    }

    TabButton {
        id: tabButton
        x: 330
        y: 287
        text: qsTr("Tab Button")
    }
}
