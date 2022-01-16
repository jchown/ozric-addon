ARG BUILD_FROM
ARG BUILD_VERSION
ARG BUILD_ARCH

#   Choose right Microsoft build image for architecture

FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye AS dotnet-builder-amd64
FROM mcr.microsoft.com/microsoft-dotnet-sdk/3.1-bullseye-arm64v AS dotnet-builder-aarch64
FROM mcr.microsoft.com/microsoft-dotnet-sdk/3.1-bullseye-arm32v7 AS dotnet-builder-armhf
FROM mcr.microsoft.com/microsoft-dotnet-sdk/3.1-bullseye-arm32v7 AS dotnet-builder-armv7

#   Use to build our project

FROM dotnet-builder-${BUILD_ARCH} AS dotnet-builder
COPY OzricDeployTest /src
RUN dotnet publish /src/OzricDeployTest.csproj -o "/ozric"

#   Build final image

FROM $BUILD_FROM
COPY --from=dotnet-builder /ozric /ozric

COPY rootfs /