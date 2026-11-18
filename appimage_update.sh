#!/bin/bash
# appimage_update.sh - check and update every AppImage in a folder.
#
# Uses appimageupdatetool (download the x86_64 build from
# https://github.com/AppImageCommunity/AppImageUpdate/releases and keep it in
# the same folder). Each AppImage is replaced in place (-O), so menu entries
# made by appimage_menu.sh keep working.
#
# Usage: ./appimage_update.sh [folder]     (default: ~/Applications)
# If FUSE isn't available, set AIUT_OPTS=--appimage-extract-and-run

DIR="${1:-$HOME/Applications}"
DIR="$(cd "$DIR" && pwd)" || { echo "folder not found: $1"; exit 1; }
TOOL=$(ls "$DIR"/appimageupdatetool*.AppImage 2>/dev/null | head -n1)
[ -z "$TOOL" ] && { echo "appimageupdatetool*.AppImage not found in $DIR"; exit 1; }
chmod +x "$TOOL"

for app in "$DIR"/*.AppImage; do
    [ "$app" = "$TOOL" ] && continue
    case "$(basename "$app")" in AppImageUpdate*) continue ;; esac
    echo "== $(basename "$app")"
    "$TOOL" $AIUT_OPTS -j "$app" >/dev/null 2>&1
    case $? in
        0) echo "   up to date" ;;
        1) "$TOOL" $AIUT_OPTS -O "$app" && echo "   updated" || echo "   update failed" ;;
        *) echo "   no update info / error" ;;
    esac
done

echo "== appimageupdatetool (self-update)"
"$TOOL" $AIUT_OPTS --self-update >/dev/null 2>&1 && echo "   done" || echo "   skipped"
