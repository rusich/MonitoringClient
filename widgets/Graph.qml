import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../functions.js" as JS

Item {

    id: item1
    width: 200
    height: 100
    property alias caption: widgetTemplate.caption
    property alias graphid: graphimg.graphid


    WidgetTemplate {
        id: widgetTemplate
        anchors.fill: parent

        Image {
            id: graphimg
            property string graphid: "1160"
            anchors.fill: parent
            anchors.topMargin: 1
            anchors.bottomMargin: 15
            anchors.leftMargin: 9
            anchors.rightMargin: 9
            width: parent.width - anchors.leftMargin - anchors.rightMargin
            height: parent.height - anchors.topMargin - anchors.bottomMargin
//            fillMode: Image.PreserveAspectCrop
            verticalAlignment: Image.AlignTop

            MouseArea {
                anchors.fill: parent
                onClicked:
                {
                    console.log(graphimg.width);
                    backend.getGraph(graphid,
                                     3600,
                                     graphimg.width,
                                     graphimg.height-(graphimg.height*0.2));
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
               caption = graph.name;
                graphimg.source = "data:image/png;base64," + graph.data;
               widgetTemplate.lastUpdatedInfo = graph.clock;
           }
        }
    }
}
