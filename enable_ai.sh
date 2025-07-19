#!/bin/bash

set -e

# --- Initial Welcome ---
echo "==================================================================="
echo " macOS Apple Intelligence Enablement Script 2.11 by KanShuRichard"
echo "       macOS Apple 智能启用辅助脚本 2.11 by KanShuRichard"
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

# --- End Language Selection ---


# --- Language Settings ---
# Declare variables for messages (these will be assigned based on the selected LANG)
MSG_TITLE=""
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
MSG_MODIFY_PLIST_START_1="" # Message for modifying the first plist
MSG_MODIFY_PLIST_START_2="" # Message for modifying the second plist
MSG_MODIFY_PLISTS_COMPLETE="" # Message for modifying both plists complete
MSG_EXECUTE_ZOUXIAN="" # Retained message for logical step
MSG_CHECK_AI_TITLE=""
MSG_CHECK_AI_INSTR_1=""
MSG_CHECK_AI_INSTR_2=""
MSG_CHECK_AI_INSTR_3=""
MSG_CHECK_AI_PROMPT=""
MSG_SUCCESS_CONFIRMED_START=""
MSG_SET_PERMS_444=""
MSG_SET_UCHG=""
MSG_FILE_LOCK_COMPLETE=""
MSG_CLEANUP_BACKUPS="" # Message for cleaning up both backups
MSG_OPERATION_COMPLETE=""
MSG_RESTART_NOW=""
MSG_CHECK_AI_AGAIN=""
MSG_RECOMMEND_RE_ENABLE_SIP=""
MSG_FAILURE_CONFIRMED_START=""
MSG_RESTORE_START_1="" # Message for restoring the first plist
MSG_RESTORE_START_2="" # Message for restoring the second plist
MSG_RESTORE_WARNING_FAILED=""
MSG_RESTORE_WARNING_MANUAL=""
MSG_RESTORE_COMPLETE=""
MSG_RESTORE_WARNING_NOT_FOUND=""
MSG_ENSURE_NO_UCHG=""
MSG_FAILURE_CONSIDER_STEPS=""
MSG_FAILURE_STEP_1=""
MSG_FAILURE_STEP_2=""
MSG_FAILURE_STEP_3=""
MSG_SCRIPT_END=""
MSG_DISCLAIMER=""


