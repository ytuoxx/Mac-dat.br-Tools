#! /bin/bash
echo "mount system.img ing..."
./bin/fuse-ext2 ./system.img system -o rw+
echo "mount vendor.img ing..."
./bin/fuse-ext2 ./vendor.img vendor -o rw+
echo "Deon"