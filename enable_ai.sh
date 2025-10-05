#!/bin/bash

set -e

# --- Initial Welcome ---
echo "==================================================================="
echo " macOS Apple Intelligence Enablement Script 3.1 by KanShuRichard"
echo "       macOS Apple 智能启用辅助脚本 3.1 by KanShuRichard"
echo "==================================================================="

# --- Language Selection ---
echo "Please select your language:"
echo "请选择你的语言:"
echo ""
echo "1. 中文 (Chinese)"
echo "2. English"
echo ""

# Use < /dev/tty to ensure reading from the terminal even if script is piped
while true; do
    read -r -p "Enter choice/输入你的选择 (默认为中文): " lang_choice < /dev/tty
    case "$lang_choice" in
        2)
            LANG="en"
            break # Exit the loop
            ;;
        *)
            LANG="zh"
            break # Exit the loop
            ;;
    esac
done

# --- End Language Settings ---


# --- Language Settings ---
# Declare variables for messages
MSG_AGREEMENT_TITLE=""
MSG_AGREEMENT_LINE1=""
MSG_AGREEMENT_LINE2=""
MSG_AGREEMENT_LINE3=""
MSG_AGREEMENT_PROMPT=""
MSG_AGREEMENT_CANCEL=""
MSG_MODE_SELECT_TITLE=""
MSG_MODE_SELECT_1=""
MSG_MODE_SELECT_2=""
MSG_MODE_SELECT_3=""
MSG_MODE_PROMPT=""
MSG_INVALID_MODE=""
MSG_EXITING=""
MSG_PLISTBUDDY_WARN=""
MSG_PLISTBUDDY_ERROR=""
MSG_SIP_CHECK=""
MSG_SIP_ENABLED_1=""
MSG_SIP_ENABLED_2=""
MSG_SIP_ENABLED_3=""
MSG_SIP_ENABLED_4_1=""
MSG_SIP_ENABLED_4_2=""
MSG_SIP_ENABLED_4_3=""
MSG_SIP_ENABLED_4_4=""
MSG_SIP_ENABLED_5=""
MSG_SIP_DISABLED=""
MSG_START_STEPS=""
MSG_PREPARE_MODIFY=""
MSG_UNLOCK_PERMS=""
MSG_WRITE_PERMISSION_ERROR=""
MSG_BACKUP_START=""
MSG_BACKUP_ERROR=""
MSG_BACKUP_COMPLETE=""
MSG_MODIFY_PLISTS_START=""
MSG_MODIFY_PLISTS_COMPLETE=""
MSG_FINALIZE_START=""
MSG_SET_PERMS_444=""
MSG_SET_UCHG=""
MSG_FILE_LOCK_COMPLETE=""
MSG_CLEANUP_BACKUPS=""
MSG_OPERATION_COMPLETE=""
MSG_FORCE_US_PROMPT_TITLE=""
MSG_FORCE_US_PROMPT_BENEFITS=""
MSG_FORCE_US_PROMPT_WARNING=""
MSG_FORCE_US_PROMPT_CONFIRM=""
MSG_FORCE_US_START=""
MSG_FORCE_US_UNLOCKING=""
MSG_FORCE_US_BACKUP=""
MSG_FORCE_US_CONVERT_XML=""
MSG_FORCE_US_REPLACE=""
MSG_FORCE_US_CONVERT_BIN=""
MSG_FORCE_US_LOCKING=""
MSG_FORCE_US_LOCK_COMPLETE=""
MSG_FORCE_US_SUCCESS=""
MSG_FORCE_US_NOT_FOUND=""
MSG_RESTART_NOW=""
MSG_RECOMMEND_RE_ENABLE_SIP=""
MSG_UNLOCK_START=""
MSG_UNLOCK_NOUCHG=""
MSG_UNLOCK_CHMOD=""
MSG_UNLOCK_COMPLETE=""
MSG_SCRIPT_END=""
MSG_SUPPORT_URL=""

