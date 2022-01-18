#   Arguments supplied by Home Assistant

ARG BUILD_FROM   
ARG BUILD_ARCH

#   Choose right Microsoft build image & runtime for architecture

FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye AS dotnet-builder-amd64
ENV runtime=linux-musl-x64

FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye AS dotnet-builder-i386
ENV runtime=linux-musl-x86

FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye-arm64v8 AS dotnet-builder-aarch64
ENV runtime=linux-musl-arm64

FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye-arm32v7 AS dotnet-builder-armhf
ENV runtime=linux-musl-arm

FROM mcr.microsoft.com/dotnet/sdk:3.1-bullseye-arm32v7 AS dotnet-builder-armv7
ENV runtime=linux-musl-arm

#   Use it to build our project

FROM dotnet-builder-${BUILD_ARCH} AS dotnet-builder
COPY Ozric /src
RUN dotnet restore /src/OzricAddon/OzricAddon.csproj
RUN dotnet publish -c Release /src/OzricAddon/OzricAddon.csproj -r ${runtime} --self-contained true -o "/ozric"

#   Build the final image

FROM $BUILD_FROM
RUN apk add --no-cache \ 
    openssh libunwind \
    nghttp2-libs libidn krb5-libs libuuid lttng-ust zlib \
    libstdc++ libintl \
    icu

COPY rootfs /
COPY --from=dotnet-builder /ozric /ozric