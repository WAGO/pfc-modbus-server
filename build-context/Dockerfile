FROM wagoautomation/pfc-firmware-base:FW21-03.09.07-alpha.1 as image

COPY resources / 
RUN opkg install /home/kbus_modbus_server/kbusmodbusserver_armhf.ipk
RUN opkg clean
RUN chmod +x /home/kbus_modbus_server/start.sh   
RUN rm /home/kbus_modbus_server/kbusmodbusserver_armhf.ipk    
RUN mkdir /etc/rc_kbus_modbus_server.d/  
RUN cd /etc/rc_kbus_modbus_server.d/ 
RUN ln -sf ../init.d/link_devices /etc/rc_kbus_modbus_server.d/S01_link_devices

FROM scratch
ARG TAG=latest
LABEL maintainer="sergei.ikkert@wago.com"
COPY --from=image / /
LABEL authors="Dirk.Meihoefer@wago.com, Sergei.Ikkert@wago.com"
LABEL org.label-schema.version=${TAG}
LABEL org.label-schema.vendor="WAGO"
LABEL org.label-schema.name="wagoautomation/pfc-modbus-server"

ENTRYPOINT ["/home/kbus_modbus_server/start.sh"]