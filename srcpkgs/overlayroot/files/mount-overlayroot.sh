#!/bin/sh

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

mount_overlayroot() {
  echo -n "mounting overlay root ..."

  mkdir /overlay_ro
  mount --move "$NEWROOT" /overlay_ro

  mkdir /overlay_rw
  mount -t tmpfs tmpfs /overlay_rw
  mkdir /overlay_rw/root
  mkdir /overlay_rw/work

  mount -t overlay overlay -olowerdir=/overlay_ro,upperdir=/overlay_rw/root,workdir=/overlay_rw/work "$NEWROOT"

  mkdir "$NEWROOT"/.ro
  mkdir "$NEWROOT"/.rw
  mount --move /overlay_ro "$NEWROOT"/.ro
  mount --move /overlay_rw "$NEWROOT"/.rw

  echo " done"
}

if [ -f "$NEWROOT"/etc/overlayroot_active ] ; then
    mount_overlayroot
else
    echo "overlay root: off"
fi
