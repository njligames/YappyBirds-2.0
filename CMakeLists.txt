cmake_minimum_required(VERSION 3.5.2)


#if(APPLE)
#  if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
#    set(MACOSX TRUE)
#  else()
#  endif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
#elseif(UNIX)
#  set(LINUX TRUE)
#else()
#  if (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
#    set(WINDOWS TRUE)
#  else()
#    MESSAGE("NOT SET!! ${CMAKE_SYSTEM_NAME}")
#  endif()
#endif(APPLE)
#

SET ( NJLI_PRODUCT_NAME NJLIGame CACHE STRING "The name of the product" )
SET ( NJLI_PRODUCT_BUNDLE_IDENTIFIER "com.njligames.${NJLI_PRODUCT_NAME}" CACHE STRING "The bundle identifier for this product")
SET ( NJLI_PROJECT_DIRECTORY "${CMAKE_SOURCE_DIR}/project.in" CACHE STRING "The directory of where the project resides")

PROJECT (${NJLI_PRODUCT_NAME})


SET(CMAKE_INCLUDES_OUTPUT_DIRECTORY MyStage)
SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY MyStage)
SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY MyStage)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY MyStage)
SET(CMAKE_BUNDLE_OUTPUT_DIRECTORY MyStage)
SET(CMAKE_PRIVATE_HEADER_OUTPUT_DIRECTORY MyStage)
SET(CMAKE_PUBLIC_HEADER_OUTPUT_DIRECTORY MyStage)
SET(CMAKE_RESOURCE_OUTPUT_DIRECTORY MyStage)

SET ( NJLI_BUILD_PLATFORM "macOS" CACHE STRING "The platform to build for." )
SET ( NJLI_COMMON_PLATFORM "${CMAKE_SOURCE_DIR}/build/common" )
SET ( NJLIGameEngine_PACKAGE "${NJLI_PRODUCT_NAME}-${NJLI_BUILD_PLATFORM}" )
SET ( NJLIGameEngine_PACKAGE_TARNAME "${NJLI_PRODUCT_NAME}" )
SET ( NJLIGameEngine_PACKAGE_NAME "${NJLI_PRODUCT_NAME}" )
SET ( NJLIGameEngine_BUGREPORT "jamesfolk1@gmail.com" )
SET ( OPERATING_SYSTEM "${CMAKE_SYSTEM_NAME}")

IF( ${NJLI_BUILD_PLATFORM} STREQUAL "macOS" )
  set(NJLI_GRAPHICS_PLATFORM "opengl_2" CACHE STRING "The rendering platform to use")
  set(NJLI_GRAPHICS_PLATFORM_Values "opengl_2;opengl_3")
ELSEIF( ${NJLI_BUILD_PLATFORM} STREQUAL "ios" OR ${NJLI_BUILD_PLATFORM} STREQUAL "appletv")
  set(NJLI_GRAPHICS_PLATFORM "opengl_es_2" CACHE STRING "The rendering platform to use")
  set(NJLI_GRAPHICS_PLATFORM_Values "opengl_es_2;opengl_es_3")
ENDIF( ${NJLI_BUILD_PLATFORM} STREQUAL "macOS" )
set_property(CACHE NJLI_GRAPHICS_PLATFORM PROPERTY STRINGS ${NJLI_GRAPHICS_PLATFORM_Values})

SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")

STRING( COMPARE EQUAL "${CMAKE_BUILD_TYPE}" "Debug" IS_DEBUG )
STRING( COMPARE EQUAL "${CMAKE_BUILD_TYPE}" "Release" IS_RELEASE )

SET ( NJLIGameEngine_VERSION_MAJOR $ENV{NJLIGameEngine_VERSION_MAJOR} )
SET ( NJLIGameEngine_VERSION_MINOR $ENV{NJLIGameEngine_VERSION_MINOR} )
SET ( NJLIGameEngine_VERSION_RELEASE $ENV{NJLIGameEngine_VERSION_RELEASE} )
SET ( NJLIGameEngine_BUILD_NUMBER $ENV{NJLIGameEngine_BUILD_NUMBER} )
SET ( NJLIGameEngine_VERSION "${NJLIGameEngine_VERSION_MAJOR}.${NJLIGameEngine_VERSION_MINOR}.${NJLIGameEngine_VERSION_RELEASE}")
SET ( NJLIGameEngine_PACKAGE_STRING "${NJLIGameEngine_PACKAGE_NAME} ${NJLIGameEngine_VERSION}")

SET ( CMAKE_INSTALL_INCLUDEDIR include CACHE STRING "The include directory" )
SET ( CMAKE_INSTALL_DATADIR data CACHE STRING "The data directory" )
SET ( CMAKE_INSTALL_DOCDIR doc CACHE STRING "The documentation directory" )
SET ( CMAKE_INSTALL_TESTDIR tests CACHE STRING "The tests directory" )

SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")

  IF( ${NJLI_BUILD_PLATFORM} STREQUAL "appletv" )
    SET(NJLI_APPICON_NAME "App Icon & Top Shelf Image")
  ELSE()
    SET(NJLI_APPICON_NAME "AppIcon")
  ENDIF( ${NJLI_BUILD_PLATFORM} STREQUAL "appletv" )
  SET( NJLIGameEngine_PRODUCT_BUNDLE_IDENTIFIER "${NJLI_PRODUCT_BUNDLE_IDENTIFIER}")
  SET( NJLIGameEngine_PRODUCT_NAME ${NJLI_PRODUCT_NAME})
  SET( NJLIGameEngine_EXECUTABLE_NAME ${NJLI_PRODUCT_NAME})

endif( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")

ADD_DEFINITIONS(-DNJLI_VERSION_MAJOR=\"${NJLIGameEngine_VERSION_MAJOR}\")
ADD_DEFINITIONS(-DNJLI_VERSION_MINOR=\"${NJLIGameEngine_VERSION_MINOR}\")
ADD_DEFINITIONS(-DNJLI_VERSION_RELEASE=\"${NJLIGameEngine_VERSION_RELEASE}\")

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  MESSAGE(
    "${CMAKE_SOURCE_DIR}/project.in/platform/${NJLI_BUILD_PLATFORM}/Info.plist.in"
    )
  CONFIGURE_FILE (
    "${CMAKE_SOURCE_DIR}/project.in/platform/${NJLI_BUILD_PLATFORM}/Info.plist.in"
    "${CMAKE_BINARY_DIR}/${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/platform/${NJLI_BUILD_PLATFORM}/Info.plist"
  )
endif(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")

SET( GAME_ASSETS "${NJLI_COMMON_PLATFORM}/assets" )
FILE( GLOB_RECURSE GAME_ASSETS_FILES "${NJLI_COMMON_PLATFORM}/assets/*" )

SET(EXTRA_PLATFORM_LIBS "")

IF( ${NJLI_BUILD_PLATFORM} STREQUAL "appletv" )

  SET(imported_SDL2_location                        "${CMAKE_SOURCE_DIR}/../../External/thirdparty/SDL2/lib/${NJLI_BUILD_PLATFORM}/10.2/Release\$(EFFECTIVE_PLATFORM_NAME)/libSDL2.a" )

  LIST(APPEND NJLIGameEngine_HDRS /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS.sdk/System/Library/Frameworks )

  SET( CMAKE_OSX_SYSROOT "appletvos" )
  SET( CMAKE_XCODE_EFFECTIVE_PLATFORMS "-appletvos;-appletvsimulator" )

  SET ( CMAKE_OSX_ARCHITECTURES $(ARCHS_UNIVERSAL_APPLETV_OS) CACHE string "Build architecture for appletv" )
  SET ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden" )

  SET ( EXTRA_PLATFORM_LIBS
    ${EXTRA_PLATFORM_LIBS}
    "-framework AVFoundation"
    "-framework GameController"
    "-framework CoreGraphics"
    "-framework AudioToolbox"
    "-framework QuartzCore"
    "-framework OpenGLES"
    "-framework UIKit"
    "-framework Foundation"
  )

  IF( ${NJLI_SOUND_PLATFORM} STREQUAL "openal" )
    SET ( EXTRA_PLATFORM_LIBS
      ${EXTRA_PLATFORM_LIBS}
      "-framework OpenAL"
    )
  ENDIF( ${NJLI_SOUND_PLATFORM} STREQUAL "openal" )

  SET( ASSET_CATALOGUE "${CMAKE_SOURCE_DIR}/build/icons/${NJLI_BUILD_PLATFORM}/Assets.xcassets" )
  FILE( GLOB_RECURSE ASSET_CATALOGUE_FILES "${CMAKE_SOURCE_DIR}/build/icons/${NJLI_BUILD_PLATFORM}/Assets.xcassets/*" )

  SET( NJLI_RESOURCES ${LOCALIZATION_DIR} ${ASSET_CATALOGUE} ${GAME_ASSETS} )
  SET( NJLI_RESOURCES_FILES ${ASSET_CATALOGUE_FILES} ${GAME_ASSETS_FILES} )

  SET( NJLI_DEVICE_FAMILY "3" )

ELSEIF( ${NJLI_BUILD_PLATFORM} STREQUAL "ios" )

  SET(imported_NJLIshared_directory_location "${CMAKE_SOURCE_DIR}/../../Engine/generated/platform/ios/11.1/Release\$(EFFECTIVE_PLATFORM_NAME)/lib")
  SET(imported_NJLIshared_location "${imported_NJLIshared_directory_location}/libnjli.dylib" )

  SET( CMAKE_OSX_SYSROOT "iphoneos" )
  SET( CMAKE_XCODE_EFFECTIVE_PLATFORMS "-iphoneos;-iphonesimulator" )

  SET ( CMAKE_OSX_ARCHITECTURES $(ARCHS_UNIVERSAL_IPHONE_OS) CACHE string "Build architecture for iOS" )
  SET ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden" )
  SET ( EXTRA_PLATFORM_LIBS
    ${EXTRA_PLATFORM_LIBS}
    "-framework AVFoundation"
    "-framework AudioToolbox"
    "-framework GameController"
    "-framework CoreMotion"
    "-framework CoreGraphics"
    "-framework QuartzCore"
    "-framework OpenGLES"
    "-framework UIKit"
    "-framework Foundation"
  )

  #IF( ${NJLI_SOUND_PLATFORM} STREQUAL "openal" )
  #  SET ( EXTRA_PLATFORM_LIBS
  #    ${EXTRA_PLATFORM_LIBS}
  #    "-framework OpenAL"
  #  )
  #ENDIF( ${NJLI_SOUND_PLATFORM} STREQUAL "openal" )

  SET( ASSET_CATALOGUE "${CMAKE_SOURCE_DIR}/build/icons/${NJLI_BUILD_PLATFORM}/Assets.xcassets" )
  FILE( GLOB_RECURSE ASSET_CATALOGUE_FILES "${CMAKE_SOURCE_DIR}/build/icons/${NJLI_BUILD_PLATFORM}/Assets.xcassets/*" )

  SET( NJLI_RESOURCES ${LOCALIZATION_DIR} ${ASSET_CATALOGUE} ${GAME_ASSETS} )
  SET( NJLI_RESOURCES_FILES ${ASSET_CATALOGUE_FILES} ${GAME_ASSETS_FILES} )

  SET( NJLI_DEVICE_FAMILY "1,2" )

ELSEIF( ${NJLI_BUILD_PLATFORM} STREQUAL "macOS" )

  SET(imported_NJLIshared_directory_location "${CMAKE_SOURCE_DIR}/../../Engine/generated/platform/${NJLI_BUILD_PLATFORM}/10.13/macosx/Release/lib" )
  SET(imported_NJLIshared_location "${imported_NJLIshared_directory_location}/libnjli.dylib" )

  SET ( CMAKE_OSX_ARCHITECTURES ${ARCHS_STANDARD_32_BIT} CACHE string "Build architecture for macOS" )

  SET( ASSET_CATALOGUE "${CMAKE_SOURCE_DIR}/build/icons/${NJLI_BUILD_PLATFORM}/Assets.xcassets" )
  FILE( GLOB_RECURSE ASSET_CATALOGUE_FILES "${CMAKE_SOURCE_DIR}/build/icons/${NJLI_BUILD_PLATFORM}/Assets.xcassets/*" )

  SET( NJLI_RESOURCES ${LOCALIZATION_DIR} ${ASSET_CATALOGUE} ${GAME_ASSETS} )
  SET( NJLI_RESOURCES_FILES ${ASSET_CATALOGUE_FILES} ${GAME_ASSETS_FILES} )

ELSEIF( ${NJLI_BUILD_PLATFORM} STREQUAL "emscripten" )

  LIST(APPEND NJLIGameEngine_HDRS $ENV{EMSCRIPTEN_LOCATION}/system/include )
  LIST(APPEND NJLIGameEngine_HDRS $ENV{EMSCRIPTEN_LOCATION}/system/include/emscripten )

  SET(imported_SDL2_location                        "${CMAKE_SOURCE_DIR}/../../External/thirdparty/SDL2/lib/${NJLI_BUILD_PLATFORM}/Release/libSDL2.a" )

  IF( IS_DEBUG)
    # DEBUGGING: https://kripken.github.io/emscripten-site/docs/porting/Debugging.html#debugging-emcc-debug

    LIST(APPEND EXTRA_PLATFORM_LIBS "--bind")
    LIST(APPEND EXTRA_PLATFORM_LIBS "--profiling")
    LIST(APPEND EXTRA_PLATFORM_LIBS "--profiling-funcs")
    LIST(APPEND EXTRA_PLATFORM_LIBS "--tracing")
    LIST(APPEND EXTRA_PLATFORM_LIBS "--emit-symbol-map")
    LIST(APPEND EXTRA_PLATFORM_LIBS "-g4")

    #LIST(APPEND EXTRA_PLATFORM_LIBS "--shell-file ${CMAKE_SOURCE_DIR}/cmake.in/Platform.in/emscripten/debug_shell.html")

  ELSE()
    # OPTIMIZING: https://kripken.github.io/emscripten-site/docs/optimizing/Optimizing-Code.html
    # SEPERATE ASM: https://kripken.github.io/emscripten-site/docs/optimizing/Optimizing-Code.html#avoid-memory-spikes-by-separating-out-asm-js

    LIST(APPEND EXTRA_PLATFORM_LIBS "-s -O2 --llvm-opts 2")

    #LIST(APPEND EXTRA_PLATFORM_LIBS "--shell-file ${CMAKE_SOURCE_DIR}/cmake.in/Platform.in/emscripten/release_shell.html")

  ENDIF( IS_DEBUG)

  LIST(APPEND EXTRA_PLATFORM_LIBS "--js-opts 0")
  LIST(APPEND EXTRA_PLATFORM_LIBS "-s TOTAL_MEMORY=256*1024*1024")
  LIST(APPEND EXTRA_PLATFORM_LIBS "-s FULL_ES2=1")
  #LIST(APPEND EXTRA_PLATFORM_LIBS "-s USE_PTHREADS=2")
  #LIST(APPEND EXTRA_PLATFORM_LIBS "-s PTHREAD_POOL_SIZE=8")
  LIST(APPEND EXTRA_PLATFORM_LIBS "--separate-asm")
  #LIST(APPEND EXTRA_PLATFORM_LIBS "-s WASM=1")
  #LIST(APPEND EXTRA_PLATFORM_LIBS "--closure 1")

  #https://kripken.github.io/emscripten-site/docs/porting/files/packaging_files.html
  SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -DSWIG_TYPE_TABLE=myprojectname --memory-init-file 1 --embed-file  ${NJLI_COMMON_PLATFORM}/assets@/" )
  SET(CMAKE_EXECUTABLE_SUFFIX ".html")

ELSEIF( ${NJLI_BUILD_PLATFORM} STREQUAL "android" )

  SET(imported_SDL2_location                        "${CMAKE_SOURCE_DIR}/../../External/thirdparty/SDL2/lib/${NJLI_BUILD_PLATFORM}/23/Release/${ANDROID_ABI}/libSDL2.so" )

  FILE(GLOB NJLIGameEngine_LBY
    ${NJLIGameEngine_LBY}
    ${CMAKE_SOURCE_DIR}/../../External/thirdparty/SDL2/lib/${NJLI_BUILD_PLATFORM}/23/Release/${ANDROID_ABI}/libSDL2.so
  )

  FIND_LIBRARY(log-lib log)
  FIND_LIBRARY(dl-lib dl)
  FIND_LIBRARY(GLESv2-lib GLESv2)
  FIND_LIBRARY(m-lib m)
  FIND_LIBRARY(c-lib c)
  FIND_LIBRARY(EGL-lib EGL)
  FIND_LIBRARY(stdc++-lib stdc++)
  FIND_LIBRARY(android-lib android)
  IF( ${NJLI_SOUND_PLATFORM} STREQUAL "openal" )
    FIND_LIBRARY(OpenSLES-lib OpenSLES)
  ENDIF( ${NJLI_SOUND_PLATFORM} STREQUAL "openal" )

  SET(EXTRA_PLATFORM_LIBS
    ${EXTRA_PLATFORM_LIBS}
    ${log-lib}
    ${dl-lib}
    ${GLESv2-lib}
    ${m-lib}
    ${c-lib}
    ${EGL-lib}
    ${stdc++-lib}
    ${android-lib}
  )

  IF( ${NJLI_SOUND_PLATFORM} STREQUAL "openal" )
    SET(EXTRA_PLATFORM_LIBS
      ${EXTRA_PLATFORM_LIBS}
      ${OpenSLES-lib}
    )
  ENDIF( ${NJLI_SOUND_PLATFORM} STREQUAL "openal" )

  SET( NJLI_RESOURCES ${GAME_ASSETS} )
  SET( NJLI_RESOURCES_FILES ${GAME_ASSETS_FILES} )

ELSEIF( ${NJLI_BUILD_PLATFORM} STREQUAL "linux" )
  SET(imported_SDL2_location                        "${CMAKE_SOURCE_DIR}/../../External/thirdparty/SDL2/lib/linux/16.04.2_LTS/Release/libSDL2.so" )

  FIND_LIBRARY(dl-lib dl)
  #FIND_LIBRARY(GLESv2-lib GLESv2)
  FIND_LIBRARY(m-lib m)
  FIND_LIBRARY(c-lib c)
  #FIND_LIBRARY(EGL-lib EGL)
  #FIND_LIBRARY(stdc++-lib stdc++)

  SET(EXTRA_PLATFORM_LIBS
    ${EXTRA_PLATFORM_LIBS}
    ${dl-lib}
    ${m-lib}
    ${c-lib}
  )

  SET( NJLI_RESOURCES ${GAME_ASSETS} )
  SET( NJLI_RESOURCES_FILES ${GAME_ASSETS_FILES} )

ENDIF()

SET(THIRD_PARTY_LIBS "")

#https://developer.android.com/studio/projects/add-native-code.html
INCLUDE_DIRECTORIES( ${NJLIGameEngine_HDRS} )

INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../../External/thirdparty/SDL2/include" )
INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../../Engine/generated/include")

ADD_LIBRARY(libnjli_shared STATIC IMPORTED )
SET_TARGET_PROPERTIES(libnjli_shared PROPERTIES IMPORTED_LOCATION ${imported_NJLIshared_location})
LIST(APPEND THIRD_PARTY_LIBS libnjli_shared)

ADD_CUSTOM_COMMAND(
  OUTPUT
  ${CMAKE_CURRENT_BINARY_DIR}/icons
  COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/icons && sh cmake_icons.sh ${CMAKE_CURRENT_BINARY_DIR}/icons && rm -rf ${CMAKE_CURRENT_BINARY_DIR}/icons
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  COMMENT
  "Generating the icons for all the platforms"
  VERBATIM
)
ADD_CUSTOM_TARGET(CreateIcons ALL
  DEPENDS
  ${CMAKE_SOURCE_DIR}/project.in/platform/IconInput_Back.png
  ${CMAKE_SOURCE_DIR}/project.in/platform/IconInput_Front.png
  ${CMAKE_SOURCE_DIR}/project.in/platform/IconInput_Middle.png
  ${CMAKE_SOURCE_DIR}/project.in/platform/IconInput.png
  ${CMAKE_SOURCE_DIR}/project.in/platform/LaunchInput.png
  ${CMAKE_CURRENT_BINARY_DIR}/icons
  SOURCES
  ${CMAKE_SOURCE_DIR}/project.in/platform/IconInput_Back.png
  ${CMAKE_SOURCE_DIR}/project.in/platform/IconInput_Front.png
  ${CMAKE_SOURCE_DIR}/project.in/platform/IconInput_Middle.png
  ${CMAKE_SOURCE_DIR}/project.in/platform/IconInput.png
  ${CMAKE_SOURCE_DIR}/project.in/platform/LaunchInput.png
)

ADD_CUSTOM_COMMAND(
  OUTPUT
  ${CMAKE_SOURCE_DIR}/cmake.in/ldoc/index.html
  COMMAND
  ldoc ${CMAKE_SOURCE_DIR}/cmake.in/ldoc.in/
  WORKING_DIRECTORY
  ${CMAKE_SOURCE_DIR}/cmake.in
  COMMENT
  "Generating API documentation with LDoc"
  VERBATIM
)

ADD_CUSTOM_TARGET(Ldoc ALL
  DEPENDS
  ${CMAKE_SOURCE_DIR}/cmake.in/ldoc/index.html
)
SET_SOURCE_FILES_PROPERTIES( ${CMAKE_SOURCE_DIR}/cmake.in/ldoc/index.html PROPERTIES GENERATED TRUE )

IF (APPLE)
  ADD_CUSTOM_TARGET(really-clean
    COMMAND export NJLI_GAME_ENGINE_ASSET_DIR=${NJLI_COMMON_PLATFORM} && export NJLI_GRAPHICS_PLATFORM=${NJLI_GRAPHICS_PLATFORM} && make clean
    WORKING_DIRECTORY ${NJLI_PROJECT_DIRECTORY}
  )
ENDIF (APPLE)

IF( ${NJLI_BUILD_PLATFORM} STREQUAL "android" )
  ADD_LIBRARY( njli SHARED
    ${NJLIGameEngine_SRCS}
    ${CMAKE_SOURCE_DIR}/../../External/thirdparty/SDL2-2.0.5/src/main/android/SDL_android_main.c
    ${CMAKE_SOURCE_DIR}/main.cpp
  )
  TARGET_LINK_LIBRARIES( njli ${EXTRA_PLATFORM_LIBS} ${THIRD_PARTY_LIBS}
    ${NJLIGameEngine_LBY}
  )
  SET_TARGET_PROPERTIES( njli PROPERTIES VERSION ${NJLIGameEngine_VERSION} SOVERSION ${NJLIGameEngine_VERSION_MAJOR})
  ADD_DEPENDENCIES(njli WrapSWIG)

  IF (APPLE)
    ADD_CUSTOM_COMMAND(TARGET njli
      PRE_BUILD
      COMMAND export NJLI_GAME_ENGINE_ASSET_DIR=${NJLI_COMMON_PLATFORM} && export NJLI_GRAPHICS_PLATFORM=${NJLI_GRAPHICS_PLATFORM} && make
      WORKING_DIRECTORY ${NJLI_PROJECT_DIRECTORY}
    )
  ENDIF (APPLE)

ELSE()

  ADD_EXECUTABLE( ${NJLI_PRODUCT_NAME}
    ${CMAKE_SOURCE_DIR}/main.cpp
    ${NJLI_RESOURCES}
  )

  IF( ${NJLI_BUILD_PLATFORM} STREQUAL "emscripten" )
    IF(IS_DEBUG)
      TARGET_LINK_LIBRARIES( ${NJLI_PRODUCT_NAME} libnjli_bytecode_shared)
    ENDIF(IS_DEBUG)

    SET_TARGET_PROPERTIES( ${NJLI_PRODUCT_NAME} PROPERTIES OUTPUT_NAME index )

  ENDIF( ${NJLI_BUILD_PLATFORM} STREQUAL "emscripten" )

  IF( ${NJLI_BUILD_PLATFORM} STREQUAL "appletv" OR ${NJLI_BUILD_PLATFORM} STREQUAL "ios" )
    SET_TARGET_PROPERTIES (
      ${NJLI_PRODUCT_NAME} PROPERTIES
      XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
      XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY ${NJLI_DEVICE_FAMILY}
      XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC YES
      XCODE_ATTRIBUTE_INSTALL_PATH "${CMAKE_BINARY_DIR}/ProductRelease"
      XCODE_ATTRIBUTE_COMBINE_HIDPI_IMAGES "NO"
      XCODE_ATTRIBUTE_ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME "LaunchImage"
      XCODE_ATTRIBUTE_ENABLE_BITCODE TRUE
    )
  ENDIF()

  SET_TARGET_PROPERTIES(
    ${NJLI_PRODUCT_NAME} PROPERTIES
    RESOURCE "${NJLI_RESOURCES}"
  )

  IF( ${NJLI_BUILD_PLATFORM} STREQUAL "appletv" OR ${NJLI_BUILD_PLATFORM} STREQUAL "ios" OR ${NJLI_BUILD_PLATFORM} STREQUAL "macOS" )

    SET(MACOSX_BUNDLE_BUNDLE_NAME ${NJLI_PRODUCT_NAME})

    SET_SOURCE_FILES_PROPERTIES(
      ${NJLI_RESOURCES}
      PROPERTIES
      MACOSX_PACKAGE_LOCATION ${NJLI_PRODUCT_NAME}/Contents/Resources/
    )

    SET_TARGET_PROPERTIES(
      ${NJLI_PRODUCT_NAME} PROPERTIES
      MACOSX_BUNDLE TRUE
      MACOSX_BUNDLE_INFO_PLIST "${CMAKE_BINARY_DIR}/${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/platform/${NJLI_BUILD_PLATFORM}/Info.plist"
      XCODE_ATTRIBUTE_ASSETCATALOG_COMPILER_APPICON_NAME ${NJLI_APPICON_NAME}
      XCODE_ATTRIBUTE_PRODUCT_NAME ${NJLI_PRODUCT_NAME}
      XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "${NJLI_PRODUCT_BUNDLE_IDENTIFIER}"
      XCODE_ATTRIBUTE_DEVELOPMENT_TEAM SRBQ5SCF5X
    )

  ENDIF( ${NJLI_BUILD_PLATFORM} STREQUAL "appletv" OR ${NJLI_BUILD_PLATFORM} STREQUAL "ios" OR ${NJLI_BUILD_PLATFORM} STREQUAL "macOS" )

  IF( ${NJLI_BUILD_PLATFORM} STREQUAL "emscripten" )
    IF(IS_DEBUG)
      TARGET_LINK_LIBRARIES( ${NJLI_PRODUCT_NAME} ${NJLIGameEngine_LBY} ${EXTRA_PLATFORM_LIBS} ${THIRD_PARTY_LIBS} "--shell-file ${CMAKE_SOURCE_DIR}/cmake.in/Platform.in/emscripten/executable/debug_shell.html" libnjli_static)
    ELSE()
      TARGET_LINK_LIBRARIES( ${NJLI_PRODUCT_NAME} ${NJLIGameEngine_LBY} ${EXTRA_PLATFORM_LIBS} ${THIRD_PARTY_LIBS} "--shell-file ${CMAKE_SOURCE_DIR}/cmake.in/Platform.in/emscripten/executable/release_shell.html" libnjli_static)
    ENDIF(IS_DEBUG)
  ELSE()
    TARGET_LINK_LIBRARIES( ${NJLI_PRODUCT_NAME} ${NJLIGameEngine_LBY} ${EXTRA_PLATFORM_LIBS} ${THIRD_PARTY_LIBS})
  ENDIF( ${NJLI_BUILD_PLATFORM} STREQUAL "emscripten" )

  IF (APPLE)
    ADD_CUSTOM_COMMAND(TARGET ${NJLI_PRODUCT_NAME}
      PRE_BUILD
      COMMAND export NJLI_GAME_ENGINE_ASSET_DIR=${NJLI_COMMON_PLATFORM} && export NJLI_GRAPHICS_PLATFORM=${NJLI_GRAPHICS_PLATFORM} && make
      WORKING_DIRECTORY ${NJLI_PROJECT_DIRECTORY}
    )
  ENDIF (APPLE)

  if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    
    SET(BUNDLE_PATH "${CMAKE_BINARY_DIR}/${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${CMAKE_BUILD_TYPE}/${NJLI_PRODUCT_NAME}.app")

    IF( ${NJLI_BUILD_PLATFORM} STREQUAL "appletv" )
      IF(IS_RELEASE)
        file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/postprocess_bundle.cmake "
          message(\"Signing application bundle: ${BUNDLE_PATH}\")
          # https://www.slicer.org/wiki/Documentation/Nightly/Developers/Mac_OS_X_Code_Signing
          execute_process(
            COMMAND codesign --deep --force --sign \"$ENV{NJLI_DEVELOPMENT_TEAM}\" -i \"${NJLI_PRODUCT_BUNDLE_IDENTIFIER}\" \"${BUNDLE_PATH}\"
          )
          execute_process(
            COMMAND codesign -dv \"${BUNDLE_PATH}\"
          )
        ")
        add_custom_command(TARGET ${NJLI_PRODUCT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} -P postprocess_bundle.cmake
        )
      ENDIF(IS_RELEASE)
    ELSEIF( ${NJLI_BUILD_PLATFORM} STREQUAL "ios" )
      #IF(IS_RELEASE)
      #  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/postprocess_bundle.cmake "
      #    message(\"Signing application bundle: ${BUNDLE_PATH}\")
      #    # https://www.slicer.org/wiki/Documentation/Nightly/Developers/Mac_OS_X_Code_Signing
      #    execute_process(
      #      COMMAND codesign --deep --force --sign \"$ENV{NJLI_DEVELOPMENT_TEAM}\" -i \"${NJLI_PRODUCT_BUNDLE_IDENTIFIER}\" \"${BUNDLE_PATH}\"
      #    )
      #    execute_process(
      #      COMMAND codesign -dv \"${BUNDLE_PATH}\"
      #    )
      #  ")
      #  add_custom_command(TARGET ${NJLI_PRODUCT_NAME} POST_BUILD
      #    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/postprocess_bundle.cmake
      #  )
      #ENDIF(IS_RELEASE)
    ELSEIF( ${NJLI_BUILD_PLATFORM} STREQUAL "macOS" )
      FILE(GLOB shared_libs
        ${imported_NJLIshared_directory_location}/*.dylib
        )
      
      FOREACH(shared_lib ${shared_libs})
        add_custom_command(TARGET ${NJLI_PRODUCT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E copy_if_different "${shared_lib}" "${BUNDLE_PATH}/Contents/MacOS"
          COMMENT "Copying the shared library to exe"
          VERBATIM
          )
      ENDFOREACH()

      FILE(GLOB the_shared_libs
        ${BUNDLE_PATH}/Contents/MacOS/*.dylib
        )
      
      FILE(WRITE ${CMAKE_CURRENT_BINARY_DIR}/postprocess_bundle.cmake "
          INCLUDE(BundleUtilities)

          MESSAGE(\"Fixing application bundle: ${BUNDLE_PATH} ${the_shared_libs} ${GAME_ASSETS}\")

          FIXUP_BUNDLE(\"${BUNDLE_PATH}\" \"${the_shared_libs}\" \"${GAME_ASSETS}\"  )

          MESSAGE(\"Signing application bundle: ${BUNDLE_PATH}\")

          EXECUTE_PROCESS(
            COMMAND codesign --deep --force --sign \"$ENV{NJLI_DEVELOPMENT_TEAM}\" -i \"${NJLI_PRODUCT_BUNDLE_IDENTIFIER}\" \"${BUNDLE_PATH}\"
          )
          EXECUTE_PROCESS(
            COMMAND codesign -dv \"${BUNDLE_PATH}\"
          )
        ")
        
        ADD_CUSTOM_COMMAND(TARGET ${NJLI_PRODUCT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/postprocess_bundle.cmake
        )

    ENDIF( ${NJLI_BUILD_PLATFORM} STREQUAL "appletv" )

    INSTALL( DIRECTORY ${BUNDLE_PATH} DESTINATION platform/${NJLI_BUILD_DIR}/${CMAKE_BUILD_TYPE}/bin USE_SOURCE_PERMISSIONS )

  else()
    IF( ${NJLI_BUILD_PLATFORM} STREQUAL "emscripten" )

      SET(ENGINESOURCE_HTML_BUNDLE_PATH platform/${NJLI_BUILD_DIR}/${CMAKE_BUILD_TYPE}/bin/${NJLI_PRODUCT_NAME})
      INSTALL(TARGETS ${NJLI_PRODUCT_NAME} RUNTIME DESTINATION ${ENGINESOURCE_HTML_BUNDLE_PATH} )
      INSTALL(FILES ${CMAKE_BINARY_DIR}/${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/index.html.mem DESTINATION ${ENGINESOURCE_HTML_BUNDLE_PATH})
      INSTALL(FILES ${CMAKE_BINARY_DIR}/${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/index.asm.js DESTINATION ${ENGINESOURCE_HTML_BUNDLE_PATH})
      INSTALL(FILES ${CMAKE_BINARY_DIR}/${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/index.js DESTINATION ${ENGINESOURCE_HTML_BUNDLE_PATH})
      INSTALL(FILES ${CMAKE_SOURCE_DIR}/cmake.in/Platform.in/emscripten/executable/favicon-32x32.ico DESTINATION ${ENGINESOURCE_HTML_BUNDLE_PATH})

    else()

      INSTALL(TARGETS ${NJLI_PRODUCT_NAME} RUNTIME DESTINATION platform/${NJLI_BUILD_DIR}/${CMAKE_BUILD_TYPE}/bin )

    ENDIF( ${NJLI_BUILD_PLATFORM} STREQUAL "emscripten" )

  endif()

  INSTALL(DIRECTORY ${CMAKE_SOURCE_DIR}/cmake.in/ldoc DESTINATION ${CMAKE_INSTALL_DOCDIR})

  # https://cmake.org/Wiki/CMake:CPackConfiguration
  INCLUDE (InstallRequiredSystemLibraries)

  SET (CPACK_OUTPUT_FILE_PREFIX ${NJLI_PACKAGE_DIR})
  SET (CPACK_PACKAGE_NAME ${NJLIGameEngine_PACKAGE})
  SET (CPACK_PACKAGE_VENDOR "NJLI Games LLC.")
  SET (CPACK_PACKAGE_DESCRIPTION_SUMMARY ${NJLIGameEngine_PACKAGE_STRING})
  SET (CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")
  SET (CPACK_PACKAGE_VERSION_MAJOR "${NJLIGameEngine_VERSION_MAJOR}")
  SET (CPACK_PACKAGE_VERSION_MINOR "${NJLIGameEngine_VERSION_MINOR}")
  SET (CPACK_PACKAGE_VERSION_RELEASE "${NJLIGameEngine_VERSION_RELEASE}")
  SET (CPACK_PACKAGE_VERSION_PATCH "local")

  if (NOT $ENV{NJLIGameEngine_BUILD_NUMBER})
    SET (CPACK_PACKAGE_VERSION_PATCH $ENV{NJLIGameEngine_BUILD_NUMBER})
  endif (NOT $ENV{NJLIGameEngine_BUILD_NUMBER})
  INCLUDE(CPack)

ENDIF()
