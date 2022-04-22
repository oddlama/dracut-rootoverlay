#!/usr/bin/env bash

check() {
	# Always include this module in the initramf
	return 255
}

depends() {
	# This module depends on systemd
    echo systemd
	return 0
}

install() {
	inst_hook cmdline 50 "${moddir}/parse-rootoverlay.sh"
	inst_hook cleanup 50 "${moddir}/rootoverlay-needshutdown.sh"
	inst_script "${moddir}/rootoverlay-generator.sh" "${systemdutildir}/system-generators/dracut-rootoverlay-generator"
}

installkernel() {
	# Requires overlay kernel module
	hostonly='' instmods overlay
}
