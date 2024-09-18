import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    Texture {
        id: suzanne_BaseColor_png_texture
        objectName: "Suzanne_BaseColor.png"
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: "maps/Suzanne_BaseColor.png"
    }
    Texture {
        id: suzanne_MetallicRoughness_png_texture
        objectName: "Suzanne_MetallicRoughness.png"
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: "maps/Suzanne_MetallicRoughness.png"
    }
    PrincipledMaterial {
        id: suzanne_material
        objectName: "Suzanne"
        baseColorMap: suzanne_BaseColor_png_texture
        metalnessMap: suzanne_MetallicRoughness_png_texture
        roughnessMap: suzanne_MetallicRoughness_png_texture
        metalness: 1
        roughness: 1
        alphaMode: PrincipledMaterial.Opaque
    }

    // Nodes:
    Model {
        id: suzanne
        objectName: "Suzanne"
        source: "meshes/suzanne_mesh.mesh"
        materials: [
            suzanne_material
        ]
    }

    // Animations:
}
