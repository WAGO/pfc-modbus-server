FROM sergo777/pfc-fw-base
LABEL maintainer="sergei.ikkert@wago.com"
LABEL version="3.0.0.35"
LABEL svn.revision="37597"
LABEL description="WAGO Kontakttechnik kbus_modbus_slave image"

COPY resources / 

RUN opkg install /home/kbus_modbus_slave/kbusmodbusslave_armhf.ipk  \
    && chmod +x /home/kbus_modbus_slave/start.sh   \
    && rm /home/kbus_modbus_slave/kbusmodbusslave_armhf.ipk    \
    && mkdir /etc/rc_kbus_modbus_slave.d/  \
    && cd /etc/rc_kbus_modbus_slave.d/ \
    && ln -sf ../init.d/link_devices /etc/rc_kbus_modbus_slave.d/S01_link_devices

ENTRYPOINT ["/home/kbus_modbus_slave/start.sh"]