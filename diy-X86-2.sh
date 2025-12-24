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


mkdir package/uwsgi
cd package/uwsgi

git init
git remote add origin https://github.com/immortalwrt/packages.git
git config core.sparsecheckout true
echo "net/uwsgi/*" >> .git/info/sparse-checkout
git pull origin master

rm -rf net/uwsgi/files-luci-support
cd ../..
cp -r feeds/packages/net/uwsgi/files-luci-support package/uwsgi/net/uwsgi/
rm -rf feeds/packages/net/uwsgi/*
mv package/uwsgi/net/uwsgi/* feeds/packages/net/uwsgi/
rm -rf package/uwsgi




# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/+luci-theme-bootstrap//g' ./feeds/luci/collections/luci/Makefile
sed -i '/+luci-theme-bootstrap/d' ./feeds/luci/collections/luci-light/Makefile 

# ttyd自动登录
sed -i '/\/bin\/login -f root/!s|/bin/login|/bin/login -f root|' feeds/packages/utils/ttyd/files/ttyd.config  
