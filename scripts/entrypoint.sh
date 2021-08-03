#!/bin/bash
# Create password
/usr/bin/expect <<EOF
spawn "/usr/bin/vncpasswd"
expect "Password:"
send "$VNC_PASSWORD\r"
expect "Verify:"
send "$VNC_PASSWORD\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\r"
expect eof
exit
EOF
# Launch server
vncserver :1 -geometry $VNC_RESOLUTION -depth 24 &
/opt/novnc/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &> /home/user/novnc.log &
while true; do
    sleep 3600
done
