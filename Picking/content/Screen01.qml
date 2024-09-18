

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import Picking
import QtQuick3D 6.2

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    color: "#848895"
    Row {
        anchors.left: parent.left
        anchors.leftMargin: 8
        spacing: 10
        Column {
            Label {
                color: "white"
                font.pointSize: 14
                text: "Last Pick:"
            }
            Label {
                color: "white"
                font.pointSize: 14
                text: "Screen Position:"
            }
            Label {
                color: "white"
                font.pointSize: 14
                text: "UV Position:"
            }
            Label {
                color: "white"
                font.pointSize: 14
                text: "Distance:"
            }
            Label {
                color: "white"
                font.pointSize: 14
                text: "World Position:"
            }
            Label {
                color: "white"
                font.pointSize: 14
                text: "Local Position:"
            }

            Label {
                color: "white"
                font.pointSize: 14
                text: "World Normal:"
            }
            Label {
                color: "white"
                font.pointSize: 14
                text: "Local Normal:"
            }
        }
        Column {
            Label {
                id: pickName
                color: "white"
                font.pointSize: 14
            }
            Label {
                id: pickPosition
                color: "white"
                font.pointSize: 14
            }
            Label {
                id: uvPosition
                color: "white"
                font.pointSize: 14
            }
            Label {
                id: distance
                color: "white"
                font.pointSize: 14
            }
            Label {
                id: scenePosition
                color: "white"
                font.pointSize: 14
            }
            Label {
                id: localPosition
                color: "white"
                font.pointSize: 14
            }
            Label {
                id: worldNormal
                color: "white"
                font.pointSize: 14
            }
            Label {
                id: localNormal
                color: "white"
                font.pointSize: 14
            }
        }
    }

    View3D {
        id: view3D
        anchors.fill: parent
        //renderMode: View3D.Underlay
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }

        Node {
            id: scene
            PointLight {
                x: -200
                y: 200
                z: 300
                quadraticFade: 0
                brightness: 1.5
            }

            PerspectiveCamera {
                id: sceneCamera
                z: 500
            }

            Model {
                id: cubeModel
                objectName: "Cube"
                source: "#Cube"
                eulerRotation.y: 45
                eulerRotation.x: 30
                pickable: true
                property bool isPicked: false

                scale.x: 1.5
                scale.y: 2
                scale.z: 1.5

                materials: DefaultMaterial {
                    diffuseColor: cubeModel.isPicked? "green":"gray"
                    specularAmount: 0.25
                    specularRoughness: 0.2
                    roughnessMap: Texture {
                        source: "maps/roughness.jpg"
                    }
                }

                SequentialAnimation on eulerRotation {
                    loops: Animation.Infinite
                    running: !cubeModel.isPicked
                    PropertyAnimation {
                        duration: 2500
                        from: Qt.vector3d(0, 0, 0)
                        to: Qt.vector3d(360, 360, 360)
                    }
                }
            }
            Model {
                id: coneModel
                objectName: "Cone"
                source: "#Cone"
                pickable: true
                property bool isPicked: false

                x: 200
                z: 100

                scale.x: 2
                scale.y: 1.5
                scale.z: 2

                materials: DefaultMaterial {
                    diffuseColor: coneModel.isPicked ? "#21be2b" : "#53586b"
                    specularAmount: 1
                    specularRoughness: 0.1
                    roughnessMap: Texture { source: "maps/roughness.jpg" }
                }

                SequentialAnimation on eulerRotation {
                    running: !coneModel.isPicked
                    loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 10000
                        from: Qt.vector3d(0, 0, 0)
                        to: Qt.vector3d(-360, 360, 0)
                    }
                }
            }

            Model {
                id: sphereModel
                objectName: "Sphere"
                source: "#Sphere"
                pickable: true
                property bool isPicked: false

                x: -100
                y: -100
                z: -100

                scale.x: 5
                scale.y: 3
                scale.z: 1

                materials: DefaultMaterial {
                    diffuseColor: sphereModel.isPicked ? "#17a81a" : "#9d9faa"
                    specularAmount: 0.25
                    specularRoughness: 0.2
                    roughnessMap: Texture { source: "maps/roughness.jpg" }
                }

                SequentialAnimation on eulerRotation.x {
                    running: !sphereModel.isPicked
                    loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 5000
                        from: 0
                        to: 360
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: view3D
        onClicked: (mouse) => {
           // Get screen coordinates of the click
           pickPosition.text = "(" + mouse.x + ", " + mouse.y + ")"

           //! [pick result]
           var result = view3D.pick(mouse.x, mouse.y);
           //! [pick result]
           //! [pick specifics]
           if (result.objectHit) {
               var pickedObject = result.objectHit;
               // Toggle the isPicked property for the model
               pickedObject.isPicked = !pickedObject.isPicked;
               // Get picked model name
               pickName.text = pickedObject.objectName;
               // Get other pick specifics
               uvPosition.text = "("
                       + result.uvPosition.x.toFixed(2) + ", "
                       + result.uvPosition.y.toFixed(2) + ")";
               distance.text = result.distance.toFixed(2);
               scenePosition.text = "("
                       + result.scenePosition.x.toFixed(2) + ", "
                       + result.scenePosition.y.toFixed(2) + ", "
                       + result.scenePosition.z.toFixed(2) + ")";
               localPosition.text = "("
                       + result.position.x.toFixed(2) + ", "
                       + result.position.y.toFixed(2) + ", "
                       + result.position.z.toFixed(2) + ")";
               worldNormal.text = "("
                       + result.sceneNormal.x.toFixed(2) + ", "
                       + result.sceneNormal.y.toFixed(2) + ", "
                       + result.sceneNormal.z.toFixed(2) + ")";
               localNormal.text = "("
                       + result.normal.x.toFixed(2) + ", "
                       + result.normal.y.toFixed(2) + ", "
                       + result.normal.z.toFixed(2) + ")";
               //! [pick specifics]
           } else {
               pickName.text = "None";
               uvPosition.text = "";
               distance.text = "";
               scenePosition.text = "";
               localPosition.text = "";
               worldNormal.text = "";
               localNormal.text = "";
           }
        }
    }
}

