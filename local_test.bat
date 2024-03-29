@echo off
if [%CORE_TOKEN%] == [] goto no_token

docker build -t ozric --build-arg BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.14 --build-arg BUILD_ARCH=amd64 .
if %ERRORLEVEL% GEQ 1 goto build_failed
docker run -it --rm -e CORE_TOKEN -p 8099:8099 -v /data:/data --name ozric ozric
exit 0

:no_token
echo CORE_TOKEN not set
exit 1

:build_failed
echo Build failed!
exit 2