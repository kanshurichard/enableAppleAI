#!/bin/bash

set -e

# --- Colors ---
BOLD="\033[1m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

# --- Initial Welcome ---
echo -e "${BLUE}===================================================================${RESET}"
echo -e "${BOLD}${CYAN} macOS Apple Intelligence Enablement Script 3.21 by KanShuRichard${RESET}"
echo -e "${BOLD}${CYAN}       macOS Apple 智能启用辅助脚本 3.21 by KanShuRichard${RESET}"
echo -e "${BLUE}===================================================================${RESET}"
#!/bin/bash

# --- Language Selection ---
echo -e "${BOLD}Please select your language:${RESET}"
echo -e "${BOLD}请选择你的语言:${RESET}"
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
# (Message variables remain the same as v4.1, only code logic is changed)
# ... (Message definitions are omitted for brevity but are identical to the previous version)
# Declare variables for messages
# (Shared messages)
MSG_SUDO_REQUIRED=""
MSG_SUDO_PROMPT=""
MSG_SUDO_SUCCESS=""
MSG_SUDO_FAILED=""
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
MSG_SUB_MENU_TITLE=""
MSG_SUB_MENU_M1=""
MSG_SUB_MENU_M1_DESC=""
MSG_SUB_MENU_M2=""
MSG_SUB_MENU_M2_DESC=""
MSG_SUB_MENU_M3=""
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
MSG_WRITE_PERMISSION_ERROR=""
MSG_BACKUP_START=""
MSG_BACKUP_ERROR=""
MSG_BACKUP_COMPLETE=""
MSG_FINALIZE_START=""
MSG_SET_PERMS_444=""
MSG_SET_UCHG=""
MSG_FILE_LOCK_COMPLETE=""
MSG_CLEANUP_BACKUPS=""
MSG_RESTART_NOW=""
MSG_RECOMMEND_RE_ENABLE_SIP=""
MSG_UNLOCK_START=""
MSG_UNLOCK_NOUCHG=""
MSG_UNLOCK_CHMOD=""
MSG_UNLOCK_COMPLETE=""
MSG_SCRIPT_END=""
MSG_SUPPORT_URL=""
MSG_M1_FAIL_TRY_M2_PROMPT=""

# (Method 2 specific messages)
MSG2_START_STEPS=""
MSG2_MODIFY_PLISTS_START=""
MSG2_MODIFY_PLISTS_COMPLETE=""
MSG2_OPERATION_COMPLETE=""
MSG2_FORCE_US_PROMPT_TITLE=""
MSG2_FORCE_US_PROMPT_BENEFITS=""
MSG2_FORCE_US_PROMPT_WARNING=""
MSG2_FORCE_US_PROMPT_CONFIRM=""
MSG2_FORCE_US_START=""
MSG2_FORCE_US_UNLOCKING=""
MSG2_FORCE_US_BACKUP=""
MSG2_FORCE_US_CONVERT_XML=""
MSG2_FORCE_US_REPLACE=""
MSG2_FORCE_US_CONVERT_BIN=""
MSG2_FORCE_US_LOCKING=""
MSG2_FORCE_US_LOCK_COMPLETE=""
MSG2_FORCE_US_SUCCESS=""
MSG2_FORCE_US_NOT_FOUND=""
MSG2_UNLOCK_IPHONE_WARNING_TITLE=""
MSG2_UNLOCK_IPHONE_WARNING_1=""
MSG2_UNLOCK_IPHONE_WARNING_2=""

# (Method 1 specific messages, prefixed with M1_)
M1_START_STEPS=""
M1_PREPARE_MODIFY=""
M1_UNLOCK_PERMS=""
M1_MODIFY_PLIST_START_1=""
M1_MODIFY_PLIST_START_2=""
M1_MODIFY_PLISTS_COMPLETE=""
M1_EXECUTE_ZOUXIAN=""
M1_RESTART_ELIGIBILITY=""
M1_CHECK_AI_TITLE=""
M1_CHECK_AI_INSTR_1=""
M1_CHECK_AI_INSTR_2=""
M1_CHECK_AI_INSTR_3=""
M1_CHECK_AI_PROMPT=""
M1_SUCCESS_CONFIRMED_START=""
M1_OPERATION_COMPLETE=""
M1_CHECK_AI_AGAIN=""
M1_FAILURE_CONFIRMED_START=""
M1_RESTORE_START_1=""
M1_RESTORE_START_2=""
M1_RESTORE_WARNING_FAILED=""
M1_RESTORE_WARNING_MANUAL=""
M1_RESTORE_COMPLETE=""
M1_RESTORE_WARNING_NOT_FOUND=""
M1_ENSURE_NO_UCHG=""
M1_DISCLAIMER=""

