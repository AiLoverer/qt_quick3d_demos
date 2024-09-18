import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D

//! [Teapot Model]
Model {
    id: teapotDefault
    source: "teapot.mesh"
    y: -100
    scale: Qt.vector3d(75, 75, 75)

    property variant material
    materials: [material]

    property bool animate: true
    NumberAnimation on eulerRotation.y {
        running: teapotDefault.animate
        loops: Animation.Infinite
        duration: 5000
        from: 0
        to: -360
    }

    Node {
        id: __materialLibrary__
    }
}
