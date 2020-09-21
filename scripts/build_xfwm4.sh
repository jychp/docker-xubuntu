#!/bin/bash
echo "[*] Build xfwm4"
echo "    install dependencies"
apt-get update > /dev/null
apt-get -y install wget gcc xfce4-dev-tools libglib2.0-dev xorg-dev build-essential libgtk-3-dev libxfce4util-dev libxfce4ui-2-dev libwnck-3-dev > /dev/null
echo "    pulling sources"
wget -q https://github.com/xfce-mirror/xfwm4/archive/xfwm4-4.15.1.tar.gz
tar -xvzf xfwm4-4.15.1.tar.gz
cd xfwm4-xfwm4-4.15.1 || exit 1
echo "    configure"
./autoclean.sh > /dev/null
./autogen.sh --prefix /opt/xfwm4-4.15.1 > /dev/null
make > /dev/null
make install > /dev/null
apt-get -qq clean -y > /dev/null