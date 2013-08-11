#!/bin/bash

##VMware Tools Kali Installation Script
##Author: Jose R. Hernandez
##Version: 0.1


echo "Checking VMware Tools are Mounted..."

#Check to see if VMwaretools is mounted
if [ -f /media/cdrom/*.gz ]
then
    echo "VMware Tools are mounted"
else
    echo "Mount VMware tools and rerun the script"
    exit 1
fi

#Wipe sources.list file
cp /dev/null /etc/apt/sources.list

#Add Correct Repositories
echo "deb http://http.kali.org/kali kali main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://http.kali.org/kali kali main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list

#Update and Upgrade
apt-get update -y
apt-get upgrade -y

#Install Linux Headers
apt-get install gcc make linux-headers-$(uname -r)

#symbolic link
ln -s /usr/src/linux-headers-$(uname -r)/include/generated/uapi/linux/version.h /usr/src/linux-headers-$(uname -r)/include/linux/

#Add services to update-rc
echo "cups enabled" >> /usr/sbin/update-rc.d
echo "vmware-tools enabled" >> /usr/sbin/udpate-rc.d

#install vmmouse
apt-get install xserver-xorg-input-vmmouse

#Move VMware tools to tmp directory
cp /media/cdrom/*.gz /tmp/

#Decompress and Run the install perl script
cd /tmp/
tar -zxpf /tmp/VMwareTools-*.tar.gz
cd vmware-tools-distrib/
./vmware-install.pl