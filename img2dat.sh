#! /bin/bash
echo "img2simg ing..."
./bin/img2simg system.img systems.img
echo "img2vimg ing..."
./bin/img2simg vendor.img vendors.img
echo "img2simg Deon"
echo "img2dat ing..."
./bin/img2sdat.py systems.img -o tmp -p system -v 4
echo "img2vdat ing..."
./bin/img2sdat.py vendors.img -o tmp -p vendor -v 4
echo "Deon"