[![DockerHub stars](https://img.shields.io/docker/stars/wagoautomation/pfc-modbus-server.svg?flat&logo=docker "DockerHub stars")](https://hub.docker.com/r/wagoautomation/pfc-modbus-server)
[![DockerHub pulls](https://img.shields.io/docker/pulls/wagoautomation/pfc-modbus-server.svg?flat&logo=docker "DockerHub pulls")](https://hub.docker.com/r/wagoautomation/pfc-modbus-server)

# How to run pfc-modbus-server container

## Prerequisites for tutorial
- Preinstalled SSH Client (e.g. https://www.putty.org/)
- Wago PFC with Docker (see https://github.com/WAGO/docker-ipk)

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

 ## Get prebuild pfc-modbus-server image
```bash
docker pull wagoautomation/pfc-modbus-server 
 ```

## Setup PFC environment for execution of pfc-modbus-server container. 
Before the pfc-modbus-server container can be started it is necessary to create a special environment on the PFC. There are two ways to achieve it: 
- automatically with the help of a script 
- manually

### Automatically
1. copy script setup_environment.sh to PFC.
2. chmod x setup_environment.sh
3. execute: ./setup_environment.sh

#### Restore original PFC environment.
To undo the environment created in the previous step, perform the following steps:
1. copy script undo_environment.sh to PFC.
2. chmod x undo_environment.sh
3. execute: ./undo_environment.sh

### Manually 
1. Start Wago PFC.
2. Open WBM (Web Base Management) menu "General PLC Runtime Configuration"
3. Set PLC runtime version to "None"
4. Start container, with credentials: We need the root password to start kbus on the host and the IP address of the PLC controller.
5. Set PFC onboard switch in 'running' state.

<b>LED Signal U1 shows: RED=kbus init on host engaded, YELLOW=prepare kbus for container, GREEN=kbus is working from container.</b>


## Start pfc-modbus-server container

  ```bash
  docker run -d \
  --init \
  --restart unless-stopped \
  --privileged \
  -p 502:502 \
  --name=pfc-modbus-server \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
  wagoautomation/pfc-modbus-server 
 ```

## Access PFC as a simple modbus server device.

EA mapping is like 750-362, watch Coupler documentation to learn how to get access to mapped digital and analog slots.  
 
https://www.wago.com/de/io-systeme/feldbuskoppler-modbus-tcp/p/750-362

<img src="https://www.wago.com/media/images/hf1/hfe/10220570279966.jpg" alt="750-362" height="175" align="middle">

Onboard operating switch: START = modbusserver is running : STOP modbusserver is stopped.   

> If the kbus would not init: => stop container => activate runtime => deactivate runtime => start container          
(This inits the kbus via runtime thread, watch kbus led: must be green)

## How to test pfc-modbus-server container.
Any Modbus client can be used for testing see (e.g https://www.modbustools.com/download.html)

 
Or use Wago-Node-Red containers with Modbus nodes. 
At least one digital IO module should be connected to the PFC. 
1. Start Node-Red Container see https://hub.docker.com/r/wagoautomation/node-red-iot
2. Copy and deploy Node-Red Flow.
```bash
[{"id":"66f5a666.891698","type":"tab","label":"Flow 1","disabled":false,"info":""},{"id":"fbd298fc.c80688","type":"inject","z":"66f5a666.891698","name":"","topic":"","payload":"1","payloadType":"num","repeat":"","crontab":"","once":false,"onceDelay":0.1,"x":110,"y":100,"wires":[["60d4c8c.3084238"]]},{"id":"60d4c8c.3084238","type":"modbustcp-write","z":"66f5a666.891698","name":"","topic":"","dataType":"Coil","adr":"0","server":"5a5a3609.1c8758","x":370,"y":140,"wires":[]},{"id":"3251a3f3.57e6ac","type":"inject","z":"66f5a666.891698","name":"","topic":"","payload":"0","payloadType":"num","repeat":"","crontab":"","once":false,"onceDelay":0.1,"x":110,"y":160,"wires":[["60d4c8c.3084238"]]},{"id":"5a5a3609.1c8758","type":"modbustcp-server","z":"","name":"PFC","host":"127.0.0.1","port":"502","unit_id":"1","reconnecttimeout":""}]
```
3. Press the button on the inject node, LED on the DIO should go on.
