## Commit Message

스테이징된 변경사항（git diff --staged）에서 적절한 커밋 메시지를 생성합니다. git 명령은 실행하지 않고, 메시지 생성과 클립보드 복사만 수행합니다.

### 사용법

```bash
/commit-message [옵션]
```

### 옵션

- `--format <형식>` : 메시지 형식 지정（conventional, gitmoji, angular）
- `--lang <언어>` : 메시지 언어 강제 지정（en, ja, ko）
- `--breaking` : Breaking Change 감지 및 표시

### 기본 예제

```bash
# 스테이징된 변경사항을 기반으로 메시지 생성（언어 자동 판별）
# 메인 후보가 자동으로 클립보드에 복사됩니다
/commit-message

# 언어를 강제로 지정
/commit-message --lang ko
/commit-message --lang en

# Breaking Change 감지
/commit-message --breaking
```

### 전제 조건

**중요**: 이 명령어는 스테이징된 변경사항만 분석합니다. 먼저 `git add`로 변경사항을 스테이징해야 합니다.

```bash
# 스테이징되지 않은 경우 경고가 표시됩니다
$ /commit-message
스테이징된 변경사항이 없습니다. 먼저 git add 를 실행하세요.
```

### 자동 클립보드 기능

생성된 메인 후보는 `git commit -m "메시지"`의 완전한 형태로 자동으로 클립보드에 복사됩니다. 터미널에서 바로 붙여넣기해서 실행할 수 있습니다.

**구현 시 주의사항**:

- 커밋 명령을 `pbcopy`에 전달할 때는 메시지 출력과는 별도 프로세스로 실행할 것
- `echo` 대신 `printf`를 사용해서 끝의 개행을 피할 것

### 프로젝트 규약 자동 감지

**중요**: 프로젝트별 규약이 있으면 그것을 우선 적용합니다.

#### 1. CommitLint 설정 확인

다음 파일에서 설정을 자동 감지：

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
# 설정 파일 검색
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

#### 2. 커스텀 타입 감지

프로젝트별 타입 예시：

```javascript
// commitlint.config.mjs
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
        'wip',      // 작업중
        'hotfix',   // 긴급 수정
        'release',  // 릴리스
        'deps',     // 의존성 업데이트
        'config'    // 설정 변경
      ]
    ]
  }
}
```

#### 3. 언어 설정 감지

```javascript
// 프로젝트가 한국어 메시지를 사용하는 경우
export default {
  rules: {
    'subject-case': [0],  // 한국어 대응을 위해 비활성화
    'subject-max-length': [2, 'always', 72]  // 한국어는 글자수 제한 조정
  }
}
```

#### 4. 기존 커밋 히스토리 분석

```bash
# 최근 커밋에서 사용 패턴 학습
git log --oneline -50 --pretty=format:"%s"

# 사용 타입 통계
git log --oneline -100 --pretty=format:"%s" | \
grep -oE '^[a-z]+(\([^)]+\))?' | \
sort | uniq -c | sort -nr
```

### 언어 자동 판별

다음 조건으로 자동으로 한국어/영어를 전환합니다：

1. **CommitLint 설정**에서 언어 설정 확인
2. **git log 분석**을 통한 자동 판별
3. **프로젝트 파일**의 언어 설정
4. **변경 파일 내**의 주석・문자열 분석

기본값은 영어. 한국어 프로젝트로 판별되면 한국어로 생성.

### 메시지 형식

#### Conventional Commits (기본값)

```
<type>: <description>
```

**중요**: 항상 1 줄 커밋 메시지를 생성합니다. 여러 줄 메시지는 생성하지 않습니다.

**주의**: 프로젝트별 규약이 있으면 그것을 우선합니다.

### 표준 타입

**필수 타입**:

- `feat`: 새로운 기능（사용자가 볼 수 있는 기능 추가）
- `fix`: 버그 수정

**선택 타입**:

- `build`: 빌드 시스템이나 외부 의존성 변경
- `chore`: 기타 변경사항（릴리스에 영향 없음）
- `ci`: CI 설정 파일이나 스크립트 변경
- `docs`: 문서만 변경
- `style`: 코드 의미에 영향 없는 변경（공백, 포맷, 세미콜론 등）
- `refactor`: 버그 수정이나 기능 추가 없는 코드 변경
- `perf`: 성능 개선
- `test`: 테스트 추가나 수정

### 출력 예시（영어 프로젝트）

```bash
$ /commit-message

📝 커밋 메시지 제안
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 메인 후보:
feat: implement JWT-based authentication system

📋 대안:
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. refactor: extract auth logic into separate module

✅ `git commit -m "feat: implement JWT-based authentication system"` 클립보드에 복사됨
```

**구현 예시（수정판）**:

```bash
# 커밋 명령을 먼저 클립보드에 복사（개행 없이）
printf 'git commit -m "%s"' "$COMMIT_MESSAGE" | pbcopy

# 그 다음 메시지 표시
cat << EOF
📝 커밋 메시지 제안
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 메인 후보:
$COMMIT_MESSAGE

📋 대안:
1. ...
2. ...
3. ...

✅ \`git commit -m "$COMMIT_MESSAGE"\` 클립보드에 복사됨
EOF
```

### 출력 예시（한국어 프로젝트）

```bash
$ /commit-message

📝 커밋 메시지 제안
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 메인 후보:
feat: JWT 인증 시스템 구현

📋 대안:
1. feat: JWT 토큰으로 사용자 인증 추가
2. fix: 인증 미들웨어 토큰 검증 오류 해결
3. docs: 인증 로직을 별도 모듈로 분리

✅ `git commit -m "feat: JWT 인증 시스템 구현"` 클립보드에 복사됨
```

### 동작 개요

1. **분석**: `git diff --staged`의 내용 분석
2. **생성**: 적절한 커밋 메시지 생성
3. **복사**: 메인 후보를 자동으로 클립보드에 복사

**주의**: 이 명령어는 git add 나 git commit 을 실행하지 않습니다. 커밋 메시지 생성과 클립보드 복사만 수행합니다.

### 스마트 기능

#### 1. 변경 내용 자동 분류（스테이징된 파일만）

- 새 파일 추가 → `feat`
- 에러 수정 패턴 → `fix`
- 테스트 파일만 → `test`
- 설정 파일 변경 → `chore`
- README/docs 업데이트 → `docs`

#### 2. 프로젝트 규약 자동 감지

- `.gitmessage` 파일
- `CONTRIBUTING.md` 내의 규약
- 과거 커밋 히스토리 패턴

#### 3. 언어 판별 상세（스테이징된 변경사항만）

```bash
# 판별 기준（우선순위）
1. git diff --staged 의 내용에서 언어 판별
2. 스테이징된 파일의 주석 분석
3. git log --oneline -20 의 언어 분석
4. 프로젝트의 메인 언어 설정
```

#### 4. 스테이징 분석 상세

분석에 사용하는 정보（읽기 전용）:

- `git diff --staged --name-only` - 변경 파일 목록
- `git diff --staged` - 실제 변경 내용
- `git status --porcelain` - 파일 상태

### Breaking Change 감지 시

API 의 파괴적 변경이 있는 경우：

**영어**:

```bash
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

또는

```bash
feat(api)!: change authentication flow
```

**한국어**:

```bash
feat!: 사용자 API 응답 형식 변경

BREAKING CHANGE: 응답에 추가 메타데이터가 포함되도록 변경됨
```

또는

```bash
feat(api)!: 인증 플로우 변경
```

### 베스트 프랙티스

1. **프로젝트에 맞추기**: 기존 커밋 언어를 따름
2. **간결성**: 50 자 이내로 명확하게
3. **일관성**: 언어를 섞지 않음（영어면 영어로 통일）
4. **OSS**: 오픈소스라면 영어 권장
5. **1 줄 엄수**: 항상 1 줄 커밋 메시지로 작성（자세한 설명이 필요하면 PR 에서 보충）

### 자주 쓰는 패턴

**영어**:

```
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

**한국어**:

```
feat: 사용자 등록 엔드포인트 추가
fix: 캐시 매니저 메모리 누수 해결
docs: API 문서 업데이트
```

### Claude 와의 연계

```bash
# 스테이징된 변경사항과 함께 사용
git add -p  # 인터랙티브하게 스테이징
/commit-message
"최적의 커밋 메시지를 생성해줘"

# 특정 파일만 스테이징해서 분석
git add src/auth/*.js
/commit-message --lang en
"인증 관련 변경에 적합한 메시지를 생성해줘"

# Breaking Change 감지와 대응
git add -A
/commit-message --breaking
"파괴적 변경이 있으면 적절히 마킹해줘"
```

### 주의사항

- **전제조건**: 변경사항은 먼저 `git add`로 스테이징되어야 합니다
- **제한사항**: 스테이징되지 않은 변경사항은 분석 대상이 아닙니다
- **권장사항**: 프로젝트의 기존 커밋 규약을 먼저 확인하세요
