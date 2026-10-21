#!/system/bin/sh
MODDIR=${0%/*}

# Wait for boot completion
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
done

# Permissive mode (required for container namespaces and binderfs)
setenforce 0

# Set up required runtime directories
mkdir -p /data/lindroid
chmod 0755 /data/lindroid

# Start perspectived if present and not already running
if [ -f "$MODDIR/system_ext/bin/perspectived" ] && ! pidof perspectived >/dev/null; then
    chmod +x "$MODDIR/system_ext/bin/perspectived"
    $MODDIR/system_ext/bin/perspectived &
elif [ -f "$MODDIR/system/bin/perspectived" ] && ! pidof perspectived >/dev/null; then
    chmod +x "$MODDIR/system/bin/perspectived"
    $MODDIR/system/bin/perspectived &
fi
