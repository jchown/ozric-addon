#!/bin/sh

docker run --name ozric-builder --rm --privileged -v ~/.docker:/root/.docker -v $(pwd):/addon homeassistant/amd64-builder --all -t /addon 
