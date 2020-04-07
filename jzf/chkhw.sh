#!/bin/bash

PRODUCT_NAME=`dmidecode -t 1 | grep "Product Name" | awk -F ': ' '{print $2}'`
SN=`dmidecode -t 1 | grep "Serial Number" | awk '{print $3}'`
MEMSIZE=`dmidecode -t 17 | egrep "GB|MB$" | uniq | awk '{print $2 $3}'`
MEMCOUNT=`dmidecode -t 17 | grep "MB$" | wc -l`
CPUMODE=`cat /proc/cpuinfo  | grep "model name" | uniq | awk -F ': ' '{print $2}'`
CPUCOUNT=`cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l`
RAIDLEVEL=`/opt/MegaRAID/MegaCli/MegaCli64 -LDInfo -Lall -aALL -NoLog|grep "RAID Level" |awk -F ': ' '{print $2}' | awk -F ',' '{print $1}' | awk -F '-' '{print $2}'`
RAIDCARDMODE=`/opt/MegaRAID/MegaCli/MegaCli64 -AdpAllInfo -aALL -NoLog|grep "Product Name" | awk -F "PERC " '{print $2}'`
HDSIZE=`/opt/MegaRAID/MegaCli/MegaCli64 -pdlist -aALL -NoLog | grep "Raw Size" | uniq | awk '{print $3 $4}'`
HDCOUNT=`/opt/MegaRAID/MegaCli/MegaCli64 -pdlist -aALL -NoLog | grep "Slot Number" | wc -l`
OS=`cat /etc/redhat-release`

echo "PRODUCT_NAME:  $PRODUCT_NAME"
echo "SN:            $SN"
echo "CPU:           $CPUMODE * $CPUCOUNT"
echo "MEM:           $MEMSIZE * $MEMCOUNT"
echo "RAIDCARD:      $RAIDCARDMODE"
echo "RAIDLEVEL:     $RAIDLEVEL"
echo "HARDDISK:      $HDSIZE * $HDCOUNT"
echo "OS:            $OS"
