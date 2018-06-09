import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    id: container
    width: 200
    height: 18

    property color bgColor: "gray"
    property color color: "green"
    property double value: 0
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
            radius: 3
        }

        contentItem: Item {
            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: container.height
                radius: 3
                color: container.color
            }
        }

    }
}
