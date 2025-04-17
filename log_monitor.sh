#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

LOG_FILE="$1"

if [ -z "$LOG_FILE" ]; then
    echo -e "${RED}Usage: $0 <nginx_access_log_file>${NC}"
    exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
    echo -e "${RED}Error: File '$LOG_FILE' not found.${NC}"
    exit 1
fi

# Trap Ctrl+C
trap "echo -e '\n${YELLOW}Monitoring stopped.${NC}'; exit 0" SIGINT

# Functions for displaying stats
function top_ips() {
    awk '{print $1}' "$1" | sort | uniq -c | sort -nr | head -5 | awk '{printf "%-20s - %s requests\n", $2, $1}'
}

function top_paths() {
    awk -F\" '{print $2}' "$1" | awk '{print $2}' | sort | uniq -c | sort -nr | head -5 | awk '{printf "%-30s - %s requests\n", $2, $1}'
}

function top_statuses() {
    awk '{print $9}' "$1" | grep -E '^[0-9]{3}$' | sort | uniq -c | sort -nr | head -5 | awk '{printf "%-5s - %s requests\n", $2, $1}'
}

function top_agents() {
    awk -F\" '{print $6}' "$1" | sort | uniq -c | sort -nr | head -5 | awk '{count=$1; $1=""; printf "%-60s - %s requests\n", substr($0,2), count}'
}

function filter_by_status() {
    echo -en "${CYAN}Enter status code to filter (e.g., 404): ${NC}"
    read -r code
    echo -e "\n${GREEN}Requests with status code ${code}:${NC}"
    grep "HTTP/.*\" ${code} " "$LOG_FILE"
}

function filter_by_ip() {
    echo -en "${CYAN}Enter IP to filter: ${NC}"
    read -r ip
    echo -e "\n${GREEN}Requests from IP ${ip}:${NC}"
    grep "^${ip} " "$LOG_FILE"
}

function tail_live() {
    echo -e "${YELLOW}Watching new log entries (tail -F)... Press Ctrl+C to stop.${NC}"
    tail -F "$LOG_FILE"
}

function realtime_monitoring() {
    while true; do
        clear
        echo -e "${YELLOW}Real-time Log Stats (refreshes every 5s)... Press Ctrl+C to stop.${NC}\n"
        top_ips "$LOG_FILE"
        echo ""
        top_paths "$LOG_FILE"
        echo ""
        top_statuses "$LOG_FILE"
        echo ""
        top_agents "$LOG_FILE"
        sleep 5
    done
}

function menu() {
    echo -e "${CYAN}Choose an option:${NC}"
    echo "1) View Top IPs"
    echo "2) View Top Paths"
    echo "3) View Top Status Codes"
    echo "4) View Top User Agents"
    echo "5) Real-time Summary Monitor"
    echo "6) Filter by Status Code"
    echo "7) Filter by IP Address"
    echo "8) Live Tail Log (tail -F)"
    echo "0) Exit"
    echo -n "> "
}

# Main loop
while true; do
    clear
    menu
    read -r choice

    case $choice in
        1) clear; echo -e "${GREEN}Top IPs:${NC}"; top_ips "$LOG_FILE"; read -p $'\nPress Enter to continue...';;
        2) clear; echo -e "${GREEN}Top Paths:${NC}"; top_paths "$LOG_FILE"; read -p $'\nPress Enter to continue...';;
        3) clear; echo -e "${GREEN}Top Status Codes:${NC}"; top_statuses "$LOG_FILE"; read -p $'\nPress Enter to continue...';;
        4) clear; echo -e "${GREEN}Top User Agents:${NC}"; top_agents "$LOG_FILE"; read -p $'\nPress Enter to continue...';;
        5) realtime_monitoring;;
        6) clear; filter_by_status; read -p $'\nPress Enter to continue...';;
        7) clear; filter_by_ip; read -p $'\nPress Enter to continue...';;
        8) clear; tail_live;;
        0) echo -e "${GREEN}Goodbye!${NC}"; exit 0;;
        *) echo -e "${RED}Invalid option!${NC}"; sleep 1;;
    esac
done
