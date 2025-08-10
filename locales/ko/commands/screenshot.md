## Screenshot

macOS 에서 스크린샷을 촬영하고 이미지를 분석합니다.

### 사용법

```bash
/screenshot [옵션]
```

### 옵션

- 없음 : 윈도우를 선택 (Claude 가 옵션을 확인)
- `--window` : 윈도우를 지정하여 촬영
- `--full` : 화면 전체를 촬영
- `--crop` : 범위를 선택하여 촬영

### 기본 예제

```bash
# 윈도우를 촬영하여 분석
/screenshot --window
「촬영한 화면을 분석하세요」

# 범위를 선택하여 분석
/screenshot --crop
「선택한 범위의 내용을 설명하세요」

# 전체 화면을 촬영하여 분석
/screenshot --full
「화면 전체의 구성을 분석하세요」
```

### Claude 와의 연계

```bash
# 특정 문제 없음 - 상황 분석
/screenshot --crop
(Claude 가 자동으로 화면 내용을 분석하여 요소나 구성을 설명)

# UI/UX 문제 분석
/screenshot --window
「이 UI 의 문제점과 개선안을 제안하세요」

# 에러 분석
/screenshot --window
「이 에러 메시지의 원인과 해결 방법을 알려주세요」

# 디자인 리뷰
/screenshot --full
「이 디자인을 UX 관점으로 평가하세요」

# 코드 분석
/screenshot --crop
「이 코드의 문제점을 지적하세요」

# 데이터 시각화 분석
/screenshot --crop
「이 그래프에서 읽을 수 있는 경향을 분석하세요」
```

### 상세 예제

```bash
# 여러 관점으로 분석
/screenshot --window
「이 화면에 대해 다음을 분석하세요:
1. UI 의 일관성
2. 접근성 문제
3. 개선 제안」

# 비교 분석용으로 복수 촬영
/screenshot --window
# (before 이미지를 저장)
# 변경을 가함
/screenshot --window
# (after 이미지를 저장)
「before 와 after 이미지를 비교하여 변경점과 개선 효과를 분석하세요」

# 특정 요소에 포커스
/screenshot --crop
「선택한 버튼의 디자인이 다른 요소와 조화를 이루고 있는지 평가하세요」
```

### 금지 사항

- **스크린샷을 촬영하지 않았는데 「촬영했습니다」라고 말하는 것은 금지**
- **존재하지 않는 이미지 파일의 분석을 시도하는 것은 금지**
- **`/screenshot` 명령어는 실제 스크린샷 촬영을 수행하지 않음**

### 주의사항

- 옵션을 지정하지 않은 경우, 다음 선택지를 제시하세요:

  ```
  「어떤 방법으로 스크린샷을 촬영하시겠습니까?
  1. 윈도우를 선택 (--window) → screencapture -W
  2. 화면 전체 (--full) → screencapture -x
  3. 범위를 선택 (--crop) → screencapture -i」
  ```

- 사용자가 screencapture 명령을 실행한 후에 이미지 분석을 시작하세요
- 구체적인 문제나 관점을 지정하면 더 집중된 분석이 가능합니다
