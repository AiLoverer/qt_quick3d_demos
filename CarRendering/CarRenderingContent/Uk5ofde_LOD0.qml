// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Node {
    id: root

    Model {
        id: aset_nature_rock_M_uk5ofde_LOD0

        source: "./meshes/aset_nature_rock_M_uk5ofde_LOD0.mesh"
        castsShadows: true
        receivesShadows: true
        materials: [
            defaultMaterial_material
        ]
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: defaultMaterial_material
            objectName: "defaultMaterial_material"

            emissiveFactor.z: 1
            emissiveFactor.y: 1
            emissiveFactor.x: 1
            emissiveMap: uk5ofde_2K_Albedo
            specularAmount: 1
            roughness: 1
            roughnessMap: uk5ofde_2K_Roughness
            normalMap: uk5ofde_2K_Normal_LOD0
            baseColorMap: uk5ofde_2K_Albedo

            Texture {
                id: uk5ofde_2K_Albedo

                source: "./images/uk5ofde_2K_Albedo.jpg"
            }

            Texture {
                id: uk5ofde_2K_Normal_LOD0

                source: "./images/uk5ofde_2K_Normal_LOD0.jpg"
            }

            Texture {
                id: uk5ofde_2K_Roughness

                source: "./images/uk5ofde_2K_Roughness.jpg"
            }
        }
    }
}
