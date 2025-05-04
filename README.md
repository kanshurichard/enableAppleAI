# enableAppleAI

一种在15.4.1（也可能支持更高版本）上，无需长期运行后台服务，也无需长期禁用SIP，即可永久稳定开启中国销售Mac设备上Apple AI的方法。

本脚本同时尝试开启了“登录非AI启用区Apple ID账号（如中国区）”及“外置硬盘安装macOS”的Apple AI支持，但由于本人没有相关设备/账号，欢迎反馈你的测试结果。

## 工作原理概述

该脚本的主要思想是通过以下步骤尝试绕过 Apple 对 Apple 智能的启用检查：

1.  检查并要求禁用 macOS 的 SIP 功能，以便修改系统文件。
2.  下载并执行一个外部的第三方脚本 (`zouxian.sh`)，该脚本会暂时破解eligibiltyd，使其向系统数据库输出该机型支持AI的信息（具体功能请参考该脚本的源仓库）。
3.  修改 `/private/var/db/eligibilityd/eligibility.plist` 这个系统文件，特别是调整其中关于设备区域码 (OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE) 和外部启动盘 (OS_ELIGIBILITY_INPUT_EXTERNAL_BOOT_DRIVE) 的检查值，禁止系统用这些参数来作为功能开启的前提条件。
4.  通过修改文件权限和设置 `uchg` (immutable) 标记，锁定修改后的数据库文件状态。
5.  清理下载的第三方脚本。

## 前置条件

1.  一台运行兼容 macOS 版本的 Mac (M1或以上CPU，macOS 15.1或以上版本)。
2.  管理员权限，因为脚本使用 `sudo` 执行特权命令。
3.  稳定的互联网连接以下载脚本。
4.  **SIP (System Integrity Protection) 已禁用。**

## 执行步骤

请严格按照以下步骤操作：

### 步骤 1: 禁用 System Integrity Protection (SIP)

如果 SIP 已经禁用，可以跳过此步骤。如果未禁用，您必须手动禁用它：

1.  **重启 Mac**。
2.  在 Mac 启动时，立即按住 **Command (⌘) + R** 键，直到看到 Apple 标志或旋转的地球。这将进入 macOS 恢复模式。
3.  在屏幕顶部的菜单栏中，选择 **实用工具 (Utilities)** > **终端 (Terminal)**。
4.  在终端窗口中，输入以下命令并按回车：
    ```bash
    csrutil disable
    ```
5.  您会看到一条确认 SIP 已禁用的消息。
6.  在终端中，输入 `reboot` 并按回车，或者从 Apple 菜单中选择 **重启 (Restart)** 退出恢复模式并启动 Mac。

### 步骤 2: 下载并运行脚本

**单命令快速执行方法:**

如果您完全信任本脚本，可以使用以下单命令直接执行：

```bash
curl -sL https://raw.githubusercontent.com/kanshurichard/enableAI/main/enable_ai.sh | bash
```

**手动执行脚本:**

1.  打开 **终端 (Terminal)** 应用程序。
2.  使用 `curl` 下载脚本文件到当前目录：
    ```bash
    curl -O https://raw.githubusercontent.com/kanshurichard/enableAI/main/enable_ai.sh
    ```
3.  **审查脚本内容：** 使用文本编辑器或命令行工具（如 `cat enable_ai.sh`）仔细阅读下载的 `enable_ai.sh` 文件，确保您理解它将执行的操作。
4.  赋予脚本执行权限：
    ```bash
    chmod +x enable_ai.sh
    ```
5.  执行脚本：
    ```bash
    ./enable_ai.sh
    ```

### 步骤 3: 按照脚本提示操作

脚本运行过程中会输出当前执行的步骤，并可能在某个阶段暂停，提示您去“系统设置”中检查 Apple 智能是否已经显示为开启状态。

* 如果 Apple 智能已经显示，请按 Enter 键继续脚本的剩余部分。
* 如果 Apple 智能未显示为开启，脚本会提示您不要继续，并建议您向第三方脚本 `zouxian` 的作者反馈问题。此时请按 `Ctrl + C` 终止脚本。

### 步骤 4: 重启并最终确认

脚本完成执行后：

1.  **重启您的 Mac。**
2.  重启后，再次前往 **系统设置 (System Settings)** > **通用 (General)** > **Apple 智能 (Apple Intelligence)** 检查功能状态。
3.  如果 Apple 智能仍为开启状态，并且您希望恢复系统的安全性，**强烈建议**您再次进入恢复模式，执行 `csrutil enable` 命令重新启用 SIP。

## 故障排除与反馈

* 如果脚本执行过程中遇到错误，请检查终端输出的错误信息。
* 如果按照步骤执行后 Apple 智能未能成功启用，或者出现其他异常，您也可以在本项目的 GitHub Issues 中提交问题。

---
