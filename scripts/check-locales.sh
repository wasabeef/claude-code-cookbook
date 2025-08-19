#!/bin/bash

# Validate language versions for completeness and consistency
# Ensures each locale has all required files and structure
# Adapted for locales/ directory structure

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Project paths
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCALES_DIR="$PROJECT_ROOT/locales"
COMMANDS_DIR="$PROJECT_ROOT/commands"
AGENTS_DIR="$PROJECT_ROOT/agents"

# Required directories for each locale
REQUIRED_DIRS=("commands" "agents/roles")

# Counters
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0
WARNINGS=0

print_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
  echo -e "${GREEN}[✓]${NC} $1"
  PASSED_CHECKS=$((PASSED_CHECKS + 1))
}

print_warning() {
  echo -e "${YELLOW}[⚠]${NC} $1"
  WARNINGS=$((WARNINGS + 1))
}

print_error() {
  echo -e "${RED}[✗]${NC} $1"
  FAILED_CHECKS=$((FAILED_CHECKS + 1))
}

# Function to check directory structure
check_structure() {
  local locale="$1"
  local locale_dir="$LOCALES_DIR/$locale"

  print_info "Checking directory structure for $locale..."

  for dir in "${REQUIRED_DIRS[@]}"; do
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ -d "$locale_dir/$dir" ]]; then
      print_success "$dir exists"
    else
      print_error "$dir is missing"
    fi
  done
}

