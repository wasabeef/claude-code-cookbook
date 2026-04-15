---
description: "分析项目依赖关系并评估架构健全性。「分析依赖关系」「检测循环依赖」「架构问题？」「检查模块耦合」「查找层违规」等触发。"
allowed-tools:
  - Read
  - Grep
  - Glob
---

# 分析项目依赖关系并评估架构健全性

分析项目的依赖关系，评估架构的健康状况。

## 使用方法

```bash
/dependency-analysis [选项]
```

## 选项

- `--visual` : 可视化显示依赖关系
- `--circular` : 仅检测循环依赖
- `--depth <数值>` : 指定分析深度 (默认: 3)
- `--focus <路径>` : 聚焦于特定模块/目录

## 基本示例

```bash
# 整个项目的依赖关系分析
/dependency-analysis

# 检测循环依赖
/dependency-analysis --circular

# 特定模块的详细分析
/dependency-analysis --focus src/core --depth 5
```

## 分析项目

### 1. 依赖关系矩阵

数值化显示模块间的依赖关系：

- 直接依赖
- 间接依赖
- 依赖深度
- 扇入/扇出

### 2. 架构违规检测

- 层级违规 (下层依赖上层)
- 循环依赖
- 过度耦合 (高依赖度)
- 孤立模块

### 3. Clean Architecture 合规性检查

- 领域层的独立性
- 基础设施层的适当分离
- 用例层的依赖方向
- 接口的应用情况

## 输出示例

```text
依赖关系分析报告
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 指标概览
├─ 模块总数: 42
├─ 平均依赖数: 3.2
├─ 最大依赖深度: 5
└─ 循环依赖: 检测到 2 个

⚠️  架构违规
├─ [HIGH] src/domain/user.js → src/infra/database.js
│  └─ 领域层直接依赖基础设施层
├─ [MED] src/api/auth.js ⟲ src/services/user.js
│  └─ 检测到循环依赖
└─ [LOW] src/utils/helper.js → 12 modules
   └─ 扇出过度

✅ 建议操作
1. 引入 UserRepository 接口
2. 重新设计认证服务的职责
3. 按功能拆分辅助函数

📈 依赖关系图
[用 ASCII 艺术显示可视化依赖关系图]
```

## 高级用法

```bash
# CI/CD 管道中的自动检查
/dependency-analysis --circular --fail-on-violation

# 定义和验证架构规则
/dependency-analysis --rules .architecture-rules.yml

# 追踪依赖关系的时间变化
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

- `madge` : JavaScript/TypeScript 依赖关系可视化
- `dep-cruiser` : 依赖关系规则验证
- `nx` : 单体仓库依赖关系管理
- `plato` : 复杂度与依赖关系综合分析

## 与 Claude 的协作

```bash
# 包含 package.json 的分析
cat package.json
/analyze-dependencies
"分析这个项目的依赖关系问题"

# 结合特定模块的源代码
ls -la src/core/
/analyze-dependencies --focus src/core
"详细评估核心模块的依赖关系"

# 与架构文档对比
cat docs/architecture.md
/analyze-dependencies --visual
"确认设计文档与实现的差异"
```

## 注意事项

- **前提条件**: 需要在项目根目录执行
- **限制事项**: 大型项目的分析可能需要较长时间
- **建议事项**: 发现循环依赖时应立即考虑处理

## 最佳实践

1. **定期分析**: 每周检查依赖关系的健康状况
2. **规则明文化**: 通过配置文件管理架构规则
3. **渐进式改进**: 避免大规模重构，逐步改进
4. **指标追踪**: 监控依赖关系复杂度的时间序列
