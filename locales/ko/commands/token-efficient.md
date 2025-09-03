# Token Efficiency Mode

AI 응답을 압축하여 컨텍스트 사용량을 30-50% 절감하는 효율화 모드입니다.

## 개요

Token Efficiency Mode 는 시각적 심볼과 약어 시스템을 활용하여 Claude 의 응답을 압축합니다.
**생성되는 코드의 품질이나 내용은 전혀 변경되지 않습니다**. 바뀌는 것은 설명 방식뿐입니다.

## 사용법

```bash
# 모드 활성화
「Token Efficiency Mode 로 응답해주세요」
「--uc 모드로」
「간결 모드로」
```

## 동작 원리

### 1. 심볼 체계

#### 로직 & 플로우

| 심볼 | 의미 | 사용 예시 |
|------|------|-----------|
| → | ~로 이어지는, ~을 야기하는 | `auth.js:45 → 🛡️ 보안 위험` |
| ⇒ | ~로 변환 | `input ⇒ validated_output` |
| ← | 롤백, 되돌리기 | `migration ← rollback` |
| ⇄ | 양방향 | `sync ⇄ remote` |
| & | 그리고, 결합 | `🛡️ security & ⚡ performance` |
| \| | 또는, 구분 | `react\|vue\|angular` |
| : | 정의, 지정 | `scope: file\|module` |
| » | 다음, 시퀀스 | `build » test » deploy` |
| ∴ | 따라서 | `tests ❌ ∴ code broken` |
| ∵ | 왜냐하면 | `slow ∵ O(n²) algorithm` |

#### 상태 & 진행

| 심볼 | 의미 | 용도 |
|------|------|------|
| ✅ | 완료, 성공 | 작업 정상 종료 |
| ❌ | 실패, 에러 | 즉시 대응 필요 |
| ⚠️ | 경고 | 리뷰 권장 |
| 🔄 | 진행 중 | 현재 활성 |
| ⏳ | 대기 중 | 나중에 실행 예정 |
| 🚨 | 긴급, 중요 | 고우선순위 |

#### 기술 도메인

| 심볼 | 분야 | 용도 |
|------|------|------|
| ⚡ | 성능 | 속도, 최적화 |
| 🔍 | 분석 | 검색, 조사 |
| 🔧 | 설정 | 셋업, 도구 |
| 🛡️ | 보안 | 보호, 안전성 |
| 📦 | 배포 | 패키지, 번들 |
| 🎨 | 디자인 | UI, 프런트엔드 |
| 🏗️ | 아키텍처 | 시스템 구조 |
| 🗄️ | 데이터베이스 | 데이터 지속성 |
| ⚙️ | 백엔드 | 서버 처리 |
| 🧪 | 테스트 | 품질 보증 |

### 2. 약어 시스템

#### 시스템 & 아키텍처

- `cfg` → configuration (설정)
- `impl` → implementation (구현)
- `arch` → architecture (아키텍처)
- `perf` → performance (성능)
- `ops` → operations (운영)
- `env` → environment (환경)

#### 개발 프로세스

- `req` → requirements (요구사항)
- `deps` → dependencies (의존성)
- `val` → validation (검증)
- `auth` → authentication (인증)
- `docs` → documentation (문서)
- `std` → standards (표준)

#### 품질 & 분석

- `qual` → quality (품질)
- `sec` → security (보안)
- `err` → error (에러)
- `rec` → recovery (복구)
- `sev` → severity (심각도)
- `opt` → optimization (최적화)

## 실제 비교 예시

### 예시 1: 에러 보고

**일반 모드 (92 자)**
```
인증 시스템의 사용자 검증 함수 45 행에서 보안 취약점이 발견되었습니다.
```

**Token Efficient (39 자)**
```
auth.js:45 → 🛡️ sec vuln in user val()
```

### 예시 2: 빌드 상황

**일반 모드 (145 자)**
```
빌드 프로세스가 정상적으로 완료되었습니다. 현재 테스트를 실행 중이며, 그 후 배포를 진행합니다.
```

