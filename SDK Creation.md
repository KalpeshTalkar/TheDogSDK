# Creating `XCFramework` using aggregated target.

# XCFramework
An _XCFramework_ is a distributable binary package created by Xcode that contains variants of a framework or library so that it can be used on multiple platforms (iOS, macOS, tvOS, and watchOS), including Simulator builds. An XCFramework can be either static or dynamic and can include headers.
[Source](https://help.apple.com/xcode/mac/11.4/#/dev544efab96)

# Aggregated Targets
Aggregated Targets is used when we need to build multiple targets together somehow.

Xcode defines a special type of target that lets you build a group of targets at once, even if those targets do not depend on each other. An aggregate target has no associated product and no build rules. Instead, an aggregate target depends on each of the targets you want to build together. For example, you may have a group of products that you want to build together. You would create an aggregate target and make it depend on each of the product targets. To build all the products, just build the aggregate target.

An aggregate target may contain a custom Run Script build phase or a Copy Files build phase, but it cannot contain any other build phases. Any build settings that the aggregate target contains are not interpreted but are passed to the build phases that the target contains.

# Building and Creating XCFramework
1. Open the `TheDogSDK.xcodeproject`
2. Select the `TheDogSDK` scheme, build and test to see if there are no build errors or failing tests.
3. Select the `Aggregated` scheme and run the project.

This Aggregated scheme will build and generate archives (.xcarchive) of the framework for iPhone as well as the Simulator architectures.
These archives are then combined into one XCFramework.
The final framework will be created in the `Output` directory.
We can distribute this framework as a Swift Package or as a pod on Cocoapods.

## Commands used to create XCFramework
### xcarchive for Simulator
```
xcodebuild archive \
-scheme <scheme name> \
-destination "generic/platform=iOS Simulator" \
-archivePath <archive path> \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES
```

### xcarchive for Device
```
xcodebuild archive \
-scheme <scheme name> \
-destination "generic/platform=iOS" \
-archivePath <archive path> \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES
```

### Create xcframework - combine of all frameworks
```
xcodebuild -create-xcframework \
-framework <simulator framework path> \
-framework <device framework path> \
-output <path>
```

## Final script used for creating TheDogSDK
```
SCHEME_NAME="TheDogSDK"
FRAMEWORK_NAME="TheDogSDK"

SIMULATOR_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphonesimulator.xcarchive"
DEVICE_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphoneos.xcarchive"
OUTPUT_DIR="./Output/"

# Simulator xcarchive
xcodebuild archive \
-scheme ${SCHEME_NAME} \
-destination "generic/platform=iOS Simulator" \
-archivePath ${SIMULATOR_ARCHIVE_PATH} \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Device xcarchive
xcodebuild archive \
-scheme ${SCHEME_NAME} \
-destination "generic/platform=iOS" \
-archivePath ${DEVICE_ARCHIVE_PATH} \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Clean up old output directory
rm -rf "${OUTPUT_DIR}"

# Create xcframwork combine of all frameworks
xcodebuild -create-xcframework \
-framework ${SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
-framework ${DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
-output ${OUTPUT_DIR}/${FRAMEWORK_NAME}.xcframework
```
