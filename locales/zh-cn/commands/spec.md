## Spec

**「在编写代码之前赋予结构」** - 完全遵循 Kiro 的规格驱动开发

与传统代码生成工具不同，实现 Kiro 的规格驱动开发，重点是为开发的混沌赋予结构。从最少的需求输入，逐步展开到产品经理级别的详细规格和可实施的设计，**从原型到生产环境**保证一致的质量。

### 使用方法

```bash
# 请求 Claude 的 Spec Mode(最少需求输入)
「创建[功能描述]的 spec」

# Kiro 式分阶段展开：
# 1. 简单需求 → 自动生成详细用户故事
# 2. 使用 EARS 记法的结构化需求描述
# 3. 通过分阶段对话精细化规格
# 4. 生成 3 个独立文件：
#    - requirements.md: EARS 记法的需求定义
#    - design.md: 包含 Mermaid 图、TypeScript 接口的设计
#    - tasks.md: 自动应用最佳实践的实施计划
```

### 实证效果(Kiro 实绩)

**2 天完成安全文件共享应用**

```bash
「创建文件共享系统(支持加密)的 spec」
→ 2 天完成生产级别的加密文件共享应用
→ 自动应用安全最佳实践
→ 无需额外提示
```

**新手一晚开发游戏**

```bash
「创建 2D 益智游戏的 spec」
→ 游戏开发新手的开源开发者
→ 一晚完成游戏创建
→ 实现逻辑由 Kiro 处理，开发者专注创造性
```

**周末从原型到生产**

```bash
「创建电商网站商品管理系统的 spec」
→ 一个周末从概念到可运行的原型
→ 从原型到生产环境的一致质量
→ 通过 spec-driven development 的结构化方法
```

### 基本示例

```bash
# 新功能的 spec 创建(最少输入)
「商品评论系统
- 星级评分功能
- 评论发布
- 图片上传」

# 系统功能的 spec 创建
「用户认证
- OAuth 支持
- 多因素认证」

# API 功能的 spec 创建
「支付系统 API
- Stripe 集成
- 重视安全性」
```

### 与 Claude 配合

```bash
# 复杂功能 spec
「创建聊天功能的 spec。包括 WebSocket、实时通知、历史管理」

# 数据库关联功能 spec
「创建电商网站库存管理功能的 spec。包括商品添加、库存更新、警报功能」

# 前端功能 spec
「创建 React 仪表板的 spec。包括图表显示、筛选器、导出功能」

# 后端功能 spec
「创建 RESTful API 的 spec。包括认证、验证、日志记录」
```

### Spec Mode 的特点

**分阶段对话工作流**

- 完全再现 Kiro 的核心价值——分阶段讨论
- 在各阶段与用户合作精细化规格
- 经过疑问解决、选项讨论、批准流程后生成文件

**3 阶段的交互式展开**

- **Phase 1**: Requirements Discovery → 讨论 → 批准 → 生成 `requirements.md`
- **Phase 2**: Design Exploration → 讨论 → 批准 → 生成 `design.md`
- **Phase 3**: Implementation Planning → 讨论 → 批准 → 生成 `tasks.md`

**动态规格制定**

- 通过对话解决需求的模糊性
- 提示和讨论技术选项
- 说明权衡并确认判断

### 详细示例

```bash
# 复杂系统功能
「创建在线支付系统的 spec。包括 Stripe 集成、安全性、错误处理」

# 前端功能
「创建 React 组件的 spec。包括状态管理、属性设计、测试」

# 后端功能
「创建 GraphQL API 的 spec。包括 Schema 设计、解析器、认证」

# DevOps 功能
「创建 CI/CD 管道的 spec。包括测试自动化、部署、监控」
```

### 分阶段对话工作流(Phase by Phase)

#### Phase 1: Requirements Discovery & Discussion

**1. 从最少输入自动扩展(Kiro 式)**

```
用户：「用户管理系统
- 登录功能
- 个人资料编辑
- 管理员权限」

Claude：「从需求生成详细用户故事。
这个理解正确吗？

自动生成的用户故事：
- 用户注册和认证功能(支持 OAuth)
- 个人资料管理功能(头像、设置)
- 权限管理功能(RBAC)
- 密码重置功能
- 安全审计日志

已补充未明确的细节。还需要其他功能吗？」
```

**2. 使用 EARS 记法的结构化需求描述**

```
Claude：「使用 Kiro 的 EARS 记法结构化需求：

EARS 记法需求定义：

WHEN 用户尝试登录时
GIVEN 输入正确的邮箱和密码
THEN 系统确认认证
AND 成功时重定向到仪表板

WHILE 用户在个人资料编辑页面时
THE SYSTEM SHALL 实时执行验证
AND 预览显示更改内容

WHERE 需要管理员权限的功能
IS 尝试访问时
THE SYSTEM SHALL 确认权限级别
AND 不足时拒绝访问」
```

