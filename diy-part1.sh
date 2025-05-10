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
sed -i 's/192.168.1.1/192.168.5.1/g' ./package/base-files/luci2/bin/config_generate


# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/LEDE/R2S/g' ./package/base-files/luci2/bin/config_generate

# 设定时区
sed -i 's/UTC/CST-8/g' ./package/base-files/luci2/bin/config_generate
sed -i "245a\                set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/luci2/bin/config_generate


# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' ./package/lean/default-settings/files/zzz-default-settings

git clone --depth 1 https://github.com/QiuSimons/luci-app-daed.git package/zoyo/luci-app-daed
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns.git package/zoyo/luci-app-mosdns
git clone --depth 1 https://github.com/gdy666/luci-app-lucky.git package/zoyo/luci-app-lucky
git clone --depth 1 -b dev https://github.com/vernesong/OpenClash.git package/zoyo/luci-app-openclash
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/zoyo/luci-theme-argon
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/zoyo/luci-app-argon-config
git clone --depth 1 https://github.com/liudf0716/luci-app-yt-dlp.git feeds/luci/applications/luci-app-yt-dlp

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
sed -i '$a src-git kiddin9 https://github.com/kiddin9/kwrt-packages' feeds.conf.default

sudo ln -s /usr/bin/llvm-strip-16 /usr/bin/llvm-strip