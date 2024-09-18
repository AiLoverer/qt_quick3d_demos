import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D

Item {
    width: 1920
    height: 720

    Item {
        id: __materialLibrary__

        PrincipledMaterial {
            id: principledMaterial
            objectName: "New Material"
            baseColor: "red"
        }
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
                eulerRotation.z: -80.25268
                eulerRotation.y: 55.59676
                eulerRotation.x: -18.16998
            }

            PerspectiveCamera {
                id: sceneCamera
                x: -0.734
                y: 255.323
                position: Qt.vector3d(0, 200, 300)
                z: 402.72238
                eulerRotation.x: -30
            }

            Model {
                id: cubeModel
                x: 0.158
                y: -231.675
                position: Qt.vector3d(0, -200, 0)
                scale: Qt.vector3d(2, 0.2, 1)
                source: "#Cylinder"
                eulerRotation.z: -176.06035
                z: 0.15788
                materials: principledMaterial
                eulerRotation.y: -166.77368
                eulerRotation.x: -12.27559
            }

            Model {
                position: Qt.vector3d(0, 150, 0)
                source: "#Sphere"

                materials: [ DefaultMaterial {
                        diffuseColor: "blue"
                    }
                ]

                SequentialAnimation on y {
                    loops: Animation.Infinite
                    NumberAnimation {
                        duration: 3000
                        to: -150
                        from: 150
                        easing.type:Easing.InQuad
                    }
                    NumberAnimation {
                        duration: 3000
                        to: 150
                        from: -150
                        easing.type:Easing.OutQuad
                    }
                }
            }
        }
    }
}
