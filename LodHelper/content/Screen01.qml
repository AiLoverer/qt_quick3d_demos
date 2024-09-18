

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import LodHelper
import QtQuick3D 6.2
import QtQuick3D.Helpers

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
            clearColor: "black"
            backgroundMode: SceneEnvironment.Color
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }

        Node {
            id: scene
            DirectionalLight {
                eulerRotation.x: -30
                eulerRotation.y: -70
                ambientColor: Qt.rgba(0.5, 0.5, 0.5, 1.0)
            }

            PerspectiveCamera {
                id: camera
                position: Qt.vector3d(0, 10, 300)
                clipNear: 1.0
                NumberAnimation on z {
                    from: 200
                    to: -100
                    duration: 40 * 1000
                }
            }

            // Model {
            //     id: cubeModel
            //     source: "#Cube"
            //     materials: principledMaterial
            //     eulerRotation.y: 45
            //     eulerRotation.x: 30
            // }
            RandomInstancing {
                id: randomInstancing
                instanceCount: 800

                position: InstanceRange {
                    from: Qt.vector3d(-200, 0, -200)
                    to: Qt.vector3d(200, 1, 200)
                }
                scale: InstanceRange {
                    from: Qt.vector3d(10, 10, 10)
                    to: Qt.vector3d(10, 10, 10)
                }
                rotation: InstanceRange {
                    from: Qt.vector3d(0, 0, 0)
                    to: Qt.vector3d(0, 0, 0)
                }
                color: InstanceRange {
                    from: "grey"
                    to: "white"
                    proportional: true
                }

                randomSeed: 2021
            }
            LodManager {
                camera: camera
                distances: [50, 100, 150]

                Model {
                    instancing: randomInstancing
                    source: "#Sphere"
                    materials: [
                        PrincipledMaterial {
                            metalness: 0
                            roughness: 1
                            baseColor: "red"
                        }
                    ]
                    scale: Qt.vector3d(0.005, 0.005, 0.005)
                }

                Model {
                    instancing: randomInstancing
                    source: "#Cylinder"
                    materials: [
                        PrincipledMaterial {
                            metalness: 0
                            roughness: 1
                            baseColor: "orange"
                        }
                    ]
                    scale: Qt.vector3d(0.005, 0.005, 0.005)
                }

                Model {
                    instancing: randomInstancing
                    source: "#Cube"
                    materials: [
                        PrincipledMaterial {
                            metalness: 0
                            roughness: 1
                            baseColor: "yellow"
                        }
                    ]
                    scale: Qt.vector3d(0.005, 0.005, 0.005)
                }

                Model {
                    instancing: randomInstancing
                    source: "#Rectangle"
                    materials: [
                        PrincipledMaterial {
                            metalness: 0
                            roughness: 1
                            baseColor: "green"
                        }
                    ]
                    scale: Qt.vector3d(0.005, 0.005, 0.005)
                }
            }
            //! [example]
            LodManager {
                camera: camera
                distances: [100, 140, 180]
                fadeDistance: 10

                Model {
                    scale: Qt.vector3d(100, 100, 100);
                    source: "meshes/marble_bust_01_LOD_0.mesh"
                    materials: [ marbleMaterial ]
                }

                Model {
                    scale: Qt.vector3d(100, 100, 100);
                    source: "meshes/marble_bust_01_LOD_1.mesh"
                    materials: [ marbleMaterial ]
                }

                Model {
                    scale: Qt.vector3d(100, 100, 100);
                    source: "meshes/marble_bust_01_LOD_2.mesh"
                    materials: [ marbleMaterial ]
                }

                Model {
                    scale: Qt.vector3d(100, 100, 100);
                    source: "meshes/marble_bust_01_LOD_3.mesh"
                    materials: [ marbleMaterial ]
                }
            }
        }
        PrincipledMaterial {
            id: marbleMaterial
            baseColorMap: Texture {
                source: "maps/baseColor.png"
                generateMipmaps: true
                mipFilter: Texture.Linear
            }
            opacityChannel: Material.A
            metalnessMap: Texture {
                source: "maps/occlusionRoughnessMetallic.png"
                generateMipmaps: true
                mipFilter: Texture.Linear
            }
            metalnessChannel: Material.B
            roughnessMap: Texture {
                source: "maps/occlusionRoughnessMetallic.png"
                generateMipmaps: true
                mipFilter: Texture.Linear
            }
            roughnessChannel: Material.G
            metalness: 1
            roughness: 1
            normalMap: Texture {
                source: "maps/normal.png"
                generateMipmaps: true
                mipFilter: Texture.Linear
            }
        }
    }
}
