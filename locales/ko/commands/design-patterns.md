## 디자인 패턴

코드베이스에 적용 가능한 디자인 패턴을 제안하고 SOLID 원칙의 준수 여부을 평가합니다.

### 사용법

```bash
/design-patterns [분석대상] [옵션]
```

### 옵션

- `--suggest` : 적용 가능한 패턴 제안 (기본값)
- `--analyze` : 기존 패턴의 사용 현황 분석
- `--refactor` : 리팩터링 안 생성
- `--solid` : SOLID 원칙 준수 여부 체크
- `--anti-patterns` : 안티패턴 검출

### 기본 사용 예시

```bash
# 프로젝트 전체의 패턴 분석
/design-patterns

# 특정 파일에 대한 패턴 제안
/design-patterns src/services/user.js --suggest

# SOLID 원칙 체크
/design-patterns --solid

# 안티패턴 검출
/design-patterns --anti-patterns
```

### 분석 카테고리

#### 1. 생성 관련 패턴

- **Factory Pattern**: 객체 생성의 추상화
- **Builder Pattern**: 복잡한 객체의 단계적 구축
- **Singleton Pattern**: 인스턴스의 유일성 보장
- **Prototype Pattern**: 객체의 클론 생성

#### 2. 구조 관련 패턴

- **Adapter Pattern**: 인터페이스의 변환
- **Decorator Pattern**: 기능의 동적 추가
- **Facade Pattern**: 복잡한 서브시스템의 단순화
- **Proxy Pattern**: 객체에 대한 접근 제어

#### 3. 행동 관련 패턴

- **Observer Pattern**: 이벤트 통지 구현
- **Strategy Pattern**: 알고리즘의 전환
- **Command Pattern**: 조작의 캡슐화
- **Iterator Pattern**: 컬렉션의 순회

### SOLID 원칙 체크 항목

```
S - Single Responsibility Principle (단일 책임 원칙)
O - Open/Closed Principle (개방 폐쇄 원칙)
L - Liskov Substitution Principle (리스코프 치환 원칙)
I - Interface Segregation Principle (인터페이스 분리 원칙)
D - Dependency Inversion Principle (의존성 역전 원칙)
```

### 출력 예시

```
디자인 패턴 분석 리포트
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

현재 사용 중인 패턴
├─ Observer Pattern: EventEmitter (12 곳)
├─ Factory Pattern: UserFactory (3 곳)
├─ Singleton Pattern: DatabaseConnection (1 곳)
└─ Strategy Pattern: PaymentProcessor (5 곳)

권장 패턴
├─ [HIGH] Repository Pattern
│  └─ 대상: src/models/*.js
│  └─ 이유: 데이터 접근 로직의 분리
│  └─ 예시:
│      class UserRepository {
│        async findById(id) { ... }
│        async save(user) { ... }
│      }
│
├─ [MED] Command Pattern
│  └─ 대상: src/api/handlers/*.js
│  └─ 이유: 요청 처리의 통일화
│
└─ [LOW] Decorator Pattern
   └─ 대상: src/middleware/*.js
   └─ 이유: 기능 조합 개선

SOLID 원칙 위반
├─ [S] UserService: 인증과 권한 관리 모두 담당
├─ [O] PaymentGateway: 새 결제수단 추가 시 수정 필요
├─ [D] EmailService: 구상 클래스에 직접 의존
└─ [I] IDataStore: 사용되지 않는 메서드 포함

리팩터링 제안
1. UserService 를 인증과 권한 관리로 분할
2. PaymentStrategy 인터페이스 도입
3. EmailService 인터페이스 정의
4. IDataStore 를 용도별로 분리
```

### 고급 사용 예시

```bash
# 패턴 적용의 영향 분석
/design-patterns --impact-analysis Repository

# 특정 패턴의 구현 예시 생성
/design-patterns --generate Factory --for src/models/Product.js

# 패턴의 조합 제안
/design-patterns --combine --context "API with caching"

# 아키텍처 패턴의 평가
/design-patterns --architecture MVC
```

### 패턴 적용 예시

#### Before (문제가 있는 코드)

```javascript
class OrderService {
  processOrder(order, paymentType) {
    if (paymentType === "credit") {
      // 신용카드 처리
    } else if (paymentType === "paypal") {
      // PayPal 처리
    }
    // 기타 결제 방법...
  }
}
```

#### After (Strategy Pattern 적용)

```javascript
// 전략 인터페이스
class PaymentStrategy {
  process(amount) {
    throw new Error("Must implement process method");
  }
}

// 구상 전략
class CreditCardPayment extends PaymentStrategy {
  process(amount) {
    /* 구현 */
  }
}

// 컨텍스트
class OrderService {
  constructor(paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
  }

  processOrder(order) {
    this.paymentStrategy.process(order.total);
  }
}
```

### 안티패턴 검출

- **God Object**: 과도하게 많은 책무를 가진 클래스
- **Spaghetti Code**: 제어 흐름이 복잡하게 얽힌 코드
- **Copy-Paste Programming**: 중복 코드의 과도한 사용
- **Magic Numbers**: 하드코딩된 상수
- **Callback Hell**: 깊게 중첩된 콜백

### 베스트 프랙티스

1. **점진적 적용**: 한 번에 많은 패턴을 적용하지 않기
2. **필요성 검증**: 패턴은 문제 해결의 수단이지 목적이 아님
3. **팀 합의**: 패턴 적용 전에 팀에서 논의
4. **문서화**: 적용한 패턴의 의도를 기록