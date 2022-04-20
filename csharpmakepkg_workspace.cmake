execute_process(
	COMMAND ${CMAKE_COMMAND}
		-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}/bin
		-DSHARPMAKE_PROJECT_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}
		-G Ninja
		-S "${CMAKE_CURRENT_SOURCE_DIR}/csharpmakepkg"
		-B "${CMAKE_CURRENT_BINARY_DIR}/csharpmakepkg")

#

if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/common.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/common.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/workspace.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/workspace.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

#

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

#

if (EXISTS vcpkgs_list)
	#--overlay-ports="${CMAKE_CURRENT_SOURCE_DIR}/out/overlay_ports"
	#--x-asset-sources="${CMAKE_CURRENT_SOURCE_DIR}/out/asset_sources"
	#--overlay-ports="${CMAKE_CURRENT_SOURCE_DIR}/out/overlay_ports"
	#--overlay-triplets="${CMAKE_CURRENT_SOURCE_DIR}/out/overlay_triplets"
	#--no-downloads 
	#--clean-after-build 
	#--vcpkg-root="${CMAKE_CURRENT_SOURCE_DIR}/bin"
	add_custom_target(install_vcpkg
		${CMAKE_CURRENT_SOURCE_DIR}/bin/vcpkg.exe 
			install 
			--triplet=x64-windows 
			--x-buildtrees-root="${CMAKE_CURRENT_SOURCE_DIR}/out/buildtrees_root"
			--x-install-root="${CMAKE_CURRENT_SOURCE_DIR}/out/install_root"
			--downloads-root="${CMAKE_CURRENT_SOURCE_DIR}/out/downloads_root"
			--x-packages-root="${CMAKE_CURRENT_SOURCE_DIR}/out/packages-root"
			${vcpkgs_list} ${vcpkgs_features_list}
		WORKING_DIRECTORY 
			${CMAKE_CURRENT_SOURCE_DIR}
		USES_TERMINAL) # remove if seeing the output is unnecessary

	set_target_properties(ws_cleanup PROPERTIES EXCLUDE_FROM_ALL TRUE)

	add_custom_target(export_vcpkg
		${CMAKE_CURRENT_SOURCE_DIR}/bin/vcpkg.exe 
			export 
			--triplet=x64-windows 
			${vcpkgs_list}
			--x-buildtrees-root="${CMAKE_CURRENT_SOURCE_DIR}/out/buildtrees_root"
			--x-install-root="${CMAKE_CURRENT_SOURCE_DIR}/out/install_root"
			--downloads-root="${CMAKE_CURRENT_SOURCE_DIR}/out/downloads_root"
			--x-packages-root="${CMAKE_CURRENT_SOURCE_DIR}/out/packages-root"
			--raw 
			--output-dir="${CMAKE_CURRENT_SOURCE_DIR}/out"
			--output="exported"
		WORKING_DIRECTORY 
			${CMAKE_CURRENT_SOURCE_DIR}
		USES_TERMINAL) # remove if seeing the output is unnecessary
		
	set(VCPKG_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/out/exported/scripts/buildsystems/vcpkg.cmake)
endif()

# TODO: this should be generated
if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg_dependencies.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/vcpkg_dependencies.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()
