#!/bin/bash

# Validate plugin language versions for completeness and consistency
# Ensures each plugin has all required files and structure
# Adapted for plugins/ directory structure

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Project paths
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGINS_DIR="$PROJECT_ROOT/plugins"
COMMANDS_DIR="$PROJECT_ROOT/commands"
AGENTS_DIR="$PROJECT_ROOT/agents"

# Required directories for each plugin
REQUIRED_DIRS=("commands" "agents/roles" ".claude-plugin")

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
  local lang="$1"
  local plugin_dir="$PLUGINS_DIR/$lang"

  print_info "Checking directory structure for $lang..."

  for dir in "${REQUIRED_DIRS[@]}"; do
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ -d "$plugin_dir/$dir" ]]; then
      print_success "$dir exists"
    else
      print_error "$dir is missing"
    fi
  done

  # Check for plugin.json
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if [[ -f "$plugin_dir/.claude-plugin/plugin.json" ]]; then
    print_success "plugin.json exists"
  else
    print_error "plugin.json is missing"
  fi

  # Check for README.md
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if [[ -f "$plugin_dir/README.md" ]]; then
    print_success "README.md exists"
  else
    print_error "README.md is missing"
  fi
}

# Function to count files in directories
count_files() {
  local lang="$1"
  local plugin_dir="$PLUGINS_DIR/$lang"

  print_info "File counts for $lang:"

  # Count command files
  if [[ -d "$plugin_dir/commands" ]]; then
    local cmd_count
    cmd_count=$(find "$plugin_dir/commands" -name "*.md" -type f -exec printf '.' \; | wc -c)
    echo "  Commands: $cmd_count files"
  fi

  # Count role files
  if [[ -d "$plugin_dir/agents/roles" ]]; then
    local role_count
    role_count=$(find "$plugin_dir/agents/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)
    echo "  Roles: $role_count files"
  fi
}

# Function to check for language-specific content
check_language_content() {
  local lang="$1"
  local plugin_dir="$PLUGINS_DIR/$lang"

  print_info "Checking language content for $lang..."

  # Define expected language patterns
  case "$lang" in
  zh-cn)
    # Check for Simplified Chinese and no Japanese/Traditional Chinese
    if [[ -d "$plugin_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese-specific characters (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$plugin_dir"/**/*.md 2>/dev/null)

      # Check for Japanese sentence patterns
      while IFS= read -r file; do
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$plugin_dir"/**/*.md 2>/dev/null)

      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No foreign language contamination found"
      else
        print_warning "Found language contamination in ${#contaminated_files[@]} files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
      fi
    fi
    ;;
  zh-tw)
    # Check for Traditional Chinese and no Japanese/Simplified Chinese
    if [[ -d "$plugin_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese-specific characters
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$plugin_dir"/**/*.md 2>/dev/null)

      # Check for Japanese sentence patterns
      while IFS= read -r file; do
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$plugin_dir"/**/*.md 2>/dev/null)

      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No foreign language contamination found"
      else
        print_warning "Found language contamination in ${#contaminated_files[@]} files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
      fi
    fi
    ;;
  en|es|fr|ko|pt)
    # Check for Japanese contamination in non-Japanese plugins
    if [[ -d "$plugin_dir/commands" ]]; then
      local contaminated_files=()
      # Check for Japanese (hiragana, katakana)
      while IFS= read -r file; do
        contaminated_files+=("$(basename "$file"): Japanese")
      done < <(grep -l '[ぁ-んァ-ヶー]' "$plugin_dir"/**/*.md 2>/dev/null)

      # Check for Japanese sentence patterns
      while IFS= read -r file; do
        if ! echo "${contaminated_files[@]}" | grep -q "$(basename "$file")"; then
          contaminated_files+=("$(basename "$file"): Japanese patterns")
        fi
      done < <(grep -lE 'です|ます|である|により|において|について|に関して' "$plugin_dir"/**/*.md 2>/dev/null)

      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
      if [[ ${#contaminated_files[@]} -eq 0 ]]; then
        print_success "No Japanese contamination found in $lang files"
      else
        print_warning "Found Japanese contamination in ${#contaminated_files[@]} $lang files:"
        for file in "${contaminated_files[@]}"; do
          echo "    ⚠️  $file"
        done
      fi
    fi
    ;;
  ja)
    # Japanese is the base language, no contamination check needed
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    print_success "Japanese is the base language"
    ;;
  *)
    print_warning "Unknown language: $lang, skipping content check"
    ;;
  esac
}

# Function to compare with Japanese base files
compare_with_base() {
  local lang="$1"
  local plugin_dir="$PLUGINS_DIR/$lang"

  # Skip comparison for Japanese base
  if [[ "$lang" == "ja" ]]; then
    return 0
  fi

  print_info "Comparing $lang with Japanese base files..."

  # Compare command counts
  if [[ -d "$COMMANDS_DIR" ]] && [[ -d "$plugin_dir/commands" ]]; then
    local base_count
    base_count=$(find "$COMMANDS_DIR" -name "*.md" -type f -exec printf '.' \; | wc -c)
    local lang_count
    lang_count=$(find "$plugin_dir/commands" -name "*.md" -type f -exec printf '.' \; | wc -c)

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ $lang_count -eq $base_count ]]; then
      print_success "Command file count matches base ($base_count files)"
    else
      print_warning "Command file count differs from base (base: $base_count, $lang: $lang_count)"
    fi
  fi

  # Compare role counts
  if [[ -d "$AGENTS_DIR/roles" ]] && [[ -d "$plugin_dir/agents/roles" ]]; then
    local base_count
    base_count=$(find "$AGENTS_DIR/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)
    local lang_count
    lang_count=$(find "$plugin_dir/agents/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ $lang_count -eq $base_count ]]; then
      print_success "Role file count matches base ($base_count files)"
    else
      print_warning "Role file count differs from base (base: $base_count, $lang: $lang_count)"
    fi
  fi

  # Check for missing files
  print_info "Checking for missing files in $lang..."
  local missing_files=0

  for file in "$COMMANDS_DIR"/*.md; do
    if [[ -f "$file" ]]; then
      local basename
      basename=$(basename "$file")
      if [[ ! -f "$plugin_dir/commands/$basename" ]]; then
        print_warning "Missing in $lang: commands/$basename"
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
}

# Function to compare plugins
compare_plugins() {
  local lang1="$1"
  local lang2="$2"

  print_info "Comparing $lang1 and $lang2..."

  # Compare command counts
  if [[ -d "$PLUGINS_DIR/$lang1/commands" ]] && [[ -d "$PLUGINS_DIR/$lang2/commands" ]]; then
    local count1
    count1=$(find "$PLUGINS_DIR/$lang1/commands" -name "*.md" -type f -exec printf '.' \; | wc -c)
    local count2
    count2=$(find "$PLUGINS_DIR/$lang2/commands" -name "*.md" -type f -exec printf '.' \; | wc -c)

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ $count1 -eq $count2 ]]; then
      print_success "Command file count matches ($count1 files)"
    else
      print_error "Command file count mismatch ($lang1: $count1, $lang2: $count2)"
    fi
  fi

  # Compare role counts
  if [[ -d "$PLUGINS_DIR/$lang1/agents/roles" ]] && [[ -d "$PLUGINS_DIR/$lang2/agents/roles" ]]; then
    local count1
    count1=$(find "$PLUGINS_DIR/$lang1/agents/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)
    local count2
    count2=$(find "$PLUGINS_DIR/$lang2/agents/roles" -name "*.md" -type f -exec printf '.' \; | wc -c)

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [[ $count1 -eq $count2 ]]; then
      print_success "Role file count matches ($count1 files)"
    else
      print_error "Role file count mismatch ($lang1: $count1, $lang2: $count2)"
    fi
  fi
}

# Function to check plugin.json validity
check_plugin_json() {
  local lang="$1"
  local plugin_json="$PLUGINS_DIR/$lang/.claude-plugin/plugin.json"

  print_info "Checking plugin.json for $lang..."

  if [[ ! -f "$plugin_json" ]]; then
    print_error "plugin.json not found"
    return 1
  fi

  # Check JSON syntax
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if jq empty "$plugin_json" 2>/dev/null; then
    print_success "plugin.json is valid JSON"
  else
    print_error "plugin.json has invalid JSON syntax"
    return 1
  fi

  # Check required fields
  local required_fields=("name" "version" "description" "author" "repository" "license")
  local missing_fields=()

  for field in "${required_fields[@]}"; do
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if jq -e ".$field" "$plugin_json" > /dev/null 2>&1; then
      print_success "Field '$field' exists"
    else
      print_error "Field '$field' is missing"
      missing_fields+=("$field")
    fi
  done

  # Check if name matches expected pattern
  local expected_name="claude-code-cookbook-$lang"
  local actual_name
  actual_name=$(jq -r '.name' "$plugin_json")

  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if [[ "$actual_name" == "$expected_name" ]]; then
    print_success "Plugin name matches expected pattern: $expected_name"
  else
    print_error "Plugin name mismatch: expected '$expected_name', got '$actual_name'"
  fi
}

# Function to generate detailed report
generate_report() {
  echo ""
  echo "╔════════════════════════════════╗"
  echo "║      Validation Report         ║"
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

# Main execution
main() {
  echo ""
  echo "╔═══════════════════════════════════════╗"
  echo "║      🔍 Plugin Validation Tool        ║"
  echo "╠═══════════════════════════════════════╣"
  echo "║   Enhanced validation & reporting     ║"
  echo "╚═══════════════════════════════════════╝"
  echo ""

  # Check if plugins directory exists
  if [[ ! -d "$PLUGINS_DIR" ]]; then
    print_error "Plugins directory not found: $PLUGINS_DIR"
    exit 1
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
    echo ""

    # Validate all plugins
    print_info "Validating all plugins..."
    echo ""

    for plugin_dir in "$PLUGINS_DIR"/*; do
      if [[ -d "$plugin_dir" ]]; then
        local lang
        lang=$(basename "$plugin_dir")
        echo "────────────────────────────────"
        echo "Plugin: $lang"
        echo "────────────────────────────────"
        check_structure "$lang"
        count_files "$lang"
        check_plugin_json "$lang"
        check_language_content "$lang"
        compare_with_base "$lang"
        echo ""
      fi
    done

    # Compare plugins if multiple exist
    local langs=()
    while IFS= read -r dir; do
      langs+=("$(basename "$dir")")
    done < <(find "$PLUGINS_DIR" -mindepth 1 -maxdepth 1 -type d)
    if [[ ${#langs[@]} -ge 2 ]]; then
      echo "────────────────────────────────"
      echo "Plugin Comparison"
      echo "────────────────────────────────"
      compare_plugins "${langs[0]}" "${langs[1]}"
    fi

  else
    # Validate specific plugin
    local lang="$1"

    if [[ ! -d "$PLUGINS_DIR/$lang" ]]; then
      print_error "Plugin not found: $lang"
      print_info "Available plugins:"
      for dir in "$PLUGINS_DIR"/*; do
        if [[ -d "$dir" ]]; then
          echo "  - $(basename "$dir")"
        fi
      done
      exit 1
    fi

    check_structure "$lang"
    count_files "$lang"
    check_plugin_json "$lang"
    check_language_content "$lang"
    compare_with_base "$lang"

    # If second argument provided, compare with it
    if [[ -n "${2:-}" ]]; then
      echo ""
      compare_plugins "$lang" "$2"
    fi
  fi

  generate_report
}

main "$@"
