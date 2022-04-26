include(FetchContent)

execute_process(
	COMMAND ${CMAKE_COMMAND}
		-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}/bin
		-DSHARPMAKE_PROJECT_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}
		-G Ninja
		-S "${CMAKE_CURRENT_SOURCE_DIR}/csharpmake"
		-B "${CMAKE_CURRENT_BINARY_DIR}/csharpmake")

#

FetchContent_Declare(
	emsdk
	GIT_REPOSITORY https://github.com/emscripten-core/emsdk.git
	GIT_TAG e34773a0d1a2f32dd3ba90d408a30fae89aa3c5a
	GIT_SHALLOW TRUE
	SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk)

FetchContent_GetProperties(emsdk)
if(NOT emsdk_POPULATED)
	FetchContent_Populate(emsdk)

	execute_process(
		COMMAND emsdk.bat install 3.1.9
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk)

	execute_process(
		COMMAND emsdk.bat activate 3.1.9
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk)
endif()

#EMSDK = ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk
#EM_CONFIG = ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk/.emscripten
#EMSDK_NODE = ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk/node/14.18.2_64bit/bin/node.exe
#EMSDK_PYTHON = ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk/python/3.9.2-nuget_64bit/python.exe
#JAVA_HOME = ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk/java/8.152_64bit
#PATH += ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk
#PATH += ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk/node/14.18.2_64bit/bin
#PATH += ${CMAKE_CURRENT_SOURCE_DIR}/bin/emsdk/upstream/emscripten
#

if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/common.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/common.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/workspace.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/workspace.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

#

add_custom_target(ws_devenv_sharpmake csharpmake/ws_devenv_sharpmake.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(ws_devenv_sharpmake PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_target(ws_devenv_workspace csharpmake/ws_devenv_workspace.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(ws_devenv_workspace PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_target(ws_generate_sharpmake csharpmake/ws_generate_sharpmake.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(ws_generate_sharpmake PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_target(ws_cleanup csharpmake/ws_cleanup.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(ws_cleanup PROPERTIES EXCLUDE_FROM_ALL TRUE)

#

if (DEFINED vcpkgs_list)
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
			--triplet=x64-windows-static
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
			--triplet=x64-windows-static
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
		DEPENDS 
			install_vcpkg
		USES_TERMINAL) # remove if seeing the output is unnecessary
		
	#set(VCPKG_OVERRIDE_FIND_PACKAGE_NAME vcpkg_find_package)
	set(VCPKG_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/out/exported/scripts/buildsystems/vcpkg.cmake)

	add_custom_target(generate_vcpkg
		#copy "${CMAKE_CURRENT_SOURCE_DIR}/csharpmake/vcpkg_CMakeLists.txt" "${CMAKE_CURRENT_SOURCE_DIR}/out/exported/CMakeLists.txt"
		${CMAKE_COMMAND}
			-DCMAKE_TOOLCHAIN_FILE:PATH=${VCPKG_TOOLCHAIN_FILE}
			-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}/bin
			-DSHARPMAKE_PROJECT_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}
			-DVCPKG_TARGET_TRIPLET=x64-windows-static
			-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
			-G Ninja
			-S "${CMAKE_CURRENT_SOURCE_DIR}/out"
			-B "${CMAKE_CURRENT_BINARY_DIR}/generated"
		WORKING_DIRECTORY 
			${CMAKE_CURRENT_SOURCE_DIR}
#		DEPENDS 
#			export_vcpkg
		USES_TERMINAL) # remove if seeing the output is unnecessary
		
endif()

# TODO: this should be generated
if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg_dependencies.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/vcpkg_dependencies.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()
