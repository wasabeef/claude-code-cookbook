## Refactor

안전하고 단계적인 코드 리팩터링을 실시하며, SOLID 원칙의 준수 상황을 정량적으로 평가합니다. 기술적 부채를 가시화하고, 개선의 우선순위를 명확히 합니다.

### 사용법

```bash
# 복잡한 코드의 특정과 리팩터링 계획
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
「큰 파일을 리팩터링해서 복잡도를 삭감해 주세요」

# 중복 코드의 검출과 통합
grep -r "function processUser" . --include="*.js"
「중복된 함수를 Extract Method로 공통화해 주세요」

# SOLID 원칙 위반의 검출
grep -r "class.*Service" . --include="*.js" | head -10
「이러한 클래스가 단일 책임의 원칙에 따르고 있는지 평가해 주세요」
```

### 기본 예

```bash
# 긴 메서드의 검출
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"50 행 이상의 메서드를 Extract Method로 분할해 주세요"

# 조건 분기의 복잡도
grep -r "if.*if.*if" . --include="*.js"
"중첩된 조건문을 Strategy 패턴으로 개선해 주세요"

# 코드의 냄새 검출
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"기술적 부채가 되고 있는 코멘트를 해결해 주세요"
```

### 리팩터링 기법

#### Extract Method(메서드 추출)

```javascript
// Before: 장대한 메서드
function processOrder(order) {
  // 50 행의 복잡한 처리
}

// After: 책임 분리
function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
}
```

#### Replace Conditional with Polymorphism

```javascript
// Before: switch 문
function getPrice(user) {
  switch (user.type) {
    case "premium":
      return basePrice * 0.8;
    case "regular":
      return basePrice;
  }
}

// After: Strategy 패턴
class PremiumPricing {
  calculate(basePrice) {
    return basePrice * 0.8;
  }
}
```

### SOLID 원칙 스코어링(0-100 점)

#### 평가 기준과 배점

```
S - Single Responsibility(20 점)
├─ 클래스의 책임 수: 1 개(20 점) | 2 개(15 점) | 3 개(10 점) | 4 개 이상(5 점)
├─ 메서드 수: <7 개(+5 점) | 7-15 개(+3 점) | >15 개(0 점)
├─ 변경 이유의 명확성: 명확(+5 점) | 모호(0 점)
└─ 스코어 예: UserService(인증+데이터 처리) = 10 점

O - Open/Closed(20 점)
├─ 확장 포인트: Strategy/Template Method(20 점) | 상속만(10 점) | 없음(5 점)
├─ 신기능 추가 시의 기존 코드 변경: 불필요(+5 점) | 최소한(+3 점) | 필요(0 점)
├─ 인터페이스 이용: 적절(+5 점) | 부분적(+3 점) | 없음(0 점)
└─ 스코어 예: PaymentProcessor(Strategy) = 20 점

L - Liskov Substitution(20 점)
├─ 파생 클래스의 계약 준수: 완전(20 점) | 부분적(10 점) | 위반(0 점)
├─ 사전 조건의 강화: 없음(+5 점) | 있음(-5 점)
├─ 사후 조건의 약화: 없음(+5 점) | 있음(-5 점)
└─ 스코어 예: Square extends Rectangle = 0 점(위반)

I - Interface Segregation(20 점)
├─ 인터페이스 크기: 1-3 메서드(20 점) | 4-7(15 점) | 8+(5 점)
├─ 미사용 메서드 구현: 없음(+5 점) | 1-2 개(+2 점) | 3 개 이상(0 점)
├─ 역할의 명확성: 단일 역할(+5 점) | 복수 역할(0 점)
└─ 스코어 예: Readable/Writable 분리 = 20 점

D - Dependency Inversion(20 점)
├─ 의존 방향: 추상만(20 점) | 혼재(10 점) | 구상만(5 점)
├─ DI 이용: Constructor Injection(+5 점) | Setter(+3 점) | 없음(0 점)
├─ 테스트 가능성: Mock 가능(+5 점) | 곤란(0 점)
└─ 스코어 예: Repository Pattern = 20 점

총합 스코어 = S + O + L + I + D
├─ 90-100 점: Excellent(SOLID 완전 준수)
├─ 70-89 점: Good(경미한 개선 여지)
├─ 50-69 점: Fair(리팩터링 권장)
├─ 30-49 점: Poor(대규모 개선 필요)
└─ 0-29 점: Critical(설계 재검토 필수)
```

