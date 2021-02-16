#!/bin/bash
echo -e "============================================================"
echo -e "                [Efs Shell script]"
echo -e "============================================================"

echo -e " Efs파일시스템의 DNS를 입력해주세요 ex: fs-889b6ae8 "
read EFS_DNS

echo `yum install -y amazon-efs-utils`
echo `mkdir /data`
echo `mount -t efs $EFS_DNS:/ /data`
echo "$EFS_DNS:/ /data efs defaults,_netdev 0 0" >> /etc/fstab

if [ ! -d /data/deploy-root ]; then
    echo `cp -r /server/deploy-root /data`
    echo `chown tomcat:tomcat /data/deploy-root`
fi
echo `sed -i 's/\/server\/deploy-root/\/data\/deploy-root/' /server/was/instances/center/conf/server.xml`
