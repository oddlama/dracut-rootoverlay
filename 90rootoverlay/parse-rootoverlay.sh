#!/bin/sh

command -v getarg >/dev/null || . /lib/dracut-lib.sh

[ -z "$rootoverlay" ] && rootoverlay=$(getarg rd.rootoverlay=)
