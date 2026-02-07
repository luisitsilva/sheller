#!/bin/bash

echo "=============================="
echo "      System Information"
echo "=============================="

# Hostname
HOSTNAME=$(hostname)
echo "Hostname: $HOSTNAME"

# Internet connection check
if ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1; then
    echo "Internet Connection: Yes"
else
    echo "Internet Connection: No"
fi

# Firewall status (supports ufw and firewalld)
FIREWALL_STATUS="Unknown"

if command -v ufw >/dev/null 2>&1; then
    if ufw status | grep -q "Status: active"; then
        FIREWALL_STATUS="On (ufw)"
    else
        FIREWALL_STATUS="Off (ufw)"
    fi
elif command -v firewall-cmd >/dev/null 2>&1; then
    if firewall-cmd --state >/dev/null 2>&1; then
        FIREWALL_STATUS="On (firewalld)"
    else
        FIREWALL_STATUS="Off (firewalld)"
    fi
fi

echo "Firewall On: $FIREWALL_STATUS"

# Logged-in user
LOGGED_USER=$(whoami)
echo "User logged on: $LOGGED_USER"

echo "=============================="
