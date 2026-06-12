#!/bin/bash
# 将默认网关从 192.168.1.1 修改为你习惯的 192.168.8.1。注意 ZC360 模板默认 IP 是 192.168.1.1
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

# 强制将默认主题设为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 以上游 defconfig 为基底（获取正确的平台配置），但只编译小米 AX3000T 固件
mv .config .config.bak
cp -f defconfig/mt7981-ax3000.config .config

# 关闭多设备构建模式（这是编译出多个路由器固件的根源）
sed -i '/CONFIG_TARGET_MULTI_PROFILE/d' .config
sed -i '/CONFIG_TARGET_PER_DEVICE_ROOTFS/d' .config

# 删除所有设备选择行和设备包配置行，只保留 AX3000T
sed -i '/CONFIG_TARGET_DEVICE_/d' .config
echo "CONFIG_TARGET_DEVICE_mediatek_mt7981_DEVICE_xiaomi_mi-router-ax3000t=y" >> .config

# 追加用户自定义的软件包选项（过滤掉目标平台相关行，避免与 defconfig 冲突）
grep -E '=y$|=m$' .config.bak | grep -v 'CONFIG_TARGET_' >> .config
