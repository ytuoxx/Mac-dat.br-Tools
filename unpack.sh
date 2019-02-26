#!/bin/bash

NEW_SDAT=./file/system.new.dat.br
PATCH_SDAT=./file/system.patch.dat
STRANS_LIST=./file/system.transfer.list

NEW_VDAT=./file/vendor.new.dat.br
PATCH_VDAT=./file/vendor.patch.dat
VTRANS_LIST=./file/vendor.transfer.list

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

TARGET_DIR=work
if [ $# -eq 2 ]; then
	TARGET_DIR=$1
fi

mkdir -p $TARGET_DIR
if [ $? -ne 0 ]; then
	exit 1
fi

#sdat.br2sdat
echo "system.new.dat.br 2 system.new.dat ing..."
./bin/brotli -d ./file/system.new.dat.br
echo "vendor.new.dat.br 2 vendor.new.dat ing..."
./bin/brotli -d ./file/vendor.new.dat.br
echo "###############"
echo "Deon"
echo "###############"
rm ./file/system.new.dat.br ./file/vendor.new.dat.br

#sdat2img
echo "sdat2img ing..."
./bin/sdat2img.py ./file/system.transfer.list ./file/system.new.dat ./file/system.img
echo "vdat2img ing..."
./bin/sdat2img.py ./file/vendor.transfer.list ./file/vendor.new.dat ./file/vendor.img
mv system.img vendor.img file
echo "###############"
echo "Deon"
echo "###############"
rm ./file/system.new.dat ./file/vendor.new.dat

#file_contexts
./bin/sefcontext_parser.py ./file/file_contexts.bin
mv file_contexts work
echo "###############"
echo "Deon"
echo "###############"

#mount img
echo "mount system.img ing..."
./bin/fuse-ext2 ./file/system.img ./file/system -o rw+
echo "mount vendor.img ing..."
./bin/fuse-ext2 ./file/vendor.img ./file/vendor -o rw+
echo "###############"
echo "Deon"
echo "###############"

#zip system vendor
echo "zip system vendor"
cd ./file/system
zip -r -o ../../work/system.zip ./
cd ..

cd ./vendor
zip -r -o ../../work/vendor.zip ./
cd ../..
echo "###############"
echo "Deon"
echo "###############"

#unzip system vendor
echo "unzip system vendor"
unzip work/system.zip -d work/system
unzip work/vendor.zip -d work/vendor
echo "###############"
echo "Deon"
echo "###############"