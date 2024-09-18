import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D 6.2

Item {
    width: 1920
    height: 1080

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
                id: cube
                source: "#Cube"
                materials: principledMaterial
                eulerRotation.y: 45
                eulerRotation.x: 30
                Node {
                    Model {
                        source: "#Sphere"
                        instanceRoot: cube
                        instancing: cube.instancing
                        x: 150
                        materials: DefaultMaterial { diffuseColor: "gray" }
                    }
                    NumberAnimation on eulerRotation.y {
                        from: 0
                        to: 360
                        duration: 4000
                        loops: Animation.Infinite
                    }
                }

                Node {
                    id: parentNode
                    Model {
                        source: "#Cylinder"
                        instanceRoot: parentNode
                        instancing: anotherInstanceTable
                        x:325
                        materials: DefaultMaterial { diffuseColor: "white" }
                    }
                    NumberAnimation on eulerRotation.y {
                        from: 0
                        to: 360
                        duration: 1000
                        loops: Animation.Infinite
                    }
                }
            }
        }
    }
}
