#!/bin/bash

# 确保脚本在出错时立即退出
set -e

echo "================================================================="
echo "       macOS Apple Intelligence 启用辅助脚本 by KanShuRichard"
echo "================================================================="

# 1. 检测 SIP 状态
echo "正在检测 System Integrity Protection (SIP) 状态..."
sip_status=$(csrutil status)

if [[ $sip_status != *"System Integrity Protection status: disabled"* ]]; then
    echo "SIP (System Integrity Protection) 当前已启用。"
    echo "必须禁用 SIP 才能继续。"
    echo "请按照以下步骤操作："
    echo "1. 重启 Mac，并长按开机键进入恢复模式。"
    echo "2. 在恢复模式菜单栏中选择 '实用工具' -> '终端'。"
    echo "3. 在终端中输入 'csrutil disable' 并按回车。"
    echo "4. 输入 'reboot' 并按回车重启 Mac。"
    echo "SIP 禁用后，请再次运行此脚本。"
    echo "=============================================="
    exit 1
else
    echo "SIP (System Integrity Protection) 已禁用，可以继续。"
fi

echo ""
echo "=============================================="
echo "开始执行启用 Apple Intelligence 相关的步骤..."

# 2. 执行命令
echo "正在下载并安装第三方脚本 zouxian.sh..."
# 使用 sudo 下载文件到系统目录
sudo curl https://raw.githubusercontent.com/CatMe0w/zouxian/master/zouxian.sh -o /usr/local/bin/zouxian

# 确保下载成功
if [ ! -f "/usr/local/bin/zouxian" ]; then
    echo "错误：第三方脚本下载失败。请检查网络连接或 GitHub 仓库是否可用。"
    exit 1
fi

echo "赋予脚本执行权限..."
sudo chmod +x /usr/local/bin/zouxian

echo "执行第三方脚本 zouxian..."
# 执行下载的脚本
sudo /usr/local/bin/zouxian

echo ""
echo "=============================================="
echo "3. 请检查 Apple 智能状态"
echo "请现在去 '系统设置' -> 'Apple 智能'或'Siri' 检查'Apple智能'是否已经显示为开启状态。"
echo "如果 'Apple 智能' 已经出现。请将其开启，并继续按任意键。"
echo "如果 'Apple 智能' 没有出现，请不要继续，并在以下地址向该第三方脚本作者反馈问题："
echo "GitHub Issues: https://github.com/CatMe0w/zouxian/issues"
echo "按下 Enter 键继续（如果 Apple 智能已显示）..."
read -r < /dev/tty

echo ""
echo "=============================================="
echo "继续修改 eligibility.plist 文件..."

# 4. 修改文件权限以允许写入
echo "正在修改 /private/var/db/eligibilityd/eligibility.plist 的权限为 777..."
# 使用 sudo 修改文件权限
sudo chmod 777 /private/var/db/eligibilityd/eligibility.plist

# 确保文件存在且权限修改成功
if [ ! -w "/private/var/db/eligibilityd/eligibility.plist" ]; then
    echo "错误：无法修改 /private/var/db/eligibilityd/eligibility.plist 的权限。请确认路径正确并已禁用 SIP。"
    exit 1
fi

# 修改 plist 文件内容
echo "正在修改 eligibility.plist 中的特定键值..."
# 使用 PlistBuddy 修改值，将 3 改为 2
# 注意：PlistBuddy 的路径可能因 macOS 版本而异，通常在 /usr/libexec/
PLISTBUDDY="/usr/libexec/PlistBuddy"

if [ ! -f "$PLISTBUDDY" ]; then
    echo "警告：找不到 PlistBuddy 工具 ($PLISTBUDDY)。尝试使用默认路径。"
    PLISTBUDDY="PlistBuddy"
fi

# 修改 OS_ELIGIBILITY_DOMAIN_GREYMATTER 下的值
$PLISTBUDDY -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_COUNTRY_BILLING 2" /private/var/db/eligibilityd/eligibility.plist
$PLISTBUDDY -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE 2" /private/var/db/eligibilityd/eligibility.plist
$PLISTBUDDY -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_EXTERNAL_BOOT_DRIVE 2" /private/var/db/eligibilityd/eligibility.plist

# 修改 OS_ELIGIBILITY_DOMAIN_CALCIUM 下的值
$PLISTBUDDY -c "Set :OS_ELIGIBILITY_DOMAIN_CALCIUM:status:OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE 2" /private/var/db/eligibilityd/eligibility.plist

echo "eligibility.plist 修改完成。"

# 5. 恢复文件权限
echo "正在恢复 /private/var/db/eligibilityd/ 目录下文件的权限为 444..."
# 恢复权限
sudo chmod 444 /private/var/db/eligibilityd/*

# 确保权限修改成功
if [ -w "/private/var/db/eligibilityd/eligibility.plist" ]; then
    echo "错误：未能将 /private/var/db/eligibilityd/eligibility.plist 的权限恢复为 444。"
    # 继续，但不设置 uchg flag
else
    # 6. 设置 immutable flag
    echo "正在设置 /private/var/db/eligibilityd/ 目录下文件的 immutable (uchg) 标记..."
    # 设置 uchg 标记
    sudo chflags uchg /private/var/db/eligibilityd/*
    echo "immutable (uchg) 标记设置完成。"
fi


# 7. 清理下载的脚本
echo "正在移除临时脚本 /usr/local/bin/zouxian..."
sudo rm -f /usr/local/bin/zouxian
echo "临时脚本移除完成。"

echo ""
echo "=============================================="
echo "操作已完成。"
echo "请立即重启你的电脑。"
echo "重启后，再次检查 '系统设置' -> '通用' -> 'Apple 智能' 是否仍为开启状态。"
echo "如果 Apple 智能仍为开启，并且你希望恢复系统的安全性，可以再次进入恢复模式，执行 'csrutil enable' 重新打开 SIP。"
echo ""
echo "免责声明：此脚本修改系统文件，可能导致不稳定或意外行为。请自行承担风险。"
echo "=============================================="

exit 0
