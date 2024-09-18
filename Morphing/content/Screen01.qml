

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import Morphing
import QtQuick3D 6.2
import QtQuick.Layouts
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
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }

        Node {
            id: scene
            DirectionalLight {
                eulerRotation.x: -30
                eulerRotation.y: -70
                ambientColor: Qt.rgba(0.3, 0.3, 0.3, 1.0)
            }

            PerspectiveCamera {
                id: sceneCamera
                position.z: 3.0
                position.y: 0.75
                eulerRotation.x: -12
                clipNear: 1.0
                clipFar: 60.0
            }

            //! [morphtargets]
            MorphTarget {
                id: morphtarget0
                weight: mouthSlider.value
                attributes: MorphTarget.Position | MorphTarget.Normal
            }
            MorphTarget {
                id: morphtarget1
                weight: earSlider.value
                attributes: MorphTarget.Position | MorphTarget.Normal
            }
            MorphTarget {
                id: morphtarget2
                weight: cubeSlider.value
                attributes: MorphTarget.Position | MorphTarget.Normal
            }
            //! [morphtargets]
            //! [model]
            Model {
                source: "suzanne.mesh"
                morphTargets: [
                    morphtarget0,
                    morphtarget1,
                    morphtarget2
                ]
                materials: PrincipledMaterial {
                    baseColor: "#41cd52"
                    roughness: 0.1
                }
                SequentialAnimation on eulerRotation.y {
                    NumberAnimation { from: -45; to: 45; duration: 10000 }
                    NumberAnimation { from: 45; to: -45; duration: 10000 }
                    loops: Animation.Infinite
                }
            }
            //! [model]


        }
    }
    Pane {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        RowLayout {
            width: parent.width
            spacing: 10
//! [sliders]
            Label { text: "Mouth:"; }
            RealSlider {
                id: mouthSlider
                from: 0.0
                to: 1.0
            }
            Label { text: "Ears and eyebrows:" }
            RealSlider {
                id: earSlider
                from: 0.0
                to: 1.0
            }
            Label { text: "Cubify:" }
            RealSlider {
                id: cubeSlider
                from: 0.0
                to: 1.0
            }
//! [sliders]
        }

    }
}
