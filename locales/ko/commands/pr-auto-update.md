## PR Auto Update

## 개요

Pull Request 의 설명과 라벨을 자동으로 업데이트하는 명령어입니다. Git 변경 내용을 분석하여 적절한 설명문과 라벨을 생성·설정합니다.

## 사용법

```bash
/pr-auto-update [옵션] [PR 번호]
```

### 옵션

- `--pr <번호>` : 대상 PR 번호 지정 (생략 시 현재 브랜치에서 자동 검출)
- `--description-only` : 설명문만 업데이트 (라벨은 변경하지 않음)
- `--labels-only` : 라벨만 업데이트 (설명문은 변경하지 않음)
- `--dry-run` : 실제 업데이트는 하지 않고 생성될 내용만 표시
- `--lang <언어>` : 언어 지정 (ja, en)

### 기본 예제

```bash
# 현재 브랜치의 PR 을 자동 업데이트
/pr-auto-update

# 특정 PR 업데이트
/pr-auto-update --pr 1234

# 설명문만 업데이트
/pr-auto-update --description-only

# 드라이런으로 확인
/pr-auto-update --dry-run
```

## 기능 상세

### 1. PR 자동 검출

현재 브랜치에서 해당하는 PR 을 자동 검출:

```bash
# 브랜치에서 PR 검색
gh pr list --head $(git branch --show-current) --json number,title,url
```

### 2. 변경 내용 분석

다음 정보를 수집·분석:

- **파일 변경**: 추가·삭제·변경된 파일
- **코드 분석**: import 문, 함수 정의, 클래스 정의의 변경
- **테스트**: 테스트 파일의 유무와 내용
- **문서**: README, docs 의 업데이트
- **설정**: package.json, pubspec.yaml, 설정 파일의 변경
- **CI/CD**: GitHub Actions, workflow 의 변경

### 3. 설명문 자동 생성

#### 템플릿 처리의 우선순위

1. **기존 PR 설명**: 이미 작성된 내용을 **완전히 준수**
2. **프로젝트 템플릿**: `.github/PULL_REQUEST_TEMPLATE.md`에서 구조 가져오기
3. **기본 템플릿**: 위의 것들이 존재하지 않는 경우의 폴백

#### 기존 내용 보존 규칙

**중요**: 기존 내용은 변경하지 않음

- 작성된 섹션은 보존
- 빈 섹션만 보완
- 기능적 코멘트 (Copilot review rule 등)는 보존

#### 프로젝트 템플릿 사용

```bash
# .github/PULL_REQUEST_TEMPLATE.md 의 구조 분석
parse_template_structure() {
  local template_file="$1"
  
  if [ -f "$template_file" ]; then
    # 섹션 구조 추출
    grep -E '^##|^###' "$template_file"
    
    # 코멘트 플레이스홀더 식별
    grep -E '<!--.*-->' "$template_file"
    
    # 기존 템플릿 구조를 완전히 준수
    cat "$template_file"
  fi
}
```

### 4. 라벨 자동 설정

#### 라벨 취득 메커니즘

**우선순위**:

1. **`.github/labels.yml`**: 프로젝트 고유의 라벨 정의에서 취득
2. **GitHub API**: `gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'`로 기존 라벨 취득

#### 자동 판정 규칙

**파일 패턴 기반**:

- 문서: `*.md`, `README`, `docs/` → `documentation|docs|doc`를 포함하는 라벨
- 테스트: `test`, `spec` → `test|testing`을 포함하는 라벨  
- CI/CD: `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops`를 포함하는 라벨
- 종속성: `package.json`, `pubspec.yaml`, `requirements.txt` → `dependencies|deps`를 포함하는 라벨

**변경 내용 기반**:

- 버그 수정: `fix|bug|error|crash|수정` → `bug|fix`를 포함하는 라벨
- 신규 기능: `feat|feature|add|implement|신규기능|구현` → `feature|enhancement|feat`를 포함하는 라벨
- 리팩터링: `refactor|clean|리팩토` → `refactor|cleanup|clean`을 포함하는 라벨
- 성능: `performance|perf|optimize|성능` → `performance|perf`를 포함하는 라벨
- 보안: `security|secure|보안` → `security`를 포함하는 라벨

#### 제약

- **최대 3 개까지**: 자동 선택되는 라벨 수의 상한
- **기존 라벨만**: 새로운 라벨 생성은 금지
- **부분 매치**: 라벨명에 키워드가 포함되어 있는지로 판정

#### 실제 사용 예제

**`.github/labels.yml`이 존재하는 경우**:

```bash
# 라벨 정의에서 자동 취득
grep "^- name:" .github/labels.yml | sed "s/^- name: '\?\([^']*\)'\?/\1/"

# 예: 프로젝트 고유의 라벨 체계 사용
```