# Assign messages based on the selected language
case "$LANG" in
    en*)
        MSG_AGREEMENT_TITLE="--- IMPORTANT: PLEASE READ BEFORE PROCEEDING ---"
        MSG_AGREEMENT_LINE1="[RISK] This script modifies core system files. Incorrect use could potentially lead to system instability."
        MSG_AGREEMENT_LINE2="[REQUIREMENT] You MUST disable System Integrity Protection (SIP) from Recovery Mode before running the patch."
        MSG_AGREEMENT_LINE3="[DISCLAIMER] All operations are performed at your own risk."
        MSG_AGREEMENT_PROMPT="Do you understand the risks and wish to continue? (y/n): "
        MSG_AGREEMENT_CANCEL="Operation cancelled by user. Exiting."
        MSG_MODE_SELECT_TITLE="Please select an operation:"
        MSG_MODE_SELECT_1="1. Enable Apple Intelligence (Patch files)"
        MSG_MODE_SELECT_2="2. Unlock Files (Revert / Uninstall patch)"
        MSG_MODE_SELECT_3="3. Exit"
        MSG_MODE_PROMPT="Enter your choice [1-3]: "
        MSG_INVALID_MODE="Invalid choice. Exiting."
        MSG_EXITING="Exiting script."
        MSG_PLISTBUDDY_WARN="Warning: PlistBuddy tool not found. Attempting default path."
        MSG_PLISTBUDDY_ERROR="Error: PlistBuddy tool not found. Ensure Xcode Command Line Tools are installed."
        MSG_SIP_CHECK="Checking System Integrity Protection (SIP) status..."
        MSG_SIP_ENABLED_1="SIP (System Integrity Protection) is currently enabled."
        MSG_SIP_ENABLED_2="SIP must be disabled to continue."
        MSG_SIP_ENABLED_3="Please follow these steps:"
        MSG_SIP_ENABLED_4_1="1. Restart your Mac and hold the power button to enter Recovery Mode."
        MSG_SIP_ENABLED_4_2="2. In Recovery Mode, select 'Utilities' -> 'Terminal' from the menu bar."
        MSG_SIP_ENABLED_4_3="3. In the Terminal, type 'csrutil disable' and press Enter."
        MSG_SIP_ENABLED_4_4="4. Type 'reboot' and press Enter to restart your Mac."
        MSG_SIP_ENABLED_5="After disabling SIP, please run this script again."
        MSG_SIP_DISABLED="SIP (System Integrity Protection) is disabled, proceeding."
        MSG_START_STEPS="Starting Apple Intelligence enablement steps..."
        MSG_PREPARE_MODIFY="Preparing to modify system files..."
        MSG_UNLOCK_PERMS="Unlocking all related system directories for compatibility..."
        MSG_WRITE_PERMISSION_ERROR="Error: Failed to get write permission. Please ensure SIP is disabled and run the script with sudo."
        MSG_BACKUP_START="Backing up original file "
        MSG_BACKUP_ERROR="Error: Failed to back up "
        MSG_BACKUP_COMPLETE="Backup complete."
        MSG_MODIFY_PLISTS_START="Patching eligibility plists..."
        MSG_MODIFY_PLISTS_COMPLETE="Plist modifications complete."
        MSG_FINALIZE_START="Finalizing and locking files..."
        MSG_SET_PERMS_444="Setting permissions to read-only (444)..."
        MSG_SET_UCHG="Setting immutable (uchg) flag to prevent changes..."
        MSG_FILE_LOCK_COMPLETE="File locking complete."
        MSG_CLEANUP_BACKUPS="Cleaning up backup files..."
        MSG_OPERATION_COMPLETE="Apple Intelligence patch applied successfully."
        MSG_FORCE_US_PROMPT_TITLE="\n--- Optional Step: Force Location to US ---"
        MSG_FORCE_US_PROMPT_BENEFITS="[Benefits] For macOS 26, this can unlock features like ChatGPT, Apple News, and international Apple Maps (requires a suitable network IP)."
        MSG_FORCE_US_PROMPT_WARNING="[Warning] This will disable the Gaode version of Apple Maps used in mainland China."
        MSG_FORCE_US_PROMPT_CONFIRM="Would you like to force your system's country code to US? (y/n): "
        MSG_FORCE_US_START="-> Starting to modify countryd database..."
        MSG_FORCE_US_UNLOCKING="   - Unlocking countryd file for writing..."
        MSG_FORCE_US_BACKUP="   - Backed up original countryd plist."
        MSG_FORCE_US_CONVERT_XML="   - Converted plist to XML for editing."
        MSG_FORCE_US_REPLACE="   - Replaced country code with 'US'."
        MSG_FORCE_US_CONVERT_BIN="   - Converted plist back to binary format."
        MSG_FORCE_US_LOCKING="   - Locking countryd plist to prevent overwrites..."
        MSG_FORCE_US_LOCK_COMPLETE="   - Lock complete."
        MSG_FORCE_US_SUCCESS="✅ Location successfully forced to US and locked."
        MSG_FORCE_US_NOT_FOUND="⚠️ Warning: countryd plist not found. Skipping this step."
        MSG_RESTART_NOW="A REBOOT IS REQUIRED for all changes to take effect. Please restart your Mac now."
        MSG_RECOMMEND_RE_ENABLE_SIP="After restarting, it is strongly recommended to re-enable SIP for system security."
        MSG_UNLOCK_START="Starting file unlock process (revert/uninstall)..."
        MSG_UNLOCK_NOUCHG="Removing immutable (uchg) flag from all related directories..."
        MSG_UNLOCK_CHMOD="Setting file permissions to default (644)..."
        MSG_UNLOCK_COMPLETE="All related files (eligibility and countryd) have been unlocked."
        MSG_SCRIPT_END="Script execution finished."
        MSG_SUPPORT_URL="If you encounter any issues, please submit an Issue at https://github.com/kanshurichard/enableAppleAI"
        ;;
    *) # Default to Chinese
        MSG_AGREEMENT_TITLE="--- 重要：在继续前请仔细阅读 ---"
        MSG_AGREEMENT_LINE1="[风险] 本脚本会修改核心系统文件。不当使用可能导致系统不稳定。"
        MSG_AGREEMENT_LINE2="[要求] 在执行修补前，您必须先从恢复模式禁用系统完整性保护 (SIP)。"
        MSG_AGREEMENT_LINE3="[免责] 所有操作的风险由您自行承担。"
        MSG_AGREEMENT_PROMPT="您是否理解并愿意承担以上风险，继续执行？(y/n): "
        MSG_AGREEMENT_CANCEL="用户取消操作，脚本退出。"
        MSG_MODE_SELECT_TITLE="请选择要执行的操作："
        MSG_MODE_SELECT_1="1. 启用 Apple Intelligence (修补文件)"
        MSG_MODE_SELECT_2="2. 解锁文件 (用于卸载或恢复)"
        MSG_MODE_SELECT_3="3. 退出"
        MSG_MODE_PROMPT="请输入你的选择 [1-3]: "
        MSG_INVALID_MODE="无效选择，脚本退出。"
        MSG_EXITING="脚本退出。"
        MSG_PLISTBUDDY_WARN="警告：找不到 PlistBuddy 工具。将尝试使用系统默认路径。"
        MSG_PLISTBUDDY_ERROR="错误：找不到 PlistBuddy 工具。请确保已安装 Xcode 命令行工具。"
        MSG_SIP_CHECK="正在检测系统完整性保护 (SIP) 状态..."
        MSG_SIP_ENABLED_1="SIP (系统完整性保护) 当前已启用。"
        MSG_SIP_ENABLED_2="必须禁用 SIP 才能继续。"
        MSG_SIP_ENABLED_3="请按照以下步骤操作："
        MSG_SIP_ENABLED_4_1="1. 重启 Mac，并长按开机键进入恢复模式。"
        MSG_SIP_ENABLED_4_2="2. 在恢复模式菜单栏中选择“实用工具” -> “终端”。"
        MSG_SIP_ENABLED_4_3="3. 在终端中输入 'csrutil disable' 并按回车。"
        MSG_SIP_ENABLED_4_4="4. 输入 'reboot' 并按回车重启 Mac。"
        MSG_SIP_ENABLED_5="禁用 SIP 后，请再次运行此脚本。"
        MSG_SIP_DISABLED="SIP (系统完整性保护) 已禁用，可以继续。"
        MSG_START_STEPS="开始执行 Apple Intelligence 启用步骤..."
        MSG_PREPARE_MODIFY="正在准备修改系统文件..."
        MSG_UNLOCK_PERMS="为确保兼容性，正在解锁所有相关的系统目录..."
        MSG_WRITE_PERMISSION_ERROR="错误：未能获得写入权限。请确保 SIP 已禁用并使用 sudo 运行此脚本。"
        MSG_BACKUP_START="正在备份原始文件 "
        MSG_BACKUP_ERROR="错误：未能成功备份 "
        MSG_BACKUP_COMPLETE="备份完成。"
        MSG_MODIFY_PLISTS_START="正在修补资格属性列表文件..."
        MSG_MODIFY_PLISTS_COMPLETE="属性列表文件修改完成。"
        MSG_FINALIZE_START="正在完成收尾工作并锁定文件..."
        MSG_SET_PERMS_444="正在设置文件权限为只读 (444)..."
        MSG_SET_UCHG="正在设置文件的系统保护标记 (uchg)..."
        MSG_FILE_LOCK_COMPLETE="文件锁定完成。"
        MSG_CLEANUP_BACKUPS="正在清理备份文件..."
        MSG_OPERATION_COMPLETE="Apple Intelligence 修补程序已成功应用。"
        MSG_FORCE_US_PROMPT_TITLE="\n--- 可选步骤：强制修改地区为美国 ---"
        MSG_FORCE_US_PROMPT_BENEFITS="[好处] 在 macOS 26 系统中，此操作可解锁 ChatGPT、Apple News 及国际版苹果地图等功能（需配合相应的网络IP）。"
        MSG_FORCE_US_PROMPT_WARNING="[副作用] 此操作将导致无法在中国大陆境内使用高德版苹果地图。"
        MSG_FORCE_US_PROMPT_CONFIRM="您是否希望将系统的国家代码强制修改为美国 (US)？(y/n): "
        MSG_FORCE_US_START="-> 开始修改 countryd 数据库..."
        MSG_FORCE_US_UNLOCKING="   - 正在解锁 countryd 文件以便写入..."
        MSG_FORCE_US_BACKUP="   - 已备份原始 countryd 文件。"
        MSG_FORCE_US_CONVERT_XML="   - 已转换文件为 XML 格式以便编辑。"
        MSG_FORCE_US_REPLACE="   - 已替换国家代码为 'US'。"
        MSG_FORCE_US_CONVERT_BIN="   - 已转换文件回二进制格式。"
        MSG_FORCE_US_LOCKING="   - 正在锁定 countryd 文件以防覆盖..."
        MSG_FORCE_US_LOCK_COMPLETE="   - 锁定完成。"
        MSG_FORCE_US_SUCCESS="✅ 系统地区已成功强制修改为美国并已锁定。"
        MSG_FORCE_US_NOT_FOUND="⚠️ 警告：未找到 countryd 数据库文件，跳过此步骤。"
        MSG_RESTART_NOW="必须重启才能使所有更改生效。请立即重启您的 Mac。"
        MSG_RECOMMEND_RE_ENABLE_SIP="重启后，强烈建议您重新启用 SIP 以保障系统安全。"
        MSG_UNLOCK_START="开始文件解锁流程 (恢复/卸载)..."
        MSG_UNLOCK_NOUCHG="正在移除所有相关目录文件的系统保护标记 (uchg)..."
        MSG_UNLOCK_CHMOD="正在恢复文件权限为系统默认 (644)..."
        MSG_UNLOCK_COMPLETE="所有相关文件 (eligibility 和 countryd) 均已解锁。"
        MSG_SCRIPT_END="脚本执行结束。"
        MSG_SUPPORT_URL="如果遇到任何问题，请到 https://github.com/kanshurichard/enableAppleAI 提交Issue。"
        ;;
