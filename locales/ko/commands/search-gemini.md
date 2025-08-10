## Gemini Web Search

Gemini CLI 로 웹 검색을 실행하여 최신 정보를 취득합니다.

### 사용법

```bash
# Gemini CLI 경유로 웹 검색 (필수)
gemini --prompt "WebSearch: <검색 쿼리>"
```

### 기본 예제

```bash
# Gemini CLI 사용
gemini --prompt "WebSearch: React 19 신기능"
gemini --prompt "WebSearch: TypeError Cannot read property of undefined 해결방법"
```

### Claude 와의 연계

```bash
# 문서 검색과 요약
gemini --prompt "WebSearch: Next.js 14 App Router 공식 문서"
「검색 결과를 요약하여 주요 기능을 설명하세요」

# 에러 조사
cat error.log
gemini --prompt "WebSearch: [에러메시지] 해결방법"
「검색 결과에서 가장 적절한 해결방법을 제안하세요」

# 기술 비교
gemini --prompt "WebSearch: Rust vs Go performance benchmark 2024"
「검색 결과에서 성능 차이를 정리하세요」
```

### 상세 예제

```bash
# 복수 소스로부터 정보 수집
gemini --prompt "WebSearch: GraphQL best practices 2024 multiple sources"
「검색 결과에서 복수의 신뢰할 수 있는 소스의 정보를 정리하세요」

# 시계열 변화를 조사
gemini --prompt "WebSearch: JavaScript ES2015 ES2016 ES2017 ES2018 ES2019 ES2020 ES2021 ES2022 ES2023 ES2024 features"
「각 버전의 주요 변경사항을 시계열로 정리하세요」

# 특정 도메인으로 한정한 검색
gemini --prompt "WebSearch: site:github.com Rust WebAssembly projects stars:>1000"
「스타 수가 많은 순으로 10 개 프로젝트를 리스트업하세요」

# 최신 보안 정보
gemini --prompt "WebSearch: CVE-2024 Node.js vulnerabilities"
「발견된 취약점의 영향과 대책을 정리하세요」
```

### 금지 사항

- **Claude 의 내장 WebSearch 도구 사용은 금지**
- 웹 검색이 필요한 경우는 반드시 `gemini --prompt "WebSearch: ..."`를 사용할 것

### 주의사항

- **Gemini CLI 가 이용 가능한 경우는 반드시 `gemini --prompt "WebSearch: ..."`를 사용하세요**
- 웹 검색 결과는 항상 최신이라고 할 수 없습니다
- 중요한 정보는 공식 문서나 신뢰할 수 있는 소스에서 확인하는 것을 권장합니다