### 기술적 부채의 정량화

#### 부채 계산식

```
기술적 부채(시간) = 복잡도 스코어 × 영향 범위 × 수정 난이도

복잡도 스코어:
├─ 순환적 복잡도: 1-5(낮음) | 6-10(중간) | 11-20(높음) | 21+(위험)
├─ 인지적 복잡도: 중첩 깊이 × 조건 분기 수
├─ 코드 행수: <50(1 점) | 50-200(2 점) | 200-500(3 점) | 500+(5 점)
└─ 중복률: 0-10%(1 점) | 10-30%(2 점) | 30-50%(3 점) | 50%+(5 점)

영향 범위:
├─ 의존 모듈 수: 직접 의존 + 간접 의존 × 0.5
├─ 이용 빈도: API 호출 횟수/일
├─ 비즈니스 중요도: Critical(×3) | High(×2) | Medium(×1) | Low(×0.5)
└─ 팀 지식: 이해자 1 명(×3) | 2-3 명(×2) | 4 명 이상(×1)

수정 난이도:
├─ 테스트 커버리지: 0%(×3) | <50%(×2) | 50-80%(×1.5) | >80%(×1)
├─ 문서: 없음(×2) | 불충분(×1.5) | 충분(×1)
├─ 의존 관계: 밀결합(×3) | 중간 정도(×2) | 소결합(×1)
└─ 변경 위험: Breaking Change(×3) | 호환성 고려(×2) | 안전(×1)

비용 환산:
├─ 시간 비용: 부채 시간 × 개발자 시급
├─ 기회 손실: 신기능 개발 지연 일수 × 일차 매출 영향
├─ 품질 비용: 버그 발생 확률 × 수정 비용 × 발생 빈도
└─ 총 비용: 시간 + 기회 손실 + 품질 비용
```

#### 우선순위 매트릭스

| 우선도                     | 영향도 | 수정 비용 | 대응 기한   | 구체예                          | 권장 액션                   |
| -------------------------- | ------ | --------- | ----------- | ------------------------------- | --------------------------- |
| **Critical(즉시 대응)**    | 높음   | 낮음      | 1 주일 이내 | God Object、순환 의존           | 즉시 리팩터링 시작          |
| **Important(계획적 대응)** | 높음   | 높음      | 1 개월 이내 | 대규모 책임 분리、아키텍처 변경 | 스프린트 계획에 포함        |
| **Watch(감시 대상)**       | 낮음   | 높음      | 3 개월 이내 | 복잡도가 높은 내부 처리         | 메트릭스 감시、악화 시 대응 |
| **Acceptable(허용 범위)**  | 낮음   | 낮음      | 대응 불요   | 경미한 코드의 냄새              | 통상 리팩터링으로 대응      |

### 리팩터링 수순

1. **현상 분석과 측정**
   - 복잡도 측정(순환적・인지적)
   - SOLID 스코어 산출(0-100 점)
   - 기술적 부채의 정량화(시간/비용)
   - 우선순위 매트릭스 작성

2. **단계적 실행**
   - 작은 스텝(15-30 분 단위)
   - 각 변경 후의 테스트 실행
   - 빈번한 커밋
   - SOLID 스코어의 계속 측정

3. **품질 확인**
   - 테스트 커버리지 유지
   - 퍼포먼스 측정
   - 기술적 부채의 삭감 확인
   - 코드 리뷰

### 자주 있는 코드의 냄새와 부채 스코어

