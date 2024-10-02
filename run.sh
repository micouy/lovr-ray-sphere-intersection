for file in *.lua *.glsl *.obj; do
    if [ -f "$file" ]; then
        echo "Pushing $file..."
        adb push --sync "$file" /sdcard/Android/data/org.lovr.app/files/
    fi
done

adb shell am force-stop org.lovr.app
adb shell am start org.lovr.app/org.lovr.app.Activity