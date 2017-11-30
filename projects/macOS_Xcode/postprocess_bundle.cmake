

          include(BundleUtilities)
          #SET(GLOB shared_libs "/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/../../Engine/generated/platform/macOS/10.13/macosx/Release/lib/*.dylib")

          fixup_bundle("/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Release/YappyBirds.app" "" "/assets"  )
          message("Signing application bundle: /Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Release/YappyBirds.app")
          # https://www.slicer.org/wiki/Documentation/Nightly/Developers/Mac_OS_X_Code_Signing
          #execute_process(
          #  COMMAND codesign --deep --force --sign "SRBQ5SCF5X" -i "com.njligames.YappyBirds" "/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Release/YappyBirds.app"
          #)
          #execute_process(
          #  COMMAND codesign -dv "/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Release/YappyBirds.app"
          #)
          #execute_process(
          #  COMMAND /usr/local/Cellar/cmake/3.9.4_1/bin/cmake -E copy_directory "/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/../../Engine/generated/platform/macOS/10.13/macosx/Release/lib" "/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Release/YappyBirds.app/Contents/MacOS"
          #COMMAND /usr/local/Cellar/cmake/3.9.4_1/bin/cmake -E copy "$<TARGET_FILE:libnjli_shared>$<TARGET_FILE_DIR:YappyBirds>"
          #  )
          #set(CMAKE_INSTALL_RPATH "/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Release/YappyBirds.app/Contents/MacOS")
          #set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE) # only if you want copy from the build tree
        