#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#



# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/+luci-theme-bootstrap//g' ./feeds/luci/collections/luci/Makefile
sed -i '/+luci-theme-bootstrap/d' ./feeds/luci/collections/luci-light/Makefile 

# ttyd自动登录
sed -i '/\/bin\/login -f root/!s|/bin/login|/bin/login -f root|' feeds/packages/utils/ttyd/files/ttyd.config  
