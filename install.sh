#!/bin/sh
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda5
cat >> /etc/fstab <<EOF
/dev/sda5 /mnt/sda5 ext4
/dev/sda3 /mnt/sda3 ext4
EOF
mkdir /mnt/sda5
mount /dev/sda5
mkdir -p /mnt/sda5/boot
cp -p /mnt/sr0/boot/* /mnt/sda5/boot
mkdir -p /mnt/sda5/tce
touch /mnt/sda5/tce/mydata.tgz
su tc
tce-load -wi grub2-multi.tcz
su root
grub-install /dev/sda