| 코드의 냄새             | 검출 기준                   | 부채 스코어   | 개선 기법               |
| ----------------------- | --------------------------- | ------------- | ----------------------- |
| **God Object**          | 책임 >3, 메서드 >20         | 높음 (15-20h) | Extract Class, SRP 적용 |
| **Long Method**         | 행수 >50, 복잡도 >10        | 중간 (5-10h)  | Extract Method          |
| **Duplicate Code**      | 중복률 >30%                 | 높음 (10-15h) | Extract Method/Class    |
| **Large Class**         | 행수 >300, 메서드 >15       | 높음 (10-20h) | Extract Class           |
| **Long Parameter List** | 파라미터 >4                 | 낮음 (2-5h)   | Parameter Object        |
| **Feature Envy**        | 다른 클래스 참조 >5         | 중간 (5-10h)  | Move Method             |
| **Data Clumps**         | 같은 인수군의 반복          | 낮음 (3-5h)   | Extract Class           |
| **Primitive Obsession** | 프리미티브 타입의 과도 사용 | 중간 (5-8h)   | Replace with Object     |
| **Switch Statements**   | case >5                     | 중간 (5-10h)  | Strategy Pattern        |
| **Shotgun Surgery**     | 변경 시의 영향 개소 >3      | 높음 (10-15h) | Move Method/Field       |

### 실천 예：SOLID 스코어 평가

```javascript
// 평가 대상: UserService 클래스
class UserService {
  constructor(db, cache, logger, emailService) { // 4 개의 의존
    this.db = db;
    this.cache = cache;
    this.logger = logger;
    this.emailService = emailService;
  }

  // 책임 1: 인증
  authenticate(username, password) { /* ... */ }
  refreshToken(token) { /* ... */ }

  // 책임 2: 사용자 관리
  createUser(data) { /* ... */ }
  updateUser(id, data) { /* ... */ }
  deleteUser(id) { /* ... */ }

  // 책임 3: 알림
  sendWelcomeEmail(user) { /* ... */ }
  sendPasswordReset(email) { /* ... */ }
}

// SOLID 스코어 평가 결과
S: 10 점 (책임 3 개: 인증、CRUD、알림)
O: 5 점 (확장 포인트 없음、직접 구현)
L: 15 점 (상속 없음、해당 없음)
I: 10 점 (인터페이스 미분리)
D: 10 점 (구상 클래스 의존)
총합: 50 점 (Fair - 리팩터링 권장)

// 기술적 부채
복잡도: 15 (메서드 7 개、책임 3 개)
영향 범위: 8 (인증은 전 기능에서 사용)
수정 난이도: 2 (테스트 있음、문서 부족)
부채 시간: 15 × 8 × 2 = 240 시간
우선도: Critical (인증계는 즉시 대응)
```

### 개선 후의 구현 예

```javascript
// SOLID 원칙 적용 후 (스코어: 90 점)

// S: 단일 책임 (20 점)
class AuthenticationService {
  authenticate(credentials) { /* ... */ }
  refreshToken(token) { /* ... */ }
}

// O: 개방 폐쇄 (20 점)
class UserRepository {
  constructor(storage) { // Strategy Pattern
    this.storage = storage;
  }
  save(user) { return this.storage.save(user); }
}

// I: 인터페이스 분리 (20 점)
interface Readable {
  find(id);
  findAll();
}
interface Writable {
  save(entity);
  delete(id);
}

// D: 의존성 역전 (20 점)
class UserService {
  constructor(
    private auth: IAuthService,
    private repo: IUserRepository,
    private notifier: INotificationService
  ) {}
}

// 부채 삭감: 240 시간 → 20 시간 (92% 삭감)
```

### 자동화 지원

```bash
# SOLID 스코어 측정
npx solid-analyzer src/ --output report.json

# 복잡도 분석
npx complexity-report src/ --format json
sonar-scanner -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info

# 기술적 부채의 가시화
npx code-debt-analyzer --config .debt.yml

# 코드 포맷
npm run lint:fix
prettier --write src/

# 테스트 실행과 커버리지
npm test -- --coverage
npm run test:mutation  # 변이 테스트
```

### 주의사항

- **기능 변경의 금지**: 외부 동작을 바꾸지 않음
- **테스트 퍼스트**: 리팩터링 전에 테스트 추가
- **단계적 접근**: 한번에 큰 변경을 하지 않음
- **계속적 검증**: 각 스텝에서의 테스트 실행
