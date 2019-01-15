#!/bin/bash

mkdir work

echo "system.new.dat.br 2 system.new.dat ing..."
./bin/brotli -d ./file/system.new.dat.br
echo "vendor.new.dat.br 2 vendor.new.dat ing..."
./bin/brotli -d ./file/vendor.new.dat.br
echo "###############"
echo "Deon"
echo "###############"
rm ./file/system.new.dat.br ./file/vendor.new.dat.br

echo "sdat2img ing..."
./bin/sdat2img.py ./file/system.transfer.list ./file/system.new.dat ./file/system.img
echo "vdat2img ing..."
./bin/sdat2img.py ./file/vendor.transfer.list ./file/vendor.new.dat ./file/vendor.img
mv system.img vendor.img file
echo "###############"
echo "Deon"
echo "###############"
rm ./file/system.new.dat ./file/vendor.new.dat

./bin/sefcontext_parser.py ./file/file_contexts.bin
mv file_contexts work
echo "###############"
echo "Deon"
echo "###############"

echo "mount system.img ing..."
./bin/fuse-ext2 ./file/system.img ./file/system -o rw+
echo "mount vendor.img ing..."
./bin/fuse-ext2 ./file/vendor.img ./file/vendor -o rw+
echo "###############"
echo "Deon"
echo "###############"

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

echo "unzip system vendor"
unzip work/system.zip -d work/system
unzip work/vendor.zip -d work/vendor
echo "###############"
echo "Deon"
echo "###############"