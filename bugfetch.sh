#!/bin/bash
# System information command line script (like Neofetch)

# Software information
hostname=$(hostname)
distro=$(grep "PRETTY_NAME" /etc/os-release | cut -d "=" -f 2 | tr -d '"') 
kernel=$(grep "version" /proc/version | cut -d ' ' -f 3)
shell=$SHELL
session=$DESKTOP_SESSION

# Hardware information
product_name=$(cat /sys/devices/virtual/dmi/id/product_name)
cpu_info=$(grep "model name" /proc/cpuinfo | head -n 1 | cut -d ":" -f 2)
memory_total_kb=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')
memory_total_mb="$(echo "scale=2; $memory_total_kb / 1024" | bc) Mb"
memory_available_kb=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')
memory_used_kb=$((memory_total_kb - memory_available_kb))
memory_used_mb="$(echo "scale=2; $memory_used_kb / 1024" | bc) Mb"
vga=$(lspci -nnk | grep -i vga | grep -oP '(?<=: ).*(?= \[)')
monitor_size=$(xdpyinfo | grep dimensions | cut -d ":" -f 2 | grep -oP "[0-9]+x[0-9]+" | head -n 1)

# Representations
hostname_colorized="\e[1;29mHostname:\e[0m \e[37m$hostname\e[0m"
distro_colorized="\e[1;31mDistro:\e[0m \e[37m$distro\e[0m"
kernel_colorized="\e[1;32mKernel:\e[0m \e[37m$kernel\e[0m"
shell_colorized="\e[1;33mShell:\e[0m \e[37m$shell\e[0m"
session_colorized="\e[1;34mSession:\e[0m \e[37m$session\e[0m"

product_name_colorized="\e[1;35mProduct Name:\e[0m \e[37m$product_name\e[0m"
cpu_info_colorized="\e[1;36mCPU Info:\e[0m \e[37m$cpu_info\e[0m"
memory_mb_colorized="\e[1;32mMemory:\e[0m \e[37m$memory_used_mb / $memory_total_mb\e[0m"
vga_colorized="\e[1;29mVGA:\e[0m \e[37m$vga\e[0m"
monitor_size_colorized="\e[1;31mMonitor Size:\e[0m \e[37m$monitor_size\e[0m"

echo -e "\e[1;32m    ,__                   __"
echo -e "\e[1;32m    '~~****Nm_    _mZ*****~~"
echo -e "\e[1;32m            _8@mm@K_                                    $hostname_colorized"
echo -e "\e[1;32m           W~@\` \'@~W"              
echo -e "\e[1;32m          ][][    ][][                                  $distro_colorized"
echo -e "\e[1;32m    gz    'W'W.  ,W\`W\`  es"
echo -e "\e[1;32m  ,Wf    gZ****MA****Ns    VW.                          $kernel_colorized"                   
echo -e "\e[1;32m gA\`   ,Wf     ][     VW.   'Ms"
echo -e "\e[1;32mWf    ,@\`      ][      '@.    VW                        $shell_colorized"
echo -e "\e[1;32mM.    W\`  _mm_ ][ _mm_  'W    ,A"
echo -e "\e[1;32m'W   ][  i@@@@i][i@@@@i  ][   W\`                        $session_colorized"
echo -e "\e[1;32m !b  @   !@@@@!][!@@@@!   @  d!"
echo -e "\e[1;32m  VWmP    ~**~ ][ ~**~    YmWf                          $product_name_colorized"
echo -e "\e[1;32m    ][         ][         ]["
echo -e "\e[1;32m  ,mW[         ][         ]Wm.                          $cpu_info_colorized"
echo -e "\e[1;32m ,A\` @  ,gms.  ][  ,gms.  @ \'M."
echo -e "\e[1;32m W\`  Yi W@@@W  ][  W@@@W iP  'W                         $memory_mb_colorized"
echo -e "\e[1;32md!   'W M@@@A  ][  M@@@A W\`   !b"
echo -e "\e[1;32m@.    !b'V*f\`  ][  'V*f\`d!    ,@                        $vga_colorized"
echo -e "\e[1;32m'Ms    VW.     ][     ,Wf    gA\`"
echo -e "\e[1;32m  VW.   'Ms.   ][   ,gA\`   ,Wf                          $monitor_size_colorized"                  
echo -e "\e[1;32m   'Ms    'V*mmWWmm*f\`    gA\`" 
echo -e "\e[1;0m" 
