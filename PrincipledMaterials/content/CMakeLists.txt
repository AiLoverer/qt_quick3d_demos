### This file is automatically generated by Qt Design Studio.
### Do not change



qt_add_library(content STATIC)
qt6_add_qml_module(content
    URI "content"
    VERSION 1.0
    #RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        App.qml
        BackgroundCurtain.qml
        BasicsPane.qml
        MarkdownLabel.qml
        Screen01.qml
        TextureSourceControl.qml
        VerticalSectionSeparator.qml
        AlphaPane.qml
        DetailsPane.qml
    RESOURCES
        maps/alpha_gradient.png
        maps/curtain_normal.jpg
        maps/grid.png
        maps/monkey_ao.jpg
        maps/monkey_thickness.jpg
        maps/noise.png
        maps/normal_stamp.png
        maps/OpenfootageNET_garage-1024.hdr
        maps/small_envmap.jpg
        maps/tilepattern.png
        maps/metallic/basecolor.jpg
        maps/metallic/metallic.jpg
        maps/metallic/normal.jpg
        maps/metallic/roughness.jpg
        meshes/curtain.mesh
        meshes/frame.mesh
        meshes/logo_lines.mesh
        meshes/logo_points.mesh
        meshes/suzanne.mesh
        QML_FILES ClearCoatPane.qml
        QML_FILES RefractionPane.qml
        QML_FILES SpecialPane.qml

)