esac
# --- End Language Settings ---


# --- SCRIPT CONSTANTS AND FUNCTIONS ---

# ── Ensure we’re root
if (( EUID != 0 )); then
  echo "Please run this script with sudo, e.g., sudo $0"
  exit 1
fi

# ── File Paths & Dirs
ELIGIBILITY_DIR="/private/var/db/eligibilityd"
OS_ELIGIBILITY_DIR="/private/var/db/os_eligibility"
COUNTRYD_PLIST="/private/var/db/com.apple.countryd/countryCodeCache.plist"

PLISTBUDDY="/usr/libexec/PlistBuddy"

# --- Function to Force Location to US ---
force_us_location() {
    echo "$MSG_FORCE_US_START"
    
    if [ ! -f "$COUNTRYD_PLIST" ]; then
        echo "$MSG_FORCE_US_NOT_FOUND"
        return
    fi
    
    # Unlock the file before attempting to modify
    echo "$MSG_FORCE_US_UNLOCKING"
    sudo chflags nouchg "$COUNTRYD_PLIST" 2>/dev/null || true
    sudo chmod 777 "$COUNTRYD_PLIST" 2>/dev/null || true

    local BACKUP_FILE="${COUNTRYD_PLIST}.bak"
    sudo cp "$COUNTRYD_PLIST" "$BACKUP_FILE"
    echo "$MSG_FORCE_US_BACKUP"

    sudo plutil -convert xml1 "$COUNTRYD_PLIST"
    echo "$MSG_FORCE_US_CONVERT_XML"

    local NEW_COUNTRY_CODE="US"
    local AWK_SCRIPT='
    /^[[:space:]]*<string>[A-Z][A-Z]<\/string>[[:space:]]*$/ {
        indent = ""
        if (match($0, /^[[:space:]]*/)) {
            indent = substr($0, RSTART, RLENGTH)
        }
        printf "%s<string>%s</string>\n", indent, "'"$NEW_COUNTRY_CODE"'"
        next
    }
    { print $0 }
    '
    # Use a temporary file in a writable location like /tmp
    local TEMP_PLIST="/tmp/temp_countryd.plist"
    sudo awk "$AWK_SCRIPT" "$COUNTRYD_PLIST" > "$TEMP_PLIST"
    sudo mv "$TEMP_PLIST" "$COUNTRYD_PLIST"
    echo "$MSG_FORCE_US_REPLACE"
    
    sudo plutil -convert binary1 "$COUNTRYD_PLIST"
    echo "$MSG_FORCE_US_CONVERT_BIN"

    echo "$MSG_FORCE_US_LOCKING"
    sudo chmod 444 "$COUNTRYD_PLIST"
    sudo chflags uchg "$COUNTRYD_PLIST"
    echo "$MSG_FORCE_US_LOCK_COMPLETE"

    echo "$MSG_FORCE_US_SUCCESS"
}


