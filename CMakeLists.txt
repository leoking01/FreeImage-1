cmake_minimum_required(VERSION 3.0.0)

project(FreeImage    LANGUAGES CXX   VERSION 0.1.1   )



# 改变安装路径可以使用下面的语句，Unix: "/usr/local", Windows: "c:/Program Files/${PROJECT_NAME}" 为默认值，所有的DESTINATION均以此目录为根目录
# set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/mymath)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/../${PROJECT_NAME}_${CMAKE_CXX_COMPILER_VERSION}_install)




#set(FI_SRCS_FILE fipMakefile.srcs)
set(FI_SRCS_FILE Makefile.srcs CACHE FILEPATH ".srcs file from freeimage source code")
message(STATUS "Generate Project From ${FI_SRCS_FILE}")

# read file content
file(STRINGS ${FI_SRCS_FILE} SRCS_File)

# find VER_MAJOR
string(REGEX MATCH "VER_MAJOR = ([0-9.]*);" VER_MAJOR_STR "${SRCS_File}")
set(VER_MAJOR ${CMAKE_MATCH_1})

# find VER_MINOR
string(REGEX MATCH "VER_MINOR = ([0-9.]*);" VER_MINOR_STR "${SRCS_File}")
set(VER_MINOR ${CMAKE_MATCH_1})

message(STATUS "FreeImage Version ${VER_MAJOR}.${VER_MINOR}")

# find SRCS
string(REGEX MATCH "SRCS = ([^;]*);" SRCS_STR "${SRCS_File}")
set(SRCS ${CMAKE_MATCH_1})

# FreeImagePlus.DllMain confilct with FreeImage.DllMain
string(REPLACE "FreeImagePlus.cpp" "" SRCS ${SRCS})

string(REPLACE " " ";" SRCS ${SRCS})


# find INCLS
string(REGEX MATCH "INCLS = ([^;]*);" INCLS_STR "${SRCS_File}")
set(INCLS ${CMAKE_MATCH_1})
if(INCLS)
    # remove missing FreeImage.h file
    string(REPLACE "./Dist/FreeImage.h" "" INCLS ${INCLS})
    string(REPLACE " " ";" INCLS ${INCLS})
endif()

# find INCLUDE
string(REGEX MATCH "INCLUDE = ([^;]*)" INCLUDE_STR "${SRCS_File}")
set(INCLUDE ${CMAKE_MATCH_1})
string(REGEX REPLACE " ?-I" ";" INCLUDE ${INCLUDE})

# source_group
foreach(FILE ${SRCS} ${INCLS})
    get_filename_component(PARENT_DIR "${FILE}" PATH)

    # ignore .
    string(REGEX REPLACE "\\.[/\\\\]" "" GROUP "${PARENT_DIR}")
    string(REPLACE "/" "\\" GROUP "${GROUP}")

    # group into "Source Files" and "Header Files"
    if ("${FILE}" MATCHES ".*\\.cp{0,2}")
        set(GROUP "Source Files\\${GROUP}")
    elseif("${FILE}" MATCHES ".*\\.h")
        set(GROUP "Header Files\\${GROUP}")
    endif()

    source_group("${GROUP}" FILES "${FILE}")
endforeach()

# add library
#add_library(FreeImage  SHARED    ${SRCS} ${INCLS})
add_library(FreeImage  STATIC     ${SRCS} ${INCLS})

# config library
target_compile_definitions(FreeImage PRIVATE LIBRAW_NODLL OPJ_STATIC DISABLE_PERF_MEASUREMENT)
if(NOT MSVC)
    target_compile_definitions(FreeImage PRIVATE __ANSI__)
endif()

if(BUILD_SHARED_LIBS)
    target_compile_definitions(FreeImage PRIVATE FIP_EXPORTS FREEIMAGE_EXPORTS)
else()
    target_compile_definitions(FreeImage PUBLIC FREEIMAGE_LIB)
endif()

target_include_directories(FreeImage PRIVATE ${INCLUDE})



install ( TARGETS FreeImage DESTINATION lib )
install ( FILES Source/FreeImage.h DESTINATION include )












#-------------------install  destation ---------------------------
#set( DESTINATION  "../install/")
#set(CMAKE_INSTALL_PREFIX "../install_FreeImage_VC14/")
#          And to the end of the top-level CMakeLists.txt we add:
#install(TARGETS ${PROJECT_NAME} DESTINATION bin)
#install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"  DESTINATION include  )


