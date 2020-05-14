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
docker login ( see: https://docs.docker.com/engine/reference/commandline/login/)
 ```

 ## Get prebuild kbus-modbus-slave image
  ```bash
docker pull sergo777/kbus-modbus-slave

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
  --net=host \
  --name=kbus-modbus-slave \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
  sergo777/kbus-modbus-slave
 ```

 ## Test kbus-modbus-slave container. 
1. TODO


