#!/bin/bash

process_vitals() {
    mkdir -p reports

    grep "CRITICAL" active_logs/heart_rate_log.log active_logs/temperature_log.log | \
    awk -F' \\| ' '{
        print $1 " | " $2 " | " $3
    }' > reports/critical_alerts.txt

    echo "Critical alerts report generated."
}

water_audit() {
    awk -F' \\| ' '
    $2 == "ICU_WATER_RESERVE" {
        total += $3
        count++
    }
    END {
        if (count > 0)
            printf "Average ICU Water Usage: %.2f Liters/min\n", total/count
        else
            printf "No ICU water records found.\n"
    }' active_logs/water_usage_log.log
}

process_vitals
water_audit