**3. 边缘情况和安全需求的自动补充**

```
Claude：「基于 Kiro 的最佳实践，还考虑了以下情况：

安全需求(自动补充)：
- 暴力攻击对策
- 会话管理和超时
- CSRF 保护和 XSS 对策
- 密码强度要求

边缘情况(自动检测)：
- 同时登录限制
- 账户锁定功能
- 数据迁移时的一致性保证
- 大量请求时的负载均衡

这些需求合适吗？」
```

**5. Phase 1 完成和批准**

```
Claude：「Requirements Phase 已完成。
可以生成 requirements.md 吗？」
→ 「继续」→ 生成 requirements.md
```

#### Phase 2: Design Exploration & Discussion

**1. 代码库分析 + 自动设计建议(Kiro 式)**

```
Claude：「分析现有代码库，提出最佳架构：

代码库分析结果：
- 认证：JWT + Express.js(v4.18.x)
- 数据库：PostgreSQL(v14+)
- 前端：React + TypeScript(v18+)
- 现有模式：Repository 模式、Service 层分离

Kiro 推荐架构：
- 符合 Clean Architecture
- Domain-Driven Design 元素
- 部分应用 CQRS 模式
- 自动化的安全最佳实践

使用这个设计吗？」
```

**2. 使用 Mermaid 图的可视化设计**

```
Claude：「自动生成系统设计的 Mermaid 图：

自动生成的架构图：

graph TB
    Client[React Client] --> API[Express API Gateway]
    API --> Auth[Auth Service]
    API --> User[User Service]
    API --> Profile[Profile Service]

    Auth --> AuthDB[(Auth Database)]
    User --> UserDB[(User Database)]
    Profile --> ProfileDB[(Profile Database)]

    Auth --> JWT[JWT Service]
    Auth --> OAuth[OAuth Provider]

还需要生成数据流图吗？」
```

**3. TypeScript 接口自动生成**

```
Claude：「基于设计自动生成 TypeScript 接口：

自动生成的 TypeScript 接口：

// Domain entities
interface User {
  readonly id: UserId;
  readonly email: Email;
  readonly profile: UserProfile;
  readonly auth: AuthSettings;
  readonly permissions: Permission[];
  readonly createdAt: Date;
  readonly updatedAt: Date;
}

interface UserProfile {
  readonly displayName: string;
  readonly avatar: AvatarUrl;
  readonly preferences: UserPreferences;
}

interface AuthSettings {
  readonly passwordHash: PasswordHash;
  readonly mfaEnabled: boolean;
  readonly lastLoginAt: Date;
  readonly failedAttempts: number;
}

// Use cases
interface UserRepository {
  findById(id: UserId): Promise<User | null>;
  findByEmail(email: Email): Promise<User | null>;
  save(user: User): Promise<void>;
}

interface AuthenticationService {
  authenticate(credentials: LoginCredentials): Promise<AuthResult>;
  refreshToken(token: RefreshToken): Promise<AccessToken>;
}

使用这个接口设计吗？」
```

**4. Phase 2 完成和批准**
```

Claude：「Design Phase 已完成。
可以生成 design.md 吗？」
→ 「继续」→ 生成 design.md

```

#### Phase 3: Implementation Planning & Discussion

**1. 最佳实践自动应用(Kiro 式)**
```

Claude：「生成了自动应用 Kiro 最佳实践的实施计划：

自动生成的实施策略：

1. 安全第一开发
   - 自动集成 OWASP Top 10 对策
   - 自动实现加密和哈希
   - 自动生成安全测试

2. 强制清洁架构
   - 自动实现层分离
   - 自动应用依赖倒置
   - 强制可测试设计

3. 性能优化
   - 自动实现缓存策略
   - 数据库优化
   - 利用异步处理

使用这个方法吗？」

```

**2. 质量检查点自动设置**
```

Claude：「自动设置各实施阶段的质量检查点：

自动质量保证流程：

Phase 3a: 后端实施

- [ ] 安全扫描(SAST/DAST)
- [ ] API 规范测试(OpenAPI 合规)
- [ ] 性能测试(负载和响应)
- [ ] 漏洞扫描(依赖关系和 CVE)

Phase 3b: 前端实施

- [ ] 无障碍测试(WCAG 2.1 AA)
- [ ] 浏览器兼容性测试
- [ ] 响应式设计验证
- [ ] 安全头确认

Phase 3c: 集成和部署

- [ ] E2E 测试套件
- [ ] CI/CD 管道配置
- [ ] 监控和日志设置
- [ ] 生产环境安全审计

全部自动执行。有额外的质量标准吗？」

```

