pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    property int focusedWorkspace: 1
    property int workspaces: 1

    function switchToWorkspace(num) {
        if (!num)
            return;
        switchWorkspaceProc.command = ["swaymsg", "workspace", "number", String(num)];
        switchWorkspaceProc.running = true;
    }

    Process {
        id: workspaceQueryProc
        command: ["sh", "-c", "swaymsg -t get_workspaces | jq -r '[(.[] | select(.focused==true).num), (map(.num) | max)] | @tsv'"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                const parts = data.trim().split("\t");
                if (parts.length >= 2) {
                    focusedWorkspace = parseInt(parts[0]) || focusedWorkspace;
                    workspaces = parseInt(parts[1]) || workspaces;
                }
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: workspaceMonitorProc
        command: ["swaymsg", "-t", "subscribe", "-m", "[\"workspace\"]"]
        stdout: SplitParser {
            onRead: data => workspaceQueryProc.running = true
        }
        Component.onCompleted: running = true
    }

    Process {
        id: switchWorkspaceProc
    }
}
