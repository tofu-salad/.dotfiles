import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets

RowLayout {
    spacing: 4

    Repeater {
        model: SystemTray.items

        Item {
            required property var modelData

            Layout.preferredWidth: 16
            Layout.preferredHeight: 16

            IconImage {
                anchors.fill: parent
                source: modelData.icon
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        modelData.activate();
                    } else if (mouse.button === Qt.RightButton) {
                        var pos = mapToItem(w.contentItem, mouse.x + 8, mouse.y);
                        modelData.display(w, pos.x, pos.y);
                    } else if (mouse.button === Qt.MiddleButton) {
                        modelData.secondaryActivate();
                    }
                }

                onWheel: wheel => {
                    modelData.scroll(wheel.angleDelta.y, wheel.orientation === Qt.Horizontal);
                }
            }
        }
    }
}
