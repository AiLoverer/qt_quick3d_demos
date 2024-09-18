// Copyright (C) 2019 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick3D

Rectangle {
    id: window
    width: 1280
    height: 720
    visible: true
    color: "black"

    Column {
        id: tools
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20

        Label {
            id: countLabel
            font.pointSize: 20
            font.bold: true
            color: "slategrey"
            text: "No. models: " + shapeSpawner.count
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            RoundButton {
                text: "-"
                font.bold: true
                palette.button: "slategrey"

                onClicked: shapeSpawner.removeShape()
            }

            RoundButton {
                text: "+"
                font.bold: true
                palette.button: "slategrey"

                onClicked: shapeSpawner.addShape()
            }
        }
    }
    Item {
        id: view3D
        anchors.top: tools.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        View3D {
            anchors.fill: parent
            camera: camera
            //renderMode: View3D.Underlay

            environment: SceneEnvironment {
                clearColor: "black"
                backgroundMode: SceneEnvironment.Color
                antialiasingMode: SceneEnvironment.MSAA
                antialiasingQuality: SceneEnvironment.High
            }

            PointLight {
                position: Qt.vector3d(0, 0, 0);
                brightness: 2.5
            }

            Node {
                position: Qt.vector3d(0, 0, 0);

                PerspectiveCamera {
                    id: camera
                    position: Qt.vector3d(0, 0, 600)
                }

                SequentialAnimation on eulerRotation.y {
                    loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 5000
                        to: 360
                        from: 0
                    }
                }
            }
            // WeirdShape {
            //     // Test
            // }

            //! [spawner node]
            Node {
                id: shapeSpawner
                property real range: 300
                property var instances: []
                property int count
            //! [spawner node]

                //! [adding]
                function addShape()
                {
                    console.log("addShape called ...");
                    var xPos = (2 * Math.random() * range) - range;
                    var yPos = (2 * Math.random() * range) - range;
                    var zPos = (2 * Math.random() * range) - range;
                    var shapeComponent = Qt.createComponent("WeirdShape.qml");
                    let instance = shapeComponent.createObject(shapeSpawner,
                        { "x": xPos, "y": yPos, "z": zPos, "scale": Qt.vector3d(0.25, 0.25, 0.25)});
                    instances.push(instance);
                    count = instances.length
                }
                //! [adding]

                //! [removing]
                function removeShape()
                {
                     console.log("removeShape called ...");
                    if (instances.length > 0) {
                        let instance = instances.pop();
                        instance.destroy();
                        count = instances.length
                    }
                }
                //! [removing]
            }

            //! [startup]
            Component.onCompleted: {
                console.log("loaded onCompleted ...")
                for (var i = 0; i < 10; ++i)
                    shapeSpawner.addShape()
            }
            //! [startup]

            Node {

            }
        }
    }

    Item {
        id: __materialLibrary__
    }
}
