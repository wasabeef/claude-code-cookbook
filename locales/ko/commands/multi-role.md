## Multi Role

여러 역할로 동일한 대상을 병렬 분석하여 통합 보고서를 생성하는 명령어입니다.

### 사용법

```bash
/multi-role <역할 1>,<역할 2> [--agent|-a] [분석 대상]
/multi-role <역할 1>,<역할 2>,<역할 3> [--agent|-a] [분석 대상]
```

**중요**:

- `--agent` 옵션은 역할 지정 직후에 배치하세요
- 메시지는 `--agent` 뒤에 작성하세요
- 올바른 예: `/multi-role qa,architect --agent 계획을 평가하세요`
- 잘못된 예: `/multi-role qa,architect 계획을 평가하세요 --agent`

### 옵션

- `--agent` 또는 `-a` : 각 역할을 서브에이전트로 병렬 실행 (대규모 분석 시 권장)
  - 이 옵션을 사용하면 각 역할의 description 에 자동 위임 촉진 문구("use PROACTIVELY" 등)가 포함된 경우, 더 적극적인 자동 위임이 활성화됩니다

### 기본 예제

```bash
# 보안과 성능 양면 분석 (일반)
/multi-role security,performance
「이 API 엔드포인트를 평가하세요」

# 대규모 시스템의 병렬 분석 (서브에이전트)
/multi-role security,performance --agent
「시스템 전체의 보안과 성능을 포괄적으로 분석」

# 프론트엔드·모바일·성능의 통합 분석
/multi-role frontend,mobile,performance
「이 화면의 최적화 방안을 검토하세요」

# 아키텍처 설계의 다각적 평가 (서브에이전트)
/multi-role architect,security,performance --agent
「마이크로서비스화 설계를 평가하세요」
```

### 분석 프로세스

### Phase 1: 병렬 분석

각 역할이 독립적으로 동일한 대상을 분석

- 전문 관점으로의 평가 실행
- 역할별 고유 기준으로 판정
- 독립적인 권장사항 생성

### Phase 2: 통합 분석

결과를 구조화하여 통합

- 각 역할의 평가 결과 정리
- 중복·모순점 식별
- 보완 관계 명확화

### Phase 3: 통합 보고서

최종적인 권장사항 생성

- 우선순위가 부여된 액션 플랜
- 트레이드오프 명시
- 구현 로드맵 제시

### 출력 형식 예제

### 2 역할 분석의 경우

```
멀티역할 분석: Security + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

분석 대상: API 엔드포인트 /api/users

Security 분석 결과:
인증: JWT 검증이 적절히 구현됨
인가: 역할 기반 접근 제어가 불완전함
암호화: API 키가 평문으로 로그 출력됨

평가 점수: 65/100
중요도: High (기밀 데이터 접근을 위해)

Performance 분석 결과:
응답 시간: 평균 180ms (목표 200ms 이내)
데이터베이스 쿼리: N+1 문제 검출됨
캐시: Redis 캐시 미구현

평가 점수: 70/100
중요도: Medium (현재 상태는 허용 범위 내)

상호 관련 분석:
시너지 효과의 기회:
- Redis 캐시 구현 시 암호화도 동시 고려
- 로그 출력 개선으로 보안 + 성능 향상

트레이드오프 포인트:
- 인가 체크 강화 ↔ 응답 시간에 미치는 영향
- 로그 암호화 ↔ 디버그 효율성 저하

통합 우선순위:
Critical: API 키 평문 출력 수정
High: N+1 쿼리 해결
Medium: Redis 캐시 + 암호화 구현
Low: 인가 제어 상세화

구현 로드맵:
1 주차: API 키 마스킹 구현
2 주차: 데이터베이스 쿼리 최적화
3-4 주차: 캐시 레이어 설계·구현
2 개월차: 인가 제어의 단계적 강화
```

### 3 역할 분석의 경우

```
멀티역할 분석: Frontend + Mobile + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

분석 대상: 사용자 프로필 화면

Frontend 분석 결과:
사용성: 직관적인 레이아웃
접근성: WCAG 2.1 준수율 85%
반응형: 태블릿 표시에 과제 있음

Mobile 분석 결과:
터치 타겟: 44pt 이상 확보
한 손 조작: 중요 버튼이 상단에 배치됨
오프라인 대응: 미구현

Performance 분석 결과:
초기 표시: LCP 2.1 초 (양호)
이미지 최적화: WebP 미지원
지연 로딩: 미구현

통합 권장사항:
1. 모바일 최적화 (한 손 조작 + 오프라인 대응)
2. 이미지 최적화 (WebP + 지연 로딩)
3. 태블릿 UI 개선

우선순위: Mobile > Performance > Frontend
구현 기간: 3-4 주
```

