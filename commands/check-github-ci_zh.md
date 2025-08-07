## GitHub CI 监控

监控 GitHub Actions CI 状态，并跟踪至完成。

### 使用方法

```bash
# 检查 CI 状态
gh pr checks
```

### 基本示例

```bash
# PR 创建后的 CI 确认
gh pr create --title "添加新功能" --body "说明"
gh pr checks
```

### 与 Claude 协作

```bash
# 从 CI 确认到修正的流程
gh pr checks
「分析 CI 检查结果，如果有失败项，请提出修正方法」

# 修正后的再次确认
git push origin feature-branch
gh pr checks
「确认修正后的 CI 结果，确保没有问题」
```

### 执行结果示例

```
所有检查均已成功
0 已取消, 0 失败, 8 成功, 3 跳过, 0 待处理检查

   名称                                    描述                    耗时    URL
○  Build/test (pull_request)                                          5分20秒    https://github.com/user/repo/actions/runs/123456789
○  Build/lint (pull_request)                                          2分15秒    https://github.com/user/repo/actions/runs/123456789
○  Security/scan (pull_request)                                       1分30秒    https://github.com/user/repo/actions/runs/123456789
○  Type Check (pull_request)                                          45秒      https://github.com/user/repo/actions/runs/123456789
○  Commit Messages (pull_request)                                     12秒      https://github.com/user/repo/actions/runs/123456789
-  Deploy Preview (pull_request)                                               https://github.com/user/repo/actions/runs/123456789
-  Visual Test (pull_request)                                                  https://github.com/user/repo/actions/runs/123456789
```

### 注意事项

- 失败时请确认详情
- 等待所有检查完成后再合并
- 必要时重新执行 `gh pr checks`