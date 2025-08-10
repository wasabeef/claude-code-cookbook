## GitHub CI 모니터링

GitHub Actions CI 상황을 모니터링하고 완료까지 추적합니다.

### 사용법

```bash
# CI 체크 상황 확인
gh pr checks
```

### 기본 사용 예시

```bash
# PR 생성 후 CI 확인
gh pr create --title "새 기능 추가" --body "설명"
gh pr checks
```

### Claude 와의 연동

```bash
# CI 확인부터 수정까지의 흐름
gh pr checks
"CI 체크 결과를 분석하고, 실패 항목이 있다면 수정 방법을 제안하세요"

# 수정 후 재확인
git push origin feature-branch
gh pr checks
"수정 후 CI 결과를 확인하고, 문제가 없는지 확인하세요"
```

### 실행 결과 예시

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

### 주의사항

- 실패 시 상세 확인
- 모든 체크 완료 후 병합
- 필요에 따라 `gh pr checks` 재실행