**3. 依赖关系和风险缓解的自动分析**
```

Claude：「自动分析实施顺序和风险缓解策略：

优化的实施顺序：

Week 1: 基础设施和安全基础

- 数据库设计和模式创建
- 认证基础(JWT + 会话管理)
- 安全中间件实施
- 基本 API 端点

Week 2: 核心功能实施

- 用户管理功能
- 个人资料管理功能
- 权限管理系统
- 验证和错误处理

Week 3: 高级功能和优化

- 多因素认证实施
- 审计日志功能
- 性能优化
- 前端集成

自动检测的风险缓解策略：

- 多因素认证：分阶段引入(SMS→应用认证)
- 会话管理：Redis 集群配置
- 大量访问：速率限制 + CDN 利用
- 数据一致性：加强事务管理

这个计划没有问题吗？」

```

**4. Phase 3 完成和批准**
```

Claude：「Implementation Planning Phase 已完成。
可以生成 tasks.md 吗？」
→ 「继续」→ 生成 tasks.md

```

### Kiro 特有的功能

**EARS 记法 (Easy Approach to Requirements Syntax)**

```
# Kiro 标准的 EARS 记法模式

WHEN [情况・触发器]
GIVEN [前提条件]
THEN [系统行为]
AND [额外行为]

WHILE [状态・流程]
THE SYSTEM SHALL [必须行为]
AND [相关行为]

WHERE [功能・组件]
IS [条件・状态]
THE SYSTEM SHALL [对应行为]
```

**自动生成功能**

- **Mermaid 图**: 自动生成架构和数据流图
- **TypeScript 接口**: 基于设计自动创建类型定义
- **最佳实践**: 自动集成安全和性能对策
- **质量检查点**: 自动设置分阶段质量标准

**hooks 联动**

- 文件保存时的自动质量检查
- 自动应用代码标准
- 自动执行安全扫描
- 自动验证 OWASP Top 10 对策

**原型→生产质量保证**

- 通过结构化方法的一致设计
- 强制安全第一开发
- 自动应用可扩展架构
- 集成持续质量管理

### 注意事项

**适用范围**

- Spec Mode 最适合功能实施
- 简单修复或小规模更改使用常规实施形式
- 推荐用于新功能开发或复杂功能改造

**质量保证**

- 明确各阶段的完成标准
- 实施前的设计审查
- 包括测试和无障碍的全面质量标准

**执行注意事项**

- 解决需求的模糊性后再进入设计阶段
- 设计完成后生成实施任务
- 重视各阶段的批准流程

### 触发短语和控制

#### 分阶段工作流控制

**开始触发器**

- 「创建[功能名]的 spec」
- 「想用 spec 驱动开发[功能名]」
- 「从规格书设计[功能名]」

**阶段进度控制**

- **「继续」**: 完成当前阶段并生成文件，进入下一阶段
- **「修改」**: 在当前阶段内调整和改进内容
- **「重做」**: 从头开始当前阶段
- **「详细说明」**: 提供更详细的说明或选项
- **「跳过」**: 跳过当前阶段进入下一个(不推荐)

**文件生成时机**

```
Phase 1 完成 → 「继续」 → 生成 requirements.md
Phase 2 完成 → 「继续」 → 生成 design.md
Phase 3 完成 → 「继续」 → 生成 tasks.md
```

### 执行示例(分阶段流程)

```bash
# 使用示例
用户：「创建用户管理系统的 spec」

# Phase 1: Requirements Discovery
Claude: [开始需求确认和讨论]
用户: [响应・讨论・修改]
Claude: 「Requirements Phase 已完成。可以继续吗？」
用户: 「继续」
→ 生成 requirements.md

# Phase 2: Design Exploration
Claude: [开始设计提案和讨论]
用户: [技术选择・架构讨论]
Claude: 「Design Phase 已完成。可以继续吗？」
用户: 「继续」
→ 生成 design.md

# Phase 3: Implementation Planning
Claude: [开始实施计划讨论]
用户: [优先级・风险・工时讨论]
Claude: 「Implementation Phase 已完成。可以继续吗？」
用户: 「继续」
→ 生成 tasks.md

# 完成
Claude: 「spec 驱动开发的准备已完成。可以开始实施。」
```

### 与 /plan 的区别

| 特征 | /plan | /spec |
|------|-------|-------|
| 对象 | 一般实施计划 | 功能规格驱动开发 |
| 输出格式 | 单一计划文档 | 3 个独立文件(requirements.md、design.md、tasks.md) |
| 需求定义 | 基本需求整理 | 使用 EARS 记法的详细验收标准 |
| 设计 | 以技术选型为中心 | 基于代码库分析 |
| 实施 | 一般任务分解 | 考虑依赖关系的序列 |
| 质量保证 | 基本测试策略 | 全面质量要求(测试、无障碍、性能) |
| 同步 | 静态计划 | 动态 spec 更新 |

### 推荐用例

**推荐使用 spec**

- 新功能开发
- 复杂功能改造
- API 设计
- 数据库设计
- UI/UX 实施

**推荐使用 plan**

- 系统整体设计
- 基础设施构建
- 重构
- 技术选型
- 架构变更
