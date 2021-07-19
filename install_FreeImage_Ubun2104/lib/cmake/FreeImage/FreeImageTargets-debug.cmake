#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "FreeImage::FreeImage" for configuration "Debug"
set_property(TARGET FreeImage::FreeImage APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(FreeImage::FreeImage PROPERTIES
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libFreeImage.so"
  IMPORTED_SONAME_DEBUG "libFreeImage.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS FreeImage::FreeImage )
list(APPEND _IMPORT_CHECK_FILES_FOR_FreeImage::FreeImage "${_IMPORT_PREFIX}/lib/libFreeImage.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
