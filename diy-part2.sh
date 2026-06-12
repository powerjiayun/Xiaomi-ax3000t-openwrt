#!/bin/bash
# 将默认网关从 192.168.1.1 修改为你习惯的 192.168.8.1。注意 ZC360 模板默认 IP 是 192.168.1.1
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

# 强制将默认主题设为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 以上游 defconfig 为基底（获取正确的平台配置），但只编译小米 AX3000T 固件
mv .config .config.bak
cp -f defconfig/mt7981-ax3000.config .config

# 保留 CONFIG_TARGET_MULTI_PROFILE=y（多设备模式），这样才能精确选择单个设备
# 如果删掉它，make defconfig 会回退到单 Profile 模式，自动选择字母序第一个设备（ABT ASR3000）

# 删除所有设备选择行和设备包配置行
sed -i '/CONFIG_TARGET_DEVICE_/d' .config

# 只添加小米 AX3000T（注意子目标是 filogic，不是 mt7981）
echo "CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_xiaomi_mi-router-ax3000t=y" >> .config

# 追加用户自定义的软件包选项（过滤掉目标平台相关行，避免与 defconfig 冲突）
grep -E '=y$|=m$' .config.bak | grep -v 'CONFIG_TARGET_' >> .config
