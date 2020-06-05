# How to run kbus-modbus-slave container

## Prerequisites for tutorial
- Preinstalled SSH Client (e.g. https://www.putty.org/)
- Wago PFC with Docker

## PFC Login
Start SSH Client e.g. Putty 
 ```bash
login as `root`
password `wago`
 ```

 ## Check docker installation

```bash
docker info
docker ps # to see all running container (no container should run)
docker images # to see all preinstalled images
 ```

## Docker Login
To gain access to the private Docker repository, you must be registered as a collaborator.  (please contact the repository maintainer) 

 ```bash
docker login 
 ```
( For help see: https://docs.docker.com/engine/reference/commandline/login/)

 ## Get prebuild kbus-modbus-slave image
 > !!! The link does not work yet, because we cannot create private repositories anymore !!!
  ```bash
docker pull wagoautomation/kbus-modbus-slave 
 ```
## Setup PFC environment for execution of kbus-modbus-slave container. 
Before the kbus-modbus-slave container can be started it is necessary to create a special environment on the PFC. During this process some changes are made in the host system!!!
1. copy script setup_environment.sh to PFC.
2. chmod x setup_environment.sh
3. execute: ./setup_environment.sh

## Restore original PFC environment.
To undo the environment created in the previous step, perform the following steps:
1. copy script undo_environment.sh to PFC.
2. chmod x undo_environment.sh
3. execute: ./undo_environment.sh

## Start kbus-modbus-slave container

  ```bash
  docker run -d \
  --init \
  --restart unless-stopped \
  --privileged \
  -p 502:502 \
  --name=kbus-modbus-slave \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
  wagoautomation/kbus-modbus-slave 
 ```

 ## How to test kbus-modbus-slave container. 
Any Modbus client can be used for testing. In our case we use Wago-Node-Red containers with Modbus nodes. 
At least one digital IO module should be connected to the PFC. 
1. Start Node-Red Container see https://hub.docker.com/r/wagoautomation/node-red-iot
2. Copy and deploy Node-Red Flow.
```bash
[{"id":"66f5a666.891698","type":"tab","label":"Flow 1","disabled":false,"info":""},{"id":"fbd298fc.c80688","type":"inject","z":"66f5a666.891698","name":"","topic":"","payload":"1","payloadType":"num","repeat":"","crontab":"","once":false,"onceDelay":0.1,"x":110,"y":100,"wires":[["60d4c8c.3084238"]]},{"id":"60d4c8c.3084238","type":"modbustcp-write","z":"66f5a666.891698","name":"","topic":"","dataType":"Coil","adr":"0","server":"5a5a3609.1c8758","x":370,"y":140,"wires":[]},{"id":"3251a3f3.57e6ac","type":"inject","z":"66f5a666.891698","name":"","topic":"","payload":"0","payloadType":"num","repeat":"","crontab":"","once":false,"onceDelay":0.1,"x":110,"y":160,"wires":[["60d4c8c.3084238"]]},{"id":"5a5a3609.1c8758","type":"modbustcp-server","z":"","name":"PFC","host":"127.0.0.1","port":"502","unit_id":"1","reconnecttimeout":""}]
```
3. Press the button on the inject node, LED on the DIO should go on.


