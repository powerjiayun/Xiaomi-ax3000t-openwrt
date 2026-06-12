# 项目规则

## GitHub 连接
- 本项目已通过 GitHub token 连接到远程仓库 `ninesun99/Xiaomi-ax3000t-openwrt`
- 可以直接通过 git push/pull 操作远程仓库，无需用户手动操作
- 修改文件后可以直接提交并推送到 GitHub

## 项目说明
- 这是一个小米 AX3000T 路由器的 OpenWrt 云编译项目
- 上游源码：https://github.com/padavanonly/immortalwrt-mt798x-6.6 (分支 openwrt-24.10-6.6)
- 上游子目标已从 filogic 改为 mt7981，配置文件中需使用 mt7981

## 提交规范
- 修改后如需推送到 GitHub，直接 git commit + git push 即可
- 提交前先运行 git status 和 git diff 确认变更内容
