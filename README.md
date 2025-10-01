# enableAppleAI

一种在MacOS上（目前测试MacOS 15.4.1+及26.1 beta均可），无需长期运行后台服务，也无需长期禁用SIP，即可永久稳定开启中国销售Mac设备上Apple AI的方法。

<img width="1411" alt="截屏2025-05-04 09 42 49" src="https://github.com/user-attachments/assets/eeb7a4ef-2d6d-46d5-8305-dd2daaafcd04" />

## 最新3.0版本介绍

- 换用了一种更优雅的方式（来自 https://github.com/hyderay/AiOnMac 的启发）：只需修改plist文件，不再需要使用lldb对系统进程进行任何调试——**目测可以解决99%的Issue**。
- 加入了对countryd的缓存文件修改，使得在MacOS26系统中，可以在设备位于中国等不支持的国家时正常开启Siri中的ChatGPT，Apple News及国际版苹果地图等功能（需要配合受支持地区的网络IP）


## 工作原理概述

1.  修改 `/private/var/db/eligibilityd/eligibility.plist`等几个系统缓存文件，强制让MacOS系统认为：（1）设备符合开启Apple智能的要求；（2）设备当前位于美国。
2.  通过修改文件权限和设置 `uchg` (immutable) 标记，锁定修改后的各个缓存文件状态，防止系统刷新缓存文件。

---以下为2.X旧版本的工作原理介绍----

该脚本的主要思想是通过以下步骤尝试绕过 Apple 对 Apple 智能的启用检查：

