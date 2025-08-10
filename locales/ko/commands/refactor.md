## Refactor

안전하게 단계적으로 코드 리팩터링을 수행하고, SOLID 원칙 준수 여부를 평가합니다.

### 사용법

```bash
# 복잡한 코드 식별 및 리팩터링 계획
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"큰 파일을 리팩터링해서 복잡도를 줄여주세요"

# 중복 코드 탐지 및 통합
grep -r "function processUser" . --include="*.js"
"중복된 함수를 Extract Method 로 공통화하세요"

# SOLID 원칙 위반 탐지
grep -r "class.*Service" . --include="*.js" | head -10
"이 클래스들이 단일 책임 원칙을 따르는지 평가하세요"
```

### 기본 예시

```bash
# 긴 메서드 탐지
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"50 줄 이상의 메서드를 Extract Method 로 분할하세요"

# 조건 분기의 복잡도
grep -r "if.*if.*if" . --include="*.js"
"중첩된 조건문을 Strategy 패턴으로 개선하세요"

# 코드 스멜 탐지
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"기술적 부채가 되고 있는 주석을 해결하세요"
```

### 리팩터링 기법

#### Extract Method（메서드 추출）

```javascript
// Before: 길고 복잡한 메서드
function processOrder(order) {
  // 50 줄의 복잡한 처리
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
    case 'premium': return basPrice * 0.8;
    case 'regular': return basePrice;
  }
}

// After: Strategy 패턴
class PremiumPricing {
  calculate(basePrice) { return basePrice * 0.8; }
}
```

### SOLID 원칙 체크

```
S - Single Responsibility
├─ 각 클래스가 단일 책임을 가짐
├─ 변경 이유가 1 개로 한정됨
└─ 책임의 경계가 명확함

O - Open/Closed
├─ 확장에 대해 열려 있음
├─ 수정에 대해 닫혀 있음
└─ 새 기능 추가 시 기존 코드 보호

L - Liskov Substitution
├─ 파생 클래스의 치환 가능성
├─ 계약 준수
└─ 기대되는 동작 유지

I - Interface Segregation
├─ 적절한 단위의 인터페이스
├─ 사용하지 않는 메서드에 대한 의존 회피
└─ 역할별 인터페이스 정의

D - Dependency Inversion
├─ 추상화에 의존
├─ 구체적인 구현으로부터 분리
└─ 의존성 주입 활용
```

### 리팩터링 순서

1. **현황 분석**
   - 복잡도 측정（순환 복잡도）
   - 중복 코드 탐지
   - 의존관계 분석

2. **단계적 실행**
   - 작은 단계（15-30 분 단위）
   - 각 변경 후 테스트 실행
   - 빈번한 커밋

3. **품질 확인**
   - 테스트 커버리지 유지
   - 성능 측정
   - 코드 리뷰

### 흔한 코드 스멜

- **God Object**: 과도하게 많은 책임을 가진 클래스
- **Long Method**: 50 줄을 초과하는 긴 메서드
- **Duplicate Code**: 동일한 로직의 중복
- **Large Class**: 300 줄을 초과하는 큰 클래스
- **Long Parameter List**: 4 개 이상의 매개변수

### 자동화 지원

```bash
# 정적 분석
npx complexity-report src/
sonar-scanner

# 코드 포맷
npm run lint:fix
prettier --write src/

# 테스트 실행
npm test
npm run test:coverage
```

### 주의사항

- **기능 변경 금지**: 외부 동작을 바꾸지 않음
- **테스트 우선**: 리팩터링 전에 테스트 추가
- **단계적 접근**: 한 번에 큰 변경을 하지 않음
- **지속적 검증**: 각 단계에서 테스트 실행