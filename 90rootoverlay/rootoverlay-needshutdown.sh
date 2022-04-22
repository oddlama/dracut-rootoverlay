#!/bin/sh

command -v getarg >/dev/null || . /lib/dracut-lib.sh

[ -n "$rootoverlay" ] && need_shutdown
