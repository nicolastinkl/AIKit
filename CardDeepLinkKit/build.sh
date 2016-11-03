#!/bin/sh




#真机编译

xcodebuild clean -configuration Release     #clean项目


xcodebuild -project CardDeepLinkKit.xcodeproj -target CardDeepLinkKit -configuration Release  -sdk iphoneos build

#模拟器编译

xcodebuild -project CardDeepLinkKit.xcodeproj -target CardDeepLinkKit -configuration Release  -sdk iphonesimulator build

#合并


Device_Dir = $PWD/build/Release-iphoneos/CardDeepLinkKit.framework

Simulator_Dir = $PWD/build/Release-iphonesimulator/CardDeepLinkKit.framework

Product_Dir = $PWD/Product/CardDeepLinkKit.framework


if [ -d "${Product_Dir}" ]
then
rm -rf "${Product_Dir}"
fi

mkdir -p "${Product_Dir}"

#cp -R "${Device_Dir}/" "${Product_Dir}/"
#ditto "${DEVICE_DIR}/Headers" "${INSTALL_DIR}/Headers"

lipo -create "${Device_Dir}" "${Simulator_Dir}" -output "${Product_Dir}"

#open "${DEVICE_DIR}"
#open "${SRCROOT}/Products"
fi
