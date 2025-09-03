# Token 效率模式

AI 响应压缩模式，可减少上下文使用量 30-50%。

## 概述

Token 效率模式通过视觉符号和缩写系统来压缩 Claude 的响应。
**生成代码的质量或内容不会发生任何改变**。仅改变的是说明方式。

## 使用方法

```bash
# 启用模式
「使用 Token 效率模式响应」
「使用 --uc 模式」
「使用简洁模式」
```

## 工作原理

### 1. 符号体系

#### 逻辑与流程
| 符号 | 含义 | 使用示例 |
|------|------|---------|
| → | 导致、引起 | `auth.js:45 → 🛡️ 安全风险` |
| ⇒ | 转换为 | `input ⇒ validated_output` |
| ← | 回滚、撤回 | `migration ← rollback` |
| ⇄ | 双向 | `sync ⇄ remote` |
| & | 并且、结合 | `🛡️ security & ⚡ performance` |
| \| | 或者、分隔 | `react\|vue\|angular` |
| : | 定义、指定 | `scope: file\|module` |
| » | 接下来、序列 | `build » test » deploy` |
| ∴ | 因此 | `tests ❌ ∴ code broken` |
| ∵ | 因为 | `slow ∵ O(n²) algorithm` |

#### 状态与进度
| 符号 | 含义 | 用途 |
|------|------|------|
| ✅ | 完成、成功 | 任务正常结束 |
| ❌ | 失败、错误 | 需要立即处理 |
| ⚠️ | 警告 | 建议审查 |
| 🔄 | 进行中 | 当前活跃状态 |
| ⏳ | 等待中 | 稍后执行 |
| 🚨 | 紧急、重要 | 高优先级 |

#### 技术领域
| 符号 | 领域 | 用途 |
|------|------|------|
| ⚡ | 性能 | 速度、优化 |
| 🔍 | 分析 | 搜索、调查 |
| 🔧 | 配置 | 设置、工具 |
| 🛡️ | 安全 | 保护、安全性 |
| 📦 | 部署 | 包、打包 |
| 🎨 | 设计 | UI、前端 |
| 🏗️ | 架构 | 系统结构 |
| 🗄️ | 数据库 | 数据持久化 |
| ⚙️ | 后端 | 服务器处理 |
| 🧪 | 测试 | 质量保证 |

### 2. 缩写系统

#### 系统与架构
- `cfg` → configuration（配置）
- `impl` → implementation（实现）
- `arch` → architecture（架构）
- `perf` → performance（性能）
- `ops` → operations（运维）
- `env` → environment（环境）

#### 开发流程
- `req` → requirements（需求）
- `deps` → dependencies（依赖关系）
- `val` → validation（验证）
- `auth` → authentication（认证）
- `docs` → documentation（文档）
- `std` → standards（标准）

#### 质量与分析
- `qual` → quality（质量）
- `sec` → security（安全）
- `err` → error（错误）
- `rec` → recovery（恢复）
- `sev` → severity（严重程度）
- `opt` → optimization（优化）

## 实例对比

### 例 1: 错误报告

**正常模式（49 字符）**
```
在用户验证函数的第 45 行发现了安全漏洞。
```

**Token 高效模式（32 字符）**
```
auth.js:45 → 🛡️ sec vuln in user val()
```

### 例 2: 构建状态

**正常模式（41 字符）**
```
构建过程已完成。正在运行测试，然后进行部署。
```

**Token 高效模式（29 字符）**
```
build ✅ » test 🔄 » deploy ⏳
```

### 例 3: 性能分析

**正常模式（65 字符）**
```
性能分析结果显示，算法的 O(n²) 复杂度导致处理速度缓慢。
```

**Token 高效模式（37 字符）**
```
⚡ perf: slow ∵ O(n²) → optimize to O(n)
```

## 适用场景

### ✅ 有效场合

- **长时间调试会话**: 保持历史记录的同时高效处理
- **大规模代码审查**: 简洁分析大量文件
- **CI/CD 监控**: 实时状态更新
- **项目进度报告**: 多任务状态一览
- **错误跟踪**: 可视化问题链

### ❌ 应避免的场合

- 向初学者说明
- 详细文档编写
- 初次需求定义
- 与非技术人员沟通

## 实现示例

### 调试会话
```
[14:23] breakpoint → vars: {user: null, token: expired}
[14:24] step → auth.validate() ❌
[14:25] check → token.exp < Date.now() ∴ expired
[14:26] fix → refresh() → ✅
[14:27] continue → main flow 🔄
```

### 文件分析结果
```
/src/auth/: 🛡️ issues × 3
/src/api/: ⚡ bottleneck in handler()
/src/db/: ✅ clean
/src/utils/: ⚠️ deprecated methods
/tests/: 🧪 coverage 78%
```

### 项目状态
```
Frontend: 🎨 ✅ 100%
Backend: ⚙️ 🔄 75%
Database: 🗄️ ✅ migrated
Tests: 🧪 ⚠️ 68% (target: 80%)
Deploy: 📦 ⏳ scheduled
Security: 🛡️ 🚨 1 critical
```

## 配置选项

```javascript
// 压缩级别
--uc        // Ultra Compressed: 最大压缩
--mc        // Moderate Compressed: 中等压缩
--lc        // Light Compressed: 轻度压缩

// 领域专门化
--dev       // 开发专用压缩
--ops       // 运维专用压缩
--sec       // 安全专用压缩
```

## 优势

1. **上下文节约**: 减少 30-50% token 消耗
2. **视觉理解**: 符号直观把握
3. **信息密度提高**: 相同空间内更多信息
4. **历史保持**: 维持更长对话历史
5. **模式识别**: 视觉模式便于发现问题

## 注意事项

- 此模式仅改变 **AI 的响应风格**
- 生成的**代码质量**不会改变
- 可根据需要切换为「详细模式说明」
- 对初学者或非技术人员建议使用正常模式

## 命令示例

```bash
# 启用
「启用 Token 效率模式」
「简洁响应」
「使用 --uc 分析」

# 禁用
「切换为正常模式」
「详细说明」
「关闭 Token 效率模式」
```

## 实现影响

| 项目 | 影响 |
|------|------|
| 生成代码质量 | 无变化 ✅ |
| 实现准确性 | 无变化 ✅ |
| 功能性 | 无变化 ✅ |
| AI 说明方式 | 压缩 🔄 |
| 上下文使用 | 减少 30-50% ⚡ |

---

💡 **专业提示**: 在长时间工作会话中，先用正常模式加深理解，然后切换到 Token 效率模式，可以优化效率与上下文保持的平衡。