**Token Efficient (35 자)**
```
build ✅ » test 🔄 » deploy ⏳
```

### 예시 3: 성능 분석

**일반 모드 (98 자)**
```
성능 분석 결과, 알고리즘이 O(n²) 의 복잡도로 인해 처리가 느린 것으로 판명되었습니다.
```

**Token Efficient (42 자)**
```
⚡ perf: slow ∵ O(n²) → optimize to O(n)
```

## 활용 시나리오

### ✅ 효과적인 상황

- **장시간 디버깅 세션**: 이력을 유지하면서 효율적으로
- **대규모 코드 리뷰**: 다수의 파일을 간결하게 분석
- **CI/CD 모니터링**: 실시간 상태 업데이트
- **프로젝트 진행 상황 보고**: 여러 작업 상태를 한눈에 정리
- **에러 추적**: 문제의 연쇄를 시각적으로 표현

### ❌ 피해야 할 상황

- 초보자에게 설명할 때
- 상세한 문서 작성
- 최초 요구사항 정의
- 비기술자와의 소통

## 구현 예시

### 디버깅 세션

```
[14:23] breakpoint → vars: {user: null, token: expired}
[14:24] step → auth.validate() ❌
[14:25] check → token.exp < Date.now() ∴ expired
[14:26] fix → refresh() → ✅
[14:27] continue → main flow 🔄
```

### 파일 분석 결과

```
/src/auth/: 🛡️ issues × 3
/src/api/: ⚡ bottleneck in handler()
/src/db/: ✅ clean
/src/utils/: ⚠️ deprecated methods
/tests/: 🧪 coverage 78%
```

### 프로젝트 상태

```
Frontend: 🎨 ✅ 100%
Backend: ⚙️ 🔄 75%
Database: 🗄️ ✅ migrated
Tests: 🧪 ⚠️ 68% (target: 80%)
Deploy: 📦 ⏳ scheduled
Security: 🛡️ 🚨 1 critical
```

## 설정 옵션

```javascript
// 압축 레벨
--uc        // Ultra Compressed: 최대 압축
--mc        // Moderate Compressed: 중간 압축
--lc        // Light Compressed: 경량 압축

// 도메인 특화
--dev       // 개발용 압축
--ops       // 운영용 압축
--sec       // 보안용 압축
```

## 장점

1. **컨텍스트 절약**: 30-50% 의 토큰 절감
2. **시각적 이해**: 심볼로 직관적 파악
3. **정보 밀도 향상**: 같은 공간에 더 많은 정보
4. **이력 유지**: 더 긴 대화 이력 보존
5. **패턴 인식**: 시각적 패턴으로 문제 발견 용이

## 주의사항

- 이 모드는 **AI 의 응답 스타일**만을 변경합니다
- 생성되는 **코드의 품질**은 변하지 않습니다
- 필요 시 "일반 모드로 설명해주세요"로 전환 가능
- 초보자나 비기술자에게는 일반 모드를 권장

## 명령어 예시

```bash
# 활성화
「Token Efficient Mode on」
「간결하게 응답해주세요」
「--uc 로 분석」

# 비활성화
「일반 모드로 돌아가세요」
「자세히 설명해주세요」
「Token Efficient Mode off」
```

## 구현에 미치는 영향

| 항목 | 영향 |
|------|------|
| 생성 코드 품질 | 변경 없음 ✅ |
| 구현 정확성 | 변경 없음 ✅ |
| 기능성 | 변경 없음 ✅ |
| AI 설명 방식 | 압축됨 🔄 |
| 컨텍스트 사용량 | 30-50% 절감 ⚡ |

---

💡 **Pro Tip**: 장시간 작업 세션에서는 처음에는 일반 모드로 이해를 높이고, 그 후 Token Efficient Mode 로 전환하여 효율성과 컨텍스트 보존의 균형을 최적화할 수 있습니다.