## 多角色分析

通过多个角色并行分析同一对象，并生成综合报告的命令。

### 使用方法

```bash
/multi-role <角色 1>,<角色 2> [--agent|-a] [分析对象]
/multi-role <角色 1>,<角色 2>,<角色 3> [--agent|-a] [分析对象]
```

**重要**:

- `--agent` 选项请放在角色指定之后
- 消息请写在 `--agent` 之后
- 正确示例: `/multi-role qa,architect --agent 评估这个计划`
- 错误示例: `/multi-role qa,architect 评估这个计划 --agent`

### 选项

- `--agent` 或 `-a` : 将每个角色作为子代理并行执行（大规模分析时推荐）
  - 使用此选项时，如果角色描述中包含自动委托促进短语（如"use PROACTIVELY"），将启用更积极的自动委托

### 基本示例

```bash
# 安全和性能双方面分析（常规）
/multi-role security,performance
「评估这个API端点」

# 大规模系统并行分析（子代理）
/multi-role security,performance --agent
「全面分析系统的安全性和性能」

# 前端、移动和性能的综合分析
/multi-role frontend,mobile,performance
「探讨这个界面的优化方案」

# 架构设计的多角度评估（子代理）
/multi-role architect,security,performance --agent
「评估微服务化的设计」
```

### 分析流程

### 阶段1: 并行分析

每个角色独立分析同一对象

- 从专业角度进行评估
- 基于角色特定标准进行判断
- 生成独立的建议

### 阶段2: 综合分析

结构化并整合结果

- 整理各角色的评估结果
- 识别重复和矛盾点
- 明确互补关系

### 阶段3: 综合报告

生成最终建议

- 优先级行动计划
- 明确权衡关系
- 提供实施路线图

### 输出格式示例

### 2角色分析的情况

```
多角色分析: Security + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

分析对象: API端点 /api/users

Security分析结果:
认证: JWT验证已适当实现
授权: 基于角色的访问控制不完善
加密: API密钥以明文形式记录日志

评分: 65/100
重要性: High（因为涉及敏感数据访问）

Performance分析结果:
响应时间: 平均180ms（目标200ms以内）
数据库查询: 检测到N+1问题
缓存: 未实现Redis缓存

评分: 70/100
重要性: Medium（当前在可接受范围内）

相互关系分析:
协同效应机会:
- 实现Redis缓存时同时考虑加密
- 改善日志输出提升安全性和性能

权衡点:
- 加强授权检查 ↔ 对响应时间的影响
- 日志加密 ↔ 调试效率降低

综合优先级:
Critical: 修复API密钥明文输出
High: 解决N+1查询问题
Medium: 实现Redis缓存 + 加密
Low: 细化授权控制

实施路线图:
第1周: 实现API密钥掩码
第2周: 优化数据库查询
第3-4周: 设计和实现缓存层
第2个月: 逐步加强授权控制
```

### 3角色分析的情况

```
多角色分析: Frontend + Mobile + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

分析对象: 用户资料页面

Frontend分析结果:
可用性: 布局直观
可访问性: WCAG 2.1合规率85%
响应式: 平板显示存在问题

Mobile分析结果:
触摸目标: 确保44pt以上
单手操作: 重要按钮位于上部
离线支持: 未实现

Performance分析结果:
初始加载: LCP 2.1秒（良好）
图像优化: 未支持WebP
延迟加载: 未实现

综合建议:
1. 移动优化（单手操作 + 离线支持）
2. 图像优化（WebP + 延迟加载）
3. 平板UI改进

优先级: Mobile > Performance > Frontend
实施周期: 3-4周
```

### 有效的组合模式

### 安全重视

```bash
/multi-role security,architect
「认证系统设计」

/multi-role security,frontend
「登录页面安全」

/multi-role security,mobile
「移动应用数据保护」
```

### 性能重视

```bash
/multi-role performance,architect
「可扩展性设计」

/multi-role performance,frontend
「网页加速」

/multi-role performance,mobile
「应用性能优化」
```

### 用户体验重视

```bash
/multi-role frontend,mobile
「跨平台UI」

/multi-role frontend,performance
「UX与性能的平衡」

/multi-role mobile,performance
「移动UX优化」
```

### 全面分析

```bash
/multi-role architect,security,performance
「系统整体评估」

/multi-role frontend,mobile,performance
「用户体验综合评估」

/multi-role security,performance,mobile
```