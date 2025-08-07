## 依赖关系分析

分析项目的依赖关系，评估架构的健全性。

### 使用方法

```bash
/dependency-analysis [选项]
```

### 选项

- `--visual` : 可视化显示依赖关系
- `--circular` : 仅检测循环依赖
- `--depth <数值>` : 指定分析深度（默认：3）
- `--focus <路径>` : 聚焦特定模块/目录

### 基本示例

```bash
# 分析整个项目的依赖关系
/dependency-analysis

# 检测循环依赖
/dependency-analysis --circular

# 详细分析特定模块
/dependency-analysis --focus src/core --depth 5
```

### 分析项目

#### 1. 依赖关系矩阵

将模块间的依赖关系量化显示：

- 直接依赖
- 间接依赖
- 依赖深度
- 扇入/扇出

#### 2. 架构违规检测

- 层级违规（下层依赖上层）
- 循环依赖
- 过度耦合（高依赖度）
- 孤立模块

#### 3. Clean Architecture 合规性检查

- 领域层的独立性
- 基础设施层的适当分离
- 用例层的依赖方向
- 接口的应用情况

### 输出示例

```
依赖关系分析报告
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 指标概述
├─ 总模块数: 42
├─ 平均依赖数: 3.2
├─ 最大依赖深度: 5
└─ 循环依赖: 检测到 2 处

⚠️ 架构违规
├─ [高] src/domain/user.js → src/infra/database.js
│  └─ 领域层直接依赖基础设施层
├─ [中] src/api/auth.js ⟲ src/services/user.js
│  └─ 检测到循环依赖
└─ [低] src/utils/helper.js → 12 modules
   └─ 过度扇出

✅ 推荐操作
1. 引入 UserRepository 接口
2. 重新设计认证服务的职责
3. 按功能拆分辅助函数

📈 依赖关系图
[用 ASCII 艺术显示的可视化依赖关系图]
```

### 高级使用示例

```bash
# 在 CI/CD 管道中自动检查
/dependency-analysis --circular --fail-on-violation

# 定义和验证架构规则
/dependency-analysis --rules .architecture-rules.yml

# 跟踪依赖关系随时间的变化
/dependency-analysis --compare HEAD~10
```

### 配置文件示例 (.dependency-analysis.yml)

```yaml
rules:
  - name: "领域独立性"
    source: "src/domain/**"
    forbidden: ["src/infra/**", "src/api/**"]

  - name: "API 层依赖"
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

### 集成工具

- `madge` : JavaScript/TypeScript 依赖关系可视化
- `dep-cruiser` : 依赖关系规则验证
- `nx` : 单体仓库的依赖关系管理
- `plato` : 复杂度和依赖关系的综合分析

### 与 Claude 协作

```bash
# 包含 package.json 的分析
cat package.json
/analyze-dependencies
「分析这个项目的依赖关系问题」

# 结合特定模块的源代码
ls -la src/core/
/analyze-dependencies --focus src/core
「详细评估核心模块的依赖关系」

# 与架构文档比较
cat docs/architecture.md
/analyze-dependencies --visual
「确认设计文档与实现的差距」
```

### 注意事项

- **前提条件**: 需要在项目根目录执行
- **限制事项**: 大规模项目的分析可能需要较长时间
- **推荐事项**: 发现循环依赖后应立即考虑处理

### 最佳实践

1. **定期分析**: 每周检查依赖关系的健全性
2. **规则明确化**: 用配置文件管理架构规则
3. **逐步改进**: 避免大规模重构，渐进式改善
4. **指标跟踪**: 随时间监控依赖关系的复杂度