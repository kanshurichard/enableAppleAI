#!/bin/bash

set -e

echo "============================================================="
echo "  macOS Apple Intelligence 启用辅助脚本 2.0 by KanShuRichard"
echo "============================================================="

# 定义关键文件和目录路径
ELIGIBILITY_PLIST="/private/var/db/eligibilityd/eligibility.plist"
ELIGIBILITY_DIR="/private/var/db/eligibilityd"
PLIST_BACKUP="/tmp/eligibility.plist.bak" # 备份文件路径
PLISTBUDDY="/usr/libexec/PlistBuddy" # PlistBuddy 工具路径

# 检查 PlistBuddy 是否存在
if [ ! -f "$PLISTBUDDY" ]; then
    echo "警告：找不到 PlistBuddy 工具 ($PLISTBUDDY)。尝试使用默认路径。"
    PLISTBUDDY="PlistBuddy"
    # 再次检查默认路径是否可用
    if ! command -v "$PLISTBUDDY" &> /dev/null; then
        echo "错误：找不到 PlistBuddy 工具。请确保已安装 macOS 开发者工具或 Xcode。"
        exit 1
    fi
fi


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
echo "开始执行 Apple Intelligence 启用尝试步骤..."

# --- 准备修改文件 ---
echo "正在准备修改系统文件 $ELIGIBILITY_PLIST ..."