1.  下载并执行一个[外部的第三方脚本](https://github.com/CatMe0w/zouxian)，该脚本会暂时注入eligibiltyd，使其向系统数据库输出该机型支持AI的信息（具体功能请参考该脚本的源仓库）。
2.  修改 `/private/var/db/eligibilityd/eligibility.plist` 这个系统文件，特别是调整其中关于设备区域码 (OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE) 和外部启动盘 (OS_ELIGIBILITY_INPUT_EXTERNAL_BOOT_DRIVE) 的检查值，禁止系统用这些参数来作为功能开启的前提条件。
3.  通过修改文件权限和设置 `uchg` (immutable) 标记，锁定修改后的数据库文件状态。

## 前置条件

1.  一台运行兼容 macOS 版本的 Mac (M1或以上CPU，macOS 15.1或以上版本)。
2.  管理员权限，因为脚本使用 `sudo` 执行特权命令。
3.  **系统地区设置为“美国”，系统语言、Siri语言均设置为`简体中文（普通话）/中国`，`English(USA)`或其他任何受到Apple智能支持的语言和地区——设置为其他不支持Apple AI的区域会导致开启失败。**
4.  稳定的互联网连接以下载脚本。
5.  SIP (System Integrity Protection) 已禁用。**（破解完成后可重新开启，不影响AI功能）**

## 执行步骤

请严格按照以下步骤操作：

### 步骤 1: 禁用 System Integrity Protection (SIP)

如果 SIP 已经禁用，可以跳过此步骤。如果未禁用，您必须手动禁用它：

1.  **重启 Mac**。
2.  在 Mac 启动时，长按开机键，直到进入 macOS 恢复模式，途中你可能需要输入几次密码。
3.  在屏幕顶部的菜单栏中，选择 **实用工具 (Utilities)** > **终端 (Terminal)**。
4.  在终端窗口中，输入以下命令并按回车：
    ```bash
    csrutil disable
    ```
5.  按y键确认，之后您会看到一条 SIP 已禁用的消息。
6.  在终端中，输入 `reboot` 并按回车，或者从 Apple 菜单中选择 **重启 (Restart)** 退出恢复模式并启动 Mac。

### 步骤 2: 下载并运行脚本


**单命令快速执行方法:**

如果您完全信任本脚本，可以使用以下单命令直接执行：

**最新3.0脚本：**

```bash
curl -sL https://raw.githubusercontent.com/kanshurichard/enableAppleAI/main/enable_ai.sh | bash
```

**如果在国内访问困难，请尝试以下国内加速地址：**

```bash
curl -sL https://cdn.jsdelivr.net/gh/kanshurichard/enableAppleAI@main/enable_ai.sh | bash
```


如果本版遇到问题，请您去提Issue，并可尝试2.13旧版：

```bash
curl -sL https://raw.githubusercontent.com/kanshurichard/enableAppleAI/main/enable_ai_old.sh | bash
```


**手动执行脚本:**

1.  打开 **终端 (Terminal)** 应用程序。
2.  使用 `curl` 下载脚本文件到当前目录：
    ```bash
    curl -O https://raw.githubusercontent.com/kanshurichard/enableAppleAI/main/enable_ai.sh
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

* 如果 Apple 智能已经显示，请按 Y 键继续脚本的剩余部分。
* 如果 Apple 智能未显示为开启，请按 N 键，脚本会自动恢复所有已有的修改。之后您可以重试一次，或来这里提交Issues。

### 步骤 4: 重启并最终确认

脚本完成执行后：

1.  **重启您的 Mac。**
2.  重启后，再次前往 **系统设置 (System Settings)** > **通用 (General)** > **Apple 智能 (Apple Intelligence)** 检查功能状态。
3.  如果 Apple 智能仍为开启状态，并且您希望恢复系统的安全性，**强烈建议**您再次进入恢复模式，执行 `csrutil enable` 命令重新启用 SIP。

## 故障排除与反馈

* 如果脚本执行过程中遇到错误，请检查终端输出的错误信息。
* 如果按照步骤执行后 Apple 智能未能成功启用，或者出现其他异常，您也可以在本项目的 GitHub Issues 中提交问题。

## 常见问题

**问：如何卸载？**  
答：3.0版本已经加入了一键卸载功能。

**问：能否在登录国区账号为iCloud时开启AI？**  
答：理论上3.0版本可以无视国区账号，强制开启AI，但由于我没有相关测试条件，希望得到您的反馈。对于2.X旧版，但有人进行了相关尝试，并（可能）[找到了一种变通的方法](https://github.com/kanshurichard/enableAppleAI/issues/6)。

**问：执行eligibilityd相关的注入代码时报错，怎么办？**  
答：（3.0版本已不再有这个问题，请立刻尝试3.0新版代码）这个问题已有多个报告，基本都是之前运行过其他开启AI的代码，比如 [XcodeLLMEligible](https://github.com/Kyle-Ye/XcodeLLMEligible/) 。我猜测由于该项目代码会尝试用自制程序替代系统自带的eligibilityd，导致现在代码无法注入真正的eligibilityd。请尝试用各种方式卸载之前破解残留的内容，还不行的话可能只能重装系统了。

**问：开启AI后，Siri调用的仍然是百度百科这类国内工具，ChatGPT也无法正常调用，怎么办？**  
答：在26系统中，请使用3.0版本代码解锁，即可开启Siri的ChatGPT（仍需要受支持地区的IP地址）。在15.X系统中，Siri并不使用机型代码，而是使用你的IP地址和Wifi定位，判断是否调用国内服务（如百度），即使在外版机型上，也是这样的。请在设置-隐私与安全性-定位服务中关闭Siri的定位权限，并考虑将所有相关URL放入代理名单，如需更多帮助，可参考：https://nsringo.github.io。

**问：图乐园（Image Playground）无法创建图片的原因？**  
答：图乐园目前不支持中文语言下创建图片，请将系统语言改为英语（美国），即可正常使用（似乎MacOS26系统中已经支持了中文环境下图乐园）。

**问：是否能开启繁体中文（或其他XX语言）的Apple智能？**  
答：取决于Apple智能本身是否支持该语言。如果该语言尚未得到支持，即使在MacOS强制开启了Apple智能，也下载不到对应的语言文件（会一直卡在下载状态）。

---
