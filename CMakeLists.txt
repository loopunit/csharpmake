cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(csharpmake VERSION 0.0)

include(FetchContent)

if(NOT DEFINED sharpmake_WORKSPACE_DIR)
	set(sharpmake_WORKSPACE_DIR ${CMAKE_CURRENT_BINARY_DIR} CACHE PATH "")
endif()

if(NOT DEFINED sharpmake_SOURCE_DIR)
	set(sharpmake_SOURCE_DIR ${sharpmake_WORKSPACE_DIR}/src/Sharpmake CACHE PATH "")
endif()

if(NOT DEFINED sharpmake_INSTALL_DIR)
	set(sharpmake_INSTALL_DIR ${sharpmake_WORKSPACE_DIR}/bin/Sharpmake CACHE PATH "")
endif()

set(sharpmake_SOLUTION "${sharpmake_SOURCE_DIR}/Sharpmake.sln")
set(sharpmake_BUILD_PRODUCTS "${sharpmake_SOURCE_DIR}/tmp/bin/release/net5.0")
set(sharpmake_PATCH_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/CompileSharpmake.bat.patch)

#message(STATUS "sharpmake_WORKSPACE_DIR ${CMAKE_CURRENT_BINARY_DIR}")
#message(STATUS "sharpmake_SOURCE_DIR ${sharpmake_WORKSPACE_DIR}/src/Sharpmake")
#message(STATUS "sharpmake_INSTALL_DIR ${sharpmake_WORKSPACE_DIR}/bin/Sharpmake CACHE PATH")
#message(STATUS "sharpmake_SOLUTION ${sharpmake_SOURCE_DIR}/Sharpmake.sln")
#message(STATUS "sharpmake_BUILD_PRODUCTS ${sharpmake_SOURCE_DIR}/tmp/bin/release/net5.0")
#message(STATUS "sharpmake_PATCH_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/CompileSharpmake.bat.patch")

FetchContent_Declare(
  sharpmake
  GIT_REPOSITORY https://github.com/ubisoft/Sharpmake.git
  GIT_TAG eab7d8b2a026722cf6056cddc73be6fc528ca12e
  SOURCE_DIR ${sharpmake_SOURCE_DIR})
  
FetchContent_GetProperties(sharpmake)

if(NOT sharpmake_POPULATED)
  FetchContent_Populate(sharpmake)
endif()

file(COPY_FILE ${sharpmake_PATCH_SCRIPT} ${sharpmake_SOURCE_DIR}/CompileSharpmake.bat ONLY_IF_DIFFERENT)

add_custom_target(
	bootstrap_sharpmake
	ALL
	COMMAND 
		${sharpmake_SOURCE_DIR}/bootstrap.bat Sharpmake.Main.sharpmake.cs Release net5.0)

add_custom_target(
	build_sharpmake
	ALL
	DEPENDS bootstrap_sharpmake
	BYPRODUCTS
		${sharpmake_SOURCE_DIR}/Sharpmake/tmp/bin/release/net5.0/Sharpmake.Application.exe
	COMMAND 
		devenv ${sharpmake_SOLUTION} /build "Release" /project "Sharpmake.Application")

#message(STATUS "install(DIRECTORY ${sharpmake_BUILD_PRODUCTS}/ DESTINATION ${sharpmake_INSTALL_DIR}/bin)")
install(DIRECTORY ${sharpmake_BUILD_PRODUCTS}/ DESTINATION ${sharpmake_INSTALL_DIR}/bin/Sharpmake)

install(
	FILES 
		${CMAKE_CURRENT_LIST_DIR}/ws_activate.bat
		${CMAKE_CURRENT_LIST_DIR}/ws_deactivate.bat
		${CMAKE_CURRENT_LIST_DIR}/ws_devenv.bat
		${CMAKE_CURRENT_LIST_DIR}/ws_sharpmake.bat
	DESTINATION ${sharpmake_WORKSPACE_DIR})
