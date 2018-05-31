import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    id: container
    width: 200
    height: 18

    property color bgColor: "grey"
    property color color: "green"
    property double value: 50
    property double from: 0
    property double to: 100
    ProgressBar {
        id: progressBar
        from: container.from
        to: container.to
        value: container.value
        //                padding: 2
        height: container.height
        wheelEnabled: true
        anchors.left: container.left
        anchors.right: container.right

        background: Rectangle {
            color: container.bgColor
            radius: 2
        }

        contentItem: Item {
            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: container.height
                radius: 2
                color: container.color
            }
        }

    }
}
