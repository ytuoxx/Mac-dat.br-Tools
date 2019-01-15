####Mac解包安卓 dat.br文件工具说明：

1.解压Mac解包安卓dat.br文件工具

2.将ROM解包出来的文件：

```
system.new.dat.br

system.transfer.list

vendor.new.dat

vendor.transfer.list
```

放到Mac_dat.br_tools目录下，然后打开终端进入Mac_dat.br_tools

解包命令依次输入:

```
chmod +x brotli.sh dat2img.sh fuse-ext2.sh

./brotli.sh			//将.dat.br文件转换成.dat文件

./dat2img.sh		//将.dat文件转换成.img文件

./fuse-ext2.sh		//将.img挂载
```

 打包命令依次输入:

```
chmod +x img2dat.sh

./img2dat.sh		//将.img文件转成.dat文件，生死文件在tmp目录
```



注意：

使用fuse-ext2之前需要安装osxfuse，安装的时候全部勾选。

osxfuse:
https://osxfuse.github.io/