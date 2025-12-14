# enableAppleAI

[English README](README_EN.md) | [中文说明](README.md)

一种在MacOS上（目前测试MacOS 15.4+及26.1均可），无需长期运行后台服务，也无需长期禁用SIP，即可永久稳定开启中国销售Mac设备上Apple AI的方法。

<img width="1411" alt="截屏2025-05-04 09 42 49" src="https://github.com/user-attachments/assets/eeb7a4ef-2d6d-46d5-8305-dd2daaafcd04" />

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=kanshurichard/enableappleai&type=date&legend=top-left)](https://www.star-history.com/#kanshurichard/enableappleai&type=date&legend=top-left)

## 最新3.21版本介绍

- **新增“强制修改地区为美国”功能**：针对macOS 26.X，通过修改 `countryd` 配置文件，即使设备位于中国，也可开启 Siri 整合 ChatGPT、Apple News 及国际版苹果地图。（需配合受支持地区的网络环境）。
- **新增 iPhone 镜像功能预警**：**重要提醒**，如果您使用 iPhone 镜像功能，必须在修改国家代码前先完成 iPhone 与 Mac 的配对，否则修改后可能导致无法配对。
- 增加了方法2（来自 https://github.com/hyderay/AiOnMac 的启发）：只需修改plist文件，不再需要使用lldb对系统进程进行任何调试——**建议方法1失败时尝试**。
- 3.1+版本加入了对Foundation Model等功能的支持。


## 工作原理概述

### 方法1（修改更彻底，建议优先尝试）

尝试试绕过 Apple 对 Apple 智能的启用检查：

1.  用一个[来自这里](https://github.com/CatMe0w/zouxian)的代码，使用lldb暂时注入eligibiltyd，模拟美版LL机型，使其向系统数据库输出该机型支持AI的信息（具体功能请参考该脚本的源仓库）。
2.  修改 `/private/var/db/eligibilityd/eligibility.plist` 这个系统文件，特别是调整其中关于设备区域码 (OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE) 和外部启动盘 (OS_ELIGIBILITY_INPUT_EXTERNAL_BOOT_DRIVE) 的检查值，禁止系统用这些参数来作为功能开启的前提条件。
3.  通过修改文件权限和设置 `uchg` (immutable) 标记，锁定修改后的各个缓存文件状态，防止系统刷新缓存文件。

### 方法2（可解决方法1失败的奇怪问题）

1.  可以直接修改 `/private/var/db/eligibilityd/eligibility.plist` 等几个系统缓存文件，强制让MacOS系统认为设备符合开启Apple智能各项功能的要求。
2.  如果不使用lldb注入，可能会无法开启部分高级功能，但可以作为保底方案。
3.  同样通过 `uchg` 锁定文件。

### 附加功能：强制修改地区（Method 1 & 2 完成后可选）

- 修改 `/private/var/db/com.apple.countryd/countryCodeCache.plist` 文件，将缓存的国家代码强制改为 `US`。
- 这可以欺骗系统认为设备物理位于美国，从而解锁 ChatGPT 整合等基于地理位置限制的功能。

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

**最新3.21脚本：**

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

1.  **选择语言**：支持中文和英文。
2.  **选择操作**：选择“启用 Apple Intelligence”。
3.  **选择方法**：建议优先尝试 **方法 1**。
4.  **可选步骤**：如果您在 macOS 26上，脚本会询问是否强制修改地区为美国。**注意：如果您需要使用 iPhone 镜像，请务必在确认此步前完成配对！**
5.  **重启**：脚本执行完毕后，重启 Mac。
6.  **检查**：系统设置 -> Apple 智能与 Siri，查看是否已开启。
7.  **恢复 SIP**：确认功能正常后，建议重新进入恢复模式执行 `csrutil enable` 启用 SIP。

## 故障排除与反馈

* 如果脚本执行过程中遇到错误，请检查终端输出的错误信息。
* 如果按照步骤执行后 Apple 智能未能成功启用，或者出现其他异常，您也可以在本项目的 GitHub Issues 中提交问题。

## 常见问题

**问：如何卸载？**
答：运行脚本，在主菜单选择 `2. 解锁文件 (卸载)` 即可一键恢复文件权限和状态。

**问：为什么新系统（如 macOS 16/26）新增的 AI 功能没有出现？**
答：请更新脚本到最新版（v3.21+）。新版脚本增加了对 `countryd` 的修改，这对解锁 ChatGPT 等功能至关重要。升级前建议先运行旧脚本的“卸载”功能。

**问：iPhone 镜像（iPhone Mirroring）无法连接？**
答：如果您使用了“强制修改地区为美国”的功能，可能会导致 Mac 和 iPhone 的地区代码不匹配，从而无法配对。**解决方法**：运行脚本选择“卸载”恢复原状 -> 配对 iPhone -> 再次运行脚本启用 AI (此时修改地区不会影响已配对的连接)。

**问：开启AI后，Siri调用的仍然是百度百科这类国内工具，ChatGPT也无法正常调用？**
答：请尝试使用脚本中的“方法2”或在“方法1”成功后，同意进行“强制修改地区为美国”的操作。这会将系统底层的地理位置缓存锁定为 US，从而绕过通过 IP 判断地区的限制（注意：仍需配合受支持地区节点的网络环境）。

**问：图乐园（Image Playground）无法创建图片？**
答：图乐园在老版本系统中不支持中文语言下创建图片，或者需要 macOS 26.1+ 系统。在之前的版本，请尝试将系统语言临时改为英语（美国）。

**问：是否能开启繁体中文（或其他非首发语言）的Apple智能？**
答：取决于 Apple 官方是否已下发该语言包。如果官方尚未支持，强制开启也没有用。

---