# Assign messages based on the selected language
case "$LANG" in
    en*)
        MSG_TITLE="macOS Apple Intelligence Enablement Script 2.0 by KanShuRichard"
        MSG_PLISTBUDDY_WARN="Warning: PlistBuddy tool ($PLISTBUDDY) not found. Attempting default path."
        MSG_PLISTBUDDY_ERROR="Error: PlistBuddy tool not found. Ensure macOS Developer Tools or Xcode is installed."
        MSG_SIP_CHECK="Checking System Integrity Protection (SIP) status..."
        MSG_SIP_ENABLED_1="SIP (System Integrity Protection) is currently enabled."
        MSG_SIP_ENABLED_2="SIP must be disabled to continue."
        MSG_SIP_ENABLED_3="Please follow these steps:"
        MSG_SIP_ENABLED_4_1="1. Restart your Mac and press and hold the power button to enter Recovery Mode."
        MSG_SIP_ENABLED_4_2="2. In Recovery Mode, select 'Utilities' -> 'Terminal' from the menu bar."
        MSG_SIP_ENABLED_4_3="3. In the Terminal, type 'csrutil disable' and press Enter."
        MSG_SIP_ENABLED_4_4="4. Type 'reboot' and press Enter to restart your Mac."
        MSG_SIP_ENABLED_5="After disabling SIP, please run this script again."
        MSG_SIP_DISABLED="SIP (System Integrity Protection) is disabled, proceeding."
        MSG_START_STEPS="Starting Apple Intelligence enablement attempt steps..."
        MSG_PREPARE_MODIFY="Preparing to modify system files..."
        MSG_UNLOCK_PERMS="Removing immutable (uchg) flag and setting permissions to 777 for files in system eligibility directories..."
        MSG_WRITE_PERMISSION_ERROR="Error: Failed to get write permission for a necessary plist file. Please confirm SIP is disabled."
        MSG_BACKUP_START="Backing up original file " # Will append filename
        MSG_BACKUP_ERROR="Error: Failed to successfully back up " # Will append filename
        MSG_BACKUP_COMPLETE="Backup complete."
        MSG_MODIFY_PLIST_START_1="Modifying keys in $ELIGIBILITY_PLIST ..."
        MSG_MODIFY_PLIST_START_2="Modifying key in $OS_ELIGIBILITY_PLIST ..."
        MSG_MODIFY_PLISTS_COMPLETE="All necessary plist modifications complete."
        MSG_EXECUTE_ZOUXIAN="Executing eligibility patch logic..." # Modified message
        MSG_CHECK_AI_TITLE="6. Check Apple Intelligence Status"
        MSG_CHECK_AI_INSTR_1="Important: Please go to 'System Settings' -> 'Apple Intelligence' or 'Siri' now and check if the 'Apple Intelligence' option appears."
        MSG_CHECK_AI_INSTR_2="If 'Apple Intelligence' **does appear**, or you see signs of AI features (even if the main option is hidden), please enter Y below."
        MSG_CHECK_AI_INSTR_3="If 'Apple Intelligence' **does not appear**, or no AI features are evident, please enter N to exit and report."
        MSG_CHECK_AI_PROMPT="Confirm if Apple Intelligence appeared or partial functionality is enabled (Y/N): "
        MSG_SUCCESS_CONFIRMED_START="User confirmed success, completing setup and locking files..."
        MSG_SET_PERMS_444="Setting permissions for eligibility files to 444 (read-only)..."
        MSG_SET_UCHG="Setting immutable (uchg) flag for eligibility files..."
        MSG_FILE_LOCK_COMPLETE="File locking complete."
        MSG_CLEANUP_BACKUPS="Cleaning up backup files..."
        MSG_OPERATION_COMPLETE="Operation completed."
        MSG_RESTART_NOW="Please restart your computer immediately."
        MSG_CHECK_AI_AGAIN="After restarting, check Apple Intelligence status again."
        MSG_RECOMMEND_RE_ENABLE_SIP="If Apple Intelligence remains enabled and you wish to restore system security, it is strongly recommended to enter Recovery Mode again and run 'csrutil enable' to re-enable SIP."
        MSG_FAILURE_CONFIRMED_START="User confirmed failure, restoring files to previous state..."
        MSG_RESTORE_START_1="Restoring original file $ELIGIBILITY_PLIST from backup file $PLIST_BACKUP ..."
        MSG_RESTORE_START_2="Restoring original file $OS_ELIGIBILITY_PLIST from backup file $OS_PLIST_BACKUP ..."
        MSG_RESTORE_WARNING_FAILED="Warning: Failed to restore " # Will append filename
        MSG_RESTORE_WARNING_MANUAL="Manual intervention may be required!"
        MSG_RESTORE_COMPLETE=" restore complete." # Prepended by filename
        MSG_RESTORE_WARNING_NOT_FOUND="Warning: Backup file " # Will append filename
        MSG_ENSURE_NO_UCHG="Ensuring uchg flag is removed..."
        MSG_FAILURE_CONSIDER_STEPS="Apple Intelligence enablement attempt failed. Please consider the following steps:"
        MSG_FAILURE_STEP_1="1. Check your macOS version compatibility (currently tested with 15.4.1 and 15.5 beta)."
        MSG_FAILURE_STEP_2="2. Report the issue to the relevant community/repository." # Modified to be generic
        MSG_FAILURE_STEP_3="3. For system security, it is strongly recommended to restart and enter Recovery Mode again and run 'csrutil enable' to re-enable SIP."
        MSG_SCRIPT_END="Script execution finished."
        MSG_DISCLAIMER="Disclaimer: This script modifies system files and may cause instability or unexpected behavior. Use at your own risk."
        ;;
    *) # Default to Chinese
        MSG_TITLE="macOS Apple Intelligence 启用辅助脚本 2.0 by KanShuRichard"
        MSG_PLISTBUDDY_WARN="警告：找不到 PlistBuddy 工具 ($PLISTBUDDY)。尝试使用默认路径。"
        MSG_PLISTBUDDY_ERROR="错误：找不到 PlistBuddy 工具。请确保已安装 macOS 开发者工具或 Xcode。"
        MSG_SIP_CHECK="正在检测 System Integrity Protection (SIP) 状态..."
        MSG_SIP_ENABLED_1="SIP (System Integrity Protection) 当前已启用。"
        MSG_SIP_ENABLED_2="必须禁用 SIP 才能继续。"
        MSG_SIP_ENABLED_3="请按照以下步骤操作："
        MSG_SIP_ENABLED_4_1="1. 重启 Mac，并长按开机键进入恢复模式。"
        MSG_SIP_ENABLED_4_2="2. 在恢复模式菜单栏中选择 '实用工具' -> '终端'。"
        MSG_SIP_ENABLED_4_3="3. 在终端中输入 'csrutil disable' 并按回车。"
        MSG_SIP_ENABLED_4_4="4. 输入 'reboot' 并按回车重启 Mac。"
        MSG_SIP_ENABLED_5="SIP 禁用后，请再次运行此脚本。"
        MSG_SIP_DISABLED="SIP (System Integrity Protection) 已禁用，可以继续。"
        MSG_START_STEPS="开始执行 Apple Intelligence 启用尝试步骤..."
        MSG_PREPARE_MODIFY="正在准备修改系统文件..."
        MSG_UNLOCK_PERMS="正在删除 /private/var/db/eligibilityd/ 和 /private/var/db/os_eligibility/ 目录下文件的 immutable (uchg) 标记并设置权限为 777..."
        MSG_WRITE_PERMISSION_ERROR="错误：未能获得必要的 plist 文件的写入权限。请再次确认已禁用 SIP。"
        MSG_BACKUP_START="正在备份原始文件 "
        MSG_BACKUP_ERROR="错误：未能成功备份 "
        MSG_BACKUP_COMPLETE="备份完成。"
        MSG_MODIFY_PLIST_START_1="正在修改 $ELIGIBILITY_PLIST 中的特定键值..."
        MSG_MODIFY_PLIST_START_2="正在修改 $OS_ELIGIBILITY_PLIST 中的特定键值..."
        MSG_MODIFY_PLISTS_COMPLETE="所有必要的 plist 文件修改完成。"
        MSG_EXECUTE_ZOUXIAN="执行资格修补逻辑..." # Modified message
        MSG_CHECK_AI_TITLE="6. 请检查 Apple 智能状态"
        MSG_CHECK_AI_INSTR_1="重要：现在请去 '系统设置' -> 'Apple 智能' 或 'Siri' 检查'Apple智能'选项是否已经出现。"
        MSG_CHECK_AI_INSTR_2="如果 'Apple 智能' **已经出现**，或者你发现 Siri/Spotlight 已经具备 Apple 智能的某些功能（即使入口没出现），请在下面输入 Y。"
        MSG_CHECK_AI_INSTR_3="如果 'Apple 智能' **没有出现**，或者没有任何迹象表明功能已启用，请在下面输入 N。"
        MSG_CHECK_AI_PROMPT="请确认 Apple 智能是否已出现或部分功能已启用 (Y/N): "
        MSG_SUCCESS_CONFIRMED_START="用户确认成功，正在完成设置并锁定文件..."
        MSG_SET_PERMS_444="设置 eligibility 文件权限为 444 (只读)..."
        MSG_SET_UCHG="设置 eligibility 文件的 immutable (uchg) 标记..."
        MSG_FILE_LOCK_COMPLETE="文件锁定完成。"
        MSG_CLEANUP_BACKUPS="清理备份文件..."
        MSG_OPERATION_COMPLETE="操作已完成。"
        MSG_RESTART_NOW="请立即重启你的电脑。"
        MSG_CHECK_AI_AGAIN="重启后，再次检查 Apple 智能状态。"
        MSG_RECOMMEND_RE_ENABLE_SIP="如果 Apple 智能仍为开启，并且你希望恢复系统的安全性，强烈建议你再次进入恢复模式，执行 'csrutil enable' 重新打开 SIP。"
        MSG_FAILURE_CONFIRMED_START="用户确认失败，正在恢复文件到修改前状态..."
        MSG_RESTORE_START_1="正在从备份文件 $PLIST_BACKUP 恢复原始文件 $ELIGIBILITY_PLIST ..."
        MSG_RESTORE_START_2="正在从备份文件 $OS_PLIST_BACKUP 恢复原始文件 $OS_ELIGIBILITY_PLIST ..."
        MSG_RESTORE_WARNING_FAILED="警告：未能从备份文件恢复 "
        MSG_RESTORE_WARNING_MANUAL="可能需要手动恢复！"
        MSG_RESTORE_COMPLETE=" 恢复完成。"
        MSG_RESTORE_WARNING_NOT_FOUND="警告：备份文件 "
        MSG_ENSURE_NO_UCHG="确保没有uchg标记..."
        MSG_FAILURE_CONSIDER_STEPS="Apple 智能启用尝试失败。请考虑以下步骤："
        MSG_FAILURE_STEP_1="1. 检查你的 macOS 版本是否兼容 (目前已测试15.4.1和15.5 beta)。"
        MSG_FAILURE_STEP_2="2. 向相关社区/仓库反馈问题。" # Modified to be generic
        MSG_FAILURE_STEP_3="3. 为了系统安全，强烈建议你重启后进入恢复模式，执行 'csrutil enable' 重新打开 SIP。"
        MSG_SCRIPT_END="脚本执行结束。"
        MSG_DISCLAIMER="免责声明：此脚本修改系统文件，可能导致不稳定或意外行为。请自行承担风险。"
        ;;
