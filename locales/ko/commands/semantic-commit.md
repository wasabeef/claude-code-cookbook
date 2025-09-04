## Semantic Commit

큰 변경사항을 의미 있는 최소 단위로 분할하여, 시맨틱한 커밋 메시지와 함께 순차적으로 커밋합니다. 외부 도구에 의존하지 않고 git 표준 명령어만 사용합니다.

### 사용법

```bash
/semantic-commit [옵션]
```

### 옵션

- `--dry-run` : 실제 커밋은 하지 않고, 제안되는 커밋 분할만 표시
- `--lang <언어>` : 커밋 메시지 언어를 강제 지정(en, ko)
- `--max-commits <수>` : 최대 커밋 수 지정(기본값: 10)

### 기본 예시

```bash
# 현재 변경사항을 분석해서 논리적 단위로 커밋
/semantic-commit

# 분할안만 확인 (실제 커밋 없음)
/semantic-commit --dry-run

# 영어로 커밋 메시지 생성
/semantic-commit --lang en

# 한국어로 커밋 메시지 생성
/semantic-commit --lang ko

# 최대 5 개 커밋으로 분할
/semantic-commit --max-commits 5
```

### 동작 플로

1. **변경 분석**: `git diff HEAD`로 전체 변경사항 취득
2. **파일 분류**: 변경된 파일을 논리적으로 그룹화
3. **커밋 제안**: 각 그룹에 대해 시맨틱한 커밋 메시지 생성
4. **순차 실행**: 사용자 확인 후 각 그룹을 순차적으로 커밋

### 변경 분할의 핵심 기능

#### "큰 변경사항" 탐지

다음 조건으로 큰 변경사항으로 탐지:

1. **변경 파일 수**: 5 개 이상의 파일 변경
2. **변경 라인 수**: 100 라인 이상의 변경
3. **복수 기능**: 2 개 이상의 기능 영역에 걸친 변경
4. **혼재 패턴**: feat + fix + docs 가 혼재

```bash
# 변경 규모 분석
CHANGED_FILES=$(git diff HEAD --name-only | wc -l)
CHANGED_LINES=$(git diff HEAD --stat | tail -1 | grep -o '[0-9]\+ insertions\|[0-9]\+ deletions' | awk '{sum+=$1} END {print sum}')

if [ $CHANGED_FILES -ge 5 ] || [ $CHANGED_LINES -ge 100 ]; then
  echo "큰 변경사항 탐지: 분할을 권장"
fi
```

#### "의미 있는 최소 단위"로의 분할 전략

##### 1. 기능 경계를 통한 분할

```bash
# 디렉터리 구조에서 기능 단위 특정
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq
# → src/auth, src/api, components/ui 등
```

##### 2. 변경 종별을 통한 분리

```bash
# 신규 파일 vs 기존 파일 수정
git diff HEAD --name-status | grep '^A' # 신규 파일
git diff HEAD --name-status | grep '^M' # 수정 파일
git diff HEAD --name-status | grep '^D' # 삭제 파일
```

##### 3. 의존 관계 분석

```bash
# 임포트 관계 변경 탐지
git diff HEAD | grep -E '^[+-].*import|^[+-].*require' | \
cut -d' ' -f2- | sort | uniq
```

#### 파일 단위의 상세 분석

```bash
# 변경된 파일 목록 취득
git diff HEAD --name-only

# 각 파일의 변경 내용을 개별 분석
git diff HEAD -- <file>

# 파일의 변경 타입 판정
git diff HEAD --name-status | while read status file; do
  case $status in
    A) echo "$file: 신규 생성" ;;
    M) echo "$file: 수정" ;;
    D) echo "$file: 삭제" ;;
    R*) echo "$file: 이름 변경" ;;
  esac
done
```

#### 논리적 그룹화 기준

1. **기능 단위**: 동일 기능 관련 파일
   - `src/auth/` 하위 파일 → 인증 기능
   - `components/` 하위 파일 → UI 컴포넌트

