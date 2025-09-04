## Dependency Analysis

프로젝트의 의존관계를 분석하고 아키텍처 건전성을 평가합니다.

### 사용법

```bash
/dependency-analysis [옵션]
```

### 옵션

- `--visual` : 의존관계를 시각적으로 표시
- `--circular` : 순환 의존만 감지
- `--depth <숫자>` : 분석 깊이 지정(기본값: 3)
- `--focus <경로>` : 특정 모듈/디렉토리에 집중

### 기본 예제

```bash
# 프로젝트 전체 의존관계 분석
/dependency-analysis

# 순환 의존 감지
/dependency-analysis --circular

# 특정 모듈의 상세 분석
/dependency-analysis --focus src/core --depth 5
```

### 분석 항목

#### 1. 의존관계 매트릭스

모듈 간 의존관계를 수치화해서 표시：

- 직접 의존
- 간접 의존
- 의존 깊이
- 팬인/팬아웃

#### 2. 아키텍처 위반 감지

- 레이어 위반(하위층이 상위층에 의존)
- 순환 의존
- 과도한 결합(높은 의존도)
- 고립된 모듈

#### 3. Clean Architecture 준수 체크

- 도메인 층의 독립성
- 인프라 층의 적절한 분리
- 유스케이스 층의 의존 방향
- 인터페이스 적용 상황

### 출력 예시

```
의존관계 분석 리포트
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 지표 개요
├─ 총 모듈 수: 42
├─ 평균 의존 수: 3.2
├─ 최대 의존 깊이: 5
└─ 순환 의존: 2 건 감지

⚠️  아키텍처 위반
├─ [HIGH] src/domain/user.js → src/infra/database.js
│  └─ 도메인 층이 인프라 층에 직접 의존
├─ [MED] src/api/auth.js ⟲ src/services/user.js
│  └─ 순환 의존 감지됨
└─ [LOW] src/utils/helper.js → 12 modules
   └─ 과도한 팬아웃

✅ 권장 액션
1. UserRepository 인터페이스 도입
2. 인증 서비스의 책임 재설계
3. 헬퍼 함수를 기능별로 분할

📈 의존관계 그래프
[시각적 의존관계 다이어그램을 ASCII 아트로 표시]
```

### 고급 사용 예시

```bash
# CI/CD 파이프라인에서 자동 체크
/dependency-analysis --circular --fail-on-violation

# 아키텍처 규칙 정의와 검증
/dependency-analysis --rules .architecture-rules.yml

# 시계열로 의존관계 변화 추적
/dependency-analysis --compare HEAD~10
```

### 설정 파일 예시 (.dependency-analysis.yml)

```yaml
rules:
  - name: "Domain Independence"
    source: "src/domain/**"
    forbidden: ["src/infra/**", "src/api/**"]

  - name: "API Layer Dependencies"
    source: "src/api/**"
    allowed: ["src/domain/**", "src/application/**"]
    forbidden: ["src/infra/**"]

thresholds:
  max_dependencies: 8
  max_depth: 4
  coupling_threshold: 0.7

ignore:
  - "**/test/**"
  - "**/mocks/**"
```

### 통합 도구

- `madge` : JavaScript/TypeScript 의존관계 시각화
- `dep-cruiser` : 의존관계 규칙 검증
- `nx` : 모노레포 의존관계 관리
- `plato` : 복잡도와 의존관계 통합 분석

### Claude 와의 연계

```bash
# package.json 을 포함한 분석
cat package.json
/analyze-dependencies
"이 프로젝트의 의존관계 문제점을 분석해줘"

# 특정 모듈의 소스 코드와 조합
ls -la src/core/
/analyze-dependencies --focus src/core
"코어 모듈의 의존관계를 상세히 평가해줘"

# 아키텍처 문서와의 비교
cat docs/architecture.md
/analyze-dependencies --visual
"설계 문서와 구현의 차이를 확인해줘"
```

### 주의사항

- **전제조건**: 프로젝트 루트에서 실행 필요
- **제한사항**: 대규모 프로젝트는 분석에 시간이 걸릴 수 있습니다
- **권장사항**: 순환 의존이 발견되면 즉시 대처를 검토하세요

### 베스트 프랙티스

1. **정기적 분석**: 주간 단위로 의존관계 건전성 체크
2. **규칙 명문화**: 아키텍처 규칙을 설정 파일로 관리
3. **단계적 개선**: 대규모 리팩터링을 피하고 점진적으로 개선
4. **지표 추적**: 의존관계 복잡도를 시계열로 모니터링
