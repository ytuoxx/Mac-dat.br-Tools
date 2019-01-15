#!/bin/bash
#build android 7.x + make_ext4fs for mac

mkdir source
mkdir bin

# clone source
cd source

proxychains4 git clone --branch nougat-release https://android.googlesource.com/platform/external/libselinux
proxychains4 git clone --branch nougat-release https://android.googlesource.com/platform/external/pcre
proxychains4 git clone --branch nougat-release https://android.googlesource.com/platform/system/core
proxychains4 git clone --branch nougat-release https://android.googlesource.com/platform/external/zlib
proxychains4 git clone --branch nougat-release https://android.googlesource.com/platform/system/extras

# build for make_ext4fs
echo building pcre
cd pcre
gcc -c \
       pcre_chartables.c \
       dist/pcre_byte_order.c \
       dist/pcre_compile.c \
       dist/pcre_config.c \
       dist/pcre_dfa_exec.c \
       dist/pcre_exec.c \
       dist/pcre_fullinfo.c \
       dist/pcre_get.c \
       dist/pcre_globals.c \
       dist/pcre_jit_compile.c \
       dist/pcre_maketables.c \
       dist/pcre_newline.c \
       dist/pcre_ord2utf8.c \
       dist/pcre_refcount.c \
       dist/pcre_study.c \
       dist/pcre_tables.c \
       dist/pcre_ucd.c \
       dist/pcre_valid_utf8.c \
       dist/pcre_version.c \
       dist/pcre_xclass.c \
       dist/pcrecpp.cc \
       dist/pcre_scanner.cc \
       dist/pcre_stringpiece.cc \
       -DHAVE_CONFIG_H \
       -Wno-self-assign \
       -Wno-unused-parameter \
       -I./ \
       -Idist
cd ..

echo building libselinux    
cd libselinux
gcc -c \
	src/booleans.c \
	src/canonicalize_context.c \
	src/disable.c \
	src/enabled.c \
	src/getenforce.c \
	src/getpeercon.c \
	src/load_policy.c \
	src/policyvers.c \
	src/setenforce.c \
	src/context.c \
	src/mapping.c \
	src/stringrep.c \
	src/compute_create.c \
	src/compute_av.c \
	src/avc.c \
	src/avc_sidtab.c \
	src/get_initial_context.c \
	src/sestatus.c \
	src/deny_unknown.c \
       src/callbacks.c \
	src/check_context.c \
	src/freecon.c \
	src/init.c \
	src/label.c \
	src/label_file.c \
	src/label_android_property.c \
	src/label_support.c \
       -Iinclude \
       -I../core/include \
       -I../pcre \
       -DHOST -DDARWIN
ar rcs libselinux.a *.o ../pcre/*.o
cd ..

echo building libz
cd zlib
gcc -c \
       src/adler32.c \
	src/compress.c \
	src/crc32.c \
	src/deflate.c \
	src/gzclose.c \
	src/gzlib.c \
	src/gzread.c \
	src/gzwrite.c \
	src/infback.c \
	src/inflate.c \
	src/inftrees.c \
	src/inffast.c \
	src/trees.c \
	src/uncompr.c \
	src/zutil.c \
       -O3 -DUSE_MMAP
ar rcs libz.a *.o
cd ..

echo building libbase
cd core/base
gcc -c \
       parsenetaddress.cpp \
       stringprintf.cpp \
       strings.cpp \
       errors_unix.cpp \
       -Iinclude \
       -Wexit-time-destructors
ar rcs libbase.a *.o
cd ../..

echo building libsparse
cd core/libsparse
gcc -c \
       backed_block.c \
       output_file.c \
       sparse.c \
       sparse_crc32.c \
       sparse_err.c \
       -Iinclude \
       -I../../zlib

gcc -c \
       sparse_read.c \
       -Iinclude \
       -I../base/include
ar rcs libsparse.a *.o

gcc -o simg2img \
       simg2img.c \
       libsparse.a \
       ../../zlib/libz.a \
       ../base/libbase.a -lstdc++ \
       -Iinclude
cp simg2img ../../../bin

gcc -o simg2simg \
       simg2simg.c \
       libsparse.a \
       ../../zlib/libz.a \
       ../base/libbase.a -lstdc++ \
       -Iinclude
cp simg2simg ../../../bin

gcc -o append2simg \
       append2simg.c \
       libsparse.a \
       ../../zlib/libz.a \
       ../base/libbase.a -lstdc++ \
       -Iinclude
cp append2simg ../../../bin
cd ../..

echo building liblog
cd core/liblog
gcc -c \
       log_event_list.c \
       log_event_write.c \
       logger_write.c \
       config_write.c \
       logger_name.c \
       logger_lock.c \
       fake_log_device.c \
       fake_writer.c \
       event_tag_map.c \
       config_read.c \
       log_time.cpp \
       logger_read.c \
       -DFAKE_LOG_DEVICE=1 \
       -Werror -fvisibility=hidden \
       -I../include
ar rcs liblog.a *.o
cd ../..

echo building make_ext4fs
cd extras/ext4_utils
gcc -o make_ext4fs \
       make_ext4fs_main.c \
       make_ext4fs.c \
       ext4fixup.c \
       ext4_utils.c \
       allocate.c \
       contents.c \
       extent.c \
       indirect.c \
       sha1.c \
       wipe.c \
       crc16.c \
       ext4_sb.c \
       ../../core/libcutils/canned_fs_config.c \
       ../../core/libcutils/fs_config.c \
       ../../core/libsparse/libsparse.a \
       ../../core/base/libbase.a \
       ../../zlib/libz.a \
       ../../core/liblog/liblog.a \
       ../../libselinux/libselinux.a \
       -I../../libselinux/include \
       -I../../core/libsparse/include \
       -I../../core/include \
       -I../../core/libcutils/include \
       -Iinclude \
       -DHOST -DANDROID -fno-strict-aliasing \
       -lpthread
cp make_ext4fs ../../../bin
cd ../..
