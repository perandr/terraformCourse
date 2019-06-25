#!/bin/bash

echo "Hello from template bash"
vgchange -ay
DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`

if [ "`echo -n $DEVICE_FS`" == "" ] ; then
    pvcreate ${DEVICE}
    vgcreate data ${DEVICE}
    lvcreate --name ebs_volume -l 100%FREE data 
    mkfs.ext4 /dev/data/ebs_volume
fi
echo $DEVICE_FS
mkdir -p /data
echo '/dev/data/ebs_volume /data ext4 defaults 0 0' >> /etc/fstab 
mount /data

echo "Hello in file" >> /data/runs.txt
