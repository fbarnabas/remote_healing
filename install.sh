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
tce-load -wi grub2-multi.tcz
sudo grub-install --boot-directory=/mnt/sda5/boot /dev/sda
cat >> /mnt/sda1/boot/grub/grub.cfg <<EOF
menuentry "Windows 10" {
	insmod chain
	insmod ntfs
	set root=(hd0,1)
	chainloader +1
}
menuentry "Tiny Core Linux" {
set root="(hd0,msdos5)"
linux /tce/boot/vmlinuz
initrd /tce/boot/core.gz
}
EOF
wget https://raw.githubusercontent.com/fbarnabas/remote_healing/main/install2.sh --no-check-certificate
chmod +x ./install1.sh
./install2.sh



