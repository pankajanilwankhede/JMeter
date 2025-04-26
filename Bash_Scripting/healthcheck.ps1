#!/bin/bash

# Set thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=20

# Get current timestamp
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Get CPU usage (average over 1 second)
cpu_usage=$(top -bn2 | grep "Cpu(s)" | tail -n1 | awk '{print 100 - $8}')
cpu_usage=${cpu_usage%.*}  # Remove decimal

# Get memory usage
read total used free <<< $(free -m | awk '/Mem:/ {print $2, $3, $4}')
available_percent=$(( 100 * free / total ))

# Prepare log message
log_message="[$timestamp] CPU Usage: ${cpu_usage}% | Available Memory: ${available_percent}%"

# Check for warnings
if[ "$cpu_usage" -gt "$CPU_THRESHOLD" ] || [ "$available_percent" -lt "$MEMORY_THRESHOLD" ]; then
    log_message+=" | WARNING:"
    if[ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
        log_message+=" High CPU usage."
    fi
    if[ "$available_percent" -lt "$MEMORY_THRESHOLD" ]; then
        log_message+=" Low available memory."
    fi
fi

# Append to log file
echo"$log_message" >> system_health.log

echo"System health check complete. Log updated."
