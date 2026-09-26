#!/bin/bash

LOG_DIR="active_logs"
REPORT_DIR="reports"
HEART_LOG="$LOG_DIR/heart_rate_log.log"
TEMP_LOG="$LOG_DIR/temperature_log.log"
WATER_LOG="$LOG_DIR/water_usage_log.log"

process_vitals() {
    mkdir -p "$REPORT_DIR"
    grep -h "CRITICAL" "$HEART_LOG" "$TEMP_LOG" | awk -F' \\| ' '{print $1, "|", $2, "|", $3}' > "$REPORT_DIR/critical_alerts.txt"
    echo "Critical alerts found: $(wc -l < "$REPORT_DIR/critical_alerts.txt")"
    echo "Saved to $REPORT_DIR/critical_alerts.txt"
}

water_audit() {
    awk -F' \\| ' '$2 == "ICU_WATER_RESERVE" {sum += $3; count++}
    END {print sum / count}' "$WATER_LOG"
}

process_vitals
