## 技術债務

分析項目的技術债務，創建按優先級排序的改進計劃。

### 使用方法

```bash
# 確認項目結構並分析技術债務
ls -la
「分析這個項目的技術债務並創建改進計劃」
```

### 基本示例

```bash
# 分析 TODO/FIXME 注釋
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
「按優先級整理這些 TODO 注釋並制定改進計劃」

# 確認項目依賴關系
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
「分析項目的依賴關系，識別過時的依賴和風險」

# 檢測大文件和復杂函數
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -exec wc -l {} + | sort -rn | head -10
「識別過大的文件和復杂的結構，提出改進方案」
```

### 與 Claude 配合

```bash
# 全面的技術债務分析
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
「從以下角度分析這個項目的技術债務：
1. 代碼質量（復杂度、重復、可維護性）
2. 依賴關系健康度
3. 安全風險
4. 性能問題
5. 測試覆蓋不足」

# 架構债務分析
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
「識別架構層面的技術债務，提出重構計劃」

# 按優先級排序的改進計劃
「按以下標準評估技術债務並以表格形式展示：
- 影響度（高/中/低）
- 修復成本（時間）
- 業務風險
- 改進效果
- 推薦實施時期」
```

### 詳细示例

```bash
# 自動檢測項目類型並分析
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
「基于檢測到的項目類型，分析以下內容：
1. 語言和框架特定的技術债務
2. 偏離最佳實践的情况
3. 現代化機會
4. 分阶段改進策略」

# 代碼質量指標分析
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
「分析項目的代碼質量，展示以下指標：
- 循環復杂度高的函數
- 重復代碼檢測
- 過长的文件/函數
- 缺乏適当的錯誤處理」

# 安全债務檢測
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
「檢測安全相關的技術债務，提出修復優先級和對策」

# 測試不足分析
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
「分析測試覆蓋的技術债務，提出測試策略」
```

### 注意事項

- 自動檢測項目的語言和框架，進行相應的分析
- 技術债務分為「需要立即修復的重要問題」和「长期改進項目」
- 提供考虑業務價值和技術改進平衡的現實計劃
- 也考虑改進的 ROI（投資回報率）
