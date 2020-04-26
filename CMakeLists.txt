# Validate CMake version.
cmake_minimum_required(VERSION 2.8)

# Hardcode cross prefix
set(CROSS mips-linux-uclibc-gnu)

# Include toolchain definitions
include(cmake/Toolchain.cmake)

project(t20-rtspd C CXX)

if(NOT CMAKE_BUILD_TYPE)
  set (CMAKE_BUILD_TYPE Release)
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/live555/usageEnvironment)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/live555/groupsock)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/live555/liveMedia)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/live555/basicUsageEnvironment)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/imp_sys)

add_executable(t20-rtspd on_demand_rtsp_server.cpp
  pwm.c
  imp-common.c
  capture_and_encoding.cpp
  )

set(SYS_LIBS pthread m rt dl)

set(LIVE555_LIBS
  ${CMAKE_CURRENT_SOURCE_DIR}/lib/livelib/libliveMedia.a
  ${CMAKE_CURRENT_SOURCE_DIR}/lib/livelib/libgroupsock.a
  ${CMAKE_CURRENT_SOURCE_DIR}/lib/livelib/libBasicUsageEnvironment.a
  ${CMAKE_CURRENT_SOURCE_DIR}/lib/livelib/libUsageEnvironment.a
  )

set(IMP_SDK_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lib/imp_sys/uclibc)
set(IMP_LIBS
  ${IMP_SDK_DIR}/libimp.so
  ${IMP_SDK_DIR}/libalog.so
  )

target_link_libraries(t20-rtspd ${SYS_LIBS})
target_link_libraries(t20-rtspd ${LIVE555_LIBS})
target_link_libraries(t20-rtspd ${IMP_LIBS})

if(CMAKE_BUILD_TYPE STREQUAL Release)
  add_custom_command(TARGET t20-rtspd POST_BUILD
    COMMAND ${CMAKE_STRIP} -s t20-rtspd)
endif()
