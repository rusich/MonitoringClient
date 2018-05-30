import QtQuick 2.0
import QtQml 2.2

Item {
    id: rpg

    width: size
    height: size

    property int size: 200               // The size of the circle in pixel
    property double inPercent: 0
    property real arcBegin: 0            // start arc angle in degree
    property real arcEnd: 360*inPercent/100            // end arc angle in degree
    property real arcOffset: -180           // rotation
    property bool showBackground: true  // a full circle as a background of the arc
    property real lineWidth: 10          // width of the line
    property color colorCircle
    property color colorBackground: "grey"

    property alias beginAnimation: animationArcBegin.enabled
    property alias endAnimation: animationArcEnd.enabled

    property int animationDuration: 200

    onArcBeginChanged: canvas.requestPaint()
    onArcEndChanged: canvas.requestPaint()

    Behavior on arcBegin {
       id: animationArcBegin
       enabled: true
       NumberAnimation {
           duration: rpg.animationDuration
           easing.type: Easing.InOutCubic
       }
    }

    Behavior on arcEnd {
       id: animationArcEnd
       enabled: true
       NumberAnimation {
           duration: rpg.animationDuration
           easing.type: Easing.InOutCubic
       }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: -90 + parent.arcOffset

        onPaint: {
            var ctx = getContext("2d")
            var x = width / 2
            var y = height / 2
            var start = Math.PI * (parent.arcBegin / 180)
            var end = Math.PI * (parent.arcEnd / 180)
            ctx.reset()

                if (rpg.showBackground) {
                    ctx.beginPath();
                    ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
                    ctx.lineWidth = rpg.lineWidth
                    ctx.strokeStyle = rpg.colorBackground
                    ctx.stroke()
                }
                ctx.beginPath();
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
                ctx.lineWidth = rpg.lineWidth
                ctx.strokeStyle = rpg.colorCircle
                ctx.stroke()
            }
        }
    }