esac

# --- End Language Settings ---


# Define key file and directory paths
ELIGIBILITY_PLIST="/private/var/db/eligibilityd/eligibility.plist"
ELIGIBILITY_DIR="/private/var/db/eligibilityd"
PLIST_BACKUP="/tmp/eligibility.plist.bak" # Backup file path

OS_ELIGIBILITY_PLIST="/private/var/db/os_eligibility/eligibility.plist" # Second plist path
OS_ELIGIBILITY_DIR="/private/var/db/os_eligibility" # Second plist directory
OS_PLIST_BACKUP="/tmp/os_eligibility.plist.bak" # Second backup file path


PLISTBUDDY="/usr/libexec/PlistBuddy" # PlistBuddy tool path

# Check if PlistBuddy exists
if [ ! -f "$PLISTBUDDY" ]; then
    echo "$MSG_PLISTBUDDY_WARN"
    PLISTBUDDY="PlistBuddy"
    # Re-check if default path is available
    if ! command -v "$PLISTBUDDY" &> /dev/null; then
        echo "$MSG_PLISTBUDDY_ERROR"
        exit 1 # Exit if PlistBuddy is not found
    fi
fi


# 1. Check SIP status
echo "$MSG_SIP_CHECK"
sip_status=$(csrutil status)

if [[ $sip_status != *"System Integrity Protection status: disabled"* ]]; then
    echo "$MSG_SIP_ENABLED_1"
    echo "$MSG_SIP_ENABLED_2"
    echo "$MSG_SIP_ENABLED_3"
    echo "$MSG_SIP_ENABLED_4_1"
    echo "$MSG_SIP_ENABLED_4_2"
    echo "$MSG_SIP_ENABLED_4_3"
    echo "$MSG_SIP_ENABLED_4_4"
    echo "$MSG_SIP_ENABLED_5"
    echo "=============================================="
    exit 1 # Exit if SIP is enabled
