## Flutter Dependencies Update

Flutter 프로젝트의 의존성을 안전하게 업데이트합니다.

### 사용법

```bash
# 의존성의 상태를 확인해서 Claude 에 의뢰
flutter pub deps --style=compact
「pubspec.yaml 의 의존성을 최신 버전으로 업데이트하세요」
```

### 기본 예제

```bash
# 현재 의존성을 확인
cat pubspec.yaml
「이 Flutter 프로젝트의 의존성을 분석해서 업데이트 가능한 패키지를 알려주세요」

# 업그레이드 후의 확인
flutter pub upgrade --dry-run
「이 업그레이드 예정 내용에서 파괴적 변경이 있는지 확인하세요」
```

### Claude 와의 연계

```bash
# 포괄적인 의존성 업데이트
cat pubspec.yaml
「Flutter 의 의존성을 분석하고, 다음을 실행하세요:
1. 각 패키지의 최신 버전을 조사
2. 파괴적 변경의 유무를 확인
3. 위험도를 평가（안전·주의·위험）
4. 필요한 코드 변경을 제안
5. 업데이트판 pubspec.yaml 을 생성」

# 안전한 단계적 업데이트
flutter pub outdated
「메이저 버전 업을 피하고, 안전하게 업데이트 가능한 패키지만 업데이트하세요」

# 특정 패키지의 업데이트 영향 분석
「provider 를 최신 버전으로 업데이트한 경우의 영향과 필요한 변경을 알려주세요」
```

### 상세 예제

```bash
# Release Notes 를 포함한 상세 분석
cat pubspec.yaml && flutter pub outdated
「의존성을 분석하고, 각 패키지에 대해:
1. 현재 → 최신 버전
2. 위험도 평가（안전·주의·위험）
3. 주요 변경점（CHANGELOG 에서）
4. 필요한 코드 수정
을 테이블 형식으로 제시하세요」

# Null Safety 이전의 분석
cat pubspec.yaml
「Null Safety 에 대응하지 않는 패키지를 특정하고, 이전 계획을 세워주세요」
```

### 위험도의 기준

```
안전（🟢）：
- 패치 버전 업（1.2.3 → 1.2.4）
- 버그 수정만
- 후방 호환성 보장

주의（🟡）：
- 마이너 버전 업（1.2.3 → 1.3.0）
- 새로운 기능 추가
- 비권장 경고 있음

위험（🔴）：
- 메이저 버전 업（1.2.3 → 2.0.0）
- 파괴적 변경
- API 의 삭제·변경
```

### 업데이트의 실행

```bash
# 백업 생성
cp pubspec.yaml pubspec.yaml.backup
cp pubspec.lock pubspec.lock.backup

# 업데이트 실행
flutter pub upgrade

# 업데이트 후의 확인
flutter analyze
flutter test
flutter pub deps --style=compact
```

### 주의사항

업데이트 후에는 반드시 동작 확인을 실시하세요. 문제가 발생한 경우는 다음으로 복원：

```bash
cp pubspec.yaml.backup pubspec.yaml
cp pubspec.lock.backup pubspec.lock
flutter pub get
```