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
  echo "  zh-cn, zh, cn  - Chinese"
  echo "  ko  - Korean"
  echo "  pt  - Portuguese"
  echo "  es  - Spanish"
  echo ""
  echo "Examples:"
  echo "  $0 ja    # Switch to Japanese (default)"
  echo "  $0 en    # Switch to English"
  echo "  $0 zh-cn # Switch to Chinese"
  echo "  $0 ko    # Switch to Korean"
  echo "  $0 pt    # Switch to Portuguese"
  echo "  $0 es    # Switch to Spanish"
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
zh | cn | zh-cn)
  LANG_CODE="zh-cn"
  LANG_NAME="Chinese"
  ;;
ko | kr)
  LANG_CODE="ko"
  LANG_NAME="Korean"
  ;;
pt | br)
  LANG_CODE="pt"
  LANG_NAME="Portuguese"
  ;;
es)
  LANG_NAME="Spanish"
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

# Copy CLAUDE.md and COMMAND_TEMPLATE.md files for the selected language (Japanese is default, no copy needed)
if [ "$LANG_CODE" != "ja" ]; then
  # Copy CLAUDE.md
  CLAUDE_FILE="$PROJECT_ROOT/CLAUDE.md"
  LANG_CLAUDE="$PROJECT_ROOT/locales/$LANG_CODE/CLAUDE.md"
  if [ -f "$LANG_CLAUDE" ]; then
    echo "📝 Updating CLAUDE.md with ${LANG_NAME} version..."
    cp "$LANG_CLAUDE" "$CLAUDE_FILE"
    echo "✅ Updated CLAUDE.md"
  else
    echo "⚠️  ${LANG_NAME} version of CLAUDE.md does not exist"
  fi

  # Copy COMMAND_TEMPLATE.md
  TEMPLATE_FILE="$PROJECT_ROOT/COMMAND_TEMPLATE.md"
  LANG_TEMPLATE="$PROJECT_ROOT/locales/$LANG_CODE/COMMAND_TEMPLATE.md"
  if [ -f "$LANG_TEMPLATE" ]; then
    echo "📝 Updating COMMAND_TEMPLATE.md with ${LANG_NAME} version..."
    cp "$LANG_TEMPLATE" "$TEMPLATE_FILE"
    echo "✅ Updated COMMAND_TEMPLATE.md"
  else
    echo "⚠️  ${LANG_NAME} version of COMMAND_TEMPLATE.md does not exist"
  fi
fi

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
