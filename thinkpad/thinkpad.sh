#!/usr/bin/env fish

set PORT 5010

while true
    begin
        echo -e "HTTP/1.1 200 OK\r"
        echo -e "Content-Type: text/plain; version=0.0.4\r"
        echo -e "Connection: close\r"
        echo -e "\r"

        echo "# HELP system_uptime_seconds Uptime of the system in seconds"
        echo "# TYPE system_uptime_seconds gauge"
        awk '{printf "%d\n", $1}' /proc/uptime | read uptime
        echo "system_uptime_seconds $uptime"

        echo "# HELP system_cpu_usage_percent CPU usage in percent"
        echo "# TYPE system_cpu_usage_percent gauge"
        set cpu_usage (top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
        echo "system_cpu_usage_percent $cpu_usage"

        echo "# HELP system_memory_usage_percent Memory usage in percent"
        echo "# TYPE system_memory_usage_percent gauge"
        set mem_usage (free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')
        echo "system_memory_usage_percent $mem_usage"

        echo "# HELP system_temperature_celsius Temperature of system thermal zones"
        echo "# TYPE system_temperature_celsius gauge"
        for zone in /sys/class/thermal/thermal_zone*
            set type (cat $zone/type)
            set temp (cat $zone/temp)
            set temp_c (math "$temp / 1000")  # convert ke Celsius
            echo "system_temperature_celsius{zone=\"$type\"} $temp_c"
        end
    end | nc -l -p $PORT -q 1
end
