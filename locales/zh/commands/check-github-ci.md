## GitHub CI 监控

监控 GitHub Actions CI 状态，并跟踪到完成。

### 使用方法

```bash
# 检查 CI 状态
gh pr checks
```

### 基本示例

```bash
# PR 创建后的 CI 确认
gh pr create --title "新功能添加" --body "说明"
gh pr checks
```

### 与 Claude 的协作

```bash
# CI 确认到修复的流程
gh pr checks
"分析 CI 检查结果，如有失败项目请提出修复方案"

# 修复后的再确认
git push origin feature-branch
gh pr checks
"确认修复后的 CI 结果，确保没有问题"
```

### 执行结果示例

```
All checks were successful
0 cancelled, 0 failing, 8 successful, 3 skipped, and 0 pending checks

   NAME                                    DESCRIPTION                ELAPSED  URL
○  Build/test (pull_request)                                          5m20s    https://github.com/user/repo/actions/runs/123456789
○  Build/lint (pull_request)                                          2m15s    https://github.com/user/repo/actions/runs/123456789
○  Security/scan (pull_request)                                       1m30s    https://github.com/user/repo/actions/runs/123456789
○  Type Check (pull_request)                                          45s      https://github.com/user/repo/actions/runs/123456789
○  Commit Messages (pull_request)                                     12s      https://github.com/user/repo/actions/runs/123456789
-  Deploy Preview (pull_request)                                               https://github.com/user/repo/actions/runs/123456789
-  Visual Test (pull_request)                                                  https://github.com/user/repo/actions/runs/123456789
```

### 注意事项

- 失败时需要详细确认
- 等待所有检查完成后再合并
- 必要时重新执行 `gh pr checks`
