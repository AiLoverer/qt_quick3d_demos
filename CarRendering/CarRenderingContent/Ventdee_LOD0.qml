// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Node {
    id: root

    Model {
        id: aset_nature_rock_M_ventdee_LOD0

        source: "./meshes/aset_nature_rock_M_ventdee_LOD0.mesh"
        materials: [
            _mat_Default_OBJ_material
        ]
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: _mat_Default_OBJ_material
            objectName: "_mat_Default_OBJ_material"

            roughness: 1
            roughnessMap: ventdee_2K_Roughness
            normalMap: ventdee_2K_Normal_LOD0
            baseColorMap: ventdee_2K_Albedo

            Texture {
                id: ventdee_2K_Albedo

                source: "./images/ventdee_2K_Albedo.jpg"
            }

            Texture {
                id: ventdee_2K_Normal_LOD0

                source: "./images/ventdee_2K_Normal_LOD0.jpg"
            }

            Texture {
                id: ventdee_2K_Roughness

                source: "./images/ventdee_2K_Roughness.jpg"
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/
