**ATTENTION: This is a work in progress and NOT read for use! It's currently unclear whether dracut even supports this mode of operation. See [this discussion](https://github.com/dracutdevs/dracut/discussions/1787) for more info.**

# dracut-rootoverlay

A simple dracut module that allows mounting a writable overlay over the (possibly read-only) root filesystem.
Specifying `rootoverlay=<device-spec>` will cause the specified disk to be mounted as an overlay over
whatever file system would be the root fs.

Be aware that the chosen overlay device must already contain a trivially mountable file-system with a
`work` and `upper` folder for the overlayfs.

Requires systemd. Inspired from existing dracut modules 90dmsquash-live and 99-squash.