else
    echo "$MSG_SIP_DISABLED"
fi

echo ""
echo "=============================================="
echo "$MSG_START_STEPS"

# --- Prepare to modify files ---
echo "$MSG_PREPARE_MODIFY"

# 2. Unlock and set file permissions to 777 for both directories
echo "$MSG_UNLOCK_PERMS"
# Remove uchg flag (ignore errors as file might not have the flag) for both
sudo chflags nouchg "$ELIGIBILITY_DIR"/* "$OS_ELIGIBILITY_DIR"/* || true
# Set permissions to 777 for both
sudo chmod 777 "$ELIGIBILITY_DIR"/* "$OS_ELIGIBILITY_DIR"/*

# Ensure both plist files are writable
if [ ! -w "$ELIGIBILITY_PLIST" ] || [ ! -w "$OS_ELIGIBILITY_PLIST" ]; then
    echo "$MSG_WRITE_PERMISSION_ERROR"
    exit 1 # Exit if write permission is not obtained
fi

# 3. Backup original plist files
echo "$MSG_BACKUP_START$ELIGIBILITY_PLIST to $PLIST_BACKUP ..."
sudo cp "$ELIGIBILITY_PLIST" "$PLIST_BACKUP"
if [ $? -ne 0 ]; then
    echo "$MSG_BACKUP_ERROR$ELIGIBILITY_PLIST file. $MSG_RESTORE_WARNING_MANUAL"
    exit 1 # Failure to backup is critical, must exit
fi

echo "$MSG_BACKUP_START$OS_ELIGIBILITY_PLIST to $OS_PLIST_BACKUP ..."
sudo cp "$OS_ELIGIBILITY_PLIST" "$OS_PLIST_BACKUP"
if [ $? -ne 0 ]; then
    echo "$MSG_BACKUP_ERROR$OS_ELIGIBILITY_PLIST file. $MSG_RESTORE_WARNING_MANUAL"
     # Clean up the first backup if the second one fails
    sudo rm -f "$PLIST_BACKUP"
    exit 1 # Failure to backup is critical, must exit
fi
echo "$MSG_BACKUP_COMPLETE"

# 4. Modify plist file contents
echo "$MSG_MODIFY_PLIST_START_1"
# Use PlistBuddy to set values (change 3 to 2) in the first plist
# Note: PlistBuddy path checked/set at the beginning of the script

# Modify values under OS_ELIGIBILITY_DOMAIN_GREYMATTER
# Add || true to prevent script exit if the key does not exist
sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_COUNTRY_BILLING 2" "$ELIGIBILITY_PLIST" || true
sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_DEVICE_AND_SIRI_LANGUAGE_MATCH 2" "$ELIGIBILITY_PLIST" || true
sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE 2" "$ELIGIBILITY_PLIST" || true
sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_GREYMATTER:status:OS_ELIGIBILITY_INPUT_EXTERNAL_BOOT_DRIVE 2" "$ELIGIBILITY_PLIST" || true

# Modify values under OS_ELIGIBILITY_DOMAIN_CALCIUM
# Add || true
sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_CALCIUM:status:OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE 2" "$ELIGIBILITY_PLIST" || true

echo "$MSG_MODIFY_PLIST_START_2"
# Use PlistBuddy to set the value in the second plist
# Add || true
sudo "$PLISTBUDDY" -c "Set :OS_ELIGIBILITY_DOMAIN_STRONTIUM:os_eligibility_answer_t 4" "$OS_ELIGIBILITY_PLIST" || true

echo "$MSG_MODIFY_PLISTS_COMPLETE"


# 5. Execute eligibility patch logic (replaces zouxian execution)
echo "$MSG_EXECUTE_ZOUXIAN" # Use the updated message

# Original Author: CatMe0w
# Source: https://github.com/CatMe0w/zouxian/blob/master/zouxian.sh
# This embedded script logic waits for eligibilityd and patches it using lldb.
MAX_WAIT_TIME=60
CHECK_INTERVAL=1
SECONDS_PASSED=0
PROCESS_FOUND=0 # Flag to indicate if eligibilityd was found (0=not found, 1=found)

while [ $SECONDS_PASSED -lt $MAX_WAIT_TIME ]; do
  PID=$(pgrep eligibilityd)
  if [ ! -z "$PID" ]; then
    echo "eligibilityd found with PID $PID"
    PROCESS_FOUND=1 # Mark that the process was found
    # Use sudo for lldb as it needs elevated privileges to attach to system processes
    # set -e will cause the script to exit if the sudo lldb command itself fails critically.
    sudo lldb --batch \
    -o "process attach --name eligibilityd" \
    -o "expression (void) [[[InputManager sharedInstance] objectForInputValue:6] setValue:@\"LL\" forKey:@\"_deviceRegionCode\"]" \
    -o "expression (void) [[EligibilityEngine sharedInstance] recomputeAllDomainAnswers]" \
    -o "process detach" \
    -o quit

    # If we reach here, the lldb command itself completed (set -e didn't trigger).
    # Even if lldb exited with a non-zero status for non-critical reasons,
    # the attempt was made. We can now break the waiting loop.
    break # Exit the while loop after attempting the lldb patch
  fi
  sleep $CHECK_INTERVAL
  SECONDS_PASSED=$((SECONDS_PASSED + CHECK_INTERVAL))
done

# Check if the loop finished because it timed out (eligibilityd not found)
if [ "$PROCESS_FOUND" -ne 1 ]; then
  echo "eligibilityd not found after $MAX_WAIT_TIME seconds"
  exit 1 # Exit the entire script if eligibilityd was never found within the timeout
fi

# If we reach this point, it means eligibilityd was found, and the lldb command was attempted.
# The script will now continue to the next logical step (Step 6), where the user confirms success.

# End of embedded eligibility patch logic


echo ""
echo "=============================================="
echo "$MSG_CHECK_AI_TITLE"
echo "$MSG_CHECK_AI_INSTR_1"
echo "$MSG_CHECK_AI_INSTR_2"
echo "$MSG_CHECK_AI_INSTR_3"
echo "=============================================="

# Use < /dev/tty to force reading input from the terminal, fixing the issue with read not pausing when executed via pipe
read -r -p "$MSG_CHECK_AI_PROMPT" user_confirmation < /dev/tty

# 7. Process based on user confirmation
if [[ "$user_confirmation" =~ ^[Yy]$ ]]; then
    # --- User confirmed success path ---
    echo ""
    echo "=============================================="
    echo "$MSG_SUCCESS_CONFIRMED_START"

    # Set file permissions to 444 (read-only) for both directories
    echo "$MSG_SET_PERMS_444"
    sudo chmod 444 "$ELIGIBILITY_DIR"/* "$OS_ELIGIBILITY_DIR"/*

    # Set immutable (uchg) flag for both directories
    echo "$MSG_SET_UCHG"
    sudo chflags uchg "$ELIGIBILITY_DIR"/* "$OS_ELIGIBILITY_DIR"/*
    echo "$MSG_FILE_LOCK_COMPLETE"

    # Clean up backup files
    echo "$MSG_CLEANUP_BACKUPS"
    sudo rm -f "$PLIST_BACKUP" "$OS_PLIST_BACKUP" # Use -f to ignore errors if files don't exist

    echo ""
    echo "$MSG_OPERATION_COMPLETE"
    echo "$MSG_RESTART_NOW"
    echo "$MSG_CHECK_AI_AGAIN"
    echo "$MSG_RECOMMEND_RE_ENABLE_SIP"
    echo "=============================================="

else
    # --- User confirmed failure path ---
    echo ""
    echo "=============================================="
    echo "$MSG_FAILURE_CONFIRMED_START"

    # Restore original plist files
    # Restore the first plist
    if [ -f "$PLIST_BACKUP" ]; then
        echo "$MSG_RESTORE_START_1"
        sudo rm -f "$ELIGIBILITY_PLIST"
        sudo cp "$PLIST_BACKUP" "$ELIGIBILITY_PLIST"
        if [ $? -ne 0 ]; then
            echo "$MSG_RESTORE_WARNING_FAILED$ELIGIBILITY_PLIST. $MSG_RESTORE_WARNING_MANUAL"
        else
             echo "$ELIGIBILITY_PLIST$MSG_RESTORE_COMPLETE"
        fi
    else
        echo "$MSG_RESTORE_WARNING_NOT_FOUND$PLIST_BACKUP. Cannot restore $ELIGIBILITY_PLIST file content."
    fi

    # Restore the second plist
    if [ -f "$OS_PLIST_BACKUP" ]; then
        echo "$MSG_RESTORE_START_2"
        sudo rm -f "$OS_ELIGIBILITY_PLIST"
        sudo cp "$OS_PLIST_BACKUP" "$OS_ELIGIBILITY_PLIST"
        if [ $? -ne 0 ]; then
            echo "$MSG_RESTORE_WARNING_FAILED$OS_ELIGIBILITY_PLIST. $MSG_RESTORE_WARNING_MANUAL"
        else
             echo "$OS_ELIGIBILITY_PLIST$MSG_RESTORE_COMPLETE"
        fi
    else
        echo "$MSG_RESTORE_WARNING_NOT_FOUND$OS_PLIST_BACKUP. Cannot restore $OS_ELIGIBILITY_PLIST file content."
    fi


    # Restore file permissions to 444 (read-only, a safe default state) for both directories
    echo "$MSG_SET_PERMS_444"
    sudo chmod 444 "$ELIGIBILITY_DIR"/* "$OS_ELIGIBILITY_DIR"/*

    # Ensure uchg flag is removed (in case it was set during a previous failed attempt) for both directories
    echo "$MSG_ENSURE_NO_UCHG"
    sudo chflags nouchg "$ELIGIBILITY_DIR"/* "$OS_ELIGIBILITY_DIR"/* || true

    # Clean up backup files
    echo "$MSG_CLEANUP_BACKUPS"
    sudo rm -f "$PLIST_BACKUP" "$OS_PLIST_BACKUP" # Use -f to ignore errors if files don't exist

    echo ""
    echo "$MSG_FAILURE_CONSIDER_STEPS"
    echo "$MSG_FAILURE_STEP_1"
    echo "$MSG_FAILURE_STEP_2"
    echo "$MSG_FAILURE_STEP_3"
    echo "=============================================="

fi


echo ""
echo "=============================================="
echo "$MSG_SCRIPT_END"
echo "$MSG_DISCLAIMER"
echo "=============================================="

exit 0
