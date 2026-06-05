#!/bin/bash


STAMP=$(date +"%Y%m%d_%H%M")

# Move the logs
mv active_logs/heart_rate.log archived_logs/heart_rate_${STAMP}.log
mv active_logs/temperature.log archived_logs/temperature_${STAMP}.log
mv active_logs/water_usage.log archived_logs/water_usage_${STAMP}.log

echo "Logs archived with timestamp: $STAMP"

# Recreate empty log files so the engine keeps running
touch active_logs/heart_rate.log
touch active_logs/temperature.log
touch active_logs/water_usage.log

echo "Empty log files recreated"
echo "Archive complete"