**GitHub API 에서 취득하는 경우**:

```bash
# 기존 라벨 목록 취득
gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'

# 예: bug, enhancement, documentation 등의 표준적인 라벨 사용
```

### 5. 실행 플로우

```bash
#!/bin/bash

# 1. PR 검출·취득
detect_pr() {
  if [ -n "$PR_NUMBER" ]; then
    echo $PR_NUMBER
  else
    gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'
  fi
}

# 2. 변경 내용 분석
analyze_changes() {
  local pr_number=$1
  
  # 파일 변경 취득
  gh pr diff $pr_number --name-only
  
  # 내용 분석
  gh pr diff $pr_number | head -1000
}

# 3. 설명문 생성
generate_description() {
  local pr_number=$1
  local changes=$2
  
  # 현재 PR 설명 취득
  local current_body=$(gh pr view $pr_number --json body --jq -r .body)
  
  # 기존 내용이 있으면 그대로 사용
  if [ -n "$current_body" ]; then
    echo "$current_body"
  else
    # 템플릿에서 신규 생성
    local template_file=".github/PULL_REQUEST_TEMPLATE.md"
    if [ -f "$template_file" ]; then
      generate_from_template "$(cat "$template_file")" "$changes"
    else
      generate_from_template "" "$changes"
    fi
  fi
}

# 템플릿에서 생성
generate_from_template() {
  local template="$1"
  local changes="$2"
  
  if [ -n "$template" ]; then
    # 템플릿을 그대로 사용 (HTML 코멘트 보존)
    echo "$template"
  else
    # 기본 형식으로 생성
    echo "## What does this change?"
    echo ""
    echo "$changes"
  fi
}

# 4. 라벨 결정
determine_labels() {
  local changes=$1
  local file_list=$2
  local pr_number=$3
  
  # 사용 가능한 라벨 취득
  local available_labels=()
  if [ -f ".github/labels.yml" ]; then
    # labels.yml 에서 라벨명 추출
    available_labels=($(grep "^- name:" .github/labels.yml | sed "s/^- name: '\?\([^']*\)'\?/\1/"))
  else
    # GitHub API 에서 라벨 취득
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    available_labels=($(gh api "repos/$owner/$repo/labels" --jq '.[].name'))
  fi
  
  local suggested_labels=()
  
  # 범용적인 패턴 매칭
  analyze_change_patterns "$file_list" "$changes" available_labels suggested_labels
  
  # 최대 3 개로 제한
  echo "${suggested_labels[@]:0:3}"
}

# 변경 패턴에서 라벨 결정
analyze_change_patterns() {
  local file_list="$1"
  local changes="$2"
  local -n available_ref=$3
  local -n suggested_ref=$4
  
  # 파일 타입별 판정
  if echo "$file_list" | grep -q "\.md$\|README\|docs/"; then
    add_matching_label "documentation\|docs\|doc" available_ref suggested_ref
  fi
  
  if echo "$file_list" | grep -q "test\|spec"; then
    add_matching_label "test\|testing" available_ref suggested_ref
  fi
  
  # 변경 내용별 판정
  if echo "$changes" | grep -iq "fix\|bug\|error\|crash\|수정"; then
    add_matching_label "bug\|fix" available_ref suggested_ref
  fi
  
  if echo "$changes" | grep -iq "feat\|feature\|add\|implement\|신규기능\|구현"; then
    add_matching_label "feature\|enhancement\|feat" available_ref suggested_ref
  fi
}

# 매치하는 라벨 추가
add_matching_label() {
  local pattern="$1"
  local -n available_ref=$2
  local -n suggested_ref=$3
  
  # 이미 3 개 있는 경우 스킵
  if [ ${#suggested_ref[@]} -ge 3 ]; then
    return
  fi
  
  # 패턴에 매치하는 첫 번째 라벨 추가
  for available_label in "${available_ref[@]}"; do
    if echo "$available_label" | grep -iq "$pattern"; then
      # 중복 체크
      local already_exists=false
      for existing in "${suggested_ref[@]}"; do
        if [ "$existing" = "$available_label" ]; then
          already_exists=true
          break
        fi
      done
      
      if [ "$already_exists" = false ]; then
        suggested_ref+=("$available_label")
        return
      fi
    fi
  done
}

# 구 함수의 호환성을 위해 남겨둠
find_and_add_label() {
  add_matching_label "$@"
}

# 5. PR 업데이트
update_pr() {
  local pr_number=$1
  local description="$2"
  local labels="$3"
  
  if [ "$DRY_RUN" = "true" ]; then
    echo "=== DRY RUN ==="
    echo "Description:"
    echo "$description"
    echo "Labels: $labels"
  else
    # 리포지토리 정보 취득
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    
    # GitHub API 를 사용하여 본문 업데이트 (HTML 코멘트 보존)
    # JSON 이스케이프를 적절히 처리
    local escaped_body=$(echo "$description" | jq -R -s .)
    gh api \
      --method PATCH \
      "/repos/$owner/$repo/pulls/$pr_number" \
      --field body="$description"
    
    # 라벨은 일반적인 gh 명령으로 문제없음
    if [ -n "$labels" ]; then
      gh pr edit $pr_number --add-label "$labels"
    fi
  fi
}
```

