#!/bin/bash

shopt -s extglob
rm -rf package/boot/uboot-ramips
svn export --force https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/uboot-ramips package/boot/uboot-ramips
rm -rf target/linux/ramips/!(Makefile|patches-5.4)
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/ramips target/linux/ramips
rm -rf target/linux/ramips/{.svn,patches-5.4/.svn}
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/ramips/patches-5.4 target/linux/ramips/patches-5.4
curl -sfL https://git.io/J0klE -o package/kernel/linux/modules/video.mk
mkdir -p files/etc/rc.d


find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
rm -Rf target/linux/ramips/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips/patches-5.4 target/linux/ramips/patches-5.4


sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config
