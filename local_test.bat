docker build -t ozric --build-arg BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.14 --build-arg BUILD_ARCH=amd64 .
docker run -it --rm -e OZRIC_HA_TOKEN -p 8099:8099 --name ozric ozric