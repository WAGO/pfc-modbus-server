#!/bin/bash

cleanup() {
  echo "stopping kbus-modbus-server daemon"
  kbusmodbusslave stop
  sleep 3 # todo detect daemon is stopped

  echo "stopping all init daemons"
  run-parts -a stop /etc/rc_kbus_modbus_server.d/ 
}

run() {
  echo "start init daemons"
  run-parts -a start /etc/rc_kbus_modbus_server.d/

  echo "start kbus-modbus-server damon"
  kbusmodbusslave -v 7 --nodaemon
  wait $!
}

trap cleanup INT TERM
run


