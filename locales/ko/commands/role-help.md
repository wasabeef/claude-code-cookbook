## Role Help

어떤 역할을 사용해야 할지 고민될 때의 선택 가이드와 도움말 시스템입니다.

### 사용법

```bash
/role-help                      # 전반적인 역할 선택 가이드
/role-help <상황/문제>          # 특정 상황에서의 권장 역할
/role-help compare <역할 1>,<역할 2> # 역할 비교
```

### 기본 예제

```bash
# 일반적인 가이던스
/role-help
→ 이용 가능한 역할과 특징의 목록 표시

# 상황별 권장
/role-help "API 의 보안이 걱정"
→ security 역할의 권장과 사용 방법

# 역할 비교
/role-help compare frontend,mobile
→ frontend 와 mobile 의 차이와 사용 구분
```

### 상황별 역할 선택 가이드

### 🔒 보안 관련

```
이런 때는 security 역할:
✅ 로그인·인증 기능의 구현
✅ API 의 보안 취약점 체크
✅ 데이터 암호화·프라이버시 보호
✅ 보안 규정 준수 확인
✅ 침입 테스트·펜테스팅

사용법: /role security
```

### 🏗️ 아키텍처·설계

```
이런 때는 architect 역할:
✅ 시스템 전체의 설계 평가
✅ 마이크로서비스 vs 모노리스 판단
✅ 데이터베이스 설계·기술 선정
✅ 확장성·스케일링 검토
✅ 기술적 부채의 평가·개선 계획

사용법: /role architect
```

### ⚡ 성능 문제

```
이런 때는 performance 역할:
✅ 애플리케이션이 느림
✅ 데이터베이스 쿼리 최적화
✅ 웹 페이지의 로딩 속도 개선
✅ 메모리·CPU 사용량 최적화
✅ 스케일링·부하 대책

사용법: /role performance
```

### 🔍 문제의 원인 조사

```
이런 때는 analyzer 역할:
✅ 버그·에러의 근본 원인 분석
✅ 시스템 장애의 원인 규명
✅ 복잡한 문제의 구조적 분석
✅ 데이터 분석·통계적 조사
✅ 왜 이 문제가 발생했는지 해명

사용법: /role analyzer
```

### 🎨 프론트엔드·UI/UX

```
이런 때는 frontend 역할:
✅ 사용자 인터페이스의 개선
✅ 접근성 대응
✅ 반응형 디자인
✅ 사용성·편의성 향상
✅ 웹 프론트엔드 기술 전반

사용법: /role frontend
```

### 📱 모바일 앱 개발

```
이런 때는 mobile 역할:
✅ iOS·Android 앱의 최적화
✅ 모바일 특유의 UX 설계
✅ 터치 인터페이스 최적화
✅ 오프라인 대응·동기화 기능
✅ App Store·Google Play 대응

사용법: /role mobile
```

### 👀 코드 리뷰·품질

```
이런 때는 reviewer 역할:
✅ 코드의 품질 체크
✅ 가독성·유지보수성의 평가
✅ 코딩 규약 확인
✅ 리팩터링 제안
✅ PR·커밋의 리뷰

사용법: /role reviewer
```

### 🧪 테스트·품질 보증

```
이런 때는 qa 역할:
✅ 테스트 전략 수립
✅ 테스트 커버리지 평가
✅ 자동 테스트의 구현 방침
✅ 버그 방지·품질 향상책
✅ CI/CD 에서의 테스트 자동화

사용법: /role qa
```

### 복수 역할이 필요한 경우

### 🔄 multi-role (병행 분석)

```
이런 때는 multi-role:
✅ 복수의 전문 관점으로 평가가 필요
✅ 통합적인 개선 계획을 세우고 싶음
✅ 각 분야의 평가를 비교하고 싶음
✅ 모순·중복을 정리하고 싶음

예: /multi-role security,performance
```

### 🗣️ role-debate (토론)

```
이런 때는 role-debate:
✅ 전문 분야 간 트레이드오프가 있음
✅ 기술 선정에서 의견이 갈림
✅ 설계 방침을 토론으로 정하고 싶음
✅ 다양한 관점의 토론을 듣고 싶음

예: /role-debate security,performance
```

