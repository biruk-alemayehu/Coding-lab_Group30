#!/bin/bash

ACTIVE_DIR="active_logs"
ARCHIVE_DIR="archived_logs"


TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

logs=(
 "heart_rate_log.log"
 "temperature_log.log"
 "water_usage_log.log"
)

echo "Hospital log archiver started."
echo "Archive timestamp: $TIMESTAMP"


for log in "${logs[@]}"; do
    if [ -f "$ACTIVE_DIR/$log" ]; then
         base="${log%_log.log}"
         echo "Archiving $log..."

        if mv "$ACTIVE_DIR/$log" "$ARCHIVE_DIR/${base}_${TIMESTAMP}.log"; then
            touch "$ACTIVE_DIR/$log"
            echo "$log archived and recreated successfully."
        else
            echo "Error: Failed to archive $log."
        fi

    else
         echo "warning: $log was not found."
    fi
done
