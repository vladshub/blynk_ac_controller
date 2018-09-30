cmake_minimum_required (VERSION 3.10)
project (BlynkAcController)

ADD_DEFINITIONS(-c -O3 -w -DLINUX)
set(CMAKE_STATIC_LINKER_FLAGS -lrt -lpthread -s)

include(CTest)
enable_testing()

include(CheckIncludeFile)
include(CheckIncludeFileCXX)
include(CheckIncludeFiles)
include(ExternalProject)
include(thirdparty/blynk.cmake)

# we add the files in the include directory to be included
# while compiling all the source code
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

# we add the sub-directories that we want CMake to scan
add_subdirectory(include)
add_subdirectory(thirdparty)
add_subdirectory(src)
add_subdirectory(test)

include_directories(${BLYNK_SRC_DIR})
include_directories(${BLYNK_LINUX_DIR})


get_property(dirs DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES)
foreach(dir ${dirs})
    message(STATUS "dir='${dir}'")
endforeach()

add_executable(blynk_ac_controller src/main.cpp ${BLYNK_SOURCE})
set(INSTALL_BIN_DIR bin CACHE PATH "Installation directory for executables")
install(TARGETS blynk_ac_controller RUNTIME DESTINATION ${INSTALL_BIN_DIR})

if(RASPBERRY==1)
    message(STATUS "Adding WiringPi to dependancies")
    find_library(wiringPi_LIB wiringPi)
    target_link_libraries(blynk_ac_controller ${wiringPi_LIB})
endif(RASPBERRY==1)
