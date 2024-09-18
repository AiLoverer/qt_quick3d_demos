import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Page {
    id: settingsDrawer
    default property alias content: contentLayout.children
    required property bool isLandscape
    readonly property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"

    property bool isOpen: isMobile ? false : true

    title: "Settings"

    onIsLandscapeChanged: updateState();
    Component.onCompleted: updateState();
    onIsOpenChanged: updateState();

    x: 0
    y: 0

    function updateState() {
        if(isOpen) {
            if(isLandscape)
                settingsDrawer.state = "Landscape_Visible"
            else
                settingsDrawer.state = "Portrait_Visible"
        }else {
            if(isLandscape)
                settingsDrawer.state = "Landscape_Hidden"
            else
                settingsDrawer.state = "Portrait_Hidden"
        }
    }

    states: [
        State {
            name: "Landscape_Visible"
            PropertyChanges {
                settingsDrawer.x: 0

            }
        },
        State {
            name: "Landscape_Hidden"
            PropertyChanges {
                settingsDrawer.x: -settingsDrawer.width

            }
        },
        State {
            name: "Portrait_Visible"
            PropertyChanges {
                settingsDrawer.y: 0

            }
        },
        State {
            name: "Portrait_Hidden"
            PropertyChanges {
                settingsDrawer.y: -settingsDrawer.height

            }
        }
    ]

    transitions: [
        Transition {
            from: "Landscape_Visible"
            to: "Landscape_Hidden"
            NumberAnimation {
                duration: 400
                property: "x"
                easing.type: Easing.InOutQuad
            }

        },
        Transition {
            from: "Landscape_Hidden"
            to: "Landscape_Visible"
            NumberAnimation {
                duration: 400
                property: "x"
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "Portrait_Visible"
            to: "Portrait_Hidden"
            NumberAnimation {
                duration: 400
                property: "y"
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "Portrait_Hidden"
            to: "Portrait_Visible"
            NumberAnimation {
                duration: 400
                property: "y"
                easing.type: Easing.InOutQuad
            }
        }
    ]

    header: Label {
        text: settingsDrawer.title
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 20
    }

    ScrollView {
        anchors.fill: parent
        padding: 10

        ColumnLayout {
            id: contentLayout
        }
    }
}
