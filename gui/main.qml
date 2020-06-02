import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 200
    height: 200

    property var ctx
    
    MouseArea {
	anchors.fill: parent
	onClicked: {
	    Qt.quit();
	}
    }

    Text {
        x: 20
        y: 20
        font.pixelSize: 40
        text: ctx ? ctx.status : ""
    }

    Button {
        id: onBtn
        x: 20
        y: 80
        text: qsTr("on")

        onClicked: backend.switchOn()
    }

    Button {
        id: offBtn
        x: 80
        y: 80
        text: qsTr("off")

        onClicked: backend.switchOff()
    }

    Loader {
        id: treeview
        x: 0
        y: 120
    }

    Component.onCompleted: {
        treeview.source = debugModel ? "debug.qml" : "";
        console.log("qml initialization completed");
    }

    Connections {
        target: jsonModel
        onDataChanged: {
            ctx = JSON.parse(jsonModel.getJson());
        }
    }
}
