#!/bin/bash

# =========================
# Linux Admin Menu Script
# =========================

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo "❌ This script must be run as root."
  exit 1
fi

show_menu() {
  clear
  echo "=============================="
  echo "      Linux Admin Menu"
  echo "=============================="
  echo "1) Add user"
  echo "2) Change password"
  echo "3) Edit network configuration"
  echo "4) Create a TCP listener"
  echo "5) Exit"
  echo "=============================="
  echo -n "Choose an option: "
}

add_user() {
  read -p "Enter new username: " username
  if id "$username" &>/dev/null; then
    echo "⚠️ User already exists."
  else
    useradd -m "$username" && passwd "$username"
    echo "✅ User '$username' created."
  fi
  pause
}

change_password() {
  read -p "Enter username: " username
  if id "$username" &>/dev/null; then
    passwd "$username"
  else
    echo "❌ User does not exist."
  fi
  pause
}

edit_network() {
  echo "Opening network configuration..."
  echo "⚠️ This depends on your distro."
  echo "Common files:"
  echo "  - /etc/network/interfaces (Debian)"
  echo "  - /etc/netplan/*.yaml (Ubuntu)"
  echo
  read -p "Enter file to edit: " netfile

  if [[ -f "$netfile" ]]; then
    ${EDITOR:-nano} "$netfile"
  else
    echo "❌ File not found."
  fi
  pause
}

tcp_listener() {
  read -p "Enter port to listen on: " port
  echo "📡 Listening on TCP port $port (Ctrl+C to stop)"
  nc -lvnp "$port"
}

pause() {
  echo
  read -p "Press Enter to continue..."
}

# =========================
# Main loop
# =========================
while true; do
  show_menu
  read choice

  case $choice in
    1) add_user ;;
    2) change_password ;;
    3) edit_network ;;
    4) tcp_listener ;;
    5) echo "👋 Goodbye!"; exit 0 ;;
    *) echo "❌ Invalid option"; pause ;;
  esac
done
