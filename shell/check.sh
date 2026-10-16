#!/bin/bash

echo ""
echo ""

echo "############"
echo "Server Check"
echo "############"
echo ""

uptime
echo ""
echo ""

vmstat 1 10
echo ""
echo ""

nproc
echo ""
echo ""

free -h
echo ""
echo ""

ps -eo pid,ppid,user,stat,pcpu,pmem,etime,comm --sort=-pcpu | head -25
echo ""
echo ""

pid=$(ps -eo pid,comm,stat | awk '$2=="apache2" && $3 ~ /^R/ {print $1; exit}')
if [ -n "$pid" ]; then
  echo "Tracing Apache PID $pid"
  timeout -s INT 5 strace -f -s 180 -e trace=execve -p "$pid" 2>&1 | head -60
else
  echo "No runnable Apache worker found; run again."
fi
echo ""
echo ""


nginx -t
echo ""
echo ""

./traffic.sh
echo ""
echo ""
