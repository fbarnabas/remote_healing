# Remote healing of unbootable operating systems

Introduction

Imagine you are the system administrator of a company, which has offices in different towns. One day you receive a phone call, saying a PC in a remote office won’t boot. You have to travel to this office to check, what is the situation and repair this PC… or maybe you can do it with remote administration? This might sound impossible, but can be done, if you have network connection to the PC which needs to be repaired and some preparations have made in advance. These preparations include installing a secondary operating system to another disk partition of the PC, creating a dual-boot system. Additionally, the secondary system must allow remote administration. In this example I will install Tiny Core Linux as secondary operating system, and setup openssh to allow remote access. I have chosen Tiny Core Linux because it requires exceptionally small disk space, the installation I use in this example fits on a 50MB partition. The primary operating system will be Windows 10 as it is the most widespread desktop operating system, but other Windows versions and non-Microsoft operating systems can be remote healed the same way. Unfortunately most hardware errors cannot be remote repaired, this demonstration focuses on software errors like Windows update malfunction, virus attack or user error.

Preparations

If the primary operating system is already set up and it is occupies the total hard disk, its partition needs to be shrinked by at least 50MB to have enough space for the Linux installation. You may shrink more if you would like to store copies of the system image files on the local disk. This depends on the available free disk space as well. 
01
 I assume, that all user data is stored on file servers and not locally, as this is the preferred setup in corporate environments. An operating system restore will not affect user data this way.
I download following release:
http://tinycorelinux.net/12.x/x86/release/TinyCore-current.iso
With Rufus I prepare a bootable USB using this release and I boot the PC from this USB stick. After boot the Tiny Core desktop appears.
02 
Right click on the desktop and select system tools, apps, select mirror, click apps, Cloud (Remote) Browse. In the top search bar enter openssl, select openssl
Right click on the desktop and select applications, then terminal.
