cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(csharpmake)

# Very simple dependency check - just compare the git hashes.
# Developing sharpmake or vcpkg is not a supported workflow, so this should suffice for now.
execute_process(
        COMMAND git log -1 --format=%h
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/vcpkg-tool
        OUTPUT_VARIABLE vcpkgtool_GIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(
        COMMAND git log -1 --format=%h
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/vcpkg
        OUTPUT_VARIABLE vcpkg_GIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE)
		
execute_process(
        COMMAND git log -1 --format=%h
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/Sharpmake
        OUTPUT_VARIABLE Sharpmake_GIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE)

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/git-state.txt "${vcpkgtool_GIT_HASH} ${vcpkg_GIT_HASH} ${Sharpmake_GIT_HASH}")

execute_process( 
	COMMAND ${CMAKE_COMMAND} 
		-E compare_files 
		${CMAKE_CURRENT_BINARY_DIR}/git-state.txt 
		${CMAKE_INSTALL_PREFIX}/git-state.txt
    RESULT_VARIABLE git_compare_result)
	
if( git_compare_result EQUAL 0)
    set(needs_rebuild FALSE)
else()
	set(needs_rebuild TRUE)
endif()

if(needs_rebuild)
	# bootstrap the vcpkg tool
	execute_process(
		COMMAND ${CMAKE_COMMAND}
			-DCMAKE_INSTALL_PREFIX:PATH="${CMAKE_INSTALL_PREFIX}"
			-DCMAKE_INSTALL_BINDIR:PATH=${CMAKE_INSTALL_PREFIX}
			-DBUILD_TESTING:BOOL="False"
			-G Ninja
			-S "${CMAKE_CURRENT_LIST_DIR}/vcpkg-tool"
			-B "${CMAKE_CURRENT_BINARY_DIR}/vcpkg-tool")
	
	execute_process(
		COMMAND ${CMAKE_COMMAND}
			--build "${CMAKE_CURRENT_BINARY_DIR}/vcpkg-tool"
			--target install 
			--config Release
			WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/vcpkg-tool")
	
	# bootstrap sharpmake
	set(sharpmake_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/Sharpmake CACHE PATH "")
	set(sharpmake_SOLUTION "${sharpmake_SOURCE_DIR}/Sharpmake.sln")
	set(sharpmake_BUILD_PRODUCTS "${sharpmake_SOURCE_DIR}/tmp/bin/release/net5.0")
	set(sharpmake_PATCH_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/CompileSharpmake.bat.patch)
	
	file(COPY_FILE ${sharpmake_PATCH_SCRIPT} ${sharpmake_SOURCE_DIR}/CompileSharpmake.bat ONLY_IF_DIFFERENT)
	
	execute_process(
		COMMAND ${sharpmake_SOURCE_DIR}/bootstrap.bat 
		Sharpmake.Main.sharpmake.cs 
		Release 
		net5.0)
	
	execute_process(
		COMMAND devenv 
			${sharpmake_SOLUTION} 
			/build "Release" 
			/project "Sharpmake.Application")
	
	file(COPY ${sharpmake_BUILD_PRODUCTS}/ DESTINATION ${CMAKE_INSTALL_PREFIX})
	file(COPY ${CMAKE_CURRENT_LIST_DIR}/vcpkg/ DESTINATION ${CMAKE_INSTALL_PREFIX})
	file(REMOVE_RECURSE ${CMAKE_INSTALL_PREFIX}/.git)
	file(REMOVE_RECURSE ${CMAKE_INSTALL_PREFIX}/.github)
	file(COPY ${CMAKE_CURRENT_BINARY_DIR}/git-state.txt DESTINATION ${CMAKE_INSTALL_PREFIX})
endif()