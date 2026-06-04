#!/bin/bash
# 将默认网关从 192.168.1.1 修改为你习惯的 192.168.8.1。注意 ZC360 模板默认 IP 是 192.168.1.1
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

# 强制将默认主题设为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 核心防坑（安全版）：以 237 官方 defconfig 为基底，仅追加用户自定义的“启用/模块”选项，不带任何 is not set
mv .config .config.bak
cp -f defconfig/mt7981-ax3000.config .config

# 删掉多设备模式和所有设备条目
sed -i '/CONFIG_TARGET_MULTI_PROFILE/d' .config
sed -i '/CONFIG_TARGET_PER_DEVICE_ROOTFS/d' .config
sed -i '/CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_/d' .config

# 只写回 AX3000T
cat >> .config << 'EOF'
CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_xiaomi_mi-router-ax3000t=y
CONFIG_TARGET_DEVICE_PACKAGES_mediatek_filogic_DEVICE_xiaomi_mi-router-ax3000t=""
EOF

grep -E '=y$|=m$' .config.bak >> .config

# ===== 临时修复：HeYangTek 驱动与 U-Boot 2024.10 API 不兼容 =====

# 等上游 PR #389 合并后删除下面 3 行

UBOOT_PATCH="package/boot/uboot-mediatek/patches/344-mtd-spinand-add-support-for-HeYangTek-HYF1GQ4UDACAE.patch"

sed -i 's/nanddev_get_ecc_conf(nand)->strength >> 1/nand->eccreq.strength >> 1/' $UBOOT_PATCH

sed -i 's/nanddev_get_ecc_conf(nand)->strength/nand->eccreq.strength/' $UBOOT_PATCH

# ===== 临时修复到此结束 =====
