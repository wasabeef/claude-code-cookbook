## 性能分析

分析应用程序的性能问题，并从技术债务的角度提出改进措施。

### 使用方法

```bash
# 全面分析性能问题
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
「找出大型文件和性能问题并提供改进方案」

# 检测低效代码模式
grep -r "for.*await\|forEach.*await" . --include="*.js"
「分析N+1查询问题和性能瓶颈」

# 可能的内存泄漏
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
「评估内存泄漏风险及对策」
```

### 基本示例

```bash
# 包大小和加载时间
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"找出包大小和资源优化的改进点"

# 数据库性能
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"分析数据库查询的优化点"

# 依赖关系对性能的影响
npm outdated && npm audit
"评估旧依赖关系对性能的影响"
```

### 分析角度

#### 1. 代码级问题

- **O(n²)算法**: 检测低效的数组操作
- **同步I/O**: 识别阻塞性处理
- **重复处理**: 移除不必要的计算和请求
- **内存泄漏**: 事件监听器和定时器的管理

#### 2. 架构级问题

- **N+1查询**: 数据库访问模式
- **缓存不足**: 重复计算和API调用
- **包大小**: 不必要的库和代码分割
- **资源管理**: 连接池和线程使用情况

#### 3. 技术债务的影响

- **遗留代码**: 旧实现导致的性能下降
- **设计问题**: 责任分散不足导致的高耦合度
- **测试不足**: 性能回归漏检
- **监控不足**: 问题早期发现机制

### 改进优先级

```
🔴 严重: 系统故障风险
├─ 内存泄漏 (服务器崩溃)
├─ N+1查询 (数据库负载)
└─ 同步I/O (响应延迟)

🟡 高: 用户体验影响
├─ 包大小 (首次加载时间)
├─ 图像优化 (显示速度)
└─ 缓存策略 (响应速度)

🟢 中: 运营效率
├─ 依赖关系更新 (安全性)
├─ 代码重复 (可维护性)
└─ 监控强化 (运营负担)
```

### 测量与工具

#### Node.js / JavaScript

```bash
# 性能分析
node --prof app.js
clinic doctor -- node app.js

# 包分析
npx webpack-bundle-analyzer
lighthouse --chrome-flags="--headless"
```

#### 数据库

```sql
-- 查询分析
EXPLAIN ANALYZE SELECT ...
SHOW SLOW LOG;
```

#### 前端

```bash
# React性能
grep -r "useMemo\|useCallback" . --include="*.jsx"

# 资源分析
find ./src -name "*.png" -o -name "*.jpg" | xargs ls -lh
```

### 持续改进

- **定期审计**: 执行每周性能测试
- **指标收集**: 跟踪响应时间、内存使用量
- **警报设置**: 阈值超过时自动通知
- **团队共享**: 记录改进案例和反模式