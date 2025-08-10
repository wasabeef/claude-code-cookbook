## Tech Debt

프로젝트의 기술적 부채를 분석하고, 우선순위가 지정된 개선 계획을 작성합니다.

### 사용법

```bash
# 프로젝트 구성을 확인하고 기술적 부채를 분석
ls -la
"이 프로젝트의 기술적 부채를 분석하고 개선 계획을 작성하세요"
```

### 기본 예시

```bash
# TODO/FIXME 코멘트 분석
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
"이러한 TODO 코멘트를 우선순위 순으로 정리하고 개선 계획을 세워주세요"

# 프로젝트 의존관계 확인
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
"프로젝트의 의존관계를 분석하고 오래된 것과 리스크를 식별하세요"

# 큰 파일이나 복잡한 함수 탐지
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -exec wc -l {} + | sort -rn | head -10
"너무 큰 파일이나 복잡한 구조를 식별하고 개선안을 제시하세요"
```

### Claude 와의 연동

```bash
# 포괄적인 기술적 부채 분석
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
"이 프로젝트의 기술적 부채를 다음 관점으로 분석해주세요:
1. 코드 품질（복잡도, 중복, 유지보수성）
2. 의존관계 건전성
3. 보안 리스크
4. 성능 문제
5. 테스트 커버리지 부족"

# 아키텍처 부채 분석
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
"아키텍처 레벨의 기술적 부채를 식별하고, 리팩터링 계획을 제안하세요"

# 우선순위가 지정된 개선 계획
"기술적 부채를 다음 기준으로 평가하고 표 형식으로 제시해주세요:
- 영향도（높음/중간/낮음）
- 수정 비용（시간）
- 비즈니스 리스크
- 개선에 따른 효과
- 권장 실시 시기"
```

### 상세 예시

```bash
# 프로젝트 타입 자동 탐지 및 분석
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
"탐지된 프로젝트 타입을 기반으로 다음을 분석해주세요:
1. 언어·프레임워크 고유의 기술적 부채
2. 베스트 프랙티스로부터의 이탈
3. 현대화 기회
4. 단계적 개선 전략"

# 코드 품질 지표 분석
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
"프로젝트의 코드 품질을 분석하고 다음 지표을 제시해주세요:
- 순환 복잡도가 높은 함수
- 중복 코드 탐지
- 너무 긴 파일/함수
- 적절한 에러 핸들링 부재"

# 보안 부채 탐지
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
"보안 관련 기술적 부채를 탐지하고, 수정 우선순위와 대책을 제안하세요"

# 테스트 부족 분석
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
"테스트 커버리지의 기술적 부채를 분석하고, 테스트 전략을 제안하세요"
```

### 주의사항

- 프로젝트의 언어나 프레임워크를 자동으로 탐지하고, 그에 따른 분석을 수행합니다
- 기술적 부채는 "즉시 수정해야 할 중요한 문제"와 "장기적으로 개선할 항목"으로 분류됩니다
- 비즈니스 가치와 기술적 개선의 균형을 고려한 현실적인 계획을 제공합니다
- 개선에 따른 ROI（투자 대비 효과）도 고려합니다