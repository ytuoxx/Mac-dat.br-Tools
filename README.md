#### Mac解包/打包安卓 dat.br文件工具说明：

1.解压Mac解包/打包安卓dat.br文件工具

2.将ROM解包出来的文件：

```
system.new.dat.br

system.transfer.list

vendor.new.dat

vendor.transfer.list

file_contexts.bin
```

放到Mac_dat.br_tools/file目录下，然后打开终端进入Mac_dat.br_tools

一键操作：

```
chmod +x unpack.sh repack.sh

./unpack.sh			//解包并挂载

./repack.sh			//打包并生成.dat文件
```

单独打包 system.img/vendor.img

```
chmod +x build_img.sh

./build_img.sh
```



注意：

使用fuse-ext2之前需要安装osxfuse，安装的时候全部勾选。

osxfuse:
https://osxfuse.github.io/
