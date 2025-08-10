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
        local cmd_count=$(find "$locale_dir/commands" -name "*.md" -type f | wc -l)
        echo "  Commands: $cmd_count files"
    fi

    # Count role files
    if [[ -d "$locale_dir/agents/roles" ]]; then
        local role_count=$(find "$locale_dir/agents/roles" -name "*.md" -type f | wc -l)
        echo "  Roles: $role_count files"
    fi
}

# Function to check for language-specific content
check_language_content() {
    local locale="$1"
    local locale_dir="$LOCALES_DIR/$locale"
    local verbose="${2:-false}"

    print_info "Checking language content for $locale..."

    # Define expected language patterns
    case "$locale" in
        zh)
            # Check for Chinese content
            if [[ -d "$locale_dir/commands" ]]; then
                local zh_files=$(grep -l '[一-龯]' "$locale_dir/commands"/*.md 2>/dev/null | wc -l)
                if [[ $zh_files -gt 0 ]]; then
                    print_success "Found Chinese content in $zh_files command files"
                else
                    print_warning "No Chinese content found in commands"
                fi
            fi
            ;;
        en)
            # Check for English content and no Japanese/Chinese
            if [[ -d "$locale_dir/commands" ]]; then
                # Find files with CJK contamination
                local contaminated_files=()
                while IFS= read -r file; do
                    contaminated_files+=("$(basename "$file")")
                done < <(grep -l '[ぁ-んァ-ヶー一-龯]' "$locale_dir/commands"/*.md 2>/dev/null)

                local total_files=$(find "$locale_dir/commands" -name "*.md" -type f | wc -l)
                local clean_files=$((total_files - ${#contaminated_files[@]}))

                if [[ $clean_files -gt 0 ]]; then
                    print_success "Found $clean_files files without CJK content"
                fi

                if [[ ${#contaminated_files[@]} -gt 0 ]]; then
                    print_warning "Found CJK content in ${#contaminated_files[@]} files (should be English only):"
                    for file in "${contaminated_files[@]}"; do
                        echo "    📄 $file"
                    done
                fi
            fi
            ;;
        *)
            print_info "No specific language checks for $locale"
            ;;
    esac
}

# Function to compare with Japanese base files
compare_with_base() {
    local locale="$1"
    local locale_dir="$LOCALES_DIR/$locale"

    print_info "Comparing $locale with Japanese base files..."

    # Compare command counts
    if [[ -d "$COMMANDS_DIR" ]] && [[ -d "$locale_dir/commands" ]]; then
        local base_count=$(find "$COMMANDS_DIR" -name "*.md" -type f | wc -l)
        local locale_count=$(find "$locale_dir/commands" -name "*.md" -type f | wc -l)

        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
        if [[ $locale_count -eq $base_count ]]; then
            print_success "Command file count matches base ($base_count files)"
        else
            print_warning "Command file count differs from base (base: $base_count, $locale: $locale_count)"
        fi
    fi

    # Compare role counts
    if [[ -d "$AGENTS_DIR/roles" ]] && [[ -d "$locale_dir/agents/roles" ]]; then
        local base_count=$(find "$AGENTS_DIR/roles" -name "*.md" -type f | wc -l)
        local locale_count=$(find "$locale_dir/agents/roles" -name "*.md" -type f | wc -l)

        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
        if [[ $locale_count -eq $base_count ]]; then
            print_success "Role file count matches base ($base_count files)"
        else
            print_warning "Role file count differs from base (base: $base_count, $locale: $locale_count)"
        fi
    fi

    # Check for missing files
    print_info "Checking for missing files in $locale..."
    local missing_files=0

    for file in "$COMMANDS_DIR"/*.md; do
        if [[ -f "$file" ]]; then
            local basename=$(basename "$file")
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
}

# Function to compare locales
compare_locales() {
    local locale1="$1"
    local locale2="$2"

    print_info "Comparing $locale1 and $locale2..."

    # Compare command counts
    if [[ -d "$LOCALES_DIR/$locale1/commands" ]] && [[ -d "$LOCALES_DIR/$locale2/commands" ]]; then
        local count1=$(find "$LOCALES_DIR/$locale1/commands" -name "*.md" -type f | wc -l)
        local count2=$(find "$LOCALES_DIR/$locale2/commands" -name "*.md" -type f | wc -l)

        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
        if [[ $count1 -eq $count2 ]]; then
            print_success "Command file count matches ($count1 files)"
        else
            print_error "Command file count mismatch ($locale1: $count1, $locale2: $count2)"
        fi
    fi

    # Compare role counts
    if [[ -d "$LOCALES_DIR/$locale1/agents/roles" ]] && [[ -d "$LOCALES_DIR/$locale2/agents/roles" ]]; then
        local count1=$(find "$LOCALES_DIR/$locale1/agents/roles" -name "*.md" -type f | wc -l)
        local count2=$(find "$LOCALES_DIR/$locale2/agents/roles" -name "*.md" -type f | wc -l)

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
                local size=$(wc -c < "$file")
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
            echo "  📊 Average file size: $(format_bytes $avg_size)"
            echo "  📄 Smallest: $smallest_file ($(format_bytes $smallest_size))"
            echo "  📄 Largest: $largest_file ($(format_bytes $largest_size))"
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
    echo "║     Validation Summary Report  ║"
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
    for ((i=0; i<filled; i++)); do
        echo -n "█"
    done
    for ((i=filled; i<bar_length; i++)); do
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
        echo -e "${RED}╔════════════════════════════════╗${NC}"
        echo -e "${RED}║  ⚠️  Validation failed: $FAILED_CHECKS error(s) ║${NC}"
        echo -e "${RED}╚════════════════════════════════╝${NC}"
        return 1
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
                local lines=$(wc -l < "$file")
                local size=$(wc -c < "$file")

                if [[ $size -lt 100 ]]; then
                    empty_files=$((empty_files + 1))
                    incomplete_files+=("$(basename "$file")")
                elif [[ $lines -lt 10 ]]; then
                    incomplete_files+=("$(basename "$file")")
                fi
            fi
        done

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
    echo "║   🔍 Locale Validation Tool v2.0      ║"
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
            local ja_cmd_count=$(find "$COMMANDS_DIR" -name "*.md" -type f | wc -l)
            echo "  Commands: $ja_cmd_count files"
        fi

        if [[ -d "$AGENTS_DIR/roles" ]]; then
            local ja_role_count=$(find "$AGENTS_DIR/roles" -name "*.md" -type f | wc -l)
            echo "  Roles: $ja_role_count files"
        fi
        echo ""

        # Validate all locales if directory exists
        if [[ -d "$LOCALES_DIR" ]]; then
            print_info "Validating all locales..."
            echo ""

            for locale_dir in "$LOCALES_DIR"/*; do
                if [[ -d "$locale_dir" ]]; then
                    local locale=$(basename "$locale_dir")
                    echo "────────────────────────────────"
                    echo "Locale: $locale"
                    echo "────────────────────────────────"
                    check_structure "$locale"
                    count_files "$locale"
                    check_language_content "$locale"
                    check_quality_metrics "$locale"
                    check_translation_completeness "$locale"
                    compare_with_base "$locale"
                    echo ""
                fi
            done

            # Compare locales if multiple exist
            local locales=($(ls -d "$LOCALES_DIR"/*/ 2>/dev/null | xargs -n 1 basename))
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