2. **변경 종별**: 같은 종류의 변경
   - 테스트 파일만 → `test:`
   - 문서만 → `docs:`
   - 설정 파일만 → `chore:`

3. **의존 관계**: 상호 관련 파일
   - 모델 + 마이그레이션
   - 컴포넌트 + 스타일

4. **변경 규모**: 적절한 커밋 크기 유지
   - 1 커밋당 10 파일 이하
   - 관련성 높은 파일 그룹화

### 출력 예시

```bash
$ /semantic-commit

변경 분석 중...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

탐지된 변경사항:
• src/auth/login.ts (수정)
• src/auth/register.ts (신규)
• src/auth/types.ts (수정)
• tests/auth.test.ts (신규)
• docs/authentication.md (신규)

제안되는 커밋 분할:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
커밋 1/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
메시지: feat: implement user registration and login system
포함되는 파일:
  • src/auth/login.ts
  • src/auth/register.ts
  • src/auth/types.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
커밋 2/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
메시지: test: add comprehensive tests for authentication system
포함되는 파일:
  • tests/auth.test.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
커밋 3/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
메시지: docs: add authentication system documentation
포함되는 파일:
  • docs/authentication.md

이 분할안으로 커밋을 실행하시겠습니까? (y/n/edit):
```

### 실행 시 선택지

- `y` : 제안된 커밋 분할로 실행
- `n` : 취소
- `edit` : 커밋 메시지를 개별 편집
- `merge <번호 1> <번호 2>` : 지정한 커밋을 합치기
- `split <번호>` : 지정한 커밋을 더 분할

### Dry Run 모드

```bash
$ /semantic-commit --dry-run

변경 분석 중... (DRY RUN)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[커밋 분할 제안 표시]

ℹ️  DRY RUN 모드: 실제 커밋은 실행되지 않습니다
💡 실행하려면 --dry-run 옵션을 제거하고 다시 실행하세요
```

### 스마트 분석 기능

#### 1. 프로젝트 구조 이해

- `package.json`, `Cargo.toml`, `pom.xml` 등에서 프로젝트 종류 판정
- 폴더 구조에서 기능 단위 추측

#### 2. 변경 패턴 인식

```bash
# 버그 수정 패턴 탐지
- "fix", "bug", "error" 등의 키워드
- 예외 처리 추가
- 조건 분기 수정

# 새 기능 패턴 탐지
- 새 파일 생성
- 새 메서드 추가
- API 엔드포인트 추가
```

#### 3. 의존 관계 분석

- import 문의 변경
- 타입 정의 추가/수정
- 설정 파일과의 연관성

### 기술적 구현

#### Git 표준 명령어를 통한 순차 커밋 구현

##### 1. 전처리: 현재 상태 저장

```bash
# 스테이징되지 않은 변경사항이 있으면 일단 리셋
git reset HEAD
git status --porcelain > /tmp/original_state.txt

# 작업 브랜치 확인
CURRENT_BRANCH=$(git branch --show-current)
echo "작업 중인 브랜치: $CURRENT_BRANCH"
```

##### 2. 그룹별 순차 커밋 실행

```bash
# 분할 계획 읽기
while IFS= read -r commit_plan; do
  group_num=$(echo "$commit_plan" | cut -d':' -f1)
  files=$(echo "$commit_plan" | cut -d':' -f2- | tr ' ' '\n')

  echo "=== 커밋 $group_num 실행 ==="

  # 해당 파일만 스테이징
  echo "$files" | while read file; do
    if [ -f "$file" ]; then
      git add "$file"
      echo "스테이징: $file"
    fi
  done

  # 스테이징 상태 확인
  staged_files=$(git diff --staged --name-only)
  if [ -z "$staged_files" ]; then
    echo "경고: 스테이징된 파일이 없습니다"
    continue
  fi

  # 커밋 메시지 생성 (LLM 분석)
  commit_msg=$(generate_commit_message_for_staged_files)

  # 사용자 확인
  echo "제안 커밋 메시지: $commit_msg"
  echo "스테이징된 파일:"
  echo "$staged_files"
  read -p "이 커밋을 실행하시겠습니까? (y/n): " confirm

  if [ "$confirm" = "y" ]; then
    # 커밋 실행
    git commit -m "$commit_msg"
    echo "✅ 커밋 $group_num 완료"
  else
    # 스테이징 취소
    git reset HEAD
    echo "❌ 커밋 $group_num 건너뛰기"
  fi

done < /tmp/commit_plan.txt
```

