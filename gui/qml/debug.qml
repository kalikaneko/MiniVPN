import QtQuick 2.3
import QtQuick.Controls 1.4

Rectangle {

    width: 400
    height: 200

    TreeView {
            id: treeView
            model: jsonModel
            anchors.left: parent.left
            anchors.right: parent.right

            TableViewColumn {
                id: keyCol
                title: "key"
                role: "key"
                width: 100
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
