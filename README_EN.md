# enableAppleAI

[English README](README_EN.md) | [中文说明](README.md)

A method to permanently and stably enable Apple Intelligence on Mac devices sold in China, without running background services long-term or keeping SIP disabled permanently. (Tested on macOS 15.1+ and 16.X beta).

<img width="1411" alt="Screenshot" src="https://github.com/user-attachments/assets/eeb7a4ef-2d6d-46d5-8305-dd2daaafcd04" />

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=kanshurichard/enableappleai&type=date&legend=top-left)](https://www.star-history.com/#kanshurichard/enableappleai&type=date&legend=top-left)

## Latest Version 3.21 Features

- **New "Force US Location" Feature**: Targeting macOS 16.X (referred to as macOS 26 in script), modifying the `countryd` configuration allows unlocking Siri integration with ChatGPT, Apple News, and International Apple Maps even if the device is physically in China (requires supported network environment).
- **New iPhone Mirroring Warning**: **IMPORTANT**: If you use iPhone Mirroring, you **MUST** pair your iPhone with your Mac **BEFORE** changing the country code. Modification afterwards may prevent pairing.
- **Method 2 Added** (Inspired by https://github.com/hyderay/AiOnMac): Simply modifies plist files without `lldb` injection. **Recommended to try if Method 1 fails.**
- Version 3.1 added support for Foundation Models, Personal QA, etc.

## How It Works

### Method 1 (More comprehensive, recommended first)

Attempts to bypass Apple's eligibility checks for Apple Intelligence:

1.  Uses [code from here](https://github.com/CatMe0w/zouxian) to temporarily inject into `eligibilityd` via `lldb`, simulating a US model (LL) to output AI support status to the system database.
2.  Modifies `/private/var/db/eligibilityd/eligibility.plist`, specifically adjusting checks for device region code (`OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE`) and external boot drive (`OS_ELIGIBILITY_INPUT_EXTERNAL_BOOT_DRIVE`) to prevent them from blocking feature enablement.
3.  Locks the modified cache files using file permissions and the `uchg` (immutable) flag to prevent the system from refreshing/overwriting them.

### Method 2 (Solves specific failures of Method 1)

1.  Directly modifies system cache files like `/private/var/db/eligibilityd/eligibility.plist` to force macOS to believe the device meets Apple Intelligence requirements.
2.  Does not use `lldb` injection. While it may not unlock every advanced feature in some edge cases, it serves as a robust fallback.
3.  Also locks files using `uchg`.

### Additional Feature: Force US Location (Optional after Method 1 & 2)

- Modifies `/private/var/db/com.apple.countryd/countryCodeCache.plist` to force the cached country code to `US`.
- This tricks the system into believing the device is physically located in the US, unlocking location-restricted features like ChatGPT integration.

## Prerequisites

1.  A Mac running a compatible macOS version (M1 or later CPU, macOS 15.1 or later).
2.  Administrator privileges (the script uses `sudo`).
3.  **System Region set to "United States". System Language and Siri Language set to "English (US)". (Setting to unsupported regions will cause failure).**
    *   *Note: Original Chinese guide mentions Chinese is supported, but for global users, stick to US settings for best compatibility.*
4.  Stable internet connection to download the script.
5.  SIP (System Integrity Protection) disabled. **(Can be re-enabled after patching, AI features will remain)**.

## Installation Steps

Please follow these steps strictly:

### Step 1: Disable System Integrity Protection (SIP)

If SIP is already disabled, skip this. If not:

1.  **Restart your Mac**.
2.  Hold the power button during startup until you see "Loading startup options" to enter macOS Recovery. (You may need to enter your password).
3.  From the utilities menu bar at the top, select **Utilities** > **Terminal**.
4.  Type the following command and press Enter:
    ```bash
    csrutil disable
    ```
5.  Type `y` to confirm. You should see a message stating SIP is disabled.
6.  Type `reboot` and press Enter to restart.

### Step 2: Download and Run the Script

**Quick One-Line Command:**

If you trust this script, run:

**Latest v3.21 Script:**

```bash
curl -sL https://raw.githubusercontent.com/kanshurichard/enableAppleAI/main/enable_ai.sh | bash
```

**Alternative (if GitHub is slow):**

```bash
curl -sL https://cdn.jsdelivr.net/gh/kanshurichard/enableAppleAI@main/enable_ai.sh | bash
```

**Manual Execution:**

1.  Open **Terminal**.
2.  Download the script:
    ```bash
    curl -O https://raw.githubusercontent.com/kanshurichard/enableAppleAI/main/enable_ai.sh
    ```
3.  **Review the script:** Check `enable_ai.sh` content to understand what it does.
4.  Make it executable:
    ```bash
    chmod +x enable_ai.sh
    ```
5.  Run it:
    ```bash
    ./enable_ai.sh
    ```

### Step 3: Follow Script Prompts

1.  **Select Language**: Choose English.
2.  **Select Operation**: Choose "Enable Apple Intelligence".
3.  **Select Method**: Recommended to try **Method 1** first.
4.  **Optional Step**: On macOS 16+ (macOS 26), you will be asked to Force US Location. **WARNING: Pair iPhone Mirroring BEFORE confirming this!**
5.  **Restart**: Reboot your Mac after the script finishes.
6.  **Check**: Go to System Settings -> Apple Intelligence & Siri to see if it's enabled.
7.  **Restore SIP**: Once confirmed working, recommended to re-enable SIP via Recovery Mode (`csrutil enable`).

## Troubleshooting & Feedback

*   Check terminal output for errors during execution.
*   If Apple Intelligence fails to enable, try Method 2.
*   Submit issues on GitHub if problems persist.

## FAQ

**Q: How to uninstall?**
A: Run the script and select `2. Unlock Files (Uninstall)` from the main menu. This restores file permissions and removes the locks.

**Q: Why do new AI features not appear after a system update (e.g., macOS 16/26)?**
A: Please update the script to the latest version (v3.21+). New scripts include necessary updates for `countryd` which are crucial for features like ChatGPT. Recommended: Uninstall using old script -> Reboot -> Run new script.

**Q: iPhone Mirroring connection failed?**
A: If you used "Force US Location", your Mac and iPhone region codes might mismatch. **Fix**: Run script -> Uninstall -> Pair iPhone -> Run script again and enable AI (changing region afterwards won't break existing pairing).

**Q: Siri still uses local search instead of ChatGPT?**
A: Try "Method 2" or ensure you accepted "Force US Location" in "Method 1". This locks the location cache to US. (Requires US-compatible network IP).

**Q: Image Playground cannot generate images?**
A: Image Playground currently doesn't support all languages/regions. Try changing system language to English (US) temporarily.

**Q: Can I enable it for unsupported languages?**
A: No. If Apple hasn't released the language pack/support for it, forcing it won't work.

---