##### 3. 에러 처리와 롤백

```bash
# 프리커밋 훅 실패 시 처리
commit_with_retry() {
  local commit_msg="$1"
  local max_retries=2
  local retry_count=0

  while [ $retry_count -lt $max_retries ]; do
    if git commit -m "$commit_msg"; then
      echo "✅ 커밋 성공"
      return 0
    else
      echo "❌ 커밋 실패 (시도 $((retry_count + 1))/$max_retries)"

      # 프리커밋 훅의 자동 수정 적용
      if git diff --staged --quiet; then
        echo "프리커밋 훅이 변경사항을 자동 수정했습니다"
        git add -u
      fi

      retry_count=$((retry_count + 1))
    fi
  done

  echo "❌ 커밋에 실패했습니다. 수동으로 확인하세요."
  return 1
}

# 중단에서 복구
resume_from_failure() {
  echo "중단된 커밋 처리를 감지했습니다"
  echo "현재 스테이징 상태:"
  git status --porcelain

  read -p "처리를 계속하시겠습니까? (y/n): " resume
  if [ "$resume" = "y" ]; then
    # 마지막 커밋 위치에서 재개
    last_commit=$(git log --oneline -1 --pretty=format:"%s")
    echo "마지막 커밋: $last_commit"
  else
    # 완전 리셋
    git reset HEAD
    echo "처리를 리셋했습니다"
  fi
}
```

##### 4. 완료 후 검증

```bash
# 모든 변경사항이 커밋되었는지 확인
remaining_changes=$(git status --porcelain | wc -l)
if [ $remaining_changes -eq 0 ]; then
  echo "✅ 모든 변경사항이 커밋되었습니다"
else
  echo "⚠️  커밋되지 않은 변경사항이 남아있습니다:"
  git status --short
fi

# 커밋 이력 표시
echo "생성된 커밋:"
git log --oneline -n 10 --graph
```

##### 5. 자동 푸시 억제

```bash
# 주의: 자동 푸시는 하지 않음
echo "📝 주의: 자동 푸시는 실행되지 않습니다"
echo "필요시 다음 명령어로 푸시하세요:"
echo "  git push origin $CURRENT_BRANCH"
```

#### 분할 알고리즘 상세

##### 단계 1: 초기 분석

```bash
# 모든 변경 파일 취득 및 분류
git diff HEAD --name-status | while read status file; do
  echo "$status:$file"
done > /tmp/changes.txt

# 기능 디렉터리별 변경 통계
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq -c
```

##### 단계 2: 기능 경계를 통한 초기 그룹화

```bash
# 디렉터리 기반 그룹화
GROUPS=$(git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq)
for group in $GROUPS; do
  echo "=== 그룹: $group ==="
  git diff HEAD --name-only | grep "^$group" | head -10
done
```

##### 단계 3: 변경 내용의 유사성 분석

