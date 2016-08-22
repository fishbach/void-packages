#!/bin/bash

# called by dracut
check() {
    return 0
}

# called by dracut
depends() {
    echo rootfs-block
}

# called by dracut
install() {
    inst_hook pre-pivot 00 "$moddir/mount-overlayroot.sh"
}
