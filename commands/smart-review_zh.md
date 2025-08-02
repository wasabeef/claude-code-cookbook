## 智能评审

分析当前状况并自动推荐最佳角色和方法的命令。

### 使用方法

```bash
/smart-review                    # 分析当前目录
/smart-review <文件/目录> # 分析特定对象
```

### 自动判定逻辑

### 基于文件扩展名的判定

- `package.json`, `*.tsx`, `*.jsx`, `*.css`, `*.scss` → **frontend**
- `Dockerfile`, `docker-compose.yml`, `*.yaml` → **architect**
- `*.test.js`, `*.spec.ts`, `test/`, `__tests__/` → **qa**
- `*.rs`, `Cargo.toml`, `performance/` → **performance**

### 安全相关文件检测

- `auth.js`, `security.yml`, `.env`, `config/auth/` → **security**
- `login.tsx`, `signup.js`, `jwt.js` → **security + frontend**
- `api/auth/`, `middleware/auth/` → **security + architect**

### 复合判定模式

- `mobile/` + `*.swift`, `*.kt`, `react-native/` → **mobile**
- `webpack.config.js`, `vite.config.js`, `large-dataset/` → **performance**
- `components/` + `responsive.css` → **frontend + mobile**
- `api/` + `auth/` → **security + architect**

### 错误与问题分析

- 堆栈跟踪、`error.log`, `crash.log` → **analyzer**
- `memory leak`, `high CPU`, `slow query` → **performance + analyzer**
- `SQL injection`, `XSS`, `CSRF` → **security + analyzer**

### 提案模式

### 单一角色提案

```bash
$ /smart-review src/auth/login.js
→ 「检测到认证文件」
→ 「推荐使用security角色进行分析」
→ 「是否执行？ [y]es / [n]o / [m]ore options」
```

### 多角色提案

```bash
$ /smart-review src/mobile/components/
→ 「📱🎨 检测到移动 + 前端元素」
→ 「推荐方法:」
→ 「[1] mobile角色单独」
→ 「[2] frontend角色单独」  
→ 「[3] multi-role mobile,frontend」
→ 「[4] role-debate mobile,frontend」
```

### 问题分析时的提案

```bash
$ /smart-review error.log
→ 「⚠️ 检测到错误日志」
→ 「开始使用analyzer角色进行根本原因分析」
→ 「[自动执行] /role analyzer」

$ /smart-review slow-api.log
→ 「🐌 检测到性能问题」
→ 「推荐: [1]/role performance [2]/role-debate performance,analyzer」
```

### 复杂设计决策时的提案

```bash
$ /smart-review architecture-design.md
→ 「🏗️🔒⚡ 检测到架构 + 安全 + 性能元素」
→ 「对于复杂设计决策，推荐讨论形式」
→ 「[推荐] /role-debate architect,security,performance」
→ 「[替代] /multi-role architect,security,performance」
```

### 提案逻辑详情

### 优先级判定

1. **Security** - 认证、授权、加密相关为最高优先级
2. **Critical Errors** - 系统停止、数据丢失为紧急
3. **Architecture** - 大规模变更、技术选型需慎重考虑
4. **Performance** - 直接影响用户体验
5. **Frontend/Mobile** - UI/UX 改进
6. **QA** - 质量保证、测试相关

### 推荐讨论条件

- 涉及3个以上角色时
- 存在安全与性能的权衡时
- 包含架构大幅变更时
- 同时影响移动和Web端时

### 基本示例

```bash
# 分析当前目录
/smart-review
「推荐最佳角色和方法」

# 分析特定文件
/smart-review src/auth/login.js
「推荐此文件的最佳评审方法」

# 分析错误日志
/smart-review error.log
「推荐解决此错误的最佳方法」
```

### 实际案例

### 项目整体分析

```bash
$ /smart-review
→ 「📊 项目分析中...」
→ 「检测到React + TypeScript项目」
→ 「确认包含认证功能 + API + 移动支持」
→ 「」
→ 「💡 推荐工作流程:」
→ 「1. 使用security检查认证系统」
→ 「2. 使用frontend评估UI/UX」
→ 「3. 使用mobile确认移动优化」
→ 「4. 使用architect评审整体设计」
→ 「」
→ 「是否自动执行？ [y]es / [s]elect role / [c]ustom」
```

### 特定问题分析

```bash
$ /smart-review "JWT的有效期应该如何设置"
→ 「🤔 检测到技术性设计判断」
→ 「这是一个需要多个专业视角的问题」
→ 「」
→ 「推荐方法:」
→ 「/role-debate security,performance,frontend」
→ 「原因: 安全、性能和用户体验的平衡很重要」
```

### 与Claude的协作

```bash
# 结合文件内容的分析
cat src/auth/middleware.js
/smart-review
「结合此文件内容从安全角度分析」

# 结合错误的分析
npm run build 2>&1 | tee build-error.log
/smart-review build-error.log
「推荐解决构建错误的方法」

# 设计咨询
/smart-review
「讨论应该选择React Native还是Progressive Web App」
```

### 注意事项

- 提案仅供参考。最终判断请由用户做出
- 越复杂的问题越推荐讨论形式（role-debate）
- 简单问题通常只需单个角色
- 安全相关问题务必推荐专业角色确认
```