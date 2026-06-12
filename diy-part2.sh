#!/bin/bash
# 将默认网关从 192.168.1.1 修改为你习惯的 192.168.8.1。注意 ZC360 模板默认 IP 是 192.168.1.1
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

# 强制将默认主题设为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 直接使用用户自定义的 .config，由 make defconfig 自动补全依赖
# 不再使用源码 defconfig 做基底，避免编译出其他路由器的固件
