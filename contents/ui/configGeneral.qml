import QtQuick 2
import QtQuick.Controls 2
import QtQuick.Layouts 1
import org.kde.plasma.core 2 as PlasmaCore
import org.kde.kquickcontrolsaddons 2 as KQuickAddons

Item {
    id: page
    property alias cfg_defaultIcon: defaultIcon.checked
    property alias cfg_foo: fooo.foo
    KQuickAddons.IconDialog {
        id: iconDialog

        function setCustomButtonImage(image) {
            configGeneral.cfg_customButtonImage = image || configGeneral.cfg_icon || "start-here-kde"
            configGeneral.cfg_useCustomButtonImage = true;
        }

        onIconNameChanged: setCustomButtonImage(iconName);
    }

    Column{

        RadioButton {
        id: defaultIcon
        text: qsTr("foo")
        }

        RadioButton {
            text: "bar"
            Row{
                enabled: !defaultIcon.checked
                anchors.top: parent.bottom
                anchors.left: parent.right
                spacing: 10

                Label {
                    text: "label"
                    anchors.verticalCenter: parent.verticalCenter
                }
                Button {
                    id: fooo
                    property string foo
                    onClicked: console.log(foo)
                    property var margin: 15
                    width: PlasmaCore.Units.iconSizes.large + margin
                    height: PlasmaCore.Units.iconSizes.large + margin
                    PlasmaCore.SvgItem {
                        id: svgItem
                        width: PlasmaCore.Units.iconSizes.large
                        height: PlasmaCore.Units.iconSizes.large
                        anchors.centerIn: parent
                        smooth: true
                        svg: PlasmaCore.Svg {
                            id: svg
                            imagePath: plasmoid.file('', 'ui/comp-on.svg')
                        }
                    }
                }
            }

        }
    }
}
