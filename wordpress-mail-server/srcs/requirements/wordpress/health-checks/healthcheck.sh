#!/bin/sh

if [ -f /tmp/done ]; then
    # If the file exists, exit with status 0 (healthy)
    exit 0
else
    # If the file does not exist, exit with status 1 (unhealthy)
    exit 1
fi

