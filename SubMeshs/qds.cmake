### This file is automatically generated by Qt Design Studio.
### Do not change

add_subdirectory(SubMeshs)
add_subdirectory(SubMeshsContent)
add_subdirectory(App)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
	SubMeshsplugin
	SubMeshsContentplugin)