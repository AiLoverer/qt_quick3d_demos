

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import CustomMaterial
import QtQuick3D 6.2

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
        id: v3d
        anchors.fill: parent
        environment: sceneEnvironment
        camera: sceneCamera
        SceneEnvironment {
            id: sceneEnvironment
            backgroundMode: SceneEnvironment.SkyBox
            probeExposure: 2
            lightProbe: Texture {
                source: "maps/OpenfootageNET_lowerAustria01-1024.hdr"
            }
            //skyboxBlurAmount: 0.1
        }

        property real globalRotation: 0

        NumberAnimation {
            target: v3d
            property: "globalRotation"
            from: 0
            to: 360
            duration: 27000
            running: true
            loops: Animation.Infinite
        }

        property real radius: 400
        property real separation: 360/5

        Model {
            id: floor
            source: "#Rectangle"
            y: -200
            scale: Qt.vector3d(15, 15, 1)
            eulerRotation.x: -90
            materials: [
                PrincipledMaterial  {
                    baseColor: "white"
                }
            ]
        }

        DirectionalLight {
            id: directionalLight
        }

        PerspectiveCamera {
            id: sceneCamera
            fieldOfView: 45
            position: Qt.vector3d(0, 100, 900)
        }

        SpotLight {
            position: Qt.vector3d(0, 500, 0)
            eulerRotation.x: -60
            color: Qt.rgba(1.0, 1.0, 0.1, 1.0)
            brightness: 50
            castsShadow: true
            shadowMapQuality: Light.ShadowMapQualityHigh
        }


        // Model {
        //     id: cubeModel
        //     source: "#Cube"
        //     materials: principledMaterial
        //     eulerRotation.y: 45
        //     eulerRotation.x: 30
        // }



        // Start with a simple material, using the built-in implementation for everything.
        Node {
            eulerRotation.y: v3d.globalRotation
            //! [simple]
            Model {
                x: 400
                y: 0
                source: "meshes/weirdShape.mesh"
                scale: Qt.vector3d(100, 100, 100)
                rotation: Quaternion.fromEulerAngles(-90, 0, 0)

                materials: [
                    CustomMaterial {
                        shadingMode: CustomMaterial.Shaded
                        fragmentShader: "shaders/material_simple.frag"
                        property color uDiffuse: "fuchsia"
                        property real uSpecular: 1.0
                    }
                ]
            }
            //! [simple]
        }

        // A metallic material using defaults for everything, except ambient light, and no uniforms.
        Node {
            eulerRotation.y: v3d.globalRotation + v3d.separation * 1
            Model {
                source: "meshes/weirdShape.mesh"
                scale: Qt.vector3d(100, 100, 100)
                rotation: Quaternion.fromEulerAngles(-90, 0, 0)
                x: v3d.radius

                materials: [
                    CustomMaterial {
                        shadingMode: CustomMaterial.Shaded
                        fragmentShader: "shaders/material_metallic.frag"
                    }
                ]
            }
        }
        // A material with custom handling of all the lights, but still using
        // the built-in specular function.
        Node {
            eulerRotation.y: v3d.globalRotation + v3d.separation * 2
            Model {
                source: "meshes/weirdShape.mesh"
                scale: Qt.vector3d(100, 100, 100)
                rotation: Quaternion.fromEulerAngles(-90, 0, 0)
                x: v3d.radius
                //! [custom lights]
                materials: [
                    CustomMaterial {
                        shadingMode: CustomMaterial.Shaded
                        fragmentShader: "shaders/material_customlights.frag"
                        property color uDiffuse: "orange"
                        property real uShininess: 150
                    }
                ]
                //! [custom lights]
            }
        }
        // Custom handling of everything, including specular.
        Node {
            eulerRotation.y: v3d.globalRotation  + v3d.separation * 3
            Model {
                source: "meshes/weirdShape.mesh"
                scale: Qt.vector3d(100, 100, 100)
                rotation: Quaternion.fromEulerAngles(-90, 0, 0)
                x: v3d.radius
                materials: [
                    CustomMaterial {
                        shadingMode: CustomMaterial.Shaded
                        fragmentShader: "shaders/material_customspecular.frag"
                        property color uDiffuse: "green"
                        property real uShininess: 150
                    }
                ]
            }
        }
        // Custom lights, plus custom vertex shader
        Node {
            eulerRotation.y: v3d.globalRotation + v3d.separation * 4
            Model {
                source: "meshes/weirdShape.mesh"
                scale: Qt.vector3d(100, 100, 100)
                rotation: Quaternion.fromEulerAngles(-90, 0, 0)
                x: v3d.radius
                //! [custom vertex]
                materials: [
                    CustomMaterial {
                        id: material
                        shadingMode: CustomMaterial.Shaded
                        vertexShader: "shaders/material_distortion.vert"
                        fragmentShader: "shaders/material_customlights.frag"
                        property real uTime: 0.0
                        property real uAmplitude: 0.3
                        property color uDiffuse: "yellow"
                        property real uShininess: 50
                        NumberAnimation {
                            target: material
                            property: "uTime"
                            from: 0.0
                            to: 31.4
                            duration: 10000
                            loops: Animation.Infinite
                            running: true
                        }
                    }
                ]
                //! [custom vertex]
            }
        }
        // Transparent material, with a refractive effect
        //! [transparent]
        Model {
            id: screenSphere
            source: "#Sphere"
            scale: Qt.vector3d(0.75, 0.75, 0.75)
            y: 60
            z: 750;
            materials: [
                CustomMaterial {
                    shadingMode: CustomMaterial.Shaded
                    fragmentShader: "shaders/material_transparent.frag"
                }
            ]
        //! [transparent]
            SequentialAnimation on x {
                NumberAnimation { from: 50; to: -50; duration: 20000 }
                NumberAnimation { from: -50; to: 50; duration: 20000 }
                loops: Animation.Infinite
            }
        }
    }
}