# Assign messages based on the selected language
case "$LANG" in
    en*)
        # Shared
        MSG_SUDO_REQUIRED="${YELLOW}Administrator privileges are required for this operation.${RESET}"
        MSG_SUDO_PROMPT="Please enter your password to grant permissions: "
        MSG_SUDO_SUCCESS="${GREEN}Privileges granted. Continuing...${RESET}"
        MSG_SUDO_FAILED="${BOLD}${RED}Failed to obtain administrator privileges. Exiting.${RESET}"
        MSG_AGREEMENT_TITLE="${BOLD}${YELLOW}--- IMPORTANT: PLEASE READ BEFORE PROCEEDING ---${RESET}"
        MSG_AGREEMENT_LINE1="${BOLD}${YELLOW}[RISK]${RESET} This script modifies core system files. Incorrect use could potentially lead to system instability."
        MSG_AGREEMENT_LINE2="${BOLD}${YELLOW}[REQUIREMENT]${RESET} You MUST disable System Integrity Protection (SIP) from Recovery Mode before running the patch."
        MSG_AGREEMENT_LINE3="${BOLD}${YELLOW}[DISCLAIMER]${RESET} All operations are performed at your own risk."
        MSG_AGREEMENT_PROMPT="${BOLD}Do you understand the risks and wish to continue? (y/n): ${RESET}"
        MSG_AGREEMENT_CANCEL="Operation cancelled by user. Exiting."
        MSG_MODE_SELECT_TITLE="${BOLD}Please select an operation:${RESET}"
        MSG_MODE_SELECT_1="1. Enable Apple Intelligence"
        MSG_MODE_SELECT_2="2. Unlock Files (Uninstall)"
        MSG_MODE_SELECT_3="3. Exit"
        MSG_MODE_PROMPT="${BOLD}Enter your choice [1-3]: ${RESET}"
        MSG_SUB_MENU_TITLE="${BOLD}Please choose an enablement method:${RESET}"
        MSG_SUB_MENU_M1="1. Method 1 (Simulate US Model Code)"
        MSG_SUB_MENU_M1_DESC="   ${CYAN}More comprehensive. Recommended to try first.${RESET}"
        MSG_SUB_MENU_M2="2. Method 2 (Directly Force-Enable Features)"
        MSG_SUB_MENU_M2_DESC="   ${CYAN}If Method 1 fails, it is recommended to try Method 2.${RESET}"
        MSG_SUB_MENU_M3="3. Back to Main Menu"
        MSG_INVALID_MODE="${BOLD}${RED}Invalid choice. Exiting.${RESET}"
        MSG_EXITING="Exiting script."
        MSG_PLISTBUDDY_WARN="${YELLOW}Warning: PlistBuddy tool not found. Attempting default path.${RESET}"
        MSG_PLISTBUDDY_ERROR="${BOLD}${RED}Error: PlistBuddy tool not found. Ensure Xcode Command Line Tools are installed.${RESET}"
        MSG_SIP_CHECK="Checking System Integrity Protection (SIP) status..."
        MSG_SIP_ENABLED_1="${BOLD}${RED}SIP (System Integrity Protection) is currently enabled.${RESET}"
        MSG_SIP_ENABLED_2="${BOLD}${RED}SIP must be disabled for this operation to continue.${RESET}"
        MSG_SIP_ENABLED_3="Please follow these steps:"
        MSG_SIP_ENABLED_4_3="3. In the Terminal, type '${BOLD}${CYAN}csrutil disable${RESET}' and press Enter."
        MSG_SIP_ENABLED_4_4="4. Type '${BOLD}${CYAN}reboot${RESET}' and press Enter to restart your Mac."
        MSG_SIP_ENABLED_5="After disabling SIP, please run this script again."
        MSG_SIP_DISABLED="${GREEN}SIP (System Integrity Protection) is disabled, proceeding.${RESET}"
        MSG_WRITE_PERMISSION_ERROR="${BOLD}${RED}Error: Failed to get write permission. Please ensure SIP is disabled.${RESET}"
        MSG_BACKUP_START="Backing up original file "
        MSG_BACKUP_ERROR="${BOLD}${RED}Error: Failed to back up ${RESET}"
        MSG_BACKUP_COMPLETE="${GREEN}Backup complete.${RESET}"
        MSG_FINALIZE_START="Finalizing and locking files..."
        MSG_SET_PERMS_444="Setting permissions to read-only (444)..."
        MSG_SET_UCHG="Setting immutable (uchg) flag to prevent changes..."
        MSG_FILE_LOCK_COMPLETE="File locking complete."
        MSG_CLEANUP_BACKUPS="Cleaning up backup files..."
        MSG_RESTART_NOW="${BOLD}${YELLOW}A REBOOT IS REQUIRED for all changes to take effect. Please restart your Mac now.${RESET}"
        MSG_RECOMMEND_RE_ENABLE_SIP="After restarting, it is strongly recommended to re-enable SIP for system security."
        MSG_UNLOCK_START="Starting file unlock process (revert/uninstall)..."
        MSG_UNLOCK_NOUCHG="Removing immutable (uchg) flag from all related directories..."
        MSG_UNLOCK_CHMOD="Setting file permissions to default (644)..."
        MSG_UNLOCK_COMPLETE="${GREEN}All related files (eligibility and countryd) have been unlocked.${RESET}"
        MSG_SCRIPT_END="Script execution finished."
        MSG_SUPPORT_URL="If you encounter any issues, please submit an Issue at ${BOLD}https://github.com/kanshurichard/enableAppleAI${RESET}"
        MSG_M1_FAIL_TRY_M2_PROMPT="${BOLD}Method 1 failed. Would you like to try Method 2 now? (y/n): ${RESET}"
        
        # Method 2 specific
        MSG2_START_STEPS="Starting Apple Intelligence enablement steps..."
        MSG2_MODIFY_PLISTS_START="Patching eligibility plists (this may take a moment)..."
        MSG2_MODIFY_PLISTS_COMPLETE="${GREEN}Plist modifications complete.${RESET}"
        MSG2_OPERATION_COMPLETE="${GREEN}Apple Intelligence patch applied successfully.${RESET}"
        MSG2_FORCE_US_PROMPT_TITLE="${CYAN}--- Optional Step: Force Location to US ---${RESET}"
        MSG2_FORCE_US_PROMPT_BENEFITS="${BOLD}${YELLOW}[Benefits]${RESET} For macOS 26, this can unlock features like ChatGPT, Apple News, and international Apple Maps (requires a suitable network IP)."
        MSG2_FORCE_US_PROMPT_WARNING="${BOLD}${YELLOW}[Side Effect]${RESET} This will disable the Gaode version of Apple Maps used in mainland China."
        MSG2_FORCE_US_PROMPT_CONFIRM="${BOLD}Would you like to force your system's country code to US? (y/n): ${RESET}"
        MSG2_FORCE_US_START="-> Starting to modify countryd database..."
        MSG2_FORCE_US_UNLOCKING="   - Unlocking countryd file for writing..."
        MSG2_FORCE_US_BACKUP="   - Backed up original countryd plist."
        MSG2_FORCE_US_CONVERT_XML="   - Converted plist to XML for editing."
        MSG2_FORCE_US_REPLACE="   - Replaced country code with 'US'."
        MSG2_FORCE_US_CONVERT_BIN="   - Converted plist back to binary format."
        MSG2_FORCE_US_LOCKING="   - Locking countryd plist to prevent overwrites..."
        MSG2_FORCE_US_LOCK_COMPLETE="   - Lock complete."
        MSG2_FORCE_US_SUCCESS="${GREEN}✅ Location successfully forced to US and locked.${RESET}"
        MSG2_FORCE_US_NOT_FOUND="${YELLOW}⚠️ Warning: countryd plist not found. Skipping this step.${RESET}"
        MSG2_UNLOCK_IPHONE_WARNING_TITLE="${BOLD}${YELLOW}--- IMPORTANT: iPhone Mirroring Notice ---${RESET}"
        MSG2_UNLOCK_IPHONE_WARNING_1="${BOLD}${YELLOW}[Requirement]${RESET} If you use the iPhone Mirroring feature, you must pair your iPhone with this Mac ${BOLD}before${RESET} you change the country code."
        MSG2_UNLOCK_IPHONE_WARNING_2="${BOLD}${YELLOW}[Reason]${RESET} Changing the country code may cause a mismatch that can prevent pairing. Pair first, then proceed."

        # Method 1 specific
        M1_START_STEPS="Starting Apple Intelligence enablement (Method 1)..."
        M1_PREPARE_MODIFY="Preparing to modify system files..."
        M1_UNLOCK_PERMS="Unlocking system eligibility directories..."
        M1_MODIFY_PLIST_START_1="Modifying keys in eligibility.plist ..."
        M1_MODIFY_PLIST_START_2="Modifying key in os_eligibility.plist ..."
        M1_MODIFY_PLISTS_COMPLETE="${GREEN}All necessary plist modifications complete.${RESET}"
        M1_EXECUTE_ZOUXIAN="Executing eligibility patch logic with lldb..."
        M1_RESTART_ELIGIBILITY="Restarting eligibility daemon..."
        M1_CHECK_AI_TITLE="${BOLD}${CYAN}--- Please Check Apple Intelligence Status ---${RESET}"
        M1_CHECK_AI_INSTR_1="Go to 'System Settings' -> 'Apple Intelligence' or 'Siri' and check if the 'Apple Intelligence' option appears."
        M1_CHECK_AI_INSTR_2="If it ${BOLD}appears${RESET}, or you see new AI features, please enter Y."
        M1_CHECK_AI_INSTR_3="If it ${BOLD}does not appear${RESET}, please enter N."
        M1_CHECK_AI_PROMPT="${BOLD}Confirm if Apple Intelligence appeared (Y/N): ${RESET}"
        M1_SUCCESS_CONFIRMED_START="User confirmed success, completing setup..."
        M1_OPERATION_COMPLETE="${GREEN}Operation completed.${RESET}"
        M1_CHECK_AI_AGAIN="After restarting, check Apple Intelligence status again."
        M1_FAILURE_CONFIRMED_START="${YELLOW}User confirmed failure, restoring files...${RESET}"
        M1_RESTORE_START_1="Restoring original eligibility.plist from backup..."
        M1_RESTORE_START_2="Restoring original os_eligibility.plist from backup..."
        M1_RESTORE_WARNING_FAILED="${BOLD}${RED}Warning: Failed to restore ${RESET}"
        M1_RESTORE_WARNING_MANUAL="${BOLD}${RED}Manual intervention may be required!${RESET}"
        M1_RESTORE_COMPLETE=" restore complete."
        M1_RESTORE_WARNING_NOT_FOUND="${YELLOW}Warning: Backup file not found. Cannot restore.${RESET}"
        M1_ENSURE_NO_UCHG="Ensuring uchg flag is removed..."
        M1_DISCLAIMER="Disclaimer: This script modifies system files. Use at your own risk."
        ;;
    *) # Default to Chinese
        # Shared
        MSG_SUDO_REQUIRED="${YELLOW}此操作需要管理员权限。${RESET}"
        MSG_SUDO_PROMPT="请输入你的密码以授予权限: "
        MSG_SUDO_SUCCESS="${GREEN}权限已授予，继续执行...${RESET}"
        MSG_SUDO_FAILED="${BOLD}${RED}未能获取管理员权限，脚本退出。${RESET}"
        MSG_AGREEMENT_TITLE="${BOLD}${YELLOW}--- 重要：在继续前请仔细阅读 ---${RESET}"
        MSG_AGREEMENT_LINE1="${BOLD}${YELLOW}[风险]${RESET} 本脚本会修改核心系统文件。不当使用可能导致系统不稳定。"
        MSG_AGREEMENT_LINE2="${BOLD}${YELLOW}[要求]${RESET} 在执行修补前，您必须先从恢复模式禁用系统完整性保护 (SIP)。"
        MSG_AGREEMENT_LINE3="${BOLD}${YELLOW}[免责]${RESET} 所有操作的风险由您自行承担。"
        MSG_AGREEMENT_PROMPT="${BOLD}您是否理解并愿意承担以上风险，继续执行？(y/n): ${RESET}"
        MSG_AGREEMENT_CANCEL="用户取消操作，脚本退出。"
        MSG_MODE_SELECT_TITLE="${BOLD}请选择要执行的操作：${RESET}"
        MSG_MODE_SELECT_1="1. 启用 Apple Intelligence"
        MSG_MODE_SELECT_2="2. 解锁文件 (卸载)"
        MSG_MODE_SELECT_3="3. 退出"
        MSG_MODE_PROMPT="${BOLD}请输入你的选择 [1-3]: ${RESET}"
        MSG_SUB_MENU_TITLE="${BOLD}请选择启用方法：${RESET}"
        MSG_SUB_MENU_M1="1. 方法1 (模拟美国版机型代码)"
        MSG_SUB_MENU_M1_DESC="   ${CYAN}解锁更全面，建议用户优先尝试。15.7和26.2以上版本系统请【不要】选择方法1${RESET}"
        MSG_SUB_MENU_M2="2. 方法2 (直接强制开启相关功能)"
        MSG_SUB_MENU_M2_DESC="   ${CYAN}如果方法1失败，建议您尝试方法2。15.7和26.2以上版本系统直接选择方法2${RESET}"
        MSG_SUB_MENU_M3="3. 返回主菜单"
        MSG_INVALID_MODE="${BOLD}${RED}无效选择，脚本退出。${RESET}"
        MSG_EXITING="脚本退出。"
        MSG_PLISTBUDDY_WARN="${YELLOW}警告：找不到 PlistBuddy 工具。将尝试使用系统默认路径。${RESET}"
        MSG_PLISTBUDDY_ERROR="${BOLD}${RED}错误：找不到 PlistBuddy 工具。请确保已安装 Xcode 命令行工具。${RESET}"
        MSG_SIP_CHECK="正在检测系统完整性保护 (SIP) 状态..."
        MSG_SIP_ENABLED_1="${BOLD}${RED}SIP (系统完整性保护) 当前已启用。${RESET}"
        MSG_SIP_ENABLED_2="${BOLD}${RED}必须禁用 SIP 才能继续此操作。${RESET}"
        MSG_SIP_ENABLED_3="请按照以下步骤操作："
        MSG_SIP_ENABLED_4_3="3. 在终端中输入 '${BOLD}${CYAN}csrutil disable${RESET}' 并按回车。"
        MSG_SIP_ENABLED_4_4="4. 输入 '${BOLD}${CYAN}reboot${RESET}' 并按回车重启 Mac。"
        MSG_SIP_ENABLED_5="禁用 SIP 后，请再次运行此脚本。"
        MSG_SIP_DISABLED="${GREEN}SIP (系统完整性保护) 已禁用，可以继续。${RESET}"
        MSG_WRITE_PERMISSION_ERROR="${BOLD}${RED}错误：未能获得写入权限。请确保 SIP 已禁用。${RESET}"
        MSG_BACKUP_START="正在备份原始文件 "
        MSG_BACKUP_ERROR="${BOLD}${RED}错误：未能成功备份 ${RESET}"
        MSG_BACKUP_COMPLETE="${GREEN}备份完成。${RESET}"
        MSG_FINALIZE_START="正在完成收尾工作并锁定文件..."
        MSG_SET_PERMS_444="正在设置文件权限为只读 (444)..."
        MSG_SET_UCHG="正在设置文件的系统保护标记 (uchg)..."
        MSG_FILE_LOCK_COMPLETE="文件锁定完成。"
        MSG_CLEANUP_BACKUPS="正在清理备份文件..."
        MSG_RESTART_NOW="${BOLD}${YELLOW}必须重启才能使所有更改生效。请立即重启您的 Mac。${RESET}"
        MSG_RECOMMEND_RE_ENABLE_SIP="重启后，强烈建议您重新启用 SIP 以保障系统安全。"
        MSG_UNLOCK_START="开始文件解锁流程 (恢复/卸载)..."
        MSG_UNLOCK_NOUCHG="正在移除所有相关目录文件的系统保护标记 (uchg)..."
        MSG_UNLOCK_CHMOD="正在恢复文件权限为系统默认 (644)..."
        MSG_UNLOCK_COMPLETE="${GREEN}所有相关文件 (eligibility 和 countryd) 均已解锁。${RESET}"
        MSG_SCRIPT_END="脚本执行结束。"
        MSG_SUPPORT_URL="如果遇到任何问题，请到 ${BOLD}https://github.com/kanshurichard/enableAppleAI${RESET} 提交Issue。"
        MSG_M1_FAIL_TRY_M2_PROMPT="${BOLD}方法1执行失败。是否立即尝试方法2？ (y/n): ${RESET}"

        # Method 2 specific
        MSG2_START_STEPS="开始执行 Apple Intelligence 启用步骤..."
        MSG2_MODIFY_PLISTS_START="正在修补资格属性列表文件 (请稍候)..."
        MSG2_MODIFY_PLISTS_COMPLETE="${GREEN}属性列表文件修改完成。${RESET}"
        MSG2_OPERATION_COMPLETE="${GREEN}Apple Intelligence 修补程序已成功应用。${RESET}"
        MSG2_FORCE_US_PROMPT_TITLE="${CYAN}--- 可选步骤：强制修改地区为美国 ---${RESET}"
        MSG2_FORCE_US_PROMPT_BENEFITS="${BOLD}${YELLOW}[好处]${RESET} 在 macOS 26 系统中，此操作可解锁 ChatGPT、Apple News 及国际版苹果地图等功能（需配合相应的网络IP）。"
        MSG2_FORCE_US_PROMPT_WARNING="${BOLD}${YELLOW}[副作用]${RESET} 此操作将导致无法在中国大陆境内使用高德版苹果地图。"
        MSG2_FORCE_US_PROMPT_CONFIRM="${BOLD}您是否希望将系统的国家代码强制修改为美国 (US)？(y/n): ${RESET}"
        MSG2_FORCE_US_START="-> 开始修改 countryd 数据库..."
        MSG2_FORCE_US_UNLOCKING="   - 正在解锁 countryd 文件以便写入..."
        MSG2_FORCE_US_BACKUP="   - 已备份原始 countryd 文件。"
        MSG2_FORCE_US_CONVERT_XML="   - 已转换文件为 XML 格式以便编辑。"
        MSG2_FORCE_US_REPLACE="   - 已替换国家代码为 'US'。"
        MSG2_FORCE_US_CONVERT_BIN="   - 已转换文件回二进制格式。"
        MSG2_FORCE_US_LOCKING="   - 正在锁定 countryd 文件以防覆盖..."
        MSG2_FORCE_US_LOCK_COMPLETE="   - 锁定完成。"
        MSG2_FORCE_US_SUCCESS="${GREEN}✅ 系统地区已成功强制修改为美国并已锁定。${RESET}"
        MSG2_FORCE_US_NOT_FOUND="${YELLOW}⚠️ 警告：未找到 countryd 数据库文件，跳过此步骤。${RESET}"
        MSG2_UNLOCK_IPHONE_WARNING_TITLE="${BOLD}${YELLOW}--- 重要：关于 iPhone 镜像功能的提醒 ---${RESET}"
        MSG2_UNLOCK_IPHONE_WARNING_1="${BOLD}${YELLOW}[要求]${RESET} 如果您使用 iPhone 镜像功能，必须在修改国家代码前，先完成 iPhone 与这台 Mac 的配对。"
        MSG2_UNLOCK_IPHONE_WARNING_2="${BOLD}${YELLOW}[原因]${RESET} 修改国家代码可能导致 macOS 和 iPhone 的代码不匹配，从而阻止配对。请务必先配对，再继续。"

        # Method 1 specific
        M1_START_STEPS="开始执行 Apple Intelligence 启用尝试 (方法1)..."
        M1_PREPARE_MODIFY="正在准备修改系统文件..."
        M1_UNLOCK_PERMS="正在解锁系统资格目录..."
        M1_MODIFY_PLIST_START_1="正在修改 eligibility.plist 中的特定键值..."
        M1_MODIFY_PLIST_START_2="正在修改 os_eligibility.plist 中的特定键值..."
        M1_MODIFY_PLISTS_COMPLETE="${GREEN}所有必要的 plist 文件修改完成。${RESET}"
        M1_EXECUTE_ZOUXIAN="正在使用 lldb 执行资格修补逻辑..."
        M1_RESTART_ELIGIBILITY="正在重启 eligibility 守护进程..."
        M1_CHECK_AI_TITLE="${BOLD}${CYAN}--- 请检查 Apple 智能状态 ---${RESET}"
        M1_CHECK_AI_INSTR_1="请前往“系统设置” -> “Apple 智能”或“Siri”检查“Apple智能”选项是否已经出现。"
        M1_CHECK_AI_INSTR_2="如果 ${BOLD}已经出现${RESET}，或发现新 AI 功能，请输入 Y。"
        M1_CHECK_AI_INSTR_3="如果 ${BOLD}没有出现${RESET}，请输入 N。"
        M1_CHECK_AI_PROMPT="${BOLD}请确认 Apple 智能是否已出现 (Y/N): ${RESET}"
        M1_SUCCESS_CONFIRMED_START="用户确认成功，正在完成设置..."
        M1_OPERATION_COMPLETE="${GREEN}操作已完成。${RESET}"
        M1_CHECK_AI_AGAIN="重启后，再次检查 Apple 智能状态。"
        M1_FAILURE_CONFIRMED_START="${YELLOW}用户确认失败，正在恢复文件...${RESET}"
        M1_RESTORE_START_1="正在从备份恢复 eligibility.plist ..."
        M1_RESTORE_START_2="正在从备份恢复 os_eligibility.plist ..."
        M1_RESTORE_WARNING_FAILED="${BOLD}${RED}警告：未能从备份文件恢复 ${RESET}"
        M1_RESTORE_WARNING_MANUAL="${BOLD}${RED}可能需要手动恢复！${RESET}"
        M1_RESTORE_COMPLETE=" 恢复完成。"
        M1_RESTORE_WARNING_NOT_FOUND="${YELLOW}警告：未找到备份文件，无法恢复。${RESET}"
        M1_ENSURE_NO_UCHG="确保没有uchg标记..."
        M1_DISCLAIMER="免责声明：此脚本修改系统文件，可能导致不稳定或意外行为。请自行承担风险。"
        ;;
