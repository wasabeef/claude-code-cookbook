#!/bin/bash

# Constants
readonly MAX_CONTEXT=160000  # 200K * 0.8
readonly CACHE_FILE="/tmp/claude_statusline_cost_cache"
readonly CACHE_TTL=60  # seconds

# Calculate daily cost using ccusage
calculate_daily_cost() {
  if ! command -v ccusage >/dev/null 2>&1; then
    echo "0"
    return
  fi

  local today
  today=$(date +%Y%m%d)
  
  local ccusage_output
  ccusage_output=$(ccusage daily --json --since "$today" --until "$today" 2>/dev/null)
  
  if [ -z "$ccusage_output" ]; then
    echo "0"
    return
  fi
  
  local cost
  cost=$(echo "$ccusage_output" | jq -r ".daily | to_entries | .[0].value.totalCost // 0" 2>/dev/null)
  
  if [ -n "$cost" ] && [ "$cost" != "0" ]; then
    echo "$cost"
  else
    echo "0"
  fi
}

# Get cached cost or recalculate
get_cached_cost() {
  local today
  today=$(date +%Y-%m-%d)
  
  # Check if cache exists and is recent
  if [ -f "$CACHE_FILE" ]; then
    local cache_date cache_cost cache_age
    cache_date=$(head -1 "$CACHE_FILE" 2>/dev/null)
    cache_cost=$(tail -1 "$CACHE_FILE" 2>/dev/null)
    cache_age=$(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0)))
    
    # Use cache if it's from today and fresh
    if [ "$cache_date" = "$today" ] && [ "$cache_age" -le "$CACHE_TTL" ]; then
      echo "${cache_cost:-0.00}"
      return
    fi
  fi
  
  # Calculate and cache new cost
  local cost
  cost=$(calculate_daily_cost)
  cost="${cost:-0.00}"
  
  # Update cache
  echo "$today" >"$CACHE_FILE"
  echo "$cost" >>"$CACHE_FILE"
  
  echo "$cost"
}

# Calculate token usage percentage
calculate_usage_percentage() {
  local total_tokens="$1"
  
  if [ "$MAX_CONTEXT" -eq 0 ]; then
    echo "0.0"
    return
  fi
  
  local usage_percent
  usage_percent=$(echo "scale=1; $total_tokens * 100 / $MAX_CONTEXT" | bc -l 2>/dev/null || echo "0")
  
  # Cap at 100%
  if (($(echo "$usage_percent > 100" | bc -l 2>/dev/null))); then
    echo "100.0"
  else
    echo "$usage_percent"
  fi
}

# Get token usage from transcript
get_token_usage() {
  local session_id="$1"
  local transcript_dir="$2"
  local transcript_file="$transcript_dir/$session_id.jsonl"
  
  if [ ! -f "$transcript_file" ]; then
    echo "0"
    return
  fi
  
  # Get last usage entry (cumulative)
  local last_usage
  last_usage=$(grep '"usage"' "$transcript_file" 2>/dev/null | tail -1 | jq '.message.usage' 2>/dev/null)
  
  if [ -z "$last_usage" ] || [ "$last_usage" = "null" ]; then
    echo "0"
    return
  fi
  
  # Sum all token types
  local input output cache_creation cache_read
  input=$(echo "$last_usage" | jq -r '.input_tokens // 0')
  output=$(echo "$last_usage" | jq -r '.output_tokens // 0')
  cache_creation=$(echo "$last_usage" | jq -r '.cache_creation_input_tokens // 0')
  cache_read=$(echo "$last_usage" | jq -r '.cache_read_input_tokens // 0')
  
  echo $((input + output + cache_creation + cache_read))
}

# Main
main() {
  # Read JSON from stdin
  local json_input
  json_input=$(cat)
  
  # Extract fields
  local model session_id current_dir
  model=$(echo "$json_input" | jq -r '.model.display_name // .model // "unknown"' 2>/dev/null)
  session_id=$(echo "$json_input" | jq -r '.session_id // ""' 2>/dev/null)
  current_dir=$(echo "$json_input" | jq -r '.workspace.current_dir // .cwd // "~"' 2>/dev/null)
  
  # Build project directory path
  local project_name transcript_dir
  project_name="${current_dir//[\/.]/-}"
  transcript_dir="$HOME/.claude/projects/$project_name"
  
  # Get token usage
  local total_tokens=0
  if [ -n "$session_id" ] && [ -d "$transcript_dir" ]; then
    total_tokens=$(get_token_usage "$session_id" "$transcript_dir")
  fi
  
  # Calculate usage percentage
  local usage_percent
  usage_percent=$(calculate_usage_percentage "$total_tokens")
  
  # Get today's cost
  local today_cost
  today_cost=$(get_cached_cost)
  today_cost=$(printf "%.2f" "$today_cost")
  
  # Output status line
  printf "🤖 %s | 💰 $%s | 📊 %s%%\n" "$model" "$today_cost" "$usage_percent"
}

main "$@"