#!/bin/bash

# Language configuration script
# Usage: ./scripts/set-lang.sh <language>
# Example: ./scripts/set-lang.sh en
#          ./scripts/set-lang.sh ja
#          ./scripts/set-lang.sh zh

set -e

# Show usage
show_usage() {
  echo "Usage: $0 <language>"
  echo ""
  echo "Supported languages:"
  echo "  ja  - Japanese (default)"
  echo "  en  - English"
  echo "  zh  - Chinese"
  echo ""
  echo "Examples:"
  echo "  $0 en    # Switch to English"
  echo "  $0 ja    # Switch to Japanese (default)"
  echo "  $0 zh    # Switch to Chinese"
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
  SUFFIX=""
  ;;
en)
  LANG_NAME="English"
  SUFFIX="_en"
  ;;
zh | cn)
  LANG_CODE="zh"
  LANG_NAME="Chinese"
  SUFFIX="_zh"
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
DIRS=("$PROJECT_ROOT/commands" "$PROJECT_ROOT/agents")

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

  # Find all .md files
  while IFS= read -r BASE_FILE; do
    # Get base filename
    BASE_NAME=$(basename "$BASE_FILE" .md)
    DIR_NAME=$(dirname "$BASE_FILE")

    # Search for language-specific files
    if [ "$LANG_CODE" = "ja" ]; then
      # Skip for Japanese as base files are already in Japanese
      continue
    else
      # Language-specific file path
      LANG_FILE="$DIR_NAME/${BASE_NAME}${SUFFIX}.md"

      if [ -f "$LANG_FILE" ]; then
        echo "  📝 Updating $BASE_NAME.md with ${LANG_NAME} version..."

        # Overwrite base file with language version
        cp "$LANG_FILE" "$BASE_FILE"

        echo "  ✅ Updated $BASE_NAME.md"
        ((SUCCESS_COUNT++))
      else
        echo "  ⚠️  ${LANG_NAME} version does not exist: $BASE_NAME${SUFFIX}.md"
        ((SKIP_COUNT++))
      fi
    fi
  done < <(find "$DIR" -name "*.md" -type f ! -name "*_*")

  # Remove other language files
  echo "  🗑️  Removing unnecessary language files..."

  # Remove all language-specific files regardless of target language
  for lang_suffix in "_en" "_zh" "_ja"; do
    while IFS= read -r lang_file; do
      rm "$lang_file"
      echo "    🗑️  Removed: $(basename "$lang_file")"
    done < <(find "$DIR" -name "*${lang_suffix}.md" -type f)
  done
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
