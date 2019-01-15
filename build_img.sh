#!/bin/bash
#Mac&Linux build image tools

echo "请输入需要打包的分区"
echo "1. system"
echo "2. vendor"

if read -t 60 -p "请输入指令进行操作 " input; then #如果超时60秒钟没有输入，则执行else中的命令
    var=1
    if [ $input -eq $var ]; then
        echo "你已经选择了 system 分区"
        echo "请输入分区大小，单位GB"
        if read -t 60 -p "请输入指令进行操作 " size; then #如果超时60秒钟没有输入，则执行else中的命令
            echo "你输入的大小是" $size "GB"
            echo build system.img
            ./bin/make_ext4fs -T 0 -S work/file_contexts -l $sys_size"g" -a system work/system.img work/system/
        fi

    elif [ $input -gt $var ]; then
        echo "你已经选择了 vendor 分区"
        echo "请输入分区大小，单位GB"
        if read -t 60 -p "请输入指令进行操作 " size; then #如果超时60秒钟没有输入，则执行else中的命令
            echo "你输入的大小是" $size "GB"
            echo build vendor.img
            ./bin/make_ext4fs -T 0 -S work/file_contexts -l $vendor_size"g" -a vendor work/vendor.img work/vendor/
        fi
    fi
else
    echo "timeout"
fi
