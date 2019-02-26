#!/bin/bash

UPD_BIN=./bin/mkotazip/update-binary
UPD_SCP=./bin/mkotazip/updater-script

NEW_SDAT=./work/tmp/system.new.dat.br
PATCH_SDAT=./work/tmp/system.patch.dat
STRANS_LIST=./work/tmp/system.transfer.list

NEW_VDAT=./work/tmp/vendor.new.dat.br
PATCH_VDAT=./work/tmp/vendor.patch.dat
VTRANS_LIST=./work/tmp/vendor.transfer.list

BOOT_IMG=./work/tmp/boot.img

TARGET_DIR=./work/tmp/otazip
if [ $# -eq 2 ]; then
	TARGET_DIR=$1
fi

UPDATE_DIR=$TARGET_DIR/META-INF/com/google/android/

if [ ! -f $UPD_BIN ]; then
	echo $UPD_BIN not exists. quit...
	exit 1
fi 

if [ ! -f $UPD_SCP ]; then
	echo $UPD_SCP not exists. quit...
	exit 1
fi 

#system
if [ ! -f $NEW_SDAT ]; then
	echo $NEW_SDAT not exists. quit...
	exit 1
fi 

if [ ! -f $PATCH_SDAT ]; then
	echo $PATCH_SDAT not exists. quit...
	exit 1
fi 

if [ ! -f $STRANS_LIST ]; then
	echo $STRANS_LIST not exists. quit...
	exit 1
fi 

#vendor
if [ ! -f $NEW_VDAT ]; then
	echo $NEW_VDAT not exists. quit...
	exit 1
fi 

if [ ! -f $PATCH_VDAT ]; then
	echo $PATCH_VDAT not exists. quit...
	exit 1
fi 

if [ ! -f $VTRANS_LIST ]; then
	echo $VTRANS_LIST not exists. quit...
	exit 1
fi 

if [ -d $TARGET_DIR ]; then
	echo dir $TARGET_DIR existed, empty it [No/yes]?
	read REPLY
	if [ "$REPLY" != "yes" ]; then
		exit 1;
	fi
	rm -rf $TARGET_DIR
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi

mkdir -p $TARGET_DIR
if [ $? -ne 0 ]; then
	exit 1
fi

mkdir -p $UPDATE_DIR
if [ $? -ne 0 ]; then
	exit 1
fi
mv $NEW_DAT $TARGET_DIR/
mv $PATCH_DAT $TARGET_DIR/
mv $TRANS_LIST $TARGET_DIR/
if [ -f $BOOT_IMG ]; then
	cp $BOOT_IMG $TARGET_DIR/
fi
cp $UPD_BIN $UPDATE_DIR/
cp $UPD_SCP $UPDATE_DIR/

LOCAL_DIR=`pwd`
echo cd $TARGET_DIR ...

cd $TARGET_DIR
zip -r ota.zip *
cd $LOCAL_DIR