```bash
# 각 파일의 변경 타입 분석
git diff HEAD --name-only | while read file; do
  # 새 함수/클래스 추가 탐지
  NEW_FUNCTIONS=$(git diff HEAD -- "$file" | grep -c '^+.*function\|^+.*class\|^+.*def ')

  # 버그 수정 패턴 탐지
  BUG_FIXES=$(git diff HEAD -- "$file" | grep -c '^+.*fix\|^+.*bug\|^-.*error')

  # 테스트 파일 판정
  if [[ "$file" =~ test|spec ]]; then
    echo "$file: TEST"
  elif [ $NEW_FUNCTIONS -gt 0 ]; then
    echo "$file: FEAT"
  elif [ $BUG_FIXES -gt 0 ]; then
    echo "$file: FIX"
  else
    echo "$file: REFACTOR"
  fi
done
```

##### 단계 4: 의존 관계를 통한 조정

```bash
# import 관계 분석
git diff HEAD | grep -E '^[+-].*import|^[+-].*from.*import' | \
while read line; do
  echo "$line" | sed 's/^[+-]//' | awk '{print $2}'
done | sort | uniq > /tmp/imports.txt

# 관련 파일 그룹화
git diff HEAD --name-only | while read file; do
  basename=$(basename "$file" .js .ts .py)
  related=$(git diff HEAD --name-only | grep "$basename" | grep -v "^$file$")
  if [ -n "$related" ]; then
    echo "관련 파일 그룹: $file <-> $related"
  fi
done
```

##### 단계 5: 커밋 크기 최적화

```bash
# 그룹 크기 조정
MAX_FILES_PER_COMMIT=8
current_group=1
file_count=0

git diff HEAD --name-only | while read file; do
  if [ $file_count -ge $MAX_FILES_PER_COMMIT ]; then
    current_group=$((current_group + 1))
    file_count=0
  fi
  echo "커밋 $current_group: $file"
  file_count=$((file_count + 1))
done
```

##### 단계 6: 최종 그룹 결정

```bash
# 분할 결과 검증
for group in $(seq 1 $current_group); do
  files=$(grep "커밋 $group:" /tmp/commit_plan.txt | cut -d':' -f2-)
  lines=$(echo "$files" | xargs git diff HEAD -- | wc -l)
  echo "커밋 $group: $(echo "$files" | wc -w) 파일, $lines 라인 변경"
done
```

### Conventional Commits 준수

#### 기본 형식

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### 표준 타입

**필수 타입**:

- `feat`: 새 기능 (사용자에게 보이는 기능 추가)
- `fix`: 버그 수정

**선택적 타입**:

- `build`: 빌드 시스템이나 외부 의존관계 변경
- `chore`: 기타 변경사항 (릴리즈에 영향하지 않음)
- `ci`: CI 설정 파일이나 스크립트 변경
- `docs`: 문서만의 변경
- `style`: 코드 의미에 영향하지 않는 변경 (공백, 포맷, 세미콜론 등)
- `refactor`: 버그 수정이나 기능 추가를 동반하지 않는 코드 변경
- `perf`: 성능 개선
- `test`: 테스트 추가나 수정

#### 스코프 (선택적)

변경의 영향 범위 표시:

```
feat(api): add user authentication endpoint
fix(ui): resolve button alignment issue
docs(readme): update installation instructions
```

#### Breaking Change

API 의 파괴적 변경이 있는 경우:

```
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

또는

```
feat(api)!: change authentication flow
```

#### 프로젝트 규약의 자동 감지

**중요**: 프로젝트 고유 규약이 존재하면 그것을 우선합니다.

##### 1. CommitLint 설정 확인

다음 파일에서 설정을 자동 감지:

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- `package.json`의 `commitlint` 섹션

```bash
# 설정 파일 예시 확인
cat commitlint.config.mjs
cat .commitlintrc.json
grep -A 10 '"commitlint"' package.json
```

##### 2. 커스텀 타입 감지

프로젝트 고유 타입 예시:

```javascript
// commitlint.config.mjs
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "test",
        "chore",
        "wip", // 작업 중
        "hotfix", // 긴급 수정
        "release", // 릴리즈
        "deps", // 의존성 업데이트
        "config", // 설정 변경
      ],
    ],
  },
};
```

##### 3. 언어 설정 감지

```javascript
// 프로젝트가 한국어 메시지를 사용하는 경우
export default {
  rules: {
    "subject-case": [0], // 한국어 대응을 위해 비활성화
    "subject-max-length": [2, "always", 72], // 한국어는 문자 수 제한 조정
  },
};
```

#### 자동 분석 흐름

1. **설정 파일 검색**

   ```bash
   find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
   ```

2. **기존 커밋 분석**

   ```bash
   git log --oneline -50 --pretty=format:"%s"
   ```

3. **사용 타입 통계**

   ```bash
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

