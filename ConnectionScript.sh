#!/bin/bash
echo -e "============================================================"
echo -e "                [Connection Shell script]"
echo -e "============================================================"
echo `mysql -ujinwoo -pjt201wdb -h jjwmasterdb.chabsh0zrlyl.ap-northeast-2.rds.amazonaws.com < /home/ec2-user/alldatabases_2021-01-13.sql`
echo `su - tomcat -c /server/was/launcher/startup_center.sh`




