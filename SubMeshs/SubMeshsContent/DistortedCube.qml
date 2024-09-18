// Copyright (C) 2020 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

//! [DistortedCube Right]
Model {
    source: "./distortedcube.mesh"

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: frontTop_material
            objectName: "frontTop_material"
            baseColor: "red"
            cullMode: Material.NoCulling
            lighting: PrincipledMaterial.NoLighting
        }

        PrincipledMaterial {
            id: frontBottom_material
            objectName: "frontBottom_material"
            baseColor: "green"
            cullMode: Material.NoCulling
            lighting: PrincipledMaterial.NoLighting
        }

        PrincipledMaterial {
            id: leftSide_material
            objectName: "leftSide_material"
            baseColor: "blue"
            cullMode: Material.NoCulling
            lighting: PrincipledMaterial.NoLighting
        }

        PrincipledMaterial {
            id: rightSide_material
            objectName: "rightSide_material"
            baseColor: "pink"
            cullMode: Material.NoCulling
            lighting: PrincipledMaterial.NoLighting
        }

        PrincipledMaterial {
            id: backSide_material
            objectName: "backSide_material"
            baseColor: "orange"
            cullMode: Material.NoCulling
            lighting: PrincipledMaterial.NoLighting
        }

        PrincipledMaterial {
            id: bottomSide_material
            objectName: "bottomSide_material"
            baseColor: "navy"
            cullMode: Material.NoCulling
            lighting: PrincipledMaterial.NoLighting
        }
    }

    materials: [
        frontTop_material,
        frontBottom_material,
        leftSide_material,
        backSide_material,
        rightSide_material,
        bottomSide_material
    ]
}
//! [DistortedCube Right]

/*##^##
Designer {
    D{i:0;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/
