## 语义化提交

将大型变更分割为有意义的最小单元，并使用语义化的提交消息依次提交。不依赖外部工具，仅使用git标准命令。

### 使用方法

```bash
/semantic-commit [选项]
```

### 选项

- `--dry-run` : 不执行实际提交，仅显示建议的提交分割
- `--lang <语言>` : 强制指定提交消息的语言（en, zh）
- `--max-commits <数量>` : 指定最大提交数量（默认: 10）

### 基本示例

```bash
# 分析当前变更，按逻辑单元提交
/semantic-commit

# 仅查看分割方案（不实际提交）
/semantic-commit --dry-run

# 生成中文提交消息
/semantic-commit --lang zh

# 最多分割为5个提交
/semantic-commit --max-commits 5
```

### 工作流程

1. **变更分析**: 通过`git diff HEAD`获取所有变更
2. **文件分类**: 将变更的文件逻辑分组
3. **提交建议**: 为每组生成语义化的提交消息
4. **依次执行**: 经用户确认后，依次提交每组变更

### 变更分割的核心功能

#### 「大型变更」的检测

满足以下条件的变更将被检测为大型变更：

1. **变更文件数**: 5个文件以上的变更
2. **变更行数**: 100行以上的变更
3. **多个功能**: 涉及2个以上功能领域的变更
4. **混合模式**: feat + fix + docs等混合变更

```bash
# 变更规模分析
CHANGED_FILES=$(git diff HEAD --name-only | wc -l)
CHANGED_LINES=$(git diff HEAD --stat | tail -1 | grep -o '[0-9]\+ insertions\|[0-9]\+ deletions' | awk '{sum+=$1} END {print sum}')

if [ $CHANGED_FILES -ge 5 ] || [ $CHANGED_LINES -ge 100 ]; then
  echo "检测到大型变更: 建议分割"
fi
```

#### 「有意义的最小单元」分割策略

##### 1. 按功能边界分割

```bash
# 从目录结构识别功能单元
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq
# → src/auth, src/api, components/ui 等
```

##### 2. 按变更类型分离

```bash
# 新文件 vs 现有文件修改
git diff HEAD --name-status | grep '^A' # 新文件
git diff HEAD --name-status | grep '^M' # 修改文件
git diff HEAD --name-status | grep '^D' # 删除文件
```

##### 3. 依赖关系分析

```bash
# 检测导入关系变更
git diff HEAD | grep -E '^[+-].*import|^[+-].*require' | \
cut -d' ' -f2- | sort | uniq
```

#### 文件级详细分析

```bash
# 获取变更文件列表
git diff HEAD --name-only

# 逐个分析文件变更内容
git diff HEAD -- <file>

# 判断文件变更类型
git diff HEAD --name-status | while read status file; do
  case $status in
    A) echo "$file: 新建" ;;    
    M) echo "$file: 修改" ;;    
    D) echo "$file: 删除" ;;    
    R*) echo "$file: 重命名" ;;    
  esac
done
```

#### 逻辑分组标准

1. **功能单元**: 与同一功能相关的文件
   - `src/auth/` 下的文件 → 认证功能
   - `components/` 下的文件 → UI组件

2. **变更类型**: 相同类型的变更
   - 仅测试文件 → `test:`
   - 仅文档 → `docs:`
   - 仅配置文件 → `chore:`

3. **依赖关系**: 相互关联的文件
   - 模型 + 迁移
   - 组件 + 样式

4. **变更规模**: 保持适当的提交大小
   - 每个提交不超过10个文件
   - 将高度相关的文件分组

### 输出示例

```bash
$ /semantic-commit

变更分析中...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

检测到的变更:
• src/auth/login.ts (修改)
• src/auth/register.ts (新建)
• src/auth/types.ts (修改)
• tests/auth.test.ts (新建)
• docs/authentication.md (新建)

建议的提交分割:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提交 1/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
消息: feat: 实现用户注册和登录系统
包含文件:
  • src/auth/login.ts
  • src/auth/register.ts  
  • src/auth/types.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提交 2/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
消息: test: 为认证系统添加综合测试
包含文件:
  • tests/auth.test.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提交 3/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
消息: docs: 添加认证系统文档
包含文件:
  • docs/authentication.md

是否按照此分割方案执行提交？ (y/n/edit): 
```

### 执行时选项

- `y` : 按建议的提交分割执行
- `n` : 取消
- `edit` : 单独编辑提交消息
- `merge <编号1> <编号2>` : 合并指定的提交
- `split <编号>` : 进一步分割指定的提交

### 模拟运行模式

```bash
$ /semantic-commit --dry-run

变更分析中... (DRY RUN)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[提交分割建议显示]

ℹ️  模拟运行模式: 不会执行实际提交
💡 如需执行，请移除 --dry-run 选项后重新运行
```

### 智能分析功能

#### 1. 项目结构理解

- 从`package.json`, `Cargo.toml`, `pom.xml`等判断项目类型
- 从文件夹结构推测功能单元

#### 2. 变更模式识别
```