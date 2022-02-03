FROM wagoautomation/pfc-firmware-base:FW19-03.07.14-v0.1.0 as image
COPY resources / 

RUN opkg install /home/kbus_modbus_server/kbusmodbusserver_armhf.ipk
RUN opkg clean
RUN chmod +x /home/kbus_modbus_server/start.sh   
RUN rm /home/kbus_modbus_server/kbusmodbusserver_armhf.ipk    
RUN mkdir /etc/rc_kbus_modbus_server.d/  
RUN cd /etc/rc_kbus_modbus_server.d/ 
RUN ln -sf ../init.d/link_devices /etc/rc_kbus_modbus_server.d/S01_link_devices

RUN rm -rf /usr/bin/qemu-arm-static

FROM scratch
LABEL maintainer="sergei.ikkert@wago.com"
LABEL version="v1.5.0"
LABEL description="WAGO Kontakttechnik pfc modbus server image"
COPY --from=image / /

ENTRYPOINT ["/home/kbus_modbus_server/start.sh"]