### This file is automatically generated by Qt Design Studio.
### Do not change



qt_add_library(content STATIC)
qt6_add_qml_module(content
    URI "content"
    VERSION 1.0
    #RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        App.qml
        Screen01.qml
    RESOURCES
        maps/OpenfootageNET_lowerAustria01-1024.hdr
        shaders/material_customlights.frag
        shaders/material_customspecular.frag
        shaders/material_distortion.vert
        shaders/material_metallic.frag
        shaders/material_simple.frag
        shaders/material_transparent.frag
        shaders/screen.frag
        meshes/weirdShape.mesh

)
