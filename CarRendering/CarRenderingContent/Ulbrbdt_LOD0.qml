// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Node {
    id: rootNode

    Model {
        id: aset_nature_rock_XL_ulbrbdt_LOD0

        source: "./meshes/aset_nature_rock_XL_ulbrbdt_LOD0.mesh"
        materials: [
            defaultMaterial_material
        ]
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: defaultMaterial_material
            objectName: "defaultMaterial_material"
            emissiveFactor.z: 0
            emissiveFactor.y: 0
            emissiveFactor.x: 0
            emissiveMap: ulbrbdt_2K_Albedo
            roughness: 1
            roughnessMap: ulbrbdt_2K_Roughness
            normalMap: ulbrbdt_2K_Normal_LOD0
            baseColorMap: ulbrbdt_2K_Albedo

            Texture {
                id: ulbrbdt_2K_Albedo

                source: "./images/ulbrbdt_2K_Albedo.jpg"
            }

            Texture {
                id: ulbrbdt_2K_Normal_LOD0

                source: "./images/ulbrbdt_2K_Normal_LOD0.jpg"
            }

            Texture {
                id: ulbrbdt_2K_Roughness

                source: "./images/ulbrbdt_2K_Roughness.jpg"
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/
