## 智能审查

分析当前情况，自动建议最佳角色和方法的命令。

### 使用方法

```bash
/smart-review                    # 分析当前目录
/smart-review <文件/目录>        # 分析特定对象
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

### 建议模式

### 单一角色建议

```bash
$ /smart-review src/auth/login.js
→ 「检测到认证文件」
→ 「推荐使用 security 角色分析」
→ 「是否执行？ [y]es / [n]o / [m]ore options」
```

### 多角色建议

```bash
$ /smart-review src/mobile/components/
→ 「📱🎨 检测到移动端 + 前端元素」
→ 「推荐方法：」
→ 「[1] mobile 角色单独」
→ 「[2] frontend 角色单独」
→ 「[3] multi-role mobile,frontend」
→ 「[4] role-debate mobile,frontend」
```

### 问题分析时的建议

```bash
$ /smart-review error.log
→ 「⚠️ 检测到错误日志」
→ 「使用 analyzer 角色开始根本原因分析」
→ 「[自动执行] /role analyzer」

$ /smart-review slow-api.log
→ 「🐌 检测到性能问题」
→ 「推荐：[1]/role performance [2]/role-debate performance,analyzer」
```

### 复杂设计决策时的建议

```bash
$ /smart-review architecture-design.md
→ 「🏗️🔒⚡ 检测到架构 + 安全 + 性能元素」
→ 「由于设计决策复杂，推荐讨论形式」
→ 「[推荐] /role-debate architect,security,performance」
→ 「[替代] /multi-role architect,security,performance」
```

### 建议逻辑详情

### 优先级判定

1. **Security** - 认证、授权、加密相关最优先
2. **Critical Errors** - 系统停机、数据丢失紧急处理
3. **Architecture** - 大规模变更、技术选型慎重考虑
4. **Performance** - 直接影响用户体验
5. **Frontend/Mobile** - UI/UX 改进
6. **QA** - 质量保证、测试相关

### 推荐讨论的条件

- 涉及 3 个以上角色时
- 存在安全性与性能的权衡时
- 包含架构大幅变更时
- 同时影响移动端和 Web 时

### 基本示例

```bash
# 分析当前目录
/smart-review
「请建议最佳的角色和方法」

# 分析特定文件
/smart-review src/auth/login.js
「请建议此文件的最佳审查方法」

# 分析错误日志
/smart-review error.log
「请建议解决此错误的最佳方法」
```

### 实际示例

### 项目整体分析

```bash
$ /smart-review
→ 「📊 正在分析项目...」
→ 「检测到 React + TypeScript 项目」
→ 「确认包含认证功能 + API + 移动端支持」
→ 「」
→ 「💡 推荐工作流程：」
→ 「1. security 检查认证系统」
→ 「2. frontend 评估 UI/UX」
→ 「3. mobile 确认移动端优化」
→ 「4. architect 审查整体设计」
→ 「」
→ 「是否自动执行？ [y]es / [s]elect role / [c]ustom」
```

### 特定问题分析

```bash
$ /smart-review "JWT 有效期应该如何设置"
→ 「🤔 检测到技术设计决策」
→ 「这是需要多个专业视角的问题」
→ 「」
→ 「推荐方法：」
→ 「/role-debate security,performance,frontend」
→ 「原因：需要平衡安全性、性能和用户体验」
```

### 与 Claude 配合

```bash
# 结合文件内容分析
cat src/auth/middleware.js
/smart-review
「请结合此文件内容从安全角度分析」

# 结合错误分析
npm run build 2>&1 | tee build-error.log
/smart-review build-error.log
「请建议构建错误的解决方法」

# 设计咨询
/smart-review
「请讨论应该选择 React Native 还是 Progressive Web App」
```

### 注意事项

- 建议仅供参考，最终决定由用户做出
- 复杂问题推荐使用讨论形式（role-debate）
- 简单问题使用单一角色通常就足够
- 安全相关问题必须推荐使用专业角色确认
