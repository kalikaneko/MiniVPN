import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 360
    height: 360

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Button {
        id: onBtn
        x: 80
        y: 200
        text: qsTr("on")

        onClicked: backend.switchOn()
    }

    Button {
        id: offBtn
        x: 180
        y: 200
        text: qsTr("off")

        onClicked: backend.switchOff()
    }

    TreeView {
        id: treeView
        model: jsonModel
        anchors.left: parent.left
        anchors.right: parent.right

        TableViewColumn {
            id: keyCol
            title: "key"
            role: "key"
        }

        TableViewColumn {
            id: valueCol
            title: "value"
            role: "value"
            movable: true
            width: treeView.viewport.width - keyCol.width
        }
    }  
}
