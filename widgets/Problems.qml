import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "../functions.js" as JS

Item {
    id: item1
    width: 200
    height: 200

    ListModel {
        id: problemModel
    }

    WidgetTemplate {
        id: widgetTemplate
        anchors.fill: parent
        caption: "Проблемы"

        ListView {
            id: problemsList
            anchors.fill: parent
            anchors.topMargin: 30
            anchors.bottomMargin: 15
            anchors.leftMargin: 9
            anchors.rightMargin: 9

            model: problemModel
            delegate: problemDelegate
        }
    }

    Component {
        id: problemDelegate
        RowLayout
        {
            width: parent.width
            height: problem.height + 10

            Text {
                id: problem
                color: "white"
                font.pixelSize: 11
                text: host?host.triggersCount>0?"<b>"+datetime+"</b>:" + " " + description
                                               +" ("+triggerid+")":
                                            "Ура, проблем нет!":"Ура, проблем нет!"
                wrapMode: Text.Wrap
                Layout.fillWidth: true
            }
        }
    }

    function displayTriggers(hostname) {
        if(hostname===host.host){
            problemModel.clear();
            if(host.triggersCount>0)
            {
                widgetTemplate.bgColor = "#d15963";
                for(var i=0; i < host.triggersCount; i++){
                    console.log(JSON.stringify(host.triggers[i]));
                    problemModel.append({"datetime":
                                        JS.tsToDT(host.triggers[i].lastchange),
                                        "description":
                                        host.triggers[i].description,
                                        "triggerid":
                                        host.triggers[i].triggerid});
                }

            }
            else {
                widgetTemplate.bgColor = widgetBgColor;
            }
        }
    }

    Connections {
        target: backend?backend:null
        onHostUpdated: displayTriggers(hostname)
    }
}
