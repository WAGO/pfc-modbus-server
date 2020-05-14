FROM sergo777/pfc-fw-base
LABEL maintainer="sergei.ikkert@wago.com"
LABEL description="WAGO Kontakttechnik modbus-kbus-slave image"
COPY resources / 

RUN opkg install /home/kbus_modbus_slave/kbusmodbusslave_armhf.ipk
RUN chmod +x /home/kbus_modbus_slave/start.sh
RUN rm /home/kbus_modbus_slave/kbusmodbusslave_armhf.ipk
RUN mkdir /etc/rc_kbus_modbus_slave.d/
RUN cd /etc/rc_kbus_modbus_slave.d/
RUN ln -sf ../init.d/link_devices /etc/rc_kbus_modbus_slave.d/S01_link_devices
RUN ln -sf ../init.d/progexec /etc/rc_kbus_modbus_slave.d/S95_progexec

ENTRYPOINT ["/home/kbus_modbus_slave/start.sh"]