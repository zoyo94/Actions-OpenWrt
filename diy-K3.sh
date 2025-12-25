#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 说明：
# 除了第一行的#!/bin/bash不要动，其他的设置，前面带#表示不起作用，不带的表示起作用了（根据你自己需要打开或者关闭）
#

# 安装依赖包
#sudo apt update -y
#sudo apt full-upgrade -y
#sudo apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
#bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
#git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev libgmp3-dev \
#libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev libreadline-dev \
#libssl-dev libtool lrzsz mkisofs msmtp ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 \
#python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion swig texinfo \
#uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev

# 修改openwrt登陆地址,把下面的192.168.2.2修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.5.1/g' ./package/base-files/files/bin/config_generate


# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/ZOYO/g' ./package/base-files/files/bin/config_generate

# 设定时区
sed -i "s/zonename='UTC'/zonename='Asia\/Shanghai'/" ./package/base-files/files/bin/config_generate
sed -i "s/timezone='[^']*'/timezone='CST-8'/" ./package/base-files/files/bin/config_generate

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' ./package/lean/default-settings/files/zzz-default-settings
# 只编译K3
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' ./target/linux/bcm53xx/image/Makefile


# 使用源码自带ShadowSocksR Plus+出国软件(与下方的vssr重复可以注释掉，文件不做修改)
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 修改wifi名称和wifi密码
sed -i 's/OpenWrt/Lede/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/none/psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '114a\                        set wireless.default_radio${devidx}.key=99987766654..' package/kernel/mac80211/files/lib/wifi/mac80211.sh
