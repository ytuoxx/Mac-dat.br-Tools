#! /bin/bash
echo "system.new.dat.br 2 system.new.dat ing..."
./bin/brotli -d system.new.dat.br
echo "vendor.new.dat.br 2 vendor.new.dat ing..."
./bin/brotli -d vendor.new.dat.br
echo "Deon"