# 2. 解锁并修改文件权限为 777
echo "正在删除 /private/var/db/eligibilityd/ 目录下文件的 immutable (uchg) 标记并设置权限为 777..."
# 删除 uchg 标记 (忽略错误，因为文件可能本来就没有这个标记)
sudo chflags nouchg "$ELIGIBILITY_DIR"/* || true
# 设置权限为 777
sudo chmod 777 "$ELIGIBILITY_DIR"/*

# 确保 plist 文件可写
if [ ! -w "$ELIGIBILITY_PLIST" ]; then
    echo "错误：未能获得 $ELIGIBILITY_PLIST 文件的写入权限。请再次确认已禁用 SIP。"
    exit 1
fi

# 3. 备份原始 plist 文件
echo "正在备份原始文件 $ELIGIBILITY_PLIST 到 $PLIST_BACKUP ..."
sudo cp "$ELIGIBILITY_PLIST" "$PLIST_BACKUP"
if [ $? -ne 0 ]; then
    echo "错误：未能成功备份 $ELIGIBILITY_PLIST 文件。请检查权限或磁盘空间。"
    exit 1 # 备份失败是严重错误，必须退出
fi
echo "备份完成。"

# 4. 修改 plist 文件内容
echo "正在修改 $ELIGIBILITY_PLIST 中的特定键值..."
# 使用 PlistBuddy 修改值，将 3 改为 2
# 注意：PlistBuddy 的路径在脚本开头已检查/设置

# 修改 OS_ELIGIBILITY_DOMAIN_GREYMATTER 下的值

$PLISTBUDDY -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_COUNTRY_BILLING 2" "$ELIGIBILITY_PLIST"
$PLISTBUDDY -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_DEVICE_AND_SIRI_LANGUAGE_MATCH 2" "$ELIGIBILITY_PLIST"
$PLISTBUDDY -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE 2" "$ELIGIBILITY_PLIST"
$PLISTBUDDY -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_EXTERNAL_BOOT_DRIVE 2" "$ELIGIBILITY_PLIST"

# 修改 OS_ELIGIBILITY_DOMAIN_CALCIUM 下的值
$PLISTBUDDY -c "Set :OS_ELIGIBILITY_DOMAIN_CALCIUM:status:OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE 2" "$ELIGIBILITY_PLIST"


sudo chflags uchg "$ELIGIBILITY_PLIST"

echo "$ELIGIBILITY_PLIST 修改及锁定完成。"

# 5. 下载并执行第三方脚本 zouxian (顺序后移)
echo "正在下载并安装第三方脚本 zouxian.sh..."
# 使用 sudo 下载文件到系统目录
sudo curl https://raw.githubusercontent.com/CatMe0w/zouxian/master/zouxian.sh -o /usr/local/bin/zouxian

# 确保下载成功
if [ ! -f "/usr/local/bin/zouxian" ]; then
    echo "错误：第三方脚本下载失败。请检查网络连接或 GitHub 仓库是否可用。"
    # 下载失败也算操作失败，进入失败处理流程前的清理
    sudo rm -f "$PLIST_BACKUP" # 清理备份文件
    exit 1 # 退出脚本
fi

echo "赋予脚本执行权限..."
sudo chmod +x /usr/local/bin/zouxian

echo "执行第三方脚本 zouxian..."
# 执行下载的脚本
sudo /usr/local/bin/zouxian

echo ""
echo "=============================================="
echo "6. 请检查 Apple 智能状态"
echo "重要：现在请去 '系统设置' -> 'Apple 智能' 或 'Siri' 检查'Apple智能'选项是否已经出现。"
echo "如果 'Apple 智能' **已经出现**，请在下面输入 Y。"
echo "如果 'Apple 智能' **没有出现**，请在下面输入 N。"
echo "=============================================="

# 使用 < /dev/tty 强制从终端读取输入，解决管道执行时 read 不暂停的问题
read -r -p "请确认 Apple 智能是否已出现或部分功能已启用 (Y/N): " user_confirmation < /dev/tty

# 暂时解锁plist
sudo chflags nouchg "$ELIGIBILITY_PLIST"

# 7. 根据用户反馈进行后续处理
if [[ "$user_confirmation" =~ ^[Yy]$ ]]; then
    # --- 用户确认成功路径 ---
    echo ""
    echo "=============================================="
    echo "用户确认成功，正在完成设置并锁定文件..."

    # 设置文件权限为 444 (只读)
    echo "设置 $ELIGIBILITY_DIR/* 的权限为 444 (只读)..."
    sudo chmod 444 "$ELIGIBILITY_DIR"/*

    # 设置 immutable (uchg) 标记
    echo "设置 $ELIGIBILITY_DIR/* 的 immutable (uchg) 标记..."
    sudo chflags uchg "$ELIGIBILITY_DIR"/*
    echo "文件锁定完成。"

    # 清理备份文件
    echo "清理备份文件 $PLIST_BACKUP..."
    sudo rm -f "$PLIST_BACKUP" # 使用 -f 忽略文件不存在的错误

    echo ""
    echo "操作已完成。"
    echo "请立即重启你的电脑。"
    echo "重启后，再次检查 Apple 智能状态。"
    echo "如果 Apple 智能仍为开启，并且你希望恢复系统的安全性，强烈建议你再次进入恢复模式，执行 'csrutil enable' 重新打开 SIP。"
    echo "=============================================="

else
    # --- 用户确认失败路径 ---
    echo ""
    echo "=============================================="
    echo "用户确认失败，正在恢复文件到修改前状态..."

    # 恢复原始 plist 文件
    if [ -f "$PLIST_BACKUP" ]; then
        echo "正在从备份文件 $PLIST_BACKUP 恢复原始文件 $ELIGIBILITY_PLIST ..."
        # 先尝试删除可能被修改的文件
        sudo rm -f "$ELIGIBILITY_PLIST"
        # 恢复备份文件
        sudo cp "$PLIST_BACKUP" "$ELIGIBILITY_PLIST"
        if [ $? -ne 0 ]; then
            echo "警告：未能从备份文件恢复 $ELIGIBILITY_PLIST。可能需要手动恢复！"
        else
             echo "$ELIGIBILITY_PLIST 恢复完成。"
        fi
    else
        echo "警告：备份文件 $PLIST_BACKUP 未找到。无法恢复 $ELIGIBILITY_PLIST 文件内容。"
    fi

    # 恢复文件权限为 444 (只读，一个安全的默认状态)
    echo "设置 $ELIGIBILITY_DIR/* 的权限为 444 (只读)..."
    sudo chmod 444 "$ELIGIBILITY_DIR"/*

    # 确保没有uchg标记 (可能在前一次尝试失败时设置了uchg)
    sudo chflags nouchg "$ELIGIBILITY_DIR"/* || true

    # 清理备份文件
    echo "清理备份文件 $PLIST_BACKUP..."
    sudo rm -f "$PLIST_BACKUP" # 使用 -f 忽略文件不存在的错误

    echo ""
    echo "Apple 智能启用尝试失败。请考虑以下步骤："
    echo "1. 检查你的 macOS 版本是否兼容 (目前已测试15.4.1和15.5 beta)。"
    echo "2. 向第三方脚本作者反馈问题: https://github.com/CatMe0w/zouxian/issues"
    echo "3. 为了系统安全，强烈建议你重启后进入恢复模式，执行 'csrutil enable' 重新打开 SIP。"
    echo "=============================================="

fi

# 8. 清理下载的 zouxian 脚本 (在成功或失败后都会执行)
echo "清理临时脚本 /usr/local/bin/zouxian..."
sudo rm -f /usr/local/bin/zouxian
echo "清理完成。"

echo ""
echo "=============================================="
echo "脚本执行结束。"
echo "=============================================="

exit 0 
