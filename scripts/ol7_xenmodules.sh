#!/usr/bin/env bash


##XEN packages
echo -n "Installing XEN Packages"

yum install bridge-utils -y
yum install http://public-yum.oracle.com/repo/OracleLinux/OL7/optional/latest/x86_64/getPackage/yum-plugin-fastestmirror-1.1.31-34.0.1.el7.noarch.rpm -y
yum install http://au1.mirror.crc.id.au/repo/el7/x86_64/kernel-xen-release-10.noarch.rpm -y
yum install xen46 –skip-broken -y
yum install kernel-xen -y

echo -n "Finished installing XEN"