## 설정 파일 (향후 확장용)

`~/.claude/pr-auto-update.config`:

```json
{
  "language": "ja",
  "max_labels": 3
}
```

## 자주 사용하는 패턴

### Flutter 프로젝트

```markdown
## What does this change?

{기능명}을 구현했습니다. 사용자의 {과제}를 해결합니다.

### 주요 변경 내용

- **UI 구현**: {화면명}을 신규 생성
- **상태 관리**: Riverpod 프로바이더 추가
- **API 통합**: GraphQL 쿼리·뮤테이션 구현
- **테스트**: 위젯 테스트·단위 테스트 추가

### 기술 사양

- **아키텍처**: {사용 패턴}
- **종속성**: {신규 추가한 패키지}
- **성능**: {최적화 내용}
```

### Node.js 프로젝트

```markdown
## What does this change?

{API 명} 엔드포인트를 구현했습니다. {유스케이스}에 대응합니다.

### 주요 변경 내용

- **API 구현**: {엔드포인트}를 신규 생성
- **검증**: 요청 검증 로직 추가
- **데이터베이스**: {테이블명}에 대한 조작 구현
- **테스트**: 통합 테스트·단위 테스트 추가

### 보안

- **인증**: JWT 토큰 검증
- **인가**: 역할 기반 접근 제어
- **입력 검증**: SQL 인젝션 대책
```

### CI/CD 개선

```markdown
## What does this change?

GitHub Actions 워크플로우를 개선했습니다. {효과}를 실현합니다.

### 개선 내용

- **성능**: 빌드 시간을 {시간} 단축
- **신뢰성**: 오류 처리 강화
- **보안**: 시크릿 관리 개선

### 기술 세부사항

- **병렬화**: {작업명}을 병렬 실행
- **캐시**: {캐시 대상}의 캐시 전략 최적화
- **모니터링**: {지표}의 모니터링 추가
```

## 주의사항

1. **기존 내용의 완전 보존**:
   - 이미 작성된 내용은 **한 글자도 변경하지 않음**
   - 빈 코멘트 부분과 플레이스홀더만 보완
   - 사용자가 의도적으로 작성한 내용을 존중

2. **템플릿 우선순위**:
   - 기존 PR 설명 > `.github/PULL_REQUEST_TEMPLATE.md` > 기본값
   - 프로젝트 고유의 템플릿 구조를 완전 준수

3. **라벨 제약**:
   - `.github/labels.yml`이 존재하면 우선 사용
   - 존재하지 않는 경우 GitHub API 에서 기존 라벨 취득
   - 새로운 라벨 생성은 금지
   - 최대 3 개까지 자동 선택

4. **안전한 업데이트**:
   - `--dry-run`으로 사전 확인 권장
   - 기밀 정보를 포함한 변경의 경우 경고 표시
   - 백업으로 원래 설명 저장

5. **일관성 유지**:
   - 프로젝트의 기존 PR 스타일에 맞춤
   - 언어(한국어/영어) 통일
   - 라벨링 규칙 계승

## 문제 해결

### 자주 발생하는 문제

1. **PR 을 찾을 수 없음**: 브랜치명과 PR 의 연관성 확인
2. **권한 오류**: GitHub CLI 의 인증 상태 확인
3. **라벨 설정 불가**: 리포지토리 권한 확인
4. **HTML 코멘트가 이스케이프됨**: GitHub CLI 사양으로 `<!-- -->`가 `&lt;!-- --&gt;`로 변환됨

### GitHub CLI 의 HTML 코멘트 이스케이프 문제

**중요**: GitHub CLI (`gh pr edit`)는 HTML 코멘트를 자동 이스케이프합니다. 또한 셸의 리다이렉트 처리에서 `EOF < /dev/null` 등의 부정한 문자열이 혼입되는 경우가 있습니다.

#### 근본적 해결책

1. **GitHub API 의 --field 옵션 사용**: `--field`를 사용하여 적절한 이스케이프 처리
2. **셸 처리 단순화**: 복잡한 리다이렉트나 파이프 처리 회피
3. **템플릿 처리 단순화**: HTML 코멘트 제거 처리를 폐지하고 완전 보존
4. **JSON 이스케이프의 적절한 처리**: 특수 문자를 올바르게 처리

### 디버그 옵션

```bash
# 상세 로그 출력 (구현 시 추가)
/pr-auto-update --verbose
```