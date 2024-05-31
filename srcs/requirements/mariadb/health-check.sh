#!/bin/sh
# check-health.sh
# Script to check if a specific file exists

if [ -f /tmp/healthy ]; then
  exit 0  # Exit with 0 if file exists, indicating 'healthy'
else
  exit 1  # Exit with non-zero if file does not exist, indicating 'unhealthy'
fi