# Function to count files in directories
count_files() {
  local locale="$1"
  local locale_dir="$LOCALES_DIR/$locale"

  print_info "File counts for $locale:"

  # Count command files
  if [[ -d "$locale_dir/commands" ]]; then
    local cmd_count
    cmd_count=$(find "$locale_dir/commands" -name "*.md" -type f -exec printf '.' \; | wc -c)
    echo "  Commands: $cmd_count files"
  fi

  # Count role files
  if [[ -d "$locale_dir/agents/roles" ]]; then
    local role_count
    role_count=$(find "$locale_dir/agents/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)
    echo "  Roles: $role_count files"
  fi
}

# Function to check for language-specific content
check_language_content() {
  local locale="$1"
  local locale_dir="$LOCALES_DIR/$locale"

  print_info "Checking language content for $locale..."

  # Define expected language patterns
  case "$locale" in
  zh)
    # Check for Chinese content and no Japanese
    if [[ -d "$locale_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for Japanese sentence patterns (more reliable than individual kanji)
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$locale_dir"/**/*.md 2>/dev/null)
      
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No Japanese contamination found in Chinese files"
      else
        print_warning "Found Japanese contamination in ${#contaminated_files[@]} Chinese files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
        WARNINGS=$((WARNINGS + 1))
      fi
      
      # Also check for Chinese content
      local zh_files
      zh_files=$(grep -c '[一-龯]' "$locale_dir/commands"/*.md 2>/dev/null | grep -cv ':0' || echo "0")
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ $zh_files -gt 0 ]]; then
        print_success "Found Chinese content in $zh_files command files"
      else
        print_warning "No Chinese content found in commands"
      fi
    fi
    ;;
  en)
    # Check for English content and no Japanese
    if [[ -d "$locale_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese (hiragana, katakana, kanji frequently used in Japanese)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Also check for common Japanese kanji patterns
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese kanji")
        fi
      done < <(grep -lE '調査|実装|機能|開発|修正|追加|削除|更新|確認|設定' "$locale_dir"/**/*.md 2>/dev/null)

      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No Japanese contamination found in English files"
      else
        print_warning "Found language contamination in ${#contaminated_files[@]} English files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
        WARNINGS=$((WARNINGS + 1))
      fi
    fi
    ;;
  es)
    # Check for Spanish content and no Japanese
    if [[ -d "$locale_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for Japanese sentence patterns (more reliable than individual kanji)
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$locale_dir"/**/*.md 2>/dev/null)
      
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No Japanese contamination found in Spanish files"
      else
        print_warning "Found Japanese contamination in ${#contaminated_files[@]} Spanish files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
        WARNINGS=$((WARNINGS + 1))
      fi
    fi
    ;;
  ko)
    # Check for Korean content and no Japanese
    if [[ -d "$locale_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for common Japanese kanji patterns (different from Korean hanja usage)
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese kanji")
        fi
      done < <(grep -lE '調査|実装|機能|開発|修正|追加|削除|更新|確認|設定' "$locale_dir"/**/*.md 2>/dev/null)
      
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No Japanese contamination found in Korean files"
      else
        print_warning "Found Japanese contamination in ${#contaminated_files[@]} Korean files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
        WARNINGS=$((WARNINGS + 1))
      fi
    fi
    ;;
  pt)
    # Check for Portuguese content and no Japanese
    if [[ -d "$locale_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for Japanese sentence patterns (more reliable than individual kanji)
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$locale_dir"/**/*.md 2>/dev/null)
      
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No Japanese contamination found in Portuguese files"
      else
        print_warning "Found Japanese contamination in ${#contaminated_files[@]} Portuguese files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
        WARNINGS=$((WARNINGS + 1))
      fi
    fi
    ;;
  fr)
    # Check for French content and no Japanese
    if [[ -d "$locale_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for Japanese sentence patterns (more reliable than individual kanji)
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$locale_dir"/**/*.md 2>/dev/null)
      
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No Japanese contamination found in fr files"
      else
        print_warning "Found Japanese contamination in ${#contaminated_files[@]} French files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
        WARNINGS=$((WARNINGS + 1))
      fi
    fi
    ;;
  zh-cn)
    # Check for Simplified Chinese and no Japanese/Traditional Chinese
    if [[ -d "$locale_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese-specific characters (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for Japanese sentence patterns (more reliable than individual kanji)
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for Traditional Chinese specific characters (avoiding false positives)
      # Note: 繁 is excluded as it appears in valid simplified words like 频繁
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Traditional Chinese")
        fi
      done < <(grep -lE '體|憂|鬱|臺|灣|關係|發現|實現|專|業|檔|產|學|雜|難|應|轉|變' "$locale_dir"/**/*.md 2>/dev/null)
      
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No foreign language contamination found in Simplified Chinese files"
      else
        print_warning "Found language contamination in ${#contaminated_files[@]} Simplified Chinese files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
        WARNINGS=$((WARNINGS + 1))
      fi
    fi
    ;;
  zh-tw)
    # Check for Traditional Chinese and no Japanese/Simplified Chinese
    if [[ -d "$locale_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese-specific characters (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for Japanese sentence patterns (more reliable than individual kanji)
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for Simplified Chinese specific characters (avoiding false positives)
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Simplified Chinese")
        fi
      done < <(grep -lE '简体|发现|实现|关系|忧郁|台湾|专业|档案|产品|学习|杂志|应用|转换|变化' "$locale_dir"/**/*.md 2>/dev/null)
      
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No foreign language contamination found in Traditional Chinese files"
      else
        print_warning "Found language contamination in ${#contaminated_files[@]} Traditional Chinese files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
        WARNINGS=$((WARNINGS + 1))
      fi
    fi
    ;;
  *)
    # Default: Check for Japanese contamination in all other locales
    if [[ -d "$locale_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$locale_dir"/**/*.md 2>/dev/null)
      
      # Check for Japanese sentence patterns (more reliable than individual kanji)
      while IFS= read -r file; do
        # Skip if already detected
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$locale_dir"/**/*.md 2>/dev/null)
      
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No Japanese contamination found in $locale files"
      else
        print_warning "Found Japanese contamination in ${#contaminated_files[@]} $locale files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
        WARNINGS=$((WARNINGS + 1))
      fi
    fi
    ;;
  esac
}

# Function to check language codes in specific command files
check_language_codes() {
  local locale="$1"
  local locale_dir="$LOCALES_DIR/$locale"
  
  print_info "Checking language codes in command files for $locale..."
  
  # Files that should have language-specific --lang options
  local target_files=("semantic-commit.md" "commit-message.md" "pr-auto-update.md" "update-doc-string.md")
  local issues_found=0
  
  # Define expected language codes for each locale
  local expected_lang=""
  local allow_ja_in_option=false
  case "$locale" in
    ja) 
      expected_lang="ja"
      allow_ja_in_option=true
      ;;
    en) 
      expected_lang="en"
      # English version should only support English
      ;;
    es) expected_lang="es" ;;
    fr) expected_lang="fr" ;;
    ko) expected_lang="ko" ;;
    pt) expected_lang="pt" ;;
    zh-cn) expected_lang="zh-cn" ;;
    zh-tw) expected_lang="zh-tw" ;;
    *) expected_lang="$locale" ;;
  esac
  
  for file in "${target_files[@]}"; do
    local file_path="$locale_dir/commands/$file"
    if [[ -f "$file_path" ]]; then
      # Check for incorrect language codes
      if [[ "$locale" == "en" ]]; then
        # English version should only have 'en', not 'ja' or other languages
        if grep -qE "\-\-lang.*[\(（].*[,，]" "$file_path" 2>/dev/null; then
          print_error "$file contains multiple language options in English version (should be 'en' only)"
          issues_found=$((issues_found + 1))
        fi
        if grep -qE "\-\-lang.*[\(（].*ja[,\)）]" "$file_path" 2>/dev/null; then
          print_error "$file contains Japanese language code 'ja' in English version"
          issues_found=$((issues_found + 1))
        fi
      elif [[ "$locale" != "ja" ]]; then
        # Non-Japanese, non-English locales should not have 'ja'
        if grep -qE "\-\-lang.*[\(（].*ja[,\)）]" "$file_path" 2>/dev/null; then
          print_error "$file contains Japanese language code 'ja' instead of '$expected_lang'"
          issues_found=$((issues_found + 1))
        fi
        
        # Check for JSON examples with "language": "ja"
        if grep -qE '"language":\s*"ja"' "$file_path" 2>/dev/null; then
          print_error "$file contains JSON with Japanese language code in 'language' field"
          issues_found=$((issues_found + 1))
        fi
        
        # Check if the file contains the correct language code
        # Look for patterns like (en, pt) or <en|pt> or （en, zh-cn）(full-width parentheses)
        if ! grep -qE "(\-\-lang.*[\(（].*$expected_lang[,\)）]|\-\-lang.*<.*\|?$expected_lang>)" "$file_path" 2>/dev/null; then
          print_warning "$file may be missing the correct language code '$expected_lang'"
          WARNINGS=$((WARNINGS + 1))
        fi
        
        # Special check for update-doc-string.md - DOC_LANGUAGE variable
        if [[ "$file" == "update-doc-string.md" ]]; then
          if grep -qE 'DOC_LANGUAGE="ja"' "$file_path" 2>/dev/null; then
            print_error "$file contains DOC_LANGUAGE=\"ja\" instead of \"$expected_lang\""
            issues_found=$((issues_found + 1))
          fi
        fi
      fi
    fi
  done
  
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if [[ $issues_found -eq 0 ]]; then
    print_success "All language codes are correct for $locale"
  else
    print_error "Found $issues_found language code issues in $locale"
    ERRORS=$((ERRORS + 1))
  fi
}

