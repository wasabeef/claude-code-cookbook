## Git Commit

適切なコミットメッセージを生成します。

### 使い方

```bash
# 1. 変更を確認
git status --short
git diff

# 2. ステージングされた変更を Claude に送る
git diff --staged

# 3. Claude に依頼
「この変更から Conventional Commits 形式で 1 行のコミットメッセージを生成して」

# 4. 生成されたメッセージでコミット
git commit -m "生成されたメッセージ"
```

### 基本例

デフォルトのプレフィックス：

- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメント
- `refactor`: リファクタリング
- `test`: テスト
- `chore`: その他

**注意**: プロジェクトで独自のプレフィックスが指定されている場合は、それに従います。

### 詳細例

```bash
# 1. 変更をステージング
git add .

# 2. 差分を確認しながら Claude に依頼
git diff --staged && echo "この変更から 1 行のコミットメッセージを生成して"

# 3. Claude が生成したメッセージをコピーしてコミット
git commit -m "feat: add user authentication system"
```

依頼文のバリエーション：

- 「この変更から Conventional Commits 形式で 1 行のコミットメッセージを生成して。50 文字以内で」
- 「バグ修正のコミットメッセージを作って」
- 「この diff から適切なコミットメッセージを 1 行で」

### 注意事項

**注意**: 自動プッシュはしません。必要に応じて `git push` を実行してください。
