#!/bin/sh
ntfsclone --restore-image --overwrite /dev/sda1 /mnt/sda3/images/win10-sda1.img
ntfsclone --restore-image --overwrite /dev/sda2 /mnt/sda3/images/win10-sda2.img
