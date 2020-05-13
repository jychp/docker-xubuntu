#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    exit 1
fi
# Create password
/usr/bin/expect <<EOF
spawn "/usr/bin/vncpasswd"
expect "Password:"
send "$1\r"
expect "Verify:"
send "$1\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\r"
expect eof
exit
EOF
# Launch server
vncserver :2 -geometry $2 &
while true; do
    sleep 3600
done
