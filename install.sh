#!/bin/sh
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda5
cat >> /etc/fstab <<EOF
/dev/sda5 /mnt/sda5 ext4
/dev/sda3 /mnt/sda3 ext4
EOF
mkdir /mnt/sda5
sudo mount -t ext4 /dev/sda5 /mnt/sda5
sudo mkdir -p /mnt/sda5/boot
cp -p /mnt/sr0/boot/* /mnt/sda5/boot
sudo mkdir -p /mnt/sda5/tce
touch /mnt/sda5/tce/mydata.tgz
tce-load -wi grub2-multi.tcz
sudo grub-install --boot-directory=/mnt/sda5/boot /dev/sda
cat > ./grub.cfg <<EOF
menuentry "Windows 10" {
	insmod chain
	insmod ntfs
	set root=(hd0,1)
	chainloader +1
}
menuentry "Tiny Core Linux" {
set root=(hd0,5)
linux /tce/boot/vmlinuz
initrd /tce/boot/core.gz
}
EOF
sudo mv ./grub.cfg /mnt/sda5/boot/grub/grub.cfg
cat > /opt/.backup_device <<EOF
sda5/tce
EOF
wget https://raw.githubusercontent.com/fbarnabas/remote_healing/main/install2.sh --no-check-certificate
chmod +x ./install2.sh
filetool.sh -b
./install2.sh



