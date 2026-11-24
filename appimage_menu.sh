#!/bin/bash
# appimage_menu.sh - add every AppImage in a folder to the Puppy menu.
#
# For each AppImage, extracts its .desktop file and icon, points them at the
# AppImage, installs them to /usr/share/applications and /usr/share/pixmaps,
# then refreshes the menu (labwc, or fixmenus on JWM).
#
# Usage: ./appimage_menu.sh [folder]     (default: ~/Applications)
# Re-run after adding new AppImages. To remove an entry, delete
# /usr/share/applications/appimage-<name>.desktop and re-run.

DIR="${1:-$HOME/Applications}"
DIR="$(cd "$DIR" && pwd)" || { echo "folder not found: $1"; exit 1; }
APPS=/usr/share/applications
ICONS=/usr/share/pixmaps
TMP=/tmp/aiextract

for app in "$DIR"/*.AppImage; do
    [ -e "$app" ] || { echo "no AppImages in $DIR"; exit 1; }
    case "$(basename "$app")" in appimageupdatetool*|AppImageUpdate*) continue ;; esac
    name=$(basename "$app" .AppImage)

    rm -rf "$TMP"; mkdir -p "$TMP"; cd "$TMP" || exit 1
    "$app" --appimage-extract >/dev/null 2>&1 || { echo "skip $name (extract failed)"; continue; }

    desk=$(ls squashfs-root/*.desktop 2>/dev/null | head -n1)
    [ -z "$desk" ] && { echo "skip $name (no .desktop)"; continue; }

    cp -L squashfs-root/.DirIcon "$ICONS/$name.png" 2>/dev/null
    sed -e "s|^Exec=[^ ]*|Exec=\"$app\"|" \
        -e "s|^Icon=.*|Icon=$ICONS/$name.png|" \
        -e "/^TryExec=/d" "$desk" > "$APPS/appimage-$name.desktop"
    echo "added $name"
done

cd / && rm -rf "$TMP"
# Refresh the menu for whichever desktop is running.
command -v update-desktop-database >/dev/null && update-desktop-database "$APPS" 2>/dev/null
if pidof labwc >/dev/null; then
    # labwc panels/launchers read /usr/share/applications directly.
    labwc --reconfigure 2>/dev/null
    echo "menu refreshed (labwc) - log out and back in if entries don't appear"
elif pidof jwm >/dev/null && command -v fixmenus >/dev/null; then
    fixmenus; jwm -restart
else
    echo "entries installed - log out and back in if they don't appear in the menu"
fi
