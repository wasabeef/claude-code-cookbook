## GitHub CI 監視

GitHub Actions CI 状況を監視して、完了まで追跡します。

### 使い方

```bash
# CI チェック状況を確認
gh pr checks
```

### 基本例

```bash
# PR 作成後の CI 確認
gh pr create --title "新機能の追加" --body "説明"
gh pr checks
```

### Claude との連携

```bash
# CI 確認から修正までの流れ
gh pr checks
「CI チェック結果を分析し、失敗項目があれば修正方法を提案して」

# 修正後の再確認
git push origin feature-branch
gh pr checks
「修正後の CI 結果を確認して、問題がないことを確認して」
```

### 実行結果の例

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

### 注意事項

- 失敗時は詳細確認
- 全チェック完了まで待機してからマージ
- 必要に応じて `gh pr checks` を再実行