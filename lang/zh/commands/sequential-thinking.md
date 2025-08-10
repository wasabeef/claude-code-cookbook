## 顺序思考

通过动态且迭代的思考过程，逐步解决复杂问题。这是一种在思考过程中可以调整方向和重新审视的灵活方法。

### 使用方法

```bash
# 请求 Claude 进行分阶段思考
「请用 sequential-thinking 考虑[课题]」
```

### 基本示例

```bash
# 算法设计
「请用 sequential-thinking 设计高效的缓存策略」

# 问题解决
「请用 sequential-thinking 解决数据库性能问题」

# 设计探讨
「请用 sequential-thinking 探讨实时通知系统的设计」
```

### 与 Claude 配合

```bash
# 复杂的实现方针
「请用 sequential-thinking 探讨认证系统的实现方针。考虑 OAuth2、JWT、会话管理」

# Bug 原因分析
「请用 sequential-thinking 分析内存泄漏的原因。包含代码审查和性能分析结果」

# 重构策略
cat src/complex_module.js
「请用 sequential-thinking 制定此模块的重构策略」

# 技术选型
「请用 sequential-thinking 分析前端框架的选择。考虑项目需求和约束」
```

### 思考过程

1. **初始分析** - 基本理解和分解问题
2. **假设生成** - 建立解决方案的假设
3. **验证与修正** - 验证假设，必要时修正
4. **分支与探索** - 探索多个解决路径
5. **整合与结论** - 得出最优解

### 特点

- **动态调整** - 可在思考过程中转换方向
- **假设验证** - 建立假设并验证的循环
- **分支思考** - 同时探索多个思考路径
- **逐步细化** - 逐步优化解决方案
- **灵活性** - 基于新信息调整方针

### 详细示例

```bash
# 复杂系统设计
「请用 sequential-thinking 探讨电商网站的微服务设计。包括订单处理、库存管理、支付的协作」

# 安全设计
「请用 sequential-thinking 探讨 API 安全设计。包括认证、授权、速率限制、审计日志」

# 性能优化
「请用 sequential-thinking 探讨大规模数据处理的优化。考虑内存使用、处理速度、可扩展性」

# 依赖管理
「请用 sequential-thinking 探讨 monorepo 的依赖管理策略。包括构建时间、部署、测试执行」
```

### 注意事项

sequential-thinking 最适合需要逐步深化思考的复杂问题。对于简单问题或有明确答案的情况，请使用常规的提问形式。

### 执行示例

```bash
# 使用示例
「请用 sequential-thinking 探讨 GraphQL Schema 的设计」

# 预期行为
# 1. 初始分析：分析 GraphQL Schema 的基本需求
# 2. 假设生成：探讨多种设计模式
# 3. 验证：验证各模式的优缺点
# 4. 分支：必要时探索新方法
# 5. 整合：提出最优的 Schema 设计
```