### 🤖 smart-review (자동 제안)

```
이런 때는 smart-review:
✅ 어떤 역할을 사용해야 할지 모르겠음
✅ 현재 상황에 최적인 접근법을 알고 싶음
✅ 복수의 선택지 중에서 선택하고 싶음
✅ 초보자로서 판단에 고민됨

예: /smart-review
```

### 역할 비교표

### 보안계

| 역할 | 주요 용도 | 장점 분야 | 약점 분야 |
|--------|----------|----------|----------|
| security | 취약점·공격 대책 | 위협 분석, 인증 설계 | UX, 성능 |
| analyzer | 근본 원인 분석 | 논리적 분석, 증거 수집 | 예방책, 미래 계획 |

### 설계계

| 역할 | 주요 용도 | 장점 분야 | 약점 분야 |
|--------|----------|----------|----------|
| architect | 시스템 설계 | 장기 관점, 전체 최적화 | 세부 구현, 단기 해결 |
| reviewer | 코드 품질 | 구현 레벨, 유지보수성 | 비즈니스 요건, UX |

### 성능계

| 역할 | 주요 용도 | 장점 분야 | 약점 분야 |
|--------|----------|----------|----------|
| performance | 고속화·최적화 | 측정, 병목 지점 | 보안, UX |
| qa | 품질 보증 | 테스트, 자동화 | 설계, 아키텍처 |

### 사용자 경험계

| 역할 | 주요 용도 | 장점 분야 | 약점 분야 |
|--------|----------|----------|----------|
| frontend | Web UI/UX | 브라우저, 접근성 | 서버사이드, DB |
| mobile | 모바일 UX | 터치, 오프라인 대응 | 서버사이드, 웹 |

### 고민될 때의 플로우차트

```
문제의 성격은?
├─ 보안 관련 → security
├─ 성능 문제 → performance  
├─ 버그·장애 조사 → analyzer
├─ UI/UX 개선 → frontend or mobile
├─ 설계·아키텍처 → architect
├─ 코드 품질 → reviewer
├─ 테스트 관련 → qa
└─ 복합적·복잡 → smart-review 로 제안

복수 분야에 걸쳐 있는가?
├─ 통합 분석하고 싶음 → multi-role
├─ 토론·트레이드오프 → role-debate
└─ 판단에 고민됨 → smart-review
```

### 자주 묻는 질문

### Q: frontend 와 mobile 의 차이는?

```
A: 
frontend: 웹 브라우저 중심, HTML/CSS/JavaScript
mobile: 모바일 앱 중심, iOS/Android 네이티브·React Native 등

둘 다 관련된 경우는 multi-role frontend,mobile 이 권장
```

### Q: security 와 analyzer 의 사용 구분은?

```
A:
security: 공격·위협의 예방, 보안 설계
analyzer: 이미 발생한 문제의 원인 분석, 조사

보안 인시던트의 조사라면 multi-role security,analyzer
```

### Q: architect 와 performance 의 차이는?

```
A:
architect: 시스템 전체의 장기적 설계, 확장성
performance: 구체적인 속도·효율의 개선

대규모 시스템의 성능 설계라면 multi-role architect,performance
```

### Claude 와의 연계

```bash
# 상황 설명과 조합
/role-help
「React 앱의 페이지 로딩이 느려서 사용자로부터 불만이 들어오고 있다」

# 파일 내용과 조합
cat problem-description.md
/role-help
「이 문제에 최적인 역할을 추천하세요」

# 특정 선택지로 고민하는 경우
/role-help compare security,performance
「JWT 토큰의 유효기간 문제에서 어느 역할이 적절한가?」
```

### 주의사항

- 복잡한 문제일수록 복수 역할의 조합이 효과적입니다
- 긴급성이 높은 경우는 single role 로 신속하게 대응
- 고민될 때는 smart-review 로 자동 제안을 받는 것을 권장합니다
- 최종적인 판단은 사용자가 문제의 성질을 고려하여 결정하세요
