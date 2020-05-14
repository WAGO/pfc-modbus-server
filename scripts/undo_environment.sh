#!/bin/bash

echo -n "starting codesys3 webserver..."
/etc/config-tools/config_runtime cfg-version=3 webserver-state=enabled
echo "done"

echo -n "starting  eRuntime..."
/etc/config-tools/config_runtime -w runtime-version=3
echo "done"
