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

if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/common.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/common.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/workspace.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/workspace.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

#

add_custom_target(open_sharpmake_in_devenv csharpmake/ws_devenv_sharpmake.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(open_sharpmake_in_devenv PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_target(open_workspace_in_devenv csharpmake/ws_devenv_workspace.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(open_workspace_in_devenv PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_target(generate_workspace_projects csharpmake/ws_generate_sharpmake.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(generate_workspace_projects PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_target(cleanup_workspace csharpmake/ws_cleanup.bat
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(cleanup_workspace PROPERTIES EXCLUDE_FROM_ALL TRUE)

#

if (DEFINED vcpkgs_list)
	#--overlay-ports="${CMAKE_CURRENT_SOURCE_DIR}/pkg/overlay_ports"
	#--x-asset-sources="${CMAKE_CURRENT_SOURCE_DIR}/pkg/asset_sources"
	#--overlay-ports="${CMAKE_CURRENT_SOURCE_DIR}/pkg/overlay_ports"
	#--overlay-triplets="${CMAKE_CURRENT_SOURCE_DIR}/pkg/overlay_triplets"
	#--no-downloads 
	#--clean-after-build 
	#--vcpkg-root="${CMAKE_CURRENT_SOURCE_DIR}/bin"
	add_custom_target(install_vcpkg
		${CMAKE_CURRENT_SOURCE_DIR}/bin/vcpkg.exe 
			install 
			--triplet=x64-windows-static
			--x-buildtrees-root="${CMAKE_CURRENT_SOURCE_DIR}/pkg/buildtrees_root"
			--x-install-root="${CMAKE_CURRENT_SOURCE_DIR}/pkg/install_root"
			--downloads-root="${CMAKE_CURRENT_SOURCE_DIR}/pkg/downloads_root"
			--x-packages-root="${CMAKE_CURRENT_SOURCE_DIR}/pkg/packages-root"
			${vcpkgs_list} ${vcpkgs_features_list}
		WORKING_DIRECTORY 
			${CMAKE_CURRENT_SOURCE_DIR}
		USES_TERMINAL) # remove if seeing the output is unnecessary

	set_target_properties(install_vcpkg PROPERTIES EXCLUDE_FROM_ALL TRUE)

	add_custom_target(export_vcpkg
		${CMAKE_CURRENT_SOURCE_DIR}/bin/vcpkg.exe 
			export 
			--triplet=x64-windows-static
			${vcpkgs_list}
			--x-buildtrees-root="${CMAKE_CURRENT_SOURCE_DIR}/pkg/buildtrees_root"
			--x-install-root="${CMAKE_CURRENT_SOURCE_DIR}/pkg/install_root"
			--downloads-root="${CMAKE_CURRENT_SOURCE_DIR}/pkg/downloads_root"
			--x-packages-root="${CMAKE_CURRENT_SOURCE_DIR}/pkg/packages-root"
			--raw 
			--output-dir="${CMAKE_CURRENT_SOURCE_DIR}/pkg"
			--output="exported"
		WORKING_DIRECTORY 
			${CMAKE_CURRENT_SOURCE_DIR}
		DEPENDS 
			install_vcpkg
		USES_TERMINAL) # remove if seeing the output is unnecessary

	set_target_properties(export_vcpkg PROPERTIES EXCLUDE_FROM_ALL TRUE)
		
	#set(VCPKG_OVERRIDE_FIND_PACKAGE_NAME vcpkg_find_package)
	#set(VCPKG_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/pkg/exported/scripts/buildsystems/vcpkg.cmake)

#	add_custom_target(generate_vcpkg
#		#copy "${CMAKE_CURRENT_SOURCE_DIR}/csharpmake/vcpkg_CMakeLists.txt" "${CMAKE_CURRENT_SOURCE_DIR}/pkg/exported/CMakeLists.txt"
#		${CMAKE_COMMAND}
#			-DCMAKE_TOOLCHAIN_FILE:PATH=${VCPKG_TOOLCHAIN_FILE}
#			-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}/bin
#			-DSHARPMAKE_PROJECT_PREFIX:PATH=${CMAKE_CURRENT_SOURCE_DIR}
#			-DVCPKG_TARGET_TRIPLET=x64-windows-static
#			-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
#			-G Ninja
#			-S "${CMAKE_CURRENT_SOURCE_DIR}/pkg"
#			-B "${CMAKE_CURRENT_BINARY_DIR}/generated"
#		WORKING_DIRECTORY 
#			${CMAKE_CURRENT_SOURCE_DIR}
##		DEPENDS 
##			export_vcpkg
#		USES_TERMINAL) # remove if seeing the output is unnecessary
		
endif()

# TODO: this should be generated
if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg_dependencies.sharpmake.cs)
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/ws_template/vcpkg_dependencies.sharpmake.cs DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
endif()

#

set(CPM_SOURCE_CACHE "${CMAKE_CURRENT_SOURCE_DIR}/pkg/.cpm/")
set(CPM_DOWNLOAD_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/pkg/")

#

set(CPM_DOWNLOAD_VERSION 0.35.0)

if(CPM_SOURCE_CACHE)
  # Expand relative path. This is important if the provided path contains a tilde (~)
  get_filename_component(CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE} ABSOLUTE)
  set(CPM_DOWNLOAD_LOCATION "${CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
elseif(DEFINED ENV{CPM_SOURCE_CACHE})
  set(CPM_DOWNLOAD_LOCATION "$ENV{CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
else()
  set(CPM_DOWNLOAD_LOCATION "${CMAKE_BINARY_DIR}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
endif()

if(NOT (EXISTS ${CPM_DOWNLOAD_LOCATION}))
  message(STATUS "Downloading CPM.cmake to ${CPM_DOWNLOAD_LOCATION}")
  file(DOWNLOAD
       https://github.com/cpm-cmake/CPM.cmake/releases/download/v${CPM_DOWNLOAD_VERSION}/CPM.cmake
       ${CPM_DOWNLOAD_LOCATION}
  )
endif()

include(${CPM_DOWNLOAD_LOCATION})
