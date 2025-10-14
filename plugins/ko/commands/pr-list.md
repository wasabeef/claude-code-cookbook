## PR List

현재 리포지토리의 오픈 PR 목록을 우선순위와 함께 표시합니다.

### 사용법

```bash
# Claude 에 의뢰
「오픈 PR 목록을 우선순위와 함께 표시하세요」
```

### 기본 예제

```bash
# 리포지토리 정보 취득
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# 오픈 PR 정보 취득하여 Claude 에 의뢰
gh pr list --state open --draft=false --json number,title,author,createdAt,additions,deletions,reviews --limit 30

「위의 PR 을 우선순위별로 정리하여, 각 PR 의 2 행 개요도 포함해서 표시하세요. URL 은 위에서 취득한 리포지토리명을 사용하여 생성하세요」
```

### 표시 형식

```text
오픈 PR 목록 (우선순위순)

### 고우선순위
#번호 제목 [Draft/DNM] | 작성자 | 오픈부터 경과 시간 | Approved 수 | +추가/-삭제
      ├─ 개요 1 행째
      └─ 개요 2 행째
      https://github.com/owner/repo/pull/번호

### 중우선순위
(동일한 형식)

### 저우선순위
(동일한 형식)
```

### 우선순위 판정 기준

**고우선순위**

- `fix:` 버그 수정
- `release:` 릴리스 작업

**중우선순위**

- `feat:` 신규 기능
- `update:` 기능 개선
- 기타 일반적인 PR

**저우선순위**

- DO NOT MERGE 를 포함하는 PR
- Draft 이면서 `test:`, `build:`, `perf:`인 PR

### 주의사항

- GitHub CLI (`gh`)가 필요합니다
- 오픈 상태의 PR 만 표시합니다 (Draft 는 제외)
- 최대 30 개의 PR 을 표시합니다
- 경과 시간은 PR 이 오픈된 시점부터의 시간입니다
- PR 의 URL 은 실제 리포지토리명에서 자동 생성됩니다
