FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
# Create user
RUN useradd -m -s /bin/bash -g users user
RUN echo "user:resu" | chpasswd
# Install apps
RUN apt-get update && apt-get install -y xfce4 tightvncserver iproute2 net-tools firefox terminator expect sudo
# Configure sudo
RUN echo "Set disable_coredump false" > /etc/sudo.conf && chmod 744 /etc/sudo.conf
RUN usermod -aG sudo user
# Configure vnc startup
COPY xstartup /home/user/.vnc/xstartup
RUN chown -R user:users /home/user/.vnc && chmod 755 /home/user/.vnc/xstartup
# Copy entrypoint
COPY entrypoint.sh /bin/entrypoint.sh
RUN chown root: /bin/entrypoint.sh && chmod 755 /bin/entrypoint.sh
# Switch to user
ENV USER user
USER user
EXPOSE 5902
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["password", "1024x768"]
