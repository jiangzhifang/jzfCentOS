#!/bin/bash
#
# File name: PostInstall.sh
#

rpm -ivh /root/jzfCentOS/jzf/*.rpm

cat /root/jzfCentOS/jzf/20-nproc.conf > /etc/security/limits.d/20-nproc.conf
cat /root/jzfCentOS/jzf/sysctl.conf > /etc/sysctl.conf

chmod +x /etc/rc.d/rc.local

HD_TYPE=$(/opt/MegaRAID/MegaCli/MegaCli64 -PdList -aAll -NoLog | grep "^Media Type" | head -n 1 | awk -F ': ' '{print $2}')

if [ "$HD_TYPE" == "Hard Disk Device" ]; then
    echo 'echo "deadline" > /sys/block/sda/queue/scheduler' >> /etc/rc.d/rc.local
elif [ "$HD_TYPE" == "Solid State Device" ]; then
    echo 'echo "noop" > /sys/block/sda/queue/scheduler' >> /etc/rc.d/rc.local
else
    echo "set io scheduler ERROR" > /tmp/set_io_scheduler.log
fi

echo 'echo 2048 > /sys/block/sda/queue/nr_requests' >> /etc/rc.d/rc.local

rm -rf /etc/yum.repos.d/cobbler*
