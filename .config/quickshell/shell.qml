//@ pragma UseQApplication
import Quickshell
import qs.widgets
import qs.sway.widgets
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick

Scope {
    id: root
    property string fontFamily: "Adwaita Sans"
    property int fontSize: 14

    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: w
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 30
            color: "#000000FF"

            RowLayout {
                id: leftSection
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 10
                }
                spacing: 14

                Item {
                    Image {
                        height: 14
                        anchors.centerIn: parent
                        source: "g16.png"
                        fillMode: Image.PreserveAspectFit
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var proc = Qt.createQmlObject('import Quickshell.Io; Process { }', parent);
                                proc.command = ["uwsm", "app", "--", "fuzzel", "-a", "top-left", "--launch-prefix=uwsm app --"];
                                proc.running = true;
                            }
                        }
                    }
                }

                WorkspaceWidget {}
            }

            ClockWidget {
                anchors.centerIn: parent
                color: "white"
                font.family: root.fontFamily
                font.pixelSize: root.fontSize
            }

            RowLayout {
                id: rightSection
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }
                spacing: 14
                SystrayWidget {}
            }
        }
    }
}
