#!/bin/bash
echo "[*] Install core packages"
apt-get update > /dev/null
# Core OS
echo "    install utils"
apt-get install -y iproute2 net-tools dnsutils curl wget netcat expect sudo locales xterm git apt-utils > /dev/null
echo "    generate locales"
locale-gen en_US.UTF-8 > /dev/null
# UI
echo "    install XFCE"
apt-get install -y xfce4 > /dev/null
apt-get purge -y pm-utils xscreensaver* > /dev/null
# Browser
echo "    install browser"
apt-get install -y firefox > /dev/null
# Tools
echo "    install tools"
apt-get install -y terminator nano > /dev/null

echo "[*] Install VNC"
echo "    install tightvncserver"
apt-get install tightvncserver > /dev/null
echo "    install noVNC"
mkdir -p /opt/novnc/utils/websockify
wget -q https://github.com/novnc/noVNC/archive/v1.2.0.tar.gz
tar -xzf v1.2.0.tar.gz -C /opt/novnc/ --strip 1 && rm v1.2.0.tar.gz
wget -q https://github.com/novnc/websockify/archive/v0.9.0.tar.gz
tar -xzf v0.9.0.tar.gz -C /opt/novnc/utils/websockify --strip 1 && rm v0.9.0.tar.gz
ln -s /opt/novnc/vnc_lite.html /opt/novnc/index.html
echo "    configure python alternatives"
update-alternatives --install /usr/bin/python python /usr/bin/python3 1 > /dev/null

echo "[*] Clean"
apt-get -qq clean -y
