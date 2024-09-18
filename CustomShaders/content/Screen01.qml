

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import CustomShaders
import QtQuick3D 6.2

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    ComponentMaterialController {
        id: control
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    View3D {
        id: view3D
        anchors.fill: parent
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }

        Node {
            id: scene
            DirectionalLight {
                id: directionalLight
            }

            PerspectiveCamera {
                id: sceneCamera
                z: 350
            }

            Model {
                id: cubeModel
                source: "#Sphere"
                scale: Qt.vector3d(2, 2, 2)
                NumberAnimation on eulerRotation.y {
                    from: 0
                    to: 360
                    duration: 3000
                    loops: -1
                    running: control.animateRotation
                }
                position: Qt.vector3d(0, 0, 0)
                materials: [
                    ExampleMaterial {
                        id: exampleMaterial
                        time: control.time
                        amplitude: control.amplitude
                        alpha: control.alpha
                        texturing: control.texturing
                        textureFromItem: control.textureFromItem
                        texSrc: Rectangle {
                            layer.enabled: true
                            layer.textureMirroring: ShaderEffectSource.NoMirroring
                            visible: false
                            SequentialAnimation on color {
                                ColorAnimation { from: "black"; to: "yellow"; duration: 2000 }
                                ColorAnimation { from: "yellow"; to: "cyan"; duration: 1000 }
                                ColorAnimation { from: "cyan"; to: "black"; duration: 500 }
                                loops: -1
                            }
                            width: 512
                            height: 512
                            Image {
                                source: "images/qt_logo.png"
                                anchors.centerIn: parent
                            }
                        }
                    }
                ]
            }
        }
    }

    Item {
        id: __materialLibrary__
    }
}
