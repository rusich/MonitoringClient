import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../functions.js" as JS

Item {

    id: item1
    width: 500
    height: 200
    property alias graphid: graphimg.graphid
    property int period

    WidgetTemplate {
        id: widgetTemplate
        anchors.rightMargin: 0
        anchors.bottomMargin:0
        anchors.fill: parent
        caption: "График"
        Image {
            id: graphimg
            property string graphid
            anchors.fill: parent
            anchors.topMargin: 0
            anchors.bottomMargin: 15
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            width: parent.width - anchors.leftMargin - anchors.rightMargin
            height: parent.height - anchors.topMargin - anchors.bottomMargin
//            fillMode: Image.PreserveAspectCrop
            verticalAlignment: Image.AlignTop

            MouseArea {
                anchors.fill: parent
                onClicked:
                {
                    console.log(graphid);
                    backend.getGraph(graphid,
                                     period,
                                     graphimg.width,
                                     graphimg.height);
                }
            }
        }

    }
    Connections {
        target: backend?backend:null
        onGraphUpdated:  {
           console.log(graph.graphid);
           console.log(graph.name);
           if(graph.graphid === graphid)
           {
//               widgetTemplate.caption = graph.name;
               graphimg.source = "data:image/png;base64," + graph.data;
               widgetTemplate.lastUpdatedInfo = graph.clock;
           }
        }
    }
}
