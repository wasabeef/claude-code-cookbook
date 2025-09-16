## 角色帮助

迷茫时的角色选择指南和帮助系统。

### 使用方法

```bash
/role-help                      # 全面的角色选择指南
/role-help <情况/问题>          # 特定情况的推荐角色
/role-help compare <角色1>,<角色2> # 角色比较
```

### 基本示例

```bash
# 一般指导
/role-help
→ 显示可用角色及特点列表

# 情况别推荐
/role-help "担心 API 的安全性"
→ 推荐 security 角色及使用方法

# 角色比较
/role-help compare frontend,mobile
→ frontend 和 mobile 的区别与使用场景
```

### 情况别角色选择指南

### 安全相关

```text
这种情况使用 security 角色:
✅ 登录·认证功能的实现
✅ API 的安全漏洞检查
✅ 数据加密·隐私保护
✅ 安全合规性确认
✅ 渗透测试·渗透测试

使用方法: /role security
```

### 🏗️ 架构·设计

```text
这种情况使用 architect 角色:
✅ 系统整体设计评估
✅ 微服务 vs 单体判断
✅ 数据库设计·技术选型
✅ 可扩展性·扩展性考虑
✅ 技术债务评估·改进计划

使用方法: /role architect
```

### ⚡ 性能问题

```text
这种情况使用 performance 角色:
✅ 应用程序运行缓慢
✅ 数据库查询优化
✅ Web 页面加载速度改进
✅ 内存·CPU 使用量优化
✅ 扩展·负载对策

使用方法: /role performance
```

### 🔍 问题原因调查

```text
这种情况使用 analyzer 角色:
✅ Bug·错误的根本原因分析
✅ 系统故障原因究明
✅ 复杂问题的结构分析
✅ 数据分析·统计调查
✅ 为什么会发生这个问题的解明

使用方法: /role analyzer
```

### 🎨 前端·UI/UX

```text
这种情况使用 frontend 角色:
✅ 用户界面改进
✅ 可访问性支持
✅ 响应式设计
✅ 可用性·易用性提升
✅ Web 前端技术全般

使用方法: /role frontend
```

### 📱 移动应用开发

```text
这种情况使用 mobile 角色:
✅ iOS·Android 应用优化
✅ 移动特有的 UX 设计
✅ 触摸界面优化
✅ 离线支持·同步功能
✅ App Store·Google Play 支持

使用方法: /role mobile
```

### 👀 代码审查·质量

```text
这种情况使用 reviewer 角色:
✅ 代码质量检查
✅ 可读性·可维护性评估
✅ 编码规范确认
✅ 重构建议
✅ PR·提交审查

使用方法: /role reviewer
```

### 🧪 测试·质量保证

```text
这种情况使用 qa 角色:
✅ 测试策略制定
✅ 测试覆盖率评估
✅ 自动测试实施方针
✅ Bug 预防·质量提升策略
✅ CI/CD 中的测试自动化

使用方法: /role qa
```

### 需要多个角色的情况

### 🔄 multi-role (并行分析)

```text
这种情况使用 multi-role:
✅ 需要多个专业视角的评估
✅ 想制定综合改进计划
✅ 想比较各领域的评估
✅ 想整理矛盾·重复

例: /multi-role security,performance
```

### 🗣️ role-debate (辩论)

```text
这种情况使用 role-debate:
✅ 专业领域间存在权衡
✅ 技术选型有分歧
✅ 想通过辩论决定设计方针
✅ 想听取不同视角的辩论

例: /role-debate security,performance
```

### 🤖 smart-review (自动建议)

```text
这种情况使用 smart-review:
✅ 不知道该使用哪个角色
✅ 想了解当前情况的最佳方法
✅ 想从多个选项中选择
✅ 初学者不知如何判断

例: /smart-review
```

### 角色比较表

### 安全系

| 角色     | 主要用途      | 擅长领域           | 不擅长领域       |
| -------- | ------------- | ------------------ | ---------------- |
| security | 漏洞·攻击对策 | 威胁分析、认证设计 | UX、性能         |
| analyzer | 根本原因分析  | 逻辑分析、证据收集 | 预防策、未来规划 |

### 设计系

| 角色      | 主要用途 | 擅长领域           | 不擅长领域         |
| --------- | -------- | ------------------ | ------------------ |
| architect | 系统设计 | 长期视角、全局优化 | 详细实现、短期解决 |
| reviewer  | 代码质量 | 实现级别、可维护性 | 业务需求、UX       |

### 性能系

| 角色        | 主要用途    | 擅长领域     | 不擅长领域 |
| ----------- | ----------- | ------------ | ---------- |
| performance | 高速化·优化 | 测量、瓶颈   | 安全性、UX |
| qa          | 质量保证    | 测试、自动化 | 设计、架构 |

### 用户体验系

| 角色     | 主要用途  | 擅长领域         | 不擅长领域    |
| -------- | --------- | ---------------- | ------------- |
| frontend | Web UI/UX | 浏览器、可访问性 | 服务器端、DB  |
| mobile   | 移动 UX   | 触摸、离线支持   | 服务器端、Web |

### 迷茫时的流程图

```text
问题的性质是？
├─ 安全相关 → security
├─ 性能问题 → performance
├─ Bug·故障调查 → analyzer
├─ UI/UX 改进 → frontend or mobile
├─ 设计·架构 → architect
├─ 代码质量 → reviewer
├─ 测试相关 → qa
└─ 复合·复杂 → smart-review 建议

跨越多个领域？
├─ 想要综合分析 → multi-role
├─ 辩论·权衡 → role-debate
└─ 不知如何判断 → smart-review
```

### 常见问题

### Q: frontend 和 mobile 的区别是？

```text
A:
frontend: 以 Web 浏览器为中心、HTML/CSS/JavaScript
mobile: 以移动应用为中心、iOS/Android 原生·React Native 等

两者都相关时推荐 multi-role frontend,mobile
```

### Q: security 和 analyzer 的使用场景？

```text
A:
security: 攻击·威胁预防、安全设计
analyzer: 已发生问题的原因分析、调查

安全事件调查使用 multi-role security,analyzer
```

### Q: architect 和 performance 的区别是？

```text
A:
architect: 系统整体的长期设计、扩展性
performance: 具体的速度·效率改进

大规模系统的性能设计使用 multi-role architect,performance
```

### 与 Claude 的协作

```bash
# 结合情况说明
/role-help
"React 应用页面加载慢，用户投诉很多"

# 结合文件内容
cat problem-description.md
/role-help
"推荐适合这个问题的角色"

# 特定选项的迷茫
/role-help compare security,performance
"JWT 令牌有效期问题该用哪个角色？"
```

### 注意事项

- 复杂问题多角色组合更有效
- 紧急性高时使用 single role 快速应对
- 迷茫时推荐使用 smart-review 获得自动建议
- 最终判断请用户根据问题性质决定
