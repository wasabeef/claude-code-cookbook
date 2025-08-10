## Rust Dependencies Update

Rust 프로젝트의 의존성을 안전하게 업데이트합니다.

### 사용법

```bash
# 의존성의 상태를 확인해서 Claude 에 의뢰
cargo tree
「Cargo.toml 의 의존성을 최신 버전으로 업데이트하세요」
```

### 기본 예제

```bash
# 현재 의존성을 확인
cat Cargo.toml
「이 Rust 프로젝트의 의존성을 분석해서 업데이트 가능한 크레이트를 알려주세요」

# 업데이트 가능한 일람을 확인
cargo update --dry-run
「이 크레이트들의 업데이트에서의 위험도를 분석하세요」
```

### Claude 와의 연계

```bash
# 포괄적인 의존성 업데이트
cat Cargo.toml
「Rust 의 의존성을 분석하고, 다음을 실행하세요:
1. 각 크레이트의 최신 버전을 조사
2. 파괴적 변경의 유무를 확인
3. 위험도를 평가（안전·주의·위험）
4. 필요한 코드 변경을 제안
5. 업데이트판 Cargo.toml 을 생성」

# 안전한 단계적 업데이트
cargo tree
「메이저 버전 업을 피하고, 안전하게 업데이트 가능한 크레이트만 업데이트하세요」

# 특정 크레이트의 업데이트 영향 분석
「tokio 를 최신 버전으로 업데이트한 경우의 영향과 필요한 변경을 알려주세요」
```

### 상세 예제

```bash
# Release Notes 를 포함한 상세 분석
cat Cargo.toml && cargo tree
「의존성을 분석하고, 각 크레이트에 대해:
1. 현재 → 최신 버전
2. 위험도 평가（안전·주의·위험）
3. 주요 변경점（CHANGELOG 에서）
4. 트레이트 경계의 변경
5. 필요한 코드 수정
을 테이블 형식으로 제시하세요」

# 비동기 런타임의 이전 분석
cat Cargo.toml src/main.rs
「async-std 에서 tokio 로의 이전, 또는 tokio 의 메이저 버전 업에 필요한 변경을 모두 제시하세요」
```

### 위험도의 기준

```
안전（🟢）：
- 패치 버전 업（0.1.2 → 0.1.3）
- 버그 수정만
- 후방 호환성 보장

주의（🟡）：
- 마이너 버전 업（0.1.0 → 0.2.0）
- 새로운 기능 추가
- 비권장 경고 있음

위험（🔴）：
- 메이저 버전 업（0.x.y → 1.0.0、1.x.y → 2.0.0）
- 파괴적 변경
- API 의 삭제·변경
- 트레이트 경계의 변경
```

### 업데이트의 실행

```bash
# 백업 생성
cp Cargo.toml Cargo.toml.backup
cp Cargo.lock Cargo.lock.backup

# 업데이트 실행
cargo update

# 업데이트 후의 확인
cargo check
cargo test
cargo clippy
```

### 주의사항

업데이트 후에는 반드시 동작 확인을 실시하세요. 문제가 발생한 경우는 다음으로 복원：

```bash
cp Cargo.toml.backup Cargo.toml
cp Cargo.lock.backup Cargo.lock
cargo build
```
