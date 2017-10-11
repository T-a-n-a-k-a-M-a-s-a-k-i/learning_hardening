#####rootログイン不可#####
echo > /etc/securetty

#####tcp_syncookies有効化#####
sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
echo "net.ipv4.tcp_syncookies=1" >> /etc/sysctl.conf

#####Smurf対策#####
sed -i '/net.ipv4.icmp_echo_ignore_broadcasts/d' /etc/sysctl.conf
echo "net.ipv4.icmp_echo_ignore_broadcasts=1" >> /etc/sysctl.conf

####ICMP Redirect拒否#####
sed -i '/net.ipv4.conf.*.accept_redirects/d' /etc/sysctl.conf
for dev in `ls /proc/sys/net/ipv4/conf/`
do
  echo "net.ipv4.conf.$dev.accept_redirects=0" >> /etc/sysctl.conf
done

####Source Routedパケット拒否#####
sed -i '/net.ipv4.conf.*.accept_source_route/d' /etc/sysctl.conf
for dev in `ls /proc/sys/net/ipv4/conf/`
do
  echo "net.ipv4.conf.$dev.accept_source_route=0" >> /etc/sysctl.conf
done

#####カーネルパラメータ更新#####
sysctl -p

#####gpgcheck有効化#####
sed -i '/gpgcheck/d' /etc/yum.conf
echo "gpgcheck=1" >> /etc/yum.conf

#####不要なサービスの停止#####
service avahi-daemon stop
service cups stop
service nfslock stop
service rpcgssd stop
service rpcidmapd stop
