#!/bin/bash
#Mac&Linux build image tools
#repack system.img
echo "#########################"
echo "依次打包 system vendor 分区"
echo "#########################"
echo "正在打包 system 分区"
echo "请输入分区大小，单位GB"
if read -t 60 -p "请输入指令进行操作 " sys_size; then #如果超时60秒钟没有输入，则执行else中的命令
    echo "你输入的大小是" $sys_size "GB"
    echo build system.img
    ./bin/make_ext4fs -T 0 -S work/file_contexts -l $sys_size"g" -a system work/system.img work/system/
    echo "####################"
    echo "Done"
    echo "####################"
else
    echo "timeout"
fi

#repack vendor.img
echo "正在打包 vendor 分区"
echo "请输入分区大小，单位GB"
if read -t 60 -p "请输入指令进行操作 " vendor_size; then #如果超时60秒钟没有输入，则执行else中的命令
    echo "你输入的大小是" $vendor_size "GB"
    echo build vendor.img
    ./bin/make_ext4fs -T 0 -S work/file_contexts -l $vendor_size"g" -a vendor work/vendor.img work/vendor/
    echo "####################"
    echo "Done"
    echo "####################"
else
    echo "timeout"
fi

#img2sdat,img2vimg
echo "img2simg ing..."
./bin/img2simg work/system.img work/systems.img
echo "img2vimg ing..."
./bin/img2simg work/vendor.img work/vendors.img
echo "img2simg Deon"
echo "img2dat ing..."
./bin/img2sdat/img2sdat.py work/systems.img -o work/tmp -p system -v 4
echo "img2vdat ing..."
./bin/img2sdat/img2sdat.py work/vendors.img -o work/tmp -p vendor -v 4
echo "Deon"
