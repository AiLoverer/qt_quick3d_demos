### This file is automatically generated by Qt Design Studio.
### Do not change

set_source_files_properties(Constants.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

qt_add_library(ReflectionProbes STATIC)
qt6_add_qml_module(ReflectionProbes
    URI "ReflectionProbes"
    VERSION 1.0
    QML_FILES
        Constants.qml
        DirectoryFontLoader.qml
        EventListModel.qml
        EventListSimulator.qml

)
