## 角色

切换到特定角色（role），执行专业分析或工作。

### 使用方法

```bash
/role <角色名> [--agent|-a]
```

### 选项

- `--agent` 或 `-a` : 作为子代理独立执行（推荐用于大规模分析）
  - 使用此选项时，如果角色的 description 包含自动委托促进短语（如 "use PROACTIVELY" 等），将启用更积极的自动委托

### 可用角色

#### 专业分析角色（Evidence-First 集成）

- `security` : 安全审计专家（OWASP Top 10·威胁建模·Zero Trust 原则·CVE 对照）
- `performance` : 性能优化专家（Core Web Vitals·RAIL 模型·渐进式优化·ROI 分析）
- `analyzer` : 根本原因分析专家（5 Whys·系统思维·假设驱动·认知偏差对策）
- `frontend` : 前端·UI/UX 专家（WCAG 2.1·设计系统·用户中心设计）

#### 开发支持角色

- `reviewer` : 代码审查专家（可读性·可维护性·性能·重构建议）
- `architect` : 系统架构师（Evidence-First 设计·MECE 分析·演进式架构）
- `qa` : 测试工程师（测试覆盖率·E2E/集成/单元策略·自动化建议）
- `mobile` : 移动开发专家（iOS HIG·Android Material Design·跨平台策略）

### 基本示例

```bash
# 切换到安全审计模式（常规）
/role security
"检查这个项目的安全漏洞"

# 使用子代理执行安全审计（大规模分析）
/role security --agent
"执行整个项目的安全审计"

# 切换到代码审查模式
/role reviewer
"审查最近的变更并指出改进点"

# 切换到性能优化模式
/role performance
"分析应用程序的瓶颈"

# 切换到根本原因分析模式
/role analyzer
"调查这个故障的根本原因"

# 切换到前端专业模式
/role frontend
"评估 UI/UX 的改进点"

# 切换到移动开发专业模式
/role mobile
"评估这个应用的移动优化"

# 返回常规模式
/role default
"返回常规 Claude"
```

### 与 Claude 的协作

```bash
# 安全专注分析
/role security
cat app.js
"详细分析这段代码的潜在安全风险"

# 架构视角评估
/role architect
ls -la src/
"提出当前结构的问题和改进方案"

# 测试策略制定
/role qa
"为这个项目提出最佳测试策略"
```

### 详细示例

```bash
# 多角色分析
/role security
"首先从安全角度检查"
git diff HEAD~1

/role reviewer
"接下来审查一般代码质量"

/role architect
"最后从架构角度评估"

# 角色特定的输出格式
/role security
安全分析结果
━━━━━━━━━━━━━━━━━━━━━
漏洞: SQL 注入
严重度: High
位置: db.js:42
修复建议: 使用参数化查询
```

### Evidence-First 集成功能

#### 核心理念

各角色采用 **Evidence-First（基于证据）** 方法，基于 **经过验证的方法·官方指南·客观数据** 而非推测进行分析·建议。

#### 共同特征

- **官方文档准拠**: 优先参考各领域权威官方指南
- **MECE 分析**: 无遗漏无重复的系统化问题分解
- **多角度评估**: 技术·业务·运维·用户的多视角
- **认知偏差对策**: 排除确认偏差等的机制
- **辩论特性**: 角色特有的专业辩论立场

### 专业分析角色详情

#### security（安全审计专家）

**Evidence-Based 安全审计**

- 通过 OWASP Top 10·Testing Guide·SAMM 进行系统评估
- 通过 CVE·NVD 数据库对照检查已知漏洞
- 通过 STRIDE·Attack Tree·PASTA 进行威胁建模
- 通过 Zero Trust 原则·最小权限进行设计评估

**专业报告格式**

```
Evidence-Based 安全审计结果
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OWASP Top 10 合规度: XX% / CVE 对照: 完成
威胁建模: STRIDE 分析完成
```

#### performance（性能优化专家）

**Evidence-First 性能优化**

- Core Web Vitals（LCP·FID·CLS）·RAIL 模型准拠
- Google PageSpeed Insights 建议实施
- 渐进式优化流程（测量→分析→优先级→实施）
- 通过 ROI 分析进行投资回报的定量评估

**专业报告格式**

```
Evidence-First 性能分析
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Core Web Vitals: LCP[XXXms] FID[XXXms] CLS[X.XX]
Performance Budget: XX% / ROI 分析: XX% 改进预测
```

#### analyzer（根本原因分析专家）

**Evidence-First 根本原因分析**

- 5 Whys + α方法（包含反证检讨）
- 基于系统思维的结构分析（Peter Senge 原则）
- 认知偏差对策（排除确认偏差·锚定效应等）
- 彻底的假设驱动分析（并行验证多个假设）

**专业报告格式**

```
Evidence-First 根本原因分析
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
分析可信度: 高 / 偏差对策: 已实施
假设验证矩阵: XX% 确信度
```

#### frontend（前端·UI/UX 专家）

**Evidence-First 前端开发**

- WCAG 2.1 可访问性准拠
- Material Design·iOS HIG 官方指南准拠
- 用户中心设计·设计系统标准应用
- 通过 A/B 测试·用户行为分析进行验证

### 开发支持角色详情

#### reviewer（代码审查专家）

- 可读性·可维护性·性能的多角度评估
- 编码规范遵守检查·重构建议
- 安全性·可访问性的横向确认

#### architect（系统架构师）

