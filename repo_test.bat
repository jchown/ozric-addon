docker pull jchown/amd64-ozric-addon:latest
docker run -it --rm -e CORE_TOKEN -p 8099:8099 --name ozric jchown/amd64-ozric-addon
