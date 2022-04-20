execute_process(
	COMMAND ${CMAKE_COMMAND}
		-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}/bin
		-DSHARPMAKE_PROJECT_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}
		-G Ninja
		-S "${CMAKE_CURRENT_SOURCE_DIR}/csharpmakepkg"
		-B "${CMAKE_CURRENT_BINARY_DIR}/csharpmakepkg")

if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/common.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/common.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/workspace.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/workspace.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

# TODO: this should be generated
if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg_dependencies.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/vcpkg_dependencies.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

add_custom_target(ws_devenv_sharpmake csharpmakepkg/ws_devenv_sharpmake.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(ws_devenv_sharpmake PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_target(ws_devenv_workspace csharpmakepkg/ws_devenv_workspace.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(ws_devenv_workspace PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_target(ws_generate_sharpmake csharpmakepkg/ws_generate_sharpmake.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(ws_generate_sharpmake PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_target(ws_cleanup csharpmakepkg/ws_cleanup.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(ws_cleanup PROPERTIES EXCLUDE_FROM_ALL TRUE)
