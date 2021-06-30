# Remote healing of unbootable operating systems

Introduction

Introduction
Imagine you are the system administrator of a company, which has offices in different towns. One day you receive a phone call, saying a PC in a remote office won’t boot. You have to travel to this office to check, what is the situation and repair this PC… or maybe you can do it with remote administration? This might sound impossible, but can be done, if you have network connection to the PC which needs to be repaired and some preparations have made in advance. These preparations include installing a secondary operating system to another disk partition of the PC, creating a dual-boot system. Additionally, the secondary system must allow remote administration. In this example I will install Tiny Core Linux as secondary operating system, and setup openssh to allow remote access. I have chosen Tiny Core Linux because it requires exceptionally small disk space, the installation I use in this example fits on a 50MB partition. The primary operating system will be Windows 10 as it is the most widespread desktop operating system, but other Windows versions and non-Microsoft operating systems can be remote healed the same way. Unfortunately most hardware errors cannot be remote repaired, this demonstration focuses on software errors like Windows update malfunction, virus attack or user error.

Preparations
If the primary operating system is already set up and it occupies the total disk space, its partition needs to be shrinked by at least 50MB to have enough space for the Linux installation. You may shrink more if you would like to store copies of the system image files on the local disk. This depends on the available free disk space as well. 

Inline-style: 
![Shrink partition](https://user-images.githubusercontent.com/73483641/124018685-641a0900-d9e8-11eb-9a71-d948e97ef8f0.png)

 After the resize is complete, create 2 new partitions on the empty place. I create a 24950 MB partition for storing the backup images and a 50MB partition for the Linux installation.
I assume that all user data is stored on file servers and not locally, as this is the preferred setup in corporate environments. An operating system restore will not affect user data this way.
Download following release:
http://tinycorelinux.net/12.x/x86/release/TinyCore-current.iso
I demonstrate the possibility of the remote healing on a dual-boot virtual machine run by Virtualbox.  The virtual machine can boot this iso file directly, on physical hardware you need to write the iso in bootable format on CD or USB drive. For USB drives Rufus, Unetbootin or similar software can be used.  After the iso file has booted on the machine, the remaining steps are the same both for virtual machines and physical hardware.
02 
Right click on the desktop and select system tools, apps, click apps, Cloud (Remote) Browse. In the top search bar enter curl, select curl in the list and click go. This will download and install curl.
Right click on the desktop and select applications, then terminal. Enter following command
 curl –L tinyurl.com/98myfbmv | sh
this will download and execute the install.sh script.
This script formats the sda3 and sda5 partitions, copies the files needed to run  TinyCore Linux from the hard disk os ssd, installs the grub boot manager, sets up the boot menu, installs ssh for remote access and ntfsprogs which is used to create images of the windows partitions and can it can also restore the images to disk, if needed.
The install.sh script also creates images of the windows partitions sda1 and sda2 to the directory /mnt/sda3/images
Finally, install.sh downloads the restorewin.sh script, which can be run to restore the windows images to disk. After the script finishes, I click on Set the button in the App browser and select /mnt/sda5 in the list to set the default location of the Linux system. I change the password of the default user tc, as later this password will be needed to access the Linux system.
I unmount and disconnect the original installation source (the iso file, CD or usb media)
Select the power button on the desktop, select reboot with backup.
After reboot you see the grub boot menu, where you can select Windows or Linux.
The automatic login feature of the Linux system is disabled in order to prevent users from messing around with the system.
The preparations are now complete.
Now simulate a problem preventing Windows to boot. I boot the Linux system to achieve this and format sda1 and sda2. After rebooting and selecting Windows in the boot menu, Windows won’t boot, as expected.
To start the remote healing, the machine needs to be restarted and somebody needs select Linux in the boot menu (This is the only assistance you have to ask from the remote site)
I connect via ssh using Putty (you may use any other ssh client)
 I enter the password for the user tc. After the login I run the command 
./restorewin.sh
  to restore the previous contents of the windows partitions. This script was downloaded and copied to the home directory of the tc user during installation. The content of this script can be found [here] (https://github.com/fbarnabas/remote_healing/blob/main/restorewin.sh)
After the image has been restored, Windows boots as new.
