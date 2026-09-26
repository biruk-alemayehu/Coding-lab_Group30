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
    END {
        if (count == 0) { print "No ICU_WATER_RESERVE readings found"; exit }
        printf "\n===== ICU Water Audit =====\n"
        printf "%-12s %s\n", "Device:", "ICU_WATER_RESERVE"
        printf "%-12s %d\n", "Readings:", count
        printf "%-12s %.2f L\n", "Average:", sum / count
        printf "===========================\n"
    }' "$WATER_LOG"
}

process_vitals
water_audit