esac
# --- End Language Settings ---


# --- SCRIPT CONSTANTS AND FUNCTIONS ---
# ... (The rest of the script will follow)
# ── File Paths & Dirs
ELIGIBILITY_DIR="/private/var/db/eligibilityd"
OS_ELIGIBILITY_DIR="/private/var/db/os_eligibility"
COUNTRYD_PLIST="/private/var/db/com.apple.countryd/countryCodeCache.plist"
PLISTBUDDY="/usr/libexec/PlistBuddy"

# --- Function to ensure sudo credentials are cached, prompting if needed ---
request_sudo_privileges() {
    if (( EUID == 0 )); then
        return
    fi
    echo ""
    echo -e "$MSG_SUDO_REQUIRED"
    if sudo -v -p "$MSG_SUDO_PROMPT"; then
        echo -e "$MSG_SUDO_SUCCESS"
    else
        echo -e "$MSG_SUDO_FAILED" >&2
        exit 1
    fi
}

# --- Function to check SIP status ---
check_sip_status() {
    echo ""
    echo -e "${BLUE}==============================================${RESET}"
    echo -e "$MSG_SIP_CHECK"
    if [[ $(csrutil status) != *"System Integrity Protection status: disabled."* ]]; then
        echo -e "$MSG_SIP_ENABLED_1"; echo -e "$MSG_SIP_ENABLED_2"; echo -e "$MSG_SIP_ENABLED_3"
        echo -e "$MSG_SIP_ENABLED_4_1"; echo -e "$MSG_SIP_ENABLED_4_2"; echo -e "$MSG_SIP_ENABLED_4_3"
        echo -e "$MSG_SIP_ENABLED_4_4"; echo -e "$MSG_SIP_ENABLED_5"
        echo -e "${BLUE}==============================================${RESET}"
        exit 1
    else
        echo -e "$MSG_SIP_DISABLED"
    fi
}

