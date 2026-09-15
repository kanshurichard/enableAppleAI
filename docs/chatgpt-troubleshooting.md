# Siri / ChatGPT 扩展：分流与地区缓存排查

本文整理一例 macOS 27 上的脱敏诊断记录，区分地区资格、登录和云请求失败。**这是系统行为观察，不是本项目脚本的兼容性测试，也不改变 README 中「macOS 26.5 beta 4 及以上版本方法失效」的说明。**没有以运行项目脚本作为本次验证步骤。

## 不同报错对应不同阶段

| 阶段 | 本例观察 | 可以得出的结论 |
| --- | --- | --- |
| 令牌获取 | `mask-api.icloud.com` 的 `fetchAuthTokens` 先返回 HTTP 429，之后返回 200 | 限流曾发生，但不能解释恢复 200 后的所有失败；遵守 `Retry-After`，避免反复重试。 |
| 扩展资格 | `regionIPRestricted`、`useCaseDoesNotAllowCurrentIPCountryCode`，检查读取旧的 CN GeoIP 记录 | 此次地区弹窗命中了 IP 国家限制，不能仅凭系统语言或地区设置判断原因。 |
| 网页授权后的令牌获取 | 浏览器已完成授权回调，但经 `apple-relay.apple.com` 的请求仍走直连，返回 `request_forbidden` / `unsupported_country_region_territory`，随后 `failedToFetchCredentials` | 网页授权成功不等于系统扩展登录成功。将该域名纳入同一网络策略后，使用者确认登录成功。 |

最后一项验证的是这次登录，不代表所有 Siri 问答、后续重启和缓存刷新均已通过。

## 检查每段请求的实际分流

以下是本例涉及的域名，不是完整域名清单，也不表示每台设备都必须添加全部规则：

| 域名 | 本例关联的请求 |
| --- | --- |
| `mask-api.icloud.com` | 私有访问令牌 |
| `guzzoni.apple.com` | Siri 请求 |
| `guzzoni.smoot.apple.com` | Siri 请求 |
| `apple-relay.fastly-edge.com` | 云请求中继 |
| `gspe1-ssl.ls.apple.com` | GeoServices 国家检测；观察到的路径为 `/pep/gcc` |
| `apple-relay.apple.com` | 网页授权完成后的扩展认证令牌请求中继 |

若正在排查代理分流，可按日志中实际失败的域名逐项对照。下面是 Clash 规则示例，`AI_PROXY` **必须替换为已有策略组名称**；将选用的条目插入现有 `rules`，放在宽泛的 `apple.com` / `icloud.com` 直连规则及 UDP 443 拒绝规则之前，不要覆盖整个配置：

```yaml
- DOMAIN,mask-api.icloud.com,AI_PROXY
- DOMAIN,guzzoni.apple.com,AI_PROXY
- DOMAIN,guzzoni.smoot.apple.com,AI_PROXY
- DOMAIN,apple-relay.fastly-edge.com,AI_PROXY
- DOMAIN,gspe1-ssl.ls.apple.com,AI_PROXY
- DOMAIN,apple-relay.apple.com,AI_PROXY
```

规则命中只说明选中了策略，不证明出口所在地、上游服务可用或节点支持 UDP。检查实际连接链和服务响应；不能用节点名称代替出口验证。观察到 UDP 被拒绝也不足以单独定因，应同时检查是否存在 TCP 回退。

## 地区接口更新不等于系统缓存更新

本例手动通过修正后的网络路径请求 GeoIP 接口得到 `US` 和 HTTP 200，但系统此前仍读取旧的 `CN`。这只能证明该次请求的结果，不能证明 `countryd` 已接收并保存新结果。

本例发现以下两个文件中都存在相同旧时间戳的 GeoIP 记录：

```text
/var/db/com.apple.countryd/countryCodeCache.plist
/var/root/Library/Caches/com.apple.countryd/countryCodeCache.plist
```

启动日志出现 `trying legacy`，单独移除第一个文件后重启又出现旧记录。这强烈提示旧版缓存回退，但仅凭重启后的文件内容，**尚未直接证明具体文件读取顺序**，也不能排除上游 GeoServices 缓存参与。

移除缓存后一度变为 `.available`，当时国家记录为空，尚未观察到系统保存新的 `US`。因此，空缓存时恢复可用不能作为持久修复的验收标准。Wi-Fi 来源也存在独立国家记录；不要把它与 `LocalCountryEstimatesGeoIP` 或综合国家结果混为一谈。

本文不提供通用缓存删除步骤：文件包含多个来源，运行中的进程或上游缓存可能回写。任何变更前应备份并确认文件权限、来源与影响范围，不要删除整个系统缓存目录，也不要为了诊断直接关闭 SIP 或锁定缓存文件。

## 最小只读检查

重现一次后，按同一时间窗口对照系统日志与代理连接日志。以下命令仅查询，不改变规则、缓存或服务：

```bash
/usr/bin/log show --last 10m --style compact --predicate 'process == "countryd" OR eventMessage CONTAINS[c] "regionIPRestricted" OR eventMessage CONTAINS[c] "unsupported_country_region_territory" OR eventMessage CONTAINS[c] "failedToFetchCredentials" OR eventMessage CONTAINS[c] "fetchAuthTokens"'

/usr/bin/plutil -p /var/db/com.apple.countryd/countryCodeCache.plist
sudo /usr/bin/plutil -p /var/root/Library/Caches/com.apple.countryd/countryCodeCache.plist
```

部分日志可能被系统隐藏或无法访问；没有匹配结果不代表请求成功。缓存是 `NSKeyedArchiver` 归档，需沿 UID 引用读取 GeoIP 字段，不要把文件里任意一个国家字符串当成 GeoIP 结果。文件修改时间也不等于内部记录时间。

**不要直接公开完整输出。**日志可能包含授权回调、授权码、令牌、账号、IP 或设备信息；提交 issue 时只保留脱敏后的阶段、错误标识、规则命中与结果，删除 URL 查询参数和个人信息。

验收应分别记录：规则是否加载、请求是否命中、接口是否成功、扩展是否登录成功，以及重启和缓存刷新后是否仍可用。
