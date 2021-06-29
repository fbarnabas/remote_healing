#!/bin/sh
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda5
#cat >> /etc/fstab <<EOF
#/dev/sda5 /mnt/sda5 ext4
#/dev/sda3 /mnt/sda3 ext4
#EOF
mkdir /mnt/sda5
sudo mount -t ext4 /dev/sda5 /mnt/sda5
sudo mkdir -p /mnt/sda5/boot
sudo cp -p -r /mnt/sr0/boot/* /mnt/sda5/boot
sudo mkdir -p /mnt/sda5/tce
sudo cp -p -r /mnt/sr0/cde/* /mnt/sda5/tce
sudo touch /mnt/sda5/tce/mydata.tgz
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
linux /boot/vmlinuz
initrd /boot/core.gz
}
default=2
timeout=4
EOF
sudo mv ./grub.cfg /mnt/sda5/boot/grub/grub.cfg
cat > /opt/.backup_device <<EOF
sda5/tce
EOF
#wget https://raw.githubusercontent.com/fbarnabas/remote_healing/main/install2.sh --no-check-certificate
#chmod +x ./install2.sh
chmod 775 -R /mnt/sda5/tce
tce-load -wi openssh.tcz
sudo cp /usr/local/etc/ssh/sshd_config.orig /usr/local/etc/ssh/sshd_config
sudo /usr/local/etc/init.d/openssh start
cat > bootlocal.sh <<EOF
#!/bin/sh
sudo /usr/local/etc/init.d/openssh start
EOF
chmod +x bootlocal.sh
sudo mv bootlocal.sh /opt/bootlocal.sh
cat >> /opt/.fieltool.lst <<EOF
usr/local/etc/ssh/sshd_config
EOF
sudo passwd tc
tce-load -wi ntfsprogs.tcz
mkdir /mnt/sda3
sudo mount -t ext4 /dev/sda3 /mnt/sda3
sudo chown -R tc /mnt/sda3
mkdir -p /mnt/sda3/images
ntfsclone --save-image --output /mnt/sda3/images/win10-sda1.img /dev/sda1

filetool.sh -b


