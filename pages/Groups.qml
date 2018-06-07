import QtQuick 2.10
import QtQuick.Controls 2.3
import "qrc:/widgets"
import "qrc:/pages"
import QtQuick.Layouts 1.3
import "../functions.js" as JS

Page {

    width: 1010
    height: 630
    anchors.fill: parent
    title: "Группы устройств"


    GridLayout {
        id: gridLayout
        rows: 2
        anchors.topMargin: 22
        anchors.leftMargin: 27
        anchors.bottomMargin: 0
        anchors.fill: parent
        columns: 4
        visible: backend.currentStatus

        HostsGroup {
            groupimg.source: "qrc:/images/server_icon.png"
            groupimg.width: 120
            groupimg.height: 120
            caption: "Home"
            onClicked: JS.nextPage("qrc:/pages/Servers.qml", {"title": caption});

        }
        HostsGroup {
            caption: "КАСО Топаз-2000"
            groupimg.source: "qrc:/images/topaz.png"
        }

        HostsGroup {
            caption: "АРП DF2000"
            groupimg.source: "qrc:/images/df200.png"
        }

        HostsGroup {
            caption: "Видеонаблюдение"
            groupimg.source: "qrc:/images/nvr.png"
        }
    }
}
