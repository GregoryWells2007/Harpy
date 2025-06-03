set(CMAKE_EXPORT_COMPILE_COMMANDS on)
project(Harpy)

file(GLOB_RECURSE SOURCE_FILES CONFIGURE_DEPENDS
    "harpy/src/*.c"
)
if(APPLE)
    file(GLOB_RECURSE PLATFORM_FILES CONFIGURE_DEPENDS
    "harpy/platform/macos/*.m")
endif()
add_executable(Harpy ${SOURCE_FILES} ${PLATFORM_FILES} harpy_test.c)
if (APPLE)
    target_link_libraries(Harpy "-framework Cocoa")
endif()
target_include_directories(Harpy PUBLIC ${CMAKE_SOURCE_DIR}/harpy/src/)
target_include_directories(Harpy PUBLIC ${CMAKE_SOURCE_DIR}/harpy/include/)
target_link_libraries(Harpy)
