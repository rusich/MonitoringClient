import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2

Page {
    width: 600
    height: 400
    property alias button: button

    title: qsTr("Page 1")

    Label {
        text: qsTr("You are on Page 1.")
        anchors.centerIn: parent
    }

    Button {
        id: button
        x: 118
        y: 81
        text: qsTr("Button")
        Material.background: "#FF0000"
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
