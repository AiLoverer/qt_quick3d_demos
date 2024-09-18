

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import QuickItems
import QtQuick3D 6.2

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
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            clearColor: "#808080"
            backgroundMode: SceneEnvironment.Color
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }
        PerspectiveCamera {
            id: camera
            property real cameraAnimation: 1
            SequentialAnimation {
                loops: Animation.Infinite
                running: true
                NumberAnimation {
                    target: camera
                    property: "cameraAnimation"
                    to: -1
                    duration: 5000
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: camera
                    property: "cameraAnimation"
                    to: 1
                    duration: 5000
                    easing.type: Easing.InOutQuad
                }
            }
            position: Qt.vector3d(200 * cameraAnimation, 300, 500)
            eulerRotation.x: -20
            eulerRotation.y: 20 * cameraAnimation
        }
        DirectionalLight {
            id: directionalLight
            eulerRotation: Qt.vector3d(-135, -110, 0)
            brightness: 1
        }
        SpotLight {
            position: Qt.vector3d(0, 500, 600)
            eulerRotation.x: -45
            brightness: 30
        }

        //! [walls models]
        Model {
            source: "#Rectangle"
            y: -500
            scale: Qt.vector3d(12, 12, 12)
            eulerRotation.x: -90
            materials: DefaultMaterial {
                diffuseColor: Qt.rgba(0.5, 0.5, 0.5, 1.0)
            }
        }
        Model {
            source: "#Rectangle"
            x: -600
            scale: Qt.vector3d(12, 10, 12)
            eulerRotation.y: 90
            materials: DefaultMaterial {
                diffuseColor: Qt.rgba(0.8, 0.8, 0.6, 1.0)
            }
        }
        Model {
            source: "#Rectangle"
            z: -600
            scale: Qt.vector3d(12, 10, 12)
            materials: DefaultMaterial {
                diffuseColor: Qt.rgba(0.8, 0.8, 0.6, 1.0)
            }
        }
        //! [walls models]
        //! [background item]
        Node {
            position: Qt.vector3d(0, 100, -120)
            Item {
                width: 400
                height: 400
                anchors.centerIn: parent
                Rectangle {
                    anchors.fill: parent
                    opacity: 0.4
                    color: "#202020"
                    radius: 10
                    border.width: 2
                    border.color: "#f0f0f0"
                }
                Text {
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    color: "#e0e0e0"
                    style: Text.Raised
                    text: qsTr("Background Item")
                }
                Image {
                    anchors.centerIn: parent
                    source: "Built_with_Qt_RGB_logo_vertical"
                }
            }
        }
        //! [background item]
        //! [circles item]
        Node {
            position: Qt.vector3d(0, 150, 100)
            SequentialAnimation on x {
                loops: Animation.Infinite
                NumberAnimation {
                    to: -200
                    duration: 1500
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    to: 200
                    duration: 1500
                    easing.type: Easing.InOutQuad
                }
            }
            NumberAnimation on eulerRotation.z {
                loops: Animation.Infinite
                from: 0
                to: 360
                duration: 4000
                easing.type: Easing.InOutBack
            }
            Item {
                width: 400
                height: 400
                anchors.centerIn: parent
                // This allows rendering into offscreen surface and caching it.
                layer.enabled: true
                Rectangle {
                    x: 150
                    y: 100
                    width: 100
                    height: 100
                    radius: 50
                    color: "#80808020"
                    border.color: "black"
                    border.width: 2
                }
                Rectangle {
                    x: 90
                    y: 200
                    width: 100
                    height: 100
                    radius: 50
                    color: "#80808020"
                    border.color: "black"
                    border.width: 2
                }
                Rectangle {
                    x: 210
                    y: 200
                    width: 100
                    height: 100
                    radius: 50
                    color: "#80808020"
                    border.color: "black"
                    border.width: 2
                }
            }
        }
        //! [circles item]

        //! [text item]
        Node {
            position: Qt.vector3d(0, 80, 250)
            Text {
                anchors.centerIn: parent
                width: 300
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignJustify
                font.pixelSize: 14
                color: "#e0e0e0"
                style: Text.Raised
                text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod " +
                      "tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim " +
                      "veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea " +
                      "commodo consequat."
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation {
                        to: 0
                        duration: 1500
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        to: 1
                        duration: 1500
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
        //! [text item]

        //! [wrecking ball model]
        Node {
            position: Qt.vector3d(0, 800, 0)
            SequentialAnimation on eulerRotation.x {
                loops: Animation.Infinite
                NumberAnimation {
                    to: 20
                    duration: 3500
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    to: -20
                    duration: 3500
                    easing.type: Easing.InOutQuad
                }
            }
            Model {
                source: "#Cylinder"
                y: -300
                scale: Qt.vector3d(0.1, 6.1, 0.1)
                materials: DefaultMaterial {
                    diffuseColor: Qt.rgba(0.9, 0.9, 0.9, 1.0)
                }
            }
            Model {
                source: "#Sphere"
                y: -700
                scale: Qt.vector3d(2, 2, 2)
                materials: DefaultMaterial {
                    diffuseColor: Qt.rgba(0.4, 0.4, 0.4, 1.0)
                }
            }
        }
        //! [wrecking ball model]
    }
}
