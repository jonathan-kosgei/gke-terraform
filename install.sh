#!/bin/bash
sudo apt-get update
sudo apt-get install glusterfs-server
sudo mkdir -p /mnt/gfs
sudo mount -o discard,defaults /dev/disk/by-id/google-gluster-pd /mnt/gfs
sudo chmod a+w /mnt/gfs
echo UUID=`sudo blkid -s UUID -o value /dev/disk/by-id/google-gluster-pd` /mnt/gfs ext4 discard,defaults,[NOFAIL] 0 2 | sudo tee -a /etc/fstab