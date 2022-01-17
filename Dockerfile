#   Arguments supplied by Home Assistant

ARG BUILD_FROM   
ARG BUILD_ARCH

#   Choose right Microsoft build image for architecture

FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye AS dotnet-builder-amd64
FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye-arm64v8 AS dotnet-builder-aarch64
FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye-arm32v7 AS dotnet-builder-armhf
FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye-arm32v7 AS dotnet-builder-armv7

#   Use it to build our project

FROM dotnet-builder-${BUILD_ARCH} AS dotnet-builder
COPY OzricDeployTest /src
RUN dotnet publish -c Release /src/OzricDeployTest.csproj -r linux-arm64 -o "/ozric"

#   Build the final image

FROM $BUILD_FROM
COPY rootfs /
COPY --from=dotnet-builder /ozric /ozric