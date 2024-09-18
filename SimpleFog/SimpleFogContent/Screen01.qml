

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.5
import QtQuick.Controls 6.5
import SimpleFog
import QtQuick3D 6.5
import QtQuick3D.Helpers
import QtQuick.Layouts
import QtQuick.Dialogs

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    Item {
        id: __materialLibrary__

        PrincipledMaterial {
            id: principledMaterial
            objectName: "New Material"
        }
    }

    View3D {
        id: view3D
        anchors.fill: parent

        //! [fogitem]
        Fog {
            id: theFog

            enabled: cbFogEnabled.checked
            depthEnabled: cbDepthEnabled.checked
            heightEnabled: cbHeightEnabled.checked
            transmitEnabled: cbTransmitEnabled.checked

            density: valDensity.value
            depthNear: valDepth.first.value
            depthFar: valDepth.second.value
            depthCurve: valDepthCurve.value
            leastIntenseY: valHeightMin.value
            mostIntenseY: valHeightMax.value
            heightCurve: valHeightCurve.value
            transmitCurve: valTransmitCurve.value
        }
        //! [fogitem]

        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            backgroundMode: SceneEnvironment.Color
            clearColor: theFog.color
            fog: theFog
        }

        PerspectiveCamera {
            id: camera
            z: 300

            SequentialAnimation {
                running: cbAutoMove.checked
                loops: -1
                NumberAnimation {
                    target: camera
                    property: "z"
                    from: 600
                    to: -600
                    duration: 5000
                }
                NumberAnimation {
                    target: camera
                    property: "z"
                    from: -600
                    to: 600
                    duration: 5000
                }
            }
        }
        DirectionalLight {
        }

        PointLight {
            y: 100
        }

        Model {
            source: "#Rectangle"
            eulerRotation.x: -75
            y: -200
            scale: Qt.vector3d(100, 100, 100)
            materials: PrincipledMaterial {
                baseColor: "green"
            }
        }
        RandomInstancing {
            id: randomInstancing
            instanceCount: 2000

            position: InstanceRange {
                from: Qt.vector3d(-500, -300, 0)
                to: Qt.vector3d(500, 300, -2000)
            }
            scale: InstanceRange {
                from: Qt.vector3d(1, 1, 1)
                to: Qt.vector3d(50, 50, 50)
            }
            rotation: InstanceRange {
                from: Qt.vector3d(0, 0, 0)
                to: Qt.vector3d(180, 180, 180)
            }
            color: InstanceRange {
                from: "#000000"
                to: "#ffffff"
            }
            randomSeed: 2022
        }
        Model {
            instancing: randomInstancing
            source: "#Sphere"
            materials: PrincipledMaterial { }
            scale: Qt.vector3d(0.005, 0.005, 0.005)
        }
        WasdController {
            controlledObject: camera
        }
    }
    Rectangle {
        color: "lightGray"
        width: 350
        height: parent.height - 40
        anchors.verticalCenter: parent.verticalCenter
        x: 8
        radius: 8
        ColumnLayout {
            anchors.centerIn: parent
            GroupBox {
                title: "Fog"
                ColumnLayout {
                    RowLayout {
                        CheckBox {
                            id: cbFogEnabled
                            text: "Enabled"
                            checked: true
                        }
                        Button {
                            text: "Color: " + theFog.color
                            onClicked: colorDialog.open()
                        }
                    }
                }
            }
            GroupBox {
                title: "Depth Fog"
                ColumnLayout {
                    CheckBox {
                        id: cbDepthEnabled
                        text: "Enabled"
                        checked: true
                    }
                    RowLayout {
                        Label {
                            text: "Density"
                        }
                        Slider {
                            id: valDensity
                            focusPolicy: Qt.NoFocus
                            from: 0.0
                            to: 1.0
                            value: 1.0
                        }
                        Label {
                            text: valDensity.value.toFixed(2)
                        }
                    }
                    RowLayout {
                        Label {
                            text: "Near/Far"
                        }
                        RangeSlider {
                            id: valDepth
                            focusPolicy: Qt.NoFocus
                            from: -1000.0
                            to: 1000.0
                            first.value: 10.0
                            second.value: 1000.0
                        }
                    }
                    Label {
                        text: "Near: " + valDepth.first.value.toFixed(2) + " Far: " + valDepth.second.value.toFixed(2)
                    }
                    RowLayout {
                        Label {
                            text: "Curve"
                        }
                        Slider {
                            id: valDepthCurve
                            focusPolicy: Qt.NoFocus
                            from: 0.0
                            to: 1.0
                            value: 1.0
                        }
                        Label {
                            text: valDepthCurve.value.toFixed(2)
                        }
                    }
                }
            }
            GroupBox {
                title: "Height Fog"
                ColumnLayout {
                    CheckBox {
                        id: cbHeightEnabled
                        text: "Enabled"
                        checked: false
                    }
                    RowLayout {
                        Label {
                            text: "Least Intense Y"
                        }
                        Slider {
                            id: valHeightMin
                            focusPolicy: Qt.NoFocus
                            from: -1000.0
                            to: 1000.0
                            value: 10.0
                        }
                    }
                    RowLayout {
                        Label {
                            text: "Most Intense Y"
                        }
                        Slider {
                            id: valHeightMax
                            focusPolicy: Qt.NoFocus
                            from: -1000.0
                            to: 1000.0
                            value: 0.0
                        }
                    }
                    Label {
                        text: "Least intense Y: " + valHeightMin.value.toFixed(2) + " Most intense Y: " + valHeightMax.value.toFixed(2)
                    }
                    RowLayout {
                        Label {
                            text: "Curve"
                        }
                        Slider {
                            id: valHeightCurve
                            focusPolicy: Qt.NoFocus
                            from: 0.0
                            to: 100.0
                            value: 1.0
                        }
                        Label {
                            text: valHeightCurve.value.toFixed(2)
                        }
                    }
                }
            }
            GroupBox {
                title: "Light Transmission"
                ColumnLayout {
                    CheckBox {
                        id: cbTransmitEnabled
                        text: "Enabled"
                        checked: false
                    }
                    RowLayout {
                        Label {
                            text: "Curve"
                        }
                        Slider {
                            id: valTransmitCurve
                            focusPolicy: Qt.NoFocus
                            from: 0.0
                            to: 100.0
                            value: 1.0
                        }
                        Label {
                            text: valTransmitCurve.value.toFixed(2)
                        }
                    }
                }
            }
        }
    }
    Item {
        width: debugViewToggleText.implicitWidth
        height: debugViewToggleText.implicitHeight
        anchors.right: parent.right
        Label {
            id: debugViewToggleText
            text: "Click here " + (dbg.visible ? "to hide DebugView" : "for DebugView")
            anchors.right: parent.right
            anchors.top: parent.top
        }
        MouseArea {
            anchors.fill: parent
            onClicked: dbg.visible = !dbg.visible
            DebugView {
                y: debugViewToggleText.height * 2
                anchors.right: parent.right
                source: view3D
                id: dbg
                visible: false
            }
        }
    }

    CheckBox {
        id: cbAutoMove
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: "Auto Move"
        checked: true
    }
    ColorDialog {
        id: colorDialog
        selectedColor: theFog.color
        onAccepted: theFog.color = selectedColor
    }
}

/*##^##
Designer {
    D{i:0}D{i:3;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}D{i:6;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/
