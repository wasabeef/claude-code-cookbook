## Smart Review

현재 상황을 분석하여 최적인 역할·접근법을 자동 제안하는 명령어입니다.

### 사용법

```bash
/smart-review                    # 현재 디렉터리를 분석
/smart-review <파일/디렉터리> # 특정 대상을 분석
```

### 자동 판정 로직

### 파일 확장자를 통한 판정

- `package.json`, `*.tsx`, `*.jsx`, `*.css`, `*.scss` → **frontend**
- `Dockerfile`, `docker-compose.yml`, `*.yaml` → **architect**
- `*.test.js`, `*.spec.ts`, `test/`, `__tests__/` → **qa**
- `*.rs`, `Cargo.toml`, `performance/` → **performance**

### 보안 관련 파일 검출

- `auth.js`, `security.yml`, `.env`, `config/auth/` → **security**
- `login.tsx`, `signup.js`, `jwt.js` → **security + frontend**
- `api/auth/`, `middleware/auth/` → **security + architect**

### 복합 판정 패턴

- `mobile/` + `*.swift`, `*.kt`, `react-native/` → **mobile**
- `webpack.config.js`, `vite.config.js`, `large-dataset/` → **performance**
- `components/` + `responsive.css` → **frontend + mobile**
- `api/` + `auth/` → **security + architect**

### 에러·문제 분석

- 스택 트레이스, `error.log`, `crash.log` → **analyzer**
- `memory leak`, `high CPU`, `slow query` → **performance + analyzer**
- `SQL injection`, `XSS`, `CSRF` → **security + analyzer**

### 제안 패턴

### 단일 역할 제안

```bash
$ /smart-review src/auth/login.js
→ 「인증 파일을 검출했습니다」
→ 「security 역할에서의 분석을 권장합니다」
→ 「실행하시겠습니까? [y]es / [n]o / [m]ore options」
```

### 복수 역할 제안

```bash
$ /smart-review src/mobile/components/
→ 「📱🎨 모바일 + 프론트엔드 요소를 검출」
→ 「권장 접근법:」
→ 「[1] mobile 역할 단체」
→ 「[2] frontend 역할 단체」  
→ 「[3] multi-role mobile,frontend」
→ 「[4] role-debate mobile,frontend」
```

### 문제 분석 시 제안

```bash
$ /smart-review error.log
→ 「⚠️ 에러 로그를 검출했습니다」
→ 「analyzer 역할로 근본 원인 분석을 시작합니다」
→ 「[자동 실행] /role analyzer」

$ /smart-review slow-api.log
→ 「🐌 성능 문제를 검출」
→ 「권장: [1]/role performance [2]/role-debate performance,analyzer」
```

### 복잡한 설계 결정 시 제안

```bash
$ /smart-review architecture-design.md
→ 「🏗️🔒⚡ 아키텍처 + 보안 + 성능 요소 검출」
→ 「복잡한 설계 결정을 위해 토론 형식을 권장합니다」
→ 「[권장] /role-debate architect,security,performance」
→ 「[대안] /multi-role architect,security,performance」
```

### 제안 로직의 상세

### 우선순위 판정

1. **Security** - 인증·인가·암호화 관련은 최우선
2. **Critical Errors** - 시스템 정지·데이터 손실은 긴급
3. **Architecture** - 대규모 변경·기술 선정은 신중 검토
4. **Performance** - 사용자 경험에 직결
5. **Frontend/Mobile** - UI/UX 개선
6. **QA** - 품질 보증·테스트 관련

### 토론 권장 조건

- 3 개 이상의 역할이 관련된 경우
- 보안 vs 성능의 트레이드오프가 있는 경우
- 아키텍처의 대폭 변경이 포함된 경우
- 모바일 + 웹 양쪽에 영향이 있는 경우

### 기본 예제

```bash
# 현재 디렉터리를 분석
/smart-review
「최적인 역할과 접근법을 제안하세요」

# 특정 파일을 분석
/smart-review src/auth/login.js
「이 파일에 최적인 리뷰 방법을 제안하세요」

# 에러 로그를 분석
/smart-review error.log
「이 에러의 해결에 최적인 접근법을 제안하세요」
```

### 실제 예제

### 프로젝트 전체의 분석

```bash
$ /smart-review
→ 「📊 프로젝트 분석 중...」
→ 「React + TypeScript 프로젝트를 검출」
→ 「인증 기능 + API + 모바일 대응을 확인」
→ 「」
→ 「💡 권장 워크플로우:」
→ 「1. security 로 인증계 체크」
→ 「2. frontend 로 UI/UX 평가」
→ 「3. mobile 로 모바일 최적화 확인」
→ 「4. architect 로 전체 설계 리뷰」
→ 「」
→ 「자동 실행하시겠습니까? [y]es / [s]elect role / [c]ustom」
```

### 특정 문제의 분석

```bash
$ /smart-review "JWT 의 유효기간을 어떻게 설정해야 할까"
→ 「🤔 기술적인 설계 판단을 검출」
→ 「복수의 전문 관점이 필요한 문제입니다」
→ 「」
→ 「권장 접근법:」
→ 「/role-debate security,performance,frontend」
→ 「이유: 보안·성능·UX 의 균형이 중요」
```

### Claude 와의 연계

```bash
# 파일 내용과 조합한 분석
cat src/auth/middleware.js
/smart-review
「이 파일의 내용을 포함해서 보안 관점으로 분석하세요」

# 에러와 조합한 분석
npm run build 2>&1 | tee build-error.log
/smart-review build-error.log
「빌드 에러의 해결방법을 제안하세요」

# 설계 상담
/smart-review
「React Native 와 Progressive Web App 중 어느 것을 선택해야 할지 토론하세요」
```

### 주의사항

- 제안은 참고 정보입니다. 최종적인 판단은 사용자가 수행하세요
- 복잡한 문제일수록 토론 형식(role-debate)을 권장합니다
- 단순한 문제는 single role 로 충분한 경우가 많습니다
- 보안 관련은 반드시 전문 역할에서의 확인을 권장합니다
