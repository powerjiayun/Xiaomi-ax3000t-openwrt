#!/bin/bash
# 将默认网关从 192.168.1.1 修改为你习惯的 192.168.8.1。注意 ZC360 模板默认 IP 是 192.168.1.1
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

# 强制将默认主题设为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 核心防坑（安全版）：以 237 官方 defconfig 为基底，仅追加用户自定义的“启用/模块”选项，不带任何 is not set

mv .config .config.bak
cp -f defconfig/mt7981-ax3000.config .config
grep -E '=y$|=m$' .config.bak >> .config
