import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources

    // Nodes:
    property alias modelMaterial:defaultMaterial_material

    // Resources

    // Nodes:
    Node {
        x: -5.095
        y: 78.134
        eulerRotation.z: 22
        eulerRotation.y: 227
        eulerRotation.x: 24
        Node {
            id: drones_obj
            x: -27.763
            y: -24.502
            eulerRotation.x: -121
            eulerRotation.z: 0
            eulerRotation.y: -42
            z: -3.99778
            objectName: "Drones.obj"
            property real rotateTime: 500
            Model {
                id: object_1
                source: "meshes/object_1.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_2
                source: "meshes/object_2.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_3
                source: "meshes/object_3.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_4
                source: "meshes/object_4.mesh"
                materials: defaultMaterial_material
            }
            Node {
                x: 10.217
                y: 3.907
                z: -0.28853
                Model {
                    x: -9.799
                    y: -4.399
                    id: object_5
                    objectName: "object_5"
                    source: "meshes/object_5.mesh"
                    z: 0.39638
                    materials: [
                        defaultMaterial_material
                    ]
                }
                SequentialAnimation on eulerRotation.z {
                    loops: Animation.Infinite
                    running: true
                    PropertyAnimation {
                        duration: rotateTime
                        from: 0
                        to: 360
                    }
                }
            }

            Model {
                id: object_6
                source: "meshes/object_6.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_7
                source: "meshes/object_7.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_8
                source: "meshes/object_8.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_9
                source: "meshes/object_9.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_10
                source: "meshes/object_10.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_11
                source: "meshes/object_11.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_12
                source: "meshes/object_12.mesh"
                materials: defaultMaterial_material
            }
            Node {
                x: 45.819
                y: 44.541
                z: -2.6958
                Model {
                    id: object_13
                    x: -45.812
                    y: -44.298
                    objectName: "object_13"
                    source: "meshes/object_13.mesh"
                    z: 2.54618
                    materials: [
                        defaultMaterial_material
                    ]

                }
                SequentialAnimation on eulerRotation.z {
                    loops: Animation.Infinite
                    running: true
                    PropertyAnimation {
                        duration: rotateTime
                        from: 0
                        to: 360
                    }
                }
            }
            Model {
                id: object_14
                source: "meshes/object_14.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_15
                source: "meshes/object_15.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_16
                source: "meshes/object_16.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_17
                source: "meshes/object_17.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_18
                source: "meshes/object_18.mesh"
                materials: defaultMaterial_material
            }
            Node {
                x: 10.142
                y: 45.328
                z: -4.02018
                Model {
                    id: object_19
                    x: -10.063
                    y: -45.358
                    objectName: "object_19"
                    source: "meshes/object_19.mesh"
                    z: 4.28218
                    materials: [
                        defaultMaterial_material
                    ]
                }
                SequentialAnimation on eulerRotation.z {
                    loops: Animation.Infinite
                    running: true
                    PropertyAnimation {
                        duration: rotateTime
                        from: 0
                        to: 360
                    }
                }
            }
            Model {
                id: object_20
                source: "meshes/object_20.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_21
                source: "meshes/object_21.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_22
                source: "meshes/object_22.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_23
                source: "meshes/object_23.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_24
                source: "meshes/object_24.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_25
                source: "meshes/object_25.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_26
                source: "meshes/object_26.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_27
                source: "meshes/object_27.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_28
                source: "meshes/object_28.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_29
                source: "meshes/object_29.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_30
                source: "meshes/object_30.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_31
                source: "meshes/object_31.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_32
                source: "meshes/object_32.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_33
                source: "meshes/object_33.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_34
                source: "meshes/object_34.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_35
                source: "meshes/object_35.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_36
                source: "meshes/object_36.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_37
                source: "meshes/object_37.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_38
                source: "meshes/object_38.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_39
                source: "meshes/object_39.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_40
                source: "meshes/object_40.mesh"
                materials: defaultMaterial_material
            }
            Node {
                x: 45.168
                y: 3.711
                z: -4.2447
                Model {
                    id: object_41
                    x: -45.411
                    y: -3.988
                    objectName: "object_41"
                    source: "meshes/object_41.mesh"
                    z: 4.31535
                    materials: [
                        defaultMaterial_material
                    ]
                }
                SequentialAnimation on eulerRotation.z {
                    loops: Animation.Infinite
                    running: true
                    PropertyAnimation {
                        duration: rotateTime
                        from: 0
                        to: 360
                    }
                }
            }
            Model {
                id: object_42
                source: "meshes/object_42.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_43
                source: "meshes/object_43.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_44
                source: "meshes/object_44.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_45
                source: "meshes/object_45.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_46
                source: "meshes/object_46.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_47
                source: "meshes/object_47.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_48
                source: "meshes/object_48.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_49
                source: "meshes/object_49.mesh"
                materials: defaultMaterial_material
            }
            Model {
                id: object_50
                source: "meshes/object_50.mesh"
                materials: defaultMaterial_material
            }
        }

    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: defaultMaterial_material
            objectName: "defaultMaterial_material"
            baseColor: "#ff999999"
            roughness: 1
            indexOfRefraction: 1
        }
    }

    // Animations:
}
