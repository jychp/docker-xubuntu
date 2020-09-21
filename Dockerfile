## Layer for XFWM4 build (current ubuntu version bug with VNC)
FROM ubuntu:latest as xfwm4builder
ENV TERM=xterm \
    DEBIAN_FRONTEND=noninteractive
WORKDIR /install
COPY scripts/build_xfwm4.sh build_xfwm4.sh
RUN chmod 700 build_xfwm4.sh && ./build_xfwm4.sh && rm build_xfwm4.sh



FROM ubuntu:latest
## Connection ports for controlling the UI:
ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901
EXPOSE $VNC_PORT $NO_VNC_PORT

### Envrionment config
ENV TERM=xterm \
    DEBIAN_FRONTEND=noninteractive

# Install
COPY scripts/install.sh install.sh
RUN chmod 700 install.sh && ./install.sh && rm install.sh

# Patch xfwm4
RUN mkdir /opt/xfwm4-4.15.1
COPY --from=xfwm4builder /opt/xfwm4-4.15.1 /opt/xfwm4-4.15.1
RUN rm /usr/bin/xfwm4 && ln -s /opt/xfwm4-4.15.1/bin/xfwm4 /usr/bin/xfwm4

# Define locales
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Create user
COPY scripts/create_user.sh create_user.sh
RUN chmod 700 create_user.sh && ./create_user.sh && rm create_user.sh

# Configure UI
COPY confs/xstartup /home/user/.vnc/xstartup
RUN chown -R user:users /home/user/.vnc && chmod 755 /home/user/.vnc/xstartup

# Copy entrypoint
COPY scripts/entrypoint.sh /bin/entrypoint.sh
RUN chown root: /bin/entrypoint.sh && chmod 755 /bin/entrypoint.sh

# Switch to user
ENV USER=user \
    HOME=/home/user
USER user
WORKDIR /home/user
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["password", "1600x1024"]
