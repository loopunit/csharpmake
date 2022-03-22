set(sharpmake_CURRENT_PATH ${CMAKE_CURRENT_LIST_DIR})

function(install_sharpmake_workspace ARG_WORKSPACE_DIR ARG_WORKING_DIR)

	#message(STATUS "COMMAND ${CMAKE_COMMAND}")
	#message(STATUS "	-Dsharpmake_WORKSPACE_DIR:PATH=${ARG_WORKSPACE_DIR}")
	#message(STATUS "	-Dsharpmake_SOURCE_DIR:PATH=${ARG_WORKSPACE_DIR}/Sharpmake")
	#message(STATUS "	-Dsharpmake_INSTALL_DIR:PATH=${ARG_WORKSPACE_DIR}")
	#message(STATUS "	-G Ninja")
	#message(STATUS "	-S ${sharpmake_CURRENT_PATH}")
	#message(STATUS "	-B ${ARG_WORKING_DIR}")

	set(ARG_BUILD_TYPE Release)
	execute_process(
		COMMAND ${CMAKE_COMMAND}
			-Dsharpmake_WORKSPACE_DIR:PATH=${ARG_WORKSPACE_DIR}
			-Dsharpmake_SOURCE_DIR:PATH=${ARG_WORKSPACE_DIR}/Sharpmake
			-Dsharpmake_INSTALL_DIR:PATH=${ARG_WORKSPACE_DIR}
			-G Ninja
			-S ${sharpmake_CURRENT_PATH}
			-B ${ARG_WORKING_DIR}
		WORKING_DIRECTORY ${ARG_WORKING_DIR})

	#message(STATUS "COMMAND ${CMAKE_COMMAND}")
	#message(STATUS "	--build ${ARG_WORKING_DIR}")
	#message(STATUS "	--target install")
	#message(STATUS "	--config ${ARG_BUILD_TYPE}")

	execute_process(
		COMMAND ${CMAKE_COMMAND} 
			--build ${ARG_WORKING_DIR}
			--target install 
			--config ${ARG_BUILD_TYPE}
		WORKING_DIRECTORY ${ARG_WORKING_DIR})
endfunction()