# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.YappyBirds.Debug:
/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Debug/YappyBirds.app/Contents/MacOS/YappyBirds:\
	/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/../../Engine/generated/platform/macOS/10.13/macosx/Release/lib/libnjli.dylib
	/bin/rm -f /Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Debug/YappyBirds.app/Contents/MacOS/YappyBirds


PostBuild.YappyBirds.Release:
/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Release/YappyBirds.app/Contents/MacOS/YappyBirds:\
	/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/../../Engine/generated/platform/macOS/10.13/macosx/Release/lib/libnjli.dylib
	/bin/rm -f /Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/Release/YappyBirds.app/Contents/MacOS/YappyBirds


PostBuild.YappyBirds.MinSizeRel:
/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/MinSizeRel/YappyBirds.app/Contents/MacOS/YappyBirds:\
	/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/../../Engine/generated/platform/macOS/10.13/macosx/Release/lib/libnjli.dylib
	/bin/rm -f /Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/MinSizeRel/YappyBirds.app/Contents/MacOS/YappyBirds


PostBuild.YappyBirds.RelWithDebInfo:
/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/RelWithDebInfo/YappyBirds.app/Contents/MacOS/YappyBirds:\
	/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/../../Engine/generated/platform/macOS/10.13/macosx/Release/lib/libnjli.dylib
	/bin/rm -f /Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/projects/macOS_Xcode/MyStage/RelWithDebInfo/YappyBirds.app/Contents/MacOS/YappyBirds




# For each target create a dummy ruleso the target does not have to exist
/Users/jamesfolk/Documents/NJLI/Games/YappyBirds-2.0/../../Engine/generated/platform/macOS/10.13/macosx/Release/lib/libnjli.dylib:
