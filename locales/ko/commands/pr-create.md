## PR 생성

Git 변경 분석기반의 자동 PR 생성으로 효율적인 Pull Request 워크플로를 실현합니다.

### 사용법

```bash
# 변경 분석을 통한 자동 PR 생성
git add . && git commit -m "feat: 사용자 인증 기능 구현"
"변경 내용을 분석해서 적절한 설명문과 라벨로 Draft PR 을 생성하세요"

# 기존 템플릿 유지하며 업데이트
cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
"템플릿 구조를 완전히 유지하고 변경 내용을 보완하세요"

# 단계적 품질 향상
gh pr ready
"품질 확인 완료 후 Ready for Review 로 변경하세요"
```

### 기본 예시

```bash
# 1. 브랜치 생성과 커밋
git checkout main && git pull
git checkout -b feat-user-profile
git add . && git commit -m "feat: 사용자 프로필 기능 구현"
git push -u origin feat-user-profile

# 2. PR 생성
"다음 순서로 PR 을 생성해주세요:
1. git diff --cached 로 변경 내용을 확인
2. .github/PULL_REQUEST_TEMPLATE.md 를 사용해서 설명문 작성
3. 변경 내용에서 적절한 라벨을 최대 3 개 선택
4. Draft PR 로 생성 (HTML 코멘트 유지)"

# 3. CI 확인 후 Ready 화
"CI 가 통과하면 PR 을 Ready for Review 로 변경하세요"
```

### 실행 절차

#### 1. 브랜치 생성

```bash
# 가이드라인을 준수한 네이밍 규칙: {type}-{subject}
git checkout main
git pull
git checkout -b feat-user-authentication

# 브랜치 확인 (현재 브랜치명 표시)
git branch --show-current
```

#### 2. 커밋

```bash
# 변경사항 스테이징
git add .

# 가이드라인을 준수한 커밋 메시지
git commit -m "feat: 사용자 인증 API 구현"
```

#### 3. 리모트에 Push

```bash
# 첫 번째 Push (upstream 설정)
git push -u origin feat-user-authentication

# 두 번째부터
git push
```

#### 4. 자동 분석을 통한 Draft PR 생성

**Step 1: 변경 내용 분석**

```bash
# 파일 변경 사항 취득 (스테이지된 변경 확인)
git diff --cached --name-only

# 내용 분석 (최대 1000 행)
git diff --cached | head -1000
```

**Step 2: 설명문 자동 생성**

```bash
# 템플릿 처리 우선순위
# 1. 기존 PR 설명 (완전 보존)
# 2. .github/PULL_REQUEST_TEMPLATE.md
# 3. 기본 템플릿

cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
# HTML 코멘트·구분선을 유지하며 빈 섹션만 보완
```

**Step 3: 라벨 자동 선택**

```bash
# 사용 가능한 라벨 취득 (비대화형)
".github/labels.yml 또는 GitHub 저장소에서 사용 가능한 라벨을 취득해서, 변경 내용에 기반해 적절한 라벨을 자동 선택하세요"

# 패턴 매칭을 통한 자동 선택 (최대 3 개)
# - 문서: *.md, docs/ → documentation|docs
# - 테스트: test, spec → test|testing
# - 버그 수정: fix|bug → bug|fix
# - 새 기능: feat|feature → feature|enhancement
```

**Step 4: GitHub API 로 PR 생성 (HTML 코멘트 유지)**

```bash
# PR 생성
"다음 정보로 Draft PR 을 생성해주세요:
- 제목: 커밋 메시지에서 자동 생성
- 설명문: .github/PULL_REQUEST_TEMPLATE.md 를 사용해서 적절히 작성
- 라벨: 변경 내용에서 자동 선택 (최대 3 개)
- 기본 브랜치: main
- HTML 코멘트는 완전히 보존"
```

**방법 B: GitHub MCP (폴백)**

```javascript
// HTML 코멘트 유지하며 PR 생성
mcp_github_create_pull_request({
  owner: 'organization',
  repo: 'repository',
  base: 'main',
  head: 'feat-user-authentication',
  title: 'feat: 사용자 인증 구현',
  body: prBodyContent, // HTML 코멘트를 포함한 전체 내용
  draft: true,
  maintainer_can_modify: true,
});
```

### 자동 라벨 선택 시스템

#### 파일 패턴 기반 판정

- **문서**: `*.md`, `README`, `docs/` → `documentation|docs|doc`
- **테스트**: `test`, `spec` → `test|testing`
- **CI/CD**: `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops`
- **의존성**: `package.json`, `pubspec.yaml` → `dependencies|deps`

#### 변경 내용 기반 판정

- **버그 수정**: `fix|bug|error|crash|수정` → `bug|fix`
- **새 기능**: `feat|feature|add|implement|새기능|구현` → `feature|enhancement|feat`
- **리팩터링**: `refactor|clean|리팩터링` → `refactor|cleanup|clean`
- **성능**: `performance|perf|optimize` → `performance|perf`
- **보안**: `security|secure` → `security`

#### 제약 사항

- **최대 3 개까지**: 자동 선택의 상한
- **기존 라벨만**: 신규 생성 금지
- **부분 매치**: 키워드 포함을 통한 판정

### 프로젝트 가이드라인

#### 기본 자세

1. **반드시 Draft 로 시작**: 모든 PR 은 Draft 상태로 생성
2. **단계적 품질 향상**: Phase 1 (기본 구현) → Phase 2 (테스트 추가) → Phase 3 (문서 업데이트)
3. **적절한 라벨**: 최대 3 종류의 라벨을 반드시 부여
4. **템플릿 사용**: `.github/PULL_REQUEST_TEMPLATE.md`를 반드시 사용
5. **한국어 스페이스**: 한국어와 반각 영숫자 사이에 반드시 반각 스페이스

#### 브랜치 네이밍 규칙

```text
{type}-{subject}

예시:
- feat-user-profile
- fix-login-error
- refactor-api-client
```

#### 커밋 메시지

```text
{type}: {description}

예시:
- feat: 사용자 인증 API 구현
- fix: 로그인 오류 수정
- docs: README 업데이트
```

### 템플릿 처리 시스템

#### 처리 우선순위

1. **기존 PR 설명**: 이미 기술된 내용을 **완전히 보존**
2. **프로젝트 템플릿**: `.github/PULL_REQUEST_TEMPLATE.md` 구조 유지
3. **기본 템플릿**: 위가 존재하지 않는 경우

#### 기존 내용 보존 규칙

- **한 글자도 변경하지 않음**: 이미 기술된 내용
- **빈 섹션만 보완**: 플레이스홀더 부분을 변경 내용으로 채움
- **기능적 코멘트 유지**: `<!-- Copilot review rule -->` 등을 유지
- **HTML 코멘트 유지**: `<!-- ... -->`를 완전히 보존
- **구분선 유지**: `---` 등의 구조를 유지

#### HTML 코멘트 보존 대처법

**중요**: GitHub CLI (`gh pr edit`)는 HTML 코멘트를 자동 이스케이프하고, 셸 처리에서 `EOF < /dev/null` 등의 불법 문자열이 혼입되는 경우가 있습니다.

**근본적 해결책**:

1. **GitHub API 의 --field 옵션 사용**: 적절한 이스케이프 처리로 HTML 코멘트 보존
2. **템플릿 처리 단순화**: 복잡한 파이프 처리나 리다이렉트를 피함
3. **완전 보존 접근**: HTML 코멘트 삭제 처리를 폐지하고 템플릿을 완전 보존

### 리뷰 코멘트 대응

```bash
# 변경 후 재커밋
git add .
git commit -m "fix: 리뷰 피드백기반의 수정"
git push
```

### 주의사항

#### HTML 코멘트 보존의 중요성

- **GitHub CLI 제한**: `gh pr edit`는 HTML 코멘트를 이스케이프하고 불법 문자열 혼입
- **근본적 회피책**: GitHub API 의 `--field` 옵션으로 적절한 이스케이프 처리
- **템플릿 완전 보존**: HTML 코멘트 삭제 처리를 폐지하고 구조를 완전 유지

#### 자동화 제약

- **신규 라벨 금지**: `.github/labels.yml` 정의 외 라벨 생성 불가
- **최대 3 라벨**: 자동 선택의 상한
- **기존 내용 우선**: 수동으로 기술된 내용은 일체 변경하지 않음

#### 단계적 품질 향상

- **Draft 필수**: 모든 PR 은 Draft 로 시작
- **CI 확인**: `gh pr checks`로 상태 확인
- **Ready 이행**: 품질 확인 완료 후 `gh pr ready`
- **템플릿 완전 준수**: 프로젝트별 구조를 유지
