#!/usr/bin/env fish

set SERVICE "thinkpad.sh"
set PORT 5010

while true
    clear
    echo "=== Monitor $SERVICE ==="

    # Cek proses
    if pgrep -f $SERVICE > /dev/null
        echo "✅ $SERVICE sedang berjalan."
    else
        echo "❌ $SERVICE tidak berjalan. Menjalankan ulang..."
        nohup ./thinkpad.sh > /dev/null 2>&1 &
    end

    # Cek port
    if ss -tuln | grep -q ":$PORT"
        echo "✅ Port $PORT aktif."
    else
        echo "❌ Port $PORT tidak aktif."
    end

    sleep 2
end
