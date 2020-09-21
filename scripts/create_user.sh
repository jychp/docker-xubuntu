#!/bin/bash
echo "[*] Create user"

# Create user
echo "    create user"
useradd -m -s /bin/bash -g users user > /dev/null
echo "user:resu" | chpasswd

# Configure sudo
echo "    configure sudo"
echo "Set disable_coredump false" > /etc/sudo.conf && chmod 744 /etc/sudo.conf
usermod -aG sudo user > /dev/null