if ( 0 )
    #
    # Format the project using the `clang-format` target (i.e: cmake --build build --target clang-format)
    #

    #add_clang_format_target()

    #
    # Install library for easy downstream inclusion
    #

    include(GNUInstallDirs)
    install(
        TARGETS
        ${PROJECT_NAME}
        EXPORT
        ${PROJECT_NAME}Targets
        LIBRARY DESTINATION
        ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION
        ${CMAKE_INSTALL_BINDIR}
        ARCHIVE DESTINATION
        ${CMAKE_INSTALL_LIBDIR}
        INCLUDES DESTINATION
        include
        PUBLIC_HEADER DESTINATION
        include
        )

    install(
        EXPORT
        ${PROJECT_NAME}Targets
        FILE
        ${PROJECT_NAME}Targets.cmake
        NAMESPACE
        ${PROJECT_NAME}::
        DESTINATION
        ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
        )

    #
    # Add version header
    #

    configure_file(
        ${CMAKE_CURRENT_LIST_DIR}/cmake/version.hpp.in
        include/${PROJECT_NAME_LOWERCASE}/version.hpp
        @ONLY
        )

    install(
        FILES
        ${CMAKE_CURRENT_BINARY_DIR}/include/${PROJECT_NAME_LOWERCASE}/version.hpp
        DESTINATION
        include/${PROJECT_NAME_LOWERCASE}
        )

    #
    # Install the `include` directory
    #

    #install(
    #    DIRECTORY
    ##    include/${PROJECT_NAME_LOWERCASE}
    #    BasicDef/${PROJECT_NAME_LOWERCASE}
    #     exportApi/${PROJECT_NAME_LOWERCASE}
    #     DESTINATION
    #    include
    #    )

    install(
        FILES
        #    include/${PROJECT_NAME_LOWERCASE}
        #  inc/SOIL/image_DXT.h
        #  inc/SOIL/image_helper.h
        #  inc/SOIL/SOIL.h
        #  inc/SOIL/stb_image_aug.h
        #  inc/SOIL/stbi_DDS_aug_c.h
        #  inc/SOIL/stbi_DDS_aug.h
        Source/FreeImage.h
        #  exportApi/${PROJECT_NAME_LOWERCASE}/api_vision.h
        #     exportApi/${PROJECT_NAME_LOWERCASE}
        DESTINATION
        include/
        )


    #verbose_message("Install targets succesfully build. Install with `cmake --build <build_directory> --target install --config <build_config>`.")

    #
    # Quick `ConfigVersion.cmake` creation
    #

    include(CMakePackageConfigHelpers)
    write_basic_package_version_file(
        ${PROJECT_NAME}ConfigVersion.cmake
        VERSION
        ${PROJECT_VERSION}
        COMPATIBILITY
        SameMajorVersion
        )

    configure_package_config_file(
        ${CMAKE_CURRENT_LIST_DIR}/cmake/${PROJECT_NAME}Config.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        INSTALL_DESTINATION
        ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
        )

    install(
        FILES
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
        DESTINATION
        ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
        )

    #
    # Generate export header if specified
    #

    if (${PROJECT_NAME}_GENERATE_EXPORT_HEADER)
        include(GenerateExportHeader)
        generate_export_header(${PROJECT_NAME})
        install(
            FILES
            ${PROJECT_BINARY_DIR}/${PROJECT_NAME_LOWERCASE}_export.h
            DESTINATION
            include
            )
        message(STATUS "Generated the export header `${PROJECT_NAME_LOWERCASE}_export.h` and installed it.")
    endif ()

    message(STATUS "Finished building requirements for installing the package.\n")

    #
    # Unit testing setup
    #
    if (0)
        if (${PROJECT_NAME}_ENABLE_UNIT_TESTING)
            enable_testing()
            message(STATUS "Build unit tests for the project. Tests should always be found in the test folder\n")
            add_subdirectory(test)
        endif ()
    endif ()
endif ()


#、、-----------------------------------------------------/





#//-------------------------------------------------------------------------

target_include_directories(FreeImage PRIVATE  ${CMAKE_SOURCE_DIR}/Source )
set_target_properties(FreeImage PROPERTIES PUBLIC_HEADER ${CMAKE_SOURCE_DIR}/Source/FreeImage.h)



#//---MyMath---------------------------------------------
# 写入库的版本信息
# install
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    FreeImageConfigVersion.cmake
    VERSION ${PACKAGE_VERSION}
    COMPATIBILITY AnyNewerVersion
)

# 将库文件，可执行文件，头文件安装到指定目录
install(TARGETS FreeImage
    EXPORT FreeImageTargets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    PUBLIC_HEADER DESTINATION include
)

# 将库的相关信息输出为MyMathConfig.cmake，供find_package查找
install(EXPORT FreeImageTargets
    FILE FreeImageTargets.cmake
    NAMESPACE FreeImage::
    DESTINATION lib/cmake/FreeImage
)

configure_file( FreeImageConfig.cmake.in  FreeImage/FreeImageConfig.cmake @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/FreeImage/FreeImageConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/FreeImageConfigVersion.cmake"
    DESTINATION lib/cmake/FreeImage
)


















