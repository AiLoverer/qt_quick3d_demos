

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import glTFAssets
import QtQuick3D 6.2
import Quick3DAssets.Sponza
import QtQuick3D.Helpers
import Quick3DAssets.Suzanne

Item {
    id: rectangle
    width: Constants.width
    height: Constants.height
    WasdController {
        controlledObject: sceneCamera
    }
    View3D {
        id: view3D
        anchors.fill: parent
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            // antialiasingQuality: SceneEnvironment.High
            // antialiasingMode: SceneEnvironment.MSAA
            // clearColor: "green"
            // backgroundMode: SceneEnvironment.Color
            backgroundMode: SceneEnvironment.SkyBox
            lightProbe: Texture {
                textureData: ProceduralSkyTextureData {}
            }
        }

        Node {
            id: scene
            DirectionalLight {
                id: directionalLight
                x: -6.256
                y: 269.572
                z: 0.7451
                eulerRotation.z: -0.00018
                eulerRotation.y: -83.20838
                eulerRotation.x: -86.10449
            }

            PerspectiveCamera {
                id: sceneCamera
                x: 397.194
                //z: 350
                y: 25.322
                eulerRotation.z: 0.00002
                eulerRotation.y: 90.14658
                eulerRotation.x: 0.6682
                z: 4.27741
            }

            Sponza {
                id: cubeModel
                x: -0.389
                y: -9.665
                z: 9.3978
                scale: Qt.vector3d(100, 100, 100)
            }

            Suzanne {
                x: 0
                scale: Qt.vector3d(50, 50, 50)
                y: 39.012
                eulerRotation.z: 0.00001
                eulerRotation.y: 90.65227
                eulerRotation.x: -0.00001
                z: 0

                NumberAnimation on eulerRotation.y {
                    from: 0
                    to: 360
                    duration: 3000
                    loops: Animation.Infinite
                }
            }
            PointLight {
                y: 200
                color: "#d9c62b"
                brightness: 5
                castsShadow: true
                shadowFactor: 75
                Model {
                    source: "#Cube"
                    scale: Qt.vector3d(0.01, 0.01, 0.01)
                    materials: PrincipledMaterial {
                        lighting: PrincipledMaterial.NoLighting
                    }
                }
            }

        }
    }

    Item {
        id: __materialLibrary__
    }
    Button {
        anchors.right: parent.right
        text: "Toggle DebugView"
        onClicked: debugView.visible = !debugView.visible
        DebugView {
            id: debugView
            source: view3D
            visible: false
            anchors.top: parent.bottom
            anchors.right: parent.right
        }

    }
}
