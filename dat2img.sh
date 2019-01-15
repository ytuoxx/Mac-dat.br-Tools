#! /bin/bash
echo "sdat2img ing..."
./bin/sdat2img.py system.transfer.list system.new.dat system.img
echo "vdat2img ing..."
./bin/sdat2img.py vendor.transfer.list vendor.new.dat vendor.img
echo "Deon"