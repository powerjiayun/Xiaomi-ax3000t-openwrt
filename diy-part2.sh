#!/bin/bash
# 将默认网关从 192.168.1.1 修改为你习惯的 192.168.8.1。注意 ZC360 模板默认 IP 是 192.168.1.1
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

# 强制将默认主题设为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

mv .config .config.bak
cp -f defconfig/mt7981-ax3000.config .config
grep -E '=y$|=m$' .config.bak >> .config

# 只编译 AX3000T：删除 defconfig 自带的其它设备型号，避免编译出一堆其他路由器的固件
sed -i '/^CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_.*=y/d' .config
echo "CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_xiaomi_mi-router-ax3000t=y" >> .config