#### 프로젝트 규약 예시

##### Angular 스타일

```
feat(scope): add new feature
fix(scope): fix bug
docs(scope): update documentation
```

##### Gitmoji 병용 스타일

```
✨ feat: add user registration
🐛 fix: resolve login issue
📚 docs: update API docs
```

##### 한국어 프로젝트

```
feat: 사용자 등록 기능 추가
fix: 로그인 처리 버그 수정
docs: API 문서 업데이트
```

### 언어 판정

이 명령어에서 완결되는 언어 판정 로직:

1. **CommitLint 설정**에서 언어 설정 확인

   ```bash
   # subject-case 규칙이 비활성화되면 한국어로 판정
   grep -E '"subject-case".*\[0\]|subject-case.*0' commitlint.config.*
   ```

2. **git log 분석**을 통한 자동 판정

   ```bash
   # 최근 20 개 커밋의 언어 분석
   git log --oneline -20 --pretty=format:"%s" | \
   grep -E '^[가-힣]' | wc -l
   # 50% 이상이 한국어면 한국어 모드
   ```

3. **프로젝트 파일**의 언어 설정

   ```bash
   # README.md 언어 확인
   head -10 README.md | grep -E '[가-힣]' | wc -l

   # package.json 의 description 확인
   grep -E '"description".*[가-힣]' package.json
   ```

4. **변경 파일 내** 주석·문자열 분석

   ```bash
   # 변경된 파일의 주석 언어 확인
   git diff HEAD | grep -E '^[+-].*//.*[가-힣]' | wc -l
   ```

#### 판정 알고리즘

```bash
# 언어 판정 점수 계산
KOREAN_SCORE=0

# 1. CommitLint 설정 (+3 점)
if grep -q '"subject-case".*\[0\]' commitlint.config.* 2>/dev/null; then
  KOREAN_SCORE=$((KOREAN_SCORE + 3))
fi

# 2. git log 분석 (최대 +2 점)
KOREAN_COMMITS=$(git log --oneline -20 --pretty=format:"%s" | \
  grep -cE '[가-힣]' 2>/dev/null || echo 0)
if [ $KOREAN_COMMITS -gt 10 ]; then
  KOREAN_SCORE=$((KOREAN_SCORE + 2))
elif [ $KOREAN_COMMITS -gt 5 ]; then
  KOREAN_SCORE=$((KOREAN_SCORE + 1))
fi

# 3. README.md 확인 (+1 점)
if head -5 README.md 2>/dev/null | grep -qE '[가-힣]'; then
  KOREAN_SCORE=$((KOREAN_SCORE + 1))
fi

# 4. 변경 파일 내용 확인 (+1 점)
if git diff HEAD 2>/dev/null | grep -qE '^[+-].*[가-힣]'; then
  KOREAN_SCORE=$((KOREAN_SCORE + 1))
fi

# 판정: 3 점 이상이면 한국어 모드
if [ $KOREAN_SCORE -ge 3 ]; then
  LANGUAGE="ko"
else
  LANGUAGE="en"
fi
```

### 설정 파일 자동 읽기

#### 실행 시 동작

명령어 실행 시 다음 순서로 설정 확인:

