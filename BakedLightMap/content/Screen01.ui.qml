

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import BakedLightMap
import QtQuick3D 6.2
import QtQuick.Layouts
import QtQuick3D.Helpers

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    View3D {
        id: root
        anchors.fill: parent
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            // antialiasingQuality: SceneEnvironment.High
            // antialiasingMode: SceneEnvironment.MSAA
            backgroundMode: SceneEnvironment.Color
            clearColor: "black"
        }

        property bool lmEnabled: lmToggle.checked
        property int lightBakeMode: lmToggle.checked ? Light.BakeModeAll : Light.BakeModeDisabled

        Node {
            id: scene

            // DirectionalLight {
            //     id: directionalLight
            // }
            PerspectiveCamera {
                id: sceneCamera
                x: 0
                z: 288.28247
                y: 111.718
            }

            //! [light]
            PointLight {
                x: -0.765
                bakeMode: root.lightBakeMode
                y: 190
                z: 0
                brightness: brightnessSlider.value
                castsShadow: true
                shadowFactor: 75
            }

            //! [light]
            Box {
                usedInBakedLighting: true
                lightmapBaseResolution: 256
                bakedLightmap: BakedLightmap {
                    enabled: root.lmEnabled
                    key: "box"
                    loadPrefix: "file:"
                }
                scale: Qt.vector3d(100, 100, 100)
            }
        }
    }

    Rectangle {
        color: "lightGray"
        width: 320
        height: 160
        ColumnLayout {
            anchors.centerIn: parent
            CheckBox {
                id: lmToggle
                text: "Use lightmaps (fully baked direct+indirect)\nif available"
                checked: true
                focusPolicy: Qt.NoFocus
            }
            Text {
                text: "How to bake lightmaps: \nOpen DebugView -> Tools -> Bake lightmap"
            }
            Text {
                text: "Slider controls light brightness"
            }
            Slider {
                id: brightnessSlider
                value: 5.0
                from: 0
                to: 10
            }
        }
    }
    Item {
        width: debugViewToggleText.implicitWidth
        height: debugViewToggleText.implicitHeight
        anchors.right: parent.right
        Label {
            id: debugViewToggleText
            text: "Click here " + (dbg.visible ? "to hide DebugView" : "for DebugView")
            color: "white"
            anchors.right: parent.right
            anchors.top: parent.top
        }
        MouseArea {
            anchors.fill: parent
            onClicked: dbg.visible = !dbg.visible
            DebugView {
                y: debugViewToggleText.height * 2
                anchors.right: parent.right
                source: root
                id: dbg
                visible: false
            }
        }
    }
    Item {
        id: __materialLibrary__

        PrincipledMaterial {
            id: principledMaterial
            objectName: "New Material"
        }
    }
}
