#!/bin/sh
# https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script
# to create the partitions programatically (rather than manually)
# we're going to simulate the manual input to fdisk
# The sed script strips off all the comments so that we can 
# document what we're doing in-line with the actual commands
# Note that a blank line (commented as "defualt" will send a empty
# line terminated with a newline to take the fdisk default.
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
  n # new partition
  p # primary partition
  3 # partition number 3
  53653504 # start at sector 53653504 
  104759944 # end at sector 104759944
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF
