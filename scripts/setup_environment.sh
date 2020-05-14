#!/bin/bash

 /etc/init.d/runtime stop

 echo -n "swith runtime to none..."
 /etc/config-tools/config_runtime -w runtime-version=0
 echo "done"

 echo -n "stopping codesys3 webserver..."
 /etc/config-tools/config_runtime cfg-version=3 webserver-state=disabled
 echo "done"
