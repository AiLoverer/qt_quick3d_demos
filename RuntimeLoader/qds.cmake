### This file is automatically generated by Qt Design Studio.
### Do not change

add_subdirectory(RuntimeLoader)
add_subdirectory(RuntimeLoaderContent)
add_subdirectory(App)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
	RuntimeLoaderplugin
	RuntimeLoaderContentplugin)