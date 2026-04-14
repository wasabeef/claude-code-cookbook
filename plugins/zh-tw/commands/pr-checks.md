## GitHub CI 監控

監控 GitHub Actions CI 狀態，並跟蹤到完成。

### 使用方法

```bash
# 檢查 CI 狀態
gh pr checks
```

### 基本示例

```bash
# PR 創建後的 CI 確認
gh pr create --title "新功能添加" --body "說明"
gh pr checks
```

### 與 Claude 的協作

```bash
# CI 確認到修復的流程
gh pr checks
"分析 CI 檢查結果，如有失败項目請提出修復方案"

# 修復後的再確認
git push origin feature-branch
gh pr checks
"確認修復後的 CI 結果，確保没有問題"
```

### 執行結果示例

```text
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

### 注意事項

- 失败時需要詳细確認
- 等待所有檢查完成後再合並
- 必要時重新執行 `gh pr checks`
