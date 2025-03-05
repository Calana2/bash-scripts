#!/bin/bash
# Ephemeral process capture (up to 0.1s)

if [[ $1 == "-h" || $1 == "--help" ]];then
  echo -e "Usage:\n\nprogram [interval] [patternMatch]\n\n   The interval is by default in seconds but suffixes of the 'sleep' command could be used\n\n"
  echo "Data showed: Effective-User-Id  Process-Id  Status  Command"
  exit 0
fi

old=$(ps -eo euid,pid,stat,comm)
interval="${1:-1}"
pattern="${2:-}"
echo ""

while true;do
  new=$(ps -eo euid,pid,stat,comm)
  diff <(echo "$old") <(echo "$new") | grep [\<\>] | grep -Ei "$pattern"
  sleep "$interval"
  old=$new
done
