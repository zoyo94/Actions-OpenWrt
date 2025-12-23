#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# 修改openwrt登陆地址,把下面的192.168.2.2修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.5.1/g' ./package/base-files/luci/bin/config_generate


# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/LEDE/X86/g' ./package/base-files/luci/bin/config_generate

# 设定时区
sed -i 's/UTC/CST-8/g' ./package/base-files/luci/bin/config_generate
sed -i "245a\                set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/luci2/bin/config_generate


# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' ./package/lean/default-settings/files/zzz-default-settings

#git clone --depth 1 https://github.com/QiuSimons/luci-app-daed.git package/lean/luci-app-daed
#git clone --depth 1 https://github.com/sbwml/luci-app-mosdns.git package/lean/luci-app-mosdns
#git clone --depth 1 https://github.com/gdy666/luci-app-lucky.git package/lean/luci-app-lucky
#git clone --depth 1 -b dev https://github.com/vernesong/OpenClash.git package/lean/luci-app-openclash
#git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
#git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config
git clone --recurse-submodules --depth=1 https://github.com/zoyo94/luci-lib.git  package/luci-lib
# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git kiddin9 https://github.com/kiddin9/kwrt-packages' feeds.conf.default

# llvm-strip 命令找不到
ls -al /usr/bin/ | grep llvm-strip
sudo ln -s /usr/bin/llvm-strip-15 /usr/bin/llvm-strip