# --- Function to Enable Apple Intelligence ---
enable_ai() {
    local ELIGIBILITY_PLIST="${ELIGIBILITY_DIR}/eligibility.plist"
    local OS_ELIGIBILITY_PLIST="${OS_ELIGIBILITY_DIR}/eligibility.plist"

    # ── Verify PlistBuddy is available
    if [[ ! -x $PLISTBUDDY ]]; then
      echo "$MSG_PLISTBUDDY_WARN"
      if command -v PlistBuddy >/dev/null 2>&1; then
        PLISTBUDDY="PlistBuddy"
      else
        echo "$MSG_PLISTBUDDY_ERROR" >&2
        exit 1
      fi
    fi

    # 1. Check SIP status
    echo ""
    echo "=============================================="
    echo "$MSG_SIP_CHECK"
    if [[ $(csrutil status) != *"System Integrity Protection status: disabled."* ]]; then
        echo "$MSG_SIP_ENABLED_1"; echo "$MSG_SIP_ENABLED_2"; echo "$MSG_SIP_ENABLED_3"
        echo "$MSG_SIP_ENABLED_4_1"; echo "$MSG_SIP_ENABLED_4_2"; echo "$MSG_SIP_ENABLED_4_3"
        echo "$MSG_SIP_ENABLED_4_4"; echo "$MSG_SIP_ENABLED_5"
        echo "=============================================="
        exit 1
    else
        echo "$MSG_SIP_DISABLED"
    fi

    echo ""
    echo "=============================================="
    echo "$MSG_START_STEPS"

    # 2. Unlock ALL related directories for compatibility
    echo "$MSG_UNLOCK_PERMS"
    sudo chflags nouchg "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/* 2>/dev/null || true
    sudo chmod 777 "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/* 2>/dev/null || true

    if [ ! -w "$ELIGIBILITY_PLIST" ] || [ ! -w "$OS_ELIGIBILITY_PLIST" ]; then
        echo "$MSG_WRITE_PERMISSION_ERROR" >&2; exit 1
    fi

    # 3. Backup original plist files
    local PLIST_BACKUP="/tmp/eligibility.plist.bak"
    local OS_PLIST_BACKUP="/tmp/os_eligibility.plist.bak"
    echo "$MSG_BACKUP_START$ELIGIBILITY_PLIST..."
    sudo cp "$ELIGIBILITY_PLIST" "$PLIST_BACKUP"
    echo "$MSG_BACKUP_START$OS_ELIGIBILITY_PLIST..."
    sudo cp "$OS_ELIGIBILITY_PLIST" "$OS_PLIST_BACKUP"
    echo "$MSG_BACKUP_COMPLETE"

    # 4. Apply new, simplified plist edits
    echo "$MSG_MODIFY_PLISTS_START"
    # --- Modifications for os_eligibility.plist ---
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_STRONTIUM:os_eligibility_answer_t 4" "$OS_ELIGIBILITY_PLIST" || true
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_XCODE_LLM:os_eligibility_answer_t 4" "$OS_ELIGIBILITY_PLIST" || true
    
    # --- Modifications for eligibility.plist ---
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:os_eligibility_answer_t 4" "$ELIGIBILITY_PLIST" || true
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_CALCIUM:os_eligibility_answer_t 4" "$ELIGIBILITY_PLIST" || true
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_FOUNDATION_MODELS:os_eligibility_answer_t 4" "$ELIGIBILITY_PLIST" || true
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_PERSONAL_QA:os_eligibility_answer_t 4" "$ELIGIBILITY_PLIST" || true
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_SIRI_WITH_APP_INTENTS:os_eligibility_answer_t 4" "$ELIGIBILITY_PLIST" || true
    echo "$MSG_MODIFY_PLISTS_COMPLETE"

    # 5. Finalize and lock target plist files
    echo "$MSG_FINALIZE_START"
    echo "$MSG_SET_PERMS_444"
    sudo chmod 444 "$ELIGIBILITY_PLIST" "$OS_ELIGIBILITY_PLIST"
    echo "$MSG_SET_UCHG"
    sudo chflags uchg "$ELIGIBILITY_PLIST" "$OS_ELIGIBILITY_PLIST"
    echo "$MSG_FILE_LOCK_COMPLETE"

    # 6. Clean up backups
    echo "$MSG_CLEANUP_BACKUPS"
    sudo rm -f "$PLIST_BACKUP" "$OS_PLIST_BACKUP"

    echo ""
    echo "=============================================="
    echo "$MSG_OPERATION_COMPLETE"
    
    # 7. Optional: Force location to US
    echo "$MSG_FORCE_US_PROMPT_TITLE"
    echo "$MSG_FORCE_US_PROMPT_BENEFITS"
    echo "$MSG_FORCE_US_PROMPT_WARNING"
    read -r -p "$MSG_FORCE_US_PROMPT_CONFIRM" force_us < /dev/tty
    if [[ "$force_us" =~ ^[Yy]$ ]]; then
        force_us_location
    fi

    echo ""
    echo "=============================================="
    echo "$MSG_RESTART_NOW"
    echo "$MSG_RECOMMEND_RE_ENABLE_SIP"
    echo "=============================================="
}

