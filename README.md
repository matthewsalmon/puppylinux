# puppylinux

a collection of scripts created with puppy linux

## appimage_menu.sh

Adds every AppImage in a folder to the Puppy menu, using each app's own
`.desktop` file and icon. Works with labwc (Wayland) and JWM Puppies; on JWM it
runs `fixmenus`.

```
./appimage_menu.sh ~/Applications
```

Run as root (the Puppy default). Re-run after adding new AppImages.

## appimage_update.sh

Checks every AppImage in a folder for updates and replaces each one in place,
so menu entries keep working. Needs `appimageupdatetool-x86_64.AppImage`
(from [AppImageUpdate releases](https://github.com/AppImageCommunity/AppImageUpdate/releases))
in the same folder.

```
./appimage_update.sh ~/Applications
```

AppImages without built-in update information are reported and skipped. If
FUSE isn't loaded, run `AIUT_OPTS=--appimage-extract-and-run ./appimage_update.sh`.