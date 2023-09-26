#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):55574528:0eed4e05ca6999ae96543c46edb660c440b75f82; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):46137344:fcb3e768d2c2707737a3e100640ee677d3c78b5d \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):55574528:0eed4e05ca6999ae96543c46edb660c440b75f82 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

