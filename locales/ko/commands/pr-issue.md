## Issue List

현재 리포지토리의 오픈 Issue 목록을 우선순위와 함께 표시합니다.

### 사용법

```bash
# Claude 에 의뢰
「오픈 Issue 목록을 우선순위와 함께 표시하세요」
```

### 기본 예제

```bash
# 리포지토리 정보 취득
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# 오픈 Issue 정보 취득하여 Claude 에 의뢰
gh issue list --state open --json number,title,author,createdAt,updatedAt,labels,assignees,comments --limit 30

「위의 Issue 를 우선순위별로 정리하여, 각 Issue 의 2 행 개요도 포함해서 표시하세요. URL 은 위에서 취득한 리포지토리명을 사용하여 생성하세요」
```

### 표시 형식

```
오픈 Issue 목록 (우선순위순)

### 고우선순위
#번호 제목 [라벨] | 작성자 | 오픈부터 경과 시간 | 코멘트 수 | 담당자
      ├─ 개요 1 행째
      └─ 개요 2 행째
      https://github.com/owner/repo/issues/번호

### 중우선순위
(동일한 형식)

### 저우선순위
(동일한 형식)
```

### 우선순위 판정 기준

**고우선순위**

- `bug` 라벨이 붙은 Issue
- `critical`이나 `urgent` 라벨이 붙은 Issue
- `security` 라벨이 붙은 Issue

**중우선순위**

- `enhancement` 라벨이 붙은 Issue
- `feature` 라벨이 붙은 Issue
- 담당자가 설정된 Issue

**저우선순위**

- `documentation` 라벨이 붙은 Issue
- `good first issue` 라벨이 붙은 Issue
- `wontfix`나 `duplicate` 라벨이 붙은 Issue

### 라벨을 통한 필터링

```bash
# 특정 라벨의 Issue 만 취득
gh issue list --state open --label "bug" --json number,title,author,createdAt,labels,comments --limit 30

# 복수 라벨로 필터링 (AND 조건)
gh issue list --state open --label "bug,high-priority" --json number,title,author,createdAt,labels,comments --limit 30
```

### 주의사항

- GitHub CLI (`gh`)가 필요합니다
- 오픈 상태의 Issue 만 표시합니다
- 최대 30 개의 Issue 를 표시합니다
- 경과 시간은 Issue 가 오픈된 시점부터의 시간입니다
- Issue 의 URL 은 실제 리포지토리명에서 자동 생성됩니다
