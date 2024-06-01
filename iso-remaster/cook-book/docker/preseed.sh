#!/bin/sh

set -ex

#create tmp dir
ISO_FILES="$(mktemp -d)"
CURDIR="$(dirname $0)"

#extract files
xorriso -osirrox on -indev /tmp/$NAME_OF_ISO -extract / $ISO_FILES

chmod +w -R $ISO_FILES/install.amd/
gunzip $ISO_FILES/install.amd/initrd.gz

# contains all of the files that we want on the remote system
tar -c -z -f /tmp/cook-book/$RECIPE/postinstall.tar.gz -C /tmp/cook-book/$RECIPE postinstall.d

(cd /tmp/cook-book/$RECIPE; echo preseed.cfg | cpio -H newc -o -A -F $ISO_FILES/install.amd/initrd)
(cd /tmp/cook-book/$RECIPE; echo postinstall.tar.gz | cpio -H newc -o -A -F $ISO_FILES/install.amd/initrd)
(cd /tmp/cook-book/$RECIPE; echo postinstall | cpio -H newc -o -A -F $ISO_FILES/install.amd/initrd)

#change the grub file to start the instalation by it self
rm -f $ISO_FILES/isolinux/isolinux.cfg
cp /tmp/cook-book/isolinux.cfg $ISO_FILES/isolinux/isolinux.cfg
chmod -w $ISO_FILES/isolinux/isolinux.cfg

gzip $ISO_FILES/install.amd/initrd
chmod -w -R $ISO_FILES/install.amd/

chmod +w $ISO_FILES/md5sum.txt
(cd $ISO_FILES; md5sum `find -follow -type f` > md5sum.txt)
chmod -w $ISO_FILES/md5sum.txt

xorriso -as mkisofs -o  /tmp/$OUTPUT_ISO_NAME -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin -c isolinux/boot.cat -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot -isohybrid-gpt-basdat $ISO_FILES

mv /tmp/$OUTPUT_ISO_NAME /result/$OUTPUT_ISO_NAME

#/bin/bash