# --- Function to set a plist value ONLY if the key already exists (for Method 2) ---
set_existing_plist_key() {
    local file="$1"
    local key_path="$2"
    local value="$3"
    if sudo "$PLISTBUDDY" -c "Print :${key_path}" "$file" &>/dev/null; then
        sudo "$PLISTBUDDY" -c "Set :${key_path} ${value}" "$file"
    fi
}

# --- Function to Force Location to US ---
force_us_location() {
    echo -e "$MSG2_FORCE_US_START"
    if [ ! -f "$COUNTRYD_PLIST" ]; then
        echo -e "$MSG2_FORCE_US_NOT_FOUND"
        return
    fi
    echo -e "$MSG2_FORCE_US_UNLOCKING"
    sudo chflags nouchg "$COUNTRYD_PLIST"
    sudo chmod 777 "$COUNTRYD_PLIST"
    local BACKUP_FILE="${COUNTRYD_PLIST}.bak"
    sudo cp "$COUNTRYD_PLIST" "$BACKUP_FILE"
    echo -e "$MSG2_FORCE_US_BACKUP"
    sudo plutil -convert xml1 "$COUNTRYD_PLIST"
    echo -e "$MSG2_FORCE_US_CONVERT_XML"
    local NEW_COUNTRY_CODE="US"
    local AWK_SCRIPT='/^[[:space:]]*<string>[A-Z][A-Z]<\/string>[[:space:]]*$/{indent="";if(match($0,/^[[:space:]]*/)){indent=substr($0,RSTART,RLENGTH)}printf "%s<string>%s</string>\n",indent,"'"$NEW_COUNTRY_CODE"'";next}{print $0}'
    local TEMP_PLIST="/tmp/temp_countryd.plist"
    sudo awk "$AWK_SCRIPT" "$COUNTRYD_PLIST" > "$TEMP_PLIST"
    sudo mv "$TEMP_PLIST" "$COUNTRYD_PLIST"
    echo -e "$MSG2_FORCE_US_REPLACE"
    sudo plutil -convert binary1 "$COUNTRYD_PLIST"
    echo -e "$MSG2_FORCE_US_CONVERT_BIN"
    echo -e "$MSG2_FORCE_US_LOCKING"
    sudo chmod 444 "$COUNTRYD_PLIST"
    sudo chflags uchg "$COUNTRYD_PLIST"
    echo -e "$MSG2_FORCE_US_LOCK_COMPLETE"
    echo -e "$MSG2_FORCE_US_SUCCESS"
}

# --- New Function to handle Method 1 Failure ---
handle_method_1_failure() {
    echo ""
    echo -e "${BLUE}==============================================${RESET}"
    read -r -p "$(echo -e "$MSG_M1_FAIL_TRY_M2_PROMPT")" try_m2 < /dev/tty
    if [[ "$try_m2" =~ ^[Yy]$ ]]; then
        enable_ai_method_2
    else
        echo -e "$MSG_EXITING"
    fi
}

# --- METHOD 1 FUNCTION (Simulate US Model) ---
enable_ai_method_1() {
    request_sudo_privileges
    check_sip_status
    
    local ELIGIBILITY_PLIST="${ELIGIBILITY_DIR}/eligibility.plist"
    local OS_ELIGIBILITY_PLIST="${OS_ELIGIBILITY_DIR}/eligibility.plist"
    local PLIST_BACKUP="/tmp/eligibility.plist.bak.m1"
    local OS_PLIST_BACKUP="/tmp/os_eligibility.plist.bak.m1"

    echo ""
    echo -e "${BLUE}==============================================${RESET}"
    echo -e "$M1_START_STEPS"

    echo -e "$M1_PREPARE_MODIFY"
    echo -e "$M1_UNLOCK_PERMS"
    sudo chflags nouchg "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/*
    sudo chmod 777 "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/*

    if [ ! -w "$ELIGIBILITY_PLIST" ] || [ ! -w "$OS_ELIGIBILITY_PLIST" ]; then
        echo -e "$MSG_WRITE_PERMISSION_ERROR" >&2; exit 1
    fi

    echo -e "$MSG_BACKUP_START$ELIGIBILITY_PLIST..."
    sudo cp "$ELIGIBILITY_PLIST" "$PLIST_BACKUP"
    echo -e "$MSG_BACKUP_START$OS_ELIGIBILITY_PLIST..."
    sudo cp "$OS_ELIGIBILITY_PLIST" "$OS_PLIST_BACKUP"
    echo -e "$MSG_BACKUP_COMPLETE"

    echo -e "$M1_MODIFY_PLIST_START_1"
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_COUNTRY_BILLING 2" "$ELIGIBILITY_PLIST"
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_DEVICE_AND_SIRI_LANGUAGE_MATCH 2" "$ELIGIBILITY_PLIST"
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE 2" "$ELIGIBILITY_PLIST"
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_EXTERNAL_BOOT_DRIVE 2" "$ELIGIBILITY_PLIST"
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_CALCIUM:status:OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE 2" "$ELIGIBILITY_PLIST"
    echo -e "$M1_MODIFY_PLIST_START_2"
    sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_STRONTIUM:os_eligibility_answer_t 4" "$OS_ELIGIBILITY_PLIST"
    echo -e "$M1_MODIFY_PLISTS_COMPLETE"

    echo -e "$M1_EXECUTE_ZOUXIAN"
    MAX_WAIT_TIME=60; CHECK_INTERVAL=1; SECONDS_PASSED=0; PROCESS_FOUND=0
    echo -e "$M1_RESTART_ELIGIBILITY"
    sudo launchctl stop com.apple.eligibilityd 2>/dev/null || true
    sleep 0.5
    sudo launchctl start com.apple.eligibilityd

    while [ $SECONDS_PASSED -lt $MAX_WAIT_TIME ]; do
      PID=$(pgrep eligibilityd)
      if [ ! -z "$PID" ]; then
        echo "eligibilityd found with PID $PID"
        PROCESS_FOUND=1
        sudo -E "$(xcrun --find lldb)" --batch \
        -o "process attach --name eligibilityd" \
        -o "expression (void) [[[InputManager sharedInstance] objectForInputValue:6] setValue:@\"LL\" forKey:@\"_deviceRegionCode\"]" \
        -o "expression (void) [[EligibilityEngine sharedInstance] recomputeAllDomainAnswers]" \
        -o "process detach" -o quit
        break
      fi
      sleep $CHECK_INTERVAL
      SECONDS_PASSED=$((SECONDS_PASSED + CHECK_INTERVAL))
    done

    if [ "$PROCESS_FOUND" -ne 1 ]; then
      echo -e "${RED}eligibilityd not found after $MAX_WAIT_TIME seconds. Method 1 failed.${RESET}"
      handle_method_1_failure
      return
    fi

    echo ""
    echo -e "${BLUE}==============================================${RESET}"
    echo -e "$M1_CHECK_AI_TITLE"
    echo -e "$M1_CHECK_AI_INSTR_1"
    echo -e "$M1_CHECK_AI_INSTR_2"
    echo -e "$M1_CHECK_AI_INSTR_3"
    echo -e "${BLUE}----------------------------------------------${RESET}"
    read -r -p "$(echo -e "$M1_CHECK_AI_PROMPT")" user_confirmation < /dev/tty

    if [[ "$user_confirmation" =~ ^[Yy]$ ]]; then
        echo ""
        echo -e "${BLUE}==============================================${RESET}"
        echo -e "$M1_SUCCESS_CONFIRMED_START"
        echo -e "$MSG_FINALIZE_START"
        echo -e "$MSG_SET_PERMS_444"
        sudo chmod 444 "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/*
        echo -e "$MSG_SET_UCHG"
        sudo chflags uchg "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/*
        echo -e "$MSG_FILE_LOCK_COMPLETE"
        echo -e "$MSG_CLEANUP_BACKUPS"
        sudo rm -f "$PLIST_BACKUP" "$OS_PLIST_BACKUP"
        echo -e "$M1_OPERATION_COMPLETE"
        
        echo ""
        echo -e "$MSG2_FORCE_US_PROMPT_TITLE"
        echo -e "$MSG2_FORCE_US_PROMPT_BENEFITS"
        echo -e "$MSG2_FORCE_US_PROMPT_WARNING"
        echo ""
        echo -e "$MSG2_UNLOCK_IPHONE_WARNING_TITLE"
        echo -e "$MSG2_UNLOCK_IPHONE_WARNING_1"
        echo -e "$MSG2_UNLOCK_IPHONE_WARNING_2"
        echo -e "${BLUE}----------------------------------------------------${RESET}"
        read -r -p "$(echo -e "$MSG2_FORCE_US_PROMPT_CONFIRM")" force_us < /dev/tty
        if [[ "$force_us" =~ ^[Yy]$ ]]; then
            force_us_location
        fi
    
        echo ""
        echo -e "${BLUE}==============================================${RESET}"
        echo -e "$MSG_RESTART_NOW"
        echo -e "$M1_CHECK_AI_AGAIN"
        echo -e "$MSG_RECOMMEND_RE_ENABLE_SIP"
        echo -e "${BLUE}==============================================${RESET}"
    else
        echo ""
        echo -e "${BLUE}==============================================${RESET}"
        echo -e "$M1_FAILURE_CONFIRMED_START"
        if [ -f "$PLIST_BACKUP" ]; then
            echo -e "$M1_RESTORE_START_1"
            sudo rm -f "$ELIGIBILITY_PLIST"
            sudo cp "$PLIST_BACKUP" "$ELIGIBILITY_PLIST"
        fi
        if [ -f "$OS_PLIST_BACKUP" ]; then
            echo -e "$M1_RESTORE_START_2"
            sudo rm -f "$OS_ELIGIBILITY_PLIST"
            sudo cp "$OS_PLIST_BACKUP" "$OS_ELIGIBILITY_PLIST"
        fi
        echo -e "$M1_ENSURE_NO_UCHG"
        sudo chflags nouchg "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/*
        echo -e "$MSG_CLEANUP_BACKUPS"
        sudo rm -f "$PLIST_BACKUP" "$OS_PLIST_BACKUP"
        
        handle_method_1_failure
    fi
}

