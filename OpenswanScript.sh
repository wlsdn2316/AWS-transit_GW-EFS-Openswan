#!/bin/bash
echo -e "============================================================"
echo -e "                [Openswan Shell script]"
echo -e "============================================================"

echo -e " IDCEC2의 Public IP를 입력하세요 ex: 54.180.131.177 "
read IDC_PublicIP

echo -e " VPN 터널의 외부 IP 주소를 입력하세요 ex: 13.124.239.36 "
read VPN_TunnerIP

echo -e " IDCVPC의 IP 대역을 입력하세요 ex: 50.54.0.0/16 "
read IDC_CIDR

echo -e " AWSVPC의 IP 대역을 입력하세요 ex: 50.50.0.0/16 "
read AWSVPC_CIDR

echo -e " VPN 암호화 키를 입력하세요 "
read VPN_PSK

echo "conn Tunnel1" > /etc/ipsec.d/aws.conf
echo "       authby=secret" >> /etc/ipsec.d/aws.conf
echo "       auto=start" >> /etc/ipsec.d/aws.conf
echo "       left=%defaultroute" >> /etc/ipsec.d/aws.conf
echo "       leftid="$IDC_PublicIP"" >> /etc/ipsec.d/aws.conf
echo "       right="$VPN_TunnerIP"" >> /etc/ipsec.d/aws.conf
echo "       type=tunnel" >> /etc/ipsec.d/aws.conf
echo "       ikelifetime=8h" >> /etc/ipsec.d/aws.conf
echo "       keylife=1h" >> /etc/ipsec.d/aws.conf
echo "       phase2alg=aes128-sha1;modp1024" >> /etc/ipsec.d/aws.conf
echo "       ike=aes128-sha1;modp1024" >> /etc/ipsec.d/aws.conf
echo "       keyingtries=%forever" >> /etc/ipsec.d/aws.conf
echo "       keyexchange=ike" >> /etc/ipsec.d/aws.conf
echo "       leftsubnet="$IDC_CIDR"" >> /etc/ipsec.d/aws.conf
echo "       rightsubnet="$AWSVPC_CIDR"" >> /etc/ipsec.d/aws.conf
echo "       dpddelay=10" >> /etc/ipsec.d/aws.conf
echo "       dpdtimeout=30" >> /etc/ipsec.d/aws.conf
echo "       dpdaction=restart_by_peer" >> /etc/ipsec.d/aws.conf
echo "$VPN_PSK" > /etc/ipsec.d/aws.secrets

echo `systemctl restart ipsec.service`