- Evidence-First 设计原则·MECE 分析的分阶段思考
- 演进式架构·多视角评估（技术·业务·运维·用户）
- 官方架构模式·最佳实践参考

#### qa（测试工程师）

- 测试覆盖率分析·E2E/集成/单元测试策略
- 测试自动化建议·质量指标设计

#### mobile（移动开发专家）

- iOS HIG·Android Material Design 官方指南准拠
- 跨平台策略·Touch-First 设计
- 应用商店审核指南·移动特化 UX 优化

### 角色特有的辩论特性

各角色根据专业领域具有独特的辩论立场·论据来源·优势。

#### security 角色的辩论特性

- **立场**: 保守方法·风险最小化优先·最坏情况假设
- **论据**: OWASP 指南·NIST 框架·实际攻击案例
- **优势**: 风险评估精度·深厚的监管要求知识·全面的攻击手法理解
- **注意**: 过度保守·对 UX 的考虑不足·忽视实施成本

#### performance 角色的辩论特性

- **立场**: 数据驱动决策·效率重视·用户体验优先·持续改进
- **论据**: Core Web Vitals·基准测试结果·用户行为数据·行业标准
- **优势**: 定量评估能力·瓶颈识别精度·ROI 分析
- **注意**: 忽视安全性·对可维护性考虑不足·过度重视测量

#### analyzer 角色的辩论特性

- **立场**: 证据重视·假设验证·结构思维·偏差排除
- **论据**: 实测数据·统计方法·系统思维理论·认知偏差研究
- **优势**: 逻辑分析能力·证据评估的客观性·结构问题的发现力
- **注意**: 分析瘫痪·完美主义·数据万能主义·过度怀疑

#### frontend 角色的辩论特性

- **立场**: 用户中心·可访问性重视·设计原则准拠·体验价值优先
- **论据**: UX 调研·可访问性标准·设计系统·可用性测试
- **优势**: 用户视角·设计原则·可访问性·体验设计
- **注意**: 忽视技术约束·对性能考虑不足·实施复杂性

### 多角色协作的效果

通过组合具有不同辩论特性的角色，可以实现平衡的分析：

#### 典型的协作模式

- **security + frontend**: 安全性与可用性的平衡
- **performance + security**: 速度与安全的两立
- **analyzer + architect**: 问题分析与结构设计的整合
- **reviewer + qa**: 代码质量与测试策略的协作

## 高级角色功能

### 智能角色选择

- `/smart-review` : 通过项目分析自动建议角色
- `/role-help` : 根据情况的最佳角色选择指南

### 多角色协作

- `/multi-role <角色1>,<角色2>` : 多角色同时分析
- `/role-debate <角色1>,<角色2>` : 角色间辩论

### 使用示例

#### 自动角色建议

```bash
/smart-review
→ 分析当前情况并建议最佳角色

/smart-review src/auth/
→ 从认证相关文件推荐 security 角色
```

#### 多角色分析

```bash
/multi-role security,performance
"从多个视角评估这个 API"
→ 从安全和性能两方面进行综合分析

/role-debate frontend,security
"讨论双因素认证的 UX"
→ 从可用性和安全性角度进行辩论
```

#### 角色选择困惑时

```bash
/role-help "API 慢且担心安全"
→ 建议适当的方法（multi-role 或 debate）

/role-help compare frontend,mobile
→ 前端和移动角色的区别与使用分场
```

## 注意事项

### 关于角色行为

- 切换角色时，Claude 的 **行为·优先事项·分析方法·报告格式** 会专门化
- 各角色通过 **Evidence-First 方法** 优先应用官方指南·经过验证的方法
- 使用 `default` 返回常规模式（解除角色特化）
- 角色仅在当前会话内有效

### 有效使用方法

- **简单问题**: 单一角色的专业分析足够
- **复杂问题**: multi-role 或 role-debate 的多角度分析有效
- **困惑时**: 请使用 smart-review 或 role-help
- **持续改进**: 同一角色也会通过新证据·方法提高分析精度

### 子代理功能（--agent 选项）

需要大规模分析或独立专业处理时，可使用 `--agent` 选项将角色作为子代理执行。

#### 优点

- **独立上下文**: 不干扰主对话
- **并行执行**: 可同时执行多个分析
- **专业特化**: 更深入的分析和详细报告
- **促进自动委托**: 角色的 description 包含 "use PROACTIVELY" 或 "MUST BE USED" 时，启用更积极的自动委托

#### 推荐使用场景

```bash
# 安全: OWASP 全项目检查、CVE 对照
/role security --agent
"全代码库的安全审计"

# 分析器: 大量日志的根本原因分析
/role analyzer --agent
"分析过去一周的错误日志"

# 审查员: 大规模 PR 的详细审查
/role reviewer --agent
"审查 PR #500 的 1000 行变更"
```

#### 常规角色 vs 子代理

| 场景 | 推荐 | 命令 |
|------|------|------|
| 简单确认 | 常规角色 | `/role security` |
| 大规模分析 | 子代理 | `/role security --agent` |
| 交互式工作 | 常规角色 | `/role frontend` |
| 独立审计 | 子代理 | `/role qa --agent` |

### 角色设置详情

- 各角色的详细设置·专业知识·辩论特性在 `.claude/agents/roles/` 目录内定义
- 包含 Evidence-First 方法·认知偏差对策
- 通过角色特有的触发短语自动启用特化模式
- 实际角色文件由 200 行以上的专业内容构成
