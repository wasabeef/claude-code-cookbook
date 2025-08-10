## 성능 분석

애플리케이션의 성능 문제를 분석하고 기술 부채 관점으로 개선 방안을 제안합니다.

### 사용법

```bash
# 성능 문제을 포괄적으로 분석
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"큰 파일과 성능 문제를 파악하고 개선안을 제시하세요"

# 비효율적인 코드 패턴 검출
grep -r "for.*await\|forEach.*await" . --include="*.js"
"N+1 쿼리 문제와 성능 병목을 분석하세요"

# 메모리 누수 가능성
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
"메모리 누수 리스크와 대책을 평가하세요"
```

### 기본 사용 예시

```bash
# 번들 사이즈와 로드 시간
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"번들 사이즈와 애셋 최적화 개선점을 파악하세요"

# 데이터베이스 성능
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"데이터베이스 쿼리 최적화 포인트를 분석하세요"

# 의존성의 성능 영향
npm outdated && npm audit
"오래된 의존성이 성능에 미치는 영향을 평가하세요"
```

### 분석 관점

#### 1. 코드 레벨 문제

- **O(n²) 알고리즘**: 비효율적인 배열 연산 검출
- **동기 I/O**: 블로킹 처리 식별
- **중복 처리**: 불필요한 연산이나 요청 제거
- **메모리 누수**: 이벤트 리스너나 타이머 관리

#### 2. 아키텍처 레벨 문제

- **N+1 쿼리**: 데이터베이스 접근 패턴
- **캐시 부족**: 반복 연산이나 API 호출
- **번들 사이즈**: 불필요한 라이브러리나 코드 분할
- **리소스 관리**: 커넥션 풀이나 스레드 사용량

#### 3. 기술 부채로 인한 영향

- **레거시 코드**: 오래된 구현으로 인한 성능 저하
- **설계 문제**: 책임 분산 부족으로 인한 높은 결합도
- **테스트 부족**: 성능 회귀 검출 누락
- **모니터링 부족**: 문제 조기 발견 체계

### 개선 우선순위

```
🔴 Critical: 시스템 장애 리스크
├─ 메모리 누수 (서버 크래시)
├─ N+1 쿼리 (데이터베이스 부하)
└─ 동기 I/O (응답 지연)

🟡 High: 사용자 경험 영향
├─ 번들 사이즈 (초기 로드 시간)
├─ 이미지 최적화 (표시 속도)
└─ 캐시 전략 (반응 속도)

🟢 Medium: 운영 효율성
├─ 의존성 업데이트 (보안)
├─ 코드 중복 (유지보수성)
└─ 모니터링 강화 (운영 부하)
```

### 측정과 도구

#### Node.js / JavaScript

```bash
# 프로파일링
node --prof app.js
clinic doctor -- node app.js

# 번들 분석
npx webpack-bundle-analyzer
lighthouse --chrome-flags="--headless"
```

#### 데이터베이스

```sql
-- 쿼리 분석
EXPLAIN ANALYZE SELECT ...
SHOW SLOW LOG;
```

#### 프론트엔드

```bash
# React 성능
grep -r "useMemo\|useCallback" . --include="*.jsx"

# 리소스 분석
find ./src -name "*.png" -o -name "*.jpg" | xargs ls -lh
```

### 지속적 개선

- **정기 감사**: 주간 성능 테스트 실행
- **지표 수집**: 응답 시간, 메모리 사용량 추적
- **알림 설정**: 임계값 초과 시 자동 알림
- **팀 공유**: 개선 사례와 안티패턴 문서화