# --- METHOD 2 FUNCTION (Direct Force-Enable) ---
enable_ai_method_2() {
    request_sudo_privileges
    local ELIGIBILITY_PLIST="${ELIGIBILITY_DIR}/eligibility.plist"
    local OS_ELIGIBILITY_PLIST="${OS_ELIGIBILITY_DIR}/eligibility.plist"
    check_sip_status
    if [[ ! -x $PLISTBUDDY ]]; then
      echo -e "$MSG_PLISTBUDDY_WARN"
      if command -v PlistBuddy >/dev/null 2>&1; then
        PLISTBUDDY="PlistBuddy"
      else
        echo -e "$MSG_PLISTBUDDY_ERROR" >&2
        exit 1
      fi
    fi
    echo ""
    echo -e "${BLUE}==============================================${RESET}"
    echo -e "$MSG2_START_STEPS"
    echo -e "$UNLOCK_PERMS"
    sudo chflags nouchg "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/*
    sudo chmod 777 "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/*
    if [ ! -w "$ELIGIBILITY_PLIST" ] || [ ! -w "$OS_ELIGIBILITY_PLIST" ]; then
        echo -e "$MSG_WRITE_PERMISSION_ERROR" >&2; exit 1
    fi
    local PLIST_BACKUP="/tmp/eligibility.plist.bak.m2"
    local OS_PLIST_BACKUP="/tmp/os_eligibility.plist.bak.m2"
    echo -e "$MSG_BACKUP_START$ELIGIBILITY_PLIST..."
    sudo cp "$ELIGIBILITY_PLIST" "$PLIST_BACKUP"
    echo -e "$MSG_BACKUP_START$OS_ELIGIBILITY_PLIST..."
    sudo cp "$OS_ELIGIBILITY_PLIST" "$OS_PLIST_BACKUP"
    echo -e "$MSG_BACKUP_COMPLETE"
    echo -e "$MSG2_MODIFY_PLISTS_START"
    set_existing_plist_key "$OS_ELIGIBILITY_PLIST" "OS_ELIGIBILITY_DOMAIN_STRONTIUM:os_eligibility_answer_t" "4"
    set_existing_plist_key "$OS_ELIGIBILITY_PLIST" "OS_ELIGIBILITY_DOMAIN_XCODE_LLM:os_eligibility_answer_t" "4"
    set_existing_plist_key "$ELIGIBILITY_PLIST" "OS_ELIGIBILITY_DOMAIN_GREYMATTER:os_eligibility_answer_t" "4"
    set_existing_plist_key "$ELIGIBILITY_PLIST" "OS_ELIGIBILITY_DOMAIN_FOUNDATION_MODELS:os_eligibility_answer_t" "4"
    echo -e "$MSG2_MODIFY_PLISTS_COMPLETE"
    echo -e "$MSG_FINALIZE_START"
    echo -e "$MSG_SET_PERMS_444"
    sudo chmod 444 "$ELIGIBILITY_PLIST" "$OS_ELIGIBILITY_PLIST"
    echo -e "$MSG_SET_UCHG"
    sudo chflags uchg "$ELIGIBILITY_PLIST" "$OS_ELIGIBILITY_PLIST"
    echo -e "$MSG_FILE_LOCK_COMPLETE"
    echo -e "$MSG_CLEANUP_BACKUPS"
    sudo rm -f "$PLIST_BACKUP" "$OS_PLIST_BACKUP"
    echo ""
    echo -e "${BLUE}==============================================${RESET}"
    echo -e "$MSG2_OPERATION_COMPLETE"
    
    echo ""
    echo -e "$MSG2_FORCE_US_PROMPT_TITLE"
    echo -e "$MSG2_FORCE_US_PROMPT_BENEFITS"
    echo -e "$MSG2_FORCE_US_PROMPT_WARNING"
    echo ""
    echo -e "$MSG2_UNLOCK_IPHONE_WARNING_TITLE"
    echo -e "$MSG2_UNLOCK_IPHONE_WARNING_1"
    echo -e "$MSG2_UNLOCK_IPHONE_WARNING_2"
    echo -e "${BLUE}----------------------------------------------------${RESET}"
    read -r -p "$(echo -e "$MSG2_FORCE_US_PROMPT_CONFIRM")" force_us < /dev/tty
    if [[ "$force_us" =~ ^[Yy]$ ]]; then
        force_us_location
    fi
    
    echo ""
    echo -e "${BLUE}==============================================${RESET}"
    echo -e "$MSG_RESTART_NOW"
    echo -e "$MSG_RECOMMEND_RE_ENABLE_SIP"
    echo -e "${BLUE}==============================================${RESET}"
}

