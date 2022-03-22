cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(csharpmake_test VERSION 0.0)

include("../create_workspace.cmake")

install_sharpmake_workspace("${CMAKE_CURRENT_BINARY_DIR}/workspace" "${CMAKE_CURRENT_BINARY_DIR}/intermediate")