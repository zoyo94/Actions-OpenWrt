#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 说明：
# 除了第一行的#!/bin/bash不要动，其他的设置，前面带#表示不起作用，不带的表示起作用了（根据你自己需要打开或者关闭）
#

# 安装依赖包
#yum update
#yum -y install ipset diffutils wget asciidoc binutils bzip2 gawk gettext git patch python3 unzip subversion flex git-core texinfo xmlto autoconf automake libtool gcc binutils patch bzip2 flex bison make autoconf gettext texinfo unzip sharutils ncurses-term wget perl-Thread-Queue openssl-devel zlib-static ncurses-devel ca-certificates gcc-c++ 

# 修改openwrt登陆地址,把下面的192.168.2.2修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.3.1/g' ./package/base-files/files/bin/config_generate


# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/ZOYO/g' ./package/base-files/files/bin/config_generate

# 设定时区
sed -i 's/UTC/CST-8/g' ./package/base-files/files/bin/config_generate
sed -i "245a\                set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate


# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' ./package/lean/default-settings/files/zzz-default-settings


# 使用源码自带ShadowSocksR Plus+出国软件(与下方的vssr重复可以注释掉，文件不做修改)
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 修改wifi名称和wifi密码
sed -i 's/OpenWrt/Lede/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/none/psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '114a\                        set wireless.default_radio${devidx}.key=99987766654..' package/kernel/mac80211/files/lib/wifi/mac80211.sh


# 修改banne文件（banne文件在根目录）（不要修改此行代码,怕弄的diy-lede.sh文件全失效,不需要的话前面加#，或者全行代码删除了）
#rm -rf ./package/base-files/files/etc/banner && cp -f ./banner ./package/base-files/files/etc/



#内核版本是会随着源码更新而改变的，在coolsnowwolf/lede的源码查看最好，以X86机型为例，源码的target/linux/x86文件夹可以看到有几个内核版本，x86文件夹里Makefile可以查看源码正在使用内核版本
#修改版本内核（下面两行代码前面有#为源码默认最新5.4内核,没#为4.19内核,默认修改X86的，其他机型L大源码那里target/linux查看，对应修改下面的路径就好）
#sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本

# 备份k3screenctrl源码
#mv package/lean/k3screenctrl package/lean/k3screenctrl_bak

#添加自定义插件链接（自己想要什么就github里面搜索然后添加）
#git clone https://github.com/sbwml/openwrt-alist --depth=1 package/lean/openwrt-alist
git clone https://github.com/kongfl888/luci-app-adbyby-plus-lite.git --depth=1 package/lean/luci-app-adbyby-plus-lite
#git clone https://github.com/kenzok8/openwrt-packages.git package/lean/openwrt-package
#git clone https://github.com/lwz322/k3screenctrl.git package/lean/k3screenctrl
#git clone https://github.com/lwz322/k3screenctrl_build.git package/lean/k3screenctrl_build
#git clone https://github.com/lwz322/luci-app-k3screenctrl.git package/lean/luci-app-k3screenctrl
#git clone -b master https://github.com/vernesong/OpenClash.git package/lean/luci-app-openclash  #openclash出国软件
#git clone https://github.com/tty228/luci-app-serverchan.git package/lean/luci-app-serverchan  #微信推送
#git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/lean/luci-app-smartdns  #smartdns DNS加速
#git clone https://github.com/destan19/OpenAppFilter.git  package/lean/OpenAppFilter  #OpenAppFilter OpenWrt的家长管理插件，支持游戏、视频、聊天、下载等app过滤
#git clone https://github.com/xiaorouji/openwrt-passwall.git package/lean/openwrt-passwall #主题及科学上网插件
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb #uci-app-vss依赖包
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/lean/luci-app-vssr #A new SSR SS V2ray Trojan luci app

#rm -rf ./package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon  #新的argon主题
#全新的[argon-主题]此主题玩法很多,这里看说明【https://github.com/jerrykuku/luci-theme-argon/blob/18.06/README_ZH.md】
#用WinSCP连接openwrt，在/www/luci-static/argon里面创建background文件夹（如果本身就有background就不需要创建）来存放jpg png gif格式图片可以自定义登陆界面，gif图片为动态登陆界面

#rm -rf ./package/lean/luci-theme-argon

# 导入所有的软件包
#cp -r ~/park/* ./package/lean/
#mv ./package/lean/brcmfmac4366c-pcie.bin ./package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/

# 用lean原本的k3screenctrl替换新的编译文件,勾选完软件后删除掉，./configure再生成一遍
#cp -r ./package/lean/k3screenctrl_bak/* ./package/lean/k3screenctrl/
#rm -rf ./package/lean/k3screenctrl_bak

# 删除掉k3screenctrl依赖项
#sed -i 's/ +coreutils +coreutils-od +bash +curl//g' ./package/lean/k3screenctrl_build/Makefile

# 添加feeds
echo 'src-git lienol https://github.com/Lienol/openwrt-package' >> feeds.conf.default

#添加ddnsto
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' >> feeds.conf.default

#  kenzok8/openwrt-packages中passwall依赖
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default

#OpenWrt的家长管理插件，支持游戏、视频、聊天、下载等app过滤
sed -i '$a src-git OpenAppFilter https://github.com/destan19/OpenAppFilter' feeds.conf.default

# 只编译K3
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' ./target/linux/bcm53xx/image/Makefile

# 软连接feeds
ln -sf ~/feeds feeds


# 执行如下命令更新feeds(第三方包)
./scripts/feeds update -a

# 取消掉luci-theme-bootstrap默认
sed -i 's/+luci-theme-bootstrap//g' ./feeds/luci/collections/luci/Makefile

# 修改默认语言主题
sed -i 's/auto/"zh_cn"/g' feeds/luci/modules/luci-base/root/etc/config/luci
sed -i '15a\        option zh_cn "普通话(chinese)"' feeds/luci/modules/luci-base/root/etc/config/luci

# 执行如下命令 安装feeds(第三方包)
./scripts/feeds install -a

# 软连接dl库
ln -sf ~/dl dl

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
