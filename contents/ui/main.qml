import QtQuick 2.5

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.kwindowsystem 1.0

Item {
    id: root

    readonly property bool compActive: kwindowsystem.compositingActive
    Plasmoid.icon: compActive ? 'composite-track-on' : 'composite-track-off'

    KWindowSystem {
        id: kwindowsystem
    }

    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: {
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            exited(sourceName, exitCode, exitStatus, stdout, stderr)
            disconnectSource(sourceName)
        }
        function exec(cmd) {
            if (cmd) {
                connectSource(cmd)
            }
        }
        signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
    }

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.compactRepresentation: PlasmaCore.IconItem {
        active: compactMouseArea.containsMouse
        source: plasmoid.icon

        MouseArea {
            id: compactMouseArea
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            onClicked: toggleCompositing();
        }
    }

    Plasmoid.toolTipMainText: "Toggle Compositing"
    Plasmoid.toolTipSubText: {
        return "Compositing is " + (compActive ? "enabled" : "disabled");
    }

    function toggleCompositing() {
        var action = compActive ? "suspend" : "resume";
        executable.exec("qdbus org.kde.KWin /Compositor " + action);
    }
}
