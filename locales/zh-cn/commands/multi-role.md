## 多角色分析

使用多个角色并行分析同一对象，生成综合报告的命令。

### 使用方法

```bash
/multi-role <角色 1>,<角色 2> [--agent|-a] [分析对象]
/multi-role <角色 1>,<角色 2>,<角色 3> [--agent|-a] [分析对象]
```

### 可用角色

#### 专业分析角色

- `security` : 安全审计专家
- `performance` : 性能优化专家
- `analyzer` : 根本原因分析专家
- `frontend` : 前端·UI/UX 专家
- `mobile` : 移动开发专家
- `backend` : 后端与服务器端专家

#### 开发支持角色

- `reviewer` : 代码审查专家
- `architect` : 系统架构师
- `qa` : 测试工程师

**重要**:

- `--agent` 选项需要放在角色指定之后
- 消息要写在 `--agent` 之后
- 正确示例: `/multi-role qa,architect --agent 评估计划`
- 错误示例: `/multi-role qa,architect 评估计划 --agent`

### 选项

- `--agent` 或 `-a` : 将各角色作为子代理并行执行 (推荐用于大规模分析)
  - 使用此选项时，如果角色的 description 中包含自动委托促进短语 (如 "use PROACTIVELY" 等)，将启用更积极的自动委托

### 基本示例

```bash
# 安全和性能的双重分析 (常规)
/multi-role security,performance
"评估这个 API 端点"

# 大规模系统的并行分析 (子代理)
/multi-role security,performance --agent
"全面分析系统的安全性和性能"

# 前端·移动·性能的综合分析
/multi-role frontend,mobile,performance
"考虑这个界面的优化方案"

# 架构设计的多角度评估 (子代理)
/multi-role architect,security,performance --agent
"评估微服务化的设计"
```

### 分析流程

### 阶段 1: 并行分析

各角色独立分析同一对象

- 从专业视角进行评估
- 按角色特有标准判定
- 生成独立的建议

### 阶段 2: 综合分析

结构化整合结果

- 整理各角色的评估结果
- 识别重复·矛盾点
- 明确互补关系

### 阶段 3: 综合报告

生成最终建议

- 带优先级的行动计划
- 明示权衡取舍
- 提供实施路线图

### 输出格式示例

### 2 角色分析的情况

```text
多角色分析: Security + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

分析对象: API 端点 /api/users

Security 分析结果:
认证: JWT 验证实施得当
授权: 基于角色的访问控制不完整
加密: API 密钥在日志中以明文输出

评估分数: 65/100
重要度: High(因为访问敏感数据)

Performance 分析结果:
响应时间: 平均 180ms(目标 200ms 以内)
数据库查询: 检测到 N+1 问题
缓存: Redis 缓存未实施

评估分数: 70/100
重要度: Medium(目前在可接受范围内)

相互关联分析:
协同效应机会:
- 实施 Redis 缓存时同时考虑加密
- 改进日志输出提升安全性和性能

权衡点:
- 加强授权检查 ↔ 对响应时间的影响
- 日志加密 ↔ 调试效率降低

综合优先级:
Critical: 修复 API 密钥明文输出
High: 解决 N+1 查询
Medium: 实施 Redis 缓存 + 加密
Low: 细化授权控制

实施路线图:
第 1 周: 实施 API 密钥屏蔽
第 2 周: 优化数据库查询
第 3-4 周: 设计·实施缓存层
第 2 月: 逐步加强授权控制
```

### 3 角色分析的情况

```text
多角色分析: Frontend + Mobile + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

分析对象: 用户资料界面

Frontend 分析结果:
可用性: 直观的布局
可访问性: WCAG 2.1 符合率 85%
响应式: 平板显示有问题

Mobile 分析结果:
触摸目标: 确保 44pt 以上
单手操作: 重要按钮在上方
离线支持: 未实施

Performance 分析结果:
初始显示: LCP 2.1 秒 (良好)
图像优化: 不支持 WebP
延迟加载: 未实施

综合建议:
1. 移动优化 (单手操作 + 离线支持)
2. 图像优化 (WebP + 延迟加载)
3. 改进平板 UI

优先级: Mobile > Performance > Frontend
实施期间: 3-4 周
```

### 有效的组合模式

### 安全重视

```bash
/multi-role security,architect
"认证系统的设计"

/multi-role security,frontend
"登录界面的安全性"

/multi-role security,mobile
"移动应用的数据保护"
```

### 性能重视

```bash
/multi-role performance,architect
"可扩展性设计"

/multi-role performance,frontend
"Web 页面高速化"

/multi-role performance,mobile
"应用运行优化"
```

### 用户体验重视

```bash
/multi-role frontend,mobile
"跨平台 UI"

/multi-role frontend,performance
"UX 与性能的平衡"

/multi-role mobile,performance
"移动 UX 优化"
```

### 全面分析

```bash
/multi-role architect,security,performance
"系统整体评估"

/multi-role frontend,mobile,performance
"用户体验综合评估"

/multi-role security,performance,mobile
"移动应用综合诊断"
```

### 与 Claude 的协作

```bash
# 结合文件分析
cat src/components/UserProfile.tsx
/multi-role frontend,mobile
"从多个视角评估这个组件"

# 设计文档评估
cat architecture-design.md
/multi-role architect,security,performance
"从多个专业领域评估这个设计"

# 错误分析
cat performance-issues.log
/multi-role performance,analyzer
"多角度分析性能问题"
```

### multi-role vs role-debate 的使用区分

### 使用 multi-role 的场合

- 需要各专业领域的独立评估
- 想制定综合改进计划
- 需要整理矛盾或重复
- 要决定实施优先级

### 使用 role-debate 的场合

- 专业领域间存在权衡
- 技术选型可能有分歧
- 想通过讨论决定设计方针
- 想听取不同视角的辩论

### 子代理并行执行 (--agent)

使用 `--agent` 选项时，各角色作为独立的子代理并行执行。

#### 自动委托的促进

当角色文件的 description 字段包含以下短语时，使用 `--agent` 会启用更积极的自动委托：

- "use PROACTIVELY"
- "MUST BE USED"
- 其他强调表达

#### 执行流程

```text
常规执行:
角色 1 → 角色 2 → 角色 3 → 综合
(顺序执行，约 3-5 分钟)

--agent 执行:
角色 1 ─┐
角色 2 ─┼→ 综合
角色 3 ─┘
(并行执行，约 1-2 分钟)
```

#### 有效使用示例

```bash
# 大规模系统的综合评估
/multi-role architect,security,performance,qa --agent
"新系统的全面评估"

# 多视角的详细分析
/multi-role frontend,mobile,performance --agent
"所有界面的 UX 优化分析"
```

#### 性能比较

| 角色数 | 常规执行 | --agent 执行 | 缩短率 |
| ------ | -------- | ------------ | ------ |
| 2 角色 | 2-3 分钟 | 1 分钟       | 50%    |
| 3 角色 | 3-5 分钟 | 1-2 分钟     | 60%    |
| 4 角色 | 5-8 分钟 | 2-3 分钟     | 65%    |

### 注意事项

- 同时执行 3 个以上角色时输出会变长
- 复杂分析可能需要更长执行时间
- 出现相互矛盾的建议时，也可考虑 role-debate
- 最终判断请参考综合结果由用户决定
- **使用 --agent 时**: 会使用更多资源，但对大规模分析更高效

### 角色配置详情

- 各角色的详细配置、专业知识与讨论特性都定义在 `.claude/agents/roles/` 目录中
- 包含 Evidence-First 方法与认知偏差对策
- 角色专属触发短语会自动启用特化模式
