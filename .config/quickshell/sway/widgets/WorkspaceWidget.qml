import QtQuick
import QtQuick.Layouts
import qs.sway

Item {
    id: swayWorkspaces
    width: workspacesRowLayout.width
    height: workspacesRowLayout.height

    RowLayout {
        id: workspacesRowLayout
        anchors.verticalCenter: parent.verticalCenter
        Repeater {
            model: Workspace.workspaces
            Item {
                property bool isActive: Workspace.focusedWorkspace === (index + 1)
                Layout.preferredWidth: isActive ? 16 : 8
                Layout.preferredHeight: 20
                Image {
                    anchors.centerIn: parent
                    height: isActive ? 8 : 4
                    source: isActive ? "pill.png" : "ball.png"
                    fillMode: Image.PreserveAspectFit
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: Workspace.switchToWorkspace(index + 1)
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        onWheel: wheel => {
            let next = Workspace.focusedWorkspace;
            if (wheel.angleDelta.y > 0)
                next = Math.min(Workspace.workspaces, next + 1);
            else if (wheel.angleDelta.y < 0)
                next = Math.max(1, next - 1);
            if (next !== Workspace.focusedWorkspace)
                Workspace.switchToWorkspace(next);
        }
        onClicked: mouse => {
            mouse.accepted = false;
        }
    }
}