### 효과적인 조합 패턴

### 보안 중심

```bash
/multi-role security,architect
「인증 시스템 설계」

/multi-role security,frontend  
「로그인 화면의 보안」

/multi-role security,mobile
「모바일 앱의 데이터 보호」
```

### 성능 중심

```bash
/multi-role performance,architect
「확장성 설계」

/multi-role performance,frontend
「웹 페이지 고속화」

/multi-role performance,mobile
「앱 동작 최적화」
```

### 사용자 경험 중심

```bash
/multi-role frontend,mobile
「크로스 플랫폼 UI」

/multi-role frontend,performance
「UX 와 성능의 균형」

/multi-role mobile,performance
「모바일 UX 최적화」
```

### 포괄적 분석

```bash
/multi-role architect,security,performance
「시스템 전체 평가」

/multi-role frontend,mobile,performance
「사용자 경험의 종합 평가」

/multi-role security,performance,mobile
「모바일 앱의 종합 진단」
```

### Claude 와의 연계

```bash
# 파일 분석 및 조합
cat src/components/UserProfile.tsx
/multi-role frontend,mobile
「이 컴포넌트를 여러 관점으로 평가하세요」

# 설계 문서 평가
cat architecture-design.md
/multi-role architect,security,performance
「이 설계를 여러 전문 분야에서 평가하세요」

# 에러 분석
cat performance-issues.log
/multi-role performance,analyzer
「성능 문제를 다각적으로 분석하세요」
```

### multi-role vs role-debate 사용 구분

### multi-role 을 사용할 때

- 각 전문 분야의 독립적인 평가가 필요한 경우
- 통합적인 개선 계획을 세우고 싶은 경우
- 모순이나 중복을 정리하고 싶은 경우
- 구현 우선순위를 정하고 싶은 경우

### role-debate 를 사용할 때

- 전문 분야 간 트레이드오프가 있는 경우
- 기술 선정에서 의견이 갈릴 것 같은 경우
- 설계 방침을 토론으로 정하고 싶은 경우
- 다양한 관점의 토론을 듣고 싶은 경우

### 서브에이전트 병렬 실행 (--agent)

`--agent` 옵션을 사용하면 각 역할이 독립된 서브에이전트로 병렬 실행됩니다.

#### 자동 위임의 촉진

역할 파일의 description 필드에 다음과 같은 문구가 포함된 경우, `--agent` 사용 시 더 적극적인 자동 위임이 활성화됩니다:

- "use PROACTIVELY"
- "MUST BE USED"
- 기타 강조 표현

#### 실행 플로우

```
일반 실행:
역할 1 → 역할 2 → 역할 3 → 통합
(순차 실행, 약 3-5 분)

--agent 실행:
역할 1 ─┐
역할 2 ─┼→ 통합
역할 3 ─┘
(병렬 실행, 약 1-2 분)
```

#### 효과적인 사용 예제

```bash
# 대규모 시스템의 종합 평가
/multi-role architect,security,performance,qa --agent
「신규 시스템을 포괄적으로 평가」

# 다중 관점의 상세 분석
/multi-role frontend,mobile,performance --agent
「전체 화면의 UX 최적화 분석」
```

#### 성능 비교

| 역할 수 | 일반 실행 | --agent 실행 | 단축률 |
|---------|----------|-------------|-------|
| 2 역할 | 2-3 분 | 1 분 | 50% |
| 3 역할 | 3-5 분 | 1-2 분 | 60% |
| 4 역할 | 5-8 분 | 2-3 분 | 65% |

### 주의사항

- 3 개 이상의 역할을 동시 실행하면 출력이 길어집니다
- 복잡한 분석일수록 실행 시간이 길어질 수 있습니다
- 상호 모순되는 권장사항이 나온 경우 role-debate 도 검토하세요
- 최종적인 판단은 통합 결과를 참고하여 사용자가 수행하세요
- **--agent 사용 시**: 더 많은 리소스를 사용하지만, 대규모 분석에서는 효율적입니다