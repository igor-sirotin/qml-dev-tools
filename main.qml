import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    color: "grey"

    Item {
        id: content
        anchors.fill: parent

        RowLayout {
            anchors.centerIn: parent
            anchors.margins: 10

            ColumnLayout {

                Label {
                    Layout.fillWidth: true
                    horizontalAlignment: Label.AlignHCenter
                    text: "Test label"
                }

                Button {
                    text: "Button 1"
                }
                Button {
                    text: "Button 2"
                }
            }
            ColumnLayout {
                Label {
                    Layout.fillWidth: true
                    horizontalAlignment: Label.AlignHCenter
                    text: "Test label"
                }

                Button {
                    text: "Button 3"
                }
                Button {
                    text: "Button 4"
                }
            }
        }
    }


    MouseArea {
        id: devTools
        anchors.fill: parent
        hoverEnabled: true

        function findItemAt(item, point) {

            console.log(item, point);

            const child = item.childAt(point.x, point.y);

            if (!child)
                return null;

            const childPoint = child.mapFromItem(item, point);
            const subitem = findItemAt(child, childPoint);

            if (subitem)
                return subitem

            return item;
        }

        onPositionChanged: {
            console.info("<--- start -->")
            const point = content.mapFromItem(this, Qt.point(mouse.x, mouse.y));
            overlay.item = findItemAt(content, point);
        }

        Item {
            id: overlay

            property Item item: null

            width: item ? item.width : 0
            height: item ? item.height : 0
            x: item ? devTools.mapFromItem(item, 0, 0).x : 0
            y: item ? devTools.mapFromItem(item, 0, 0).y : 0

            Rectangle {
                anchors.fill: parent
                color: "hotpink"
                opacity: 0.3
            }

            ColumnLayout {
                anchors.centerIn: parent

                Label {
                    Layout.fillWidth: true
                    horizontalAlignment: Label.AlignHCenter
                    text: overlay.item ? overlay.item.toString() : ""
                }

                Label {
                    Layout.fillWidth: true
                    horizontalAlignment: Label.AlignHCenter
                    text: overlay.item ? overlay.parent.width + "*" + overlay.item.height
                                       : ""
                }
            }
        }
    }

}
