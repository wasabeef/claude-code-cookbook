#!/bin/bash

# Language installation script
# Usage: ./scripts/install.sh <language>
# Example: ./scripts/install.sh en
#          ./scripts/install.sh ja
#          ./scripts/install.sh zh

set -e

# Show usage
show_usage() {
  echo "Usage: $0 <language>"
  echo ""
  echo "Supported languages:"
  echo "  ja  - Japanese (default)"
  echo "  en  - English"
  echo "  zh  - Chinese"
  echo "  ko  - Korean"
  echo ""
  echo "Examples:"
  echo "  $0 en    # Switch to English"
  echo "  $0 ja    # Switch to Japanese (default)"
  echo "  $0 zh    # Switch to Chinese"
  echo "  $0 ko    # Switch to Korean"
}

# Argument check
if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  show_usage
  exit 0
fi

LANG_CODE="$1"

# Language support check
case "$LANG_CODE" in
ja | jp)
  LANG_CODE="ja"
  LANG_NAME="Japanese"
  ;;
en)
  LANG_NAME="English"
  ;;
zh | cn)
  LANG_CODE="zh"
  LANG_NAME="Chinese"
  ;;
ko | kr)
  LANG_CODE="ko"
  LANG_NAME="Korean"
  ;;
*)
  echo "❌ Error: Unsupported language code '$LANG_CODE'"
  echo ""
  show_usage
  exit 1
  ;;
esac

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🔄 Setting language to ${LANG_NAME} (${LANG_CODE})..."

# Target directories
DIRS=("$PROJECT_ROOT/commands" "$PROJECT_ROOT/agents/roles")

# Success/failure counters
SUCCESS_COUNT=0
SKIP_COUNT=0
ERROR_COUNT=0

# Process each directory
for DIR in "${DIRS[@]}"; do
  if [ ! -d "$DIR" ]; then
    echo "⚠️  Directory does not exist: $DIR"
    continue
  fi

  echo "📁 Processing: $DIR"

  # Find all .md files (excluding language-specific ones)
  while IFS= read -r BASE_FILE; do
    # Get base filename and relative path
    BASE_NAME=$(basename "$BASE_FILE" .md)
    REL_PATH=${DIR#$PROJECT_ROOT/}

    # For non-Japanese languages, copy from locales directory
    if [ "$LANG_CODE" != "ja" ]; then
      # Language-specific file path in locales directory
      LANG_FILE="$PROJECT_ROOT/locales/$LANG_CODE/$REL_PATH/$BASE_NAME.md"

      if [ -f "$LANG_FILE" ]; then
        echo "  📝 Updating $BASE_NAME.md with ${LANG_NAME} version..."

        # Overwrite base file with language version
        cp "$LANG_FILE" "$BASE_FILE"

        echo "  ✅ Updated $BASE_NAME.md"
        ((SUCCESS_COUNT++))
      else
        echo "  ⚠️  ${LANG_NAME} version does not exist: $LANG_FILE"
        ((SKIP_COUNT++))
      fi
    else
      # For Japanese, restore from locales/ja if exists, otherwise keep current
      JA_FILE="$PROJECT_ROOT/locales/ja/$REL_PATH/$BASE_NAME.md"

      if [ -f "$JA_FILE" ]; then
        echo "  📝 Restoring Japanese version of $BASE_NAME.md..."
        cp "$JA_FILE" "$BASE_FILE"
        echo "  ✅ Restored $BASE_NAME.md"
        ((SUCCESS_COUNT++))
      else
        echo "  ℹ️  Using existing Japanese version: $BASE_NAME.md"
        ((SKIP_COUNT++))
      fi
    fi
  done < <(find "$DIR" -name "*.md" -type f)
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Language configuration complete!"
echo "  🌍 Language: ${LANG_NAME} (${LANG_CODE})"
echo "  ✅ Updated: $SUCCESS_COUNT files"
if [ $SKIP_COUNT -gt 0 ]; then
  echo "  ⏭️  Skipped: $SKIP_COUNT files"
fi
if [ $ERROR_COUNT -gt 0 ]; then
  echo "  ❌ Errors: $ERROR_COUNT files"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "💡 All commands are now available in ${LANG_NAME}"
echo "   Examples: /plan, /commit-message, /refactor, etc."