1. **CommitLint 설정 파일 검색**

   ```bash
   # 다음 순서로 검색하여 처음 찾은 파일 사용
   commitlint.config.mjs
   commitlint.config.js
   commitlint.config.cjs
   commitlint.config.ts
   .commitlintrc.js
   .commitlintrc.json
   .commitlintrc.yml
   .commitlintrc.yaml
   package.json (commitlint 섹션)
   ```

2. **설정 내용 분석**
   - 사용 가능한 타입 목록 추출
   - 스코프 제한 확인
   - 메시지 길이 제한 취득
   - 언어 설정 확인

3. **기존 커밋 이력 분석**

   ```bash
   # 최근 커밋에서 사용 패턴 학습
   git log --oneline -100 --pretty=format:"%s" | \
   head -20
   ```

#### 설정 예시 분석

**표준 commitlint.config.mjs**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "perf", "test", "chore"],
    ],
    "scope-enum": [2, "always", ["api", "ui", "core", "auth", "db"]],
  },
};
```

**한국어 대응 설정**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "subject-case": [0], // 한국어를 위해 비활성화
    "subject-max-length": [2, "always", 72],
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "test", "chore"],
    ],
  },
};
```

**커스텀 타입 포함 설정**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "test",
        "chore",
        "wip", // Work in Progress
        "hotfix", // 긴급 수정
        "release", // 릴리즈 준비
        "deps", // 의존성 업데이트
        "config", // 설정 변경
      ],
    ],
  },
};
```

#### 폴백 동작

설정 파일을 찾을 수 없는 경우:

1. **git log 분석**을 통한 자동 추측

   ```bash
   # 최근 100 개 커밋에서 타입 추출
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

2. **Conventional Commits 표준**을 기본 사용

   ```
   feat, fix, docs, style, refactor, perf, test, chore, build, ci
   ```

3. **언어 판정**
   - 한국어 커밋이 50% 이상 → 한국어 모드
   - 그 외 → 영어 모드

### 전제 조건

- Git 저장소 내에서 실행
- 커밋되지 않은 변경사항이 존재할 것
- 스테이징된 변경사항은 일시적으로 리셋됩니다

### 주의사항

- **자동 푸시 없음**: 커밋 후 `git push`는 수동 실행
- **브랜치 생성 없음**: 현재 브랜치에서 커밋
- **백업 권장**: 중요한 변경 전에는 `git stash`로 백업

### 프로젝트 규약의 우선순위

커밋 메시지 생성 시 우선순위:

1. **CommitLint 설정** (최우선)
   - `commitlint.config.*` 파일 설정
   - 커스텀 타입이나 스코프 제한
   - 메시지 길이나 케이스 제한

2. **기존 커밋 이력** (2 순위)
   - 실제 사용된 타입 통계
   - 메시지 언어(한국어/영어)
   - 스코프 사용 패턴

3. **프로젝트 종류** (3 순위)
   - `package.json` → Node.js 프로젝트
   - `Cargo.toml` → Rust 프로젝트
   - `pom.xml` → Java 프로젝트

4. **Conventional Commits 표준** (폴백)
   - 설정을 찾을 수 없는 경우의 표준 동작

#### 규약 감지 실례

**Monorepo 에서 scope 자동 감지**:

```bash
# packages/ 폴더에서 scope 추측
ls packages/ | head -10
# → api, ui, core, auth 등을 scope 로 제안
```

**프레임워크별 규약**:

```javascript
// Angular 프로젝트
{
  'scope-enum': [2, 'always', [
    'animations', 'common', 'core', 'forms', 'http', 'platform-browser',
    'platform-server', 'router', 'service-worker', 'upgrade'
  ]]
}

// React 프로젝트
{
  'scope-enum': [2, 'always', [
    'components', 'hooks', 'utils', 'types', 'styles', 'api'
  ]]
}
```

**기업·팀 고유 규약**:

```javascript
// 한국 기업에서 자주 보이는 패턴
{
  'type-enum': [2, 'always', [
    'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
    'wip',      // 작업 중(풀 리퀘스트용)
    'hotfix',   // 긴급 수정
    'release'   // 릴리즈 준비
  ]],
  'subject-case': [0],  // 한국어 대응
  'subject-max-length': [2, 'always', 72]  // 한국어는 길게 설정
}
```

