# 🔍 Real-Time Interactive NGINX Log Analyzer (Shell Script)

This is a powerful and user-friendly **Bash-based NGINX access log analyzer**. It provides both **interactive menu-driven exploration** and **real-time monitoring** using `tail -F`, allowing you to dig into logs and monitor traffic as it happens.

---

## 📦 Features

- 📊 Top **IP addresses**, **request paths**, **status codes**, and **user agents**
- 🧭 **Interactive menu** for easy navigation
- ⏱️ **Real-time stats dashboard** with auto-refresh
- 🕵️ **Filter logs** by IP address or HTTP status code
- 📡 **Live log tailing** with `tail -F` support
- 🌈 Color-coded, well-formatted CLI output
- 🧼 Graceful error handling and exit

---

## 📁 Requirements

- Unix-like OS (Linux/macOS)
- Bash
- Standard tools: `awk`, `grep`, `sort`, `uniq`, `head`, `tail`

---

## 🚀 Installation & Usage

1. **Clone or download the script:**

   ```bash
   git clone https://github.com/peymansohi/nginx-log-analyzer.git
   cd nginx-log-analyzer
   ```

2. **Make the script executable:**

   ```bash
   chmod +x log_monitor.sh
   ```

3. **Run the script with your log file:**

   ```bash
   ./log_monitor.sh /path/to/access.log
   ```

---

## 🧭 Menu Options

| Option | Description                              |
|--------|------------------------------------------|
| 1      | View Top 5 IPs                            |
| 2      | View Top 5 Requested Paths                |
| 3      | View Top 5 Status Codes                  |
| 4      | View Top 5 User Agents                   |
| 5      | Real-time auto-refreshing log summary    |
| 6      | Filter log by HTTP status code           |
| 7      | Filter log by IP address                 |
| 8      | Tail the log live (`tail -F`)            |
| 0      | Exit the script                          |

---

## 📸 Preview

```bash
Choose an option:
1) View Top IPs
2) View Top Paths
3) View Top Status Codes
4) View Top User Agents
5) Real-time Summary Monitor
6) Filter by Status Code
7) Filter by IP Address
8) Live Tail Log (tail -F)
0) Exit
> 
```

---

## 🧪 Example Log Format (NGINX)

```
123.45.67.89 - - [12/Apr/2025:06:25:10 +0000] "GET /api/v1/products HTTP/1.1" 200 532 "-" "Mozilla/5.0 (X11; Linux x86_64)"
```

Ensure your log file is in this standard NGINX access log format.

---

## 📥 Sample Log File

You can download a sample NGINX access log for testing from:

https://gist.githubusercontent.com/kamranahmedse/e66c3b9ea89a1a030d3b739eeeef22d0/raw/77fb3ac837a73c4f0206e78a236d885590b7ae35/nginx-access.log
---

## 🧩 Future Enhancements (Ideas)

- Export reports as CSV/JSON
- Highlight suspicious IPs (rate limit or abuse detection)
- Generate HTML dashboard
- Dockerize for cross-platform use
- Support Apache logs

---
https://roadmap.sh/projects/nginx-log-analyser
