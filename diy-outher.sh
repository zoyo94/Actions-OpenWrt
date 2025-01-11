# 取消掉luci-theme-bootstrap默认
#sed -i 's/+luci-theme-bootstrap//g' ./feeds/luci/collections/luci/Makefile

# 修改默认语言主题
sed -i 's/auto/"zh_cn"/g' feeds/luci/modules/luci-base/root/etc/config/luci
sed -i '15a\        option zh_cn "普通话(chinese)"' feeds/luci/modules/luci-base/root/etc/config/luci
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