### 베스트 프랙티스

1. **프로젝트 규약 준수**: 기존 설정이나 패턴을 따름
2. **작은 변경 단위**: 1 개 커밋은 1 개의 논리적 변경
3. **명확한 메시지**: 무엇을 변경했는지가 명확
4. **관련성 중시**: 기능적으로 관련된 파일을 그룹화
5. **테스트 분리**: 테스트 파일은 별도 커밋으로
6. **설정 파일 활용**: CommitLint 를 도입해 팀 전체 규약 통일

### 실제 분할 예시(Before/After)

#### 예시 1: 대규모 인증 시스템 추가

**Before(하나의 거대한 커밋):**

```bash
# 변경된 파일(15 개 파일, 850 라인 변경)
src/auth/login.js          # 신규 생성
src/auth/register.js       # 신규 생성
src/auth/password.js       # 신규 생성
src/auth/types.js          # 신규 생성
src/api/auth-routes.js     # 신규 생성
src/middleware/auth.js     # 신규 생성
src/database/migrations/001_users.sql  # 신규 생성
src/database/models/user.js            # 신규 생성
tests/auth/login.test.js   # 신규 생성
tests/auth/register.test.js # 신규 생성
tests/api/auth-routes.test.js # 신규 생성
docs/authentication.md    # 신규 생성
package.json              # 의존성 추가
README.md                 # 사용법 추가
.env.example             # 환경변수 예시 추가

# 기존의 문제 있는 커밋
feat: implement complete user authentication system with login, registration, password reset, API routes, database models, tests and documentation
```

**After(의미 있는 5 개 커밋으로 분할):**

```bash
# 커밋 1: 데이터베이스 기반
feat(db): add user model and authentication schema

포함 파일:
- src/database/migrations/001_users.sql
- src/database/models/user.js
- src/auth/types.js

이유: 데이터베이스 구조는 다른 기능의 기반이므로 먼저 커밋

# 커밋 2: 인증 로직
feat(auth): implement core authentication functionality

포함 파일:
- src/auth/login.js
- src/auth/register.js
- src/auth/password.js
- src/middleware/auth.js

이유: 인증의 핵심 비즈니스 로직을 한 번에 커밋

# 커밋 3: API 엔드포인트
feat(api): add authentication API routes

포함 파일:
- src/api/auth-routes.js

이유: API 레이어는 인증 로직에 의존하므로 뒤에 커밋

# 커밋 4: 포괄적 테스트
test(auth): add comprehensive authentication tests

포함 파일:
- tests/auth/login.test.js
- tests/auth/register.test.js
- tests/api/auth-routes.test.js

이유: 구현 완료 후 테스트를 일괄 추가

# 커밋 5: 설정과 문서
docs(auth): add authentication documentation and configuration

포함 파일:
- docs/authentication.md
- package.json
- README.md
- .env.example

이유: 문서와 설정은 마지막에 함께 커밋
```

#### 예시 2: 버그 수정과 리팩터링 혼재

**Before(혼재된 문제 있는 커밋):**

```bash
# 변경된 파일(8 개 파일, 320 라인 변경)
src/user/service.js       # 버그 수정 + 리팩터링
src/user/validator.js     # 신규 생성(리팩터링)
src/auth/middleware.js    # 버그 수정
src/api/user-routes.js    # 버그 수정 + 에러 처리 개선
tests/user.test.js        # 테스트 추가
tests/auth.test.js        # 버그 수정 테스트 추가
docs/user-api.md          # 문서 업데이트
package.json              # 의존성 업데이트

# 문제 있는 커밋
fix: resolve user validation bugs and refactor validation logic with improved error handling
```

**After(종류별로 3 개 커밋으로 분할):**