# Function to compare with Japanese base files
compare_with_base() {
  local locale="$1"
  local locale_dir="$LOCALES_DIR/$locale"

  print_info "Comparing $locale with Japanese base files..."

  # Compare command counts
  if [[ -d "$COMMANDS_DIR" ]] && [[ -d "$locale_dir/commands" ]]; then
    local base_count
    base_count=$(find "$COMMANDS_DIR" -name "*.md" -type f -exec printf '.' \; | wc -c)
    local locale_count
    locale_count=$(find "$locale_dir/commands" -name "*.md" -type f -exec printf '.' \; | wc -c)

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ $locale_count -eq $base_count ]]; then
      print_success "Command file count matches base ($base_count files)"
    else
      print_warning "Command file count differs from base (base: $base_count, $locale: $locale_count)"
    fi
  fi

  # Compare role counts
  if [[ -d "$AGENTS_DIR/roles" ]] && [[ -d "$locale_dir/agents/roles" ]]; then
    local base_count
    base_count=$(find "$AGENTS_DIR/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)
    local locale_count
    locale_count=$(find "$locale_dir/agents/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ $locale_count -eq $base_count ]]; then
      print_success "Role file count matches base ($base_count files)"
    else
      print_warning "Role file count differs from base (base: $base_count, $locale: $locale_count)"
    fi
  fi

  # Check for CLAUDE.md
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if [[ -f "$locale_dir/CLAUDE.md" ]]; then
    print_success "CLAUDE.md exists"
  else
    print_error "CLAUDE.md is missing"
  fi

  # Check for COMMAND_TEMPLATE.md
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if [[ -f "$locale_dir/COMMAND_TEMPLATE.md" ]]; then
    print_success "COMMAND_TEMPLATE.md exists"
  else
    print_error "COMMAND_TEMPLATE.md is missing"
  fi

  # Check for missing files
  print_info "Checking for missing files in $locale..."
  local missing_files=0

  for file in "$COMMANDS_DIR"/*.md; do
    if [[ -f "$file" ]]; then
      local basename
      basename=$(basename "$file")
      if [[ ! -f "$locale_dir/commands/$basename" ]]; then
        print_warning "Missing in $locale: commands/$basename"
        missing_files=$((missing_files + 1))
      fi
    fi
  done

  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if [[ $missing_files -eq 0 ]]; then
    print_success "All command files have corresponding translations"
  else
    print_error "$missing_files command files are missing translations"
  fi

  # Check for significant differences in content
  print_info "Checking content differences for $locale..."
  local content_issues=0
  local files_with_issues=()

  # Check command files
  for file in "$COMMANDS_DIR"/*.md; do
    if [[ -f "$file" ]]; then
      local basename
      basename=$(basename "$file")
      local locale_file="$locale_dir/commands/$basename"
      if [[ -f "$locale_file" ]]; then
        local ja_lines
        ja_lines=$(wc -l <"$file")
        local locale_lines
        locale_lines=$(wc -l <"$locale_file")
        local ja_sections
        ja_sections=$(grep -c "^#" "$file" || echo 0)
        local locale_sections
        locale_sections=$(grep -c "^#" "$locale_file" || echo 0)

        # Check line count difference (more than 50% difference)
        if [[ $ja_lines -gt 0 ]]; then
          local line_ratio=$((locale_lines * 100 / ja_lines))
          if [[ $line_ratio -lt 50 ]] || [[ $line_ratio -gt 150 ]]; then
            files_with_issues+=("commands/$basename (lines: ${line_ratio}%)")
            content_issues=$((content_issues + 1))
          fi
        fi

        # Check section count difference
        if [[ $ja_sections -ne $locale_sections ]]; then
          files_with_issues+=("commands/$basename (sections: JP=$ja_sections, $locale=$locale_sections)")
          content_issues=$((content_issues + 1))
        fi
      fi
    fi
  done

  # Check role files
  for file in "$AGENTS_DIR/roles"/*.md; do
    if [[ -f "$file" ]]; then
      local basename
      basename=$(basename "$file")
      local locale_file="$locale_dir/agents/roles/$basename"
      if [[ -f "$locale_file" ]]; then
        local ja_lines
        ja_lines=$(wc -l <"$file")
        local locale_lines
        locale_lines=$(wc -l <"$locale_file")
        local ja_sections
        ja_sections=$(grep -c "^#" "$file" || echo 0)
        local locale_sections
        locale_sections=$(grep -c "^#" "$locale_file" || echo 0)

        # Check line count difference (more than 50% difference)
        if [[ $ja_lines -gt 0 ]]; then
          local line_ratio=$((locale_lines * 100 / ja_lines))
          if [[ $line_ratio -lt 50 ]] || [[ $line_ratio -gt 150 ]]; then
            files_with_issues+=("agents/roles/$basename (lines: ${line_ratio}%)")
            content_issues=$((content_issues + 1))
          fi
        fi

        # Check section count difference
        if [[ $ja_sections -ne $locale_sections ]]; then
          files_with_issues+=("agents/roles/$basename (sections: JP=$ja_sections, $locale=$locale_sections)")
          content_issues=$((content_issues + 1))
        fi
      fi
    fi
  done

  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if [[ $content_issues -eq 0 ]]; then
    print_success "All translated files have consistent content structure"
  else
    print_warning "Found $content_issues files with significant differences:"
    for issue in "${files_with_issues[@]}"; do
      echo "    ⚠️  $issue"
    done
    WARNINGS=$((WARNINGS + content_issues))
  fi
}

# Function to compare locales
compare_locales() {
  local locale1="$1"
  local locale2="$2"

  print_info "Comparing $locale1 and $locale2..."

  # Compare command counts
  if [[ -d "$LOCALES_DIR/$locale1/commands" ]] && [[ -d "$LOCALES_DIR/$locale2/commands" ]]; then
    local count1
    count1=$(find "$LOCALES_DIR/$locale1/commands" -name "*.md" -type f -exec printf '.' \; | wc -c)
    local count2
    count2=$(find "$LOCALES_DIR/$locale2/commands" -name "*.md" -type f -exec printf '.' \; | wc -c)

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ $count1 -eq $count2 ]]; then
      print_success "Command file count matches ($count1 files)"
    else
      print_error "Command file count mismatch ($locale1: $count1, $locale2: $count2)"
    fi
  fi

  # Compare role counts
  if [[ -d "$LOCALES_DIR/$locale1/agents/roles" ]] && [[ -d "$LOCALES_DIR/$locale2/agents/roles" ]]; then
    local count1
    count1=$(find "$LOCALES_DIR/$locale1/agents/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)
    local count2
    count2=$(find "$LOCALES_DIR/$locale2/agents/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ $count1 -eq $count2 ]]; then
      print_success "Role file count matches ($count1 files)"
    else
      print_error "Role file count mismatch ($locale1: $count1, $locale2: $count2)"
    fi
  fi
}

# Function to check file sizes and quality metrics
check_quality_metrics() {
  local locale="$1"
  local locale_dir="$LOCALES_DIR/$locale"

  print_info "Quality metrics for $locale..."

  if [[ -d "$locale_dir/commands" ]]; then
    # Calculate average file size
    local total_size=0
    local file_count=0
    local smallest_file=""
    local smallest_size=999999
    local largest_file=""
    local largest_size=0

    for file in "$locale_dir/commands"/*.md; do
      if [[ -f "$file" ]]; then
        local size
        size=$(wc -c <"$file")
        total_size=$((total_size + size))
        file_count=$((file_count + 1))

        if [[ $size -lt $smallest_size ]]; then
          smallest_size=$size
          smallest_file=$(basename "$file")
        fi

        if [[ $size -gt $largest_size ]]; then
          largest_size=$size
          largest_file=$(basename "$file")
        fi
      fi
    done

    if [[ $file_count -gt 0 ]]; then
      local avg_size=$((total_size / file_count))
      echo "  📊 Average file size: $(format_bytes "$avg_size")"
      echo "  📄 Smallest: $smallest_file ($(format_bytes "$smallest_size"))"
      echo "  📄 Largest: $largest_file ($(format_bytes "$largest_size"))"
    fi
  fi
}

# Helper function to format bytes
format_bytes() {
  local bytes=$1
  if [[ $bytes -lt 1024 ]]; then
    echo "${bytes}B"
  elif [[ $bytes -lt 1048576 ]]; then
    echo "$((bytes / 1024)) KB"
  else
    echo "$((bytes / 1048576)) MB"
  fi
}

# Function to generate detailed report
generate_report() {
  echo ""
  echo "╔════════════════════════════════╗"
  echo "║         Validation Report      ║"
  echo "╚════════════════════════════════╝"
  echo ""
  echo "📈 Statistics:"
  echo "  • Total checks performed: $TOTAL_CHECKS"
  echo -e "  • ${GREEN}✅ Passed: $PASSED_CHECKS${NC}"
  echo -e "  • ${RED}❌ Failed: $FAILED_CHECKS${NC}"
  echo -e "  • ${YELLOW}⚠️  Warnings: $WARNINGS${NC}"

  local success_rate=0
  if [[ $TOTAL_CHECKS -gt 0 ]]; then
    success_rate=$((PASSED_CHECKS * 100 / TOTAL_CHECKS))
  fi

  echo ""
  echo "📊 Success Rate: ${success_rate}%"

  # Progress bar
  echo -n "   ["
  local bar_length=30
  local filled=$((success_rate * bar_length / 100))
  for ((i = 0; i < filled; i++)); do
    echo -n "█"
  done
  for ((i = filled; i < bar_length; i++)); do
    echo -n "░"
  done
  echo "]"

  echo ""
  if [[ $FAILED_CHECKS -eq 0 ]]; then
    echo -e "${GREEN}╔═══════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  🎉 All validation checks passed! ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════╝${NC}"
    return 0
  else
    echo -e "${RED}╔═══════════════════════════════════════╗${NC}"
    echo -e "${RED}║  ⚠️  Validation failed: $FAILED_CHECKS error(s) ║${NC}"
    echo -e "${RED}╚═══════════════════════════════════════╝${NC}"
    return 1
  fi
}

# Function to check documentation files (README in root, CLAUDE and COMMAND_TEMPLATE in locales)
check_documentation_files() {
  local locale="$1"

  print_info "Checking documentation files for $locale..."

  # README files are in root with suffix
  # CLAUDE.md and COMMAND_TEMPLATE.md are in locales without suffix
  local doc_files=(
    "README_${locale}.md"
    "locales/${locale}/CLAUDE.md"
    "locales/${locale}/COMMAND_TEMPLATE.md"
  )

  local base_files=(
    "README.md"
    "CLAUDE.md"
    "COMMAND_TEMPLATE.md"
  )

  local missing_docs=()
  local found_docs=0
  local content_issues=0

  for i in "${!doc_files[@]}"; do
    local doc_file="${doc_files[$i]}"
    local base_file="${base_files[$i]}"
    local file_path="$PROJECT_ROOT/$doc_file"
    local base_path="$PROJECT_ROOT/$base_file"

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    if [[ -f "$file_path" ]]; then
      print_success "$(basename "$doc_file") exists"
      found_docs=$((found_docs + 1))

      # Check if file has substantial content
      local size
      size=$(wc -c <"$file_path")
      if [[ $size -lt 500 ]]; then
        print_warning "  ⚠️  $(basename "$doc_file") seems too small (${size} bytes)"
        WARNINGS=$((WARNINGS + 1))
      fi

      # Compare sections with base file (excluding code blocks)
      if [[ -f "$base_path" ]]; then
        # Count sections excluding those in code blocks
        # Method: Remove code blocks first, then count headers
        local base_sections
        base_sections=$(sed '/^```/,/^```/d' "$base_path" 2>/dev/null | grep -c -E "^#{1,3} " || echo "0")
        local locale_sections
        locale_sections=$(sed '/^```/,/^```/d' "$file_path" 2>/dev/null | grep -c -E "^#{1,3} " || echo "0")

        # If sed fails, fallback to simple grep
        if [[ -z "$base_sections" || "$base_sections" -eq 0 ]]; then
          base_sections=$(grep -c -E "^#{1,3} " "$base_path" || echo "0")
        fi
        if [[ -z "$locale_sections" || "$locale_sections" -eq 0 ]]; then
          locale_sections=$(grep -c -E "^#{1,3} " "$file_path" || echo "0")
        fi

        # Check section differences - warn if any difference
        if [[ $locale_sections -ne $base_sections ]]; then
          print_warning "  ⚠️  Section count mismatch in $(basename "$doc_file"): Base=$base_sections, $locale=$locale_sections"
          content_issues=$((content_issues + 1))
          WARNINGS=$((WARNINGS + 1))
        fi

        # Check line count differences - warn if > 5%
        local base_lines
        base_lines=$(wc -l <"$base_path" | tr -d ' ')
        local locale_lines
        locale_lines=$(wc -l <"$file_path" | tr -d ' ')

        if [[ $base_lines -gt 0 ]]; then
          local line_diff=$((locale_lines - base_lines))
          if [[ $line_diff -lt 0 ]]; then
            line_diff=$((-line_diff))
          fi
          local diff_percent=$((line_diff * 100 / base_lines))

          if [[ $diff_percent -gt 5 ]]; then
            print_warning "  ⚠️  Line count difference > 5% in $(basename "$doc_file"): Base=$base_lines lines, $locale=$locale_lines lines (${diff_percent}% difference)"
            WARNINGS=$((WARNINGS + 1))
          fi
        fi

        # Check for Spanish-specific quality issues
        if [[ "$locale" == "es" ]]; then
          # Check for common Spanish translation issues
          local quality_issues=0

          # Check for missing accents in common words
          if grep -q -E "\b(mas|tambien|facil|rapido|faciles|despues|mas)\b" "$file_path" 2>/dev/null; then
            print_warning "  ⚠️  Possible missing accents detected in $(basename "$doc_file")"
            quality_issues=$((quality_issues + 1))
          fi

          # Check for incorrect verb forms or anglicisms
          if grep -q -E "(hacer click|hacer clic|setear|testear)" "$file_path" 2>/dev/null; then
            print_warning "  ⚠️  Possible anglicisms detected in $(basename "$doc_file")"
            quality_issues=$((quality_issues + 1))
          fi

          # Check for proper Spanish punctuation (¿ and ¡)
          local questions
          questions=$(grep -c "?" "$file_path" 2>/dev/null || echo 0)
          questions=${questions//[^0-9]/} # Remove non-digit characters
          local spanish_questions
          spanish_questions=$(grep -c "¿" "$file_path" 2>/dev/null || echo 0)
          spanish_questions=${spanish_questions//[^0-9]/} # Remove non-digit characters
          if [[ $questions -gt 0 ]] && [[ $spanish_questions -eq 0 ]]; then
            print_warning "  ⚠️  Missing Spanish question marks (¿) in $(basename "$doc_file")"
            quality_issues=$((quality_issues + 1))
          fi

          if [[ $quality_issues -gt 0 ]]; then
            WARNINGS=$((WARNINGS + quality_issues))
          fi
        fi
      fi
    else
      print_error "$(basename "$doc_file") is missing"
      missing_docs+=("$(basename "$doc_file")")
      FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
  done

  # Summary
  if [[ ${#missing_docs[@]} -eq 0 ]]; then
    if [[ $content_issues -eq 0 ]]; then
      print_info "All documentation files present and consistent for $locale"
    else
      print_warning "Documentation files present but with $content_issues content issues for $locale"
    fi
  else
    print_warning "Missing documentation files: ${missing_docs[*]}"
  fi
}

# Function to check for translation completeness
check_translation_completeness() {
  local locale="$1"
  local locale_dir="$LOCALES_DIR/$locale"

  print_info "Translation completeness for $locale..."

  if [[ -d "$locale_dir/commands" ]]; then
    local empty_files=0
    local incomplete_files=()

    for file in "$locale_dir/commands"/*.md; do
      if [[ -f "$file" ]]; then
        local lines
        lines=$(wc -l <"$file")
        local size
        size=$(wc -c <"$file")

        if [[ $size -lt 100 ]]; then
          empty_files=$((empty_files + 1))
          incomplete_files+=("$(basename "$file")")
        elif [[ $lines -lt 10 ]]; then
          incomplete_files+=("$(basename "$file")")
        fi
      fi
    done

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ $empty_files -eq 0 && ${#incomplete_files[@]} -eq 0 ]]; then
      print_success "All files appear to be fully translated"
    else
      if [[ $empty_files -gt 0 ]]; then
        print_warning "Found $empty_files nearly empty files (<100 bytes)"
      fi
      if [[ ${#incomplete_files[@]} -gt 0 ]]; then
        print_warning "Potentially incomplete translations (< 10 lines):"
        for file in "${incomplete_files[@]:0:5}"; do
          echo "    ⚠️  $file"
        done
        if [[ ${#incomplete_files[@]} -gt 5 ]]; then
          echo "    ... and $((${#incomplete_files[@]} - 5)) more"
        fi
      fi
    fi
  fi
}

# Main execution
main() {
  echo ""
  echo "╔═══════════════════════════════════════╗"
  echo "║      🔍 Locale Validation Tool        ║"
  echo "╠═══════════════════════════════════════╣"
  echo "║   Enhanced validation & reporting     ║"
  echo "╚═══════════════════════════════════════╝"
  echo ""

  # Check if locales directory exists
  if [[ ! -d "$LOCALES_DIR" ]]; then
    print_warning "Locales directory not found: $LOCALES_DIR"
    print_info "This project uses Japanese as the base language in commands/ and agents/"
  fi

  # Parse arguments
  if [[ $# -eq 0 ]]; then
    # Check base Japanese files first
    echo "────────────────────────────────"
    echo "Base Files (Japanese)"
    echo "────────────────────────────────"

    if [[ -d "$COMMANDS_DIR" ]]; then
      local ja_cmd_count
      ja_cmd_count=$(find "$COMMANDS_DIR" -name "*.md" -type f -exec printf '.' \; | wc -c)
      echo "  Commands: $ja_cmd_count files"
    fi

    if [[ -d "$AGENTS_DIR/roles" ]]; then
      local ja_role_count
      ja_role_count=$(find "$AGENTS_DIR/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)
      echo "  Roles: $ja_role_count files"
    fi

    # Check for main documentation files
    local main_docs=()
    [[ -f "$PROJECT_ROOT/README.md" ]] && main_docs+=("README.md")
    [[ -f "$PROJECT_ROOT/CLAUDE.md" ]] && main_docs+=("CLAUDE.md")
    [[ -f "$PROJECT_ROOT/docs/templates/COMMAND_TEMPLATE.md" ]] && main_docs+=("COMMAND_TEMPLATE.md")

    if [[ ${#main_docs[@]} -gt 0 ]]; then
      echo "  Documentation: ${#main_docs[@]} files (${main_docs[*]})"
    fi
    echo ""

    # Validate all locales if directory exists
    if [[ -d "$LOCALES_DIR" ]]; then
      print_info "Validating all locales..."
      echo ""

      for locale_dir in "$LOCALES_DIR"/*; do
        if [[ -d "$locale_dir" ]]; then
          local locale
          locale=$(basename "$locale_dir")
          echo "────────────────────────────────"
          echo "Locale: $locale"
          echo "────────────────────────────────"
          check_structure "$locale"
          count_files "$locale"
          check_language_content "$locale"
          check_language_codes "$locale"
          check_quality_metrics "$locale"
          check_translation_completeness "$locale"
          check_documentation_files "$locale"
          compare_with_base "$locale"
          echo ""
        fi
      done

      # Compare locales if multiple exist
      local locales=()
      while IFS= read -r dir; do
        locales+=("$(basename "$dir")")
      done < <(find "$LOCALES_DIR" -mindepth 1 -maxdepth 1 -type d)
      if [[ ${#locales[@]} -ge 2 ]]; then
        echo "────────────────────────────────"
        echo "Locale Comparison"
        echo "────────────────────────────────"
        compare_locales "${locales[0]}" "${locales[1]}"
      fi
    fi

  else
    # Validate specific locale
    local locale="$1"

    if [[ ! -d "$LOCALES_DIR/$locale" ]]; then
      print_error "Locale not found: $locale"
      print_info "Available locales:"
      for dir in "$LOCALES_DIR"/*; do
        if [[ -d "$dir" ]]; then
          echo "  - $(basename "$dir")"
        fi
      done
      exit 1
    fi

    check_structure "$locale"
    count_files "$locale"
    check_language_content "$locale"
    check_language_codes "$locale"
    check_quality_metrics "$locale"
    check_translation_completeness "$locale"
    check_documentation_files "$locale"
    compare_with_base "$locale"

    # If second argument provided, compare with it
    if [[ -n "${2:-}" ]]; then
      echo ""
      compare_locales "$locale" "$2"
    fi
  fi

  generate_report
}

main "$@"