# --- Function to Unlock Files (Revert/Uninstall) ---
unlock_files() {
    echo ""
    echo "=============================================="
    echo "$MSG_UNLOCK_START"
    
    echo "$MSG_UNLOCK_NOUCHG"
    sudo chflags nouchg "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/* "$COUNTRYD_PLIST" 2>/dev/null || true

    echo "$MSG_UNLOCK_CHMOD"
    sudo chmod 644 "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/* "$COUNTRYD_PLIST" 2>/dev/null || true

    echo ""
    echo "$MSG_UNLOCK_COMPLETE"
    echo "=============================================="
}


# --- MAIN SCRIPT EXECUTION ---

# 1. Show disclaimer and require agreement
echo ""
echo "$MSG_AGREEMENT_TITLE"
echo "$MSG_AGREEMENT_LINE1"
echo "$MSG_AGREEMENT_LINE2"
echo "$MSG_AGREEMENT_LINE3"
echo "----------------------------------------------------"
read -r -p "$MSG_AGREEMENT_PROMPT" agreement < /dev/tty
if [[ ! "$agreement" =~ ^[Yy]$ ]]; then
    echo "$MSG_AGREEMENT_CANCEL"
    exit 1
fi

# 2. Show mode selection menu
echo ""
echo "=============================================="
echo "$MSG_MODE_SELECT_TITLE"
echo "$MSG_MODE_SELECT_1"
echo "$MSG_MODE_SELECT_2"
echo "$MSG_MODE_SELECT_3"
echo "=============================================="
read -r -p "$MSG_MODE_PROMPT" mode_choice < /dev/tty

# 3. Process user's choice
case "$mode_choice" in
    1)
        enable_ai
        ;;
    2)
        unlock_files
        ;;
    3)
        echo "$MSG_EXITING"
        exit 0
        ;;
    *)
        echo "$MSG_INVALID_MODE" >&2
        exit 1
        ;;
esac

echo ""
echo "$MSG_SCRIPT_END"
echo "$MSG_SUPPORT_URL"
echo "=============================================="

exit 0