```bash
# 커밋 1: 긴급 버그 수정
fix: resolve user validation and authentication bugs

포함 파일:
- src/user/service.js(버그 수정 부분만)
- src/auth/middleware.js
- tests/auth.test.js(버그 수정 테스트만)

이유: 프로덕션 환경에 영향을 주는 버그는 최우선 수정

# 커밋 2: 검증 로직 리팩터링
refactor: extract and improve user validation logic

포함 파일:
- src/user/service.js(리팩터링 부분)
- src/user/validator.js
- src/api/user-routes.js
- tests/user.test.js

이유: 구조 개선은 기능 단위로 함께 커밋

# 커밋 3: 문서와 의존성 업데이트
chore: update documentation and dependencies

포함 파일:
- docs/user-api.md
- package.json

이유: 개발 환경 정비는 마지막에 함께 커밋
```

#### 예시 3: 여러 기능 동시 개발

**Before(기능 횡단 거대 커밋):**

```bash
# 변경된 파일(12 개 파일, 600 라인 변경)
src/user/profile.js       # 새 기능 A
src/user/avatar.js        # 새 기능 A
src/notification/email.js # 새 기능 B
src/notification/sms.js   # 새 기능 B
src/api/profile-routes.js # 새 기능 A 용 API
src/api/notification-routes.js # 새 기능 B 용 API
src/dashboard/widgets.js  # 새 기능 C
src/dashboard/charts.js   # 새 기능 C
tests/profile.test.js     # 새 기능 A 용 테스트
tests/notification.test.js # 새 기능 B 용 테스트
tests/dashboard.test.js   # 새 기능 C 용 테스트
package.json              # 전체 기능 의존성

# 문제 있는 커밋
feat: add user profile management, notification system and dashboard widgets
```

**After(기능별로 4 개 커밋으로 분할):**

```bash
# 커밋 1: 사용자 프로필 기능
feat(profile): add user profile management

포함 파일:
- src/user/profile.js
- src/user/avatar.js
- src/api/profile-routes.js
- tests/profile.test.js

이유: 프로필 기능은 독립된 기능 단위

# 커밋 2: 알림 시스템
feat(notification): implement email and SMS notifications

포함 파일:
- src/notification/email.js
- src/notification/sms.js
- src/api/notification-routes.js
- tests/notification.test.js

이유: 알림 기능은 독립된 기능 단위

# 커밋 3: 대시보드 위젯
feat(dashboard): add interactive widgets and charts

포함 파일:
- src/dashboard/widgets.js
- src/dashboard/charts.js
- tests/dashboard.test.js

이유: 대시보드 기능은 독립된 기능 단위

# 커밋 4: 의존성과 인프라 업데이트
chore: update dependencies for new features

포함 파일:
- package.json

이유: 공통 의존성 업데이트는 마지막에 함께
```

### 분할 효과 비교

| 항목          | Before(거대 커밋)        | After(적절한 분할)             |
| ------------- | ------------------------ | ------------------------------ |
| **리뷰성**    | ❌ 매우 어려움           | ✅ 각 커밋이 작아 리뷰 가능    |
| **버그 추적** | ❌ 문제 위치 파악 어려움 | ✅ 문제 있는 커밋 즉시 파악    |
| **되돌리기**  | ❌ 전체를 되돌려야 함    | ✅ 문제 부분만 선택적 되돌리기 |
| **병렬 개발** | ❌ 충돌 발생 쉬움        | ✅ 기능별로 병합 용이          |
| **배포**      | ❌ 전체 기능 일괄 배포   | ✅ 단계적 배포 가능            |

### 트러블슈팅

#### 커밋 실패 시

- 프리커밋 훅 확인
- 의존성 해결
- 개별 파일로 재시도

#### 분할이 적절하지 않은 경우

- `--max-commits` 옵션으로 조정
- 수동 `edit` 모드 사용
- 더 세밀한 단위로 재실행
