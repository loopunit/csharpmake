cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

execute_process(
	COMMAND ${CMAKE_COMMAND}
		-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_LIST_DIR}/bin
		-DCSHARPMAKE_WORKSPACE_ROOT:PATH=${CMAKE_CURRENT_LIST_DIR}
		-G Ninja
		-S "${CMAKE_CURRENT_LIST_DIR}/csharpmakepkg"
		-B "${CMAKE_CURRENT_BINARY_DIR}/csharpmakepkg")

