#!/bin/bash

process_vitals() {
    echo "Scanning vitals for CRITICAL events..."
    mkdir -p reports
    > reports/critical_alerts.txt

    # Delimiter is " | ". awk -F' \\| ' splits on it cleanly.
    # Cols: $1=Timestamp, $2=Device_ID, $3=Value, $4=Status
    grep "CRITICAL" active_logs/heart_rate_log.log active_logs/temperature_log.log 2>/dev/null \
        | awk -F' \\| ' '{print $1", "$2", "$3}' >> reports/critical_alerts.txt

    echo "Critical alerts saved to reports/critical_alerts.txt"
}
