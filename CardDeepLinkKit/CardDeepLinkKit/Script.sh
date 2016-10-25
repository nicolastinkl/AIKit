#!/bin/sh

#  Script.sh
#  CardDeepLinkKit
#
#  Created by asiainfo on 10/25/16.
#  Copyright © 2016 AsiaInfo. All rights reserved.




echo "${EFFECTIVE_PLATFORM_NAME}"

RELEASE_DIR=${BUILD_DIR}

#DEBUG_IMULLATOR_DIR_FRAME=${RELEASE_DIR}/Debug-iphonesimulator/${PROJECT_NAME}.framework
DEBUG_DIR_FRAME=${RELEASE_DIR}/Debug"${EFFECTIVE_PLATFORM_NAME}"/${PROJECT_NAME}.framework

#RELEASE_DIR_FRAME=${RELEASE_DIR}/Debug-iphoneos/${PROJECT_NAME}.framework

PRO_BUNDLE_DIR=${PROJECT_DIR}/${PROJECT_NAME}/Resoures/${PROJECT_NAME}.bundle

echo "================ start =================="
echo "${PRO_BUNDLE_DIR}"
BUNDLE_DIR=${DEBUG_DIR_FRAME}/${PROJECT_NAME}.bundle

echo "${BUNDLE_DIR}"
# 根据不同环境移动到指定目录：如模拟器和真机

#if [${EFFECTIVE_PLATFORM_NAME} == "-iphonesimulator"]


INSTALL_DIR=${SRCROOT}/Products/Debug"${EFFECTIVE_PLATFORM_NAME}"

echo "================ clear cache =================="
# Cleaning the oldest.
if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi
echo "================ mkdir path =================="
mkdir -p "${INSTALL_DIR}"

echo "================ do *.nib files =================="

if [ -d "${BUNDLE_DIR}" ];then
if ls ${DEBUG_DIR_FRAME}/*.nib >/dev/null 2>&1;then

rm -rf ${BUNDLE_DIR}/*.nib

rm -rf ${PRO_BUNDLE_DIR}/*.nib

cp -rf ${DEBUG_DIR_FRAME}/*.nib ${BUNDLE_DIR}

cp -rf ${DEBUG_DIR_FRAME}/*.nib ${PRO_BUNDLE_DIR}

rm -rf ${DEBUG_DIR_FRAME}/*.nib


# copy to bundle

cp -rf ${DEBUG_DIR_FRAME} ${INSTALL_DIR}

fi

fi

# copy framework to local path.

echo "================ finish shell. =================="
open "${INSTALL_DIR}"

