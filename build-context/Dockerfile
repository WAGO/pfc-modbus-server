FROM wagoautomation/pfc-firmware-base-image:v15 as image
COPY resources / 

RUN opkg install /home/kbus_modbus_slave/kbusmodbusslave_armhf.ipk
RUN opkg clean
RUN chmod +x /home/kbus_modbus_slave/start.sh   
RUN rm /home/kbus_modbus_slave/kbusmodbusslave_armhf.ipk    
RUN mkdir /etc/rc_kbus_modbus_slave.d/  
RUN cd /etc/rc_kbus_modbus_slave.d/ 
RUN ln -sf ../init.d/link_devices /etc/rc_kbus_modbus_slave.d/S01_link_devices

RUN rm -rf /usr/bin/qemu-arm-static

FROM scratch
LABEL maintainer="sergei.ikkert@wago.com"
LABEL version="3.0.0.35"
LABEL svn.revision="37597"
LABEL description="WAGO Kontakttechnik pfc modbus slave image"
COPY --from=image / /

ENTRYPOINT ["/home/kbus_modbus_slave/start.sh"]