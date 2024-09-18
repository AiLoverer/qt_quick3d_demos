// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Node {
    id: root

    Model {
        id: aset_nature_rock_M_venodhb_LOD0

        source: "./meshes/aset_nature_rock_M_venodhb_LOD0.mesh"
        scale.z: 1
        scale.y: 0.01
        scale.x: 1
        materials: [
            _mat_defaultMat_material
        ]
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: _mat_defaultMat_material

            objectName: "_mat_defaultMat_material"
            heightAmount: 1
            roughness: 1
            roughnessMap: venodhb_2K_Roughness
            normalMap: venodhb_2K_Normal_LOD0
            baseColorMap: venodhb_2K_Albedo

            Texture {
                id: venodhb_2K_Albedo

                source: "./images/venodhb_2K_Albedo.jpg"
            }

            Texture {
                id: venodhb_2K_Normal_LOD0

                source: "./images/venodhb_2K_Normal_LOD0.jpg"
            }

            Texture {
                id: venodhb_2K_Roughness

                source: "./images/venodhb_2K_Roughness.jpg"
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/