# --- Function to Unlock Files (Revert/Uninstall) ---
unlock_files() {
    request_sudo_privileges
    check_sip_status
    echo ""
    echo -e "${BLUE}==============================================${RESET}"
    echo -e "$MSG_UNLOCK_START"
    echo ""
    echo -e "$MSG_UNLOCK_NOUCHG"
    sudo chflags nouchg "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/* "$COUNTRYD_PLIST"
    echo -e "$MSG_UNLOCK_CHMOD"
    sudo chmod 644 "${ELIGIBILITY_DIR}"/* "${OS_ELIGIBILITY_DIR}"/* "$COUNTRYD_PLIST"
    echo ""
    echo -e "$MSG_UNLOCK_COMPLETE"
    echo -e "${BLUE}==============================================${RESET}"
}


# --- MAIN SCRIPT EXECUTION ---
# Show disclaimer and require agreement
echo ""
echo -e "$MSG_AGREEMENT_TITLE"
echo -e "$MSG_AGREEMENT_LINE1"
echo -e "$MSG_AGREEMENT_LINE2"
echo -e "$MSG_AGREEMENT_LINE3"
echo -e "${BLUE}----------------------------------------------------${RESET}"
read -r -p "$(echo -e "$MSG_AGREEMENT_PROMPT")" agreement < /dev/tty
if [[ ! "$agreement" =~ ^[Yy]$ ]]; then
    echo -e "$MSG_AGREEMENT_CANCEL"
    exit 1
fi

# Main menu loop
while true; do
    echo ""
    echo -e "${BLUE}==============================================${RESET}"
    echo -e "$MSG_MODE_SELECT_TITLE"
    echo -e "$MSG_MODE_SELECT_1"
    echo -e "$MSG_MODE_SELECT_2"
    echo -e "$MSG_MODE_SELECT_3"
    echo -e "${BLUE}==============================================${RESET}"
    read -r -p "$(echo -e "$MSG_MODE_PROMPT")" mode_choice < /dev/tty

    case "$mode_choice" in
        1)
            # Sub-menu for enabling AI
            echo ""
            echo -e "${BLUE}==============================================${RESET}"
            echo -e "$MSG_SUB_MENU_TITLE"
            echo -e "$MSG_SUB_MENU_M1"
            echo -e "$MSG_SUB_MENU_M1_DESC"
            echo -e "$MSG_SUB_MENU_M2"
            echo -e "$MSG_SUB_MENU_M2_DESC"
            echo -e "$MSG_SUB_MENU_M3"
            echo -e "${BLUE}==============================================${RESET}"
            read -r -p "$(echo -e "$MSG_MODE_PROMPT")" sub_choice < /dev/tty
            
            case "$sub_choice" in
                1)
                    enable_ai_method_1
                    break
                    ;;
                2)
                    enable_ai_method_2
                    break
                    ;;
                3)
                    continue # Go back to the main menu
                    ;;
                *)
                    echo -e "$MSG_INVALID_MODE" >&2
                    exit 1
                    ;;
            esac
            ;;
        2)
            unlock_files
            break
            ;;
        3)
            echo -e "$MSG_EXITING"
            exit 0
            ;;
        *)
            echo -e "$MSG_INVALID_MODE" >&2
            exit 1
            ;;
    esac
done

echo ""
echo -e "$MSG_SCRIPT_END"
echo -e "$MSG_SUPPORT_URL"
echo -e "${BLUE}==============================================${RESET}"

exit 0
