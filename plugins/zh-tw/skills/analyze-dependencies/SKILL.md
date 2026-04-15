---
description: "分析專案依賴關係並評估架構健全性。「分析依賴關係」「檢測循環依賴」「架構問題？」「檢查模組耦合」「查找層違規」等觸發。"
allowed-tools:
  - Read
  - Grep
  - Glob
---

# 分析專案依賴關係並評估架構健全性

分析項目的依賴關系，評估架構的健康狀况。

## 使用方法

```bash
/dependency-analysis [選項]
```

## 選項

- `--visual` : 可視化顯示依賴關系
- `--circular` : 仅檢測循環依賴
- `--depth <數值>` : 指定分析深度 (默認: 3)
- `--focus <路徑>` : 聚焦于特定模塊/目錄

## 基本示例

```bash
# 整個項目的依賴關系分析
/dependency-analysis

# 檢測循環依賴
/dependency-analysis --circular

# 特定模塊的詳细分析
/dependency-analysis --focus src/core --depth 5
```

## 分析項目

### 1. 依賴關系矩阵

數值化顯示模塊間的依賴關系：

- 直接依賴
- 間接依賴
- 依賴深度
- 扇入/扇出

### 2. 架構违規檢測

- 層級违規 (下層依賴上層)
- 循環依賴
- 過度耦合 (高依賴度)
- 孤立模塊

### 3. Clean Architecture 合規性檢查

- 領域層的独立性
- 基礎設施層的適当分離
- 用例層的依賴方向
- 接口的應用情况

## 輸出示例

```text
依賴關系分析報告
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 指標概覽
├─ 模塊總數: 42
├─ 平均依賴數: 3.2
├─ 最大依賴深度: 5
└─ 循環依賴: 檢測到 2 個

⚠️  架構违規
├─ [HIGH] src/domain/user.js → src/infra/database.js
│  └─ 領域層直接依賴基礎設施層
├─ [MED] src/api/auth.js ⟲ src/services/user.js
│  └─ 檢測到循環依賴
└─ [LOW] src/utils/helper.js → 12 modules
   └─ 扇出過度

✅ 建議操作
1. 引入 UserRepository 接口
2. 重新設計認證服務的职責
3. 按功能拆分辅助函數

📈 依賴關系圖
[用 ASCII 艺術顯示可視化依賴關系圖]
```

## 高級用法

```bash
# CI/CD 管道中的自動檢查
/dependency-analysis --circular --fail-on-violation

# 定義和驗證架構規則
/dependency-analysis --rules .architecture-rules.yml

# 追蹤依賴關系的時間變化
/dependency-analysis --compare HEAD~10
```

## 配置文件示例 (.dependency-analysis.yml)

```yaml
rules:
  - name: "Domain Independence"
    source: "src/domain/**"
    forbidden: ["src/infra/**", "src/api/**"]

  - name: "API Layer Dependencies"
    source: "src/api/**"
    allowed: ["src/domain/**", "src/application/**"]
    forbidden: ["src/infra/**"]

thresholds:
  max_dependencies: 8
  max_depth: 4
  coupling_threshold: 0.7

ignore:
  - "**/test/**"
  - "**/mocks/**"
```

## 集成工具

- `madge` : JavaScript/TypeScript 依賴關系可視化
- `dep-cruiser` : 依賴關系規則驗證
- `nx` : 單體倉庫依賴關系管理
- `plato` : 復杂度與依賴關系综合分析

## 與 Claude 的協作

```bash
# 包含 package.json 的分析
cat package.json
/analyze-dependencies
"分析這個項目的依賴關系問題"

# 結合特定模塊的源代碼
ls -la src/core/
/analyze-dependencies --focus src/core
"詳细評估核心模塊的依賴關系"

# 與架構文檔對比
cat docs/architecture.md
/analyze-dependencies --visual
"確認設計文檔與實現的差異"
```

## 注意事項

- **前提條件**: 需要在項目根目錄執行
- **限制事項**: 大型項目的分析可能需要较长時間
- **建議事項**: 發現循環依賴時應立即考虑處理

## 最佳實践

1. **定期分析**: 每週檢查依賴關系的健康狀况
2. **規則明文化**: 通過配置文件管理架構規則
3. **渐進式改進**: 避免大規模重構，逐步改進
4. **指標追蹤**: 監控依賴關系復杂度的時間序列
