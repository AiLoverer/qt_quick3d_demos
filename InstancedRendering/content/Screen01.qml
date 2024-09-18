/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

import QtQuick 6.2
import QtQuick.Controls 6.2
import InstancedRendering
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
                id: directionalLight
                eulerRotation.x: -30
                eulerRotation.y: -70
                ambientColor: Qt.rgba(0.5, 0.5, 0.5, 1.0)
            }

            PerspectiveCamera {
                position: Qt.vector3d(0, 0, 300)
                clipNear: 1.0
                NumberAnimation on z {
                    from: 300
                    to: 0
                    duration: 10 * 1000
                }
            }
            //! [randomInstancing]
            RandomInstancing {
                id: randomInstancing
                instanceCount: 1500

                position: InstanceRange {
                    from: Qt.vector3d(-300, -200, -500)
                    to: Qt.vector3d(300, 200, 200)
                }
                scale: InstanceRange {
                    from: Qt.vector3d(1, 1, 1)
                    to: Qt.vector3d(10, 10, 10)
                    proportional: true
                }
                rotation: InstanceRange {
                    from: Qt.vector3d(0, 0, 0)
                    to: Qt.vector3d(360, 360, 360)
                }
                color: InstanceRange {
                    from: "grey"
                    to: "white"
                    proportional: true
                }

                randomSeed: 2021
            }
            //! [randomInstancing]
            //! [manualInstancing]
            InstanceListEntry {
                id: redShip
                position: Qt.vector3d(50, 10, 100)
                eulerRotation: Qt.vector3d(0, 180, 0)
                color: "red"
                NumberAnimation on position.x {
                    from: 50
                    to: -70
                    duration: 8000
                }
            }

            InstanceListEntry {
                id: greenShip
                position: Qt.vector3d(0, 0, -60)
                eulerRotation: Qt.vector3d(-10, 0, 30)
                color: "green"
            }

            InstanceListEntry {
                id: blueShip
                position: Qt.vector3d(-100, -100, 0)
                color: "blue"
            }

            InstanceList {
                id: manualInstancing
                instances: [ redShip, greenShip, blueShip ]
            }
            //! [manualInstancing]

            Model {
                id: asteroid
                source: "meshes/asteroid.mesh"

                PrincipledMaterial {
                    id: asteroid_material
                    baseColor: "#ffe0cc"
                    roughness: 0.5
                    cullMode: Material.NoCulling
                    alphaMode: PrincipledMaterial.Opaque
                }
                materials: [
                    asteroid_material
                ]
                instancing: randomInstancing
            }

            Model {
                id: ship
                eulerRotation.z: 90
                eulerRotation.x: 90
                scale: Qt.vector3d(15, 25, 15)
                source: "meshes/ship.mesh"

                PrincipledMaterial {
                    id: hull_material
                    baseColor: "#ff779ccc"
                    roughness: 0.15
                    cullMode: Material.NoCulling
                    alphaMode: PrincipledMaterial.Opaque
                }
                materials: [
                    hull_material
                ]
                instancing: manualInstancing
            }
        }
    }

}
