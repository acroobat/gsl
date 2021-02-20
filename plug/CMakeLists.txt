cmake_minimum_required(VERSION 3.16)
project(moonlight.so LANGUAGES C)

aux_source_directory(./src SRC_LIST)

#SET(MOONLIGHT_COMMON_INCLUDE_DIR ./third_party/moonlight-common-c/src)
#SET(GAMESTREAM_INCLUDE_DIR ./libgamestream)
#include_directories("${PROJECT_BINARY_DIR}")

#add_subdirectory(libgamestream)

find_package(PkgConfig)
pkg_check_modules(MPV REQUIRED mpv)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -shared -fPIC")

add_executable(moonlight.so ${SRC_LIST})
target_include_directories(moonlight.so PRIVATE  ${GAMESTREAM_INCLUDE_DIR} ${MOONLIGHT_COMMON_INCLUDE_DIR})
#target_include_directories(moonlight.so PRIVATE  ${GAMESTREAM_INCLUDE_DIR} ${MOONLIGHT_COMMON_INCLUDE_DIR})
#target_link_libraries(moonlight.so PRIVATE mpv gamestream)
target_link_libraries(moonlight.so PRIVATE mpv)
