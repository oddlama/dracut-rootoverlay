#!/bin/sh

command -v getarg >/dev/null || . /lib/dracut-lib.sh

GENERATOR_DIR="$1"
[ -n "$GENERATOR_DIR" ] || {
    echo "rootoverlay-generator: no generator directory specified, exiting" >> /dev/kmsg
    exit 1
}

[ -z "$rootoverlay" ] && rootoverlay=$(getarg rd.rootoverlay=)

case "${rootoverlay#block:}" in
    LABEL=* | UUID=* | PARTUUID=* | PARTLABEL=*)
        rootoverlay="block:$(label_uuid_to_dev "$rootoverlay")"
        ;;
    /dev/*)
        rootoverlay="block:${rootoverlay}"
        ;;
esac

{
	echo "[Unit]"
	echo "Before=initrd-root-fs.target"
	echo "After=sysroot.mount"
	echo "RequiresMountsFor=/run"
	echo "[Mount]"
	echo "Where=/run/rootoverlay"
	echo "What=${rootoverlay}"
	echo "Options=defaults"
} > "$GENERATOR_DIR"/run-rootoverlay.mount
{
	echo "[Unit]"
	echo "Before=initrd-root-fs.target"
	echo "After=sysroot.mount"
	echo "RequiresMountsFor=/run/rootoverlay /sysroot"
	echo "[Mount]"
	echo "Type=overlay"
	echo "What=overlay"
	echo "Where=/sysroot-rootoverlay"
	echo "Options=lowerdir=/sysroot,upperdir=/run/rootoverlay/upper,workdir=/run/rootoverlay/work"
} > "$GENERATOR_DIR"/sysroot-rootoverlay.mount

mkdir -p "$GENERATOR_DIR"/initrd-root-fs.target.requires
ln -fs ../sysroot-rootoverlay.mount "$GENERATOR_DIR"/initrd-root-fs.target.requires/sysroot-rootoverlay.mount
